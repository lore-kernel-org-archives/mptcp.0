Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B47B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuOPWkEcbfcCVWDqw5TJLrWprjkHBzOpQkpU8+/cFJKi6+Nohgo4X+SPjLivVPm6ICVzUrP40rBi4NiRjn6ofJO/Q2XiIme5sLFCivxyVamfHRLlbiO7TWwo5Tz0VsC1mot30eI2cBC4pbViGy20cp9c+lToYkz9PDrIOkgdqgDkZ/ZgmQJWdB68y+C4jTkWBpMAKUKx6SmYg+BniYr3T0lED/SJi29lIeMW8vUAnw67VwNPJkLY384YjjBaw5whGdjeiOtzWVFyFogT5S+yXiBSx1cN2z90SKtQMKf7pAotND0JZEe5EjZYzTcZ7utreHc/SmjdX4W5gWfhzWQUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSC9e5WlALdvL65tIcGpgi78Dd4+mOZga8dVclXuxsQ=;
 b=TxvFk97PJtXyoSQSOrnyKd407biaPU2r4gS9tBvM+5lsV2NypMixj/0UpY1w32jyGsPtBMqervAp7z/KFURQKpWnfm6WXd36v0XAV1pzCVPZtJnedtKvCl3uz+iR3rVtNcIFyTseTFfpLzfwdZu8J1kiOxmRhghNXjpraXkA05tWtvHnsK0hby9icqVd71vdb5BuA3ELlQS3uG7qCmhdbxytsNWrSXWLuc2B8atwQSnkVJFGkcCEgcuUEXexT/98iiysukQo8UkWfbVULU9GxV5nrIxCat23ImtmHhWwHq4jv570BBuiI4Ryvbit7LW5mul2aUiCQBEUPF5oBfe1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSC9e5WlALdvL65tIcGpgi78Dd4+mOZga8dVclXuxsQ=;
 b=M9LYYWOqQl47wQOCZOJi6+d2EZo6QUlkXEp8mwRTVs6N6DZjzzTH8cPp7k+xS04OIUUT9IMoP/m1Uk96KMqfBshiDAfbGj/OVC3pGKc2LkbTF1RJOxZ5AR2oZJu517aRHtl6wrQI7n1tArpwKZLuR4UDEAnGtoJhs243V00dQBE7j7ZNRv7VT6Kc+FLkqnkjDQgbi1oHeT2LHqzAYBzT+uIG4AIiMq3bbA1Kg+J4W1KQIXWJPbjc4Js+1YwVDK+qAVm9Nzc00xa2PyfcAy8X1xOVguqaxeS9YwHDRENfFwo9FQgiIa6YfIFfWvWA8b/cmZkKCACB5TgkeqtulLJ8bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 11:03:14 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:03:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 16/19] mptcp: delay updating first_pending
