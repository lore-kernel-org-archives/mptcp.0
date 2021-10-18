Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FF72
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gXqut0EHpbnuFIpo8SF7jCRzj4lg5tvXPe9/deHn6M=;
	b=C5jJUBXvKU99hqKisRN8V09Jcaa3LPkUg7/MtfBpKeGnat3SSmi+sgFErZN2eSpx34G5Lt
	BClhO3eEn7Rvgj7rYVMR85j2oRvVxDG30PEbGMu+lTO6tjh6JU9BotB+xXgjeEvrnWif0s
	uuR6XUM0Cs+yh7v3yIV1HGw/pP9kCw8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-5xanZE6qOSu2Ce0t5R6Z8Q-1; Mon, 18 Oct 2021 14:33:52 +0200
X-MC-Unique: 5xanZE6qOSu2Ce0t5R6Z8Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4/iFe1QUvmDLntW13gIxIjNYPUz/BxHMjswj9yZRpr0UaMoEEwqxnfbJDkIqVdc3OVSZWknfcQWb31dMK6P/y047UqsEFKL9BQKh18yCOfwUSU8cJn4GxbWsxHAV6u/kPSW3Nwyr617f3uy/MUuaL4wCxEN3nyBk/ZPfDM75u47VdmZX1iGc5J/MEAj89nEieIYACQtJIs6Cq6aiFkh/YenmgmGdictQ3DhR5xz8ZJEY/gmu2pxOkVnyVWqUiL2aZPkHpLo5Wg+XkjgJlJM9+jJyCemg7dXoy8+jXzRdzlesbZWhxV2P1PMT4qzkfjEwYsHHKAkiV4blSN4Y6TjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP33ElWuW+/k3ihfqrfYxc9UNeoBrZoe53MPG/1TGj0=;
 b=a7NsVewQn02ijQ+tOt348YJm00wCmGu986/MKfXZoW+n958W5Bm1E8Jnn1AJlWzfkEJWO5dYdrnhNF+woOcDkXUCi4d8pQiKqF1kVCp5pL8+uIq66CO4QKp8gCJpmS8mYvuHhszXrlgRbVVfNVkPxE5exjrCj7QKZtlosPv7Wdg/LXfcn7D3Moz6QXqFF5ggCCuIm4JHr+PxhqacX8vqElD+0E/WdsB6Ik8tG1YLsBGu1hg0B7/JxX2YzGPIaZNHnRuCKkXiH1/JhDeYg3cUvW34xHkikJG3ds15Rl36aCPNDvPBUqNlqzcd/zX7ylIAaq9XiPPJ8EALpKEtUAigzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2825.eurprd04.prod.outlook.com (2603:10a6:3:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 12:33:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:33:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v7 2/8] mptcp: add the fallback check
