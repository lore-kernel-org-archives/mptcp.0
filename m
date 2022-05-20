Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F87E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCwn3UG3LDI8fytH7NumMuuX9pwU5w9E8/hto5cI6vk=;
	b=kGZr71Qyz5pIxf5qV774PyOyF2dyTOsg2FcoAphvL5jzcQrpj259+Y0JLGpex8GSLFUEHq
	a9GCjhdwzXOaG19hMOTjGWEb7SeDX6ReD0eF0rlE6y5sV03pGuj853y47e/D53U/EyAgqv
	PvD0jNbNmis9RwfPJaOV3gcC3uS+UQ8=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-R3hQSR90OCaW_rvR-4wa8g-1; Fri, 20 May 2022 10:05:22 +0200
X-MC-Unique: R3hQSR90OCaW_rvR-4wa8g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9zxnLgo9AUO4yWzl81q+f3EE94Kc84022IiBJ733/w5xvRxNNWA4EgJDF0cx/soLR5WBJY/f3DPA6pZnWwUz78/Q0/Pkcb5N/JvnVPQ0Nm5BfAxQ6krYOYCvWz8wInzQIhcmQxxBZv+c5zssS+8nM26tzOt8yWMMD5THaP6Zd4TrE3uZtEN/jTP6Wjfy3MFK/qXGhXXGehqBy+xJqtyZ+hhdVVG4j4GxhqsRL8gkhFi0LBgnbdMr8YaoiGnQqz474/zSBNBmJcFS9Nl0TcClVQU5ZxpfBr0NoGvvQBgAeIQAlQAcw8areV5dRhMAYTC9f5A+XOn0GWD5vAI4LEcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj6HEouHYnpd1KdfG8zt76H+J8qzFGGukUEdyX1m50k=;
 b=TgmUV1Djz8kpY1kuim1N9HXNK+UjBkIvmb520irSk/np2MDQJKNhA29c99GEhwZOaApcJhxILp3+0R+pA+YQdewmwHBpgeK3gShxEehoYfMruoUA5ew5OCEYPSmVEi0zrVYMAqVJuVpa6U3nzID4x4VdmJbETU2043zG9S8gy0lzSN7/5IDMRjGnRGrj3Y0hdovs/PNEHMdqzO0fDxQJs7UMIJdrtSX9df+Z4voI83dRdkh3jfjoxX8E9xInhZnZAJoo+LuoAGdnyd2Dx4JnWA7J0xi8uVx7kgRW5XJEEuOM4tbgv5g58ltzNYXX+L28SB/vURUBgNz/wtqVm18oRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 20 May
 2022 08:05:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:05:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 03/10] Squash to "mptcp: add get_subflow wrappers"