Date: Fri, 21 Oct 2022 19:00:08 +0800
Message-Id: <b011f073ef2e9b965235f2cb147f46b813cd2899.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0130.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::12) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: a39adfb6-e074-4509-f2c5-08dab353d970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	clxoSkS0MXrj6eKY2sRQZ73YmKBBjlaVAxQTMXMyEvl0LkwxOiDFEs6PBggLTgtUHaX2sUgmuf2jmkEkrF8VqkhiHPMStbQpwkfxLodF2UH6asEsztCi16cqU56HPhHUuTgXh9pvzv9EVFFmPg/kiB0fnc6bFUOzSKbaKEOO//nNutu6ixZxHm7XimmRdrDf1uIiPi48iYAnzSxe7xIqTg9MnaQSF/QCooVSomwCICjioZsaDEV4fKMZ8jDD7dbQWyqOPx6DnsxVY4qPwJPCVE19ImSiO3Zc4+pqKVupWzBIckVsduze7acw7i8dYzFJtxo4X4EzfhhYah2+uqUxFGDwHT+ftwBeZgYYtPL5lnIhoXC1H6yb99FrpqDQwE0ynRiII19lfxOHS+PVO0k3Meps1LeQxq35n9LRmQzeO4fXh+cIz773FFIEd+MEhqOl4TJpXg81XwOd+GLy8mIm+xAPlh6dsmFMyCP91HDH3n64Cqm3k80qEOX5pc7LBCZcyqpE8xDDm2n4TPtFvPkx4zX2kllhpzj+kke+rGTGcQwaDCuzV7VidXr6tZr9gtwjyfRrgEosLVsqDJIaVc3yHGqZyWsz5FEeTqOWqEPTbibCLxjA5yxgBZQVlWY42MfF9h6Bv92jyMAYnxAboxYbzfDqTLHqsh2Xu8KjDhllLKHaUQDw2F6HKUO6SSgubfTg41lCfsjKss1Sr+YdyN4HOLHRH+ArDwi7MCka2IM9yJRxrUgn1KvQm7gJHoEpg/Ay
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(478600001)(41300700001)(66556008)(66476007)(36756003)(66946007)(44832011)(4326008)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(83380400001)(26005)(6512007)(38100700002)(86362001)(6506007)(107886003)(6666004)(186003)(2616005)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Cq3zhuqYTUXs8VAUcHaEQeODjxsohBwlJVBG+MYPkcZBUs6OPpDCkpIe3xt?=
 =?us-ascii?Q?lotr/4uZVfNc21MeE19E+0hrQsUmYgBkJrc0l2kcoLHnnKTjRtgVtPEEvEr9?=
 =?us-ascii?Q?oAidfk5MOn1HqBXKdGYBkOlH9I1Sxptpgob2DUPtedvT7+cfrVRchn1ufpwb?=
 =?us-ascii?Q?FAjbpGJNPGeKxEFWfpQ6Z1YU3kOHlzGap4aNU/AsdedEtSnflTXeEjwJS9Er?=
 =?us-ascii?Q?L1GT0xKeL2avP8qygZ6ydZv0bjKRGxpzzrQen0AGQdodaQRQIM9qxFcPVnLi?=
 =?us-ascii?Q?TePMUA0bKm6R2zR2PHMqHQjB60Tdt9WGir7WfvNvgsbQxQhBSPCkSB6F+WGH?=
 =?us-ascii?Q?YWzrFwKkSk5zjzk/MA6xZup+eUGtv6DsAIMMR5EuHk6Lu7pwhIUHzWqMFZYk?=
 =?us-ascii?Q?bUSDKj8Fz+G+I95702XdN/0xjE1KLesqrjNPfpg6scCZxGpjcOkkG6uNlsr7?=
 =?us-ascii?Q?lHx0AaF2r9buenvZgLyczsRqPxMTW1RtI6uLXpgL5+1/dIDuKVCD6OSyd1P3?=
 =?us-ascii?Q?fHwFBZpWKnp1dVG8ouumjfHEyPGq9uBGBdMMp+uiFhuG8DBsqU40ImL7DRBz?=
 =?us-ascii?Q?Hlq4u4c3nje4ZoRmuQJq5KOjbpc4KIyiEb2VlMwcdWnsZMKDRbLI21BzZZHT?=
 =?us-ascii?Q?inrSPNX/+cRZ7FouKMiNevptc5YExMgEgDHax8dURxuIKnpjumY6kEtP72i/?=
 =?us-ascii?Q?d+d5aKh1oLSqS2fotH+V/xARZflISUQLNhsZRGTTdp/N0JSeiRLCpcZMW1rg?=
 =?us-ascii?Q?Ic1O4TOuLf+E46XvCgfuxmQcRqosjZZ+7cLvDduM6Lmq6edzNnJl+dyXp9ss?=
 =?us-ascii?Q?BN1EsikmMKu1jXvU9e4fT9RIO4CTrywv2yHolkxwkX6o718W1LlqfpjoYCCw?=
 =?us-ascii?Q?KXhJ5repWEvDfUmnm5uXPIxaolw5rf8XpIzEwph8QLZv6xePo7pT1CttVGsN?=
 =?us-ascii?Q?Pm4g765cvg97c0xNKAN/+qiviUOPFfs92JEdQ8gnwdygZfd41t4HunaCNALO?=
 =?us-ascii?Q?MNf5QWo2RLEIhWgs1WAtmiF0GYHhEbKbFsdCdFaHSw5GPnPtI5+kcv9ptKmp?=
 =?us-ascii?Q?srbAFeQK42cPwW/lRoMhrH48qikEbvK9UyKBrnmVanQP4RC1sLW9BdvYeAEh?=
 =?us-ascii?Q?+1rBsERwtSTpx8JBohaVeJAFBzzCQVRDDNnICosaDYLkLDqbceejflzrKl+m?=
 =?us-ascii?Q?PomdcxbqRV2ZGCVkSROwkOOYFZwHxQGhRjLCk5XoIrX0t/5WREEH8ufKxn2B?=
 =?us-ascii?Q?UZMWcpK/4igIopc1xOoCMhIsBo/4XYpWFtoMSVTy/675t5R7ViHvThrSmOhq?=
 =?us-ascii?Q?M0RKZHaPKZR3rwJ09Zm0RAZwD/EhpV41l/AXkSo40tAT8jeqSSluWF3Zm/vD?=
 =?us-ascii?Q?GFrKGrHPcgjzkuJH+5YIJvec28b92Rj5A6LLPBfxVMcXFeilVgGdCKHOV3cO?=
 =?us-ascii?Q?N/a8x79bi0O0J3UvD0q/YA7lJ4REue2XjF0Kbl5OzTqP6pUhv9NI2tl7w78U?=
 =?us-ascii?Q?TZxaBcIOUoIRIFOn5a1/ltw+b6zn/Y6ZJom4EAztJZRcBX+GXMKGr7e86FX8?=
 =?us-ascii?Q?XpLVx+xEhrpX8jTYngI5nAoNplL3AeRoedXOGfm+FI4jjlyqFG/9mhSVN5Zz?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39adfb6-e074-4509-f2c5-08dab353d970
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:03:14.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEuc/1svIt0d1ZYzXttE2Nyx9SSQnwoZpBBwRpTtu8+Dh3AhpzCRsfwGslgGBLkXtmVQeToJhqO8Shhp9z7uEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884

