Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859313FC8
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 16:38:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="211354116"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="211354116"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 09:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="475242542"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2021 09:38:51 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 09:38:51 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 09:38:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 24 Sep 2021 09:38:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 24 Sep 2021 09:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7c7xU/A4PKi/9yyaD7sk8n4X3Ngbm2VMfkjchKaDBg2RY1mizs6InZyjKvxKWbc1kLRFGkUKzPDVR1Wk7Fb6kK7DBD8azrMEQ5AWef5Tu8RVDMmzBQ81gTE+oZYD3HJD0OaPbVK4bIwnu2rAaTTnwQjYKH+uRXmuRbPlg4y66T9JCD0buWVREQySQ4OdbXHewRZq1ODzNwZKQItCYUP34g+KKA7ojHo434Aj6Lrn5HY/5JoD2Gm+FGqR3HMYUyZvuf2nY/aZaVm8Fbz0+ZF37WyGeAXzeXuwaZMFJsGjYfzpCxUdYWmzeuIrol/rsuMwThcJ4cAcO7n4OhMkfm7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IiKX0ecAPXKvKFCPJjzbyqEqmm03N+p+AxK2jz5kai4=;
 b=QuZ0qj/mb07do9l4dDL3AhK+ppyglAKugxxyyJx1OSOIHzGekwPa5J13ArIBe2wJ5IqIg+t+ysqgog3pPzRXszNrkYM9gNseWFMD96YqkTo5ymTHCIPMTHx6NayT2thmmCWDQL3MzOYvpIl3H5m6swBfnJhG5V6MPWD2Di8KeFFeQWq9Ju7jdBQomMpTYdFurQlSMxvcbAJRPtAuoGRkQzW3fWKcoXyWCc+ISx59PiVr2vJr+fgeZkavsCC6Zl0Q1zPsKDXdK0PI2z+Yab7s4pjD0BjQTL9yI7Ylwjb1eCshoG8a6icGbqNSfhw+mY8jwlzRBjxv0Jy/MGX/EnavOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiKX0ecAPXKvKFCPJjzbyqEqmm03N+p+AxK2jz5kai4=;
 b=q5YTSkiY/6UG1dqsZrQM18QddMgccygXQKI5vCADc3EQ0a561nUN0OyAhfbtDnKHIriYZCG6/gSRt1zsfPI5Z/VJq9M8eDXQSPlE4EjDvRlJ9TOJgDlNNKt92ibO7gkTaNeyk5TP+BB9rtqiZWfaVsV5QD33pC0Xo9zftCsS9tw=
