Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E50224CC
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9hLDOsLyDpaYrk6hwmuIL/Z7XLxWE8BmK2PherrHqG0L5jFvxSkxsrOaRuyDCdUHNMxMSP/49zzLavX+JaXq4n/I246gyTbA7G9N4S54Y31EJR3UbN8261VPzqapTpGw9GgPkIvc9fbuRjg2bAPiVOAT+L15x+XfmGJmAdkZvI9Wy4rQuaTMB1OAa8ev3NPMZk8snMTmKhjRzUWsXbohi/pmIUP+SRsCDA1QR7TlKLwzrjnFlbhIjVBi+eupe5DH8d/uDmFNWZ70JnxJWvusdLJBP28B99a4S2UbVpfMgj/Xn2Ng+3rY04ULmWUVFrM6LS8QYgzbjVgZvX3TcYnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB4km/eRHIk5CMt0/rxknW0+18XlBUVx3UbUH+rnoSI=;
 b=JNM4JtTsuFVGmRsp7PdavhPrGtsVla/TpVReNY4qFnY2ppIWrXTF9M+h67AMsifafs/f5J8WC8onyytO+9uBW72APZUW1OH1xSPm5goWJxcVhfBb4VunAGchB3dvL1mavei2Pxh5BvOsTwcv6rQc5SUcPTZxAvz/J3sQ/zC8rlfpkrCfFjhJjn3FwPAKLT2Ssb30JhfGPRjt264sJQcouZtMXgBRiDDPRZuTXWVORnqXAJ24EsgBQsa88b2k1iY8UzT6YSZXIVqgJpr+k6217D9PyLlr5KiQeSjzLq8W+nRJit9ypGMJWQan2Gd8ZjQv1lXeJjA2bZQZN8GWYwiQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB4km/eRHIk5CMt0/rxknW0+18XlBUVx3UbUH+rnoSI=;
 b=POzxfL/QSCoJk5yPWr0Wp7KmHO80zGbd1gyvb7z4OggzhXfG7m0rJS1kVD4o5+HPmhAkfXHBrl/LC3gHrDDAPfLTqThjfPvE5juGcsOlddmY4G5ueYbNnnTd5fykL1pWz3eoCS3tXGmG/Bdh/Dmwgk+ZnbSxqjlINOcbwYSbdvQy4aGGFBCr2Lxgtn0YtNwdxDdKVZzfJJHB8K4xGvbsH1KGczgzv0pZTBjhFFgp/dOc3pdnieuOTwhuaSQicyvagV+mykdVaw3iRi/S8YxvmIChfZOTK4PtUB5pwxRLfAy2TcaO2lj7s7XI1/G2fcdGyiejP7psFMK11gk1sWLoWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 10:02:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:02:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 0/8] userspace pm remove id 0 subflow & address
