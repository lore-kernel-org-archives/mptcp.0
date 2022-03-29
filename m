Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200B20FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4roFYMj3xBnR8JvEubsVAWd25yKE4LrEKPIR59igJiI=;
	b=Ggy6d/fRfJK1k6kcbROVkTCWAH15i71doKKLnqTvdo1QsR0fCrJQxEYttVyyL2wFE5/HxG
	obxqgvtvahNh38JgrE3tyYhNqewQv4M+xyVsbOtAiDFE2f0vS001GB63SISK8s4E8E4jhB
	X5xwgYOXxnxBtj7PqKXIwTpM5Gyh6uo=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-OVqg7OEBOuO2w9QZVchr3A-1; Tue, 29 Mar 2022 09:10:04 +0200
X-MC-Unique: OVqg7OEBOuO2w9QZVchr3A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfQSyABjXPvgV2IzNxL4ORgq0Ai6VbpWsjYePP/5w7NJvioxthTb0A4sIvlOFfsgRUW4mZajKc9ZA0vabsv+hgzwHoseWEfIvYii2IOyO0i4sPM5VzHSKlekKcu9TfkN+G8GTewf2wE+q9Rn2knStpXZiyEjTR9Hjt3zpOgbi3OJu37RSXI7XyimkFmjZUrEtoYkgVfrczhIvCjSaihBuKo4qyyRxo5BBTLrZqTaBuu1C6dinoemAr5Ms0Xt/VWptXxGzYtjxYq44DtMqOqJFfiE6EgrSy4MegB1kFG68UVseMOSyR8M53ZzoQ+izgAOvkTbsxBUKqFsqWqzEPfKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeqWi/4+3cM7I0HdZPm7gIUU9/c/ZenRWeY1oDrKoro=;
 b=BNVAg+/gVZl/3cqfrVAg2PjHHTkXLMQ3xEqdQwZXoKdVnb6cLJ2BQStiWYTcPbpdAiehjzlr1djqQ6h6b3cR8z3oU/YOq4FMTIMo+GOnxMeypSsrGsbXUViJwFmHKiAfFJZohoBNGL0Y1o5l07m6akL1Cnfy+uPe560Q842QDR9WlQ5YoCguygHo15LeluZQCdkv2Gu9vuzxsjMhZJpIbJmPrdeowGwWX9QcYDkbNFBVxaSG8Nddjyxx8+37E7RQwm5T/GeUKjL0Xf7zhY79mci1rBPnzqsDDXMfv2K+622Af24N6PN+ixO2WsrjTgB7hHPcEfXSuNPu6N84vrz/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6735.eurprd04.prod.outlook.com (2603:10a6:803:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 07:10:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:10:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 5/8] mptcp: add get_subflow wrapper
