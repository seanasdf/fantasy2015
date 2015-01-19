(function() {
  var creativeDefinition = {
    customScriptUrl: '',
    isDynamic: true,
    delayedImpression: false,
    standardEventIds: {
      DISPLAY_TIMER: '2',
      INTERACTION_TIMER: '3',
      INTERACTIVE_IMPRESSION: '4',
      FULL_SCREEN_VIDEO_PLAYS: '5',
      FULL_SCREEN_VIDEO_COMPLETES: '6',
      FULL_SCREEN_AVERAGE_VIEW_TIME: '7',
      MANUAL_CLOSE: '8',
      BACKUP_IMAGE_IMPRESSION: '9',
      EXPAND_TIMER: '10',
      VIDEO_PLAY: '11',
      VIDEO_VIEW_TIMER: '12',
      VIDEO_COMPLETE: '13',
      VIDEO_INTERACTION: '14',
      VIDEO_PAUSE: '15',
      VIDEO_MUTE: '16',
      VIDEO_REPLAY: '17',
      VIDEO_MIDPOINT: '18',
      FULL_SCREEN_VIDEO: '19',
      VIDEO_STOP: '20',
      VIDEO_FIRST_QUARTILE: '960584',
      VIDEO_THIRD_QUARTILE: '960585',
      VIDEO_UNMUTE: '149645',
      FULL_SCREEN: '286263',
      DYNAMIC_CREATIVE_IMPRESSION: '536393',
      HTML5_CREATIVE_IMPRESSION: '871060'
    },
    exitEvents: [
      {
        name: 'DGM167_CTA1_Exit',
        reportingId: '1751167',
        url: '',
        targetWindow: '_blank',
        windowProperties: ''
      },
      {
        name: 'DGM167_CTA2_Exit',
        reportingId: '1751164',
        url: '',
        targetWindow: '_blank',
        windowProperties: ''
      },
      {
        name: 'DGM167_CTA3_Exit',
        reportingId: '1751166',
        url: '',
        targetWindow: '_blank',
        windowProperties: ''
      },
      {
        name: 'DGM167_Main_Exit',
        reportingId: '1751168',
        url: '',
        targetWindow: '_blank',
        windowProperties: ''
      }
    ],
    timerEvents: [
    ],
    counterEvents: [
      {
        name: 'DGM167_Disclaimer_Click',
        reportingId: '1751165',
        videoData: null
      }
    ],
    childFiles: [
      {
        name: '13_Verano_Sedan_IMD-Backups-Gen_160x600_IBS_V1_ENG.jpg',
        url: '/ads/richmedia/studio/21705293/24031074_20130611092428887_13_Verano_Sedan_IMD-Backups-Gen_160x600_IBS_V1_ENG.jpg',
        isVideo: false,
        transcodeInformation: null
      },
      {
        name: '160x600.swf',
        url: '/ads/richmedia/studio/21705293/24031074_20140423132543765_160x600.swf',
        isVideo: false,
        transcodeInformation: null
      },
      {
        name: '160x600.xml',
        url: '/ads/richmedia/studio/21705293/24031074_20130611065011640_160x600.xml',
        isVideo: false,
        transcodeInformation: null
      }
    ],
    videoFiles: [
    ],
    videoEntries: [
    ],
    primaryAssets: [
      {
        id: '31216337',
        artworkType: 'FLASH',
        displayType: 'BANNER',
        width: '160',
        height: '600',
        servingPath: '/ads/richmedia/studio/21705293/24031074_20140423132523887_parent_160x600.swf',
        zIndex: '1000000',
        customCss: '',
        flashArtworkTypeData: {
          actionscriptVersion: '3',
          wmode: 'opaque',
          sdkVersion: '2.3.1',
          flashBackgroundColor: ''
        },
        htmlArtworkTypeData: null,
        floatingDisplayTypeData: null,
        expandingDisplayTypeData: null,
        imageGalleryTypeData: null,
        pageSettings:null,
layoutsConfig: null,
layoutsApi: null
      }
    ]
  }
  var rendererDisplayType = '';
  rendererDisplayType += 'flash_';
  var rendererFormat = 'inpage';
  var rendererName = rendererDisplayType + rendererFormat;

  var creativeId = '58897585';
  var adId = '283606080';
  var templateVersion = '200_55';
  var studioObjects = window['studioV2'] = window['studioV2'] || {};
  var creativeObjects = studioObjects['creatives'] = studioObjects['creatives'] || {};
  var creativeKey = [creativeId, adId].join('_');
  var creative = creativeObjects[creativeKey] = creativeObjects[creativeKey] || {};
  creative['creativeDefinition'] = creativeDefinition;
  var adResponses = creative['adResponses'] || [];
  for (var i = 0; i < adResponses.length; i++) {
    adResponses[i].creativeDto && adResponses[i].creativeDto.csiEvents &&
        (adResponses[i].creativeDto.csiEvents['pe'] =
            adResponses[i].creativeDto.csiEvents['pe'] || (+new Date));
  }
  var loadedLibraries = studioObjects['loadedLibraries'] = studioObjects['loadedLibraries'] || {};
  var versionedLibrary = loadedLibraries[templateVersion] = loadedLibraries[templateVersion] || {};
  var typedLibrary = versionedLibrary[rendererName] = versionedLibrary[rendererName] || {};
  if (typedLibrary['bootstrap']) {
    typedLibrary.bootstrap();
  }
})();
