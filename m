Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE697E
	for <mptcp@lists.linux.dev>; Sun,  5 Jun 2022 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654435832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ1ra6XhV/M2I116+WKY/KUQgFeJABF3MfgX34w8D/4=;
	b=NA0KIdBTONe5CpAFMov1nIDxf/odJDmmWjvp1VBGSmDHWWBW5u6UYHnnQ74YqjCZCyqRGm
	7k9m+VwU1pkvfgoRar5dqNkV4PnLtJMa1/nhDKuvmeQ+2PbMptCulvT1uU1XFbFMVWFo/N
	Ww1xNSp4KTlcQWb5Lw2JDcOxn6xxVi4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-efPdGbr2P0q4LpPPMRnyTg-2; Sun, 05 Jun 2022 15:30:31 +0200
X-MC-Unique: efPdGbr2P0q4LpPPMRnyTg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEyKtACEnATnOq8r1FL9+Yj14nuFXLWFqS+EQFVBZQ2E+g6dhGNIk71ZBjMCMGg5VwMhKRcvhukXAGn+zN9JHqTSPPuvAd2r2LRwlhnof+5P0eMpvMlRP9eBHlBMc/jYYW1rH19mAaSo6E9eB4fbsn9BGmnHyy7P2jDgoIfhfnY7QNKrQSC3EAlaZPNslQPRMHqiNoVmv2OVIS136rUE9SsJf50H+kAKPhRngWGSr72T0G1N/qva1SC1cl51QNwSUzJ7xEPhFCOPJ5mgYA6Qr/e0HkMxZE08QVqeRt/GKLdT2B7YzfdvBHCyPtXDDcJYFde8ODgN4Xc+a99yHCogLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtAD0+YgFA6dgvNyoZQmE3xddbY5NNPSF36PAulImug=;
 b=VRKfir+2/23LMsEURY0V+f8BAs6eBeBr4dday7b2pwQFvKdXxBQLfkZ10ylvQT1MlQeadVjXku3BAdkmRhIPXTESs3CdEnBDfKilo8XaGAeuPPiokwfiGwXtQ7rq/hZ5pmb5g1fSB3n+xouW8hCeKMzW+GZCVEIOvQIYnWopFrMFrDSgT3DTb4gXGm69kXgVPcxlOhMZ1cQrSc5BuB8Op6KgVWzlFkmfD1QDjlgX99ufCNMX3FS+Rr8MfRpr3ItIFExtS6AqHsQ8esUPubmCQ7jR5VDBrvmnynMQBUgNJMS0mjwvRZ+pQWq2ps1VMwsYiSahAfW2J0VzqdTaBBw8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5028.eurprd04.prod.outlook.com (2603:10a6:208:cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 13:30:30 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 13:30:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/5] mptcp: add mptcp_sched_get_send wrapper
