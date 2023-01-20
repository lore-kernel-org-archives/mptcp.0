Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6261198
	for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 02:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674182694; x=1705718694;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HaLNuO3kMWqu72pJVaY1QEw+YYT4er/aft4hb0FSJA0=;
  b=WQbapF+uLgZp6aVEsNmNd4rfRRa8NeKGmVPANoRSGuu9JBDgGOREc67Z
   MbMG0beNjSWxyfh/zRkcNn9GDTTKjbXAZkdhixyh4wwTIW848VBseLVre
   dxZ/PBXc2tEDJFtSt6dvDTJ1H0bGIFwIv1oSON/wQutUHf9qCaVpTqtIk
   N2/s/GRJW+8gbIyHt5aCMq5xEYQjTRfqUt4wVPYMIXQ+C245WcbyAjN+S
   Vyd4/vVN7jO6ONdJksxUYxJ2p25Fe751gxKqR7Vwgeu+zZe0wzTqwXDTX
   nJd2Be9uKvYCCOqmX9QZHAFS8jYXavZNkT2cisrwBsQzvHmtS4UPy1EpO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327585107"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="327585107"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 18:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989261983"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989261983"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 18:44:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 18:44:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 18:44:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 18:44:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 18:44:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du8kr8XDrc0336bvvoTKBu1zAiW78OerL5nRnJyLF8JsFaFjKaaq+5CBKNK1b+D1ikS2gLIi26mVQ/+inDSXK/Hqn06ws8zRsCXqVlz2t8IzvOyAJ8f0UoV4Olofbr5IQVDOYjArzLRbfNMqnv+MWkFgBWHD9RAa/d7BJPeol+v3M5EK/TxwgHlniR6ya9KzfVnXTwa7qTpI/I8OrT54n2lsCy/jhXUhInGgUaD2L3CHbu9kI66EdyBLI/9vf7PxBaCb+clExh3fbxa3C3GcQeaWwDq1lZrhfNa4i3I214nMyNRy8uuqZnFgzXpuV3hustB3nuAAgfGIzqs3FoVvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in8YaEad7niLrbtpalCpNAf8eZP5r1QjcEZsGGg2x6w=;
 b=IzKMxsP9+X0/sOOjzb1m+ZyOjBbNFkWVUu3WHz7a9eSUTGYccwrmyPzJbOTdJZG6W5vmgiJ17JXiPGQEIfzSeHVXTYv9LroRTYTB3Ygg5giaC1C6IvPgMbmCjFnGoNDOHA9xiiSd3bspXVz17l0Tmdlmdt9Ecm+1A99XGzKii4wd9Doo3gnGC4EHL+m66HnmycMM7MOQvbVqh/Olkx6+UIY7KI77rlUPky734Tr2KrjY2GiIgUkmSnCaXgq9n7PzB5crN6WoveAFRvXB8nwg0fSZCwFK44edpeM+Ai4rsmqwfqpNyNJP1b2ApXN7PL26f6HwhBYSPY5Tf9r2VhwPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 20 Jan
 2023 02:44:50 +0000
