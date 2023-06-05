Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFF156C8
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5rvlgQ9DB92ev+FLIqhHYolApXcSrWCEpApF+LVe/fisgC49wS6k7aaA4/R0Xeat77IIBpaRcqEEVLjPrgLqhmMNKUzV9ycYnte194YQXSoutQ6+K9ofbDioNLasV53MBEAzjTUTpXVfG6lAz3B13sTFR4qV6LFW/onY2WDq6rX/XyJLovPTSZB/xyi3a1hf2PyYi4u6gUMTXprhwgaEG9GUofSfb0sgPAu5lw+tvViXuvfBP4AWBPBhX5t8cuFgKyrPAMQIMzX8gW6Vzu17kbrxMTU5ULiMIihltPyvMJon8aRzG5CMlDkedASKg+b0lsBtTSV8KnSKFuqckW5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFb/jWVa/VxyKx0/U4e+HmGER4i6Wb24Hu45ywUOakQ=;
 b=lIiMx1dlwdrH03Ei6J+RrErGq9XSoAQXHeQpeVASUepUsiUz2hzqkze7fmCAs3yhv6p2QVnR7H9lZsY643i8zApEQ3/8KPN9w7YsdVsbwMEYGUV7GlVDDDUSkoFq1/zZDotz6BDO6xde9AQPMPh1CecXbpEekSw8/3QxiRpea6CcU/VNQ/Wf4qJdsWy056Zsc8/5mOCn4U1K3KYV+tedDYqPGUdA3AhqHdxf8oHmY/knLuZ4Edbs325kDfqYr1Xno3efaSH4ghb6rJGMbIyR3h8afqXUN5UC5dWLl4eYgtKliT5VRc4W+pwpM6CxnYtQtaz9eA0Fro8H0gGINHz/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFb/jWVa/VxyKx0/U4e+HmGER4i6Wb24Hu45ywUOakQ=;
 b=dGqQCX0l1h9hPvzjv+XbW498WxMYp3eOHuF4oMnG0XWNHZqA+rGIoZPKabpowtFK0NKgRm4Rb4ldNEdgHI+zQe275J2NEAI8P8uLh+CHlPYzJZOGHNbaGzYd7HNjUqTtUUENIJnaDjcg+8H8320/z5U743YXk/zPqt7TjKlcYJoT5GvMhQXchtu5zuZPPGEZiH++7igU9g2GBUqm9Nw74cbfSQdKALv0vYM7yf1huXxXgPo/unZ85065F0jDzFSzw3JaYj4PjTXtEFrf1pxkP9dp7bMy/68S3sdXSsX/hLxN5vEfxO7xenlQ9cO6o54km0+lxMD2i0tHrR3NXUVlCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:05:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:05:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 10/14] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Mon,  5 Jun 2023 18:04:05 +0800
