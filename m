Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EE7B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2IN8PdJgpIrFFcCJE++X1b9h/mEkXrwblNsOzoZFFI=;
	b=NINyrdoKGBe+oyg2Pe/g+pBFQKGXhDtGtldpbfh/cE9zx3ZwStGc38yWiwHsBBaf77E1wq
	95Sb088d51UVgv2LZjgpzV5ZF/mfB6XI5fTyEj767eTEMa/TF2/cJyblxlAqp6Zkp4EkS/
	D6z7cBHzT7vnjE+lhkSJ2vTFuunOnyo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-ggx-9kwTNPS5fBb4ffUcFw-1; Thu, 28 Apr 2022 07:23:51 +0200
X-MC-Unique: ggx-9kwTNPS5fBb4ffUcFw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvPLiD7kEf8cY/lgzfpcfZRJ5TFXJ+LdUBMCT+BNLrzlDbiYPxb8V92uIV73QHF7I9QzefV3WVbex/O1rrwQFCG2JzflUCEM5vK0Xc/zGDuoB0ScHHNLVZV11d5NY6e62p6V1wFhx9YnMM3pC1ClMMyAU2qZPvRzOGirjMq1+2JJ8lSk9/pK8mNluNjAUSDpNIoX/IXgJuYmWM2yCmndlNlR0i5s7mB2dqweChTmZFChi0BDbZyGczBQzg1jNQHvByzLB9/ZuwscJaLzf0chpcXi0f5Y0ywiUmfj+U2GjZSb2KwZIaaY8tmIufpplhIDoKy3LgqpKmdYzQGkx2EExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGQrazxrWuL850zDT70PZmLeTqh6FxbXzFSIVv2WEXQ=;
 b=iLhnvqokAKm9Gsmf+ws86IEoRvI35D6tI3DH2ARX4bID7a3pBynODCzxglTyhuyzmtmunejrNHR6XzdibJ9hiE4Rs3TVFz1hOH+jcqlSxGTnuVyCH16QW4K/emrdcwVwo59etwA7h9O9wTex1bRdpv/RNTvWDbsQqEPNPn9HGpyK3bSa5y/sTJuRuu5wD5+7Qt+8GmIH2TisWsY3kqO45n/edmt8ENyT5lkMRKxY4EQrhIfia6gN+XF2V/bAU2oV3TiaCaQhIPYfOaZ41T/S6d+vgC4fodMiYWK0m7n5f5usk5OiX8SsVy80VynqPX57dHFD8TQEerMAxMtk/fTzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5653.eurprd04.prod.outlook.com (2603:10a6:20b:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 05:23:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:23:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 4/8] mptcp: add get_subflow wrappers
