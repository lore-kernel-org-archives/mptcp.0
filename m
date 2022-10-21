Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2075.outbound.protection.outlook.com [40.107.103.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A97B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNfcfV7YGGFRiRyAH8yPY+XjDzDTZi+4VuD6duwGJnqn6KEZmq9YRd1zBB/TO0Ys2LF2nGrTnmb6d4gc9lWpo8G38TihKNnm01GXSbZG1hFa9b9LeeyOPqgRe6K2mWgTN1s4NJ32jX7DlUg6Too6rGiqkDTWzGUS9DG9kBtyKsc02fkRQgNCxL7ABRnULmh0gbZDcy9wYrnIosZZ5JG1f9IhtyCqmSFtgtX1731jgYM/OJBwGvhsfc8nG4Q1MqJCeoCrGVSZQPuzF4cb2vVZsVcoOpneoTVtbhBTbJZJQJkYtHQxkprFIlVV1y6KeBZa3mOV2thz4WNOY9vgj5Z5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsy1TKYm4o5iBbv1kiurZ+1UnOMGb9rFmN8R8mi6nVo=;
 b=aS+0W9gtKjDjRxQf3t8AuqMFYRehWDKU4zoFe9eUYTKZ+VbsZjYWFN1cx83+PDtsaFJXF/ELMz6eG5bZSnkn9iKMY9qcKD+bhpCx7pHsJf/CqzQv1/QStprJhvDLLceMj6TvRPfZPaOBInRVX5nXPAOJxIiLyGGtit9ZcSEwA+UDKCySQuvvNgig9W7/KWIctNHthPS8x3S3uMTOddkHBkbsXjiq0jVhCuqfk7jnDn8RIKBPeULgu6RF45xNdn/VxWlh/WbrRzYmrukL36+8H5mh4jMYNE8ZKZ6AI7NadiZoTzFaEAtP093jS8Dw7Ecm2Y4G45xHUPmoBWlNulwBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsy1TKYm4o5iBbv1kiurZ+1UnOMGb9rFmN8R8mi6nVo=;
 b=kXFhNz8ZoKqSYOlVn59nBpjEcN2ATpB/BBOJetYjd8WoxwUvAfBQGOE8EPSbcKUbB1B7wrMl0WfZofJVRJZVDO8K/tlNj/um7Wn6oZmSKLwMY48TZaYMuGWnQP040Ufb5yZKEU63mD5OMKlV3exnF8HLCW1l3h0v52O9S9tAMxMZSH92mTjvjs/QDjnhiHFGsPT4EZGQ0BeDtfjl8x17W58fLqVlZrFYHGAWTwAg2CKt8VbfmIj/eEpsMasWtFDYCo7UfMP5TncXjLBfh89TRcWsITvv0++u1NQ0pys3Pk1j1DYK3XXjLlR8n+3Jw38I1ulY25H3CsmI0A7Zc7KZUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 11:03:23 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:03:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 17/19] mptcp: delay updating already_sent
