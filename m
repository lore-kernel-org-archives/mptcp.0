Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D48F4B
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675185295; x=1706721295;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=7HFMOOIUp6L9hbG2WJVp3Re8IjoijatBVbOL6IKsZOA=;
  b=aN8UWw2roatVhjA8m8gKnK3EGV+MfT0dTNELtLwe2UegDjNObTNt9qHe
   7Oz/o7rLPqOK1WVmCxvfFOq25EsyjJXsLm2qxGJpUB/o2Ab9zBTpdGG9P
   56QmCVh+GaKju0XuihYKJUc26hWooVZBS+573liYENW2RDAae4cjZ1xwC
   jP0JIEhpu7Z7EkelaqkOsLYITwlIpdF4HihkiLX/ha+h17tQV+RnkwdJD
   xQMQj4QKj45MDbY4FisKLyRYVdqFWVrlJIbxOV2o1ElV01qWH1iVTZ0Os
   yn3QbXOyVKDacfxjWKz4+Rpy7ViZLrtIeU0IpDMrEZDgiSOD4/dMnuGZ7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="329167816"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="329167816"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 09:14:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="642050364"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="642050364"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2023 09:14:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 09:14:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 09:14:53 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 09:14:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBYPHDSfM7adtbPHTTquHAv6YMZz3JcTzDtO4VkwV7rKMFvoc0Uiwvm9Hv8lLJvO4DWzPETxpaZX618FN3GQMPi0pYzd3A1fcL1YpJJWYY5zAzgrH2OkfIrayYSrD3qR65iglw3CuRj+tFHHBAzaaqOujhrt2nAQ5MiteXqxQwHgMAVV7t5JlQTUhiL9BJqZd/cA/jBupTuSyzoKUFg+uE97ZAEw0T/RlXa3JLrSZBOyA7SGu0xf02UQHoI7RcaVAIll+PQ8oolVLQvLI79rSXk4e0+GsZAbkH0VSMVxuWGzn8mFsRNPXX8DqXHpu0Uqio6WS6hFnNMk5vLQ01lz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VznoqC13++N/fBhK9Z/6slbywugfxlNmp9vJt2OvkCc=;
 b=hm+iyAMHPq11350zKqzVxAO2n9l3TSiiiOjvY5d+1TvsVWsHVRbgdMLMFnZFygcYjncKHM7m7vWqwGVz6ZhbKiNQb9FePgcIQRoviYXblhGuJbi+YNUhc8RKkbIvrDWriH93u+ToB6uS0htnTq7eiy4BW57hJfUioZaMiY7RJtx6ia9CLnatLHleuA4bx4TNHuVN7oVBWmHa0UlDRcOopl4cNXdo3tYiBBoFV0uuc2eglNGmRtLcuddh/ejnVqmDzsZpMpi73Fi+HV/vWEH729nUP4XP8aI/FVrCUrVrT4zXdSlRLFhLbBb5mipKBocOcA6B7k7LpTIYy/7BdPOKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20)
 by DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:14:51 +0000
