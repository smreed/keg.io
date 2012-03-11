#
# Pour: A beer dispensing event for a User on a Keg
#
module.exports = (sequelize, DataTypes) ->
  sequelize.define('pour', {
    rfid: DataTypes.INTEGER,
    pour_date: DataTypes.DATE,
    volume_ounces: DataTypes.INTEGER
  },
  {
    underscored: true,
    instanceMethods: {

        addFlow: (rate) ->
          @rates or= []
          @rates.push {rate: rate, time: new Date()}

        calculateVolume: () ->
          @rates.push {rate: 'end', time: new Date()} # assume the pour ends right now
          # TODO: Don't throw away the first rate number by having a time diff of 0
          @volume_ounces = 0.0
          last_rate_time = null
          for rate_time in @rates
            # 1 liter per minute = 0.000563567045 US fluid ounces per ms
            # 1 liter per hour = 0.00000939278408 US fluid ounces per ms
            if last_rate_time?
              diff_ms = parseFloat(rate_time.time - last_rate_time.time)
              flow_amount_oz = diff_ms * (parseFloat(last_rate_time.rate) * 0.00000939278408)
              @volume_ounces += flow_amount_oz;
            last_rate_time = rate_time
      }
  })