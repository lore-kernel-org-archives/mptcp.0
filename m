Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE66ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE+TddtZ86Ign9ylFRr3X2dAXjPprjmN+/IxNi+eqd6Sy5Hv39LfepE3ICpUwvHpAPEA0brT8+bp10jIG/fWa2tbUSl2slZ6zXj8l0jM/PQPemmhobGEIWNab4zTxdJ0T8NM5IyJ6jUxck6SyvgJTRtqQ9xzrvGb5OpCE8TP4ffRQHrDXrYjl8ckmo5AW9tIjewl4EGeDyV5FYNrmkuRHQa4mllDboA+KAF4Hor1oh/2/wLNylIhb2F1AFR2y5iKormTaY9yXNLA8SM3zBaOcJhg+oykv7KIpQ7tpMyu+fATEr3ml1JIcnyA8pBCf3Dur1EEIrzvelya+TI34ctwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSzm30+7Jfm5nKSccJZlVXfMv5OMkKhbdewzmpIhJWU=;
 b=Xhd1UfLbgNtalZWZyCh5lcJbc6adUWan2kYnnniXWYZvbOmcGxoYjm8NmItlNUfM7Ut0ruEDVkuzmvYEvcnDFe6KiLiKvjIKoUVkAWNnAND9hTXr5xKhsOMeoTmS7hTnaelYtwEZc+vMVE/eTelNrdf4zok3goxHzJO5YN2+WKLr2Jxz4E5nHWMoH7BlSgYdmDfmcUn8ibE/ZeX0mBJ/L85+jeOtCfQjzENAephpI17e+DC7nPg23RdZJM62gPTmgCGm6Kk6xffX3ytd7BebeLn107Q0LQ1AMCXI9k0gyLxjlJr0VOERoGXB2pP90PEYSQ97/wpbguuEzLO3cekclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSzm30+7Jfm5nKSccJZlVXfMv5OMkKhbdewzmpIhJWU=;
 b=2ZORpJQ2AxG4jbEW8lJr3PUgEl+mIYu5ovexg0nPWhyaXvpVsL3cVqH7Cbl72RIubXymvvaaW6iQdFksOjwj3FHTVXrorfADOYQF2NyDpqkeSq/ureZ3E4VPrcnC4Gyh4efXKxEtVtVKoj9xRyaROlk6E5NrrZBo6ZIaFEEqG/jbqSrpE3sLWeVoDF7z9PdPSUM1RrLj9t7XHm8ECyRwEo/OIL5H8iF/q8jyU7Pa0zZaDf7b/QIKtnhYYx/+0WSg5dseBSFys07PnoK26s79D+HGPwwFXTkU8nGL4aduJ/i8c834M3DAjjOUX52mrx9I63Ns9it942yUe7H9CWvENw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7896.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 11/15] mptcp: use get_retrans wrapper