Date: Thu, 14 Sep 2023 18:03:17 +0800
Message-Id: <cover.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 39eb3c85-8165-4a2c-5bef-08dbb509bf75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SMlKAZmpcKbiWCzlqP+xQ5lEN6ob3yFeZpfbZ93YLLyfGtx1DQYgUStyOWqSGQ6rHzFy8mgzNFyxvrnWxqQfqYNsRAe7oxpb/b6hylZis2xC51apHD52kGVPqMYeA8qF55mMPDBIBg6jvUea/qDJU7YWFrK08AmchEx8qbSP6OHE+kPqvtaTbISzegdLcASgYmfWsYe/57SHwKizWir65EZ1+/FMvtZtubpMoXQc/AZDXEU/EQTDLie0MWQQ+k81EQ6U2PMNMpWgL2ZUD3ahy0dIucdnQx79++T112tmB10GZ9nu940dHnJBusue0HSXRkT6fcwsmVF22vtyYqDr/I8LM1FXsUfg/JrVkm/3BfC6PLuHt5/hQ/NmN09g0BaggA4OJEmQYzD24TvrHuSmRgF9erTaEuYz6FisLTXinAQw2xDB9jjy5ansj/Pk0rhdVCPF6O7J+wpXRFVvGluv3a2NkCuSvh60yMXdw29jL/LD/6zOHZdkcG2OpHP4+2Q9mfmowKwiGRWwzaG48Ei8FOPOpxWiNGxOXMeaS4PRIuk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(186009)(1800799009)(451199024)(6512007)(41300700001)(2906002)(6666004)(86362001)(38100700002)(966005)(478600001)(2616005)(83380400001)(36756003)(107886003)(6486002)(6506007)(26005)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(8676002)(8936002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yaQgfSJxfeOkYYKrp//0GFvvjg0RvjGeFeywl+1qW+ohq6MBlh0LMZKIqOri?=
 =?us-ascii?Q?iGPZZ1oL08oxQPSa5FmSXOLPV+RNUNlbwS8Hg20aT8FRKAGGNLnv1dTnYBrt?=
 =?us-ascii?Q?mUzC+KNGf13Q5pQCyyv+7zqDLOoFo/0eSmar7GP4PlDVpu0VxYSLVqZ1X4jg?=
 =?us-ascii?Q?ethZxjTF1kD0epe8joxFcOuW4Ko55axTS8LAc7cJaeW2tLYxQoBARscw5jP9?=
 =?us-ascii?Q?/JRUahwVGcFAcrnZ/fUiXNvxcqDp6gijnGPsWJI8mJ8nMUOS8qyYTsO7FSBc?=
 =?us-ascii?Q?Nqf2sy5yUjI0bQ8uoT5hdbTjPUxS2HgMhOriO4O5SHIMg+B28sR6x/kn5ge3?=
 =?us-ascii?Q?rQzsYg78jnIoHNXjmWU10j3ZLzjCNROdN3AP0JqTU2PYmfd14L3RVsdiuQGc?=
 =?us-ascii?Q?fI6RHGO1asIurItBdB4bQzB1ivJq9RVGIET2dAv5nb2PfUPDq4NWl/fT6kr3?=
 =?us-ascii?Q?MUBckhWAVpRktr1LNd7E5jQBYtwZ62gbRuD+hOdQ7VExQnq9ihkwRryyBZkc?=
 =?us-ascii?Q?k4s36IU1h3aRrOFgt+TeNlcyF4sxfAHOyEmsw/Qyq6shb2PnX1XP/TNd4oKs?=
 =?us-ascii?Q?NL9yYg1GSOVpzuJ4SGIgVtOJ1blbifWJW2WoCShsEGTNxtok2TGs2ZdUphPE?=
 =?us-ascii?Q?hZNs34J6vLHAkZnH2foYZfTSBrlp7tRw8wJLZp4+O5uQy9o8siMlk/PkP/JA?=
 =?us-ascii?Q?jfjrr/+5EcjswlSPUpUYoy8PK0lnZLZeVCiZHrBxiu9+PRciOBehftsos7XE?=
 =?us-ascii?Q?kFVTkbOt+KMlgfcq4+GdHhOhZIaaHdXWkkHV9frEeXQ52IKUIsGmXTh2vVBb?=
 =?us-ascii?Q?5mlkmBGDwsUHBG72ySiLvNrE2wW5cZHGmTwR7V4GLcd4AVZ5+AjnIehsVtof?=
 =?us-ascii?Q?XuInI8fUWuBtpe9VY5zDKoEJn5frHaZ70io5leO+GWjA+4dZy/u4MenbeQhs?=
 =?us-ascii?Q?givbqBuJH85DnWuSARx7WNwvuNPQSeImhqRAh0F2S9rmlaSUaxgm2/IykigV?=
 =?us-ascii?Q?y8l+YJsrzHQ0o1bT7Om2Hh12T2K/H5Nb+LEEVy25NpIy4Ns+MalfUiuLdQNG?=
 =?us-ascii?Q?cUwRxD+dlx/oGw4s4ExTIF/evvse5qJllo7/2nKrNLOp11Q+Mb9NcB7DGpS3?=
 =?us-ascii?Q?AXOFLtMTPN1rhlAyD/PoIc9WpTF71uQ7+pW+PNt/md/FPexYQZMT56FiMyVr?=
 =?us-ascii?Q?SNmMWqSXbItD1RE0QwFf1heXnHk1VYVzZQJegoCiFJa1b8vitKmZEYzkH/5U?=
 =?us-ascii?Q?ljSuOoSp9TJknP8r+htF0nq8znV/xutebISiEzUADG2zvKjBeXqsrp0fMeps?=
 =?us-ascii?Q?y0u3Ubdkww0Mz7BXbOKF3D9AdFMiM2tOCgAHQWVbUDPm7zTIpBZnl9nCjJcx?=
 =?us-ascii?Q?oYzBw896Tz4CD6QMeUFuJB8TC14XtfMm+1PEqcQYXZg460UcC9Nq79iWoXFI?=
 =?us-ascii?Q?Jz/GkHszTMeu3eWTKwNofx+WGAzMotrRIaAd+bx5F8l+j3sbXszcR5tnwKGp?=
 =?us-ascii?Q?3V4BaDVrz821dUdP+Wbh51QfePUiY5A4vAAVeUxwQxbpcx/AXqdJmxinvktD?=
 =?us-ascii?Q?3SOI0+9pcGXZGVgzd/vpVrc4RGE7r0/8ri4kLK53?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39eb3c85-8165-4a2c-5bef-08dbb509bf75
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:02:47.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlXAaSOMS1u1qkRyYv/bBVvvnjTIAoAakOmml7HdTH2VFw8qWjzZ3+4hSXPtG+Ris5x0KpeLFh3PxntMzn6gwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

v8:
 - merge two squash-to patches for v7.
 - address to #428 too.

v7:
 - move evts_get_info into mptcp_lib.sh, update userspace_pm.sh with
   this helper too.
 - drop the last two cleanup patches, they'll be sent in another series.

v6:
 - add a new helper get_info_value, update chk_mptcp_info(),
   verify_listener_events() and pedit_action_pkts() too.
 - only patch 1, 2, 4 are changed, other patches are the same as v5.

v5:
 - update userspace_pm_add_addr/sf helpers.
 - add userspace_pm_rm_addr/sf helpers.
 - remove id 0 subflow or address will send MP_RST, add chk_rst_nr for
   them.
 - add two selftests cleanups using for-loop.

v4:
 - add evts_get_info and chk_subflows helpers.
 - split the selftests patch into three.

v3:
 - address Matt's comments in v2.

v2:
 - fix CI errors.

This patchset addresses #379 and #391, add the abilities to remove id 0
subflow and address for userspace PM. And a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428

Geliang Tang (8):
  mptcp: add NO_INITIAL_SUBFLOW flag
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: update userspace pm test helpers
  selftests: mptcp: userspace pm remove id 0 subflow
  mptcp: userspace pm allow creating id 0 subflow
  selftests: mptcp: userspace pm create id 0 subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        |   4 +-
 net/mptcp/pm_userspace.c                      |  33 ++-
 net/mptcp/protocol.c                          |   4 +
 net/mptcp/protocol.h                          |  15 ++
 net/mptcp/sockopt.c                           |   2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 221 +++++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../selftests/net/mptcp/userspace_pm.sh       |  87 ++++---
 9 files changed, 267 insertions(+), 112 deletions(-)

-- 
2.35.3

