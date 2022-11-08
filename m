Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2071.outbound.protection.outlook.com [40.107.104.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8B323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqnbWcQ1biTll1RQQXyCCnbb8ZrRLwltu7YMF/pVUM/PATg9Z3jtVSU6JCkeRtDp3M0FQQEvO9R/hQInkbcDkFPhc0mv/y0JkU39dQrErJ0zW0qm6U/SceI+ednbK3BkVpmhObVaqv2fl9Sq58yJUbmjWxN7mbKWrop9BZkhJPsS1odwjMF6cyR7r/OGdLPIlGit968SLlY3kfa6njAIWeHeJwiX3iXr2kA2kutoIKamGJnbqo+b2eVTYCZY1ycMlIF5Z2elbAA1Nx4j2a/COKwvaVch0pKRVkilYO/q+eAo2bAAAVjU6WlLqP2R4innq5NkO6B7PvGjMlsYb/y7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAqCB9HW/sT1DI7p7N8dQW9jz/S37INoIbtSaastIrE=;
 b=LlEgXvfJuI7RKUd1wwvJgp8uDQD81Q0xDKPF8uHi0GhiDKIDRJAwLMeUUNP1QEQNz6Wkvwwelp133KC0QV32xFqi9goobWlGFEHR0ixdKXarF7vRXSeDm7CshKxsnYnJO/D8Mjj4X6edftrDdnX/4sM/65VRjRWt2eyF+4iOAF7nl7IHX4Krxmu7BtZUfGz1PFo9a9O4Wtt61u5m+MZqbZ4fIHFwUaJ43bfR5J1EBEWMFVHx4hDCRM4Hg2jh3j4qtRwSeNBnnyI3vXMtdGE9n8AR5s+J29lM0ljjWMr9tE7T63iSHhYDyKoa6KspXqTea9izJ0RgfaPOljYxvdKqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAqCB9HW/sT1DI7p7N8dQW9jz/S37INoIbtSaastIrE=;
 b=0BWtBsMnQ2EDEoJlk7rytNRYFS4Ik+3Zhls6ywwxhM81EOP74WtbD+w5Wu7x6VgYrup2NBvITO+JCVDq6N01qRU1bVo8/C8Xs2GkG6wmc5TIe0Y4xvekHbRrS3mWqO9Gls42Nqy7ZGPikNXeCXJFwqZhnfxE4PZtIbOGCQZ/7Ibp2k8YtfFWW/jXZJf19nmm1JmGcCYnZMerAZ7l2D8wVVKUbl7HjRD/4WFeNg9N8vk5lXzhNenf/SzkpKhYYJfs8hiiRFM6VCzvF2TLOBUFpm+59Z+NNzxFyEwvU2mDqLyv9RZWm5b6dyc1QEijDexrAWumb3YvlgZjXvxFRf0/AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:46:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:46:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 12/15] mptcp: delay updating first_pending