Date: Fri, 20 May 2022 16:04:48 +0800
Message-ID: <727a87da10932296150becc361b48b60b43531f4.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ad17a64-b9f3-498a-7f22-08da3a377c12
X-MS-TrafficTypeDiagnostic: GV1PR04MB9149:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB91495C595916F64AE0EB22E7F8D39@GV1PR04MB9149.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eHWoOkiSCge6bfmRA2dAEyZzzVzgVvybclYcXoKFNN9zyFaq3hp3x5ZmNXHkgn+xiLypV1KrCpLqwXdRhUBbk6q4yLwCCetoL2RO4ZNUJNiSMflKxD+BMGOnIxfSfslBjX/qFQYBqFnUFhUdAWsuGCH+ayRE8DmWV+mAA5Cq+UTy1I7zWjqtYsMbZwM++nuhiABwVFqCvBNXyxCNoxjjh5iqDtIrcMqMlhhZ7OKC47pEuW0KEJooqVyt5Z7B6t/Wd1eV5z01QDgmV01OkBEEQ+y0xXo2KO3f8kFJ/aXou3dxdln49Vh+/MxC2W+OXA33SgedKwJ9cy94tXP+L4uFhNZihHDDHhhP361MhdcU+SdT2Giq/UNcb33h9iegqO57DDsi7/iudWz6vvs9NbwtfJuf/Ho6wYSbDPWBQ/tNTxKTyg17fRZY6yNN/Uu9oqHTCHxmHekaXASK9w7hRyLDSmZOYddfXC58rWnqop1Kd5NTHzdJKybE8kVnZ89xVhfuCbA/Q2UMr+w1knp9kkmLJSlaMLXn8ESzhZOyfQTxVxq3gsJnGCQF6F/mpAP5YzKJBvyumpL2RkzBbocux9xzygJlgQbWjS9m39Z7UgBWLvuJg17sNxDnczqV4Rk8Dj4IGyYAT9XfrB+4Dwhv11E/7/6pqS8ctLhMylyMiJu/h0Kn4TypgFtG0yfjp3ynE9eF/LKazcXTL6ajeVAOEDZWew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(2616005)(26005)(5660300002)(83380400001)(86362001)(6512007)(316002)(186003)(66476007)(4326008)(508600001)(36756003)(8676002)(66556008)(38100700002)(6666004)(66946007)(2906002)(6916009)(6506007)(6486002)(8936002)(30864003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aRB5hH9wq5xhRrTvCZYKYA4wwi/SXCK9hw84hEpyEjfoejsFHX6vziD7V9Jx?=
 =?us-ascii?Q?ZFkqdRPh5FMCcyuXlMzZBxN/8BXpmBvQV562vBK5tkxJjdXpYSb52UH3PFIJ?=
 =?us-ascii?Q?iTOW6FHXW9p91trKRbrJWxa+FdRsvA3mFqeyKYm0kl3jzqjwaBxrKfp6zl+A?=
 =?us-ascii?Q?ZzLB+RiSJhoys9QyiAMQA5AO7AF5L3EKkkKk8ys8kFrHQ3y3HPbVC9zoOxS8?=
 =?us-ascii?Q?+k3E8N3F7/Ba+/tnz5TxlcJ0GwM9WD7nLLfKa2Z8Nbzm6itBJ1VaFuJjXSbz?=
 =?us-ascii?Q?jSssNMCXsZfdauECdIRJFONKGorcVw3DzOTBkWtdUm2etLEMULrsjRNNiwJL?=
 =?us-ascii?Q?1gGqLSg6GmzcsV/aGDHDzPlTSvgJtQidUldrl4WOJQeS39b2Q8yLOVgzNv9e?=
 =?us-ascii?Q?oscefSjG8d0O0PnArFL6Wa6i2VBdpA0q7utVJJycDtUeny6hDZXiP6mA73mF?=
 =?us-ascii?Q?2TTxaNqhpnnF8XKqSOFqhK03/tWo5mRLgQsjNBHRX1PaLA0dOIviYmwvarmE?=
 =?us-ascii?Q?ViyXx24wfGkidJdOF+KfXlwj5vrfMRJMQFcKchGMF7w+qisBDaWD+UXUWpkK?=
 =?us-ascii?Q?6cqhL2WHHFkTR6RurgQGbA681XYXbtgCUm9DkbP6t6k2p3EyGbMkihAQxJGL?=
 =?us-ascii?Q?n/Qhj5PQzw2gzX/32+ZK8C8kiLRKhON401Ai1qbG1+mNTVm8OWTGqwSj3zzT?=
 =?us-ascii?Q?VHTlgGPqaVmaU+sgyE4W/LRtqupnDkJ7H6oW+msTtBQmPy0u9MX4Vrpf8pgO?=
 =?us-ascii?Q?YpKGnO7XEUMEcbAl61EXtliDVl9uPXRON9Rqz/DnRoA63J90phEK9nnENb4q?=
 =?us-ascii?Q?UnZFnniKcvMHT3BhT4idLil3iobyx0M/UqZNtWbQ978jNsC7CCDP9RQYtvpf?=
 =?us-ascii?Q?jR3IpjsE19llebo9S+NXucvi9npWSh3ZN+efQe1WdA3DInsl9GMC07nWczzp?=
 =?us-ascii?Q?kKVhtyUmjGhgfbvBHTup09Isnopwecw+gh8qYKiHE75yPWfDkmem6+VOLJ/c?=
 =?us-ascii?Q?L/oCa4Si/MYhOxopXigOnSz8+/aoe5se9MNJk1h8sCFhCPnPEhruuSzxOwzh?=
 =?us-ascii?Q?4ZiWwfpHMa+uhbQGM46Hl65s4gEvFe18pPu2YJxPtoYVJI1dB/5cigd3uaAI?=
 =?us-ascii?Q?0UgqH4OPrOQs4PpvWCKsJPoI+Tw3xa3+YmUissg2uxIt494op/McjtSP7xZb?=
 =?us-ascii?Q?Qv5BOmcTfF+Ds5o2VLBDFGrvdkuSpekZuMDgKE3XV7ZbUE4ZxFaOl8FyGnIe?=
 =?us-ascii?Q?1UC3zBQgrgJDizovLIlTPpX4Rk3GGRHjHYUKWbDFGYqixCO1a2TBqvpGhQWI?=
 =?us-ascii?Q?hOkdNTwa+RnK1jjoS4A4x1EssFGPoBepLQnfSirODGIBPyMT0dK06j4XOwRL?=
 =?us-ascii?Q?yYIINkLZhtESjeQ5+p7eRW8RkZohnsyX2MPnlELg96FYYfFk7aeIY2y27BM+?=
 =?us-ascii?Q?bZNDOKIGNZXkV88OBMfDfj/sP3JeIQCzL9HUcu+lHWz5cNQ02d2JOr/AT9UY?=
 =?us-ascii?Q?whxw222x/BJH7cnNSbLlVAXsQ6Ivhv0TRZoYuPq07RS23Sk8jkvKXL5vXQpJ?=
 =?us-ascii?Q?ol2BMy01X7ZK/GBo/fmBKK8nbliWvRQDRhb/uaKnK6YPrcnPZQ7xujmss7ws?=
 =?us-ascii?Q?WnE35Tocn2QdAlyTClCigDC+WFV+kBkvhOe+6orOXvRx51sI8CjT/33Md5aK?=
 =?us-ascii?Q?aP6z8nq6Rt6CqHcOD6pj3pW9Mw8gUTrgmYFRPQ0s9EFZVEdNWFnQ/kH2yAth?=
 =?us-ascii?Q?hr6N+M5WleA9YcPl3Q2B8aCVxEeJMss=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad17a64-b9f3-498a-7f22-08da3a377c12
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:05:20.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnGgZIo9As99IjJ/6uTZOii0tW9JptjEOYflmQQIj3IifI5p2iBiPKF2hliGwre2eUZ8jRiw8o4R49tc0GoHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

This patch adds the redundant subflows support, sending all packets
redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 192 +++++++++++++++++++++++++++----------------
 net/mptcp/protocol.h |   5 +-
 net/mptcp/sched.c    |  78 ++++++++++++++----
 3 files changed, 188 insertions(+), 87 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 96cf1620348b..274818480a36 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1564,37 +1564,50 @@ void __mptcp_push_pending(struct sock *sk, unsigned=
 int flags)
 		info.limit =3D dfrag->data_len;
 		len =3D dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
+			struct mptcp_subflow_context *subflow;
 			int ret =3D 0;
+			int max =3D 0;
+			int err;
=20
-			prev_ssk =3D ssk;
-			ssk =3D mptcp_sched_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk !=3D prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
-
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk !=3D prev_ssk)
-				lock_sock(ssk);
-
-			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <=3D 0) {
-				mptcp_push_release(ssk, &info);
+			err =3D mptcp_sched_get_send(msk);
+			if (err)
 				goto out;
+			mptcp_for_each_subflow(msk, subflow) {
+				if (subflow->scheduled) {
+					prev_ssk =3D ssk;
+					ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+					/* First check. If the ssk has changed since
+					 * the last round, release prev_ssk
+					 */
+					if (ssk !=3D prev_ssk && prev_ssk)
+						mptcp_push_release(prev_ssk, &info);
+					if (!ssk)
+						goto out;
+
+					/* Need to lock the new subflow only if different
+					 * from the previous one, otherwise we are still
+					 * helding the relevant lock
+					 */
+					if (ssk !=3D prev_ssk)
+						lock_sock(ssk);
+
+					ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+					if (ret <=3D 0) {
+						mptcp_push_release(ssk, &info);
+						goto out;
+					}
+
+					if (ret > max)
+						max =3D ret;
+				}
 			}
=20
-			info.sent +=3D ret;
-			copied +=3D ret;
-			len -=3D ret;
+			info.sent +=3D max;
+			copied +=3D max;
+			len -=3D max;
=20
-			mptcp_update_post_push(msk, dfrag, ret);
+			mptcp_update_post_push(msk, dfrag, max);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
@@ -1628,7 +1641,10 @@ static void __mptcp_subflow_push_pending(struct sock=
 *sk, struct sock *ssk)
 		info.limit =3D dfrag->data_len;
 		len =3D dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
+			struct mptcp_subflow_context *subflow;
 			int ret =3D 0;
+			int max =3D 0;
+			int err;
=20
 			/* the caller already invoked the packet scheduler,
 			 * check for a different subflow usage only after
@@ -1639,31 +1655,41 @@ static void __mptcp_subflow_push_pending(struct soc=
k *sk, struct sock *ssk)
=20
 				if (!xmit_ssk)
 					goto out;
-				ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <=3D 0)
+				max =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (max <=3D 0)
 					goto out;
 				first =3D false;
 			} else {
-				xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
-
-				if (!xmit_ssk)
-					goto out;
-				if (xmit_ssk !=3D ssk) {
-					mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-							       MPTCP_DELEGATE_SEND);
+				err =3D mptcp_sched_get_send(mptcp_sk(sk));
+				if (err)
 					goto out;
+				mptcp_for_each_subflow(msk, subflow) {
+					if (subflow->scheduled) {
+						xmit_ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+						if (!xmit_ssk)
+							goto out;
+						if (xmit_ssk !=3D ssk) {
+							mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+									       MPTCP_DELEGATE_SEND);
+							goto out;
+						}
+
+						ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+						if (ret <=3D 0)
+							goto out;
+
+						if (ret > max)
+							max =3D ret;
+					}
 				}
-
-				ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <=3D 0)
-					goto out;
 			}
=20
-			info.sent +=3D ret;
-			copied +=3D ret;
-			len -=3D ret;
+			info.sent +=3D max;
+			copied +=3D max;
+			len -=3D max;
=20
-			mptcp_update_post_push(msk, dfrag, ret);
+			mptcp_update_post_push(msk, dfrag, max);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
@@ -2455,16 +2481,17 @@ static void mptcp_check_fastclose(struct mptcp_sock=
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
-	ssk =3D mptcp_sched_get_retrans(msk);
+	err =3D mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2483,31 +2510,45 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
=20
-	if (!ssk)
+	if (err)
 		goto reset_timer;
=20
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->scheduled) {
+			int ret =3D 0;
+			int max =3D 0;
=20
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent =3D 0;
-	info.limit =3D READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->al=
ready_sent;
-	while (info.sent < info.limit) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <=3D 0)
-			break;
+			ssk =3D mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
=20
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied +=3D ret;
-		info.sent +=3D ret;
-	}
-	if (copied) {
-		dfrag->already_sent =3D max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
-	}
+			lock_sock(ssk);
=20
-	release_sock(ssk);
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent =3D 0;
+			info.limit =3D READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->=
already_sent;
+			while (info.sent < info.limit) {
+				ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <=3D 0)
+					break;
+
+				if (ret > max)
+					max =3D ret;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied +=3D max;
+				info.sent +=3D max;
+			}
+			if (copied) {
+				dfrag->already_sent =3D max(dfrag->already_sent, info.sent);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
+
+			release_sock(ssk);
+		}
+	}
=20
 reset_timer:
 	mptcp_check_and_set_pending(sk);
@@ -3118,12 +3159,25 @@ void __mptcp_check_push(struct sock *sk, struct soc=
k *ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
+		struct mptcp_sock *msk =3D mptcp_sk(sk);
+		struct mptcp_subflow_context *subflow;
+		struct sock *xmit_ssk;
+		int err;
=20
-		if (xmit_ssk =3D=3D ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND=
);
+		pr_debug("%s", __func__);
+		err =3D mptcp_sched_get_send(msk);
+		if (err)
+			return;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (subflow->scheduled) {
+				xmit_ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk =3D=3D ssk)
+					__mptcp_subflow_push_pending(sk, ssk);
+				else if (xmit_ssk)
+					mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SE=
ND);
+			}
+		}
 	} else {
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8739794166d8..1ce01db60b7e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -461,6 +461,7 @@ struct mptcp_subflow_context {
 		send_mp_fail : 1,
 		send_fastclose : 1,
 		send_infinite_map : 1,
+		scheduled : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -630,8 +631,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..207ab422ac5d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -91,51 +91,97 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
-	data->sock =3D NULL;
-	data->call_again =3D 0;
+	data->bitmap =3D 0;
=20
 	return 0;
 }
=20
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
+	struct sock *ssk;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
+	mptcp_for_each_subflow(msk, subflow)
+		subflow->scheduled =3D 0;
+
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first && sk_stream_memory_free(msk->first)) {
+			subflow =3D mptcp_subflow_ctx(msk->first);
+			subflow->scheduled =3D 1;
+			return 0;
+		}
+		return -EINVAL;
 	}
=20
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk =3D mptcp_subflow_get_send(msk);
+		if (!ssk)
+			goto err;
+
+		subflow =3D mptcp_subflow_ctx(ssk);
+		if (!subflow)
+			goto err;
+
+		subflow->scheduled =3D 1;
+		return 0;
+	}
=20
 	mptcp_sched_data_init(msk, &data);
 	msk->sched->get_subflow(msk, false, &data);
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return 0;
+
+err:
+	if (msk->first) {
+		subflow =3D mptcp_subflow_ctx(msk->first);
+		subflow->scheduled =3D 1;
+		return 0;
+	}
+	return -EINVAL;
 }
=20
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
+	struct sock *ssk;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
+	mptcp_for_each_subflow(msk, subflow)
+		subflow->scheduled =3D 0;
+
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		goto err;
+
+	if (!msk->sched) {
+		ssk =3D mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			goto err;
+
+		subflow =3D mptcp_subflow_ctx(ssk);
+		if (!subflow)
+			goto err;
=20
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+		subflow->scheduled =3D 1;
+		return 0;
+	}
=20
 	mptcp_sched_data_init(msk, &data);
 	msk->sched->get_subflow(msk, true, &data);
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return 0;
+
+err:
+	if (msk->first) {
+		subflow =3D mptcp_subflow_ctx(msk->first);
+		subflow->scheduled =3D 1;
+		return 0;
+	}
+	return -EINVAL;
 }
--=20
2.34.1

