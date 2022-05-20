Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3D7E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOP4NYQRPLir+GWOgn/hkiysQruerMXq6vYcmXcEkwM=;
	b=E6VduBIsB4i91pMlbdRYYphEZZCaNFeDagasDq+wcujVa79lwKzTwNPRbQ1QfEpMBew7oS
	dktjXGda8y45oR2+MYT5IURXavqmOI09DjS0SYq4lF9eHl8BhihTcbqzauGm2+AVm1+0xv
	UtlIeBJqFUZvxcm3XlGzWZa38cQT3oM=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-gX927ETjO6qa1gXpJr9T6w-1; Fri, 20 May 2022 10:05:36 +0200
X-MC-Unique: gX927ETjO6qa1gXpJr9T6w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJJaYpJjVb3hHHs4sEUD16eWwDACOfe902bRIJSpHDadmbapJL0CgFE0GSgpVoNxHW4HGW8QVZa5yxe16gPAoKUbBsBmHeClw2+c7QcDCBv3QHP5oLbka1VgYZaCK5LdEKxXstSrVRAFiSUFv4DRZinrW+6zTWvjUsnKwmjhnRI4O7GYz5xwe9vLrZhSOnoxQFbj6sQYhe8B/6RNtfzj9Q9GBfbLxXxdHjXbztfx+lDfcQQ5LBv1kY7Gzw4rbQij8ZPyt+QPPiWZZWk0F98iMNC7ikOdqzXbcA2vMswLm218RWXdLubuXk8CwfH/c6TScwvI9MXEGgItXBphU6+MqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uq57ek975SCwqAuQMdO6ag9bVwyxxhqKKeBl0hA774=;
 b=MEBsIT/oLXM2EeVH+405EKhemo+X0Xlg8xKBDtU2TH0yGZwF/YWUk3K5lTWZUhu8BuuH9tJ9mgeSV0Yn7MGS2QdDkfTEHpup36HUMrDQTgg7aHwg90oopOiEkl+i2kEPjSrv2Ctmt6y1lN87mOE1mJCHF7BTDC4yyNtnX8RNLEO3TwOHUD55goLgvgB7M0dqkeHs9EZozi4IcyjuXzCEGaZnkA8JpUPOTHaLZSvLoHxropAlpPvbLnQKcn/9H80N+wLy8mgYAF3coFGOQyx/DU6woTDoKzvAkr2JbcJXQKx1y0oowX7pZdibR/nhzuTGQX72WfrkCUDC/lnTHmtZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 20 May
 2022 08:05:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:05:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 05/10] mptcp: add subflows array in sched data
