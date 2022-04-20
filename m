Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11737A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6KH0JZjxF9V5Mz1TPrg1Xc5MdqK38fIstsCnD9n5Tg=;
	b=XGX23/JDhxVuXMFtgsd973TfqQa3pnw7r/vK1243qJWIKzaRCcfvwy+LmFC6KRduWUe3sz
	WtL+Pm3WxBmhSaVYwfKwvI534o4IO56cs/xZJ4OEDQfo5U6b0eSyyWSo+qAkvKpERxr+Ot
	Oh6UfaWoGDRTNdCbIUF6OteHsUowwYw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-LQhNI_MAPk6bzOlNbIYmBg-1; Wed, 20 Apr 2022 06:57:37 +0200
X-MC-Unique: LQhNI_MAPk6bzOlNbIYmBg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwcq7HA7Ze8JqVzJxU3MZF73g8VRnxega2JG5+YGcqb3C9ryiELKU9NChALcnazx62STRUo34QJbuM06q45mT33XizT+zpS9W0HJWDNqmvCtcJAhoORtPFyMJZsiOx790vo5rkXSSi7DqpsdMu6ZbrOIDd3USlJNW2BQw6ocfzwqBoMj6GH++NWqlUKjgayIPFQQ2xfA7Lks2scYP/m/8R4eMU7v8/lZ42tGALh3TLayDEKdPhddkX03IVUBFvFphYF0OI/aRcKuJkjdpVzc/dV27kd18cPExN8MLSbazA4CjRKHnJLJptyAJMc3RFwwaM91uaC8cnSCx0iDsbdwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29RsK9EuoXxO7M1cTS/Y60/xzC2ESgLLvW1ALtynvOU=;
 b=DHsNUjyvnBXlkbPB5DK8bqvpLuiosWMz17Ulbf6SUJqzLaijTTBSJiYdZ9rvG7Xke3b9CS9Oh7J0kcr4PcYGC/9GD1Vd/ebSPkGQ3Q2ma14TXxqENLsFfFtBb0Z/WZmX5umwoSPpaCTLGGOyY2d4uSUfe1FGDNft1EcfhEOIr6qMfp2mshAfsbZ4R6MnQ57hALElLsnfSZym0YYNIDLNZimvbbt/4rVZKu756DBU07rP8DqWG8AVPz8zp4EtbSQafSGkaEQ9usQWYF7YxF58So9X9LcHKzarS9P0UMT7t5McgAcykyh5uh8vjLEjG4hRwDs9sZrwkedpeEepuVe3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:57:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:57:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 05/10] mptcp: add get_subflow wrapper