Date: Tue,  8 Nov 2022 14:45:11 +0800
Message-Id: <0e6e1b9ce7046b836d0e9aa931e3f4e98517721d.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cce3862-0d9c-43b0-8815-08dac154f05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6888LLNgYwlfmXZEsheajJBxZ/g5iw+ZIN4U1mtTnHU6KS6fARvPL0Pw2FOaDwFfFU3m5fSWV1rTqyz6jzIe7MbqNRfHTlBBpq7nb71eU5EHsW3rlziW6/uDzsXv7u8hl/0nHSbbV4AbMvwxXLkRK3Brb+nMBn20icl7FbQjEpt4lPyp3/85H8kEQQ0DHruysq95I0Z7Ogq69P1FIHp6UGJy978N7Hzi4sOhd2D9CFpULCOpNJkHnap3iutgrJYx9iYRnmJW9BTtljDNAF87dPmReXWk1yw6CdsfkC/zf6nBFvzecBfzVzcm/pw7JHOCNe3ElyLnG8nLDNcXuXJdd3rXRfbwZCO34D1mZUlInPfdRnMF+2r4eADA8T4Kvs+Xye9cYxCrRpj+/Vw/5qy7QrPlh43diEmT5XKByxnJQ8rjblCKQJ6fKShwk5vTxzdDE3/kOl3Qh6VSQP1Y2O1uu+dA5M1qS7ECC17HojBse1tO1J+L/0oZd5hB/gz3ggytOlHV3g1vOETQxBrwJjpe27ucXMl8LzvPrxj0gpVjq4srV0o9SAIJjDeDuz3xAJTs3Jp5B8/fFyztBeF3K3otLhObB0r22a4Gib2daH63CyNdz5djsnG34BQafp6kydgK5frp0Bn/jmxILlSva0dOvs1hvsSgrIkrg8Q5I/f9NSs+I6AJ8PP4K15tSvahTqXjF39i25LH9hk2SM/iwOy8JWrcUeunD7i5bCqQZoNSwv7uW65uGC0oiQMqTufxvqRL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(83380400001)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5U5hKwMMz7ripvlwgws0lft/Txm084oq4RPqdsAg/KkyDrfnT53TZGiasBg?=
 =?us-ascii?Q?ltLKtsTu5lHbuDGieOujKO0LNAzcFRe+3XSQRRYHAohXwzdW6vp9GCsP4nRe?=
 =?us-ascii?Q?hdBAzaR2Gfw+iZwdj/zZspz+5+hN7FwZokmQaQ6yHbEewPW0nKt9ZMT3YmaK?=
 =?us-ascii?Q?LcDPNo/pS+mXqmFVUSDmFqFUI9sNYnDAAUK4t0/1O3fgDPwUAEPse493MPQ1?=
 =?us-ascii?Q?OEULpMydvutR5p0RiZE5dN7EeKdJsp5n+atnBGOf351+eKTUG9UtibKLiWC3?=
 =?us-ascii?Q?HER3E5jmWJLNkjjh3toLkL9uuBUzeuMMqOQoXKp9/pK6Xl/dGF5dBxLQRr3Z?=
 =?us-ascii?Q?Dr/aQWI0TUkwWADEbdW+X6k6aIVqYfB+V7OtsTZpibhrfyhSmXZCSUyDLsFe?=
 =?us-ascii?Q?6oLiuok5wmQmBGi8f0uflu7HYyuY9iE23Kb0NMxgbmKbDsnK9vcvVouICNXx?=
 =?us-ascii?Q?Jjlklr/CXYnOwd5RCseuHh4J+oHYS6BimQT0t9Mg0MqC2XtdvE49zUQQFhnO?=
 =?us-ascii?Q?AFWrNqgHRotpnI4ewyc3hvRcXs550czL2zURSjs7OFWuw1CIweXC1LnkB5IF?=
 =?us-ascii?Q?LHEgMgUxx90HkLX/fF+YGXTIvKdiJxNvNJulTaiqY9FItrUStzotGozRBN54?=
 =?us-ascii?Q?f1uXVFtewgwwb3Fz3mYd8gHe2lpHKZOmTlI2wMrIuMMa+MZdx2xtoDTvfS2O?=
 =?us-ascii?Q?pTfGWgGQLL0PGKci0eJ+5cwAZLG3KPv/rX2iduaNLjVUjrUiUCmSrusrO27/?=
 =?us-ascii?Q?KOvM+lZwdWESONA0z1DdCrr1WlChXbdLE58DHjIk6jVy5axkPp7XmyZ5Peyj?=
 =?us-ascii?Q?NnXihcqptUDKBL2CEg7EI5FLxZC2xPjUKh+Ar0FCqU23rcByfmhlqFNkelg5?=
 =?us-ascii?Q?STA5RV9uuam4Sf7Xvbi5LyHnAROzX7Hd96OG/jDnRRlUAC/4vIHJC3YlNg3s?=
 =?us-ascii?Q?CGN1gEQ9OLyzM6GNr7GjZmL7KMEaWKqYK9LRorBgIZSr1CX8Bxx6oVfLNNCo?=
 =?us-ascii?Q?DbgQzlGU6usS+l5idqn2SAZwJyDa/UyF5cLWy5RdELMgVBM5jNjgubxBJx8/?=
 =?us-ascii?Q?xsp4ihwcp8C1Pq13Rre2oEPuR+8B+NKno6mQy/aLWj0h1m80roNdzLgtRo0D?=
 =?us-ascii?Q?PhdSXuLAa6GKdg3Um2FYEKNvXae62VSQ54cvMsPceuCQcE7r95zAYxNBC3Wg?=
 =?us-ascii?Q?mFGrFP8HCJaDj6l8staiq3kcwaUjsen7AheohTC6xLsUz/lhSs0nYYqFvBu9?=
 =?us-ascii?Q?fsXqOSgSRYkXs74KNkzG82n6yJuDEx1thffXGJOQHbe63Nb8/WEYWG3hzNPJ?=
 =?us-ascii?Q?X/SIEm6FzkWaD7FeEZoEpNRT3Ts5bBXhEVJhaawWvvo+OAvZfoQWhexFX1vl?=
 =?us-ascii?Q?Ri1zW4JmT0OVCSRK/OwlLfdwN9DnRBHKY/xhfQuiHvxUnTS2QkWHG7OexZE5?=
 =?us-ascii?Q?21EflMNGGshM5RNl9e3K7aL5gW85s3RUzT8OF6Ij67w7amVywMPbSyGyilES?=
 =?us-ascii?Q?g8VwM0TC5qQ53Dg7okvjIyu0ZU/ATRpk4RxhOrFK7Wwpo+J/unEBh4oRZpW1?=
 =?us-ascii?Q?T1tyy5P6QQgcki02jctxrs8qLS/iR4ZtSMVEQkIo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cce3862-0d9c-43b0-8815-08dac154f05c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:46:18.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwmODX3Imelmpb1P3uR45OWSEo81pWTKXB5WveInmYLQUeZpKnSdo7cD3fSFIpRExFaJWGFDtpCQywhDzj09kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

