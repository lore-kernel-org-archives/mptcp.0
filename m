Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01181FA0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDBpLju37SaI1e/83IXiHupAq93aJYyLWveE++J5TlI=;
	b=JvBBUmBeNdq+clKt8KbuTG9bbhBnflh2oi0p+OPujE0HrNAbIxAazIWx44i9N+GpDyss3L
	vCDXFK/flqLxQUqREIhSRiiFX2IwyjAS9RryM6lnnJ9y/K1d3WjngV2d6+a3wMvvEYnwwn
	ura/JZotyphl1dprR5Zx5OXFXOAdAOI=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-m31mYTKDNsW587fD47KQbw-1; Mon, 09 May 2022 17:01:20 +0200
X-MC-Unique: m31mYTKDNsW587fD47KQbw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3WPXeQ3/WdrvxdEBKyj3YMRjl2yQ7FqAo5YLCmle0isQdVD3p1VBoHcJLm/Bbi082z3e7bRI1d2RvOh1QE2/fL5D8OOnxy/e8vd/B6dndrV5crMHp3yS7aqACr51HssfDZx7NNwrWm0VF6mexmWo3eMnNcsknuOCUebeOlhx0IVxLY5KugOudFL9/jYbCWE+hihpPgh+Xh56RvQuR0voJg2WsWCl4Kc9yK5x1RMiYPmf1Qe1VtyXfos3xirlHWahR8zdGMT4Y0B/ouAZWuvpywjoaobHuCnnqUyzY0kMD9MXkxC46enoQUKkZI1rZT50+Wr2E2JwVaY2vBcWsV6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfFFjewsdlSF3h+0lg0M0fKUQn5+YSHSCOL/Re0wawY=;
 b=HxOJrXJ2kZR1Om90gTePInLYjgU4+EvWEUEcUX6Vvhump3UhZQev5cl9E6NY9EEEwh4y4yRfq89nwbAhX1mCpwNwX4wE9zj/cw90RNiTH7fPtiZm2N2ZQzY/3XOEJI9yaFWjI2pgHv1brVbiFN+pvyKpxPBt8DbYEQdg2nLpJpnCn3wk8b2BRt38wrUvPt1iWy1cHtt6Hi29MJMIOXwKwC9xwUiwXbfh73NBQbjkM+49rxanVXVmR2/kP6ZfwKo1nlwKu0RlTxKFKpactcvjbyl+Fj2axwKDuAaUKU5BYbrF/0lYeWpY8S2hz8u2uGv17Du2dij9xlIiIJ2769h+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 15:01:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 15:01:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] Squash to "mptcp: add get_subflow wrappers"
