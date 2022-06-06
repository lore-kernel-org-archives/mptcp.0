Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5523BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lobe5Z6ToDAMGitJ3uCKNtxFPgeWsnUoSR6X7mvJjIs=;
	b=OLaz/rGs6pIEJ7ERZRM+QHCb1wFQUrydkvwwMBeioeZ/XLEXR+HcZhDq4G4b5gSJhsn2sh
	2c84RwPys+omAtS3mBfC/qXApRHN56iNVqOOgr/QFYDahPJYgT9eyFIXJySKz+yceCJM+E
	fzejXtALSGboVYy1wgPA2p779rOxsJg=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-D7_Qp92wODmqESTmt6cK4g-1; Mon, 06 Jun 2022 11:47:34 +0200
X-MC-Unique: D7_Qp92wODmqESTmt6cK4g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb65RAcWNfAdlOuICAywh7sI5kGi0nQ0vHX1xpLHJreO69+B7FuYi5dE84yayQntGxDEuzAwrRrnPpEXcrUIZSThvDYNldFJLqIFB1TWNDkV1ctN6IWZijUp3DwP5iKy+8IwS3T9CmodQGhZj2Tljpj6mJxKtWCGH5GGdKBVJc8Bawt6DuPWMc6MVKq2YlLwF0Sg4ItmkmcYjs/TIlwUgtRA9OnSa/1cFLyd6xJEiGlI6poOYAUMhWiw3/wzO4fz4xHXQmUb/d7/kX/ue5R+hMGw9FrSXVp+u7ak/k933Osn5A0fknXkmWSGg6jd6Sh4A9ZLTigP6LML3a7wH/kpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p14LMl5K1qay0uFerUt9ZmkS09HYtblAtFdNB3QUoFI=;
 b=PHQMMJaIIy3VdoepvHrCs2B8m764CS/t/YtxUw0c30cvyLyEUKMCUCe5YlVPOcYHX6XnCbG57KWCNwlnbDJg4/IAigIKGuTuhB6m3nkPGqM7fbSgForbBjnGxJ/C0LN8qfljUStQJ+ziU7eUJhlpV03/crmpkRpf5gpES/MUgC8BkHlcpIK1FZ0LwfabHCv00gLXeIjoqXkzWBSEq2nCxCSkupTAShl5gj/xC/euH7swwJav2H4oMQ+aPPK1rlG3uyVBmbsTcXs3EYR8ToCza5+NwCqwWpmuIYgqxN54RKKg57THtcY8ozpxHpN+tJPYseUP7iasMQ9gV8FyyfXsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4802.eurprd04.prod.outlook.com (2603:10a6:208:c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:47:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:47:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/5] mptcp: add __mptcp_sched_get_retrans wrapper
