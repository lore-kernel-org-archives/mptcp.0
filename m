Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3CF10E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF0sqM0fgxYCRu9lNUWe8pNF1fZ1DH/x04k+f+vjIETjrBSv0I0bZmWV4WEmbD+KoJuejOiLf7DepI8BVD0JCuD7W8aP7GyEDlF0UQG6rs+nMwNaY3yB20IXYqhhavadJ8G0JMcgutLHgrzYt3TYGpmHeHb1T7TqfqzHH7DY7mrBhi2fcOBBtG2V01wvd2w/4rVO9WjBDTMIF42FZasG+DLwnRs2mgXSASKqtf6fCQWmfgzvXtJiirA2IEq6Iqsv0OzTRZeFfczUm9NI17NM5LKNwGaGSE9Jh7Cq1vHNahb49VErGdkpkdkwVXWCEsckovvrQTmHeHEEiH15DLIGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hStRBQms5r9S3AbR8kt9tPQrTr0D90Bye4gEDleyFIg=;
 b=RWBvtLQMnoaCb6qOapdahH45lgQo/YUVTUEvixA8+ZiMAkn2/6jh386DB+X81lqh579q3qeiezrYZu0HFZ1yiJEkjGLlZkvsrjHjpzYDeFoGV2ycF4esopHeZ2jJM8DixG+n21M/wRZ6UnecZJWl+9IMosaOKuKBzsBqRn6RszEGK8RqtBh8tRMzGrLZee3WKoLz6tC5bnGWt6XpIIzv2fHhd/FgQt9NZMi7M8p/X0aOp+JXcaq2N4I2CJtA0zy1ttgdGiKBcJvMQCAO39aKoSEY1F6fTDTpALvsZF/Tdcos0QnKhigtGtIwvRnrtfU27PtTDAjqRVMmdUjBneOt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hStRBQms5r9S3AbR8kt9tPQrTr0D90Bye4gEDleyFIg=;
 b=feNe0ucIrHWdZmznsqumyMYsXkFcJ/mqwVjZaSgstFOMzOGcL6sQlItgBTD6EHyx73KMjDCT1gUzdE8hXYgHBeRmx4EPPFAZAcZ4JmIRZ4NYfP4fE/lbAbnFCMvzUKrwUnxJzCMi6ooeeA3ghpIB+Hxy7M4ADKq8Ltg+eJAGlGezTe+N+pHXGOeYnPwgvK9Bh5dtQzMioAJBS9dcYimqPhll+jg0s4eDHfCnL4bCXj/Laj3bAEaCpz0TlFFEyRZAlj2y1EYkqgf/61NsyXyM3kzDCARhgrhxLt3zUj1mj5Ev/OxX8nLm7yTmJRY2g9lCYsEAIB3Z7vas0BsWnNZBgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:01:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:01:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v24 1/5] mptcp: add scheduler wrappers