Date: Mon,  9 May 2022 23:01:07 +0800
Message-ID: <769fd51201f15cdc6c582e9b14661445143fdf25.1652108279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652108279.git.geliang.tang@suse.com>
References: <cover.1652108279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:d0::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d260e032-4dca-4ad4-b2ae-08da31ccc634
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB8107A2CE3A6E7CA236224DA1F8C69@DB9PR04MB8107.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dJp4DSfP79p//NCKiJ/i3SVPYhw1+p4DtYmC18qDJLZnTC/wMZ4KPs8qluzd3GbMtHxOqjls1QnPUQdCBg8rFDP9nlGejIrA1soFGMqN6z8q9kd+ehsFbaK/KstEooxunyHSf2NlXTHIHQ6RTOl5eM80nWVbHVqieSgCz8j5pdEfQm1x42FPxjAcKgWO3EX8GD+WsxcaKK3ngUDzXPLEBZ3kvCXBpdNjl93pK9xEkTb/r+qTv1a7EjOsY3WoFtItRmUJgSnV5T9ZvALDB5FcBHKvBuB8NrFa+IkyfY2+6CA8ahLx8+ZgbSfHc7VT0g+1CulplVWT3ekaWvTn1WzmgZT5jK+qBFGRRzICMd90CQpRzJMs359k2VgCjqMty9xOq9avCcHW19atwQYipZac6WbiJRycXXn84Vc97/DrzBnbmxqayGzz88eyL14DnAoaR3RjaUhRDSaYPyE/+R+FjiKKkTMP9JkzAEDBDJr9J9//jztKGqtZuSI1ysRW6ISRBlFHvzKrIy2DF+5I29b6nuTWBwLXrYjoNN7DHpM3/+A3FSE7TiXqHzLdMD1oybn0legXi0k8Tq2GynIrfSOkL0/xewWELBknSx/ANlfm62LNS8tz9GmMRyI4rLJeq4tJGr7Uscbzf/0Oa4w0MNU6ZBykL59Ew6Z0XfQJzB3TgHgr0fCbfRQEl+Ppc4bEwtLZnNDoXqd7wCDIuyKgJ+0RDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(38100700002)(508600001)(8936002)(66476007)(6916009)(66946007)(86362001)(8676002)(4326008)(2906002)(26005)(44832011)(6666004)(6512007)(83380400001)(6506007)(186003)(2616005)(107886003)(36756003)(5660300002)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQdGDtei0QLBtAGLpxItQ9+tuaKFWESJkJwEyrrmi0sH3+By0cni+AFmqqyf?=
 =?us-ascii?Q?t83NUGue7k7L23l3oEQ+jaqYy80LAts2aP2PpxtiSVEj2skVs6jlEeTqvP7v?=
 =?us-ascii?Q?/nyZj1gT8jPzgvxbxbQlnQUZFwfxRe/+4RD6EoF/V9V4hfpINY/xfwd4D56F?=
 =?us-ascii?Q?Kx1egHWyAibfzHnWa4hyMveyf9wivCgvFaYEzk7yHDLk82KltckzZSzutQcA?=
 =?us-ascii?Q?6Q/mLAW6DTeduEUIRQmQWZNxbF0eMickX10dozmP1Llyqy6bWXRoBVPN6yiu?=
 =?us-ascii?Q?7eiRkBaria3DrR0cpoJlkXO+5exDn3NH2BabEgxAi8nfuP1nW+Q6x9dI23hE?=
 =?us-ascii?Q?AfQTvIujrlwFRLTiMUs4JCZxcM07njNM+UbI1VJz383vfcGNlrypKynrZ3NL?=
 =?us-ascii?Q?CJZQu8FdDyCaclESlnRR0rPGCoDl/Ms8UkR14+KZ8whSQdIUJHB+mVBrvtNu?=
 =?us-ascii?Q?HacVnA1Os1hNpD9kFDKoxv8teQQssUmpBbKQnHEfX+CRyhiQkfmpq1APc2Qt?=
 =?us-ascii?Q?QTDcCRboe4pM0q+Y8JL87wVjpyyRPCXUpwFUT9SegHIUDzEfHRo2tBGma4n0?=
 =?us-ascii?Q?lAkySPKBivEKd8IMvNAS/mgElroJynYrGfqYKt11rOIWSfcuyyl9gfcPn/z2?=
 =?us-ascii?Q?xKvrDjiqTnV0ILbWo5yJhxjRktLQUZGY9rIb6N6z6HLZvrd+JQ7h0TR5ggZr?=
 =?us-ascii?Q?HqTFRFEcYsL5q2m2D6NX53wQuNfSdY5Win1dXwuksegmtIGFS7kyb6bko+eT?=
 =?us-ascii?Q?528wuTIuJLhrM1Q3YQHKmA0hiZh7Tz+K/UB1CfrqYLNNaCqvmTY4rnVzhgJ0?=
 =?us-ascii?Q?aOsYEWQDtawciX5OH6arCj+epiu/H/JOjFAW0h4m/UPeedOnrVOb3wX+gquB?=
 =?us-ascii?Q?VIDA/lzJ1ZyrPRh+J6BC58HYPtNd24+y7Ee9YSW27ldlMfI6A8j9u/s6C40E?=
 =?us-ascii?Q?yaQPjXwsdKnLciscmRmcxxX4Z/lOpVU3gdW3Rb3MwLarUdAkWq1wifhCUIuU?=
 =?us-ascii?Q?L7qJoKdMQILEtqvXxMupUhSqLKPoTG51tS5ldTa1LLrGqYzdQ8K79G9H4kM7?=
 =?us-ascii?Q?JkeFuUiJBOywFmUSwouZccL39ehzT8kOepUgy+7YKrvM7BUfg3zOecRynVB6?=
 =?us-ascii?Q?O79flm3txPhAbJEgryno5kvyHNNkWBZ9tvkL9xlmbLSkIG3pD8hCyj8Q6djo?=
 =?us-ascii?Q?BOLevjjDg1+DlZtRVT1KIk50OWCissAWX/Kz5dnbTQd50qhdXw77Drmp6xY4?=
 =?us-ascii?Q?K0yLcS7aWVuCxV7Fo7usc2Z15zXsC2by1Qq7zHrIlKDZpapa7V+d0zj6gead?=
 =?us-ascii?Q?cJo0G/4zBDkwMsDoiY+g+wuLFXTu81ZjaX59GDMUT6dU3NEmmQE61qTujuXe?=
 =?us-ascii?Q?H9bHelHh44EZ3IpCvx9HB13zf5MPPAvgfkfNeypAbaPS/4gALfwvE/AntqVp?=
 =?us-ascii?Q?ewTIq5uYK2gXd/QUT5Ng2Evhtcg3lDn1U02JqcHMjyl9BW/350+xA8c2lvwo?=
 =?us-ascii?Q?SS3tf5CzUu0S+zlheZlOtuwTQi9MUWeiRx820lgur395PluddPxOzVjfsKOP?=
 =?us-ascii?Q?0n2RrSA6tJHAXo9XKTKupS4IC8XnK46yV58wYcbdB4c5HGa2eefLq9l1PKYh?=
 =?us-ascii?Q?LBjyMileqvZcwPMfD90oYBYe5ASBgw+Bcj+ii8wWnYRBtir6+zhgHPUKbskF?=
 =?us-ascii?Q?Vnoi/xCy5+SQSJUs9oAV+Gpkbe9neWDY6b8ESXzHVg4lta16c354RX5ovUVJ?=
 =?us-ascii?Q?DxjRq5YU1FmnvdCwNIlqnzwrcPEyw90=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d260e032-4dca-4ad4-b2ae-08da31ccc634
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 15:01:19.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJpUaRcrjAxlm0Aquk9/fDuC2x4wASw9PEy1BzehuKiSgn63/GbcVmo4hWZFu4EYCMHW0XVIN0iE1FjqHASBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8107