Date: Fri, 21 Oct 2022 19:00:09 +0800
Message-Id: <39168335db0f872ec0bf65bd8589fd74edacc363.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::13) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 77eb903a-16eb-4385-4bc9-08dab353def4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wgcvrrIjxTUtWVxwttx6rI9U8/o4hDHekeypRON+/vEYf8K4dkf7taVSgLLBtMSegiiEZd0yerJHarULxajhVNI6EnXrW1WX+x7ITSfBLgUBbCyV/OL9SrilVGGee/WzFksESiNIfp0TYCr37/vagZg3DP+wQselmLVlfaunfeaogezgKIVQehjebqQWSwIZpE7LZ6OQazL83TtQqAh91QMHuhFOTMS9J4m2SRMmmESfpXj10P+6Y6xiqbOvwamIPHmFKGharVdyRFNBUeMVjbikmFbcoCNawKDxVhEEHVzj08EPgTagPZqw3aaw382bXzu4VNmdtPJzlc8CmSG9Sl019c3JHQ8tSj0ZU9hgsXx9F9rF4LnM9XhpEsLdCeQB63wl5cgsnpTjfd5dLBtNeBka5BY87COXs5cqj7gCEDtpbptHXV6GtpK9zAu6ZPw/12mSWDcFEaAdjtYCWzAezu7GXErnFfhqmDayZQYqtp/QHVQhn4j9HCaHd4TWBdFKLKnbin2Bm5OnZHnosaqmDnQM3jvNLyapllDdq/VzJcX8fnaE/jzlLGEoeYuQ84necCDQ6Du82sFjnxf8Yg3ppwkcxlkYl4IL/Tjf+oVO/fDNp0ztstzGfkaFV3QMyh/SaNKLMKtvJ+YMKCzMIdSPnTzxS5OnO3o6ml4k3OrluKodxUCa+p7MLOR4XA5r8a9qB4F+Ipxe4BiOuzID0eubsWnIOdR4sP5NuwyedAOO9dThmu+sQG0kVxdHnzwQlKDH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(478600001)(41300700001)(66556008)(66476007)(36756003)(66946007)(44832011)(4326008)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(83380400001)(26005)(6512007)(38100700002)(86362001)(6506007)(107886003)(6666004)(186003)(2616005)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h1/SUDE5w5XthGZDj94aEJ2QryesvbP2xts7iwWkR5MjkzkcK7QmaRoXvdHi?=
 =?us-ascii?Q?Q9ZQPcsDHQyvHJ+zSPjbEATbQx3xOW2rYsYu0raTl31AYrTyyyvkI4yaiX5O?=
 =?us-ascii?Q?6JAQfXwQIgjUsl03a86GKYT5B6/e0cauHpPYkOok8zET2+skP3XxnGHSu1j5?=
 =?us-ascii?Q?uPXu/JF1ghom7AWPUruGHZ4p7EC7IBdcgLDjxrSIC0Hx5l9/r0mVK6NEEWFX?=
 =?us-ascii?Q?iPbSd/NmBc8vTsXE7y17wjXxkJs2JlmO2gor8vLAezSQdLRHplVCbNlKxAco?=
 =?us-ascii?Q?JGsskit2EkzWS48rqx0f8cglZc43wX7ekBrdoayMPeb5jC5E4XaTS3LRdB87?=
 =?us-ascii?Q?oOoKkdE/3c02Z5T7rfSn0R7+GPx/8/EAjSGPbPmC0Vii5Wy+g/k5GJxDWLx2?=
 =?us-ascii?Q?e7G/H26UWf4cFRqX/lMw7IGDAnaJdLJhg+SsCVELcVGimBnwCzXt8c5dmrov?=
 =?us-ascii?Q?rX94Z6cGobABV8TtJ5AX76mjJu+OIhypR90Ok3Ov7D0GXQgt8MS4LGr67gOm?=
 =?us-ascii?Q?WxWarEy4pja0uo7iEGUWI8gnSv23aMqSJUyndKtIv5wrk8Bg7TlV3LKJoedf?=
 =?us-ascii?Q?TRFwcLgdza3U2/D1l5XA8l7eVDnHWkOkNjlSfi2GvfP+XW/J8OnF+mGmUOqO?=
 =?us-ascii?Q?M7ZTrXUiE4bBEMSUIs9/UmjX3TcolDBcQVcRvujLsT5WLe+WtCLXoNcX0QgS?=
 =?us-ascii?Q?EMYsnOxRQiWMsFKe0w7y9XkXeqLNOK0qiCuz61gXmA7cVVqYWVSaOIXzB05K?=
 =?us-ascii?Q?5OvKSMNNSNsQi1jS+eC3UktxsD5P+ZyeGyx/SLiS5jKJ8wKVMYWbN3tsQiOh?=
 =?us-ascii?Q?mY24hp4MldcY1aK8z+z7C2vCkMs2UOgz/vFolyP65Pe2mgAHGU6XD0tV4XtP?=
 =?us-ascii?Q?rfX/DKpl4VAqLdsAvremPj1ZlYFxpNcFr/pGrEM0suuE1lOZ+mlYslbdm2hw?=
 =?us-ascii?Q?zYkks1RJcaolQLfZ3JN+jj/cgEMKylI2kAfgL7a3BElBX5e928nJSOtmu5bK?=
 =?us-ascii?Q?jEnKbU3y/8gnGQCIFbFzRPHt5aMFsnny4NY2e3IB4WPqIP3Oiy84/DHWRy0Z?=
 =?us-ascii?Q?KZQaVjUgMz35LdGceXzA3m5JCQTlBCjPqlPM+O75WNdDv6JblUUPp5wl+A5j?=
 =?us-ascii?Q?gPL+MZ9EM8y2L0kTVjR1Npx6eWP86aaJuon6XvjqoBDRSc/x0l0L5lEIqDOV?=
 =?us-ascii?Q?0unZ3qbSd24H6aNdsoWPzlsou8Km4LlvnaLFjloDrR7+Jtgk+iCMvr2fJxX/?=
 =?us-ascii?Q?lEsU8zHGPgcII7xX3ASkmDvT6bqdevuW2AauGaO+Z0/VdzSvEurki/ivNwV4?=
 =?us-ascii?Q?MgBshq3rfG7IhVqd2DvWkphzFrA4YI/eoyeHngMvn8UfKLKZxRS8VSqaypDy?=
 =?us-ascii?Q?t/b5vnQkYWQXthsUkde0trq4licHj3O4ie3qN1KTzjDntSjvSU0uRdA9b+uk?=
 =?us-ascii?Q?brOgCEKZXOootkwSnkjiRBu0hqbIC2Y9OGXJOP2L2BPTM91qGoR+hoLh3li5?=
 =?us-ascii?Q?kueYKcMk2WNLNYZLMCE6gmckLuivoOUuLeecdgTtkkzdiomnOBAqv1+0uoNg?=
 =?us-ascii?Q?bMN3Jaag3P1a7V/hK6JzUlxeOFhnxjK6M0+ZHrhrfNI75QnvRPxbxLr2syca?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77eb903a-16eb-4385-4bc9-08dab353def4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:03:23.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNLO39uBk59QVItUEdA48Ys2dX3qycfiEPZK41VUbb5nCwY7VGT/qD0tdOnGncKx8djOKwqA17pYSuLxqgPfGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884

