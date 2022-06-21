Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50057.outbound.protection.outlook.com [40.107.5.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FCCEA4
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 09:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoXY3EQD7s0gUMDskxkd1/DippXe0TnVsSn+SyIipf8DekRCXvxlRk8FDoaq285lQabx7ley4KBScKlCPuv79KHJnyBNAY+Dqse3wVY3pOKmDtz0NaZ7vhKWQvEwg/gFVPwCu9NRIszAVaxlcKO0FYu9r59gOjdbfRZp1ZMhxitxj2zFDaexG5BQTdktjNZE93aS2o1B/mPNVVj8jxBqudVU9BsHGBbJpJf1VoUKBfnKD1eclHleyw+6W+6XH74uEhqTxDRYLK3vgiwa45WzDnVE5D2FAPqFIP3cOgDgNPrg8eX3fUWjvmYjgKeM3x++KglNpQBCH4qd7XzGyomLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpekssJYee+jkLDteMS0kFF6mjBIEHN9s+LyApC93WU=;
 b=iHnogoGVrEZ7EAkdaBCoaVnqkW4Ycq1p9IChLTdVM03ImbGd5NHaUzGWlCVgA6/tbk1wggzqjVc2VFQdK3pDp35dVga/Gmilm9UbP9U+1r9aOftow1SYn2KkRduPjX7Z/vedh9FwoamqdVy0oqSmjvOFc9xcELMCw25Bl+8eNcKhX3nVjOIGiko3n1ZdY/9iSdKXxJoIFhIpYBbBgI9afRZKhlK9GQ3wFBJ/q2Dk1s1SfEgALcGGuWBxtcIk5cjrvTtBqZdeou0+aoQZ6simmr1GKcU3cZ77Orj3Qc3VUJHuZzvxD2hxNf4RqWcGIZpSGgoZ2JZgPpGoR5YEzYmAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpekssJYee+jkLDteMS0kFF6mjBIEHN9s+LyApC93WU=;
 b=IpMjmC8vENcvOJxZOi/yxVfqyi8XxyOIde7IRM7VeOMXtoIMD61v/k6yBcCWx/eDnPUqgLAbrw1k3HviH+7f1YmxAp4qi7EkMW907qKU+gg50Q6Y0yTocAY9VkS11dPGqrelQpNTjkAZXHHuUqavXY/aO6LhUuk2kh4T0OCj7YJHoymxCmoUFIAPiAvtVj0UjxJb/4uMJdXVzYHqrtkaFz9GtI9xvV3+zDF0oREuSIpOiT61vxjIFlu6KVc6rdeOCSZ9XPSqt74wPYZ7V7byZEc6G1S+MDaOEQrCQDG/dsboCnVgzVGiZ2S62NuxgM0pmLpI5CeMSUUFIreKXF8GUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 09:54:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 09:54:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 0/5] BPF redundant scheduler