Date: Wed, 20 Apr 2022 12:57:04 +0800
Message-ID: <b4d628fe6835278204c9013989fffad5eba1fe6a.1650430388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb7b8e25-9720-487b-c148-08da228a47bf
X-MS-TrafficTypeDiagnostic: AM6PR04MB5752:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5752F489A794BFCBF76CEC8DF8F59@AM6PR04MB5752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MEMIUsBpJqp5qWme39/3XbSKJTt8UiOwHNyf8qnBG1VfLbRQEoZyRTai58zVLqvA1nHSEy7bD2rAtCR13CdwV7Yq6AqjOzE3nrMWZ2Pn36lEY2OHCqO4tYlybvhYDa8UBSWsYm0c6Tv50X9ZeEsiT6Vk8yhnZ/yAu6nmWfXyyDQH67owK+zjHI5NL8Z6JG5TMaGqA0QtKS2pNNKZJjXsgNs67qBbR06ECS0hn41ng6ZIbRo7H1rLmNOMglX3q6vqrLYIWsdlskuNYalmYgFDDiXR4vnBkl62pQG8oWHiAyx+FuhFW48A6RRYimDsiP6Y2UkXyHaTOxuQXJb6uc5301bVY+94Yc32YS6bJrSx0GPlHorDGx92o9wurCEyDmsISeBK18kbjdjLTi5cFuLYDv4trW6FBEB5/C5uxbSHOYidzZ0CIcaEeQomX5b1230ORf1NLV6IhEs11o0wvdG7eOwlwoRuZExBeYRAVfz6ieyiwV6juXXsKX9WzwHmsOEUax1+1PcHGXjH6pIEjDJiXfrS7hAjRLh4OBPLM4sIG9lY+qsPbgvAnK6oeN98UY6eTcuIpf/83Tb1qb8QbBgpbSEjdl0WpAOyoMx8hXBBXdTcovjumWwQd1GANjmuB8Y5lYOhR/FUwQFnwW8K/QPuQelE9Bv0umaWw4RNNrxo/cTfOeddjzQGIrmXbVj4PNht
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(508600001)(36756003)(316002)(6916009)(6486002)(66946007)(4326008)(2906002)(8936002)(6666004)(8676002)(86362001)(6506007)(44832011)(107886003)(6512007)(66556008)(66476007)(5660300002)(186003)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1nNRaeQKBpuuYcdq4/e9i6kemcXZCbH6XLinlNJrv97miUlxXhRXq/+dCk2?=
 =?us-ascii?Q?QUmbQNu2EU2S5FQYV9tFCmyRAYLiy8/9j/N5EQfCg+BJ9QM9C4lqwq9kVLFv?=
 =?us-ascii?Q?YaK4dNDCfqwsfHsUTx+7PwZuphPUb29fBYCHltYxyqnYJKn2Ff7UkVnwuWXh?=
 =?us-ascii?Q?vWKvXPTLbo8qtsh10FduRFgE78bfgR8Ab02jsCAKHaEhacf8oohsE8i5dIzu?=
 =?us-ascii?Q?bhludM3aA373Lrdcs1Md4bJuguFP+sBejZTUtZWtAiQCzCV3n6AqNBVY6Dov?=
 =?us-ascii?Q?w4poNnqJxrx93A1DhqwTcixZVe4kIEF4XN51kmssUAac2KTJP5BY2OhxdMN+?=
 =?us-ascii?Q?NGLgUAl2plPrV+FEgNK/sI7fT1vHBp4SlQ7RkpaJ006unnGCaSihksHc+trj?=
 =?us-ascii?Q?1/3cMa19yEcvKXuTGSZtb0ujBABtipZsTv0bRIwcQtKicTMfG+0rzVmFlFED?=
 =?us-ascii?Q?uuKyC7/scATX59JXf5CxzjvqFgVG+duOsD+xFsyQlf/Q0b2p1HUvHOrFOzFS?=
 =?us-ascii?Q?Eb+vLYvkmQCnxgcCkb+5SDa5suGE7QFKIcSuSGartEbofThnpjifbGhKh3vi?=
 =?us-ascii?Q?CnoZMP1eCwFZCpdWHcwxgVM5S48Ca8y71MzbeE6V1tuyOVs6InNL90XtVoBl?=
 =?us-ascii?Q?SaWN8RpQr70W7ilDSycyBryxmY3ELxr0kEvqYlSSHpQuUT4reVwa/xtv5ZFD?=
 =?us-ascii?Q?T4ghb53TiCM9B83mZkhXS4Nm8OHzlaYmwHQ4kqr5zHE7/+LCl5yekZC0rDHD?=
 =?us-ascii?Q?7CPGCZsDWpCV0/6NIqmkeEro6K0MPic40EN8uwXSlMl0P7jokp8lR5kfbq9B?=
 =?us-ascii?Q?mRRgAY6iUSbOWFmr2+y9iBjAj/dwleEXBxB/iPEi6MP5LWdPkIb81bSR5ro0?=
 =?us-ascii?Q?yQ6slXZfSW0XIQhZkeqg8+SC6RgGeryUqmKdr4DX2LEU3Bk2Qk0Kzs4woTxH?=
 =?us-ascii?Q?bep3MT8xNkHxnlQpCYzoJDCxNbJTfYFVWhTgzoqklwinlO/KlQW9TC1z1M2B?=
 =?us-ascii?Q?heHoIGQOrP0fU/hs4dvumNCYSCJy+cl+xuRKUQO69OMGdgTB6byrCunjQqwT?=
 =?us-ascii?Q?3XlXA5f89bnVRjRsDCm1NuAdBuDrfhIKB9ekY+gBXBTtf+sqmmUBTwRIH8Eq?=
 =?us-ascii?Q?Fs37bEhAmcmqNj2mq8lvdLBwge46BO5D2QkRGzMF5rvOpcyYoicLTJYNtMWT?=
 =?us-ascii?Q?PmeVei04IZnodzpn46TMG71gJdpRXQEgI6QY+nH40oSrPqXtA3d9QcKaDq3j?=
 =?us-ascii?Q?+1whcYe8Bg2cDbqMQV583ciojCOfjvKPTkO+ebFviq7pXNE4L9v9x6bG+OMm?=
 =?us-ascii?Q?X45fQ9W6GCD7LzjwB/WeM8S1/BfGGxH71GBu4tqMrOnCCY1xXIMtS2wkftH/?=
 =?us-ascii?Q?2vhhTEa424dITGVqnmup++ud6JUAJVtUfNWKOyL8eeyqUS9CvCcXDBRAv4z1?=
 =?us-ascii?Q?/QRQShCVNq7icoZjcWAtcRaVMFUp7Nd74+gQy+VpoMNnuoy7ngMYQjH8+LNA?=
 =?us-ascii?Q?DZNmM+mfd74+C9IfhjWtPN8PT4N2T8lohgGyePLajRlRPWxC+MOSgO9/pGkF?=
 =?us-ascii?Q?THqfbxy89RK67zfEFJxLlfH6CNsL4Q4FDXHVycCY8EcwG1BPmydopJXeXDYx?=
 =?us-ascii?Q?fYRJ8K6Vj8SjVaibvwJ/NlQV+2XBW/u+B0fJfuIZ4LsGG8RABLU9nXw6UjtF?=
 =?us-ascii?Q?kkWNyGxoOJLAa86GXFkxjUF6NMlb35KPuOOQNvChvQv0Tcmo8I0R+JiUCRS/?=
 =?us-ascii?Q?D86QUM33exHOw8zeIRbPrQLde+QgKUg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7b8e25-9720-487b-c148-08da228a47bf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:57:33.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RARZVyCjM0KPx5xYR9qHqoD+areje3RJoTAMvIriDjSPSj9vtTr+dUzXWaATVyKgwdX9BiGMfZUf8avakGmUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow() of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 8 ++++----
 net/mptcp/protocol.h | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3d50c35c0b33..c1c23450eff1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk, false);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk), false)=
;
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2481,7 +2481,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_subflow(msk, true);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3146,7 +3146,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk), false);
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b06836d1a899..d831effe2dfe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,6 +632,13 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk,=
 bool retrans)
+{
+	return msk->sched ? INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+						 mptcp_get_subflow_default, msk, retrans) :
+			    mptcp_get_subflow_default(msk, retrans);
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

