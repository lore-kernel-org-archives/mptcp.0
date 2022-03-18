Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113415AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0AnpNvzVQuBzoxCisyo1XtQTgibC09rFuTkmx26SOM=;
	b=gVRtDC8cEZqWFAi9Xz4N4RiFpm2hV7qrgVyaop4dbyLPbXK/y2nT0t2WcuOisYibZVHk8j
	LSdt1+rHAyeSHhA0CvMsvIZOmLLVMFnEgECerbImybZa5h571MGG0nVD7oYo5eFLv182qS
	0hqH5hE8UV/xBfg+S1rThAvZQznB8J8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-xUfQ27HsOQaYrK3t5V_17Q-1; Fri, 18 Mar 2022 03:58:31 +0100
X-MC-Unique: xUfQ27HsOQaYrK3t5V_17Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm1kJtG9uf1s8ZRhiKUiaKNRd1rRftIfshc/Li7B4AHlo4aZWvinma6rycf7PzZYu3uSswYRwq7igaebFKflOTRNkunisZ+222cc0OD7nHExZtF+2tujIiaCLhRFhaep85qqvmFAkGvmE1LuryruVQzvPKXI5VwdPzsj8PwdXWloVdhvJHdYb6Xov2k8Eyd4RNMiPxxvsKSVPobxEAWJ76tg0rhAV4JjTPACIyDVFkMoJe9cWoDaBcGidK8JVdNyTc4iEj8e8M0qIlpOkYsvwq5/gQAanDnHF2r4dsj7Mz9iMAn9udkhWADwRfcuWxNpM9hQgvF4pxGDZNcniuKGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppFVMKXoqmOSxovAXMb1wNoWaGNH44gYIBRy3WapThc=;
 b=OMD5ygOydrqJS1Kud8CDYNZ2qu3Ud5gmQwaThLjAzSWncMfZZF72GRVjqo/rBrvLGGDs8KVWBFF/TLteMAJmzJOX3tCnGSUaAvMjY/9ZvIZdD2VPODD09esY9GFQ2Uxkwug1+ENk1VhW74YCaq+ykHXmC4Csas8ML5SpFZvbtQg/g1Dji+TtuCJbCVznxK3qLf2gJ1oUALeBsQ8U/iR0AMmdJsH++thIyF4+sh5OT6ORQOJaQOf+UMpB3twS0EpFEvRy9LzGZmCRWFepiXQzsGAGKJI5sfliQZEWzw8j5sBgN94srwL+AGlvEV8jCpgBEcppxFTrg9vwKPH/8tvpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:58:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:58:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/8] mptcp: register default scheduler
