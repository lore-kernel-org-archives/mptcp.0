Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8A13AD6
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSx4n7sUa0LAEBzfoVIpxHYPAMWOMpN5XLXQq2e61gFVTGcshopXVlptBELJwCqljJRJPIAf1e7L/ciiLp1/yRmluWbvKw/82r3W3NXbF9O1NIMVdayC63z47KrPyuB9tnz3UPzGqEVUXMaVRL1XleJBHaMwMiXZmAAwunIBChoNs8jRZk2PkeFak5X3xVk9g40l9hsl5MDB17tCT50kLkDHJqp/Kfz5fMyOELZWIGZsGMGS8gVS5/I1mnsC1RB4uMSVPCt3CpYZuCG4dUdgxqYp9Tkb1PIAKqPh5g7XUAUP0cyW/bB25SLD4jqeSWe8Ui99dHdWQ8yG09E/wmhCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NQoEtDw8hfPZdmVZJNDOnN9YUxD9lQ/XhbsKM3JQk0=;
 b=OCNbrdePxFn7e7VpSxv6o78gL9jugL2xytQj/dHIURNvGfmml96o43XMzFmnnbUxfafNf4j54ZdI0uuAq4NIo92pO6anGl2Lzwov2CL17yOz4oXlKf5LmuQ3SujGpYV5ORonTbDH064tUAm2GGcIi9UzKij/Ggia7nNayEEqBA8/6WZprZceEg8vApWy8T/9XwlS2IuUOenOgp/jNQOfIZHIvJDS6rI1nP4rm03L94pyk5sRA/LaOq/28fW5PNFLtGSJSv8EVCLvNIoxVMhDcWAIjk6pnijTtzMd0Amyr293C556RVYZVviua7zGm5Hm4Ba6P3ay5r2UOJn467mTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NQoEtDw8hfPZdmVZJNDOnN9YUxD9lQ/XhbsKM3JQk0=;
 b=aHUeDbJMMuACEXwiyUEVIHSi1uuWrF53DBiOaNk/anWMehwHpTZcfIK1j68q7EwLZfAb7xw1ZEilPq7yqTiXqcxaTsYyNN+t3UfCYNmVGloyv96JtNKM/+LOGP8W3f1K3QuJhUL6QiO7ahtvT9W7sUBxCJ8jGhoLUmJj1Ncov8T0Mk5aqfboouLSCVOA+PsoUib2PVutEaodC0CYcz7MCJKMWI/Srim4hkXX0ofqf8DEEuPCeqAuDUrWphOot8r1dSI6cICR+47YMIFStkjGhkZM7Bl+bJK3w71t44QJ/TFtmFdmAFtlOsbECsw+vDbp0LKE3c8Yr9OiLIliLyt1JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:30:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:30:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 7/9] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Tue, 15 Aug 2023 14:29:27 +0800