Date: Tue,  8 Nov 2022 17:08:33 +0800
Message-Id: <7bef9995aab43fa6cb8e895b0e5ea84e20f30d77.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c316d26-b9ec-4a51-735a-08dac168fe9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FTCnEMqWZjh7ja8ipG1dxNFSsXl235T0dL/bdA/sqnzNFoLg/fL/aoUUUVwccNKfu6qF/eP/TRnBt9PnXUZ9gXiV92RS7jCgaAI71y4kZbVsjb6KkO+nq2uS6uNFuuJU7rWRLBWYZRydSM1kkpmTzf29Pt+UKX2xRfOdnqA7Z+GDSwAnk8/8C8hP/6Ubh7KTv5FpsqaQgID6yjYkh71mstPSdGjDhn+lQ4trFm1voXbCKfRGDKNQuEDMC1JygBx3JT8vXH+70t+ajJ77Yk7l/A+NRH0kg3lQXMbyFGUrHD7sNfUAZzgWENUzkVz09a/iVEE+oRhV37zRea2OCAkAkvKme7mAbVRjHwPCg+F70amDUZrV0IONNUwbAZpPjpUO5jh5e8iDZyK/04DQcPnEhhGGJhm14sipSpt2MkEDOZpAO5Gwjxtt8kXh9Pg6dZsPAvaMVBlLUOJC4iXpDFPbWNqiLMvAWq+/qD6yfp5RNHpWqs9h7edlQLQ9zOlCAsosknPJa9GTWXG7exQReeRVsGVp6m1m6LWsg/ooaNaNaUYIlcvTm1be53lMZRO0amKfuZfI++rr+inYn9M4M23jsH9T0aEX3A67S/qWdT6KIs1ratPpqw7uCBTw1wV1T6ZnHqVWcX/k8eUyHnqpuRRWElg6GoywnQuDZ+FtjnXr80TSMsi1oc74vqGAEhirSxcMYYA7eUGpsXf8LqHHKdvmRJ3NI5CyqLw0XgaEYJm83itw8cBKX6vAcLfvuVv/gmDf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(6506007)(316002)(6512007)(36756003)(83380400001)(8936002)(2616005)(186003)(5660300002)(2906002)(26005)(41300700001)(44832011)(66556008)(66476007)(4326008)(66946007)(8676002)(107886003)(478600001)(6666004)(6916009)(86362001)(38100700002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FrHLCnFDb54E9YBjHRxhH9YvLq/VZptPWhYRa8rN7yYpOuRkvZJ2Efmp2tJ6?=
 =?us-ascii?Q?x6OmqoWKFzN9NgjNroUt6WiTi7V9sWoJXuZ+izC2Y45WQIRWq1ZhurjnnqkV?=
 =?us-ascii?Q?yPbieM/BRymA618vbvmCt7NQDb1I5wxIzumm7cvBQHOsypL7/R6wsuKQ00qs?=
 =?us-ascii?Q?EDlQxHhsIw1Wltlmo5Q6Q6i5r4XGRQHseAFFuHcegcq8m6G5kH16wn91tLle?=
 =?us-ascii?Q?PGcf9IZF8Af8l8jzKG5qT3GlxlEMRwhYuX3qdEgtraxOWKwcpFj1mhF5k2qw?=
 =?us-ascii?Q?+7xKwxqg1nkZhWtuw8GeXy6sT9BI86G8iPjFqaz7g1gNQC3pCUFEWdici0x3?=
 =?us-ascii?Q?kTHVWUmsyNSfrdAx9uR3dIZmi5dP9+9wOS80rHla7ZEQ8PhvSI30pxoBvaFc?=
 =?us-ascii?Q?ED0ZHKsLorkXiexeVOR88dis81fdFsYkCdGTNXMMWEtslWRCTRy3etnixxGU?=
 =?us-ascii?Q?64a7WeG8xyX7fca6T/CuPP0JGfdBMdoaW+rTIBnWk7GP5nDqUBTGLhPaJxyx?=
 =?us-ascii?Q?NPZfPqmDWgmiU4IOCCTPcLJNScJQkGJqynhujPV5UVnsDVddmaFAs7HxnXYB?=
 =?us-ascii?Q?8SSw37AUlPLk5sLWacIyHxHdlaJ3c24LG/zOei4dYkrYZdsKnXykElLIiaxC?=
 =?us-ascii?Q?q7rzFqmia44DBFg3kCNvbndNiLi6jNuGiYIDljfPUvUyMDgcY24Qvf5LMpFk?=
 =?us-ascii?Q?GxVjO5NU2SqtyotInZavNAwhSmlSlxiGLoTjYCD7ScQXI/n9i9qhYfhIPfZn?=
 =?us-ascii?Q?GR3BRwXfuMFR+IKKJ2i2V3W++CyIlnT0sSPt+x7MvJa1wHZGF/1sgLOjmuDw?=
 =?us-ascii?Q?70skWPORKSrFiJF8uDFi2RQrT3NZRMZfOLme/X7RPiXsUD3a44JzFSuDd+QQ?=
 =?us-ascii?Q?N6ahNZ6Ks1PzN/QdVnNR17f05hcncc4NC8KJwHAGrEU7Wu26PaGu0gcfAELy?=
 =?us-ascii?Q?7g6cHX4C62gNq5ondiJqnWjhbM/NxpnnQSKbzeXAJk+lBd+4QjzADpVPLcpZ?=
 =?us-ascii?Q?tanVlJjwbk/DCfHXTWdoN1GI5sJRLRGvbW7KVMPG3ZT0QVOHtJq/76q6HfTK?=
 =?us-ascii?Q?4kApv1I6DKxhuKO4AboCmnPFkXLCj2UECrgLNrFzzLhMrnLMEwD7Tef0xxoA?=
 =?us-ascii?Q?YEnQVwj0V75K3W2ouDyiDEuK5a8+Cym+D1MwaadRi7fCp6sTKh0/di8hVlFv?=
 =?us-ascii?Q?xjicnsdAgSBc4C5a7KiPYRB4/1zTylhYp/sBmuKuCiBLq1E0SM1XnsI5Yri2?=
 =?us-ascii?Q?zuNHv8M2Lp7Z49Fpt74igBF79Odgi04kZf0bxIcxDOznZOWrtH4y71tXg9uF?=
 =?us-ascii?Q?DfaLz9uU1ygOPsLAsUgUEpZkYNxpfjCzuNmdPIsPvqZ6UpXfn67W2ZdDe9pl?=
 =?us-ascii?Q?sJe0vYiMqVnboJd/ouNEMlX4/K7q7Jhe5MsVK2R5OGGDYhasCuNswkNn68ks?=
 =?us-ascii?Q?SM9EfvXjuMc0D8+RxEnnxElx2RRWdeg+0jnxrLz+QAH3SDx+e9NZAEHi+E2g?=
 =?us-ascii?Q?6nmkjEwtpRkmgkwViyoGx9OTzfjXF0xrtV+ih7Zl9Oanqq51Rdjx/m8mZ1wc?=
 =?us-ascii?Q?KLxSc+TtINxdYlovWJnn/doZ7Sy7XJUjFu0DaATz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c316d26-b9ec-4a51-735a-08dac168fe9f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:52.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53/pQDZgfxTgZWHFt7LyrUcKoCVl/3ppf4sm0iWXgol2e2KgMm5GO0UcKD5lZQb171zHrjOBGCsdrKnhUlOeaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7896

This patch defines the packet scheduler wrapper mptcp_sched_get_retrans(),
invoke data_init() and get_subflow() of msk->sched in it.

Set data->reinject to true in mptcp_sched_get_retrans(). If msk->sched is
NULL, use default functions mptcp_subflow_get_retrans() to retrans data.

Move sock_owned_by_me() check and fallback check into the wrapper from
mptcp_subflow_get_retrans().

Add the multiple subflows support for __mptcp_retrans(). Use get_retrans()
wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 69 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 30 +++++++++++++++++++
 3 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5bcadb36b99b..bf49eaf203dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2264,17 +2264,12 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2549,16 +2544,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2577,31 +2573,46 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
+
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
+
+			lock_sock(ssk);
+
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			release_sock(ssk);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
 	}
-
-	release_sock(ssk);
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2bc0acf2d659..f8cc14064573 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -641,7 +641,9 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index bc5d82300863..edddd7cceada 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -149,3 +149,33 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+	struct sock *ssk = NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
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
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