Received: from DM4PR11MB5247.namprd11.prod.outlook.com
 ([fe80::d57e:333d:9649:c2e7]) by DM4PR11MB5247.namprd11.prod.outlook.com
 ([fe80::d57e:333d:9649:c2e7%4]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 02:44:50 +0000
From: "Othman, Ossama" <ossama.othman@intel.com>
To: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: mptcpd 0.12 release plans and transition to multipath-tcp/mptcpd
 repository
Thread-Topic: mptcpd 0.12 release plans and transition to multipath-tcp/mptcpd
 repository
Thread-Index: AdksZREc7W/Kyop9SFC+rN4lV/8TZA==
Date: Fri, 20 Jan 2023 02:44:50 +0000
Message-ID: <DM4PR11MB5247A7BF960343BC079AAB4BF2C59@DM4PR11MB5247.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5247:EE_|IA0PR11MB7742:EE_
x-ms-office365-filtering-correlation-id: 21f7b77e-c6d7-4967-4303-08dafa904d3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buU6uzIf/lCOZ51yb8JEEyrzwLRt3JeR9npfH5kfqwaEV6jB2R5XxjXQ9hXqbEgh1nBssAPXRrzOFkRXUkAk1pX9pQGoqx4PCIDdBVadrNcT+EULgzvnyXIGo3j8j7ykA8DcKSX+JMPFfn/J5IyYrEluJNDObmIR+NJej0A6c1ozBeti1KEBh/YP4KRvC7y+6PuPEi1le1bO1wQth/Ay78eWmaV2Pg7z33B3WIqKn3xQQVA0csSK8yyKySjxVbL0UySTp3iZjtfDBgmR/qmJbpb5Kiwd/J3GmuZMcyE0D8g0TsmDjOiDwLOMVNiHnAk74eOU/0O8KGJUaye2jNC0IA3Ftn9BQV35eH0HmOkR8apF8MqoC2wENiDBzw3pfOGw3Wexmu4835NBs7MZiqKLOOIzmjysTUg4AKp3ENh0bM1xW0iNcLnBduOP+yVtxIZakyBiowkzTHwe5R4KFiwdf52jGMOct0ujmk/xvcUBeHfZbnEb6jNqo+MCobSepOzoeMOXSleO0noLnMdl73Ti/5W5hlzZry46vTuz1Q3skJCtfVhCbh15mVEQdycRfminG6KQ0smxvOa8sli6augNqwAoR/6TOly0hOj8JNKHpbIsTjQ5ukmC7LzE70OdgZBCBbfKLtgHYuPexLslerhoxy7/PA8KZ/jcWTIqVDvbJ9ndAdr6fTzmAfJkyDIAWObyC0mfY/QunKvnwEaXhU3XKSP0fjmL9tRXd0g+xdRW2P8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5247.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(6506007)(186003)(9686003)(122000001)(26005)(86362001)(83380400001)(38100700002)(82960400001)(66556008)(6916009)(66476007)(41300700001)(66446008)(76116006)(38070700005)(64756008)(66946007)(8676002)(478600001)(2906002)(52536014)(33656002)(5660300002)(8936002)(966005)(316002)(71200400001)(55016003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnK+GhDkc4Mg0SOR03k8qsXtpU4mfWxQ5R6/NolU6TSxdS1mELH/Kql9mVif?=
 =?us-ascii?Q?in2wSdB+dz4212SxAlA/Sl/ypAWkv2M2hBdC7VV1jquRaq+1+BPMMhVgMZdH?=
 =?us-ascii?Q?k46kGx56P6ipehlqb5Irxg6OelwAJDF1Cbxn01Jl855fsB7nFoqkc3+joid3?=
 =?us-ascii?Q?4GHR5RCoFTcW6wCGGI+PgQ9Rf1eCLbuze7zxqdb8CCXggxaSRvzaXpf+zxMV?=
 =?us-ascii?Q?TN/ZLKS6iGSqR4Mj+A4wJqdkKqRbs4HPX0kdF9XvXurPKDTHFybxAFdU6Abi?=
 =?us-ascii?Q?r01sC4WLkaBVW0fN7cN2Kkwgk45EOHo8RvuE0TP1tm3RtAN7D1aZ3+Bpy4Ow?=
 =?us-ascii?Q?ntJe9vPsovS6iNR7vvXZpoajHcXLh4h8V9bkoBS7dYK3nr2rXiY1xFTwNtDx?=
 =?us-ascii?Q?+L/eay3qe0PfVT/24k9OMLoTT34UT1au5T9Ufb/xHqK46AMKxju5wwE+1n7v?=
 =?us-ascii?Q?8y0KYM0+gUuCpnoCDSUfmqrUIIIBrIBlwbDfd9rt+zDL2y4Hs2Cn73FkLnhd?=
 =?us-ascii?Q?RrJlL90uk6Z+9p5MRyUMtxqIQ54+4K1SZjhYG7/w0PWGVGdaF+w5xD/1gYg6?=
 =?us-ascii?Q?v8OeGsgWAhAxG9WE9PREndYhtDx6AHrcvRVFnq6jrTGE/F/qWwASnXgbKyj0?=
 =?us-ascii?Q?4m8GGBspkh/SXel3Us+RSS96+UEcG2lE8nfX22NCUh9SHx2hFaVD0dOQjU7w?=
 =?us-ascii?Q?4S+uyw/240+gqGT9OCUHIZWSILlysczlkKD+nOUuQO27RniqCPRiC4UAYdUl?=
 =?us-ascii?Q?oG1MUyqM3jmKLHFzYdh5gkl950+VJB44MIuZ2So0icKX+OWFB9Uwnv2CrW6H?=
 =?us-ascii?Q?z6JCpBj5ZvCiLEsQ2QE8FvH5UAb9rKInXvkanTx6boVAIxe0D4SFYqv4HWXE?=
 =?us-ascii?Q?A4iptQ8wKRxx2U8CRceSI6e5yh/JxgDdIm8SqacJh1sHySrjX/ec0JeQP3hb?=
 =?us-ascii?Q?7syyW9U3Nf44tFmMuqahP4fdz1W/JM/RnaqPez8lOe53IRTf9OMrEGnKD6Lx?=
 =?us-ascii?Q?arkjoEMwf3HKqX1mAr+fSBJyYz6WKfuUgiQjJWc05DaISC/exAtb2NRuXR6H?=
 =?us-ascii?Q?6l0n7LKChohQ5POy4mXySEDcBV8Ty74aN69lYfv8m2Z541HpOdGCQaY0kwp3?=
 =?us-ascii?Q?FWvJDJ+ko2iHALESy7xFvPyu71o1Iy/g171t69592DXEir/2c8/PtkXF0tdk?=
 =?us-ascii?Q?TrhwCYcNLWkwGi0I7/5lYuhCwEl0aeZm37IhXM64SQ3HqAMtQ7+mvZxC33Ux?=
 =?us-ascii?Q?qocT9L52FHLGG7Z9He/mvHFQcbRThkqu2Ss0lA8TEvf4UhVhcz0lphIZKct9?=
 =?us-ascii?Q?l78mYn/FZnRBj5PhMSPtyYDhR+kdISJK23zO81TumNhDVrj5gSqOjZ9gQYhZ?=
 =?us-ascii?Q?2yi7owsGoWdSnluk1Rj3pcKABIzJyWzeJqy95HBmnTTgqFQC9x+XTfTFkfRm?=
 =?us-ascii?Q?bwU3jHBajQxzrxHBHMrACkPBXg14TDOkahDcbiSSBguX/6tBfiwASjPwStmr?=
 =?us-ascii?Q?L2TwxUR82+B4wD8kX795b6B87z+FJ929SDk3yQf/DxRGh2GkOxnYyifJ6Akd?=
 =?us-ascii?Q?SSpuRoqqb3O+ouM0ptVOYwqBJjHfTw/VlKyc14KP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5247.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f7b77e-c6d7-4967-4303-08dafa904d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 02:44:50.3932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytJRlS+yqvz5P5AWumcAzcceDeq+byhCbv47cZPWQCnjvk1/n1jHYGuVhm//YuV+u7vc/NtCAe6KYtxPQcnNIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

Hello,

Our current plan for transitioning the mptcpd repository to
multipath-tcp/mptcpd includes the following:

* Update the owner e-mail in the CODE_OF_CONDUCT.md and SECURITY.md
  files.
        - The e-mail was meant to allow for private communication
          between the mptcpd maintainers and users in the case of CoC
          or security violations.  Is there a specific e-mail that can
          be used?  If not, should we point to the kernel MPTCP
          maintainers, or just drop these files?

* Generate the mptcpd 0.12 release.
        - In addition to existing changes on the main development
          branch, references to the old repository URL in the mptcpd
          source files will be replaced with the new repository URL,
          https://github.com/multipath-tcp/mptcpd.
        - The release can be generated quickly, e.g., this week.

* Create the https://github.com/multipath-tcp/mptcpd repository fork,
  timed at or soon after mptcpd 0.12 release generation.

* Update the old repository's GitHub pages
  (https://intel.github.io/mptcpd) to point to the new repository.

* Officially announce on the mailing list the mptcpd 0.12 release and
  mptcpd's new home.

* The old intel/mptcpd repository will be no longer be used for
  development and will be archived.

What do you think?

Thanks,
-Ossama

