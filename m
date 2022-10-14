Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6020F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZdpz4OVo0ME83rk/Mydqzf97ADrs5m0WepowXjmRAZXlhH58mPc079tUIKKL+2AN1VCkM3VTewCGgv9C71dPDQCfev5VMbUIyCo+1wKFoXJf1WZRCRTIdl9Rl+TUkPTILiGG57Woxlva9cLYe1l/CpXSZlT81oSDVLdU0hKv4ESYmK6drzNWsdvxM4dIyp6NhZU4UicTVx+sorUQ2YfvrqSMj7Gb6mmmE6pioJW7CYZ26dyfjx703yAv7Hbg3prAHefzVhjcMAhcfRMHq3OZLKdy4GuRTK2POk/ISdM2vvi85arPcx/PdivkCFtd3x67fTZ3g3SphWOGWYFiFvKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU34LIf9WSvwvaxF0Xu8JWxr6eA2+75biWSXiYL7Gic=;
 b=RGNxSP2MTxunM4JQK3hL4bQXyeWIuExvYWOPKIBVlY2QG2pfdoTBChsi+ERoiC19nI7CL1AmgSRs6SiS1P7BCm+fmsHo3r7WAioQaQ25Ka3X9K8/WWiv2qnFB1W9PNvHGR7TVRkHLv+09rorageror89BeVtXQcSqpkQyHhDWLVBxua+bCkG8KHUmPGZEaC1d6Q680c3fNossGyNY/+5OmiwcOtghVs0DZ3vxBlDyH7Hygj8U6f+RwybLBElRWmfQKJkgYAyVHolPzTdbFH+1ON+WMbqEh5JMZvVosoxu3HbVHJXF5Qyl5kkhEnigkBQEnAsgxbfdM2YV04JrMDkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU34LIf9WSvwvaxF0Xu8JWxr6eA2+75biWSXiYL7Gic=;
 b=iNW7JlTTODFeJUzLDdpZdm/4KJLunj+lcI823/S+HNDbnFzdyrT7agiW81NwEr0KAN/Kn1J/SJucyioOj7vMDGd5z9CjutkJOkE+xwYZTRf4yK4rQRfHJGWNf0Mt/7vidz57lYSTlwBpXaajiCuBXl8ZZ6wlk450o1wKPT7yBByHIenIttKEexSirmj8VP+2/nuki8wL1qWhSUWUYwN4mzziMp1aFhqPlJHsX9rdczUoLncuPGiUH3AZu2vpok8nRCYMU+rZAXpfSsbcrxhP99bhebsiP8Ps8QDAq0rutG4o3eVfADtr25SSZrOJeGqZh9YUTaHa+ybDNsaaf1rXyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:34:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:34:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 10/15] mptcp: add scheduler wrappers