To support redundant package schedulers more easily, this patch refactors
the data sending loop in __subflow_push_pending(), to delay updating
first_pending until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h | 13 ++++++++++---
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 06c738961348..26b08474351e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1121,6 +1121,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last_frag;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1511,6 +1512,19 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (info->last_frag)
+		WRITE_ONCE(msk->first_pending, mptcp_next_frag(sk, info->last_frag));
+}
+
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	mptcp_update_first_pending(sk, info);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1524,7 +1538,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
+	info->last_frag = NULL;
+
+	dfrag = mptcp_send_head(sk);
+	if (!dfrag)
+		goto out;
+
+	do {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
@@ -1543,7 +1563,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		info->last_frag = dfrag;
+		dfrag = mptcp_next_frag(sk, dfrag);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1552,7 +1573,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 		mptcp_set_timeout(sk);
-	}
+	} while (dfrag);
 	err = copied;
 
 out:
@@ -1598,6 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN &&
 					    inet_sk_state_load(ssk) != TCP_CLOSE)
 						goto again;
@@ -1611,6 +1633,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1644,12 +1667,14 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
 			if (ret <= 0) {
+				mptcp_update_first_pending(sk, &info);
 				if (ret == -EAGAIN &&
 				    inet_sk_state_load(ssk) != TCP_CLOSE)
 					goto again;
 				break;
 			}
 			msk->last_snd = ssk;
+			mptcp_update_dfrags(sk, &info);
 			continue;
 		}
 
@@ -1676,6 +1701,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN &&
 					    inet_sk_state_load(ssk) != TCP_CLOSE)
 						goto again;
@@ -1687,6 +1713,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f8cc14064573..4b13ba9df34f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -349,16 +349,23 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 	return READ_ONCE(msk->first_pending);
 }
 
-static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
+static inline struct mptcp_data_frag *mptcp_next_frag(const struct sock *sk,
+						      struct mptcp_data_frag *cur)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_data_frag *cur;
 
-	cur = msk->first_pending;
+	if (!cur)
+		return NULL;
+
 	return list_is_last(&cur->list, &msk->rtx_queue) ? NULL :
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_send_next(const struct sock *sk)
+{
+	return mptcp_next_frag(sk, mptcp_send_head(sk));
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