Message-Id: <be56041e2c3e729ae13a61a3fb621bff97fa1d44.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:405::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: ed01d293-a142-4504-3bb7-08db9d5922da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kjfomkdLMtPl8xfHGR/qIlspxYkh5mUo1An/4Q363apMaUl1/VV4FJ1ObXPKzPOZuWPk8NA+ZX9/f/zetGYNn89hbrbOlM5hpALBPb3hgllPQDPjIdFF6AGA9oJUZ8BvYuL9TkMtVhEbNrt3c1T/MnZfW+IINS/gepb9d3yQXd6LiKM0LEKwTyA93AoABEnRYhvlrW9An/FyuEVg+BEfXcd13bRX/ZAp0w2PgvRs/tLQ3iKTPjVWiViPw/pDgyl5jX7lD3Joto0gsZjtkng4lLrJDYNq1mchjkPwYuLdL/zBRvSHf+HrNVWCmNMJDseobkEAY02hNMMDmHEh6FajDY0fb1H3JQlXKjHqDNXQYYbzL2ZOmXN7zDWcJxTTBq+5BgF9aMb4MZYqaTjL1w2u1gX+txX6NpXF86N/KDq3CJYEm18c61RgT9dmNAY8qeQYQpRAWIV4oCpPKoteaU78DBbKkpyeQdBiaLLeG8SXGbBBKdvbUkwnTStdu0MjQ1iTH6N2I2DUy3YzrkQDdZbKwe9w76Lu4qxw/vYmHIHkN36usxD6ze4GbMvaifVHlDTOB1PJeg3/mvIUg2xnAUwEX9izK0hVDwrZCMkY5sNwPZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(1800799006)(186006)(6486002)(6666004)(6512007)(478600001)(2616005)(107886003)(6506007)(26005)(2906002)(44832011)(4326008)(316002)(6916009)(66556008)(5660300002)(8936002)(66946007)(66476007)(8676002)(41300700001)(36756003)(38100700002)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fw3rkURT6qOiNNVR2yny4vVAHDq2ON451hdn76NEDH9UD6lFQjXRRUIgdRmB?=
 =?us-ascii?Q?m4cfLzsaK+ULXAYWLbjmAPP3H8CLv+c6SdpytKVAAAixBKaUsKr7IEEj8229?=
 =?us-ascii?Q?27CTrY7bq4ELGbe2StisuTq+KIfMI2tp+7ktxorPQTXntJoT9qZK9qwEHwCJ?=
 =?us-ascii?Q?6CGIN4Fs2RL2x+OxoSxjPqeisgVEqtiW6y3Ia0p3vfysUYNBxxTIFiw9ftms?=
 =?us-ascii?Q?P2YyzF9JIA9hZ1g5TbkSwLPfOOqKa2DxD/yfIDkpDN0mzduIwqOfQh5Emp97?=
 =?us-ascii?Q?WQo1DYL4SjlGguAFGEn30/23+txL28eioo83vFwBDTkcRRyYF9pIjLcU+co+?=
 =?us-ascii?Q?kRlthL2drOjTBN0OHND84hCmUCDs+ypfsThMbgHGxOVOJ3rhU6b/1N6ZlwhF?=
 =?us-ascii?Q?Fh8BPAMFr05Q1e6qqTJhGcTlwqhpGvZJSUy0kckAC5UbbBTv9I9XYRpGoFky?=
 =?us-ascii?Q?IPbzbmUfRn25/guBlyomq7N3KJaF5UqVa5Qzo5wqInqdjSq8V2w3sErLpFbD?=
 =?us-ascii?Q?QGDikawqfn7MYO9JMwQK6EY2gA6HTZQSnv6l412WBCdrImpY5goCnd4B+WUj?=
 =?us-ascii?Q?Ivyc6vNTqy4cvcDyvy8JnAZqfW1lk4XzKnGHnjsd5bS2p3CImZO8xeZDuKTd?=
 =?us-ascii?Q?RLSoMPPPhg/T8ZyljTp6PV4RYQf71bqkKw6fY+sdk4aakxJKvWAL7naq5R/w?=
 =?us-ascii?Q?Pb462mcSxVMqDg64OtsurGughRCQyoqHpfJRLY9pZlVp2cD4YSZuqVBvdXad?=
 =?us-ascii?Q?VbYRvFqn7gB4Eh/JrzFVkopuZ6uslBny6uaOnZHExUVM+wGdW0KH0Wrw7p5W?=
 =?us-ascii?Q?newWjvqQRqZFYBZIBrfGv43GkRN9SVbAODMcbMTMOvCtpzIrbUoRfN22/Ilz?=
 =?us-ascii?Q?Q/QLiGsMnFMPgM7nPChNJTh3IhEYzWKuQntnosK2DGUOuomql5fY92lQQsXz?=
 =?us-ascii?Q?QkIs+CknqSnv3O7qJl1MLGWiD2qBgf3xNtTPy3tMlKtx+eEfeqWe2AxEQ9Fp?=
 =?us-ascii?Q?gTSqpqmgkScxZvH7QmuL4H9ArI9r6+PojlahW8Jj/lepxY7zoqqquaL8/YqV?=
 =?us-ascii?Q?mcZ/IJ0CRykC81DLhAa66mFUkjuMo+8FZhfZQp2iuBR3qsSIgc9lUR6ZPqyO?=
 =?us-ascii?Q?T5cSz1z/LuRo1xmhL4mCxEeH5VmjbJ8T3J9drRciRZAYfCgUwINsYZSh0DVj?=
 =?us-ascii?Q?8qV3BJ5a0eZic1nkqoD7zVlXDY4YmYDQ2YTx8QB2Yfr8ss2NK4/nGAGjZGPs?=
 =?us-ascii?Q?qCTfXNHsj9MtwPyiho/fjSfO+w9pe8FE1N14p8cKt5dLMO6v25oy42farQwg?=
 =?us-ascii?Q?qCWDcSA9QOXWAfD8T9SZ44n1IWNTTdtcJKSVhdTKr1lw4J+fN6ltKXXzr8pP?=
 =?us-ascii?Q?NC6GEsNB8Gou1qXtYMkdF2eQYrlz9J8xPcQkTOCi+0BqlR5QC5/vUEDboyIh?=
 =?us-ascii?Q?dlkSl+MsQD8GW4FujZnV+VZCMb6y9uVZZm5bniY8H2vOp5TdgFVJyO5RxwI+?=
 =?us-ascii?Q?hWfOi+ZwIPt5/i769sRuAFC79etGwG+owYAWY38HFF8ZWA99zFD4Viq6D3tU?=
 =?us-ascii?Q?1oIFEK7rSRQPJsrPYUAq3JfSt8y023/ga1t+y1GL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed01d293-a142-4504-3bb7-08db9d5922da
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:30:36.6716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVZdpbQbIIc/EKWn6rqOr7rHtBUh2RG36U2vhDeJiApH7icLqk5fY0kOvCkHkAvsFnf5ScnJZRyZpDbUCCOKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239

Drop data_init interface.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 8d9442996e0f..7a5c058d2408 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -28,14 +28,8 @@ void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
 	bpf_sk_storage_delete(&mptcp_rr_map, msk);
 }
 
-void BPF_STRUCT_OPS(bpf_rr_data_init, struct mptcp_sock *msk,
-		    struct mptcp_sched_data *data)
-{
-	mptcp_sched_data_set_contexts(msk, data);
-}
-
 int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
-		   const struct mptcp_sched_data *data)
+		   struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_rr_storage *ptr;
@@ -49,6 +43,8 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
 
 	last_snd = ptr->last_snd;
 
+	mptcp_sched_data_set_contexts(msk, data);
+
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		subflow = mptcp_subflow_ctx_by_pos(data, i);
 		if (!last_snd || !subflow)
@@ -75,7 +71,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
-	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