Received: from DM4PR11MB5247.namprd11.prod.outlook.com
 ([fe80::d57e:333d:9649:c2e7]) by DM4PR11MB5247.namprd11.prod.outlook.com
 ([fe80::d57e:333d:9649:c2e7%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 17:14:51 +0000
From: "Othman, Ossama" <ossama.othman@intel.com>
To: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: mptcpd 0.12 released and move to multipath-tcp/mptcpd
Thread-Topic: mptcpd 0.12 released and move to multipath-tcp/mptcpd
Thread-Index: Adk1lnO1TdaWdT6mTq6CtIYwcJeGJA==
Date: Tue, 31 Jan 2023 17:14:51 +0000
Message-ID: <DM4PR11MB52479D2A1E29FE4C48E93552F2D09@DM4PR11MB5247.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5247:EE_|DS0PR11MB8230:EE_
x-ms-office365-filtering-correlation-id: 398f6f94-3deb-4996-f11b-08db03aea9cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QyN0S5zOzK/9P4NR/tQAyo0x+Xxjyib6ZtRZWNitUn2NVZREw4R6Vxw4IcqQlqEoQHonSNdgf0f+3AkBnjBKmjaDE+V3efl503p4jf3fJI6Ib4tbzvMMVqimGBZ8rMP7hcD5kqpyouXaVZ7hFVzhMmQmpod5wOVSrmYt+4cSh3zTNfAID8b069GW+QIKUTDeZ3ta/SpXNorPRYmncHaMnUnR9R6t3294HEM1QoCzOV0ix5tjbl0wLQc933Kj7M2eD49MQBzx2iHlB/yzz0yJ2PElJ52sxWLfPp3yhd6FmCI54Gqub3xpgWaVK0qzXIkWYYw43V7z5tku68SO+lceRMraLhO0bLLbCKY+fpgi0JJ5UJrF6AkDo7S7MjuB7oiStMVrheAv2QqYABjdeSjPwbLgkpbPQ3oYae4HcY0TnPD0KYEKSLpHu37bm4L8MPf906+E6Jz/ndBHZroOcbstRX0awC4qmTEa7YrpFBM/mkLBY2iYoHU67lIWSeK0HPVm1sDzTsS3YUjwlcwTqYA86Vig9SymOfMLm0SUEvWhZgbnfOgFogCyQ7VHukX93Mic4RyR1Fl5yx23TjRmMbOizDmeG/LBUriGMsGOTcmwQg0LGUxVVq4rOdJ8vt52BdroO6yS+Lf29glDaQT8kLIIChJxQrieQ9QMjzabHPLS6BxJ5+gi1OVH7jP2n7kp2WAdMR7NyETrIBohLbb40zhCOiroJc0Xcqkev4lAQs75lO0rhi49zH6uzjtUgUdgnwkD+I3I7Mxtx29G6YjUGIQIgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5247.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199018)(38070700005)(478600001)(82960400001)(38100700002)(122000001)(83380400001)(33656002)(55016003)(6506007)(26005)(186003)(9686003)(7696005)(966005)(41300700001)(52536014)(8936002)(316002)(71200400001)(5660300002)(2906002)(86362001)(66446008)(66476007)(76116006)(64756008)(66556008)(66946007)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZA4Xh1kaW8TBPsE9Wksze+2QN52PKjTIPf4VbpscICNZ27xG95VMg6U5ByaV?=
 =?us-ascii?Q?PA31XYsjl026fAZLGO6EDeg4H+QySgNwIQkzy7geO2tJqjreRcKPsuWPQsJ3?=
 =?us-ascii?Q?n2FfjNckKLk+JacLxlbgUWDYY9WIRRCZRg4JD1QLhiCNJwd4IwqIPQK3ZBTX?=
 =?us-ascii?Q?tGY8oThQ1WkRq92UIGIBg75prr5CBF+/QBB3uNPnCPrBu/Yh9h7Ao3KW+NKs?=
 =?us-ascii?Q?60LP+3OIyInZdbbmwV2jLvBanVvUaLvn384UkLffYB24Inp02jJ6afpU1DTK?=
 =?us-ascii?Q?l8OECPsnVfLRgGvsdULXyybPnQ1x4GPQsMR0M7VIw5UbiobtCuXjJv4njBsV?=
 =?us-ascii?Q?j9tcVRxxs/5nbLiyOjzJMHpQTcCzT0KkTibvMZJDUZ2lWIQ8kh7gyiSsINxr?=
 =?us-ascii?Q?yaf+UHjVaPJdeGLmcu5Lc23tQpfnWnOfnSoAXgnmzi3O+QldluwM/DPI0i0B?=
 =?us-ascii?Q?aBjZwP5LDhW7HquOp3GQFhVNtghd7KRiUC5KgZn7pmyVQwpTh6N3EuCHpsbV?=
 =?us-ascii?Q?aQ+DjGsIl7HibQc7hhLdeZpFYUajj/E0PgpdfJG433f2PvnVheVbU1Dkg2Lv?=
 =?us-ascii?Q?0u2Aj6IZBAQWiJv+YQ8FDKM5vKxHwGN0PuMo5WjzvvpBgv01LTYHzAmidWAV?=
 =?us-ascii?Q?cCGjAaOH0cOnYT4EhJJ5lJDNBLCzT/9Nr5hlPs0Yi+wgfkLteWlL5J3yUdaa?=
 =?us-ascii?Q?vdyV24bfdcIKg7nbILcGSJL8y3AyLE3/GabAfmhErLHPSGIn+18EGsjq7Ob8?=
 =?us-ascii?Q?pavooL+ya9o+oTeCGhyEoyoU8CPUjBd96fIOgyhZwh/pV5945xj9FJnajUGM?=
 =?us-ascii?Q?mWOzbMGWV1oB5ewahbGJAZaq6prL8Nf7ocovJ2nzJIgL1KaekaGz4CRb0+ML?=
 =?us-ascii?Q?2ZDGvrIyBDN1ZtAQ9LLduXhVY6gRg/3JVDOO1fHDrn6Zz6iX34fUWNQERDkZ?=
 =?us-ascii?Q?XR0uo6N2P7ocniHbggqXY3K5/18jzPoaSHPuTYnaIEmg8ZyH9E6sk3BG2uzy?=
 =?us-ascii?Q?XQEjV71n2QEYomTU+S4osW700XW0wKT4yvdbnO4yR7l9povD9UhZBEU0kKZa?=
 =?us-ascii?Q?w/yjeOLYX5vYqe8ZkeOezphEA0rtwbpXBQXOHB9+COsqa2FPcPwzewgclRng?=
 =?us-ascii?Q?LhnuvB5WjUHncKdWTnGWsgaqUBI0M+PRlz9kYdqU/r351UIxjWgd2YE4ISEX?=
 =?us-ascii?Q?Yfhhg3GxpLdbA7/AG1zKiASTGDrU0vYLfKeXkhyJTfz5CzxRugvW1xfIy3HB?=
 =?us-ascii?Q?xhsiNQnjKwvfLMIi5EVYgW0j5qOyYC5khzj/+2brJ/oMv4dT5YTuzQnWKlja?=
 =?us-ascii?Q?LkrXo7YyGLQvDd69WickUBCFRGRGzeWudn7v28wAwIjLWOKgLV+EU//PBdYt?=
 =?us-ascii?Q?dHQAUNXvzCtTpq4C9hA++N1E4MOYRU6F89Pb1KpB3IIQ5yBow3PeGZabguKb?=
 =?us-ascii?Q?tX9ItQj2v8JwqH134FluYTyqB4wLcWBS0laIeD8Tjb1Y8mZ/lVYI76DDhUWq?=
 =?us-ascii?Q?n0vJVrC85Ch5pm3H2pkG7ET4vHE3r9p8lcJE/vvgdBPEfryN/AZJMyFhWMAE?=
 =?us-ascii?Q?+jKE1pbHGLSNoDeRSAHUHld/xkxlQjmTchIyBI94?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 398f6f94-3deb-4996-f11b-08db03aea9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:14:51.0405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcuPDfLjRqtb4E08FbDZwE5givFzXqPnBadtrltDsA+mvzTo+FO9DVTvS4Xga2pJA/I1xRhvxKbJffB03A7lxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8230
X-OriginatorOrg: intel.com

Mptcpd 0.12 is available at:

    https://github.com/multipath-tcp/mptcpd/releases/tag/v0.12

Notable changes include the following:

- The mptcpd repository has been transferred to:
      https://github.com/multipath-tcp/mptcpd
  The previous intel/mptcpd repository will redirect to
  multipath-tcp/mptcpd.

- A new mptcpd landing page is available at:
    https://mptcpd.mptcp.dev/

- The payload sizes of path management commands sent to the kernel
  were reduced in some cases, slightly improving performance.

- Automatically set the "signal" flag when a TCP/IP address with a
  non-zero port is passed to the mptcpd_kpm_set_flags() function.  The
  "signal" flag is required when a port is specified.

- A potential memory violation that occurred when cleaning up
  resources in the case of a failed attempt to track a network
  address was corrected.

- Several order of operation problems in the `test-commands' unit test
  were addressed.  The `test-commands' unit test now succeeds as
  expected.

- Skip the listener manager unit test if the kernel doesn't support
  MPTCP.

