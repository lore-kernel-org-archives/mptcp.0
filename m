Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7515C4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVxj7r/DO7WmmHjuG9sV1Fa3xU7BZHTs8Vnx4cTk1Wo=;
	b=e40EMAG81tk2+wtRryA7h9KnRpjftW4IzdAMwJoL3vM1TzCQMJvxxqDscvAiGnZwC+5e/j
	IVUORyKh4cGmIuoWXYKz9VSPig2WInuqt9x7iap7lfYGOVYTZy86L370IxNwYxLQ5a1xZZ
	Z6qwabZEEqf9fyVnBNDIc6aAnjEX7es=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-7MZFxPzVPGmgBZMP2zptzQ-2; Wed, 11 May 2022 05:41:03 +0200
X-MC-Unique: 7MZFxPzVPGmgBZMP2zptzQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9zviBY518ioMYyRYHJaBh/tpdLbrTLv/Wc65KUgKwXnJUgc7imXt3W0N0BtLiMaUEmKGVver2YFP42TU6igNnh/qfBM5OYbyVm5jzEROws8h/V0oM8BzsCJecUVrrGlmr/OdwT0ZfCk1CdC5XXATHxb4/0r5DB+ouZqdvMidoQDGS/Vi6EsRYFsiLmeoirN7G/4nSDhXjIM+rbrA65VJ1tAIVuyl9ryTLohzqLorYttXY9mrWkfKf0/rSlzAlz5LPHIX7r90AuKLhrJKOI7l2NCpkzsxZylOef9fPDkaCzkeEy1ngaDlTzAnX0wXe0Y+9tya5i7pwQuc2aZcZdtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZKH+jmRjjHcvw2C8uNF3rRV0lIs9iBD7qyfLQx5bHc=;
 b=St3DIoYTIg6M8irkCSX3QdIKsUNrT5ynrwdELk99YBUPJhm4GmzazYpNjVPntuIMk8gaP43X+OBPDcUE3pCAjhHXTluTAwIT82WjNoPZUNE+VeoXwU7DRDCRtolzi1YOxuWR/rtKxJf4LSmJTDb9dxeMCerPw3gFowetI26V5XsyBNRkHXgh3oQqx81tXeDzRZ1Qu8McAjKBEbub2OXz2OMBEsSX7hYpNODMIe9r9wxWEPxch6zWrgnFPMjk0PBVIvbktxNXLSKGib4+oDvyxVMizx8g8v8B5EmwWv7wrkiudMnz3PwzgUI8qfgUcxDOMhiPodcZfrWunqurDRTpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:40:59 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:40:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 12/15] mptcp: add get_subflow wrappers