Date: Tue, 29 Mar 2022 15:09:24 +0800
Message-ID: <a17754ee4d551379e0832635ca172a47868a74aa.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e89160d8-2c9d-4ca8-3afb-08da11532520
X-MS-TrafficTypeDiagnostic: VE1PR04MB6735:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB673558FCB3C78AC77AC870DFF81E9@VE1PR04MB6735.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SUkPOLCtFLJH5P0hjEETHzhtsCnBATLabHNIltBDU3ViQLDHOHG2K/uYQ0nf5+aq0EbLR2knirAdjN953UJZpkmq9RZtOjEmsK6S5sA77yCAqpWMDjBaqXx9BtTA7cw69XjsHpMoCSD1unKkZL9wmE8k9Rrt+NGHeyW1q0flj0/iFUVJc93rnfHLFwv6ww46VkUVk8UMSdz8Ufx6+XlneN9IUGfI1J5mh6cHSkG3OO2ClqIk29C3Rc3wC/+xCCa4cJe7qqbiabkEshBnnIUvt3mk/FZP6SBsaacsa5IS1lzTeMsNEac9f4YTrVvZUyJfzm4Smepzkd5HHO64sRsqVCUAt8stnGIEl5PpotEYs+3eqya5cDRg3k8U6aV+G0QVPfEhNhuQhUfF2D4j+Y6q2vJ5d9ks1xpyveD1ifDbIecUMVVxtsqU4/JLcw8ZbHeQY89MPvszdUqTVsUzsR5tyBNqq+KJy1PBdU2WOLmXqjUQuVv6J9BrBICPKKOrio0JfhEoHmqJGEFSZW1KBBUqmdlF0u+QomkyRph/5ZpeL+UVNIl+7g77DRKBm8GAgHWk5fQTZUmXSh0lG1ihshSURAuWCxXVx6+6znuBW/6vQZVXNZlbnd7Htx6f6FZFtE87dADkbr8RQi/indymkUjZHkHL18/dqAy3MOB5iERi32aNvc3ux+mnv8Iuq22p2GmvpZTo0TBLgmHC5nryDeUKgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6916009)(86362001)(8936002)(8676002)(4326008)(36756003)(2906002)(6486002)(508600001)(316002)(2616005)(66556008)(6512007)(66946007)(66476007)(44832011)(107886003)(26005)(5660300002)(83380400001)(186003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nWfC3yIBMUXeSXNXMkX2e85redAUBsvIKJjnlZK14DwZ7O4iHP604UkWyDj6?=
 =?us-ascii?Q?ZcsAxIDkNCQkgmFse0RMKDzCjp5y/IeLmmNWxlLV0tGfsitsW6VQphI4M/en?=
 =?us-ascii?Q?xF/1aTlPwgl7bWVNvejxmZu4KOLlSdnI49x1zXi5DiQ1+l+A8JwPCpm0vHnf?=
 =?us-ascii?Q?enG7u+KqVo9sKPrYDRC2PHsxo0nQnfVOSMShNxkEOkTeLt6BIj/Wz2zO5woQ?=
 =?us-ascii?Q?c+JsOdbp1ESCnqgLCZQ4JS/qkrB6gdo1ZwrQLLAl/TvKnw139Y5P8u7Ucafp?=
 =?us-ascii?Q?y7T4Cxi55dDAfYTEpNtqjhmb9mfYbnt30CjUd5zHqbcdy2UFvr1JXQ7XiJWr?=
 =?us-ascii?Q?J7KcsMlOM/fGBm3SfGm2j3DA1p0WDAwG+g3d6J9S3hsf1LUuyUdNwPAVXqc8?=
 =?us-ascii?Q?nKZyyW+Tw6Yca8ON3neHBXVfLbspxCJElb4RrYklZsuZbI3U5Iv1l9awTnD1?=
 =?us-ascii?Q?h0UMtQH6S7EDxL0OQ9GCZeKztObFRtFp1lyGLiL+WZOqCPSDQmQNGD3P+4f9?=
 =?us-ascii?Q?rNlV6n1BvtQqWOk265/aIcku5zGha2y6qic2AuPNQj/ANh56zGeh/rwGW3Gy?=
 =?us-ascii?Q?JIXpWM2rQ3+G8Fa5ZWdn2hkivVzTW7dXcxELuGh8iCUkPUQ3aRUvHH2AdCRH?=
 =?us-ascii?Q?2QsjaTRMDQRGGIVtKw2P9swUa/ni5F9/HSsenX14tAGdTSQDQUWdU6b6FFVm?=
 =?us-ascii?Q?XIge3gCa72/A9KTiA6mYNhRtG2IOu8PTC48IxVgCw674+rjuJk+M25v+dd85?=
 =?us-ascii?Q?A6m6FzfkOzpptHL3KjdGZocx3UzUQWZpR2YaS3LDyiregNspf7dfGOZX6V42?=
 =?us-ascii?Q?f0ms4A03lmAHMb1n0FoFxpulhD8nxbs52d5hUAxqdaEgBnEgjCRw4Gg87RpP?=
 =?us-ascii?Q?X5pLSiwUceXUFOh6YxNBzU1uj9/ir6/MgrgxMIEKV2LYTt7uhgUeZHXFBRTk?=
 =?us-ascii?Q?cvv5rCsjU0dZptaTKKn630XJl5dYkVtDK61a9J2FLy496vh6JPG2AIzTKLEk?=
 =?us-ascii?Q?hwiVCEiejzP08hQ7poGhmcFyt19JNfT4MUF4PV3uF1d0Do0yPOtPhel2vHlX?=
 =?us-ascii?Q?Cc7p30FyfI9fEfJSbkxloSkarOVwRrZPSHXZZ1RY83+7TqEFftMsYuwZe9iD?=
 =?us-ascii?Q?rS1qhy83SUWAy+Sepgxqvv2boldhnnjIjoM0zyBMHwqeId+4whdWqL/88fp4?=
 =?us-ascii?Q?C/MR7XdZXoXVcIru/LYSzX1+7DDIJ1zOSacADjEkJ5uU+hqLG5SgwdK1z/WH?=
 =?us-ascii?Q?arZHN36EB6aiH79DZzdaMMmBSbjSRkx/lsNwnhrl007r8630/yYyZs2CQe5T?=
 =?us-ascii?Q?idBDaFD94IlNiuxrzGl7UpQ6EH5SRJBOpgM9+UlJZcJKZ3tqh9c8lSw1dTXB?=
 =?us-ascii?Q?IJWxEvrthYnMursN5epi5ztZIC6lwXvAgBLuHEBhfcGwsXSKKLI3YmfVdhsH?=
 =?us-ascii?Q?UFqXVXHB3j92O4dTBPKSOXzMS+3wj/ARbV6GdSc2KRv/ZtDUG0tShDDb1CPn?=
 =?us-ascii?Q?beaAtydFH5HqVum2NyjnjqgtcAvq/HEXjOPShVgisWaHy0I9J+JVtrvkFdNv?=
 =?us-ascii?Q?KDFxGk3dfOx9VKUq33TOsOCuI8M4Z1iazqm9O71hIKG5Gr1YAh/CpxOXp1nh?=
 =?us-ascii?Q?hnHKzxWILpuklF/K0xihwBaRVSciQwIvFQOhgvTYosxOnWQoComeYYRAWpGC?=
 =?us-ascii?Q?vaIpj26hW3EyUSv/7cNEqushv1lOLlmor8QNVYjWA3DHd9kldO5DjCX6441S?=
 =?us-ascii?Q?6grvYKhQD2bihQh8OaF/d5i6YE1Usss=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89160d8-2c9d-4ca8-3afb-08da11532520
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:10:03.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ7YjoLXPyb57Tu9gcj1Nz0wFtsNXawMZjsCIxrFIDyIxPQQNSuIUtdHUjaghU5aJyMSXdnIzUrxUttkVXX1kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6735

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e65b4dfcb758..ac00647d94cc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3137,7 +3137,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 74d2b05f5d6b..a60aa588b1a7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -619,6 +619,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