Message-Id: <817faa3bfc40cccb479673626ae0ab50b846fae2.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ec1b94-ed45-459b-e08e-08db65ac6caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hwsCDaaX9d/WHBmXcHQZDKz8jTUs3TFHUEgFTjWUY/q/w7aUFmO6sSBZa96dHk8YEqYMbsGX4BfEt5WUAGvBkPOvXDbcvO7OifC5+Hxr1Geg3ilRPRcCFj9wJHvpCla76Gzcy7iHA9uGBIYUQqZU2Mp01W/4NOiLgrnwih1B1F3se8LW/SxwrU6knKmsqUmbRp2qua1l2lLAV5+COwNZkXVFb/xiWCkqvSwmPcv79RTdNHXKrkVwwwr8Yezbo56R1/FQ9hgE5OAjg0mLMo+sKoC2/84axP1zFXNJsV0GSjYa3MMCpB0/2HAgcgpV2l9vagYlADXgoaclhXegbRxvTWYxwJeMi69a3ApT+LrqlPC3ki1HqEbmGv/LbsJsgJF+AZnxRQvJnrB9fEqYEZ6mmCjPTjiWETc2fpUcDd2h4qiEsPGVrmvJopq4+Cx0hBtZaOnVrVp2NJPrh401iejLx0whXvVjHPgXvDhjdcyasi+KveVhHKOv/mlYZAmwfbogKVFrh4mkNDZQoPCYinL+SEm3sNzw6XkkktfSOdE/bEBCkJf0mZ7YW4spiBE87+mK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjiFr9oCpq/NTiX+67JxLdPQNHgS+50DQJyLGOc83DkDs9715gEZ4+10XiSz?=
 =?us-ascii?Q?TeE2viA2ge5NIWzpXoxevfzyI+6KJ6bt19HMV2xqK/S5v5qIubZsI9/8gqZr?=
 =?us-ascii?Q?EXjWxreqn3E9XcQAhfNDS7ImuceAW8qnHVZ050EMLWOxbsK5P28gD2CnedVy?=
 =?us-ascii?Q?6cz7oE8n8mVXYftJmqHWIBxPj76GpMGrVJGfRCYBGSYkiPDZw/n7CHVbUk62?=
 =?us-ascii?Q?lmMxlKXTLKWHzS4L529KoW4AXZBgav3MlzVIiNRMPKaookoNYSDdsn7YAj1L?=
 =?us-ascii?Q?1cupYUzXjkGvW/ZC3R7eQdL1+gWB6TeD0+C/lKecPLuphYMBAnBRsON+vraA?=
 =?us-ascii?Q?r6Kpje+pUGmWtTDCfPu1W4OgqTl9nh2KalN9uBqqEEOIaQS/6jSL/vhxA7sa?=
 =?us-ascii?Q?94aTZj9j46vaG/oGvc7fdIBMqavW5VfGC+pv3af/DfkBgzFe3jN2qNe5k5wL?=
 =?us-ascii?Q?h1S8oGzoeAdeGMWU2XX9MW0DbnBZr9OtcWQkHbRha0tTaUOr6DOOssmo8kFm?=
 =?us-ascii?Q?xPbAyKwZ8Q9Ry1VGWpwQAVXgJNwl2UOrXNTUrqrGUtVglVD6C9p51wpyvtth?=
 =?us-ascii?Q?jjZaoCsrTd2elxFwjoGfvP1zF/TIDOiZYxk6fR2naGKZtEICDMcTB+5MHi1R?=
 =?us-ascii?Q?tClqI7pv9S75WaZDSV0AFrdj1agp9lgsMkCKHVePjiV79odpia8SsSmODTwf?=
 =?us-ascii?Q?ezGiMfq0XVjr3vtvAoAgORhq89OEVGWA3hifVa+yHu5Cbxu7yXlwCuJG3iyI?=
 =?us-ascii?Q?//jNVtJGRatF5e3HXIwAPwnjoFgwoIQaTxXS/HNKx09K/9uyxJctTmJ0QO0M?=
 =?us-ascii?Q?Unolr7WxbV2f5tyMFASijBI5aXa1iqlhtz4LV6tj8IOrrP2/erCaYoxBeL6c?=
 =?us-ascii?Q?KqeiXe734ZHZ4AYzruBpG9SPGuf0U2BdHVYXABIYkUzb/w7mGvmWofrsFpvS?=
 =?us-ascii?Q?1pcf+hXi+a88iuJIfk0MDynd6X172Fb9mxoLPKNaYGXThGdZu/8LgUKaSta0?=
 =?us-ascii?Q?9eHGcWE1K7AJBxRK9XwUet3kA6jUlenXvOxrvvmzhM4180QAg6kNhS8wLOJ5?=
 =?us-ascii?Q?0JM+WyTH2ltC7Q3jHIfomlNzD9dbToRmfOA1lQbIbFWyIGGxHYtCbbnJzztz?=
 =?us-ascii?Q?rENLYhfwWgNzfhueMc6O+sDT7nu9t40d7OYKDjzAoeSfzUqnW1sXNwheXFZY?=
 =?us-ascii?Q?C4ccSHRiLQw1hBpEFIqSpWSj3hS7+rouK0OiW5tbM1gL3yFRyqnA8XccLi6w?=
 =?us-ascii?Q?L1uPhxEdkeEpJalYn3D4/bQamfFSnJCfs8OZV3FgCvpRxDS26CsugkqoGa11?=
 =?us-ascii?Q?pBn/xNVo+wfUMN2GWTZOHFfrO+WmuPZfRzveLDtCHrXA4ijxJfOaM0DRf3D7?=
 =?us-ascii?Q?ew2CwAsKWM9N+fduwrCU6EgT8l9I+d0GmjGSIsmstTjfNNiY20w+o03Zj1sG?=
 =?us-ascii?Q?ordGs7ZG+Nx1gvZ2LDKFDA2FTPdWK6xEQC3TZPcx0ML5YgVusd7+amg0dSdq?=
 =?us-ascii?Q?NrAty3avb0pxckQvwlJNRKwy1kL+pM0x62ROrJBCOcbtYmRnhhVq47p/0rHJ?=
 =?us-ascii?Q?bpL7JY+sdWl97bOqq/1XywSQmLg/xGTECevhWudydRCKDR2h/4rKC3rkn6P4?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ec1b94-ed45-459b-e08e-08db65ac6caa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:05:43.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6VQuIqFz5GbsFB+Y0xm5VpQmdz3O0eOh0I5Fyy3AMvQkJVIZG4ajqLCYJ2XOVjtpBs7RQoHl125HWPfcLNcMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 7 +++++++
 net/mptcp/protocol.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index de9e28d69c00..bb33f00cdaa1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -175,6 +175,13 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_timeout_from_subflow)
+BTF_ID_FLAGS(func, mptcp_set_timer)
+BTF_ID_FLAGS(func, mptcp_stream_memory_free)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, mptcp_rtx_and_write_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55c2be2b14f2..e416e4a7b82d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
-static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->wnd_end);
 }
@@ -490,7 +490,7 @@ void mptcp_set_timer(struct sock *sk, long tout)
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
-static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
+long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
 {
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-- 
2.35.3

