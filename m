Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706F653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtpZD0YJ8nJeaDTxRNFfS1O4BMslgYXnC/fwd8txYqKFavK89dAOdIo4MmNxYlmrjVzkk73ioj93vqPP2kup8PNpw15O84W0uDSe1flaBFGDlP/6nbUZOtxUPj9waoIsMuIxIbn1hpLa9X8CxMiA8tXowP5zAbAiKjqAvZeUnKL3G3MmqPsiMJvPchtbf4Gj581hXikwFdTAUIDB0/nO/I2iaXoCEY0Ol0z6UeeaxHW+QlSBzTZQj3V3EJsA0fVYICzBcrmbW8geqA2EvCU+4RZK+s2WfjbyyvnCsDeXbxxMkCQGgBQ6thEWPJsZ74G29Xh63F2iXAWebXCYGbxEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEof+zNd4ZJJJeGkqEj0jVYdIi8hrMp+Ks7e1KSChwQ=;
 b=oM+sx8cAz6PKluaozexS10KhnRou/EAqDURKF15XevoeqrrORxP9VrnSlavn06X4dxL8h5k1sbCQTxL8dUcnGQpR1gcEWO8RjvsKkVwuXdwLtCbRJK3aXF6RWWPRg3sIGZ29TjBKW4cOmx0WUiOpIJyGEZHwZJuQlqqTCLQ5CF2Vitqa4Tm34iu9c5Fa0Z1OwOb7GKMt03Mrmyn1iTf0xexCditA70iZN3q4LaqrVijoNCxADTaKgdeerwNaq2eZFS9lm9Pqev5eGfZhEuUdcMqwsq74NinAwdbMBu+ZhYu+pM4shTwZqGHyRBSJXtqozEn9RyAo29NTT9jMj71uxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEof+zNd4ZJJJeGkqEj0jVYdIi8hrMp+Ks7e1KSChwQ=;
 b=oCbyEaWd77MCw0kqXX0UzXzsdmIFg9tBU4K5zM1sl7Se9iXoiyz/DUzMr4Jakrn6SR29cxnIco+M3f4LBZakE27bQct6pHJqnvDeeOwoHhT/jXVSzZpn1g53lIB5WNs3KvNts1zIyGK6vUwisKNN68EdSmBXu3CTv/C2cT30xoXZHkwvfMyRAKpJNQsi7MxhAj59cVsoVjo6IZ7TyP6r9BgY5VWJkv/ijEQ1gUd46gdV0bUZ/OwDItgKhBD1l1QZTgzLqjRpks6mGvqAJA54NK+jCzeRJFK2Ek7q06S/M4OK8UPZKgQBhfLCc8W2NbE7bmL1QDxuONaSJSwzo+ECqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:39:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:39:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 06/19] mptcp: add snd_burst in sched_data
