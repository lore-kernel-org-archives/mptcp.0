Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D82564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJE405uDBfSRJ+SJMznEnJKywNJadW+OPNpyKtWlEyA=;
	b=Ulde1fhCejyeb91dt1PYwqBCm678dMEawyAxUygsk4DC0PKAzQT0g5ANbEXUatHJeVC4nE
	o9HrkYSkO1htDi95apohQrimNiJ2QCMI+L3N+VCgA1p/CLUaUj0upyQry1cRvzpX8yhwIk
	Py4QIQTzTn5l2Qz6NHxKGlyYhiXeyS4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-HKTkWkIvOIaoQsRXV0RvXA-1; Fri, 08 Apr 2022 17:38:49 +0200
X-MC-Unique: HKTkWkIvOIaoQsRXV0RvXA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnyjBJ8IDHpvyC89/md8Ysi/e1VYVhg19LhJX8sds7PVaPBUtzX7sTXW+8iPRmdlYd+TupouGfQsHM0NcGbVNJR60224YBTC3fQ2ZQzK/poz9NlBo6NPW85CAu4McSNuMxt2wX2wHF3pjnJJVKhQcwzEDB8eD+NeWAzdVQmUrzSSyscsa+fP4o/7fr7t+ra0VskHYZghSI6y8jz51GHsekkt1M1O3GpDddY1CGNL4ZB2WHfjnB8YrmX8TPaeDPHl6kCe5/glEdzPMNGySCjczmmqc118EGpY1Dt8Hy2vIZ4CyRtj5RXXcfSSIrC6amNpgj54+YAdkqrPhCn9x0oxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4aFxYxKyQ+POGu8T6k+SkwS8X3Ugj0JPvJAvKF/Qso=;
 b=CaG6otCwdP+AkEToWh6l5aHQlGa1xFpFp2doknJ5XSBub+yxyyQLOfRsyeufdG2iN+57h23IKUTcDyYXqP7LK/p68427ytbIjk19lhKt3Wk8ZlshIoXy+pZ2Zu/WTlDuQXoCkvUUX+JI3mgcOUyeUGlcTiX1Jg3oAg2qHX+qbYQgKwnE040rCut50UOby/AWVahvqz8VOEbhkJ8tHZPpBpv69LXOaz6DhWjAAZLTtuk7O4+wfkPxU8s+p2QEYn8qP2/hdP7dNV4vSAj2tZRHePPM1JNUM3naE78LWaHEtc+X8kb1U5nIuCnWmIY/kJgEtn8LDbCVzFMsEAS0wPBtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:38:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:38:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 5/8] mptcp: add get_subflow wrapper
