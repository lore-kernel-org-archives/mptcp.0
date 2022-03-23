Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EEA1391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qhtkeQHiTIWLK3A99Zdb05IDzmabPFz0TGw7n6BWZ4=;
	b=nKE4jiogeI3cSBm7ze6dzpde8pOfTVGbiOgGSNMVkwHdf3U4911vr6vHbBs7KnvBoSM8/c
	A8dSIYh9ZkrUY0ouE317ELmYw8XDDRk4Q80x/0SORWUyG6Q6yRt+pwglaiZ6CVGCeB8gxE
	VXWiWC5YaBcBKkJiiuzl0jUauC8oZUA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-eWPezd0zPX2Bp0EiJQnthA-1; Wed, 23 Mar 2022 10:29:21 +0100
X-MC-Unique: eWPezd0zPX2Bp0EiJQnthA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpVAHte+LOSqXrzE5jJ+ZzxAU2JR+pX6Li8JlmBfLl2SxnFqnVT6twIM9OyLIWIlpKqt/4ic4f6jnp/1lv9y9EC0y17/MXgiEl5TRvoabFU9+c0Lx0IPm6B38UbCVYN2+y0Ns4j0hTDASpNGj70tIBL1nt5BbojJZIAsrOnvOMRY0sJutvCz38dxDOIdQCdyQWlcRzbb2upqelCjN+ltOYI5mBslp2TnB7a++2AB5QzJR8BGKxgzbO44um+W06nHdNksa16hsNlpw9hvJsxeTjGbWQLrHvodIC4NPWEhCxVJ/MM8f1/JCmiaEFM3DuGpZT2THYwSc43FmeV8qVk7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9kk9JzUBUFjEG9kHXdIwl43h3QiA4lCl8AW726vR2U=;
 b=lO+sCcEBMYyLaaMW9BCh7hBhqo+YOAcHP6nUPxGKlj/762RWTP0tzuFpsQVfsw1qz/1QtUIj9WqGP6dKKCRqfW6jHCk5qcIaexjQXXFjei80cY4Md0bwNkTmJ1xRgqDarGQG0yk3uOkAwug7IPPvSnzzaDF/g/fkJI9/sBG8azPKH891+znrJhMNE8fTdGecgyNu/vlpEefcC8l5exrEcUXE6fREXuPqf8q8z1KNAU85FuzJG/MaU1uZcjbqvEdCFJM7j9B8QauV8Z/ZJixyQBbt43LxgCh8zpRid9yodjkKSilGTj00F2LbbvwQ6JgBzfasbrKeZHQArquaGPLU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/8] mptcp: register default scheduler