Date: Fri, 18 Mar 2022 10:58:04 +0800
Message-ID: <70ff4322bee0aa3da2133b1bfe2c907d835051a2.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647571510.git.geliang.tang@suse.com>
References: <cover.1647571510.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e1d096f-5993-42d0-80c7-08da088b2e8f
X-MS-TrafficTypeDiagnostic: AM9PR04MB8321:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB83217EF0D7408DEEAC9A09A7F8139@AM9PR04MB8321.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sw158Iy2FLgLkfO1meqHo2BXiWKwNVBAdKy9Ij8iQwq/asPf2UtQJ1tGN547TXzNlOCPccCnjOjsJjXrYCEbXIIujHlzK2KTBYc39JPH264HPDIkLi3VQeaW+V6iYQ6h2ZBsQbGgJA0nb9rBAOnZlhVUvBhlML1jlrO7D+4mbvtIHjiAojVb73CKa1dtAJC+LlpFQYIcUI1mY7xO92i5zEdry6yc11uj1wLYS1LesJE+PKBDcrTNvfoebENAgM54UR8xcqT7k0cfJjCrEtOTCAr+8WLdtfkx1bWSPZLKVa8356PisD5RBjlCe/3RTJpd3T9uCakHl/yceeuLQxpESltx8W2uBU4WsRRBeag8LECfloJaP3qeMhf9sSnRSDEL0u3xAf5ohChSWSjiQReoIJd+0jw4la35uNHp89pJi//9aKfTgZlP7AbKTa2X8MDm7PE5F8pbHgTO9WL3xeb114N/1fVcVLaYhZ34VX8zEq4ickREhlM3/lIptBCFSvMTz6xWJeeM+N8DyFlw+gacYzorX0i0I7Y6Q3JkBIQZZt+4EigyzfXWDKwOeu+Dr4YlhddjHMi4PbCoVzZY8odwrIWdxFzbsh8b9d4/DElPiyhbQ9uMdUFf6lysO4AUIpilBV+Km0rRhsJUWKJA8xxkFTJd0AlN1UIdvA5orlvn0BBfov2Z0vb0h6zMdh5IqEaB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(86362001)(44832011)(6666004)(5660300002)(6512007)(6916009)(36756003)(316002)(2906002)(6506007)(66946007)(6486002)(4326008)(508600001)(8676002)(8936002)(66556008)(66476007)(186003)(26005)(2616005)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qc+4erTUj77QLtDQ5PqWrgdzNMZAcYC6EAuH3F83ZFJ7CfjEThE/KGqtfN6c?=
 =?us-ascii?Q?T51J0ulwdRfe53UT2rqrlV9AJMEvudzf2bJyrRNz8d0lqQfc5QHNy8iQbZAx?=
 =?us-ascii?Q?Px7c3FQCzpcK6YKIeiAqJa8diySklLj4rZzpXNwSgdMpDHp6tMv/kiVpSLuD?=
 =?us-ascii?Q?wt4EJXXHTQZ21EmTfN34MAlSxjlmjguUmTiVansFOpEX04q8tSVGInrBGybj?=
 =?us-ascii?Q?8LDtLIKMVjLPWcu2H77qKSkE3PAkMV9ozteO7C9VtpXOTWYDF9GyNwA5X0PT?=
 =?us-ascii?Q?GERTH4y0uDdLv5QYQOOkMNiAgEV+VBlX27ecNwAo6pHcrKs8mjzRX/9ywjEi?=
 =?us-ascii?Q?JwDJyOQsRznQ+InKRfRHyjR9YUqfxTAF7UBRXlZ8FmvAqax4TTW+DWE94mNO?=
 =?us-ascii?Q?wYY1+jY7U5pN1t5F8KOBUOazo+c7KlZoSORzFDdabxdAMyV8TZT0jNp5Ebb1?=
 =?us-ascii?Q?bbS8PJObps+eB5gKDflzG17OLNjOVzn0iwWk/PkkkEH5n1+kSqm63g37rYYO?=
 =?us-ascii?Q?FVbWBAROkhmHyo5BeYvYVLrxoBJ4tOC5jU9X4MT0k4pgNCmak+K0uOilVLFz?=
 =?us-ascii?Q?3uATcy8b06Ko38JOBWLMmLvdOkeJtIWKWWA5gJL0F8AO7iOal8wW463AU533?=
 =?us-ascii?Q?jcHd9lLWOhry7wt0OgTLTC/zeSkxMnoGqitI3Y4AaR9vIfb9ATMcLDzgpTHi?=
 =?us-ascii?Q?SX3nj3lNBy/+itzSF97fXwGg76j1C1Y4Knf4Hhog8b+6am5//keU1vo7r7QQ?=
 =?us-ascii?Q?ON1Xjy0PJDaXiLRgPLL0upcDp4IkhjGpw0T+vXgGvEGOX/5JgalAIPjQ7bji?=
 =?us-ascii?Q?eKCp3kpHaPug6TsJ4Fwjd9Wyy9TYrNqqGqXfYyen/jF91DO7PecZvjaH0lpd?=
 =?us-ascii?Q?eSEQRWip49VH+02hTeNhSqFa+AYEAXmNz3zBwUmfdhKkKwuUvtByKFvR+qhj?=
 =?us-ascii?Q?YSRoBQkywW8kPL37NkNHE7+OnCvnNZRZvtXtwnf2NsZK1XzJb/oL8H+fh/E8?=
 =?us-ascii?Q?aoq/nhHys+S0Zldxkus1QuTdmrZ8jU/RSeGa0boWPRjMlGZCALx6M6y4O6Xa?=
 =?us-ascii?Q?ccAhSqzymzqHYoccXdRvj8Y0fge0z0KMnz3UPqVngrusNC/fotR7hVbQmiiy?=
 =?us-ascii?Q?MKc8Dwpq/VkZNg4Q/w/v4w07oBJxfGnSFK4OP9POuZVxYb3mUe270W9FsECy?=
 =?us-ascii?Q?XdJbCGnYqt2R21jlFr6slp+7s+1qsAXk3AGqgHmYyCzoQ53hiyF4QJYMiNTA?=
 =?us-ascii?Q?jINY5lqHqOW9RAxLDGhF7o+PMg5ErehfxqKtcgoxbb1FSV2VyCnowe74QksD?=
 =?us-ascii?Q?3AkCCSSEtNlXFK1smH/EmujnCfDSijh7IoFh1Jwsd1Eh89viEUevYdOQK4yJ?=
 =?us-ascii?Q?wKz3AGjwoUijEMGQoGT3Nxneq7oOax32scCL3innyg+dYqQ7Pt6S86zRZ/ro?=
 =?us-ascii?Q?AmJWm29nmK/hqDD5Ir5m31USwTbgvaeXY2SiOY2mr68N7aRC4bsurg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1d096f-5993-42d0-80c7-08da088b2e8f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:58:30.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhKUmuWyTzG4r8TUI9TS+OkbfmQ61QqBYdycfa+nNQrIBbrsEDgskU6IZ/zVnEdbz8CBFU5/QdC2/ixlll0tmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

This patch defined the default packet scheduler mptcp_sched_default,
registered it in mptcp_sched_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 11 +++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbb14dfe62b3..11e19ac9d5af 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -3743,6 +3743,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 500dc7b3fde8..c186d199cf5b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -608,6 +608,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 88ddc4aba4ea..9612e182b7b7 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -54,3 +54,14 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *=
sched)
=20
 	synchronize_rcu();
 }
+
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