Date: Fri, 20 May 2022 16:04:50 +0800
Message-ID: <fbfc0fd93403e416a12f33e828eca983df632074.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4224c479-7b2c-4494-ec69-08da3a3784aa
X-MS-TrafficTypeDiagnostic: GV1PR04MB9149:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB9149FEBB2B48B42BD31C5B3FF8D39@GV1PR04MB9149.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fdf4ERXpg3DtDT1r5Btk318iAosEYmZlR1c4hhrtk6HQnLnpgYviHo43AYtYzzC5gQg1KFZ/dMH4MI7WUYtROELW2Vy5Yn3vdYk20IBis4VXD2TDZmqZgQfXCCYKvdwUNbAEKF07KqQP97bNyaH5YE10TlfG8E/Zy+avpS/64ntER4zcpjohkBWnG6n965Oyye0irO1WKuyEXtCcBq67rsdeEM1vA93E0t4cGb/Gvjarb+aEtCSFF9xREOlleDuROATiPNtMrDq4R1qeaUj5mpGBrDJZvbzgwD2s1KcdaXJgZk5erYk4YdFWu2m2sK0RW1RJb/YFPrA0G0H4DU2WblUCP+i3EdKT5c1OWnELBUbCRAMhCDFRbUMLkOaJQT3SJGXV9nVTSveRfb/M2wd6xaF4izeiciiTUdAXQKPaNPquOove2jutG20b3sUNnE1fuaz5gtoV0q/g5Sl4S+B7ADEWpWfDdNEd8ToIIb7KaXT83Z6UnWodYVN2L2vagpSyjl+2Gnb5S7cb05AAuEUJC5s3pEkPHodTX4bnPHhXzh5aVlZ9nFwZv5SbkjkQSFyl9cCc/9T5NOTqC3kPD4lJFP4mYAv2iTHtvOdwocexVzn3zTvS1THWKFdZG+BtdP3g8wkRqh3/qxE9CVIpYP6SCndV7PiFpq4Hz1DU6sludVlnaWps2PI6fKh4GkoBXXx47EU8wWq8ptoqn1Gd4q+81Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(2906002)(6666004)(6916009)(36756003)(508600001)(38100700002)(8676002)(66556008)(6486002)(6506007)(8936002)(316002)(44832011)(26005)(5660300002)(107886003)(2616005)(4326008)(66476007)(86362001)(83380400001)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S1+JW7Yo4VhFAUZ9gvKGrLoDlss328RbXGbbzaJ/av0ljYZN2TI4CMVKvOKZ?=
 =?us-ascii?Q?yOxa22kIhH1TUTK1DtZYxOFyxNwtYojb19GFEvagl6TJtt57V6m3Tbka8SMy?=
 =?us-ascii?Q?OM3r0xis3LpvObfGswes2wNrSbsnX9EdQnHZxccOl8Vp/nP92/41xAAMbmlZ?=
 =?us-ascii?Q?4EBcKjuEfbpEpmdfIZGgHmfjT1tLH7xvAlYOfm3Jvu/nmLB3UnHH6q2PMLAl?=
 =?us-ascii?Q?a0Ykbct4QXNsdAyC1R3yzFAOA/Wiaj+DCCu7/FB5Huj8/BfXRMNTpZH+FrTH?=
 =?us-ascii?Q?gbOnQfDK7TACiHb5as37DYEw3TzYfoRr2LF+7NU/++fcwkhVABL4/DPI2v3l?=
 =?us-ascii?Q?CXmlLsuKpSUAk+LcJdqHenRS23/RWjuyqlPZp3+gPQ9deJEd73ifjpCg0Jx8?=
 =?us-ascii?Q?/s1Zk8G0wmY/QGY/9J+HhjtiN19jpHMCZbCrDJjcURGAPXA5e29r8ya6KnTu?=
 =?us-ascii?Q?rt0rX7ra7TDOyzTGXHfVtLmTJN4GCVTGGXQfGujgKmVSvPmQj0skVmoNsLcz?=
 =?us-ascii?Q?hvJ9WIfUQTxlnYFS87l1loc6cnadgfLfIxAbOmILSblOpWiG8A3Zv5XBr4uf?=
 =?us-ascii?Q?85r8KltBIBpUHLLMTOT3o8vBUocEpnYje8/dr9HXITqtTUDLGwyAm6gCepj2?=
 =?us-ascii?Q?ElMRRtOnNrde69FMh/pf9G07qsA7ZlzsPCfKxfS0cfOUZfUgaAaosNI2YF/l?=
 =?us-ascii?Q?9MyPcPRCpVVpSZ2zSHU71y9XDMvz5t/6EeolVc5FD+eEy2Qv4j2QPA6274KF?=
 =?us-ascii?Q?gOXt0F8fzuvICiOu0eYzMl7+VVfLbPAJXSqUnatD76XRh1SA3oXghCygulVu?=
 =?us-ascii?Q?hjaOOIz2VLmFMn1VcRSwpw0ooyOtrK7CDD9YJSTiBrnWlHbz7qiMpkP1SROm?=
 =?us-ascii?Q?QuqtTI5d5f2KMz+8JaMwkpiYMk1LiOoz5y7sFq27aT6n3dHAAjR6iJiKDOSd?=
 =?us-ascii?Q?W2FkYwgD/CXuoeax9XVkzSgkG1NmigMaDPwZgb7ajtzbHfxLPq/2vNfU/XKU?=
 =?us-ascii?Q?ry+8epPj+C2WJTpqkj6YM8RTqJ8Iq39FMSWoDAeyWW0vxOqFH8/lk+tZjzWc?=
 =?us-ascii?Q?ljq9Lg2QB0dcn1VQoimDuSjxRVoQcHestPpolcLyB+MoX3jNsYe6g8pA85C4?=
 =?us-ascii?Q?hbzBT1+KTrx29rGQEzyNX8s+ielvrZ5duhwGoMSZaEn8+EF2YYST2lqeqQPP?=
 =?us-ascii?Q?/7yRnCmRhPF2X3u/sx/BE6LvtyP9h9CNmmuZGMJB31iWjTNFWZq82sVUFoE2?=
 =?us-ascii?Q?BXMeEgNcpudWMtFLIwCQwX833vQmJqIwKX+zGjnlX+juzKhtUe4hGpsRE1sp?=
 =?us-ascii?Q?nNSZsUYbi7GTiM7qD3/olhXCxqr1nuoB6IJa1dp3sheBdeNGlUWdFG3tyrw6?=
 =?us-ascii?Q?ti6q0LKfviJ3On5Ndd52jARN+2qM4DzkJZOAgeScqYxnhqbU8JV7sQ3acvQf?=
 =?us-ascii?Q?WoevIBMHqduZIxQGkjUtkDwwVTIbVw6nzJRDWGz+9sZQm8JIXrPVfmk37oNV?=
 =?us-ascii?Q?s5MBwVHbkGktsoi3G68cDi+Cb795EqE+PDnCcq7QBKZmJhADjA1plxeMlt0r?=
 =?us-ascii?Q?UijdFMxt49ZQr0c2end095IwT+qWikRqchhFoubyZwZM3uFpgSquMnLXsueW?=
 =?us-ascii?Q?WHmPdw/wgFQ1DlGlgOxbuXxMLd+1MHb+Bs1we3NqkgO/KoHoMAqCW2X9VzEL?=
 =?us-ascii?Q?XpceAqceXzLjZAVDfMhlyGc1DjNzFzJIFsV/7xHIcm8wQOAp4DYz26TEYHlb?=
 =?us-ascii?Q?bYqMBZRlv8OcZeP5fucXBkM+h9tQ4gQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4224c479-7b2c-4494-ec69-08da3a3784aa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:05:35.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpxOF2l4i3dOY9xRx/l0QsCeFKW/pwBZZDz83MyKCeQzbicGWw7jD4uGdBATZLg94FftNKAtGbVeZx0fKTqK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