Date: Fri,  8 Apr 2022 23:38:02 +0800
Message-ID: <752c5475b78dc8408b2f0dc6274b35dff0a08710.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1545b40-646d-443d-9e73-08da1975df07
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2995C9E2D31A66BF5347D3C4F8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j9gTSUOlZ4ymM7LElh+klB5gbVeg5gTejZkrb7BCE1bV+9dFnSDCjmKQLOp0xF3qBKEJf5g6ZTC/xrMenUkjcz3GV3Hz9pzzdAZCgvvIfEjGx39gKXYErwl1tJyzdlmDjlMtrcrzMQyfA4ORivOqP8hhYCcLKZQX8l2YwOH0EYTj8decWzByqNdMfNbYJOrG+gj5PAKOt+pEr1ak9YX66oMCOAwc0Y9wB2ijjkUcjJV9sQsemrg3NxtF9Ot1oCGetGtnc0Wo9+a070ukp/ze6v7TYkqNh7CrvJfmqe4V2/qSIPlencM+UjInkUowMpV8BpYHUpW8E8c8hTNMMibR2EhKsq61pVxZkwvXuI0OHFLCPI19lBqMxrrjXvkCLVleTsreP+W0Sxg6QBhsELZVzfwH9yDQvVnV4ZLnnuHrfilKZZ5TdV+wvbdW0nvZxiv1WNLvCEMngDlRWRyFmLSTDWSBTTiJyhS70BcOhMIDGKCIsZQ4/6Wi93N8eii5XLNJgsH/8ixN967XmO96e56aekwoR7WfCRnepZNpP1BAV6Cq63t0BAyeXTGtq6kmlzLHB5Zlamfs3G4mxT/+AwNG4cpMDeJzJ3Fbmn8v+Aq06kZxF5WPhQuNWWwzRnAiWqqCjduvxX8yd+e77t1x6/ghMrt6OCW9eKrBkqjLX1pn95W1JCgn6C1XA4D/JQMyJJ0j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(83380400001)(66476007)(6486002)(36756003)(6512007)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6aEHvrunKOM8q47rQTNwCUuZNVirE3zrGJ9z6w2FTGXqGTXzOh2jIbZ2Ngap?=
 =?us-ascii?Q?zyXPBwzNQynbCqMP3JmqZa2YjskDZsid5V+ay/E3ZQ6n2GExzHrVtTygGno6?=
 =?us-ascii?Q?lBhi57DBRdLwkR8f6gVkXNEKL3TJOT9v8tK/Kk2r2u4kbrmSPclDxN3AWtZB?=
 =?us-ascii?Q?F+O/Z+KAVb1plRrtIj2ZSF82ybGj8J6Fx03kTfjyvR+47XekQOmbDmCG0OuB?=
 =?us-ascii?Q?ivYMtNo83OsWmMjat1hojj4zgx1OlE8fxBHrbeSfi5tL3QXVp7hjkU3BdV7H?=
 =?us-ascii?Q?MqhAnZNYXC5gOQDRdC0OPyEEX4iIH2HUi7WHJfB4PQH6I5t5z1MH8xk+Sp94?=
 =?us-ascii?Q?Nr2EYc9n4mnyq1GM6esm7UsYNzFmUTNoeHKiv49z+wf+ffLTqKiBd20D4Mig?=
 =?us-ascii?Q?i7YrDOVxWIwlI2lW1TvtJ1YuStWsHLiwVMI+6utm9/oyeooxWdYbGZEY5tM8?=
 =?us-ascii?Q?rpYUR/gS9BdnUwGDRKktoxN6A/35zpcObFb+QLcZmYx1f7wrZ/2pUqROt5q8?=
 =?us-ascii?Q?a6S3JlAh3qInjm3JlH+jWIUNHB4jZl0SXd3wsx3pI/ZwHsPA80XyPHADNWNR?=
 =?us-ascii?Q?7ZCcx5QP/7DMcfax/RHJQPyLTnNKx/xPVby24iY3aJWn3PxywjDZHp/16sJj?=
 =?us-ascii?Q?sfVwYt0Z52nN15k9rfy6NKYIZx+Uzoa3bNpggZK1IDivSKNRxSaGwPtUDfWG?=
 =?us-ascii?Q?FWo7KzoPbPZxPFpjkSd4r92ibBDV3zCfcrN7rvBAuOD92i6copfN4tcZOCNW?=
 =?us-ascii?Q?pLOpAmV9MTIszukDe+uwrQ+1CVuRMxzZwJ1lMx99+vVCrbJbpVyhaXzC12Si?=
 =?us-ascii?Q?pzv0r7wavKERG+HquOUqdvYGJXtGx37rpgYQ5St+i7khn09toUKIh9WspJAR?=
 =?us-ascii?Q?+201aJKLe02mBxVxrk4UJdUZSMcvHW2DSrELMbZqkEqc2Ypv7xGet7aTP/CK?=
 =?us-ascii?Q?wD3MJN9XnuZXrOdE8nXK4LDNENPEvRmv3XD9qU8N89S7UYo4B8xBGEl87miV?=
 =?us-ascii?Q?f8f/XhvozPIZNERGxoh8VPruJRaof5tjreJ87gQweqzJt86Sd9llDulRSv6j?=
 =?us-ascii?Q?LYLanDAl0mBqxFbPeNbgzt+mYCUarGOY5cRvK9Tl16h6tLUp7OT2Ux4M5RiX?=
 =?us-ascii?Q?QGH642lWmemOvZHPa/0zvzmvNN2Mh7y+D8byhkvvrNaRdaguxmfjv5OtTcHf?=
 =?us-ascii?Q?fYM9em8zILP0X7tMrUUd3gdPrR9BdTbL8TfnYSnT5NN1SjhMkL4oOa7hzNIR?=
 =?us-ascii?Q?c3LKxI60eU0y+x7c7+f4GpfDUG68RmPDv/Br9eQUn4jW6I/9+GhJkQWaamyV?=
 =?us-ascii?Q?6ZSmvcq6ZTV0oLMc8vN0ICka8t4v/zbl+Aqw3oKN/1bJVxeO+avaIT3Oxk43?=
 =?us-ascii?Q?NReI95sXDkvSACp1n2m89agujsFfaFMc4wT1SCLbQNYkXiJWDQxN7ZFDH+jS?=
 =?us-ascii?Q?GbNLsnk2f/TYJ/wy1HIevnHg97P2cctT+tYOw5kUGYUQpGV3PQuSqWxR/r/w?=
 =?us-ascii?Q?WPaq8R3yLuG2htO1oqF5ZPe1FHOFIK5+2N6Vw+wFge5WFXeY++Rk9KUUjkSB?=
 =?us-ascii?Q?AGK/lw/jy7qmnwjJtQE5gp+lfRhoh5Ts8iUjyQXoggmvFiF+vk+Buz113/vR?=
 =?us-ascii?Q?e8+FCAMXqZhWaL3jo1+60zwiRNWoyv77TJvCrPm7uJuzSuA+w5J8YULmHnLJ?=
 =?us-ascii?Q?KKEIH6krrHzkGx5hEqigoIdQuEED+aqrfoLPFByy2WWGorL5qJvDDZAsxSzV?=
 =?us-ascii?Q?GLvz3bSBEe3M0KNvqO+uQb8Vz8We9Es=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1545b40-646d-443d-9e73-08da1975df07
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:38:47.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FNsyJ39A0Qtb7+K6Kyst68eJDOTO/snl2ThsWp7glY39uUFLfy/FF9ThzXT035B96qUgDg2kOjFy9GgnlaUww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow() of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 8 ++++----
 net/mptcp/protocol.h | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1153bddb92a6..785c428f87ea 100644
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
@@ -3145,7 +3145,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
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
index 2b3143045f89..a58c5c84e72b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -619,6 +619,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk,=
 bool retrans)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_get_subflow_default, msk, retrans);
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

