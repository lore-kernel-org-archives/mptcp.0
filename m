Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D87C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdjabJBJaXezo4UcO+m0u1/lvLCuCfJ5R3rijvBvKBAJRxIW5N4LA8BsNoDRsrO+oRRNsmfbJSEQwTyEODulK/ZcHvttJue9cxFQV0wgiDzbCUNcCpWqOgCA1lNdG3RRCiXJ3mYQhxhBGRO+kbc1kAcOEE7YCGaCk4j5qO9LgPrlzJn1hAff8YEi/wlUm88jc3LfBZGgGXfmPSwTWqSksVIEuGVNvryjQPH0rVD97fHvGcG6f/AntIljKVaw7M6sQ4pLDthTrvleHpojzol48qnutbrUg1KfLe4fEU8ghIHP9rlzPrhUipZbAmmWvMIqEKZ6T8wy7msGXAI0uuOHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMXtrTJqhIrLdzDVnSs4JNzt07M0J/MINIa0pKF7CCU=;
 b=W61W/yYP0xbvCz6B6hE1ERNnWnXiR/BAUSiVtYk9PkdC+6ltPmArMW0TfZvQhJ2t28FTTx/2maJ68F+2NdEsDtQFtDlX5bkhRZivKgToHl1hWjNurhF7lSNiMmO6LDdXU73u3gcDKsBeTTChL29wppMyErDj/b5vqzWERkc/rHHvK/4LVKnXlVowemlAzfXxjlcjbi1N8HpG2uMVwfDEXsxRqQ91rZbbo7z6Ztxli2ZlrSkh9QoAgfnbGWmtSO39m4G4rZKWfj9iQI72xE0aqfwns4KtT6x/gPy+Q473COCnZIIpNM+ub6Irnl+XzeVakVxWwtieDAUlGDHW13TciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMXtrTJqhIrLdzDVnSs4JNzt07M0J/MINIa0pKF7CCU=;
 b=l75jz3rIYteIdWdmtl5O4hMhnP2NXVVtsTtpsYxqgRLN4RPYpEoEU91BWNo79vqa4ZKAnxfhKgOYRKmki+GX3RgaNVgwY7Ens1nCn2VqhCoQinsiCATL7PQlY+DtMhuY263Cz3oJmySbCLpfiYTrbYI2zyiD+2KI5Nymt/v/CQdHZGeWRGVU57aijbe4B0ggxaW9RaR/YdoB3aF5sqtPEJPg1+/ielsdRvZxinQR091CqfJukLeEN3YoD4sxwsg1uFOfIirqOzia9GfsI3Oq7KS+r4df8zQQkHLg2jdp9pWFjUTAIrCtsoJfJGD4qaYPkdLkKCmt+hXOa/JpARlykA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:17:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:17:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 00/12] save sched_data at mptcp_sock