This patch adds a new member info_sent in struct mptcp_data_frag, save
info->sent in it, to support delay updating already_sent of dfrag until
all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 34 +++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  1 +
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 26afec5bc212..9ea3af9a0250 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1108,6 +1108,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
+	dfrag->sent = 0;
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 
@@ -1243,8 +1244,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
-	if (WARN_ON_ONCE(info->sent > info->limit ||
-			 info->limit > dfrag->data_len))
+	if (info->sent > info->limit ||
+	    info->limit > dfrag->data_len)
 		return 0;
 
 	if (unlikely(!__tcp_can_send(ssk)))
@@ -1493,11 +1494,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 {
 	u64 snd_nxt_new = dfrag->data_seq;
 
-	dfrag->already_sent += sent;
+	dfrag->sent += sent;
 
 	msk->sched->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
+	snd_nxt_new += dfrag->sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
@@ -1520,6 +1521,23 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
 		WRITE_ONCE(msk->first_pending, mptcp_next_frag(sk, info->last_frag));
 }
 
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
+
+	if (!dfrag)
+		return;
+
+	do {
+		if (dfrag->sent) {
+			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
+			dfrag->sent = 0;
+		}
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
+	mptcp_update_first_pending(sk, info);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1543,6 +1561,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		dfrag->sent = info->sent;
 		while (len > 0) {
 			int ret = 0;
 
@@ -1553,6 +1572,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			}
 
 			info->sent += ret;
+			info->limit -= ret;
 			copied += ret;
 			len -= ret;
 
@@ -1617,7 +1637,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
-		mptcp_update_first_pending(sk, &info);
+		mptcp_update_dfrags(sk, &info);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1657,7 +1677,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				break;
 			}
 			msk->sched->last_snd = ssk;
-			mptcp_update_first_pending(sk, &info);
+			mptcp_update_dfrags(sk, &info);
 			continue;
 		}
 
@@ -1687,7 +1707,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
-		mptcp_update_first_pending(sk, &info);
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 262ebaf93e9c..64a169547b2d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -241,6 +241,7 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u16 overhead;
+	u16 sent;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.35.3