Date: Tue, 21 Jun 2022 17:54:14 +0800
Message-Id: <cover.1655804700.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186ac868-a24b-4f03-ca71-08da536bfff4
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB9427256AAA75FA95996FE53DF8B39@DB9PR04MB9427.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0LZD+9YLi2QLuRfcwJvoiP0uxlLsCVH4RIvj8q9XPPqLqDBz9xbWrsBZp9wM4Q8NUBZgqva6OnMMohJySgt2agDC+9Bmu6qd4SLnx/xieYHcTDFf5Y/QbDZYCciv8raBjzmLwYKChpxiP7OgiDISvpMFzakktW1St9zFHFANl72herx/8Lpxd8TRQMPu8/D27GXeIuDrdqxt1AGsKOYDcEc71qe+2/7FjZBk0RnMavSYT6uggBy29Ftq0W9H697gKR+3GDZFKJnbPoZy1G+pruCA6AReAo94qJAB2z6GkIMGQcwmcOQu09oJpvntET2gMTeCHfcfYDOUkznBn3D7SSyYkKQbj6S68bYOm3BrB+g1OMfm5ALZT+JN5sop7R2JIle5nloFSBcn/OJiFzlndA+P7kbxJpVmk0TSH4RaHBciF+okjbRKwJXpdGCZAj6GPH/eq1cAIJMcSc2UPxl4+UwXfEuXRo02L3uTEylvIGTAFBees9qozU+6rLCbJUiPPXv+LB3loMPGJRsYgUIZSENvjEdTjSLBNhL/X2o9uZV86UC0f5kpSA9IZiUwO2gzYuiv52wzGwdIeiuXuYjfbUZ3HHmlmHNzCbHd2AyCy7KOhPCvtIWo8WkdMcqzNMTZYF/lS7JAw2iSyX0KsLCwv3brSU+fFlyBWZ97vXBbwcnQ3urwK/j3DMPjLoPWi8gZkCUhsnTl9JP8icuWrnafZT9SluSDiNCtSRmvVaOrPn0cEtz2sbCKzGBefacfZZM2oGqWBD+YqRCzg982UVTjDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(2906002)(6486002)(83380400001)(6506007)(5660300002)(44832011)(478600001)(8936002)(36756003)(38100700002)(186003)(86362001)(41300700001)(316002)(107886003)(6916009)(66556008)(66476007)(66946007)(2616005)(8676002)(6512007)(4326008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M8CNEDJ5SbRbYGYTOzA8nK0j+UcUbUpXdC3ViLRxYJuXSrBplnSdu0meUDg4?=
 =?us-ascii?Q?DVihe4TotU778qQYCHCV7DRln1YCB+SAgY8rRjiBHZOIeBEB/WZLfhkg79pJ?=
 =?us-ascii?Q?wUrosjS9W7hW+/ue5vkaXTzQW8gRC13hBfw3rh2RzkG9rY5FXRzfHh+pbXWB?=
 =?us-ascii?Q?pn3HzwiVkeIUTi0XmdbUsCwItMSY25jT7ksJUsAkmW4M/hyrZEyhnAqC0aM8?=
 =?us-ascii?Q?alGESzq9YT1r5ga+uszW3VVgpaMPSKx1W1px/If+ppxAR2Bjk5fhlY2fASqw?=
 =?us-ascii?Q?mdi8WnPvkbXTfR8JA7fvT+TJniA9yVm0k/cTjMryxL7bwVjlApf+Zmoey1GO?=
 =?us-ascii?Q?6e5LY0M672ezexazbmeceoWar6qFbAAlF7/Rs7bSdzCWeTUOiYlXaGSs18Oo?=
 =?us-ascii?Q?PgtKDM3qzYP4fVGTeHx+w/GZuki80MZi7qzM0EEKQqZurJ01QKwKOM5IYout?=
 =?us-ascii?Q?3MFFnbgykOV/exQ6lHMLlVP4YmBKT1ClfuLXBShx/6qt+keTLE7DgdlkT/7l?=
 =?us-ascii?Q?EyJrN8rZboOU5HuB0AoTQchYryKh1Cor+hClIqoDZXlZwJgVn9ashtyfG9+/?=
 =?us-ascii?Q?Pk6ORrQsWTDhPMhx78SqLqEHnyAgREf1vBI5zBGdGuazp1H9k4gyMCVTFsOQ?=
 =?us-ascii?Q?a7FW745DYvXU0jAC41YHDw1dW0DeHVe/6QxUxsj9+V71Ry4FmLLqgOHOT30z?=
 =?us-ascii?Q?uzhuRbQdZIIpTqoccxomq+TQlDMUWlCnf/dHOZlA5KghIXWaI5EqtCtuw2qb?=
 =?us-ascii?Q?GEJy9u4PHRoa86wwDN6X/Uiatdr0oLo7CgF2oeCmO1++azQJ9BnqgrzgMOn4?=
 =?us-ascii?Q?WBN587C/YQwgVOW1zFz9nOA2N/LMXnIgDtUyStq5gw3Zjkva7uH0/xasAUIk?=
 =?us-ascii?Q?h6sOJLnuZOdjkYQMy4Fz9x7jdH2AwAvQuPAXuY4jYyXnyl8quYu8zzXEmgYU?=
 =?us-ascii?Q?qZAZU6t85VcftkeJiR2JF8k0RO4Ylmc5yo9IsH56A7ViKFjVq4JgKbArRW7d?=
 =?us-ascii?Q?L2wdBanoqAC444oRfO7zjdF/zd7udo0e1CEbDA8E6WcRtK6l+2JNstYLP+xs?=
 =?us-ascii?Q?zMkQhK7JEz2xXSmLcA12p0Bac+NXjqlIACQz9N05gU0o4oaPIn2zyeS9cysY?=
 =?us-ascii?Q?TDkAi6OwxttumwgAR5xUJtqwAbLl7WJdWG+2hHxgExuGI3JCQv+bOgNvnOfG?=
 =?us-ascii?Q?fZqXKipGO9wXGorz+I3EK4aGtaCQ8oB/9rRsZFtpTnQxvmgn9RqSbbfaOweH?=
 =?us-ascii?Q?/6FuV+uGHR0YP9PC/iVJ3N+8m5oVR7mdvSv0WoWTkg7k4S2m8z/zXHT9wuka?=
 =?us-ascii?Q?+B5sd9bU2ZL6q/+3KBRKBrMHNxXdv/kLwRHLWOZhnZN8XCT7E/hogK3TfWlY?=
 =?us-ascii?Q?nQXSIHC3PNN2xXKsndtyXX7idr2NKb34s0PpsCR4F7frzOL9zFyO2N53qpHr?=
 =?us-ascii?Q?h1kANpcAAtq7fKTmdoT5fuJa08EBdqFrVcso+fEYAwkxehjOtn/b/wmxHMqk?=
 =?us-ascii?Q?ZcGRAHOOx0CCcNdUw4p2a0Ir822EL/YDTG1GgEuFIddBkyFoOmQ+cMDNj+eE?=
 =?us-ascii?Q?fJjx9sUVsH/vMshvgAugQuuXK0nticiiBeV95WVgc21qeWxYUy0aXxqU63SB?=
 =?us-ascii?Q?m0RT+vpQRypu7aeKx8hABJ/uZIxLqMX15KB3wK6JC7I6zSZa/fBGu4qEpndO?=
 =?us-ascii?Q?8XiU6zZ+bvVrN6jafviLGCM9gFPDA/K58jdw8Jn1ujSe1Ax+8lHsDN5gPghj?=
 =?us-ascii?Q?IObs2Ci7lOJIWtdZAWLPHYQLr/RNpZ4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186ac868-a24b-4f03-ca71-08da536bfff4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:54:15.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onRwYAPS6VM4pUH1L9eOPfirtw+wEiu5aS1HxODxXRhRDotJZ35d7VxcH5z0K6rznoetUSwpxfjMykzAXfCG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427

v7:
 - drop redundant flag in v6
 - drop __mptcp_subflows_push_pending in v6
 - update redundant subflows support in __mptcp_push_pending
 - update redundant subflows support in __mptcp_retrans

v6:
 - Add redundant flag for struct mptcp_sched_ops.
 - add a dedicated function __mptcp_subflows_push_pending() to deal with
   redundat subflows push pending.

v5:
 - address to Paolo's comment, keep the optimization to
mptcp_subflow_get_send() for the non eBPF case.
 - merge mptcp_sched_get_send() and __mptcp_sched_get_send() in v4 into one.
 - depends on "cleanups for bpf sched selftests".

v4:
 - small cleanups in patch 1, 2.
 - add TODO in patch 3.
 - rebase patch 5 on 'cleanups for bpf sched selftests'.

v3:
 - use new API.
 - fix the link failure tests issue mentioned in ("https://patchwork.kernel.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

Geliang Tang (5):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: redundant subflows push pending
  mptcp: redundant subflows retrans support
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 161 +++++++++++-------
 net/mptcp/protocol.h                          |   4 +-
 net/mptcp/sched.c                             |  61 ++++---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++
 5 files changed, 203 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