Date: Wed, 23 Mar 2022 17:29:01 +0800
Message-ID: <e668ed94cbae7641a33358407c192dbc0af625ca.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648026806.git.geliang.tang@suse.com>
References: <cover.1648026806.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66dcb6e0-1342-4e1b-0301-08da0caf9c22
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3359:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB33598518C73BD04D6DDC59F5F8189@VI1PR0402MB3359.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H8zVJ07p1mPf58xDW1EEfgDbtGtJHa6meXNsdmZ1ZEqxeZOvyIpYtaSOt14kGFjKHX4IJd6SZIcUIxzCrirPwJxwcQ4J3auKepWnXKJEFKKF9b8vvoP1gFJx8dErI9LXwrpo/HViEJaWNM5HJBnV2f/HysTEvM8vDzMVV/FmbmNDpz3ZW3RDZN6363J3ZrE3C+9w2hRO7N56ejxrzGRHXj1eOc4cAmoPSGigm5d6ndBDNJjb/D+6/5wWRjhre+rymgIWy90QOnvodXQgYMlYpgbVKhYWxNKlNe5ki7K0HbsW3eCxYRtYhfmOa5OobuUuqvbDv/gVtgVSwLgFK9RJ20ydW4kBNNWIklBcUfM5wzfwXJ/o/0Gr9UypkDIO+sNrMxIQ5V3loq4cjPZiTSpAq2ROirkDok6YmHPhqeLdYM8I5L8XvDYKbZedVHnT8lZlBbx9+chBam0K5hIFOL2aZ6qwimqt/uFijsrWoLDzxtIKsDpdihQGEXlGVgeLC4ThkKnvfr+xUGatmRxCjF+bZGg6eqdQYFr/5lV3tHZsdoE42X/N3mI4a9unWZXxpDZ55x2fF2NWkB67IrjDek9XrG2r1E8ADL3CJA4UPe5D/lw4YpWqUVy8t0ENfjuIuIM//9VCsbau6/tqnNXYrgFcrK72/9hcmR9NZGqMzk/W7NO0lSvIs2kGC9QuERdN5hk+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(508600001)(6506007)(5660300002)(2906002)(38100700002)(2616005)(44832011)(8676002)(4326008)(6486002)(66476007)(36756003)(107886003)(8936002)(316002)(83380400001)(186003)(86362001)(26005)(6916009)(6512007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wYVX/jhHRnUdzWS9ikJXic11E0cZV9nIuT1lYo336E01S9sILHuj53sgyjsG?=
 =?us-ascii?Q?dpn/zH11cYtqZZnYminlbdrXFqQNLidGNg4FAoK/kVeq6gf6X4vH4sOqdSS1?=
 =?us-ascii?Q?k2JJDbRvamVLjUw1WQ61Z46cYAkmjQazRf24eqcluFEnb49qwqg8f7hQ61ez?=
 =?us-ascii?Q?y6pZP8M02sHp3XbADxwlEDIDB+1lar2WN/GcUa9jcKQaTIiC7niKgUqkhXiU?=
 =?us-ascii?Q?tE3bVbyQTxzPNl55RSTT9SS3/LNBiUBAOk1o+vv5BEHnqUPVv6eCsl7AnN10?=
 =?us-ascii?Q?64Hf/VhGziyrw7WLLYmpq7xKzjbYs13epWXjI8dc3Cri9WAWwLClzTQRdGyo?=
 =?us-ascii?Q?wXBez1q2m/h7hR09hadz5BK42uIxzhAbPArdHSmZdc2vUF09A9l1dSXOb9Kx?=
 =?us-ascii?Q?/hB1/F4Xr5RFOYTWuQ9kCYfIS5uzObVO2JYceXFIYjP7jx0AmmFwqYCwkJmS?=
 =?us-ascii?Q?n3mxnkr30jCXtV5Q49YR6waLO69Unu8BU0tk2bmJfqOaFmFqaxZ1YuiUhQ3L?=
 =?us-ascii?Q?6BuodXX1WoQf8KVJEMUA0lvoTENK/yanlwQNPaWBSRdibUEvIyXraigdQtgf?=
 =?us-ascii?Q?+AsLEgFgzr2nhEBY9jzIUXyHN4t32lnIIC7k4Hw/2tf79tvKkLnEXpHS0sVD?=
 =?us-ascii?Q?I2jNPevRyPaPmmyWuzzr+PJnwr6X1wIBOoLolvfLAFG2z6IgPEV2OmY0jlEX?=
 =?us-ascii?Q?Q3v5Aaohs5cSDwPqmBO81jjELKui5upVTGt7qYEZVS3Qn/8nb04vyEtEkihn?=
 =?us-ascii?Q?+cgUQ5WCI2ICU8IXBVlxxzWAma+DUmqND0s94m+z43Xc1rx2xIiQ/3YXsWm9?=
 =?us-ascii?Q?AsyuHky2qgiKLHMuMAWRFJM9rpqnWTG8D97e4kXlvo4v6EkqFpHv5474C0HS?=
 =?us-ascii?Q?f6qSojir7yqhhvTs7HjtS0kz6g18/HpLYK/2pfFJRPDy9Un/nV75V/Jw56I9?=
 =?us-ascii?Q?mM+cupg9rBsJ8kZ/3lbHwgePG9chFycL0U4B2EWm5d0Kq6PGqvvimSopXq42?=
 =?us-ascii?Q?kBf8O5p7M9GXk+tnKdzJVwjKDco4yr0kBs1wyw3Kg9oKDZR+o6JE0XmraFx0?=
 =?us-ascii?Q?pcgsGURvh3i7xWinMgdqTW6xlY1Nvl3K6kYN64y7NFLtuSFXXRCF3IzVjDT7?=
 =?us-ascii?Q?7fjbVo8WDh2v00Vcw3QFGjIkdPJBZPTHRichfM4V0sNz1urnjxxH+7EsSzJ7?=
 =?us-ascii?Q?GLTbwJCzwMWHjNX735cslMu8UxC5645LJ/XMbXeWbrrh0OKvrlmUjCAu9Flx?=
 =?us-ascii?Q?n349R2t+HGqKSeHM4gDjKfJ4L+qWnOB5NIODhrKBszInn7e9hk1hgQJQaKVe?=
 =?us-ascii?Q?Zx+avZR6o6NaKiW/Tr1yj+xQzhFIzpcW/cu1fwirT3ul0JrfVRIlgGxhagMT?=
 =?us-ascii?Q?5H4jtcHhCXUMORePSo2rV0uAMAitE0mpBXw6vae/LTycdKPxkam32s5FNA+z?=
 =?us-ascii?Q?kWVQum2OfbH6dwtu0VvGfv0tHIGu+x+8FzDpLZ+UAaadJuf6qkT9qw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dcb6e0-1342-4e1b-0301-08da0caf9c22
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:20.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLVtUnSx+8uGYjhIlOVYZ4W0Dfefczvrc5pXjoGn5+n65hR+krpxzr1XDt0c3e9z2Xlxb6CBRaUSBfpBCLpAnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3359

This patch defined the default packet scheduler mptcp_sched_default,
registered it in mptcp_sched_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 95f7c3fc943b..11e19ac9d5af 100644
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd10899bedfd..85642ba3354c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -608,6 +608,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const struct net *net, const char=
 *name);
 int mptcp_register_scheduler(const struct net *net, struct mptcp_sched_ops=
 *sched);
 void mptcp_unregister_scheduler(const struct net *net, struct mptcp_sched_=
ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 52e7c74b33ae..3ee23b24b771 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -23,6 +23,12 @@ struct sched_pernet {
 	struct list_head	sched_list;
 };
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static struct sched_pernet *sched_get_pernet(const struct net *net)
 {
 	return net_generic(net, sched_pernet_id);
@@ -67,6 +73,9 @@ void mptcp_unregister_scheduler(const struct net *net, st=
ruct mptcp_sched_ops *s
 {
 	struct sched_pernet *pernet =3D sched_get_pernet(net);
=20
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&pernet->lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&pernet->lock);
@@ -108,4 +117,5 @@ void mptcp_sched_init(void)
 {
 	if (register_pernet_subsys(&mptcp_sched_pernet_ops) < 0)
 		panic("Failed to register MPTCP sched pernet subsystem.\n");
+	mptcp_register_scheduler(&init_net, &mptcp_sched_default);
 }
--=20
2.34.1

