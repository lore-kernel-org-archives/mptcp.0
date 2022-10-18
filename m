Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31E4A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoVGvm8MzkgYEgeuETLlxGggRNIY8W1caVMzPNEjRv+uWJ8OTn74VxBV+9w17cTTp5mUlqCW7FSajVOyY1IW8EWiUe3ZL5LIAje9VuHkKg/RxgVu6iY48+kyIlW+VZZZTIHysbP3zlwzfSYsQBBk6jXGwPvbAjVwF6LMAnXrpdpfr2hZbAEB/x6ZxTBrp1w5YvTZS+4Peyf2FmLSWd3LlhkSY8/VdR0MWBtWsBIrIPwu3IW3YKEEYXUuPvWAJaV6jIcchmpNibKA6OTZKWwbav91KQJSd/V3EvIzdJHXtLiQdvDdelc2l+rhiNNXxU1q5Y8vBbVf/luRM+9lxzLKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9u7OjXZMinQHaxwX/v1/FjCWTO11Zd2231s/cbee1Y=;
 b=exHd2SCEQp1uWxravMrvd4xdslvaqYovZVbdlU1LVYRU2uW7SYXKlk0oGpk+gFNgoQggzOTkYXwKueaQmZNoG6zDJCQw7IH4NcWRfCfUY5FO8nzG0hJNScs2TOCge/CmAgf9anGYQrmAJgRuDjwQ1wBnKajGuuKDEnY9dMED5O/Ibh0tz+DFevYVQFmbV89FLVAgITVh5jpKHCSqClQrmFHEAsTQHPe0PkdBwU/R41SF9eG2RIO0hqh3RyCy6uomu2LAOVEK3IbCkd/XeA/WWFbwpmwC0OQD7mIdDi2zKlJWVVhG2kkCo4hxgWLWvDX10wzVocPiBNI+nJZGKo9Djg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9u7OjXZMinQHaxwX/v1/FjCWTO11Zd2231s/cbee1Y=;
 b=iQFnw2yczyOTbQs2ulGYTdDTJ2RQS7cYdFVIcJktaFw3sOEb/2hjdM1eZtIZJ7BmpJpnl5FcN4rqvasKGNYx9nHaGWI5ujy+rFMpu1VmQJKPd8v/9s4/9eBX0fHtLzS6m0hVWt0QaKdhSaK5t0vIu8CEcx84TxlKPIvTzatJz6kcMAoy25KdVJKnwVRONx24fEEBcuemsFuwlcjc5QowBAFePvdXrckyBicmEX9uz7J9IUIM0JtNshV9kSX0Gr5hDN2ox4GVWGRPuBTjtjESUPDssLpB0wAQzkt97CEatXa9okmqJVnCm6O1yZC3FfUz99QfgJ4ES+oT01/Qy6ZN2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:03:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:03:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 0/4] refactor push pending
