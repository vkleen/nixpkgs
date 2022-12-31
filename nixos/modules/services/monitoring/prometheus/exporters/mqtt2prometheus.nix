{ config, lib, pkgs, options }:
with lib;
let
  cfg = config.services.prometheus.exporters.mqtt2prometheus;

  settingsFormat = pkgs.formats.yaml { };
  configFile = settingsFormat.generate "mqtt2prometheus.yml" cfg.settings;
in
{
  port = 9641;
  extraOpts = {
    mqttUser = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = lib.mdDoc ''
        MQTT user name for authentication
      '';
    };
    mqttPasswordFile = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = lib.mdDoc ''
        file to read MQTT password from
        will be expanded in bash
      '';
    };
    settings = mkOption {
      type = settingsFormat.type;
      default = { };

      description = lib.mdDoc ''
        Configuration for mqtt2prometheus, see
        <https://github.com/hikhvar/mqtt2prometheus#config-file>
        for supported values.
      '';
    };
  };
  serviceOpts = {
    script = ''
      ${optionalString (cfg.mqttPasswordFile != null) ''
        export MQTT2PROM_MQTT_PASSWORD=$(< ${cfg.mqttPasswordFile})
      ''}
      ${pkgs.mqtt2prometheus}/bin/mqtt2prometheus \
        -listen-address ${cfg.listenAddress} \
        -listen-port ${toString cfg.port} \
        -config ${configFile}
    '';
    environment = {
      MQTT2PROM_MQTT_USER = cfg.mqttUser;
    };
  };
}
