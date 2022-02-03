Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675E29CA
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643908994; x=1675444994;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=jckigtsekTh4Ef7/XixCf26zkyB+0kSFSngBDc/GG3o=;
  b=Lp/MYQyA7E7/VI0exALNbNQ4NUEnLlQjW4+xyJ/24TmMflsuELbFyM1C
   3PDpslnnNC38ibnI3BWrdWwAdkHk1qX9+2SnlJHMbZ+AZc5mG/9YHL7j0
   GEemaYC/VeRDU9qe7TzUtr+RNrqm2o39tEu4KyGJGplrRbDjrJdQ+aC1h
   JYGgD84NskMTNCVZG5iIZUvGPA1gt6EN3fyCdTd7dUiYRKS3yigeaFsqx
   wPp1iB0uUIoAbmxqQoTwJvgkFHru4DIOIEAp6cMLwE5+Ummz9TYa+pn5V
   VNs39I0E5tqt4Z32vv4kUEy6k8A1DTQLoCa5VRngeIODNqvmJzowG+0O7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="311500294"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="311500294"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 09:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="620568403"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2022 09:23:14 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 09:23:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 3 Feb 2022 09:23:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 3 Feb 2022 09:23:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POZv0sLpJQKJeYYnFEY5wH5dH9i6bD4d8QeklC1VXeHXsCCP29NiqnRLCszqEWEKyMKkrdsShTd5I5R+0sIaTNFm0ukrLByKbUeHoZcwvAwqq6J2qOWFvhPTnO9k4IMI8r/gmENqNJS+jL8edQHcaeEkUMcFFRbDriobYRTxI++pt8P7p3d7afWIvv9BoJr/N8CWxWh4UT+eDT70FtSnhuFzQikjrirvXEkHde24xWFMeUNxZiCDUYAFO27CMjskqdnOHymXt06NeXw9G9CdNjfTcECF5ywfjgoIXWC5UqPbuDTQBVUiDzv5AaIoiDYe8bZLcTsllUSTshLkTQ0Nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jckigtsekTh4Ef7/XixCf26zkyB+0kSFSngBDc/GG3o=;
 b=N6jQgtOVBODAC4XLR1hLf9ztJbtTS0m7qJFkTjqB35ws7ONJ7n2I2KcgKwKcc/Q1kASvkE42XiY/NCBsEY0eDUGErqbx55jm5LlNX2IsVpsk8iuLhfvfuhYimevzZa1Ku0bXJoCW7tOTrKQI0zBLVeW09EPL/p/OPRqZ40OmhuZTsXz2a8pFv9tRMAunNTZgt4rJG1fxb63YNpbE3BOVWQNoCwLenvilCrT2hSpjXLxnYGnMzE1MLTuevBqH+M4JUoyNFijLRgOdzhLA80QoUZX6CcZi2lV0VrXtO+3d/HRXOwfQM44kSC/j2yz+3DEaS5gODrPIbMN65pViBLpRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13)
 by DM5PR11MB1418.namprd11.prod.outlook.com (2603:10b6:3:8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Thu, 3 Feb 2022 17:23:11 +0000
Received: from SJ0PR11MB5182.namprd11.prod.outlook.com
 ([fe80::b8bf:2625:be7c:4178]) by SJ0PR11MB5182.namprd11.prod.outlook.com
 ([fe80::b8bf:2625:be7c:4178%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 17:23:11 +0000
From: "Othman, Ossama" <ossama.othman@intel.com>
To: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: mptcpd 0.9 released
Thread-Topic: mptcpd 0.9 released
Thread-Index: AdgZIraFUdP1xAeWQkSG7JOxbqYMUw==
Date: Thu, 3 Feb 2022 17:23:11 +0000
Message-ID: <SJ0PR11MB51820317DC0520BBB2F0C943F2289@SJ0PR11MB5182.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.200.16
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be2e2d22-2e79-4897-82db-08d9e739da61
x-ms-traffictypediagnostic: DM5PR11MB1418:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1418013862DF5FDCF854996CF2289@DM5PR11MB1418.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hinA6sqJwsYlZ78nVGDceN6du7ao0T89UNx4F2uc+89SeoefayUWw3fDovm6zrubGPCZI6DlJZauKBxkTrZqt457Z4crEi60BRrX3GUPg5ALE2IRr8PQyiczvfTsP0lvWFNfOGtm2BXRXgkm9s54I8wrHGR9v8Fhd6LpXZwdFoqd7Ti+w+bzE88Zf3RRFoON4M7YMkmeeVQ7WXWPju/yi27h2odImHavrYeHgSBc4EzDZO5jo7z5yrE6hTz16E/03DaMlD1R4uYbOYgtvlG9ILOtUKInz4qh3VrJ98coSn2eByz29Zm3CHkzGNJ9n0wi5F5aCu3+Sp2v3sTMKy8OxI4UChYEHuYwz/7o1wUBFcl68dPIsQnr9Ih9cjT0onEn2Sts7WCvXlWlwnnxHHYrifvjI6QotMh8+rWsFXHvGF9XIdSzddjpilt7RF3mggSbi9+LOvRRkQqTXjVFLBlct5HUTTiqH8a0QiV6/nNVT92kNZzhzrEgA3XmykewnXBreukMpGy8vM3D9cXNnMciZZktdluY04VDHViTN7UYrzLe++D1WuOgMtpFHTvn40BjTGO/A8fZV+aKHh8F9BVvaNuRP4VkNwf8FTAJo5Kh3+y73w0BsBnOADIrxfbD2oZQ3UFEFcTheN4C56eE9Y0GG5JVWszdQjo61X6cBus5kwfSpCTnqkiHVezEfsUdC5kRbsKaOr7N1E0xr2/08HQa7RAcQy7XhP2wtvBpfhp7D6u51Rp61Jj5KPGmKQ1NO+T01HWAttMs+XuELg+kGG04DHP0ENgPfB1mRF5RGCcpJyo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(9686003)(2906002)(8676002)(82960400001)(26005)(66446008)(71200400001)(186003)(6506007)(122000001)(66476007)(64756008)(8936002)(66946007)(66556008)(55016003)(966005)(5660300002)(316002)(38100700002)(6916009)(33656002)(7116003)(83380400001)(52536014)(38070700005)(76116006)(508600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lLWeuNwoCHmIzcq5fEgu9oTg0tajXjdDDKxAEcYNm7/7WWHWXLwlWLbgv1?=
 =?iso-8859-1?Q?bLjjPcnCUELXWlR07gBr3rWDkTmVDZWZLyRdiSccMt+ardI5iXUEnybc0M?=
 =?iso-8859-1?Q?an+deFUS9EFBbXE48pcug04XcPWirXSviprti8cF2t6u5ugovgFf/2kTvw?=
 =?iso-8859-1?Q?Xf1GnZYfwxNpVGjFlh+t0YMLoJD+Dfgb6tCx+cT9jRmlBQE8fExToriW96?=
 =?iso-8859-1?Q?0o9kyN9sUbKhSsWTLS0tIUi9ZSHrH/KW0L49fqmYxFx+PdXFYJrd10YoGj?=
 =?iso-8859-1?Q?VbIj5w6TgBtfOlBQLhzkJ4wFHtaolG5GKTxgidq5EUEtGA4FknYbwygSHc?=
 =?iso-8859-1?Q?L+kk41b3/+vKrpqQWadZTPlse+uzUAlNR1Quk+AyiDYHbQiCtfcAtR+auO?=
 =?iso-8859-1?Q?UPZWIyWHCYbf+n98inUG1TRdrSNRtcHeDh4COG+o920qqd8mS9C+MWt40P?=
 =?iso-8859-1?Q?fEpmkyKSvx+ok0ykEW9zhw+Qw6ztak8/lH9E/WkbYN92T4Ed3zqgqU4vqF?=
 =?iso-8859-1?Q?xUZ8ixMyGv+0iZZYiZxBjCHc50EnqhZ7NzgRvlss7XX6N32bt+STfw7LoL?=
 =?iso-8859-1?Q?qMRp4rswnjl2cU935gtd2EkOjS0d5z5ZBZHruMBxpoTDdEbu9+X8BKxYuC?=
 =?iso-8859-1?Q?3pJywY5GyCjP5Wv3XdE2TAznNgyUq8CFBzVuRdwnNundcgmJYYiRoSmJam?=
 =?iso-8859-1?Q?okZxePjinnBSUHSOc4JDqiCdicEdj0RLxQQClTcHWY2qpYiVm1cxii1mAA?=
 =?iso-8859-1?Q?jiOCuSzDvHSngF/oy8hU/52XPMGlX/qp+bnQFM6VOG9R6lA5M+L3S+sXyE?=
 =?iso-8859-1?Q?gOMlREEeed3K8NJIrI9J4pmSQcPw+bNDBlKukLNT6+x8ReDVGAc6jp7eXV?=
 =?iso-8859-1?Q?hExic/VDfw3fxpPNWDmhUYIn8vjrq9MxuHKJ6Ri3TcTQ1kq/83McY2rIDr?=
 =?iso-8859-1?Q?dCrEmzQfqE1zsBp6cVQFJp0aoXaCw6jBf4q+0JW4vLqIyu1n5ty+tl2EuQ?=
 =?iso-8859-1?Q?QMLK2eeLjlQ0sX3gQHzTttKxMCEWr8+MErttSwUqPhPAFKgUpq5f08g1My?=
 =?iso-8859-1?Q?B+YsN4NDNh80X75V2DcypXlulxeUtSVCeKIEWgJIHYvluxmbmUVJ0kDgKI?=
 =?iso-8859-1?Q?gnlKO8DfF9YzIPh9tNTLmchkrh1oQ57ovW7O8mRKWHRLlbbhZ0wV1Evtpx?=
 =?iso-8859-1?Q?d/Va+MaJiiTLU74XmDUEwOT1j3kFhqQGCbhdJfj+TOJpDPd5j8EY/MNm/0?=
 =?iso-8859-1?Q?OfaZMPOXk2+rYwt2lDVKstvLetdgtnWD8aWprlk0tnvYGuURTjO7Bs+8+M?=
 =?iso-8859-1?Q?a4aKinL4UMRI4O5KW+zCQ78Dwr53RLaVErzDCpj+5j2Us4o1reGyZXHjxn?=
 =?iso-8859-1?Q?4/e+dNvGdCltVXhtIAS6fYMtO1+a7jpHXnYbJ5uJQyErdkFxKIZrumlQiW?=
 =?iso-8859-1?Q?wZUQMJ/xr+S9MocK6FJtU1gC+GL0V2JOa4pRr/dILSMSzrKhektu3mO71X?=
 =?iso-8859-1?Q?0BVTCNCk4U0wieeKdmD7rNmPqMGmC3Z6wV6xaIExgm8F4wqL3yGPEKbaCl?=
 =?iso-8859-1?Q?H1l6OG0VU00xbONmwJnaY4P6+3bTsaAimpEKjvBoFcs7KOsX7hKF5Th3UG?=
 =?iso-8859-1?Q?YtcdwGGLjkrYcslj1JZFuPnWP9LaO2yutmOe9MCNtBf//m7su2PoaaBA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2e2d22-2e79-4897-82db-08d9e739da61
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 17:23:11.1518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywg0OweFo2jo3vKkd1INPlyLtMpmxdK0RZ8iDJw0dzsJVBzxfm5BT0Ak0k90BB+sTMFpUzAfkbJZqX07ldNbXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1418
X-OriginatorOrg: intel.com

Mptcpd 0.9 is now available at:

=A0=A0=A0 https://github.com/intel/mptcpd/releases/tag/v0.9

Notable changes include the following:

- mptcpd
=A0 =A0 - Several security hardening fixes were made including missing
=A0 =A0 =A0 hardening flags for the `mptcpize' program and compile-time
=A0 =A0 =A0 hardening (e.g. _FORTIFY_SOURCE) that was inadvertently disable=
d
=A0 =A0 =A0 in some cases.

=A0 =A0 - Systemd based start of mptcpd has been delayed until the
=A0 =A0 =A0 multi-user environment is fully operational.

=A0 =A0 - mptcpd will only support one kernel at run-time.=A0 The kernel ma=
y
=A0 =A0 =A0 be selected through the new "--with-kernel" `configure' script
=A0 =A0 =A0 option, e.g. "./configure --with-kernel=3Dupstream".=A0 Support=
ed
=A0 =A0 =A0 kernels are "upstream" and "http://multipath-tcp.org".=A0 The `=
configure'
=A0 =A0 =A0 script will attempt to automatically detect the kernel, and
=A0 =A0 =A0 fallback on the upstream kernel if it cannot do so.

=A0 =A0 - mptcpd_addr_info is now an opaque structure.=A0 Field accessor
=A0 =A0 =A0 functions were added to the <mptcpd/addr_info.h> header,
=A0 =A0 =A0 accordingly.

=A0 =A0 - Address filtering based on default route availability was
=A0 =A0 =A0 implemented in the mptcpd network monitor through a new
=A0 =A0 =A0 "check_route" mptcpd command line option notify flag,
=A0 =A0 =A0 e.g. --notify-flags=3Dcheck_route.

=A0 =A0 - mptcpd initialization order issues were addressed to ensure that
=A0 =A0 =A0 the internal mptcpd state is stable and consistent prior to
=A0 =A0 =A0 invoking user provided callbacks such as "pm_ready".

=A0 =A0 - A "complete" callback parameter was added to
=A0 =A0 =A0 mptcpd_kpm_get_addr() and mptcpd_kpm_dump_addr() to allow the
=A0 =A0 =A0 user to be notified when these asynchronous calls complete.
=A0 =A0 =A0 This is particularly useful for the case where no results are
=A0 =A0 =A0 available, which consequently prevents the "results" callback
=A0 =A0 =A0 from being called.

=A0 =A0 - The mptcpd_kpm_add_addr() function no longer ignores the port
=A0 =A0 =A0 parameter.

=A0 =A0 - A new command line option "--load-plugins" was added to allow
=A0 =A0 =A0 the user to specify which mptcpd plugins to load instead of
=A0 =A0 =A0 loading all plugins.

=A0 =A0 - ELL >=3D 0.30 is now required.

=A0 =A0 - The mptcpd unit test suite was expanded to further improve code
=A0 =A0 =A0 coverage.

- mptcpize
=A0 =A0 - mptcpize will now hijack socket() calls that specify the
=A0 =A0 =A0 IPPROTO_IP protocol.

=A0 =A0 - An issue that prevented mptcpize from updating systemd unit
=A0 =A0 =A0 files on a different filesystem was corrected.

=A0 =A0 - The libmptcpwrap library is now installed in ${libdir}/mptcpize
=A0 =A0 =A0 instead of ${libdir}/mptcpd to differentiate it from mptcpd
=A0 =A0 =A0 plugins.

