Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463D7C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8hLIXruJgkuQNY6SEPfJdQFk8yXwuu4DoFjfFkM10QOFFhWzRBaTtTrrvdwNjOQJvENxsj5jRANwrNQf9RacJZRZtt+ifGY0zhjrDl9zhrRhs/tSBnWqXrxaxHeezfoFPHkB2w+cqJr/m7FX7TxOeIVc14bx8GsJQ2DoluSQofd2wnL66IcGyDt97ymkotvTKUiqFYK15q+8eh0Wct0itmxEupynKFGkBCrCdrn3TkArhAPkvLVFvWp0nQ7Jdbh4q/Ex8jS+1MEk12AEqy+0pwaSnHiuaLerX7Bf9f00UPmAXzeogyUiPUPQLBvmceh9hwG42aIFgJxBtmPTJSQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=oHLYPC+7oFNVL8GsukZG5MRoKSIBEWPLcQnbaKQH68GQHQmTkORR1w0cEZM/jUMFpAdwzGrmjHujGGwNLXzOet7+6s2aR8RCMX86q8FL1ZGWIPv8mT+pE2BuzDlHz9Ifk6BhSro5PiTqsZvrq3TkUx7IVeCtp//DjyzE4QZzYYtZT/FIf+7gx7GYXLF3xKQK4RIFFDHo4Ij+cU/GLvoW2XqnOkrxBA8WurlyyHnnoMA4iJizcnIEp79myoGe8OoyM38uYMivrOJ1darloLDCowot3o0PKex/Vx1jielNA53mhIe1Ww3VBVXz1J9tp1rvDaTXq0VynqQFTwqACw9Q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=y8Vs5zupqofmZiFz1EUi5KdawmUKamf+v0sQo+JCThKKOtrn3UxrTT4GZsBBSDMpm7FMdv10NcUDXqTnam04tcsxelsh74AEoPtwe6UU2oQBjI3Gxf1v3isv/lBiAgL02Izgf+ISq4uGr9Ry+mgX2GXBWCTyJWqLwhWrblvNo39Yqq6K9Z1YYTHkGZmfo7lUEp9rHISjP6FHNsyFmJBSeVzDYkmB52DURgWDnV1MvtZ1D6vDhflTOGBiYppT1+1i1EJct2hhNXt8hr7sq4xBJ8k91BD32MjGZjfLnIQk7A38sE53RPXF9ZFnBFDheB2IuJsjW0PhGHcGIcqZlNH9/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:18:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:18:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 10/12] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Mon, 29 May 2023 17:17:24 +0800
Message-Id: <aaaa0bad2a031bbd9ac93d03d6c749be44f09222.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 6024d005-3bd2-4ad7-1170-08db6025b86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H16E+0tcBIOcAbN13Mkc8NPtxjNKH2cLQL8B860UdJbTBH43+yqmsC7vYeVE0U8wDYwGyI7RRL2+hsxXgvh9msz4lniM4QpQUwad4YUQxJ+UWcGuf8EH2bTlg7OxwID5KalJ9RU0lhpI51kh8a7VUWQWnBWgu3CTRGJX1kO+jD05Fm2lGRz7Nz+5YO1BZOyOQ2O9v/Qu53aspmpcrCpMu/EZrvc/m0bW1cRmYhYuy5krpl7MBt14y7WnYVdU6c1qLf0cS96NpUXsysEwcXHxAFBWrRPfj8OjwUMQPtMqTVKhnvg8GyCyrArG2I2Lb7xBEMG/jdLebesM6SoEo4gL+YNt9QI5g2OBxAr5tVkgNV0tKD4IP9yJ7RytLPyPVhmikk1zk74adU8e5ngZjSRtfLphBFp4eJi6QabEXM4GpMr/BYLa8q2+BgR1Nz9wD5bxQnH9lY/5NXP+iohJRAl7sXzL5GGXMbg+7bQVvwAzNMU1W8lNgeYf4888bYaNs2WWUI5RJLvsbGmM3vWlvrAl6NyMfJScknYXbJwpjPCbnA03uCqC9ak1c9ubte5LbmHV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZj9QbwBJQnovRwEPGGWdJWCDFgaY6DlEjZQtl/NsBuXHoKxTEgUL399lOwp?=
 =?us-ascii?Q?yRY0T8cOnyKHaBuCq417XgkVcyfTP70EXnH/vovL0m29Jz3omWm8alj+JNEW?=
 =?us-ascii?Q?8tOiWqSeTrJWUW0p8XJgI8N/b/qzzdsz89Hd4QzBQJyVVvQB/CIk8GK724Op?=
 =?us-ascii?Q?5pUDBb3DpsKKU7imkUaph8TDYPu4vcyobU4qyykWMQ8SXHiGKYGgd7ahbgX3?=
 =?us-ascii?Q?rZXTqoz61cuhQqzp5hYWbJSpTDQdf/wgmJxkq/MLAxpT9DvxdbkuSbc4Q/Z0?=
 =?us-ascii?Q?3I4MhArXACA5FfY0E8qRzOjic2SDqlyJvd71IW8xV0ZoVUi+zYNVUau1VBej?=
 =?us-ascii?Q?Keo14OX76jaKW63xQlJq1EwsoN6cOGqdr4IiJkaLJDAf/CGewqEu8eKJzzJ6?=
 =?us-ascii?Q?qvqTCm7gSJxte7WOjHdtqenvdRBEgCpZcGmc2e3pPxDvNx0AN4dFcFdOWULY?=
 =?us-ascii?Q?ICHjkgUpRJd2WfehM725aLrnpAtZV0Ti6qboLdNC+yg8Q0xcr8vZX3xTrNSs?=
 =?us-ascii?Q?frFRzJd0TGFoW/DxBfrBTspMivlSac4r3iUnPVx7jzNjqZN3vJTeeR00dbFj?=
 =?us-ascii?Q?ZedzOAcOsnzYXJIcrUN11m272RrEh60tudEgXpSfOLXHEwLm2/U62Ceo71Ap?=
 =?us-ascii?Q?K0npPi5/S5Y+f+/APeQdJCOs2OaV46LpxQaRDp4vHuJyGIeAE9dNyCy4knLn?=
 =?us-ascii?Q?405ra7B4Z812hZICi0sr3KDK+ph6QID9LRhotDKqYuVT0o1j8KMGVTcFshVz?=
 =?us-ascii?Q?PnxPuPAyqcgTt/c4LjeFociANKCj6kX432eY+xklviW4VRqOb0u1RgGd4Crt?=
 =?us-ascii?Q?Cs3ALWc0r/8RqaxmE0AyOl5kvvpcc0z+wv0EIC1wYW7GN1QmUlUUbj4TCtBs?=
 =?us-ascii?Q?irD3EPzep/7+Zvl/YOniRVHAWnPfbf11N4jcfwBkBg68SqPXsrBVeQaGbQxl?=
 =?us-ascii?Q?Gw/IdtYdGkGpovGK+Xr3HcKTCS5a0VAGkXYewnLELtMCj4XQRuL7VtstFXVf?=
 =?us-ascii?Q?Ax74f+9iIzFyv5qHnUIRJyKdhwsq4JGqFX2PFdP/38L4inLA/Jq/x7Vb+oip?=
 =?us-ascii?Q?p9le+DAEJPUitfFMksxIgv680u1SBVsmlF7HBMYMxa4KsxRdPmq8AO5jvEVi?=
 =?us-ascii?Q?M4/8DViMHH+rNZCZJ30tqmOnbwBV46OyoSSZuoYXuTuFYFvYCLO2Rvnvt4gD?=
 =?us-ascii?Q?vLUPrUIz98k7VM7MfFS7M0y2byPZ1GVYpuaV40gujnbbnkdka9O5GdyazMKI?=
 =?us-ascii?Q?xrAIL1aEoRBDABERONF6NpE1yqS60xoXkkQ5nZ72b5Cnb4gSIwkSfcQ7fhTp?=
 =?us-ascii?Q?LZA9BMywMGcJhTaZIB4+ge0aYPUxPuZWYpTW8NVGs2PeLGFMTHwcQC2OOWhF?=
 =?us-ascii?Q?A002AYlDpQeqryy6y8IzNhU+b6jfMnBRNG3LkrzCk/k2oT3pqrMnS6dGfci8?=
 =?us-ascii?Q?3Ui3zZViQ+FfbrWRwAQvZU1OA5msYWm3wftFPAk3/i2+x29EI2JMHn+/itgb?=
 =?us-ascii?Q?lqGAYoelHYiyh6s9qb3Buz93W2rIooKYTHQqsYpZk/yOdEAZU88Vw+AyZP7t?=
 =?us-ascii?Q?51+PG7AgoZaiv7aXJMvDBepVnA4BnudGy5UoWPAG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6024d005-3bd2-4ad7-1170-08db6025b86b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:18:52.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VI4bDXuG4aWNosVRuAOMtABM9HHH5rkEHl3/ZU6sfnC6myrKoKHeGqOuXij1stlD5RoKjTQy6mtfRQHHeOPUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

Use data->last_snd instead of msk->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index fcb023a749ad..dddb51a47740 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,6 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
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

