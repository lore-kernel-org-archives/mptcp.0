Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20079.outbound.protection.outlook.com [40.107.2.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD27E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 09:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMRWzdJ7WcXd4i6HN31tutj1UnsZ6PrBomYzq/gB6RdagX7aXs0xejbkafivKAaY6+LlTmiMX7Dtvpr29tFfZbsGKp9fV7me0jIjtRTnnlJHP7EEPVebiOhegDMy6xI3jZf2l4E02nOLMLMFp7d83VLdZtpWh9cGYotSQGdG7s6glGJRFG5KpNzk6295IuOVTIGLV1cMq8wW+e0nnr4X//JKWwGEw4JMOfsyRVo87M9B1z3qar093tM/5ZVbFxrwc3PB3gq2Cc8GWje2iuo5qWuwCy53d0leJBw3NQDHoL1KVhjahZcdicSfhzoC4TT1uv5/av/GvrxMXN6Uurt26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDslROtSk2w/wOfeRi/b/opJmFwQjMDeSM43X9L21fE=;
 b=nyoGlSeZ4fxlxwOihG5PqKhYoTTkrqtHPGOt6C0IxSW2fCOXMxhslMGAhntyUW32aGAxGMrXIpOZpxnI6xSTZ/wq/c0qt75QBRZvRZXodD5o7ZC/GnfssjyUGTGIdjC2ceIodQPbajn73GWZeGZ3M0DAuJO01Toxn1gOXjuHDxfx1Q67sZSqzWj5Upf/HNf7mJYgVt4tVu3J6z2NFPJtyHh3taAos88Ei1a7Wu8scQ+RKDRoap5y7j6OjEtAcXX8kEUwvY1Lr+x+lyVyuJ7PHUTZlsQ0jQ9bqrAMx4JoRiTfQW9R5Q8fYJuHQ4NGg+cyeVBVDiLWUw4cui/zR//trQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDslROtSk2w/wOfeRi/b/opJmFwQjMDeSM43X9L21fE=;
 b=I0/umW2uH6ge6ty2PVwMk5rKzPkvdMFnqJRBTuU4mDnVv/XSu1zDsQKpcJ76Yp08OVTkRgwsIKorN6fOZntp2DwKw793w6YJ/u9BSm0OEgj4Q7FeF+eIc8byRlJRAR8+R5CiyV5bIuum0oAxBWvlUNffr0LWYiGOLJl4dlIbyv3KfhUlriINEIR11XxvNTjdebFyHT0JMhcXDhvFpRPPg4hfGjibO1zW9TXjpY3l5sQfeeS5C9zR+eNRh4eKlLOTyv1EItTFRMfLp7oEOvbqIaEunfdIDpHpoTOsN4vNT7qlPt2MtRV88to65OrKuYKDHMUQg4eZP+DNIHWJ3ZhDWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7542.eurprd04.prod.outlook.com (2603:10a6:20b:299::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 09:11:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 09:11:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 1/5] Squash to "mptcp: add get_subflow wrappers"
Date: Fri,  9 Sep 2022 17:11:32 +0800
Message-Id: <6b7806e8632ed9a7adcf83007bb374db7a14eadb.1662714028.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1662714028.git.geliang.tang@suse.com>
References: <cover.1662714028.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f55af1-5786-4cf8-1e56-08da924343c4
X-MS-TrafficTypeDiagnostic: AS8PR04MB7542:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6lVVOdYLBmG+cfsRF+OkScJQyG5cVAsUm6FXdyXakX8TiuSn1mZSqiQg6KpXaEB7b8CzZq1MbD7nKTPtSaitvkN7p8Acy8zeYtqaa/72y5vPPQN7ENT0WhUFlD9PZIjvD1Gycfdn0gFTbGCbhkuLk3ugzhNNOiXmXRUWBYmw9c4md4yxqdEIuJjPhuNunK2Ktx4oC8A2/CF/lbqBAlv7lMUD6kl0HfdoQR+MEdWcrt4w77O/uPFaUbljoUBc3aAdrngxCZy/L8jrc6bwwhRpPW39okwSIpL1EH9jflZoQypeoNYF43qRuHmoQC/rv7HhWmtRDVTaZaqZ4uMI65sboW5cerjeehGpCHgxtgG5lk+ghZ2TuCtT/EJY7IjGMJoG9ukGuUAn04BA/Eri7yLXSxHqHU8ZARKdKdufvlGgErlFg8Bw2dyhoNnrBRkbj0DSuOX6DIhsBDLt1ESTAoQkmSXX7Np/0fqa1f+qCny8eyFmrLLib+YIk5JBTfRFHlxl3itn9MfZsrdnXsNynw7hWIfkogZz9UmYVkSMdqB6FJt1I66/HYqhnXK6N5cT7PtbZgBicKdKOV8oqjhguyE/Opo403zULpvghJCap3cVZTannBOEISeNaJQhFU+DBryI0AmJbfKR30JNn47vKLDJe2hr6v/Aja1jIZNqacUI5mU43J93142+fSMGAKX4A7YHZu7sHHmsdHKQ9z1YFyWlm3V2R+cSf6zLslOKyAJ0dwdLrk2nre6kTG8LAyAmKdIC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(396003)(376002)(136003)(86362001)(38100700002)(4326008)(66946007)(8676002)(66476007)(66556008)(36756003)(478600001)(6512007)(26005)(83380400001)(2616005)(6506007)(107886003)(6486002)(6666004)(316002)(8936002)(6916009)(41300700001)(186003)(44832011)(5660300002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AC9wHDqXOzA3+7RfgOPM0TXA0mBdMQyOpT7PooKwCxWSGpmSvMzbxcvbVQi0?=
 =?us-ascii?Q?ycQ+WSIFECQpUdNigTNyQyuWAXEZZSJZvNi5FT1h6CmSsz8XkMMc/xCe1N2c?=
 =?us-ascii?Q?ooRm9U4/hYdNICYqJqnfs2Y7yOzydROrYK5IrurSxjyURvKRTLuOMiYKWJSh?=
 =?us-ascii?Q?L+Tnk+eybJNkdOi+Ql1Tok/4bAgxYoi4KCiWJIhuVyb9GNI5Ao4sgblLezCw?=
 =?us-ascii?Q?0KnqwcJUpWJQcGNwz44UN+d4Hdj4F4gmS4qFv8ewLZ+BnvUb747Ei5rpyF3M?=
 =?us-ascii?Q?rBIqCLkZZYRKNYa3CSPthCkJKwzWwiGDTwJ7Fkt30qawSZbGnBmlxx7TzbZA?=
 =?us-ascii?Q?Idx/2eUzdjAs4P8dejF0K9enPzTq2oxiU+/L1hWhKJMUWmt6vJVOxsFaaQ+P?=
 =?us-ascii?Q?BuZS2FbBn4mdInYtUUD5k9TWrrA+dIw4u1+nKRYc6ubnvCaqOGi+Y0ncFQml?=
 =?us-ascii?Q?fXDq+mHK9ID4Jf5S3uHA4v9RHVL6fPWWYwSG4aV4tP5q+3g0Eih7VebJBI8H?=
 =?us-ascii?Q?EXSWAW733xzJHSo+JaNNpQm2XhDwHMcpeuXtPaV2sfLAVKNj2VYbW9mvS9iA?=
 =?us-ascii?Q?CNV8Wy6u8JGpEYHd5unUzfAlBHGISrMEypqBeogKtUwfxRqyNcK/AT2WBZtH?=
 =?us-ascii?Q?RRk+WAZCAC1KX/ElHYwu6dg7Ckh+0aZQUnmaVZ+r/YinPQQ+PkXOuIdBtcRp?=
 =?us-ascii?Q?uftLMuYHyIAlURyBIGRJM74yPX6Wh+MuZvT/ct2yq3cgAzT0FSC3Z4MGadtU?=
 =?us-ascii?Q?IyfvwXvrbzykCzdaGu+6cYfW0XgBk0HI2z5Nox6g4FaF0qisye7LHPkJXece?=
 =?us-ascii?Q?LW1G37FINMCo753MDz6zg9niGs0zBW40l7hZPBBbq/P727JO4sUaNZoZdakD?=
 =?us-ascii?Q?aXym0g+k3BatsGSS/pvAnNp9pKcCKORzyXZcmesPm/00l16pNtTPJOeL59Sl?=
 =?us-ascii?Q?PiSTx6XTRn/chOSozJzFgvnyJfASYouK03z+XGG1GKJvifxTltNQ2Bo0+uWS?=
 =?us-ascii?Q?bbStd5/Ba9w+03LYv6020E+b06EGLsVPAmilrsux+IPAjxWsAz31QBSnPZV9?=
 =?us-ascii?Q?56ubMeptZsn2bDc/yb/stChlzWQVbIpBYiPS/A6xq6RBvEQawvXXm8kjx2CZ?=
 =?us-ascii?Q?7G8FGHppLdhwVTvCsLmJt5JBgRMrO1+y90FOEqMukfodw+x4s6I8joS3wR7A?=
 =?us-ascii?Q?clCHKwA43JtKyGVJ/z/tFGZxqfU7xUgiUVF7OfYw8OHrj4AzHoH0RL0SnfEF?=
 =?us-ascii?Q?tdFQvTMCcCALiBWddTIPAT9cEg2nrjwTCofq6uvQyX9umlh5tSjNXqjZflR8?=
 =?us-ascii?Q?ijK8ibGSFohwJhrU1H8saPMIlS6eVvD/oFM6mfryAHzi6FspZtkN1gEi7Ifz?=
 =?us-ascii?Q?VanzFEeyBqe9+AeRVufyVdHtL/Rlt5AUESfZkz+uqv8XzpPhL/8V9gzgZDUh?=
 =?us-ascii?Q?AZCz2hGIXCbgWb9Di4lsyD+QCkMuECtDVhZr0qMHnXj87n1Bio0AbcFr0VUD?=
 =?us-ascii?Q?FjcQCW+GSZSlK2QDWqOCuEpVfmtUaXR8lzNwISTCCosup9QMr8nGV8Vl4cLo?=
 =?us-ascii?Q?rW+EFvoXZZeTQTMrDnozJtw7EQGuzAlpUr2QObyY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f55af1-5786-4cf8-1e56-08da924343c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 09:11:22.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvlarotKjf3qmT7WcMfiA4xK9OFI4eCWR+J7AtvkIA94bD/AMQdMf2wfu8nC8iblvUFmaSugfZms9A9LPp4++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7542

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.

Redundant subflows are not supported in __mptcp_subflow_push_pending()
yet. This patch adds a placeholder in mptcp_sched_get_send() to pick the
first subflow for the redundant subflows case.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 +--
 net/mptcp/protocol.h |  2 +-
 net/mptcp/sched.c    | 59 +++++++++++++++++++++++++-------------------
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55442df8fb97..8888de922475 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1547,7 +1547,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -2425,7 +2425,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1bc9f6e77ddd..b6411285a0b2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -639,7 +639,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 044c5ec8bbfb..cff538a9e187 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,35 +114,48 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return msk->first;
+		}
+		return NULL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (ssk)
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return ssk;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			/* TODO: Redundant subflows are not supported in
+			 * __mptcp_subflow_push_pending() yet. Here's a
+			 * placeholder to pick the first subflow for the
+			 * redundant subflows case.
+			 */
+			ssk = subflow->tcp_sock;
 			break;
 		}
 	}
@@ -150,31 +163,27 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		return -EINVAL;
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, true, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
-- 
2.35.3