Add call_again parameter for mptcp_sched_get_send() and
mptcp_sched_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 13 +++++++++----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    | 10 ++++++++--
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c55e7f45aef..4a55a6e89ed5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1558,6 +1558,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 	};
 	struct mptcp_data_frag *dfrag;
 	int len, copied =3D 0;
+	bool call_again;
=20
 	while ((dfrag =3D mptcp_send_head(sk))) {
 		info.sent =3D dfrag->already_sent;
@@ -1567,7 +1568,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_sched_get_send(msk);
+			ssk =3D mptcp_sched_get_send(msk, &call_again);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1621,6 +1622,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 	struct sock *xmit_ssk;
 	int len, copied =3D 0;
 	bool first =3D true;
+	bool call_again;
=20
 	info.flags =3D 0;
 	while ((dfrag =3D mptcp_send_head(sk))) {
@@ -1634,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk), &call_aga=
in);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2461,12 +2463,13 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_data_frag *dfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
+	bool call_again;
 	int ret;
=20
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_sched_get_retrans(msk);
+	ssk =3D mptcp_sched_get_retrans(msk, &call_again);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3117,11 +3120,13 @@ void __mptcp_data_acked(struct sock *sk)
=20
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
+	bool call_again;
+
 	if (!mptcp_send_head(sk))
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk), &call_again=
);
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 59a23838782f..2fe0021a678e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -631,8 +631,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, bool *call_again=
);
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk, bool *call_ag=
ain);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9ee2d30a6f19..83377cd1a4de 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -111,12 +111,14 @@ static int mptcp_sched_data_init(struct mptcp_sock *m=
sk,
 	return 0;
 }
=20
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, bool *call_again=
)
 {
 	struct mptcp_sched_data data;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
+	*call_again =3D 0;
+
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
@@ -131,15 +133,18 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *=
msk)
 	msk->sched->get_subflow(msk, false, &data);
=20
 	msk->last_snd =3D data.sock;
+	*call_again =3D data.call_again;
 	return data.sock;
 }
=20
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk, bool *call_ag=
ain)
 {
 	struct mptcp_sched_data data;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
+	*call_again =3D 0;
+
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
 		return NULL;
@@ -151,5 +156,6 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock =
*msk)
 	msk->sched->get_subflow(msk, true, &data);
=20
 	msk->last_snd =3D data.sock;
+	*call_again =3D data.call_again;
 	return data.sock;
 }
--=20
2.34.1

