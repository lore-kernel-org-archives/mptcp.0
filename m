Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524FD269;
	Mon, 20 Nov 2023 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5+noW17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700467094; x=1732003094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tnj3eGWwkNp+ch8AyO+yL4TyAWh+E24wVI63ylrkToI=;
  b=W5+noW17imIwwKnIRidVIY091HV0ZQQuZ4NTNzH3/6CWGw4f9EiL6Kun
   j2oABEyMdPzo2MYov6fOZl196ly+rRWGxIowN8zdA4swgTeVjKreHlDOn
   sRJ4FajBKeDanOqS5d6GIu1NO0JOB66quWZ1jNlTjsKGGjbORiBYfQbXM
   xxcKHta/jZFzt5WnGdpKVoNe/ldELJxStpGGNqCzbGpM06uI4s7ZZgSZZ
   h1Xv7nLhekBa23AOophKuist4SMs1z492KoG4WMkeCUCqCgi9wgZUwJmu
   7l303D3cx3hHgU8btXF2ySBtufTpKMw28DUbDISMNDh3myxcwHeyfROxs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="422665067"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="422665067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="832194790"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="832194790"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 23:58:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 23:58:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 23:58:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 23:58:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 23:58:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkiXprnod3wgn0d1EQpqYir2f0Zl79GbzrpzqVydbOP6ISCRx+JjGuLff+spRhG5VlTaEBU0Qt7YwZ0puLzf0CZvMYpBt80IEQ8QMuP1rAf4QV60rYlTkrFvf0DET7geoLkikYvAQ3N4jhbRWgJB7YBwnhdIQWiMmc+r8qK/i+u0cSY4rlwkyRC08Ez5/i7GSRwNvr/vJE9wg7dUyZJiLi5H4f2Wj3hm+JBBjvFw8W/8ATfjedvqgzhqYlkcm7oKPZXFapEopwJr9e36sBqqtj/wImVvPeZxsPV6Bp2jlbsiXF129nDeIQw3Kzb8Yn0797dQbrt+SsvrZy4ZG0SsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPwDS6rjl/saxBdrj9lk2K5WNLalXc+hQbX+yxMuglE=;
 b=YCLFpG27O3Wy1HgxsaXoE47HNji9F9JYbSYStQ72xpl0lic/Y7N4TQYQyixkR+8DkXzhQQoNB7qJMacmcW/5Wetr3AObGEycYCb7vAudE4IAM8Bwjb4hreWTH4jGcgfAX6WkStgEqBsUIs2Rbd36YMeBFx/jwvVRXf1uau2KgA8ri5SV++IfyTeh6W2UPw4Gh7Hu9aDToMcmdKQ9nbCLQJQAH+nquSwhoyf3eD3QYMEOjQAkeUNSrPWitonhU0RiqcC7FANIbhnBPPijtNRDk7PywuIWnxZF3V3yd+0NsCOFaeg22QxKhswRoze/GgAU6Ujd8Y2jb/sez0kLFNg2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB5578.namprd11.prod.outlook.com (2603:10b6:510:e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Mon, 20 Nov
 2023 07:58:10 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 07:58:10 +0000
Date: Mon, 20 Nov 2023 15:53:32 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Geliang Tang <geliang.tang@suse.com>
CC: <oe-kbuild-all@lists.linux.dev>, <mptcp@lists.linux.dev>, Mat Martineau
	<martineau@kernel.org>
Subject: [mptcp:export 35/39] progs/mptcp_bpf_burst.c:37:18: error: no member
 named 'write_seq' in 'struct tcp_sock'
Message-ID: <202311180438.KHYloYBe-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 269447fb-dae9-4b45-8a27-08dbe99e7062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWBimxDLitD3tGEEO+8Sv0WKF+rIL6S5mZCQAS4S2G2QItYyEu+/1vnInEhiRTYoV8vR7ucWoaR3nrMvsLtir3JEUJ9YlKBM8Sy/H3Fe4uP3BbJvwR3lGHYPdEoS9r9BF+zgSeWtlfICw23i6Vf+ppo3UTZa6buhHSD/0Whn3f5js4GSTdabtMTAY9/Fo+v7tmErSyhkJf8bV7HFeKzbA6HljEsGetCgOE19i89kNpxTvF7qeOT/ft2afsD5D62l1n/+an454fJCOcaoZeXV8SSOIihf8O5c3JlLVrTKzBNMzq+6aTbJ5mqg1kj/9FjYMT0Apx0OQOki7T+9gw4Lsw8IrDLeGWPzdQ/ckbzUMcGbWdwM+ux2GTwi9QswQYuZ+NMGN3I3H3/l6n+z0SQSofpcx88O6aHhtBkjElo5kVqZqop8ObqE2fdp9Aj2NGrSagywK5tGt+w1JYLggzHfWkwz9dhoN0ramYwhmrFE8eOedm9v421ranOQ144h4IPmkf9FaRyHZ8lcBGyXKED2wUGUEP66EI74qt4AvfPVjurbGMa61ll/q0oMvf5HJcPhsbdajfUEcAz8gXaOKLstkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(83380400001)(26005)(2616005)(1076003)(6512007)(41300700001)(8676002)(4326008)(8936002)(478600001)(2906002)(4744005)(5660300002)(966005)(6486002)(6506007)(6666004)(6916009)(66476007)(66556008)(66946007)(316002)(36756003)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?08VXP+HIHfZtc+7tHPX0ZYSNcThZTTk/T9TyrtvpPkgXR+dyh82YVQ80f/5z?=
 =?us-ascii?Q?eteK7ET+XCCeljLryIcAzohf+uAGn+Z09jykNq6tvV/uj3ZBEB+VJ1m84+ww?=
 =?us-ascii?Q?5kewaSXi4cpTIaAOkRPQlUg2Ne2lu27b7mFn8vY2+heZTo6XMPW6bE5AkRqn?=
 =?us-ascii?Q?Epf6JoAq6S2YyDsLcy4qwglZcnxY2+PLSGTUvJuK1ZX46GUUMVYKaQ2X7NXp?=
 =?us-ascii?Q?Ml4DkbAfA4sMwVkRoRj8wX0jlK19FBVSrNULV5YGMaQkCxAK/QOOj2NWZWxk?=
 =?us-ascii?Q?RN8i0Jilypr9VzLGsy3aDeBKJ4lvb85XtN2mdaNJGpwg4vWvjciJeaYPONVH?=
 =?us-ascii?Q?jQRU0j1zMwxFmSxcIIuJtzaaUMGqaFjJBxmzhTuN6dYjMfCmqaRxlg2z1diD?=
 =?us-ascii?Q?TQSjjPT0LDO4D/ZjOaphtYxNQFUhiYeAE2GR6maTSXXNldCg+10uIkiEaLPg?=
 =?us-ascii?Q?/sf8m9w0wxwoid1Z5LBGPvp6mQoPvwgB9C7TL5MsWygjvN3FH9dW5BhsX5LS?=
 =?us-ascii?Q?ixqMckRv77VI4u4y36WTEc6yCx9c5X9hQwCxjvuLOB2IVcuWdZZJUwFKEA1P?=
 =?us-ascii?Q?ShydF2iYomoJawe/930D8kU810tsg4peP7q1zuu2ySQClDjI3f8Vqs6ds6lN?=
 =?us-ascii?Q?IpY2SH8Bo6wgD/xXfH40S2yyoWc4U5o6oqNy0SGrnaUy+q3jQWp1MxDCUp3/?=
 =?us-ascii?Q?RRKrbqmKVwz/UAfFuoQLkZ/W53gDw1us05SLq8LKRQvYs2agRwoYwxmonfi9?=
 =?us-ascii?Q?ewuAkQ8Pzdo8yLwruCYXTWeanlTi8tzvkRVjgVqlaQRliwXlrPpShpJDzLpY?=
 =?us-ascii?Q?mSRWU9AIv0F2cqMIKgmxxnuDZ5ohXdhYoIp5umf7UYiMcdXRj/QV5dZMLQK+?=
 =?us-ascii?Q?MBRoqaBLglhgIbAapHqJBdBnbpoesmTutN/WUGKNuvA0In//oT3YAGJL3sy6?=
 =?us-ascii?Q?M1lJU0PHxHNIBnR+KHRmXD+1fQP0sfwT52Cs6VoxW92+iUuCh5romDy6OZrj?=
 =?us-ascii?Q?H8cP5U2BLt+e4WxEakANeY86NWuRHyEnR4seDlp6X8gwE2fq1Px2o7yv8d8R?=
 =?us-ascii?Q?KT7Wa6L1jS8Fnxj1HjnsEAj+po8p1dYnhe65g63EACUzlLKpFnkiWYuMLHns?=
 =?us-ascii?Q?GhHnOc9YpnKe3V9X177sFfraWjGhlmPvI5kuRq9AL+5hdROusi+3bNFxnSY1?=
 =?us-ascii?Q?8PHzHWd2G0xnQtSVikBio/0xsAnC+vmTGymfmjWShaCX3P1YGLf8eCv+FMjq?=
 =?us-ascii?Q?JEx6xQCNSCtEoRFULSN6gSwha8+N8vdf397BhBV2+3bem/L8u91Nd64KuFzI?=
 =?us-ascii?Q?owU+YKypqjfxO4jhLTs0TrarX3TFAVzQ0lE0ArGSflKu2xS01u0igBwKoq38?=
 =?us-ascii?Q?AjAwfZPBxl4sJeqMJJ3Vbt9y74yzcT61tZxn6XvaqS28cxUl146s7EtcmHi5?=
 =?us-ascii?Q?OqDbkNxfd+CxEvtNsdbNAjbD3xrwzUFNzOhi2yfYTcsczXNFyT40XYkZF2Xc?=
 =?us-ascii?Q?htBfmLyjUNrA2j41GyKJkW+hTz0aCGeCZyg0nhlLO/wgP5laaUIkI/3t0rAH?=
 =?us-ascii?Q?k6oe0Tp6OVW/kisMIPym/KFG0YsExXLwzLH++K5w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 269447fb-dae9-4b45-8a27-08dbe99e7062
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 07:58:10.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxXh3Ly9+F+EjkjZXlggZRfM5w1okEsyAFr1/R5GExFkpA8gtqYwsBOmA7juepCRfuGx6DVyYph5ms17WexRJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5578
X-OriginatorOrg: intel.com

Hi Geliang,

First bad commit (maybe != root cause):

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   4fb8133272737c034fce4cf3a82ea02ded380281
commit: 5b8c59bd41d2ec0608090675ec3cdd1a1ce3e9c0 [35/39] selftests/bpf: Add bpf_burst scheduler
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311180438.KHYloYBe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311180438.KHYloYBe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> progs/mptcp_bpf_burst.c:37:18: error: no member named 'write_seq' in 'struct tcp_sock'
      37 |         return tp ? tp->write_seq == tp->snd_nxt : true;
         |                     ~~  ^
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