Date: Mon,  6 Jun 2022 17:47:12 +0800
Message-ID: <08e0c77af83d0e79a0899c2b2a4cb2ced7124fe2.1654508532.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654508532.git.geliang.tang@suse.com>
References: <cover.1654508532.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e26b8031-09e7-4f48-220f-08da47a19477
X-MS-TrafficTypeDiagnostic: AM0PR04MB4802:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4802AEA244E0328E83FB3072F8A29@AM0PR04MB4802.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+2jf1Sq7DO+g6USxuXcXRzB4un3ezeNi2y+EG3Mgtwh3j8fUJVl7SMYcdd8n/81+iOc2TGt+9ykFzZZ40H9zzJmPxyotSYMclwMOe9fUQEL+T9Vg4YCvxDZmPHbHjB/pabYVNs2HzcFSdBGizzPeeBmZk/NycIPZMR+P2MTnMauzARJAdAD+gBpbWV24euxoOLkfyDd6gDUzrpmbMiUlabUlaTM4PyipbE1pyyDTXHT+z0/JJiJA+rd2skDdgW/c5F/mOsgrCiGqHlU3A+hJj8tje+NUwcpbhfFTn0LA/2ybynRWpeVSqDUJcCT9sCW9CJFuIj3TidWf1UGCuOqtJTtjEK3R3x4EpS1bEAaADWaj487rqMUKXUPQZ15+Ltr847QvvZy4H0VBTDbQw1Hw2Y0Eq0OcVdUXz6NztshqBONDrhyoZ4Im1Qbp7xK7Wd/IdXjyXkqsjgz4JZsANfNYUcegQlrJwVi1pdWKE19IBRnJFx31YUG3z5VQnHipzX0rkEbW5Y64of6DgaIcjIsTR9eEfkIZKTWEv2uqJaXElUJzib/1y187TKOsyokVNBHG0PgtC50JHK60EfU/0oNCn94GBzWe54FQEEeZ+gWqWNYKe2KI5NiiIbxJsOyb4rpYr0BD6YWhT4ciUs97tMysRchkSe7R98HDgeTqpcEMj5dBEiqJy1a7s2ikvoh0JWPYshgMmnuLFgvggXjdQRcSlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(6916009)(38100700002)(66556008)(66476007)(107886003)(316002)(5660300002)(26005)(6512007)(2906002)(4326008)(44832011)(8676002)(6506007)(83380400001)(2616005)(6666004)(508600001)(6486002)(186003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WcNUVtUpiPFqXMudn1mzbEnjD9XGisCFeHzhMXBkAV5Y/A9eo4DdOpASNQbs?=
 =?us-ascii?Q?Rs+P30rjN+wotBENqeRvl67DVEjgvloAxz1L1q+u202oSb0W8796UMJ83Cxw?=
 =?us-ascii?Q?KyzpzZr1jeZRAImgUr7M+ZKlT5ZY1wrbakkrxIHV/pzusqFYdOIW62BYKN58?=
 =?us-ascii?Q?y2Vel3lX3esQsDbzf6N/gWNABhf5dU0DgCFc/P8ROOL5MCvCKySykwMeR/O5?=
 =?us-ascii?Q?qrimWOSNoxOFnd2GflOupGaxShKYK5lvXUa1gr1zAVfpjj1FXKWeVaVVvjWY?=
 =?us-ascii?Q?bnYq0gXLTtzo4vPUYeIF3/WVNU4Y6Ro9yoPU70lyBPRiEFbF3w5idlzZtqm1?=
 =?us-ascii?Q?YofB9wAm3CLqsztM8kzdXx4xRfck1/2nDzINfblN24bYOJGv9dKdFJ7ak6aJ?=
 =?us-ascii?Q?C1OwntXzWWGlxm4xYu0ZQ4cuKi4TevZxBpwGgGhwjX84ZKDq5vEOAcASHydf?=
 =?us-ascii?Q?5bm9cpGvgONwXmUGuxUxy71lSw0GlmrvmBgxiks2f9/liBzj5yVN66exNmd+?=
 =?us-ascii?Q?+UbhNtHL6GhDRsTvIklwFgGwBsKiV/Y1t4dE+AKbePuDebsc/dY/G1hinWUB?=
 =?us-ascii?Q?EUt849q2ovM5LplnNR1wMsofL6KXJrSZQT1lN7fBPHnfKHwcwJsBB5GA5/DB?=
 =?us-ascii?Q?cs4+vNRV3ODwzHtZgudPBq4ASgn0IfFW+iMFe0EWWAU0Scfe6VlcH2HEzM7x?=
 =?us-ascii?Q?r3EC+t+1mmyPn9Au1Ih+OM2k6t7PIh9FJ9YPyHCr8GTscWGgfnWRO8q0erpX?=
 =?us-ascii?Q?6GXA9vyxwDag61RMUsKwNWFOB71eZ5mWbTzpzjnWIYPC+fmv3A28iRXpJiyM?=
 =?us-ascii?Q?cEcc1vMHL231eHe7DDYFu0MYPVMuC+D+g/RnlSuVCtpeQjL5oC6sRDB/9wVP?=
 =?us-ascii?Q?B/lcrFye26pJ7Ba9eYa55nZAsXkhw8qgaoQAcqQkDqeRLB5XwxvTJ4b5m+sP?=
 =?us-ascii?Q?7+I2YUDZGyZ1j5pkmB7H6kU9P0ip2bviOBcsV2Kz9JOEeh8Pioa4EFx3wq1y?=
 =?us-ascii?Q?EjOoFwz6JBR7aha84OA+v8iSONo42nZrWt2LfMV/BvDii56afCcpfwkinw39?=
 =?us-ascii?Q?80OJenYPKmGwN4W93ju/2CvSMMwIWNzQznQ2xPeAkfZe/rBDZLNodsb75EGI?=
 =?us-ascii?Q?0KuruljHwBxgcJtlWk6KGCeQC45ZgmBi4+kJxLjmubxs9/AF5RHTb9EQYL9I?=
 =?us-ascii?Q?ZtUazwMWtCcPO6k/WCZ+Ib2H2t/sz2TuGFuFAYPNepHBrI0LHwBUdszoh+eL?=
 =?us-ascii?Q?GqmQ+mVoIKETMyU7Y+/GgdtX4wCByp3fOCTBoOsnswFj5FjCv6AaaGAOZjcU?=
 =?us-ascii?Q?hl2qGcKh5wfWMmuJP7SfDhaOU1kPasitgZP4XegFciGpa06puU5PnzCKFzp9?=
 =?us-ascii?Q?hH/yXqXDx0bS6xVzS24yFL62GWP86UzQx1E2nb9TX53Bk1ET25/maKOQq6mv?=
 =?us-ascii?Q?cxbMFehajnW2Ydu0G+oQJNqHl64uEgbnzmwkwjcuw638MOW2n3H3CLaB+cof?=
 =?us-ascii?Q?I0QMSHoGVMFLuJ6VTq2Fz4En5lxZauJ25Tprj5yH7J0T8bYHTVUK8eNBuMn0?=
 =?us-ascii?Q?zzbV1OEASwzmWj0vPMLL+8L5arVbVLo7BBN+x7XPC8gfkbGXl5BOp+V704M5?=
 =?us-ascii?Q?bTIjAkKx4YHkE0Yp4f9eWcfQmoM0BwKFDcjCQBNoxUNukUTJjt4UdsAFy/wQ?=
 =?us-ascii?Q?OJCPVlDTSxq/D43ue0Dnk88y/QU5gqfEmcYaYQouE1hyzy8PQNAEfSKYlGde?=
 =?us-ascii?Q?e7f/aXtHC8C4KlqzwxhSvATGlhUFXSk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26b8031-09e7-4f48-220f-08da47a19477
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:47:33.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKKGNxlyyMZywUNenqqfbUyh13J9ge8Jd33W0no8uRhwSQ8rISG7fvsKEHi2OnaqQXYKO8eSP0FBZW7phKXyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802

This patch defines the wrapper __mptcp_sched_get_retrans(), invoke
get_subflow() of msk->sched in it. Use this wrapper instead of using
mptcp_subflow_get_retrans() directly in __mptcp_retrans().

Check the subflow scheduled flags in __mptcp_retrans() to test which
subflow or subflows are picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 52 +++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 25 +++++++++++++++++++++
 3 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c7a1e15a66fe..999e83eae821 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2196,17 +2196,12 @@ static void mptcp_timeout_timer(struct timer_list *=
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
@@ -2450,16 +2445,17 @@ static void mptcp_check_fastclose(struct mptcp_sock=
 *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info =3D {};
 	struct mptcp_data_frag *dfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
-	int ret;
+	int err;
=20
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	err =3D __mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2478,32 +2474,48 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
=20
-	if (!ssk)
+	if (err)
 		goto reset_timer;
=20
-	lock_sock(ssk);
-
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent =3D 0;
 	info.limit =3D READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->al=
ready_sent;
 	while (info.sent < info.limit) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <=3D 0)
-			break;
+		int ret =3D 0, max =3D 0;
=20
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				ssk =3D mptcp_subflow_tcp_sock(subflow);
+				if (!ssk)
+					goto reset_timer;
+
+				lock_sock(ssk);
+
+				ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <=3D 0)
+					break;
+
+				if (ret > max)
+					max =3D ret;
+
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+
+				release_sock(ssk);
+
+				msk->last_snd =3D ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
+		}
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied +=3D ret;
-		info.sent +=3D ret;
+		copied +=3D max;
+		info.sent +=3D max;
 	}
 	if (copied) {
 		dfrag->already_sent =3D max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
 		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
=20
-	release_sock(ssk);
-
 reset_timer:
 	mptcp_check_and_set_pending(sk);
=20
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a12507dcf1d5..4669d34f4d7c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,7 +632,9 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int __mptcp_sched_get_send(struct mptcp_sock *msk);
+int __mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9427d15b4c69..70ab43c59989 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -146,3 +146,28 @@ int __mptcp_sched_get_send(struct mptcp_sock *msk)
=20
 	return 0;
 }
+
+int __mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched) {
+		ssk =3D mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	return 0;
+}
--=20
2.34.1

