Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87020EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUHZUaEsZhoj57Azentx5JWMIcByg0ANWYGrMc88Y2uYqYWryyeC8Td38347dCvl06gT6dS+38THYsxvqv6g5SHBG8QZx94MoYAIwCPdLcaDA+/htREPTEEZjtigaG8KBZjKM1V7GrgHxVlXBU8ZcgfVMX1zGdgUbQVLjhDDx77d8fBWJpgyJ8JABlhLmkjICpmbNY3Ku2aAqW6mMELDYZTm5oakjns5PMqLykePUKg28748Kv2TSBugvhmTwMiwOOYo4EavTl/9AToHCOdaxVEn2+owbdLZQmTn3Fv5IauyzOQPc/BMyIS+rqo5qS9w5Sty13VJBMNB3O+FCHWwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otDUYIFuNZBrPMT4ne45nnq6N//qpmKE9zvbkoC9z1s=;
 b=YTuIaDrKFOtT/OQ/NqvWlbW96C/wZw52M/qwlGJdruoa/vfMc+4XOxcEntZoSGLcxJWgkHKeHFy6TjFxSoVPTHW8+5vv+M2uNs2y7pj+ef03o2JVApnXKAGvw2ljpFoSsVPvI7EEsgYvlWaC+7F21IYxTYORA7Appx6qJlMmnbWc0s6Ca3JNa1rL9Ia1fMr8yy8OWjb/c03hJ9D0TK6666f7zoAorzsLmqezpHdjVvaA6OlaIATDDEd4FQAUhyVbtcWnpMyo7jlXo/KK4z6QQwDxqZplQD0Hc2VidkuD+HzkRo5yj6tz0k2Nx06znQwJg8fY3Wg3NuzgjWg5nPth6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otDUYIFuNZBrPMT4ne45nnq6N//qpmKE9zvbkoC9z1s=;
 b=Wc88OLDdgfy2Dobfn3jl3H0ZH8xiWrwbw51lVD4fOpeGaYke9atlU9Wdzst/REG7jP0HFeCk6BYEl2mTbUntYECjXq1x2C1MT0YRY7GMxK1XiNOG4U3UcpJcMpr/txIWH+KLVtMkSoiq/CkY2MxMwrh9DbsKtSX+Df4g4/iULeicA+zrK64gcFG2Ugug+fBSZouyqFvxdMvJy2+qAc0eo5NOe/1wnl3V75Yeq7Zb+ExU7cKvtmsl4GISSQHbjRzZz/Dd5c9Q/oBfySVoM4rVqQ3edGdd//oOY0lY7n23XE2uhWvU6y0RCnlI4xJl+45GJR+i7nSBhCqaF8yEzDcT+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:56:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:56:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 8/8] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Sat, 27 May 2023 20:55:37 +0800