Received: from SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 16:38:49 +0000
Received: from SJ0PR11MB5182.namprd11.prod.outlook.com
 ([fe80::38d8:c4ee:c9f7:11c8]) by SJ0PR11MB5182.namprd11.prod.outlook.com
 ([fe80::38d8:c4ee:c9f7:11c8%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 16:38:49 +0000
From: "Othman, Ossama" <ossama.othman@intel.com>
To: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: mptcpd 0.8 released
Thread-Topic: mptcpd 0.8 released
Thread-Index: AdexYPXk3BRpzvTvRTaxNMBu2rV3Og==
Date: Fri, 24 Sep 2021 16:38:49 +0000
Message-ID: <SJ0PR11MB5182C3E255457FF9F472E80CF2A49@SJ0PR11MB5182.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.200.16
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a25132d3-f111-409d-edda-08d97f79c955
x-ms-traffictypediagnostic: SJ0PR11MB5182:
x-microsoft-antispam-prvs: <SJ0PR11MB5182B25040A81A53A30697A2F2A49@SJ0PR11MB5182.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwUv+ChonnRwiK4RvTnPa/vrRa7gnimeHXeURdOyZWt1iWlGZupEAUUllPap2nBK79ILGLBey1YOu0E/bE6DhC+kEf/2m6erJwpPqZgH66HR+KuBJ/9KoxdB78CbAVfCvDVUgFHDpYTnyI0i9bCDbS8rQzw4l2NBOCbexF5h2qB3sNwYSWTjXJZ/TpD5KpRkU1/msAHyuduK/Io8TJte67ShIwa6aLxNMt/XzrM8nxhvNiAH+yslVp87uN3uzqmAINjB8wV6WMIMAD5DxmjtFZCfOiK051L8wQuzGRwtBr63XsrlkT4KLEu5UhcyQtREKyPNFirOJegIYerhrfov4mISDOKpvXHiAsU4jzQJkbZSe0LdjzrjD2zJ/1enkFMuZ5bXSCu6sdaPJxzicDQTeyZxmVa3ByS0Nl+eL7XpOUijPn5w0Ev+gFlNO7e+qzLIXA+b/41SRJkIagnU32RANZyq1AjVKCKibt6qrWIjHrDMcO7/3DuKIYXs/cTzE7tDivlJb/whXzT5PAJaMGIXV97iIw7sPedAjr29VOole1ov738qOlUAvUwVjEs0bMhdDPbUOc/FDlfOTxNT0IPlCk4m18ok1n1HsHwBf1fB85KJnqDDTuNnJ2AQyxYFHap8nP4CcCOSiA4bJYdd1YCVOHUuZhmom5pM5lxJNZ8hNll2WtsXwyYA4YKIBx0HDTA3TAgZXskwmJJOvkN3URrj/PBzll+kcQvelqWDdKKl47AKQKujpx7y1d+u3JSf0Hj+82nFKxUOV5QXViSwTIq0k3uBxqyPzqjUiCxh4A/Ion4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(66556008)(33656002)(2906002)(7696005)(6506007)(316002)(83380400001)(38070700005)(71200400001)(8676002)(52536014)(38100700002)(5660300002)(8936002)(9686003)(86362001)(186003)(76116006)(122000001)(7116003)(64756008)(6916009)(26005)(55016002)(66946007)(508600001)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C4qP+g1KFw3XCJF4OMEyuzjSsV74g6VbJCvlAKyB3B3OqJjEpaHvzzvIsjWc?=
 =?us-ascii?Q?h8M+oqBPs/HDXhfNmsnng/rZIerJYM5HutroxTKuiOhHSvNDkblrivpKFFEF?=
 =?us-ascii?Q?XiSgADXoKCToOvI/JZZ7dq9aKSdS3Xyo6GrIO6TLFnN7Rcq5Gar8Hvcnp9rM?=
 =?us-ascii?Q?un+5daKNbo9rBrkUI9+gN7hxaORNmwOaQhpTmP+5C8rR9DTZFFoBsPf4q0X1?=
 =?us-ascii?Q?j48pMft0c/GEl/GpW/C1FgvmC5h6uFyvdjZBOfBdoyDWHqjwEnQUS2laVUwT?=
 =?us-ascii?Q?i6QgMK+2rvHarpnnjfWJ8S9DqLXSy3rCwwmcbjlLe1YB95BwbCYh+1gn07Pm?=
 =?us-ascii?Q?MsuhfvgsI2xWBJRBqmhRNlFJ/T/+VSwjfdRDDeXMdQBTiypb9e+JnGPu5DA5?=
 =?us-ascii?Q?aeEZYV8SNhVyBITlRbyKxBaSv8aILtAV7yE+DsK8S9w8RMzKDmXZtMlyeAow?=
 =?us-ascii?Q?f1vm6lEobiQU4LZUrI+SFDoX6850Alxp61EIBeyL/Iz972HJPzzOojtKZaJm?=
 =?us-ascii?Q?OakgqYY0P1hsGmwVqiV3n/diz1Ozkv+1EagG0rJfW7SfiwTYwbwu38rmNQlv?=
 =?us-ascii?Q?Fhv8VHrjPEDnF9XHb1l5NIAh2kUqryz/lEcRLfkwJ0hoL43Nu4x1tDaYpNn0?=
 =?us-ascii?Q?nEp6dPtpWMCBqZ1Is9A0WSsBS8Wucvrz6CMUfIUPKbj+3JkEkper6i2Xa4A+?=
 =?us-ascii?Q?XXkM70pQ7tU393Xg+V7G3K9QfbuD/e6GlaJTaEQT9yjr52AO/5iU6yUcZogg?=
 =?us-ascii?Q?eElK8DILo7FDzurVeGfrmfbJHw+UxUGlaY4NHiXkjWycPld5Lf2/kzHgFoCJ?=
 =?us-ascii?Q?PjYn2sUhLZNOi0/+Fxlue0wf6koargBUTuhzvl9Z0euNrcNTQ43H62djrUfl?=
 =?us-ascii?Q?pmftB08yJIkU8m+6hnUh/r6PmkL+pEUQZpWsie+5wUeC9F4zwMKpBK3JffB+?=
 =?us-ascii?Q?0D/LquLW7Rt3C+I8+eEnXiUt/1modXqoPKhcBxjJVfU+QOzOPQL9s4HOoeKE?=
 =?us-ascii?Q?RrSUQYE+5kwhQ9eHEA+Rnmt2MEW1kK9dYuZoGE7Bnmo5wDvKPUKv6BaQIeG0?=
 =?us-ascii?Q?L8Zb0PTzmOEstNrUmux/AMNkUPqFeOU6ibcuz7XJlfkhDJ917Hy1IlU5J4Aa?=
 =?us-ascii?Q?0pnMV86i7XzjYbKhluZHdzsub3LOzZTD/hj1/6SO1cmORQWVX/2vhvZHdTw6?=
 =?us-ascii?Q?KduIJ96Hh6x9isZNBCAL0GvklhzfkLtc5mOHBgSltDdAKyHaCUWzW/akTVzD?=
 =?us-ascii?Q?eL/9qgtcTRoT004oQ+t66z7GtvW1j2loviLulVxrrClF2S6OCutbRNINV0e4?=
 =?us-ascii?Q?wXM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25132d3-f111-409d-edda-08d97f79c955
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 16:38:49.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OU2QVO9zLuhZxKEMO1/o7D2Y5HZW4Du7kCiFBKJND38gVxeXJo7FmXy+qYH7UzfRbP3+CNv3hKrdPRcJ2xja8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
X-OriginatorOrg: intel.com

Version 0.8 of the Multipath TCP Daemon - mptcpd - is now available on
GitHub at:

    https://github.com/intel/mptcpd/releases/tag/v0.8

Many thanks to Paolo Abeni, Davide Caratti, and Daniel Danzberger for
their contributions.

Release notes:

- The mptcpd library API now splits path management operations
  specific to the in-kernel path manager found in the upstream Linux
  kernel into a separate "mptcpd_kpm" API namespace to differentiate
  ADD_ADDR and REMOVE_ADDR related operations between the in-kernel
  and user space cases.  The operations for the two are different and
  have different use cases.

- Two new mptcpd command line arguments were added: "--addr-flags" and
  "--notify-flags", along with the equivalent settings in the mptcpd
  system configuration file (e.g., /etc/mptcpd/mptcpd.conf).
  "addr-flags" are used when announcing an IP address.  Similar flags
  are used by the "ip mptcp" sub-command.  See the ip-mptcp(8) and man
  page for further details on these address related flags.
  "notify-flags" provides for further control over how plugins are
  notified of changes to local IP addresses.  See the mptcpd(8) man
  page shipped with this mptcpd release for further details.

- Improve the mptcpd "addr_adv" plugin by making it set suitable MPTCP
  resource limits in the kernel, such as expanding the maximum number
  of subflows to allow subflows associated with advertised IP
  addresses to be created.

- The mptcpd plugin directory name in the mptcpd system configuration
  file may now be left empty to improve "multilib" support found in
  some Linux distributions.  A compile-time default will be used if no
  plugin directory name is found in the mptcpd system configuration
  file or the mptcpd command line options.

- Mptcpd command line options now properly take precedence over the
  corresponding mptcpd system configuration setting.  This addresses
  an issue that prevented mptcpd from starting if a required setting
  was not specified in the mptcpd system configuration file even
  though the same setting was configured through the mptcpd command
  line.

- A new "mptcpize" program was added that allows legacy TCP-only
  applications to transparently use MPTCP by either of the following
  approaches:
    - leverage library inter-positioning to transparently replace TCP
      socket calls with their MPTCP counterparts.
    - enable or disable TCP to MPTCP socket conversion through an
      existing systemd unit file.

- Build regressions against ELL versions 0.31 and 0.33 were
  corrected.