Date: Thu, 28 Apr 2022 13:23:31 +0800
Message-ID: <4244e3e9db5b34b5c7ea5809933aed847bc2d523.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651123078.git.geliang.tang@suse.com>
References: <cover.1651123078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7119207a-c213-4a8c-3766-08da28d746f9
X-MS-TrafficTypeDiagnostic: AM6PR04MB5653:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB56535F6FC3A1484644505BC4F8FD9@AM6PR04MB5653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r3wNDgPyLiOyw+SkZHc8AYMvbDCdiyd0s1P5uyO0zHqqJ2BtDxBIa2Rpqlx1ce6DFehDDiBz7C7pGnmAk21N9thnEOVYxYhap8nUJGhXVXOLDrZifmT+lBmmyISm6DXuq2rEyD+Z+Y65CYOVv4CpeRBpZlDohLcRgpJpKKoPZ2aLbGyKSUP9ydFaw64LWP5uOh5+M8VFgqsDCbsJ0s6ICaYN7xAWP09nFEivL8+wTFNAKo31Vx/tpL2GEwhBqk0ZIdl0nwvUw7HwgPd8ZBuws/SzhzNW+LdY8ohVcXvS18I7HNSqw/O/3LCJgYk1mNu3IXejCZcJBZytnLKsJvukbhsj+zQfM0P3Ee1g+VuRg6VkgPlizoYQwVmf+MQb/Mn8DRdzFYDs044RKC7vmziasd3S+Vkec5ZB1WjLA8YWPtTviAsLzJDWRN4ah7WvStxjjUQnUK3nsBqgBB+sQbOa29epgolmziNeiHt0MsbdiUU43WhZ9NfpTF/8xAOhnmUsubgEogdZPYTkB1cSzQawCzFZBNIqMFV4WoNPmaYEJUctrwQBZqZgBTDsdDWQSfowhTDJIrwHdvqjq5fTCwGC3usth13EKAoSn4Aa9SO2ZMqpXjjATqNAgVzemcv9erhi7dM4V4BKC2IWMOT0f+R+0GQfHdo5dZ8O11NFHXzZL6Nc1pf5jn9Ux3FLJXbqg6kZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(8676002)(66556008)(4326008)(66946007)(66476007)(6506007)(38100700002)(5660300002)(86362001)(44832011)(8936002)(508600001)(2616005)(83380400001)(26005)(6512007)(6486002)(6916009)(107886003)(316002)(36756003)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RbR+3WNMFQSQ+36ozu+Xw5lHx3WC/Mr/okI98r+vA4YC9LGlKF9VPymeXWHO?=
 =?us-ascii?Q?yKsM/DUuPb3wUiDCCFKml28jR4unvr2RqIev7Z27UXQK7YB27tN0veZeapYR?=
 =?us-ascii?Q?Qm5ZBuMdNQZ3rujK5iyfhtqIdusreryysz2Niy30R4bu4C+sH87FxG1Bry+U?=
 =?us-ascii?Q?labnxaY80F0OO96ToSgt13/d78YJ1qq8OMVxelzFMPRdyJNKkYhQIpTQuspK?=
 =?us-ascii?Q?eEj8XLvgnML2IEKP8ji2uE0JK6q5BZ5kGYArZ2b1luqNEJacqSiu0OnTvJeG?=
 =?us-ascii?Q?wlviHLfcrroBMFTk04EW3uj3yS4dRKzuJBZbvLB7GTx3drnBCLE1RinArshW?=
 =?us-ascii?Q?z/BZXVuXe9HkuolGTntF4hy08fBkyBUaAENMW/VO+4eEO3Rn+1g6lahpY2+1?=
 =?us-ascii?Q?gQMbJ+QYvFpp4ynzj1R/4ZNwV2HGkbROBSfAdkr7LGUDV5eoVIvekbnd5rBh?=
 =?us-ascii?Q?HRuVgsQjWDwJbRuAlpumRv3ZgVOvv27rfyTnXjhpyGSmNrKfkZUxhNfEcvGl?=
 =?us-ascii?Q?rJ9gWchVNMWWusazgks3Kb4JmRtZV/eLfaqgx8sxHAi9DDNsKGgQiQQpETSw?=
 =?us-ascii?Q?IXIBo7i5nUKKtFBBYa+tcQCLvZmKbp1aC1cvLCyr/effMiPcVXKNhdscP7F2?=
 =?us-ascii?Q?qQIFE5HgKVGWD7L+oVLQSFS5+ysCe4NxiYyF8rmvAKF/pSBG26g0ROP0+p1o?=
 =?us-ascii?Q?TCZeFM04ATk65p/pgdnQlNYYozuDwcnBhPI4HeTg+BSKFQypTps1PNT6yVkU?=
 =?us-ascii?Q?qS8WwqEd3HqkCeQSH8Flv2Ebx6T9tBQIBAbnyBcEl6+gzJjE1oEHgzOa2Mfy?=
 =?us-ascii?Q?0wOOXs4dEPqviYPC4wtGCMJHOA+BxnY0snPzCIgVL3QUIbcbPp49jG1KJrK8?=
 =?us-ascii?Q?N7+0vWP55uydkKAZS2EGfI8SQjSLvu8Jjxh5Wo2eg48Zlp2Ta2T5vttAzmcH?=
 =?us-ascii?Q?jMaP+jN7Y4sdW57Raj+X/m++yNAP6nR67Ia33oJ534fMFGp/rxbsXxrAvXGA?=
 =?us-ascii?Q?GnFIL1RFQTapAXJafQLdgVxcpSGL406Ms2hvq1jmkfTHJa5JsJXNot16YPy9?=
 =?us-ascii?Q?tFoelrsHbAZHvjYHEAv8s6LQQFJzsWi3FUqFWT9mtl19sn4J/jBrDFhW5iHD?=
 =?us-ascii?Q?KYTvMZ8WFWANA1GKdz5jC1l2PSH4fzazbnCgA/8C0kThcSp31eh/WItvRWPL?=
 =?us-ascii?Q?s9+ObyFYHYNfq66pl3dXgnYC329HkWfhPT68LKjI6zh+V/OF0fIu1/yd4orl?=
 =?us-ascii?Q?bwUJHUroIKwUxcm1rNuCp6b1KuRbBdvLWt/SbHTU4DLWxbg21TEGyMp3/c7E?=
 =?us-ascii?Q?i6WKQr4zT2h56o0EttvhL9Q8ImuFT088Lz20rfbxjYccQX2Bm//rcbKDrpmD?=
 =?us-ascii?Q?I7I3J1B2VsUduMxAy9EgFQkcUT98rdl3wg5Ivhz23sCy11OGgeUgKb89qyr5?=
 =?us-ascii?Q?jg9UnRCBSaTe5RMqn+9Mmm43bJTgTtOqpkK/0j+fZ3btzI1qYmTzedEESkDk?=
 =?us-ascii?Q?x87RebZ6/Nw6cbu9bS7pcSFVnhB2nRf87YZIDGrRnFys4dYW+IKFWULCiw/Z?=
 =?us-ascii?Q?di5qk8+JpDC9TIQqmM+phTSgGXQ8d62a/b78rF6PyNJE1mSzDmQiXdFdsWG2?=
 =?us-ascii?Q?LJl9WPuTyIiWekHXq+ziL87y9aMVXOLRxy7whX9O0aNxG2vHf5B+yO6BauRq?=
 =?us-ascii?Q?+3jbvoyf3E1T6cMeneekLMMtItW5D4gV0me8mnD9jFzPe7Sb4qkJm6OcNX1X?=
 =?us-ascii?Q?z8/haSIxgSUOOLQI6hAh7uK7mKPsEGE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7119207a-c213-4a8c-3766-08da28d746f9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:23:50.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMVDXSXEoukSFOphvUlsby8mAQUB01ok8PNbcQdRryUyVM6351qdBIyaGz1OznimnZJpVQddN2WyZYqPa3IArw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5653