This patch adds a subflow pointers array in struct mptcp_sched_data. Set
the array before invoking get_subflow(), then get it in get_subflow() in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  2 ++
 net/mptcp/sched.c                             | 29 +++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  7 +++++
 3 files changed, 38 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 33a44ec21701..10eb96ed2ecc 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,9 +97,11 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	unsigned long	bitmap;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 207ab422ac5d..5e224e3a17e8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -91,8 +91,22 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
 	data->bitmap =3D 0;
=20
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i++] =3D NULL;
+
 	return 0;
 }
=20
@@ -101,6 +115,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk;
+	int i;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
@@ -133,6 +148,12 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	mptcp_sched_data_init(msk, &data);
 	msk->sched->get_subflow(msk, false, &data);
=20
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (test_bit(i, &data.bitmap) && data.contexts[i]) {
+			data.contexts[i]->scheduled =3D 1;
+			msk->last_snd =3D data.contexts[i]->tcp_sock;
+		}
+	}
 	return 0;
=20
 err:
@@ -149,6 +170,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk;
+	int i;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
@@ -175,6 +197,13 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	mptcp_sched_data_init(msk, &data);
 	msk->sched->get_subflow(msk, true, &data);
=20
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (test_bit(i, &data.bitmap) && data.contexts[i]) {
+			data.contexts[i]->scheduled =3D 1;
+			msk->last_snd =3D data.contexts[i]->tcp_sock;
+		}
+	}
+
 	return 0;
=20
 err:
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 60c8239f95ff..4c7192cb6134 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -231,9 +231,16 @@ extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32=
 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflow_context {
+	__u32	token;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
=20
 struct mptcp_sched_data {
 	unsigned long	bitmap;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
--=20
2.34.1