Date: Mon, 18 Oct 2021 12:33:09 +0800
Message-ID: <ea1f9dde9e05447e115422e6369edc9aea8e8ec6.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634531093.git.geliang.tang@suse.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.2 via Frontend Transport; Mon, 18 Oct 2021 12:33:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b95206-4196-4219-8198-08d992338a8c
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2825:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB28256FBBE3F196E809ED316FF8BC9@HE1PR0402MB2825.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/XsuZOhQLgtjUlb97EsJb+KtYE0QYzIlN5dRkXNpLWV2b2SpeypS6phGBoh0hKuP8UBgOWYfSY1n9iBpBX98SiE1WTpPEVk7mu6Hz3hGp0kia+cg35PXYSIcCG7lXpcbiCiELk59okB4qAVhvNDlCQi0yDVysRpHTEU3LzRi1bdldHQJ5u78nW3Q9boCcYAHD3YpNp+Q7MrVlY0W5uWvnD9h4FX+rBwhDyxXfNoNBqlezs0kqMRp7N3zaI2AWNj37Yx8oqLrrrZVMLd/bTy3B/Loiz8AnoiUA354UUSTDThgmd7oBXSV8VYPhw3JVjFtB0cJkZAcSehB/Ddu8L7CKvGGQmJo+koRwkaQ/ujOO+DuOHKp/hDVx+kRojWiXzh0nFGat5xuCrFAGsmGmikOK/ELJNCvSzbojgdbAGKmbXcq6258p7tCtvgaM4NjX1WSLC5SG1Va6N/O3tnRm2VllWSjS+DT8NJG27KBxKIwRtfQOoSC0aal7ZtRbfaP6o0JAh7why+T+zgU5rZcwHackoJAk/bDmqoH3umn8rHZ972sgN8dMs6toqEUNdCyz/vjcPDdo42gfaljwGHHUBfNXB/jZXLY0XXcyhXLGXq+7pjrBQlchbaWdnB7lZJRolJumBsx9JmHjTU70YnP8r0mHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(36756003)(2906002)(6496006)(66556008)(38100700002)(8676002)(83380400001)(66476007)(2616005)(54906003)(44832011)(316002)(5660300002)(186003)(6666004)(86362001)(8936002)(6916009)(508600001)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5Jo9m/luyKh8JX37VwVtVmw0uqzy/FSXwr2An6U+Oiuh+6Gh4C1vGEI9NDx?=
 =?us-ascii?Q?/OgUXRUonsFgrHEoS6MsF4GgbCuxMD/IU7/SkVNoB1rAlfvHF/eAF8niru2H?=
 =?us-ascii?Q?MxSqC07yOLrTsBkOs6CQ201BrQ3o9DIubtILXe8/ra7mfALXOTl0QRA89ayr?=
 =?us-ascii?Q?9IAkpCRBziMG9oTVfLOpGPzm/tzt7j+89XeMcJyewRqPoOUhpMUQCtdKzBod?=
 =?us-ascii?Q?X9QeAN85+YwMNNgO05a+MxqrvXUiwzvQrdRPRZw4MrJ0LGhkM6R1RYRPr2dP?=
 =?us-ascii?Q?5CpTe59cvyd8QfH8s4gKiMSWUeO0FjDYO5sOO/D8tcYb8UWxBYA/kqQPyKol?=
 =?us-ascii?Q?jH/XfdV9Xa8vB8Ul2aHbvoGpHo34yvFUkk/OdswxI0mITy1MrN5pdR5kw1qr?=
 =?us-ascii?Q?gVGDidUyK11azA6CqWdBqqtj+CkMDd0vf712+dsiTIVNk47ciXfNTlWDt+S0?=
 =?us-ascii?Q?oP5vZqPeM2PzAEH90h7UGpOqR9Sw7L/p7fmUlYLHryElj7S/EkTRYrbnpfSY?=
 =?us-ascii?Q?qTZoo2AsCEZ73SspwjlLydI/SeDczuSXOriQuQcZsWzlbfPLL0rZsCvVuCRN?=
 =?us-ascii?Q?mCwa9T8ZJdFpTAvd6O9TnE+KmJdggqVFobEtoWyQPTlG9m2o32Xj2X8hkTNB?=
 =?us-ascii?Q?0vaTqheGx6bcNTKBslxq9MhSU4zn0GgIilOsf7MZp9u2M7t9Vhp3t5sPG9PX?=
 =?us-ascii?Q?3pEC6aWdnnWwhdJSzSPcwCBhgetVLw/jy5O7Pdc1A4N0Ppuj7ztHxjSj2upk?=
 =?us-ascii?Q?1ZXsdmyNFh90dyXdOmOt/tF2ksO+bHWX6CMdoVUx12+FXmAiMU92GX/z7ML8?=
 =?us-ascii?Q?AQMqbQErMeJQF3OT5EEJvJEof5yTfiJZY/5kNnue8ZCdtMreFH8sA8klu1dE?=
 =?us-ascii?Q?nJDEBzoiU5ELsp8L7TLdKMgeyvHAkrypXH/EhblAD8wPgij7YKCorWV/oQBy?=
 =?us-ascii?Q?MjA0yDnM+vsFd023s5EUmtOu7UMq0I1hbg8Rk/J8wS2XroTJwiT+Ks0ULOa5?=
 =?us-ascii?Q?9FBlwQ57hdKhY5Q4BcffCZiPVQEfU871k2wGM+JKVw1Gr/vt5nnmoTBwDBt8?=
 =?us-ascii?Q?XKnl1et8GGmMPEiC+6rjWYUQN4SSqcyslloCqINq+ZF95rnP5Tz7eowkrsWP?=
 =?us-ascii?Q?2jJs0YeJEePgX4NBPk75+V9W1hobE7c422BumG3pQTzDrUqB2j0OitVILIv4?=
 =?us-ascii?Q?lHk9CREIJqfoVz3YO3G1BGWSkAAQtG5sx6dgd+ymas9tCNegHsE+L5Yci2sg?=
 =?us-ascii?Q?hU2ZSRpy4i6icfd0/2tS+P5jawb5aeQAYJ7+qU9mN5zNznocHgtyIBrf9xEc?=
 =?us-ascii?Q?vwDO/ncSXrRIE6J+u9OZSDkHN7cptkHBx3JEJ7d0MtjuVQSvjFYO2dXe4vzf?=
 =?us-ascii?Q?uoAq0F5swrarGmktfEGwlvFmGlhC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b95206-4196-4219-8198-08d992338a8c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:33:51.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XReS1x2srHWOBwP8f2f5uym4LWXRYKhgsDckkXSETa/2/S4uzA1siEof8TVOu7x5vELpQNfrqOKnvubRaN4dZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2825