Date: Tue, 18 Oct 2022 19:03:08 +0800
Message-Id: <20221018110312.22510-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f53779-9901-42c2-ac27-08dab0f860ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OJgIIbqRuMvNMS1nKmok1XA0N/Iestwg1M9Gn5LLk7CijRK8cBnyonmNqSmFvkvnMUCE2lzmG5HyqWV/uGPiZknLCw7kpUMS4IRmTJqK4Kk/hXQMTsJLU32oq+FJ9PT1Tr6cGzfRbCuX4WYIMGZOsA/VCqXhC1rTf2IRK53+0NfzqciEpLfMjBilQVDBBVZaSjilrj2SFu6yAWWrQ3Gs+9UHB7ZnzaIeGolTHEHXJFlKtiEPIDatEJgvGVtIUzE0Qji/ITlmsPXytiL4ujSnPiep/9JI9b+RYU8zKCHD/N022QXeaH4XJuEXx/OuHFx7Zxb1ctT2WfYxhP08hy0JlH9bZvOr6S8vxKNoaZ0Ig40TrH5zT39e/t+OWMICOMpPuNm7Fyg+x7jyAArwXJgxNoSArSHOkekaOGzrAuNueuZZiURow0Pj2SO/n1SwAZ5y3JNQAk1nETawNzVarQGrnytrxj5DUJIko1LOjVmZXtsnlTYRpRNmFRL3XGH8JC7NZEYdGWFJ96KRakNMTKEsDiG8q/MKeWK/5pmK5y+scjMjvIQHUnbUVGQaaU0R1aiIBz7WgNJnrkb5nHwZyg/vd0Ed7aZMWPcmvdb6pdZMFwnAwFMgV3pTdf0VaPqG0nPTwI6Bw+xeIUEAYj6skLKBnyVE4TQmFfobvirWSRG2vS9W+hhLpbElaI5jm8VC2M7zRg3P1NBiJLoH9Vp+qkfH2Phe7nnHIRDGlowyfKKrL0cbtB5+fp6Qdks6wgXN08bo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36756003)(86362001)(107886003)(6666004)(83380400001)(38100700002)(66946007)(66556008)(8676002)(5660300002)(316002)(8936002)(6916009)(44832011)(4326008)(6486002)(2906002)(186003)(1076003)(66476007)(2616005)(6506007)(478600001)(26005)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hyd9lakm7BoUEVoZWV/eK3GN0xAxQ3Ojc19H0sLk5n5VZsMXdJSmhFzBt6u2?=
 =?us-ascii?Q?vUpJLL4ybwTCEtnC9L2b6ppocpdMp+uJ01PZNtHBWIgIE2kGuQFIug90N/ud?=
 =?us-ascii?Q?k5HCx5sLb1UnAMPWQ+YOs3MXsHWL12JgfxPkbYSxjA12g0oErp0oIqeRPy+e?=
 =?us-ascii?Q?ZBt6gv1X8ApSFOviG1WVpXlwGo8XlayYOlstpYgFppbsKAMkAFgScO1u+b3J?=
 =?us-ascii?Q?/rAalseagkiCjjpOyj1lg/XkC9xd6FKKQtg0BecOv6z1T719hNEX3DeV3sKV?=
 =?us-ascii?Q?C3sGFigAj/d/ATvb5MQQqyEkiUwUuBHPRXiKhUwwDHmQYcPbwDLBwjQM/q/L?=
 =?us-ascii?Q?zyCVZwszzYt5tmMke3SoBJD//meZgl4zjWB8KfMTAkvaUTuQRsm20WWjIkY0?=
 =?us-ascii?Q?c0HjSNFxCSvezQU3S0DDLXHNUp1BeEcc2oSsUdXnNbGVYzfxqEP4vkJBoKow?=
 =?us-ascii?Q?XFkFvNWToMssf5box7Lqe/tLicdywsstfyzOSgDMx8f85iDGBJjOYiQqpblL?=
 =?us-ascii?Q?TAhUUeMX/Oxeh3COCfAWqkFlmq6gHKMg2cFUTduqWbEei81bTSsMGQqiIl0z?=
 =?us-ascii?Q?g4JoH6BNuxnMffX9y+HciQEYzu4ODTm3qhD4NR4R1eKZoUV6o6c515KWc4CP?=
 =?us-ascii?Q?0SQ0Ttbxpd65c4zWJ+S2ionyH+3YBDSg2Hb2jkMlyqhU1uKDVu0B9V/IJDpu?=
 =?us-ascii?Q?Ij352FWWEzxrFpAIAsJCoTMroJNjJSVKv9nIdDhDg+vwRIDFQmLt59n4pLz3?=
 =?us-ascii?Q?vmO8t3P3TdIJ/PkZPDxHugTJkfysKJE218uzvTcAExCsg+Ql61VNZCaPy4ZM?=
 =?us-ascii?Q?V98ECRPvKAjIYq8Ww6Fqx+OQTKg4bUJpzjxYhtWx1+wdHTdVA31D+lTOt0fc?=
 =?us-ascii?Q?KST8r8YrOSeFu8/X+5yQq0dqHVDckcTz/1kwmRXsao/VRmscnSYGgzA3RWor?=
 =?us-ascii?Q?KzjkVjgt2PAGcmyak/RdJSoDayIpGcIMdaWYYPbvo22PhEN92YoIaybYvtws?=
 =?us-ascii?Q?3stYhCJ4y7od3JgIpSTS+DR4Z174U12ViQt0L3KNDyS3QWvxewQc4ZOdvwtY?=
 =?us-ascii?Q?1qMYzp1jtVHEQxHV0DA274e9kRfPlhQ9s/7n/hvvdrrPyxUw1xlZG46uwLes?=
 =?us-ascii?Q?bAQY43R0B5Uq7FugVyet1r8pJhjQFdZvfRxxmMP958NWHsNImvB++2C/I88d?=
 =?us-ascii?Q?f5hDXilJVscVG8T/Lj7g7bzJO+muwDgRFOCJzYiU3xs4RhAo/qZCIPx6gN7T?=
 =?us-ascii?Q?eahWEEGLr4k5kMEMeoqeZx+ulOx1alcMLS+Yq1qYup8CAyKJb9QaVQMhIncG?=
 =?us-ascii?Q?WQ2XNdPAkl39WB/gTdAtOkgLg0NCWC8/3hd3MhoMe5aTToRvIgJY2bqoR+WG?=
 =?us-ascii?Q?tKoDyoPekmdSH4gNpZC8yoB0mGBFGH9JRXBNTiHwaxQ5PsjyY3E4dPps3ORJ?=
 =?us-ascii?Q?wxhzvSMEdYo19p+rGHbR+RuaGKhumrMebAWSh26iFP+aSIoJpejSe3hVYQFQ?=
 =?us-ascii?Q?Z2eODP7CALI6goDv4tNI/e4ocKy87DWqR9Qkx8bAzi69XR3B1oLM4wdcUKpb?=
 =?us-ascii?Q?HwZ0AN+8N6SdmSHDEqLgMnLUCV9aDYKNY0JVioEd8myYQk07s2G+xO5g20u0?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f53779-9901-42c2-ac27-08dab0f860ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:03:24.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpggby8jcPKmpxqBsSLOkOxkNqppHfvV4mFl7AG9Yog374ZrUO4UvynW9gK6A4qmIinHyUIncbSF/txBem8EHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369