Date: Sun, 11 Dec 2022 10:00:52 +0800
Message-Id: <a61104993db0e458d2b36f8016594776d161b1cd.1670723836.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670723836.git.geliang.tang@suse.com>
References: <cover.1670723836.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9ec6a5-0017-4d05-9aa3-08dadb1b8d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/IR2YT2P0RMqrqbGePT47bLFmxznmR/sTO3ATX/Zci6/NJmmmaIGHTROymAifcqNWFs8yMx7HFehy3Im7ndVz4rQ4nsfxFSyZ/ZboMUfFpwvyZn1T1B4JVcksm8POZsXvIdnuOG1PgVJVgsQenhyAVRgk0ZOZC/5pvJ7dTECCeAk0ntWzQ/GqYUF3mtFsSDqBn1YKlIGwrlBtUrUjEokYK8mZ9t/mRi42Z2Uhg/A9+B393l6LjA1ADtTZGyvufpVF7VYgpWFtuEnnmhuDgQOeqHj5/c3tVZ318dBmfecN21wqPp3lWIbSSIDdu1XBZN6HzQbFG8KdFLcSpmfPbzxGmr9hCqSmkFekid5Lv7E25DTg5zoeLg78ls+M4JnMDDL7e/B44L1TJHzasrl6AqTHFrNMsFOIS5pchVqE7sOZ5YvL1TL4Pay2aTC9/wEOXcOMOM4h8IE5tVtD96JXG/sozR0gR4V1lGd3vzHaq3xhFWseqkqsVgMCQlTqD5/+7W+VyuVLwyJsTr/dUU2MR1fonR/z6xPOLl1Pxa64A0hs0Bd4590Jz7w0C4kASBaMi4hicmexGyEY+q4uQvB/0cktu3dyLuwH1FV0wash6C46qxLB4QuPplduFYfcJYt/Y8QnjZH0TwTUQi35E9U+ME93g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(83380400001)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X8dKSbdkGTcb40At20NG2ZQnxa4/thsWLfY1VCQMInhIZbnwmrRWas/UKc3H?=
 =?us-ascii?Q?spqdb+ZwTMKIAVSmhWmJOajkP/c8ZTVHpBYKrWhVHItUmt1acyzqQiqQZr21?=
 =?us-ascii?Q?SY9JsM+9TDilEv5odt3npq1Dwu+Gsoiq1eAd/fUl5vZnSR+ktQPpV2walFh+?=
 =?us-ascii?Q?PT8KqLlf/EN7g+58i/fGu3Em6lmn4h65MCHm0BtOcK/ZwHKFDb10m30eGaVi?=
 =?us-ascii?Q?DgehUsDEzYuYxspjLaXUrhOiMA+1FDZ1mhKNa9zjE2XAvmvLSvhE764Gwl1o?=
 =?us-ascii?Q?aUKgOHaQZZP8/lG9nzJcMWi9RP3A+xKSVRu9zZ8CXukTSAarbFd5co5QGddF?=
 =?us-ascii?Q?HA+qjlA6KFAi1IBUCM/fo5mD91OMWaObEEJUKMr2YQeQk7vvQSHav6rt8Fv0?=
 =?us-ascii?Q?/tNh6NGl8qEssylVwU/nhNV1UbdKtI3p7Vwz5vzfEy4FeUpfE9FkDm46Yam3?=
 =?us-ascii?Q?jLV9593xuOUuFaL26ioy63VYJ3AZKA+P9nObCQeGiAjC9YAHnncTEbMaNmzX?=
 =?us-ascii?Q?8EsfQpxcE4VvR7b07hHwmtCqhay3pgQBo6TKyyK03vIegQ5nZX9S1LfIVOV4?=
 =?us-ascii?Q?jNFul7h0ZrTdPnq/rEL+4S3haebo0YiYmIIw+YLCLmfbjWL8AYBajURXT2Up?=
 =?us-ascii?Q?ap9ZpDCqSAcuNqux5esdoaKgJkcQGlOv28VmnhrkDPLFln3kmds2lHIP+ptl?=
 =?us-ascii?Q?HzOv3rCyryewTUNm7gjXfHOLVhG7HWxrKkbIWpecrX2sLvn/axIHkmj7a7vw?=
 =?us-ascii?Q?B5v5jchXW9NQLZF7Pj0/bz8tSZ/jgTiSpE917DUaX7BZvlpSoT244ndrzjtQ?=
 =?us-ascii?Q?pfiTawgpuQ638VtsmYxsaQbXJnvehJQPzUlGE8YnVwCxMoxIBim0KJJwaEzO?=
 =?us-ascii?Q?kp0NbwBWs/ejvOBsXCeyWAuzXiQDOCJRHlS2yHNr861Le8dKDhQ+GgHXRxhE?=
 =?us-ascii?Q?6xU9K6+sIYhNvra5C5mir90gI3eNVnftvwHUMJFfSb8te1ZfHIETvBOpF/Z7?=
 =?us-ascii?Q?pytvsg7Lvsy2AgwrzCVvupMs6lesDZFo2PwxJmC0LjAI7Mg3+ntxddtSyNqY?=
 =?us-ascii?Q?uwNNYhX2xLZ+iPq/ceVxWu3Un1+j53NfzAiA2uJO8gMvhOvsDdMesUiQkIgQ?=
 =?us-ascii?Q?spomYLLIuOeHA02y0vUq/x/jfMulfBnmzBKEs6OIUAirVOVNGYCG/LRF9MOc?=
 =?us-ascii?Q?Pqh17MwwY+Vym8N4WJvLlB6kgfCnhTm0ULXP/gkPifGzlDVLvzVw3j4hn8p9?=
 =?us-ascii?Q?H0INeHeAWHn+YlORSk2LDH6pcM4cs9fj6FoRdr3+tKbj9Qr1GhkNUjjFFwFd?=
 =?us-ascii?Q?bo5YqiJIySxU4+rJpMz5/YmKmMqOjhrfoVcFoZLsmwvrr2VD0iKdDIMAsBmT?=
 =?us-ascii?Q?4CSM9hTfsbChbkFs8Ow756jiN4JU7CZenYr8cRToCeuGu7mbzuMsRvSiVBlN?=
 =?us-ascii?Q?eGhgOAsPRQRJoFPuyx1H5E+xQYG2YIUUUniKeGvAcrTma3Qgi/F7IHnw0hFP?=
 =?us-ascii?Q?4J3yrQIl/LtLpNd6u9HkXWMq1VIRBGvgPauvOwgOjyvmpDOy5w0tJZLVveB2?=
 =?us-ascii?Q?2yqqqO2AO6OBbdW9+jChl96WXMT/zqyUZlg68qz1dd41PQ2JHtIHDAD87876?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9ec6a5-0017-4d05-9aa3-08dadb1b8d3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:01:00.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGrqh40ZB6qXT2elN7Y/gqpAHZFR70dzsOpmwbfoQexWfmpQZB3MVdP7H3qDxtYThbidMl/5JU0qO16xwbIdtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke data_init() and get_subflow() of
msk->sched in them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ee39a16d9a8..14c69a519898 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1396,7 +1396,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -2216,7 +2216,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a9ff7028fad8..ecb94ce68ea4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -657,6 +657,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..c4006f142f10 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,3 +112,53 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