Date: Wed,  7 Jun 2023 16:38:21 +0800
Message-Id: <f2252517adfff9798e1b70fd8c1c71450ec1bf68.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 76223d49-df4f-4d47-904b-08db6732c1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kfYNIkWa+OI0f2/Mb195EO2Je2QSbpp2tml6hD/3yhTrKdkXimI0eIAewnrNMLAirdmRGfaxne1M+s3aTzU9KLK/NzcKUVH/XGoStu60E0jccOqcqrAFS1l846dfgflH1+Lqm+3EnPp9rZawvLdbNAJ1bKynH4bq4gDW+h6WFVU3+WIq1cfYo3y1Kc6+PlADo+04AcepVNz5kelIKYXviQSSs5cfMkH/nJRlsWB1CYiS3rZf0nCbUxxT741gFAfjT33xrz/mdFSy+1FRfdUcWLrTFeTcggs5urQnqODmpIr5c6pPU9iWKNZWSUXo91PxMWFHo/MNsROPEtq3mWI6UOOecbut3S/HZQ52Ot97WMpZnVrq6a8sTh6LNiJnFk+R8IUhoEaCrydHAn7Rm+x2Th57Uq+3LdpX5s12v/DYY2j0c+36/AiHcE8DAoPRIiO33NxhPdZGIFOd+GViUbPIh2cAMqKQ15Uekk/pCVGIdhFO7/NTlEJADgHbAEfFNHP8+n6T8st+2tZcG6eOkn0dcEQzFch6blRTM/K7fCsm1vcdBmMCfUUH5BTH85hlAwdN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J+zkp3gaFeFOJ1AZXYRY0E5yLhWsnBACPNI4BP8FokSdwKtWgSxqLQ0RGyGb?=
 =?us-ascii?Q?thIas3zbPe7QJUFCV2XXhgW8fEwelISkhs9GNGceJxu9KoK2ws4pSquv33D1?=
 =?us-ascii?Q?3BJkrJLGFPMEl+IS/gpeIeOIu3QIcDd/okIp3SPGoUflKCUEqAF8R0pV5Eoo?=
 =?us-ascii?Q?2ZMd6y03lD/puVLRHU/GR83Tu3l8opMzEAyu3aVzeLs69nfdI/FkiydC0WPC?=
 =?us-ascii?Q?W1ARjrhtteDpp12uVVpmKpUMQVTuuVD52GPYmQ9i1vc3QVv5+oAYuSM7uFC6?=
 =?us-ascii?Q?Wz/ouzseQgGKIRTwpbX/elwKhrFY6vGXCKGDpZvAC4tSSt8UYcXSCjpEtkmX?=
 =?us-ascii?Q?j2ApZen4cDuzQLL7LyApO5mJQOg6cR//ODd11c3l/PWYcjT/xBT8+sMUykOZ?=
 =?us-ascii?Q?hhG9yNuvJs3HnAQs/74peIWREJ/Rd2wzwzfxVvyd/6T4v32X3TevemQf98C1?=
 =?us-ascii?Q?gz5R92Y1CQXNvCX7t7Yy/kG8eDg02BOfszJhb5wFgjmQEUTCNgcYpCmmTgiz?=
 =?us-ascii?Q?QPUabY1uElMpga16MK2Jvs6zP5jHYTwaE5ePLwjoTWMe7qqrTsuDcfURWeah?=
 =?us-ascii?Q?RT55UQdbOmSqc1sHYtbOjtKWMupFolYFgh3T8tyLsqk8RqYzttkuFL11iVQO?=
 =?us-ascii?Q?26RWZRHeAkMRqaUdtF24vVxeK4ksKfB6HJV41iliocjx4Val6CDkmru9VfSL?=
 =?us-ascii?Q?Oi8YAh9p1HoIIHx2h4d9IScxU12dX9QSSwCXtMPYI8rhpQJBJwRu4CoNS+dj?=
 =?us-ascii?Q?RcTuzwAsnVywBfXgh7idh++h0ECevKlbMgqSIg4l0zMTueMG+J1u3loZ0L7z?=
 =?us-ascii?Q?5g0IyjS6dV/Tts61D7yYHwDKKda4HUYxo6s+dNM4aL2U1z0mHXwh74fWhfMP?=
 =?us-ascii?Q?+SlQaVV3aL+SJajjF7I9G3O+LQaspIkJr5WDeJkxWGI3pp661pCEGZ6S8FC8?=
 =?us-ascii?Q?n2MIWzmapdjkYS8ibeD1bXZXZFTfLXyy90RQFrtIrL2OLH20Z4QRqdVlpW7v?=
 =?us-ascii?Q?vGnXlC2Rqrn/Qv1TwNJ/wikF0ZjdmBQCxlUnjW2ToZAo184/5XGhByekJ3fQ?=
 =?us-ascii?Q?64KPRBLL3QFqocGh47ORAiJmNtYK3deD7YXFu2pvzI7ls2xof2cMoKZu2Xqs?=
 =?us-ascii?Q?RjQS3kx5sVcR0sk/UjUCNCt93pynfz9L4NNjhFnQLY3P+h7DClvZ1tb2Qkwi?=
 =?us-ascii?Q?muSWauAVoOAiws2vVOgASg9r/XwQX+NrEcj84ojLaZYWvoEjbafiu1VrRHm4?=
 =?us-ascii?Q?OC7AtS6g9hKNJnmEnAxP7+wGnI57gKplnJqrDkrUco9bqYhSDWJgUp/TmOPv?=
 =?us-ascii?Q?V3dNGfrBY93r0ohN3NRIGFP34HuEcTSZGwuT+ICwimy2qFpH8VNI4vkfX6ar?=
 =?us-ascii?Q?ix3CbE1fywTKRKfiOQsZwbcz7XlTw5pnXfURDrP7nkEKDsU/avLUhQu6yrjv?=
 =?us-ascii?Q?EyyD+omOro/u8UsjCKqDOk/w4HV5T5Y26PPMSYKFNXabrNdAkW0XYL+XrLp/?=
 =?us-ascii?Q?W2WLNvpIOpAiaGL/x8CZl3C9/aHJhXeRhd+wDuMMYqzt+0YM0xS+Bdev+ard?=
 =?us-ascii?Q?uFwdCUIvNNKhRx3IOuf+7zdQwnjginOhFDvQ5Mx4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76223d49-df4f-4d47-904b-08db6732c1b1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:39:50.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHB0pIQXwLFNE6Z2/zQjKdGs+0L+3Yw5LdXGGV3yGb2najxF9u7oQLYUYmM4812Z+MnLWMCqZgnx029ffr0Tow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

This patch moves the member snd_burst from struct mptcp_sock to struct
mptcp_sched_data to make it accessible to bpf schedulers.

To make mptcp_subflow_get_send() adapt with MPTCP scheduler API, it's
necessary to make the msk parameter of it const. Also an new parameter
sched_data is needed.

With this change, msk->snd_burst should be replaced by
msk->sched_data->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d52aeb8b4485..fb4e6a59afc8 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,6 +101,7 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	struct sock	*last_snd;
+	int		snd_burst;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f3e1a0c359e6..71fad937ea0b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1414,7 +1414,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1484,7 +1485,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1502,7 +1503,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->sched_data->snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1555,7 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->sched_data->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2352,7 +2353,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->sched_data->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 949f46d4c710..a4db0f8f00f4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,7 +269,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -668,7 +667,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 2babc377cbf2..130e53ac2c55 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -151,7 +151,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched) {
 		struct sock *ssk;
 
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, msk->sched_data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