This patch added the fallback check in subflow_check_data_avail(). Only
do the fallback when the msk isn't fallen back yet.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 92b45a7c997e..87a9ffebcc42 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1164,35 +1164,38 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
 	return false;
=20
 fallback:
-	/* RFC 8684 section 3.7. */
-	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+	if (!__mptcp_check_fallback(msk)) {
+		/* RFC 8684 section 3.7. */
+		if (subflow->send_mp_fail) {
+			if (mptcp_has_another_subflow(ssk)) {
+				ssk->sk_err =3D EBADMSG;
+				tcp_set_state(ssk, TCP_CLOSE);
+				subflow->reset_transient =3D 0;
+				subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
+				tcp_send_active_reset(ssk, GFP_ATOMIC);
+				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
+					sk_eat_skb(ssk, skb);
+			}
+			WRITE_ONCE(subflow->data_avail, 0);
+			return true;
+		}
+
+		if (subflow->mp_join || subflow->fully_established) {
+			/* fatal protocol error, close the socket.
+			 * subflow_error_report() will introduce the appropriate barriers
+			 */
 			ssk->sk_err =3D EBADMSG;
 			tcp_set_state(ssk, TCP_CLOSE);
 			subflow->reset_transient =3D 0;
-			subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
+			subflow->reset_reason =3D MPTCP_RST_EMPTCP;
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
-			while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
-				sk_eat_skb(ssk, skb);
+			WRITE_ONCE(subflow->data_avail, 0);
+			return false;
 		}
-		WRITE_ONCE(subflow->data_avail, 0);
-		return true;
-	}
=20
-	if (subflow->mp_join || subflow->fully_established) {
-		/* fatal protocol error, close the socket.
-		 * subflow_error_report() will introduce the appropriate barriers
-		 */
-		ssk->sk_err =3D EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient =3D 0;
-		subflow->reset_reason =3D MPTCP_RST_EMPTCP;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
-		WRITE_ONCE(subflow->data_avail, 0);
-		return false;
+		__mptcp_do_fallback(msk);
 	}
=20
-	__mptcp_do_fallback(msk);
 	skb =3D skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid =3D 1;
 	subflow->map_seq =3D READ_ONCE(msk->ack_seq);
--=20
2.31.1