Message-Id: <ef47cf1485fc292a8f613c3f507dab8c6e7c7a65.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685191581.git.geliang.tang@suse.com>
References: <cover.1685191581.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d437dd-5aff-4f48-3c50-08db5eb1cf88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yeYTagqyJmic5o8ANpb2yyCWgpbOZuV435OdTzceDFCZ4dNDocJryD3Ktqu+7GHFtSakvJeeSKBCoDm8LJu7fvYv+y/dAdZx2ViG7a8PRvgWVNMKn4oJDbJTj4rhVBSe6ZQhKd5FNfb/Hq+CnJEiICSTvFU92bkd3DFHAGOtDD9+RcDbC46JL5meOrv7n3RIGeGuANJ+Lte8sotDTn9BvWaef06blH4z3d4jalWu4BweGYV8esAZtIQ9QiuH46grkpvrJD1Zt0XgAM5lnP9/hlvYW5uVGmiWW0UjKJNDlwsfNbR28ltBFv2weDeVls/gqGzl9zoNXGB1JEzampqseCPPaaeUo8xQs7F1UpPYbXwXa3zqQqb6MnbKv1w/+IgeA1BqJePgvBaxgK+knTGeUvAolEN/chKLG3G0yz1XAsBQjh209aM/VwlxOBRimpxVfugXb95EwmxJwLRtv8Kq4gxl6vXJts1gGTW+fz+hzh0XPwFcQ5Qrvg8sqyd5rDCLcqZApjslp2ocFkvN9HXvTJm9Uv0y2xhGbtKuwYgjP8WUeOU79yWHT/2mlcoBjpmR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(478600001)(86362001)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGlLoj6TjNs8iNlhzXsDX30s18sxhv2guc6ujtjIh1lBkm6fM6ot1i2jJTmU?=
 =?us-ascii?Q?mBeT19T0vqPdlXmmBFTW33ObL4fDulMEL78rDyzUdN561+DkyIdRERyQRWnW?=
 =?us-ascii?Q?cv6BmfGBS4Mz1YoQD2DLG5xUxGkBGlTU48wFOrO4p1hfwu2scpEjwCaoqfun?=
 =?us-ascii?Q?xpvefYTeH1xPD7dLURFbD+rx5zwCuJ/WXJ82KUiPgFtOVPIHDd40UXYxpEcj?=
 =?us-ascii?Q?vfTIxo2zhPtr1zwy8PpsdUVo8MO7wmLOPxWdsySVEURSvpF+B3mmU5sD/j9s?=
 =?us-ascii?Q?rAZbMenNOjNtIP2CqBPqDyC1qFZwuAU5T75zJ65jXAga53NDKUZ9kUHVOaZ+?=
 =?us-ascii?Q?lYgein5JjS1biZ4G7IYQPo8W6jIbhm4r7+A3YJhs7Rj5PgqS1rwnBYQ+agoT?=
 =?us-ascii?Q?jE4ptTDTz+v/tmYpi5tlZ+xiFHrfdjP+UAZ0IFXfW65uerIUlQqxo6JT+Wav?=
 =?us-ascii?Q?tZgjphR1cH4FifWwOxywfKFgZTE7hjImagExTPGnBZ9uqsefxjES16DsYGfP?=
 =?us-ascii?Q?ryQhxFl4tDS5EBFurmVflHKECIg3Jl9C12fmFWY/WJGtZtFUHUeVPn5e+FXS?=
 =?us-ascii?Q?dlRtJHPtqUAtR3VPoctgnomr4zvvUdt0Tg1HzKEEsG7XeVi/j7t9lZUFyq/I?=
 =?us-ascii?Q?YYS49zmfcDIS1V4xQvaWSLvi2KNdsAWNvlB+NYl5O4eyhQFTZ/XTDRGoLOzz?=
 =?us-ascii?Q?c9ufAKZqxV7S75Fab27GmAWHQkH+SHusrTLxCH8avLoXiurcUuJbgPLSnnNb?=
 =?us-ascii?Q?toLDdSGT5QZe4bKVCKqc/dy7HRX+nTm1gj1+gz4ZKV979vvfqKxE/MUnhzdw?=
 =?us-ascii?Q?YbPZoGs1PFjqvzuUY3Tm4C1P1R03PvFhtu7JQuRTzRTpVXmEF0sl8Hi5Cx7T?=
 =?us-ascii?Q?XKs22EYZzLmxqR+mQk8DBMaaXgivT+k/NUlMIiAIWP6cQE/Kel7iGUo89M72?=
 =?us-ascii?Q?X7v5Vn2SwlWTdfe75rB1vjqtRAqRgjBoptBd66/qvyUsEkLOoyMPJq2tOLha?=
 =?us-ascii?Q?gMjhqP9sIHxTePPzHIfTxoTZpe6e13z3Z3zlXxT/7XKwoxDuGMhbcK7RGhv+?=
 =?us-ascii?Q?5rlcQcYzgFL/PJ43OSiAMmRNhynFpX22tjuoia2VrLLSuBDEp67j9dhMHmbZ?=
 =?us-ascii?Q?k1njLlezzAODbDq6lI6EhoqeYzpG1GhbKTE2a6NykcnufSG3YsNuL46jc5BH?=
 =?us-ascii?Q?6QdPEI5NbCGWQbKv1M5jvQoUEe+m2UavMeH2OtMUU+rBSER0YZ1w1sERKVZV?=
 =?us-ascii?Q?rrycvQp7m5uOLd42j9ti6azwDCj3+ACAvghqB/YN4jnOfbeZgy+bsw9H4byx?=
 =?us-ascii?Q?0+3UZvd9Pc9yH+U6ArFZjyuW7QVGp0e5LQ99RBt/vIoQG1hesWk7mj5t0kJv?=
 =?us-ascii?Q?fHB3N29Wk4zsUMFqGjBmBoLnZvRxAte1MBVyQAn02zdOvI36Xp4KHfQ+VP19?=
 =?us-ascii?Q?SiS8qOdjniPe/ADaOvF5LrZHdkkNd/hm2Q1aPkqnFTTeNLbxKTP4Vd6Uiiom?=
 =?us-ascii?Q?fYF2yarR8fMIBvd8VATIq3baLdgN92y4AtRXJz2Erb4BOJ7kDB44ezY4txkI?=
 =?us-ascii?Q?mg5g/azWi8lngWr1nSN6hnNmvwnRJHqHrCJoR9F+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d437dd-5aff-4f48-3c50-08db5eb1cf88
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:56:38.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gtSKQcNusEug1vCjo6ouoOgIifMKesmWalCyOiJjtLLt5hRRU4cRvb0RONH+isMoPuln/gKf2SnYtOoRuPArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

Use data->last_snd instead of msk->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index fcb023a749ad..b6a0789fe33b 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -240,6 +240,7 @@ struct mptcp_subflow_context {
 
 struct mptcp_sched_data {
 	bool		reinject;
+	struct sock	*last_snd;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
@@ -259,7 +260,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index e101428e5906..4b4141056fe2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -28,10 +28,10 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!data->last_snd || !data->contexts[i])
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
+		if (data->contexts[i]->tcp_sock == data->last_snd) {
 			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
 
-- 
2.35.3