Date: Sun,  5 Jun 2022 21:29:38 +0800
Message-ID: <a7745fc411da243d51e719370f45cb4860009123.1654435294.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654435294.git.geliang.tang@suse.com>
References: <cover.1654435294.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff921eeb-7e08-40f3-bb2f-08da46f78f2c
X-MS-TrafficTypeDiagnostic: AM0PR04MB5028:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB50283E95198FDB42B3F018D0F8A39@AM0PR04MB5028.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gUE4dxQ0Fk2IljL+1DbSo5z9V6mCDNTeGSSJe2GIscfdVnUqpawWIac3O9e+mI7Q1LE44pCYeeavgGEF0Qb5Gs1IfM3dOfkSP0SU6UtXXSizRxk6BAiT35lTYMayBb1jXIWL7IG+9o/uwpYIIiytZYeMpb9M7GBNvinQZzHTtNQn/V1l+HzmiDLd+lqrM/sNKyxO2fu74Fs6CaW4fRxhO2Rxdx1ww8eHUqMm8j+k2pLcpRp3QWLj9RZe4yQ5GptPm0ZofRXRVBVcqpwMIPLXSTko9Gh51VYxkjcvsHX11YpXoifOGGIYSz+TwG7wIsOY6HnOieyUj+lBAczUFQd8uuyKRLMwjp6g3OBxJYSOtelGjTcucO9yUBOlqdLbUI7UUphcoOU8w0IQG8SASsbbNwoBX7l7riDeIO2hB+XpU3JM7GHCdEYACtw7CfAMLtfCeNnh8bex5wiJW20pnin47AXnmK6a5A7PQNO0Ycot3sdCf5puWUbBURcFnvdpzcD5JA6UnrIlJGXPCqSY63QADp5V5ZNYffnNJPSFSQB1YQuRTUcZ2+2rXLhhnJ+V6tObsyOiPs9NvuSttWcG/QV5GUJp43mv0gvBPCaqLM+ynCbbAdfuOImdr7ohc4S1veegyeWnNO8FOE31kWEc2eyMzwpUBzoa7ajZZwFtbp0QiamXuH5D7XmslkVf+o1rPTqQYlulimFgcFkcHmRWpsO91Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66476007)(66556008)(66946007)(38100700002)(107886003)(8676002)(186003)(6486002)(86362001)(6916009)(26005)(6512007)(508600001)(5660300002)(44832011)(36756003)(316002)(6506007)(2616005)(4326008)(2906002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vVRGg80KTYMg1wMl8vaY/VNCeeL3awV8h3EFsu8wsfbmfoniRLev+9WYdASY?=
 =?us-ascii?Q?ZEowI4jEUxtR1Y/A0T43K/mxEh/jistEB47LJAuuZnC0ORtZiSmGG2zlP6R5?=
 =?us-ascii?Q?nQF9KPuZAiTXnbbk9ngsXRSQOsQpyMUqQ/r8OYYvxw1bEeLKkV+WXoJ7bIKs?=
 =?us-ascii?Q?8soOYYlxSpSG9MhGh2RdXVE4yti8Bq9msuSZ+U/SGJu949Iy0akSdgJmXuf2?=
 =?us-ascii?Q?1cGsia2IlyhB8Gx/jZ19g0M6ZuwIT5WbI1e8/zCK/Cbyqui6ypgeD+cFr4tB?=
 =?us-ascii?Q?NLzJ0R/rcSgCLULpzDXDqzJ99v+6IfJIID566PZqOhHuVyotCyxHgvXJwa/L?=
 =?us-ascii?Q?xY2lXdCvoyyAnRYJJije6Sl8FX5TGMyzrTU2/EnbRO7l847gT3QgSo2XUFXu?=
 =?us-ascii?Q?cF4TjAMju9E5Ujv7/JRno4nHr41qWVWep+hM05WQqoVTVVgCooODWYDgErO0?=
 =?us-ascii?Q?P/dpr+9MidabBr2TbBb1STfnsXlIA3xyrohHdyYQaEnRHcsnJ0vado4IrQAg?=
 =?us-ascii?Q?sxO0+xJSbh1CD7XLI3V5moZA9Xd9HmM7hz4fLk417sDWTiPIPWjEDtid7Q2I?=
 =?us-ascii?Q?EAKd3gXewRJT8Dflm3D/17UN3INSq7lkiI7hjvN5xwcxn50EQOhvXoPXlCRv?=
 =?us-ascii?Q?Rk+E5rfFOA9X0yr3ILxPEmGHlX4FKpyjYgduSWpNNX+95eS0C/fT+lVrjOQY?=
 =?us-ascii?Q?lBI1TjKE7aG2InGAqqHA17vGOi5+2ogBqU0gddkbW8An2kZeES71O93oFh2U?=
 =?us-ascii?Q?CMBfmIi4oIk6n74abaXkaboqzr9iwQ1LVFf2U4gcp05FEqrCeGBgmFsUKghn?=
 =?us-ascii?Q?i5tVy22lHi3cPRPwZH9IUfqdI30fu+i6GfZRSAPL5wwSaLA2dPDwdQCLie3R?=
 =?us-ascii?Q?9h0tFmzOcFFzH7OR2QlziZk8SN4eocTeabKFQ2VJho9FPfwigLykuu5e7jTd?=
 =?us-ascii?Q?1tnRjviQHhTDFccGF6b+jDjOwE9LHijegYcBCRn8EGOmShJcwtr0XEhrYdB+?=
 =?us-ascii?Q?kjbw6cjRPZy0idocXAwYV+VXEMFRO7hx0kThSn0p2l4Qsvbpxi/Tl2wFoco7?=
 =?us-ascii?Q?5RQRVIhX4ajEBGihwQIiS4UfDZVXu4UbkhLkQ3Og6zqiMNs0XUHpbKr+elb/?=
 =?us-ascii?Q?X+cgct/bi8WsXq12ukgl47VZ1vsAOtxPrUNLzUyCBRxiStRSzvAOnBhmvYGs?=
 =?us-ascii?Q?bmXELwKtg/30+V42LNRoWN1eMXBBJlnyjvjaCH+4bYXL27jn/K23XUThrE7t?=
 =?us-ascii?Q?0moEqZYw8XKTbM5wPjNjjxhhC8SVYv+r8zIhOo1RoIsrvrA3MDHtQw1HeZ8u?=
 =?us-ascii?Q?Ujbbur9PCudrwiNAdjKed75vsuZtHWpKda1t+Wek6Us2iBQpRvXVh96XEQUc?=
 =?us-ascii?Q?+tuFAoLBVg23X+PMqWeSG6vQw5A0C07F3PfqGXlgLztf+sY/OPaL/Aq207wD?=
 =?us-ascii?Q?xDMOBhv219mR1Iua4JBeQzxF3sVlU2vclDBLF/mfVVoIHiR26EhoT+3C36HS?=
 =?us-ascii?Q?LpAmabWl8DcUTYLqXv1j4cXDGwLgKx9xeyb2AhQmTPMczQxvay+AmEZhp5tr?=
 =?us-ascii?Q?MqxAV2iYdJUWHjU7+6q6jP2Hlq8cRnRWK61zMPfTdHz3HrfyXNs4AkBa18Q3?=
 =?us-ascii?Q?f4S8Wsfy5XjN42YhUmwriUAYxkJJVj6x1Ph36CqSRaCWUhqNaeTxQ5v3di8b?=
 =?us-ascii?Q?+FuQ1/yEmnbidG9vVylT7ElOgcRw+Azntt+VOXFqMPkLLmMxcCT4PY6mFDBx?=
 =?us-ascii?Q?+aYUyNZEvLzqhGF5yJhpKpdMiiY4ruU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff921eeb-7e08-40f3-bb2f-08da46f78f2c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 13:30:30.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGUe/5QsrfcHddhSl1qEiD7QWX6t+U+c40yDgN8QTvBa5gwg+9/IapCJqk5BiU8UOFgdcU+dtZgSjX0mU2r1TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028

This patch defines the wrapper mptcp_sched_get_send(), invoke
__mptcp_sched_get_send() in it. Use this wrapper instead of using
mptcp_subflow_get_retrans() directly in __mptcp_subflow_push_pending().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3ae237f89bfa..c15635341b9c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1637,7 +1637,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3128,7 +3128,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
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
index 4669d34f4d7c..6d9e8ec5c96f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -634,6 +634,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_c=
ontext *subflow,
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int __mptcp_sched_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
 int __mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 70ab43c59989..273a3b65d1b5 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -147,6 +147,26 @@ int __mptcp_sched_get_send(struct mptcp_sock *msk)
 	return 0;
 }
=20
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D NULL;
+	int err;
+
+	err =3D __mptcp_sched_get_send(msk);
+	if (err)
+		return NULL;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+
+	return ssk;
+}
+
 int __mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
--=20
2.34.1