Date: Fri, 14 Oct 2022 21:32:17 +0800
Message-Id: <c9141bb653fea1fc9086af5b0876de77ac194773.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:1::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb1a280-b915-4a24-3e3c-08daade8ccac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NR8SseJ2nN6X0G9wqzWmOO5tj0Xgcp2kiqYfntqq6a+t3JNT0fyNFwUdEqUbiE/1FcFz2SEByZBHbmrtEzINieoio/Lxq/lGWL+UvhAcdhC8OPZX9e6E7gv6hWWzty59DfWmbiTck4xdiXF0fCHjILefjJqATxhfV49J4WrT56jth2FxBRALRIlGn/ciyzkjc6YzIIcEG8w1BvK/XsxfbDbmpw4z/8Zwdg9wxJloa7T4lfqn8cm0KWfP/IWvoDKQCTt0rSMj/VOfwyYlWt7Jbk+6C3l+GLJIIU0zlfjHNwSLUDBgNBoav/xM4THliqr5BUrTEsi8r5w+pCFd5NF5N/PKZKrVENK9Jun+GffK/qA9/lgQk0won9Lgjbb0618rQV/p3uCwKAyOrIPOj5juYdYwyr3fJHrLPSDSnw3OczO/w2R773bkHb8nTgaB3UFMn0/euzfp4vcj/+T4JOS7pawzNGiZewLmBaF/1blMERiLrtFPb2sFYvF0zB9zBOfBm1rrbOTUeEBrR1m5LmSQtIWIO856n/W+rVwOPNL6YW8kWI5z+4zuuJVc++8bWwgG2i7NnxLRu42T7MN1kwCC6ldYH9Mxiqdr6I3xOn5odX5zXS7hFsHPeKJcWjwaoZQFmsx1NNux5YnXQv5iEPVJotOEDOoD5RZJP73ItktxqpEMU3aRx3dBkY7kNcNJlQDuj8pQqItuSRhTzwrOJMWS4DwDreNykMqKUp5NI9L4EnlNDJ8CxzPtt5OZ7uqUhID2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6486002)(36756003)(2906002)(83380400001)(6916009)(316002)(6666004)(38100700002)(41300700001)(6506007)(186003)(8936002)(107886003)(26005)(5660300002)(2616005)(478600001)(44832011)(6512007)(66476007)(66556008)(66946007)(8676002)(86362001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ekFrZAy+Bg9eEo3rGGXVGkgfSpqvf7u7puB4RY6UeSxXnkrKOk6dxxNRzIaX?=
 =?us-ascii?Q?G5Q9HYYa2pN1EQ1grryODqXTuiqak7ATTC9qE9TZ99HFuvGzyKSz0Bf4oex0?=
 =?us-ascii?Q?4+iIVbcn78TM2R1lSFYlGDSerNlJAA/RmkB9gFK/buSY3EwAwF6Jgwg6DGyf?=
 =?us-ascii?Q?Tw8xiv9SSeekJ2SxQxKEfF98ZVmu0bO1ggQN4RwB4rXrOcj5xXDrgj2k2bM5?=
 =?us-ascii?Q?ZktwypHA9FHeAJleXcfBSli3XmnVBPrbulGzkeOanfQfA+TaNGW4Gg2Opdp9?=
 =?us-ascii?Q?ujmkZLjIHM+vTZq72hF4GU6zIh0fZ48UUcDw+yKbQ6w0ImuvK1YyFiph/Ga5?=
 =?us-ascii?Q?VS8FpugyFtCWPhkzX9pLmuV5RPfanufUvGuRoKT+aRBQG7Rzq+NGz28nuP6D?=
 =?us-ascii?Q?FhVpULdnmPr9TXNmvW8RlGb7XbSTBejAm8PRspLcO6MVEc8oshXs2Fb79AMZ?=
 =?us-ascii?Q?s3ZR0SW+j50nxxDquWNXUa73+doEZvgBt+Pqyl6z4teYrns51EN4mCzRK/iP?=
 =?us-ascii?Q?hNozRn1UKBGi955KqXUdifGuKrScP41jP8OdIpIbKm89dViYCzlGf7lig72N?=
 =?us-ascii?Q?02nPJwSQ2ensV3pVK8ioXP+OvFwM82qW6QK/GJmkugRiysKZot72axLxSOa2?=
 =?us-ascii?Q?kDbQdrqTMNzj5UiwAHl1Lt6NuCtcPc58VoFRvyCuMok+zg4gczGJbXtjWa42?=
 =?us-ascii?Q?7QkVmNnprJ6cep+cyJy42DbKCp1mlUnxVpYQBmt6EQ8Lby5ep9qVY7+9gH1V?=
 =?us-ascii?Q?U1Mfvz/MsH0jYph+zwBCSF+Mgdmpw6k8dSGonHm1j9s2YYvc+Xl40VguU7PO?=
 =?us-ascii?Q?Y3XYX2ciTUlWKggbB3F+iy7U4ZnoR/6thuVw2t/lcgASssmdW32I78jFd0Lv?=
 =?us-ascii?Q?X1AjT560JJY1pz5e/sJpsPIed0pQiY+NKjdhT4jDiJmeWeI1HWBu45J4uoj7?=
 =?us-ascii?Q?MNVwaFR5li0n6ZEKps77U/L2hYeJtQoyFBbqn924Q0lBnTjrKR/bJMrDUbFI?=
 =?us-ascii?Q?Srq7M9KDDi0ctj9UdWiKGZCxJauxa7TM9VwkE3M9AHqYJ1vARQ/67RYEZ/uv?=
 =?us-ascii?Q?fidH1CLSsWPhqwF+aKm8lEa1p3/0B0n8d1aS+NBdA6Ux7UfGkIuhQq72bZD5?=
 =?us-ascii?Q?qThMq8aSntbDKkDK76ecpL7AIUeGbnuRfB5N/wdl5tprNP1w4rkicJPkNHLN?=
 =?us-ascii?Q?0RAyhkHB7n059/eRn5SJUPe4FAF0Qsq1wio+VveeqpIFDRPluh1D+hCSwj+O?=
 =?us-ascii?Q?3rOfl6s6URX2RH/GMUPZ0ssZmJkTcfSFbSwW/P9y9ZIeSMRLRHBjc6Ycmwkw?=
 =?us-ascii?Q?lmVkhp3T+Waflh7gZ3302s00/6a6U5UgjVAS5AsYBTG6GqPd7rlwjDIXXl76?=
 =?us-ascii?Q?OuUFZWnIatJ0gj03h5b5YaoQKV18TKF3Sp/MkrW3lVWai0monQ3GLWkpUOjd?=
 =?us-ascii?Q?jqj7nXDksarFtp0cH3ohTIhvPA/p7WS5Xh/6q9nSCS6aSLB8/zmvQiqIO6tZ?=
 =?us-ascii?Q?dlmZUyFoQxajLypkiqyLjkIph90q2NZo/YsRhH5QqTwmfnL1qoIpvgrgszaT?=
 =?us-ascii?Q?ppJOvYdVgSDOGImKHiM/HQ+q58V0vkGA4uMcc5Mbn9110PNPxj5gygbhmwuQ?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb1a280-b915-4a24-3e3c-08daade8ccac
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:34:20.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzeBjr7FpJ1XAqjhTggwiT1HWKl86rj/xOkJ9tSNet50uduQvcjSKXLWtPRAMuJC0yqbbeYbiGSivCqVr6bclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke data_init() and get_subflow() of
msk->sched in them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.

Move sock_owned_by_me() check and fallback check into the wrappers from
mptcp_subflow_get_send() and mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 14 -----------
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 93c2b5d71254..8974ce86fbad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1418,15 +1418,6 @@ struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 	u64 linger_time;
 	long tout = 0;
 
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -2190,11 +2181,6 @@ struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cdea1efb14a5..95500d0293fb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -642,6 +642,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk,
+			 struct mptcp_sched_data *data);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk,
+			    struct mptcp_sched_data *data);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 92057ca94cf4..fd29797af3bc 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -146,3 +146,58 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk,
+			 struct mptcp_sched_data *data)
+{
+	struct sock *ssk = NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk, data);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data->reinject = false;
+	msk->sched->data_init(msk, data);
+	return msk->sched->get_subflow(msk, data);
+}
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk,
+			    struct mptcp_sched_data *data)
+{
+	struct sock *ssk = NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data->reinject = true;
+	msk->sched->data_init(msk, data);
+	return msk->sched->get_subflow(msk, data);
+}
-- 
2.35.3

