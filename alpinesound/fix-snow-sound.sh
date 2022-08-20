
#!/bin/sh

# Script to fix ALSA Sound on the XE303C12 Chromebooks for PostmarketOS
# Credit to Alan Xu for Creating this Script

WDIR=`dirname $0`

ASOUND_SHORT_NAME=`cat /proc/asound/cards | awk '{print $3}' | head -n 1`
if [ "${ASOUND_SHORT_NAME}" != "Snow-I2S-MAX980" ]; then
    echo "Unexpected asound card: ${ASOUND_SHORT_NAME}"
    exit 1
fi

ASOUND_LONG_NAME=`cat /proc/asound/cards | awk '{print $5}' | head -n 1`
if [ "${ASOUND_LONG_NAME}" != "Snow-I2S-MAX98095" ] && [ "${ASOUND_LONG_NAME}" != "Snow-I2S-MAX98090" ]; then
    echo "Unexpected asound card: ${ASOUND_LONG_NAME}"
    exit 2
fi

rm -rf /usr/share/alsa/ucm2/conf.d/${ASOUND_SHORT_NAME}
cp -r ${WDIR}/${ASOUND_LONG_NAME} /usr/share/alsa/ucm2/conf.d/${ASOUND_SHORT_NAME}