v9:
- move "register default scheduler" out of this series.
- add missing "first = false" in patch 4
- patch 2 could be merged before the commit "mptcp: add
struct mptcp_sched_ops" as a non-bpf cleanup.

v8:
- merge "register default scheduler" into this series.
- Move "multi-subflow scheduling" out of this series.
- This series should be merged between the commit "mptcp: add get_subflow
wrappers" and "bpf: Add bpf_mptcp_sched_ops", except the squash-to patches.

v7:
- update delegate sending in patch 10
- rebase to export/20221011T063543.

v6:
- drop all msk->last_snd, add last_snd variable instead in patch 13
- fix lock_sock issue in patch 3
- merge squash-to patches

v5:
- address Mat's comments in v4.

v4:
- update __mptcp_subflow_push_pending as Mat suggested.
- add more patches from "BPF redundant scheduler" series.

v3:
- add a cleanup patch.
- remove msk->last_snd in mptcp_subflow_get_send().
- add the loop that calls the scheduler again in __mptcp_push_pending().

v2:
- add snd_burst check in dfrags loop as Mat suggested.

Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
remove duplicate code and support redundant scheduler more easily in
__mptcp_subflow_push_pending().

Geliang Tang (4):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: use msk instead of mptcp_sk
  mptcp: change 'first' as a parameter
  mptcp: refactor push_pending logic

 net/mptcp/protocol.c | 183 +++++++++++++++++++------------------------
 net/mptcp/protocol.h |   4 +-
 net/mptcp/sched.c    |  61 +++++++--------
 3 files changed, 111 insertions(+), 137 deletions(-)

-- 
2.35.3

