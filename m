Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17023D3
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7/VNQhYVEGiM3jdLT6AudI6n0wpTmGsgD52ocyoOT8=;
	b=WDopnSz/ffvzO5wRoCghV9vyGxtUP7+09V4o7Ot9u0U21Xi8sXAXYAf/wzxV/Hxt9hzmPH
	Dn9SfbtdSfLe663fU/zk0tg2ILAE+5vxg9D6nm7K6e3ug187lTsCBnaRNZb5b0jFWaY1rS
	99vfeKrJtJZITPZOhYPB0FTnQjsYDn8=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-FXIrlidxPkCBPD1U0YYbsg-1; Fri, 22 Apr 2022 09:43:17 +0200
X-MC-Unique: FXIrlidxPkCBPD1U0YYbsg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfA9SxojGoucDqDidK3uCcLXTR2Ge9hHVNd7+c7IFhvZenwsSAexRvThfFCHuE5ImlkE41R847Wuc0sC+5zIXtjt5OrlEeN9XHFn31+f8jl1W6ZdVY9/OUFN9mYkhZ8l+S9+OTJS55J1sio381QHCvktQ/vX43GYqBX/+sF2kaSVHRY0dv88iiH14AwHAu1kjvPerL8n8BTPiM31aaGmHDyHogw7OWMQyWRGtwfOpbiakf+BiXJETbBO4AtHk+iunxCtgmFWlNGBb6l51t/b7K2ZiTGNm5LGkxjAsHt4OXzgyl7rHh+aeZYu09zg40bUQj197WIAI7W8YfNXSrqoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFZN7JSH5kMW6zV2st8JDT5sF62MTJxt4YFBaeIQNq0=;
 b=I957j8RaX0sIeXoxxicTxSzuZ+pl+nTcJYq6wyaE4tx5RgdRhdI5FFRNC2FDeaJLorJ/N229slK7jNNtUCKhmKFCV4aS/tO9IC9Ws9cvzI0R3U1CYfqznpsQCV0fL7rYjxwXyU+v+34AcvdlBFWjEPGMC1tMHkN0lWppRe9O8M5pl/pL7h+86Z0ZDdwHzrRBvuFNcs2UECdC+So6n4IT2uHp5s1y+DNTWIRFfMpOU+GUrv+crNdqKBjN6Iuj+ej3SlcPZyaOuTtI/iWatOWlc3oW0RYsO3U+xh3/e7tuEEGJCgmSwJUrHXvHM/py/tWOV+LWPo30vu9WvvfRYfiEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:43:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:43:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 4/8] mptcp: add sched in mptcp_sock