Date: Wed, 11 May 2022 11:39:13 +0800
Message-ID: <47087b6146dfa1bd172bfdaf8ded17ecfaf54037.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f8dbdb4-55eb-43dd-12ad-08da3300107b
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB715652E6806CF24A6F49BE8DF8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qVdF4h0BsLtmhxvJgapu9MbYZHKPdhrADK3wkN2xFgnrzI1hgD8k9lBdA7XnN20i2ZP/zIJmU02oUVaK18HOKfLYFQG2pRNOGFRVJQL33HI345C0BG7JpF6/GMLHhm/9Yg7cTN4fMsuLCpamN/2U5ZUGZNHaIBvS4lSudvLacq4BCBU17+4m8HJCbWOkr4xYZP7LmXsvxhT9cqesC60gopZ+yMTiIP/4gxPpWEBCW9n2hYKnDMXsSovWnYOQKx+oZqCdpiJOsTJbgalkzlstcW2bj4bZUXvzdEj5VpwIaYF3ElGZh34wCr8YLInaTdqVb7qDRtDEy5Cfi87k8kVpMqoAQHHel9x0jHYyz2BWyZv5X+AThAOUw2Sz/bTkIHjCS9jABNFdRUJBnV1AAb1yJURcexQURO9VuUWW5ZsTfxcKQS0V1LBFfvfnRejZQAGmyohRdc5XINKt9gB+iApVcrOgR9OzWMN1yb6deaWwoh1ifqmy2dS1iDFori8eG/uXvR+AWjhfZaPFxGRiq8zUNA35Kfc6npknSuOA+KQEsrokl2xFRS0PSuOlT7VUrspJqcfJDriUadsIR/Sg8nkFYku9yDP8POLXYFgOCaNCvC9dkMaHX3TOWVrELxT4O/OUgjLBkF6ujueirwVNCNUBtniavrtAU/nK0BLV5Rhad7qzNCP9SG8DWXyayicqGNlS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YzfFhdZamqKgVBARhjfFeB9LqgWUtEhDkOf9tV/Yy1NvQRTaiBdtLlGmmaE5?=
 =?us-ascii?Q?DgGtbdVROEwlPFubTcxD1TJ8ZR0O/8fiQtE2+rLNq6NKk8K/Q9bMFqwQK5hN?=
 =?us-ascii?Q?V1aR8XjFdn2MKNwz5pVLkM1X/eRkSWnnInDXTaTI97Kq/LkhW2g+RMtv+13t?=
 =?us-ascii?Q?u2yEovptpsr7qDpN5+QQUp9KBsv7paW+JwfBnmZQf8mZb6DTEwFi5Kn5X6/G?=
 =?us-ascii?Q?PduJlhkogkvkHs18UsCQecMurtqfuRXUBk3pvkBdnd/xkEv2QC7Pjf5GLA4P?=
 =?us-ascii?Q?cdAvpM+5BINPi8e05+FpsCV/J/+oT0nQbCXyAaoh4YxNGFkmW1KDEWP0s7B8?=
 =?us-ascii?Q?uXvZvkYbbvGY/pfUVg4ZMyl/lBNnzdeTL3k7s39JSMV3MrBs6bhYZStSEEJE?=
 =?us-ascii?Q?MUFi3o8Y2/yTwrRPVTWZSW7ZR765TBfbUX1br24fjVwAcKO4YbpGQucyZgMT?=
 =?us-ascii?Q?oiaK9QP1w4uSA5Dq3uuVaSR8+gzdaGT0DfmHiqD7DhR9aTa0JN5rUv8lDLPQ?=
 =?us-ascii?Q?+cbvoNx5GBssqSev4cnjn8xNWyrXOWdGFL2boSPA0RBMc23X6SBW1TUOUtB6?=
 =?us-ascii?Q?t8TAd60iYWfxMl1NjmhG/JP9CLkPUZdzXB/WBwD6aap9XKAEEOKOHDcP+ESw?=
 =?us-ascii?Q?Sy2jddA2/CiLMz43qE795GuTh4DLV0ENcBZdnNH4HQj3mKMFMk0SqN8SQ32u?=
 =?us-ascii?Q?Dklguk0CKpx9F5Wna8MGkgh/VVVo8RISALJlsPxS4M78I6S2jcAmlFwwXGU4?=
 =?us-ascii?Q?SuWC/B75iVV1AavIQCdYZNZBMIPTlPIHxczBR3hfPCH+bmmIBbLNEaMrdaHS?=
 =?us-ascii?Q?kJSB87PJkl6OiqlD9cykmQbk7TbW4K3Ek541eZB38Vh23NnndLhO1K/6r6oF?=
 =?us-ascii?Q?gwEZbodTVtpdtxAw4OcLlf+Gs0FM7fwZsZJ90qQrIMb42EBNrFWavN0FAyzY?=
 =?us-ascii?Q?/84LO+JdUPvtbL8hmiQBkyNERDoLJJbG80i113HNhPaCy7DEcIebS+cWnaPa?=
 =?us-ascii?Q?0ZvbWtdgyf+10nZt7S4QFuzbT1t1U67CEMcYa5jt5Ou5fvwyFp+DmqFnUaEO?=
 =?us-ascii?Q?M4AjueeC9KSrBgZ3xmvB49xSIqafU55X92ZL1TkuBY0BCOuameJonQ3GOq4l?=
 =?us-ascii?Q?mEUGW5uJCS+61ZIZEoYISoQUJc5YRc1WfjNGhA29siwavRoNvKHgKzo+nwvM?=
 =?us-ascii?Q?g/Hw5tuS2P/yjN9RITkr9ArzBaz6FZ146vfm2arvNgKJxgwKm69tBXMObDpu?=
 =?us-ascii?Q?DCp1nfYrot268Z4OXmvZ6zDXnX19nPGzUeLpGLXb48ZF9ElKOJOL1h3dRADP?=
 =?us-ascii?Q?btGI+9xdGtIYLJi+OAT3KxTdSjESGETb2ysbxU3MvE97y5gVeLtDIdnLqU3S?=
 =?us-ascii?Q?uiyIvxagPo8I9xCzqbJfx0beJY1Ko7I1RNcZQm3Y0XK9D172b3csAN5CClRj?=
 =?us-ascii?Q?X/2uNEdX/8aHxA2oi0zGQIfgE4xZV0lmlM4hOjlKvt9kx5FbPDNaKwmY0Uxn?=
 =?us-ascii?Q?vpYgwF4o3aTWqdt/Kc0A5IAvMtALE6hjXEOHKtaW8NsSfj10WkxiqaWl+fa8?=
 =?us-ascii?Q?d749DrIOMcCAUV8bydJJkYfaca+KHAK/UvtIy3tn+AbpVlpiCgiMvsQ8Lpd0?=
 =?us-ascii?Q?kKuwlq+7yTwU4s5a4O++4lBBLC+FlkW6OWlnuOEKdgPvCdxmvyik+CmOOY0G?=
 =?us-ascii?Q?UOwbAVpQOuv5PDJgOwTUGp8yp85e5YmECkFkpaBMGVaMb9jgGUjJPsLcuWVM?=
 =?us-ascii?Q?LLYX67g2FcsBeDgDT7JtMA/FKxFXfCg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8dbdb4-55eb-43dd-12ad-08da3300107b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:40:59.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQrOuqA0lHWXLqp+359Go8wFd8amw17UuGIkA5p6i40/Heebx4vYCl0L2SinnWJAhSgYdEra+YRPfI9B1x+Acg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched
in them. Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 25 +++++----------------
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3e9246822412..ea3c93322592 100644
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
@@ -1642,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2216,17 +2208,12 @@ static void mptcp_timeout_timer(struct timer_list *=
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
@@ -2479,7 +2466,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3128,7 +3115,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
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
index 85dd69b8d9d5..59a23838782f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -629,6 +629,10 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops=
 *sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 53773668b5ee..3ceb721e6489 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -87,3 +87,55 @@ void mptcp_release_sched(struct mptcp_sock *msk)
=20
 	bpf_module_put(sched, sched->owner);
 }
+
+static int mptcp_sched_data_init(struct mptcp_sock *msk,
+				 struct mptcp_sched_data *data)
+{
+	data->sock =3D NULL;
+	data->call_again =3D 0;
+
+	return 0;
+}
+
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
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
+	mptcp_sched_data_init(msk, &data);
+	msk->sched->get_subflow(msk, false, &data);
+
+	msk->last_snd =3D data.sock;
+	return data.sock;
+}
+
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
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
+	mptcp_sched_data_init(msk, &data);
+	msk->sched->get_subflow(msk, true, &data);
+
+	msk->last_snd =3D data.sock;
+	return data.sock;
+}
--=20
2.34.1