Date: Mon, 29 May 2023 17:17:14 +0800
Message-Id: <cover.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: cafd77b4-be80-4550-e3df-08db6025870f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C/HyQYpdUxebaZC/d/VDqAJ3cchHIFzL4L4WlO9ZnYODiwgir13hz273xLWJof+gtywB+TOAmcohuLu68eAiOxH+QQENNqDvRlzEdyMcdU1EbxuMtHXyTvtuorD42Q0RYNNchoTj8MQ++p3bnHDyApTPJ2Sjqy/kTEkKR6nNnSRzexGlqh41c/lvn20Y9985x+bf3qq9l7G8t0N5ky1yfIaDluBH1BdlC5JzV78IwYQdA6gTgfhDB1N69oQsWrjqwdqZz/FIhPKIhkryp9MWf1JzwQeEnxdpmTF/cGoal3k628f3lvMt5imOLZCYgKD7Vd9MEVUvuX2tUk4dDMHxCDz4P/l53aBin/zaw040tnAY0JEirLMgaqBkfV80pqjPl3rKX5xYAqoxRpAgb+xBDYX/e2xyrKfQYv0av8kmJVdyNVu9+LeEDE2SR2gtv8vNRjWOg1wURx1xDXeCixI/R8OLjyq9OJzxhFaXEyT+5yqmug/HEntjVcqkwG66akWX1gAoM0h8/JRNoaOTN54mVBFWrSaeRzjBJy1eq2xdTrSpJY21CMq2THo4pVRpSGncBDGItzgqFSnWw/DNJMBjdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(966005)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CTWe6vNJAMa88eXcssLsWlZ3lk1J40TNrZbhyvctHMalNSeq5bxN8PB8wfUE?=
 =?us-ascii?Q?44rvdg0RFUtaoDC1zAHMf8G//PPnbPB06xp5046DoBceK6UbST9ih5uNJaki?=
 =?us-ascii?Q?iroDqmDp/oh0YSzAk74sgEKJyHvRxcIqeeoeHyGqj5fn1dgrvkaY2Fusb0dY?=
 =?us-ascii?Q?+WCARdjTuHB5ReAiaEbjQYOnO2jEXMuJ+FCd+PqGl10XqONwnR9chRcXJKP1?=
 =?us-ascii?Q?8NR7k36PYf4XNjoj3xE1ef6Fn+RRg9sagnmSRgEFmrkDrFgM/DVQRVZNOAOX?=
 =?us-ascii?Q?7u4J5a42hAG2AP46Yho9zqUQM8IySx+xaVGzZuRjiTCmjPsPGoJL6sNXOO35?=
 =?us-ascii?Q?6DZ4Kxg889fI22tk4zglTiOcEQi2JWTA7rfGNoX/NvPRZqYcv5vj/oxL6jWb?=
 =?us-ascii?Q?PbMinvZ72LpnYyxAI4pEJUrrpt01TizKd8bVjNYG7J0EWdU5pb+U8NNydFBR?=
 =?us-ascii?Q?k7yStWKuBtvnEFyVBAqIsGNrc2lHnxsKgkyx+YXd7miFBB29sehY+qIKTvRH?=
 =?us-ascii?Q?m6p6qbbJEsGnB5qKSFMSI0aRkayLUEtzG8K2zWUBCyxL6dbYG37dOeuPSoWa?=
 =?us-ascii?Q?s/0c+MmW3XAhlXa/pvSn5Zu9WHKgWfY3sMekHN6IvBPL8qIo+EDUj0yMGt83?=
 =?us-ascii?Q?MKBUhfv70gucvENUvQPpedBPAztURvPyM49RTcLtLG6nIESBOK1xyxwU/qlp?=
 =?us-ascii?Q?P8Rzc9cd+lwUQEzq7UVyKVB60hgVLLZ4pXd4BL9crXVJtX5/g2CivrxS8QBd?=
 =?us-ascii?Q?MVjypQAE7Us8H8We38QR99W/7jxathcgnmr/MK6NHCKvUpmaKDwLX73KmPna?=
 =?us-ascii?Q?D+Bs0L2+sfheGloDPQqjEoOi0NONr9lBvYLFP9Doio4zptcEb3B8lxMwP1U0?=
 =?us-ascii?Q?XHO2yQgWxomJFB59+e8dxCBLnRAEyQlpg9ks2FfNuF4gjflpJWFj1AgwLH5I?=
 =?us-ascii?Q?bS8R9/NJuDGGLjxHg0hP6MvxXo5UKMqcJVBx6OuN8bHfWY9IVmH82PmPxDlA?=
 =?us-ascii?Q?gS55uT0iRNRgYmV4hGRGo2BbOmS4Pp0wX30rUgN12LvamtH6OSIBCYE00/mZ?=
 =?us-ascii?Q?y1B19fQMj3zNdqovYf+95YsIM5HgCPg2eyvD+o26Dchs4aDcIDjckzH1M0FD?=
 =?us-ascii?Q?6cdZ4VuXkQqMd76JS2W41bc5AImcFHDGfuhSjEVoiHUi+s2OG1l1n2XmDVKn?=
 =?us-ascii?Q?P2ZJR1nyGCaD81M8mfcH/oQVH5ZM2XNheXaPcrVDV0L+FbEVOtmSYQwRkUGL?=
 =?us-ascii?Q?HbCjX4i8FnBrM3TxeJT+hAzP00x6ppf8oEKVsI4YidqVM1kx8FMjHruBKEvV?=
 =?us-ascii?Q?sa7k/ysozh3ApjVmJZW7K6TrQEbbl7Iko+qVAcW+wlwXZqOiDrecxWqE+iS2?=
 =?us-ascii?Q?fgJqimBhpqYfEv3epoXbVLvqZMy1GI9ia1N9RfLosn2tLARoTzoquk6bYziV?=
 =?us-ascii?Q?WaG3pRfPqMEFMb+ztxO0WO14n89Y0FrbFEaFWRq8fvL4Ixq6tJMiy6ly6Wl1?=
 =?us-ascii?Q?NreeatUauo2uHtSZz8ZM95D6qFjmJGvltG17azHLSycxMgdnvD5SNYMQjsgl?=
 =?us-ascii?Q?VsafoJdK37o34K/p8KFyANFXr2XZrTaW9zlZ60ck?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafd77b4-be80-4550-e3df-08db6025870f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:17:30.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH5Yg/icphBDgFEXchK3k0D5DK7+A118sCLoOyFLOCCR63U1Vp63qcGZFSyJacl5CeUTygGfCKyc4X+oqb2Q9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

v2:
 - fix this error reported by CI:
KASAN: slab-use-after-free in __mptcp_close_ssk (net/mptcp/protocol.c:2461)
 - add bpf burst scheduler.

This patchset adds sched_data pointer into mptcp_sock to to save some
data at MPTCP and subflows levels.

With these changes, the old patch "mptcp: register default scheduler" in
[1] now works.

https://patchwork.kernel.org/project/mptcp/cover/cover.1665753926.git.geliang.tang@suse.com/ [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/342

Geliang Tang (12):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test

 include/net/mptcp.h                           |   4 +-
 net/mptcp/bpf.c                               |  42 +++-
 net/mptcp/protocol.c                          |  68 ++++--
 net/mptcp/protocol.h                          |   9 +-
 net/mptcp/sched.c                             |  62 +++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   7 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  38 ++++
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 195 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   4 +-
 9 files changed, 383 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

-- 
2.35.3