Date: Fri, 22 Apr 2022 15:42:52 +0800
Message-ID: <e0a30c1c8995039ce9edc4e749f1ae351c89f3d4.1650613135.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613134.git.geliang.tang@suse.com>
References: <cover.1650613134.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 511fad74-68ce-44c5-fb22-08da2433c32b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5876:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB58768A7BA6B1577EB2C17F66F8F79@AM0PR04MB5876.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6U68bIowyNMMuwCK07nWXlNbnDDJcYrv0wGtpCeHioNFGLuT+tFGZ6LkSf6hFuX5zPAFRVf1FLuVfiOnLfKfwWtUUuZAk19Cbcb2OW+UDS3PClJPsvorkQ3298K2b1ahq7h8fq1xt6BzE5RByK1pDBwwhqsngBh+wUb3RqtffMQeqqL/XIaiq6Y+5W+bHiHzCkqyaiaDIeEOGsIq04qJAxmqic8HoqM+/8SsQ4bg2kOduBUaETGt30syEuOQ4+qqS6EJECEGet+erMOGHPo4z+XeqYqTUb52ZHa4zz7i0L51QIojvjtFk2vZ08nWxFmR7yYpHgWwTWKa2cDmkYYooE7pzUo7Vb1WAIrEy0KGRFVAAD2xx+Sgjvwpe9EKAGhZLoIPImh6TaI9xXqC21jIJSbqOtTycMg6AvqqqJ4aKVtC634ewf9Ms/0kPUa4+jL1W/q5LqqlnuMXocXX0jnt/Kra5iL25Zriz5/Vh9R1EfyYpBsWD6+OLG/X0CWDY8Q/OXJAKIXED4QQPyee+FW3C4P1CksBsC7c5ZogdpsN56ecTe2DRKd4oFc66P0RJoeZPROfe9hOsh9KyoOh5QU1WAb2Q/AQU2VjRviTrEIb1Fot4piP3sKfODPYpVzFDnH0P8yeu3oVygQaZkMgbcK5sxrMH70515U3zU3Tz5mUF9rez8hgnePt17U8RLPFV3J1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(86362001)(5660300002)(6916009)(6666004)(8936002)(6486002)(44832011)(4326008)(38100700002)(186003)(2616005)(2906002)(107886003)(6506007)(6512007)(66476007)(66946007)(66556008)(8676002)(26005)(36756003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5pr61Kw0BapAn9OClXjrvHpwoYzkGovcmCWhtw+1ecuAoTYmN1T6FgpxgWDv?=
 =?us-ascii?Q?7J60ab8gZPWKsSnOcJDqfIJ4aQnXd4eP7Dz1oBbWrGhqlfdpcCqoe502aP5u?=
 =?us-ascii?Q?8FsrjgHkQJssrd624EeoLEaXXZMEgbC093eM0+VSllf5cKxDEIZ9UzMqY0EG?=
 =?us-ascii?Q?cFHtk0oIjDUCJcBZkuRJHEM4/oOh4AM8gnmMMcVWwBKEZV/uuBCEo9UeIOOn?=
 =?us-ascii?Q?aTIDBzGZdnQ5frWoqKwMLAcimKmv9t0+Lo16h2uxXDNDHjN6FWV/X4vwEFCr?=
 =?us-ascii?Q?Q1g34NMvIjBPaNR8IEqbo2wrtLFwOj1yDdsD2UlGfEtz8WqcWq4Cd5pF6XsS?=
 =?us-ascii?Q?xIvykzpRMiORsDz18nocnswp0UdIQfXPIboD7JpRxASTlfVgDhRHkTpnGueY?=
 =?us-ascii?Q?HZfvFYazX5CnJ7D6EKXw3fqGHrNRwekUw8C3MglCtuXNlw8GWdpoK6qhLY+2?=
 =?us-ascii?Q?Zmwx8oJsBRSyoD3rV8nHMjQ9af8A9joRGdv8qNpbr1ac8dTmPut/V0Sm4BMH?=
 =?us-ascii?Q?ymNQ1RA2ktj+pKqrYGW+pWqCndR2KelQdbq0px1If/mdcn9dpze42hPiv+71?=
 =?us-ascii?Q?MkvGks/wMOu/3KZ9/htDKOGRrSx9xhqzCfdQxd9HUKKBrL7vbXhYjFauIQJf?=
 =?us-ascii?Q?+tbZ/xv5b7FeSOdsjxA4Wb8hgTGXbw7mfG+0t4bGYq8P6U+4xtK/DzTzjCzS?=
 =?us-ascii?Q?LgKxGK68KUriJIJ8w3a1An706raL7443ANxvmSi5de1zHBNZc8T+dENHLJgp?=
 =?us-ascii?Q?ZizolxaKgD0yfj1FiQBLZkgGGCiL3S/qWqmX6AeaZWHATmdlVkOPq9TIV9ba?=
 =?us-ascii?Q?xaRwIizE7nL3Kjd2RZGLf2iBbl+oXJERYEuo76w1XOoaclP1+lb6avrSCm6E?=
 =?us-ascii?Q?LSOqV7mWUGCeWTOgHE7IUiqkk3Wciqt38gx+tWZl9mFBaiwDg4IxYf9XUsHN?=
 =?us-ascii?Q?GMn0jOW6TBd1MjdUPnLRwPbJrDpVv5btIShcHQFx3JK8cFXntUDLsR5qsEDE?=
 =?us-ascii?Q?Btdyagdua+4ctpBurTako0vA62o927lgPZ3PrHSXV7/ivNPhvIk2FvpfZ+eF?=
 =?us-ascii?Q?oRE1eRIvqMEqqyeocxMQkattJ8WB7R/jN08p0uCiZUuoZcC897v9u6DK/uMc?=
 =?us-ascii?Q?cq1pwrD9tC33IIhehnR+h85oyEQ018KniyGy4cdOaV7kI19nDz9deSpoPDDh?=
 =?us-ascii?Q?eI5LPla94TcMAFHwEQ9UkYlWhJiCiyqUbfUoK4mwOUNF8ej6Xw2oHXRpPlw4?=
 =?us-ascii?Q?9PPDCG4RnrRKIz1rvhJbM32bsCToecyngpetMNkZ19opKvQ0i61hunXP8RbX?=
 =?us-ascii?Q?eevqa9EytmUUMAFkNdJYa5mnCxr+uzKOk77nNdbX9asYMX4sIeeGISJZjV+h?=
 =?us-ascii?Q?4g571fN+ldWtYb7etV7WSLSyNl3Zc8ZnMBXoh1KwnU/TvwmznyahMZbAFwoo?=
 =?us-ascii?Q?SgkYUWbVE5Bo44X3DW+0hUDcFwez8GLAB6aB+ZiKNkbAgWGiHKmL8pdIWzER?=
 =?us-ascii?Q?CxLxXXAmtBOwduZJVJyKAnF/8jRfT73/JnbQ8quHja/AFHMVJjwGWJlDwIuH?=
 =?us-ascii?Q?Nyh04kfYPpCz5JetY6YOW4Ekvo3A1I8AKH9jWnEEtd0QWMt+7GaDpB4/g0nL?=
 =?us-ascii?Q?kpJuZuWrIKSwz2fK6lJyTdm/Hd3lDhrP5E4lIB2n+RRauBWbFl/k0MB7lyBP?=
 =?us-ascii?Q?A6jIS6X+2OkTF9INq/t2qX0LYU0UQz8BNRwlpo64UM2oFjonnZgjgwSuIm1s?=
 =?us-ascii?Q?ACSaxn4EG4TqTDySvYBYhJJqHywqNJ0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511fad74-68ce-44c5-fb22-08da2433c32b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:43:16.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8uD9VVwgA+VrKNdbPjOyV87sc00NCUAyvEF6VGNhnqGJuBWEflP72Y7bJLASGhQUNh0RN43oymuIPdo0+MLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5876

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c                          |  7 ++++
 net/mptcp/protocol.h                          |  4 +++
 net/mptcp/sched.c                             | 34 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 4 files changed, 46 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3f2e1f18e970..70ba43c18e45 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2665,6 +2665,11 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
=20
+	ret =3D mptcp_init_sched(mptcp_sk(sk),
+			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	if (ret)
+		return ret;
+
 	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone wi=
ll
 	 * propagate the correct value
 	 */
@@ -2824,6 +2829,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -3001,6 +3007,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0b17b4f7b134..9ded79c942b0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -298,6 +298,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -628,6 +629,9 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops =
*sched);
 void mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinject,
 			       struct mptcp_sched_data *data);
 void mptcp_sched_init(void);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index bd0beff8cac8..8025dc51fbe9 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -68,3 +68,37 @@ void mptcp_sched_init(void)
 {
 	mptcp_register_scheduler(&mptcp_sched_default);
 }
+
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched)
+{
+	struct mptcp_sched_ops *sched_init =3D &mptcp_sched_default;
+
+	if (sched)
+		sched_init =3D sched;
+
+	if (!bpf_try_module_get(sched_init, sched_init->owner))
+		return -EBUSY;
+
+	msk->sched =3D sched_init;
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+
+	return 0;
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_ops *sched =3D msk->sched;
+
+	if (!sched)
+		return;
+
+	msk->sched =3D NULL;
+	if (sched->release)
+		sched->release(msk);
+
+	bpf_module_put(sched, sched->owner);
+}
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index de20fbdb6d98..a0b83fbe8133 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -29,6 +29,7 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