To support redundant package schedulers more easily, this patch refactors
the data sending loop in __subflow_push_pending(), to delay updating
first_pending until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
 net/mptcp/protocol.h | 13 ++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3e8e06448261..26afec5bc212 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1121,6 +1121,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last_frag;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1511,6 +1512,14 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
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
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1524,7 +1533,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
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
@@ -1543,7 +1558,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		info->last_frag = dfrag;
+		dfrag = mptcp_next_frag(sk, dfrag);
 
 		if (msk->sched->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1552,7 +1568,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 		mptcp_set_timeout(sk);
-	}
+	} while (dfrag);
 	err = copied;
 
 out:
@@ -1591,6 +1607,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN)
 						goto again;
 					mptcp_push_release(ssk, &info);
@@ -1600,6 +1617,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_first_pending(sk, &info);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1633,11 +1651,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
 			if (ret <= 0) {
+				mptcp_update_first_pending(sk, &info);
 				if (ret == -EAGAIN)
 					goto again;
 				break;
 			}
 			msk->sched->last_snd = ssk;
+			mptcp_update_first_pending(sk, &info);
 			continue;
 		}
 
@@ -1658,6 +1678,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret == -EAGAIN)
 						goto again;
 					goto out;
@@ -1666,6 +1687,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_first_pending(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 74e4097f9ddb..262ebaf93e9c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -347,16 +347,23 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
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