This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched
in them. Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 25 ++++++-------------------
 net/mptcp/protocol.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f599b702415e..5243c58789a4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1427,7 +1427,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1438,14 +1438,6 @@ static struct sock *mptcp_subflow_get_send(struct mp=
tcp_sock *msk)
 	u64 linger_time;
 	long tout =3D 0;
=20
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
@@ -1575,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_send(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1644,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2218,17 +2210,12 @@ static void mptcp_timeout_timer(struct timer_list *=
t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup =3D NULL, *pick =3D NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count =3D INT_MAX;
=20
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
=20
@@ -2481,7 +2468,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3146,7 +3133,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 723141a888f4..0da2a91ad197 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -988,4 +988,46 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflo=
w_request_sock *subflow_re
 static inline void mptcp_join_cookie_init(void) {}
 #endif
=20
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+
+static inline struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+
+	sock_owned_by_me((struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (!msk->first)
+			return NULL;
+		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+	}
+
+	if (!msk->sched)
+		return mptcp_subflow_get_send(msk);
+
+	msk->sched->get_subflow(msk, false, &data);
+
+	return data.sock;
+}
+
+static inline struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
+	if (!msk->sched)
+		return mptcp_subflow_get_retrans(msk);
+
+	msk->sched->get_subflow(msk, true, &data);
+
+	return data.sock;
+}
+
 #endif /* __MPTCP_PROTOCOL_H */
--=20
2.34.1

