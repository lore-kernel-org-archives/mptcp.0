Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA6621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvvbsvegrT5AxOmxgn8ZnJ8aX41EgSZK+9yoTkUuqUY=;
	b=evctFKaFRc3uqaVvLhCQbkKC7rV2NiE2FaJt78KC0PLAPUCW2bVSQp5pV7ycWOkaP0mbjo
	SUD3DUB5NcM2rGl3dgC8PtNxg5YtLwkTGSqUWXQGl3ey7VisLl/AVaUIWNStS5stnPNIPR
	VMuoSpa1DiYKwg2mrmpDyvgeuJDWV1c=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-uB7Iu5-wMAiFxki0A7kOFA-1; Wed, 27 Apr 2022 03:56:54 +0200
X-MC-Unique: uB7Iu5-wMAiFxki0A7kOFA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0aocWnMyPRSpN+3WSj1tVvjYj8pfsRYgvGT1YDShl/1TOQ26IEtrf4u4asOgjZQDFu/NLW/JG6k5M6CSROkoWgnlVFJxdSxayak1kDHBR2TYvimhRp9j2adKOyiCXbui/SfKr1F7raCmaXTgnmwtuDEd8TB5Di73aTi/xFgvz7mKs31n0VoRUx7JDHOhebTA12E3Szp6Y3IdB4JjhhWZhx2AfoaWK7dM3sCbkq8HDLmJmhf70+jbkmllya3RSooep+8WiVpW4BLw57484XQ9417FNrYd5Z3IGEA06Ji/ai03Hk0Vb/+PtJQdSCiJqte/uwdPpJ7gQXs0F2AJ6i+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5IMNB/Ob+mif/9GAdi4MrvdeD5EMOBSGJjiuM5U208=;
 b=Ywi4yY3zApLtRIUm7hr9P+CKrRROcXFnqcHYsYr8B/YgJdKJvfmfyB9fW/o+CHKe9mbTEbH0MU0DzFfhIP5+Pl0i7C/mDpd5Z8ChX9VSggoPQfZumOKueYymYZE4wuSlvSeFmJi74NzNwJIwXIAqbPvj8EJIIEzE2Ce298auKydk+pBKTi4XP+pRfcUJYhJycPg9zs8e8ncGcetzLwlECPnvQoBkpTh28mwisC/sa8JmALCmK34gwZwoUd59goyfbXRIdSLrfYF65PKGDaVuoJYJZCcyx9fIvczSz+6LcDCuEvyCnmTmXRerpVrQxiWSyxMs/T/FReDksPfbQUL+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:56:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:56:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 2/8] mptcp: register default scheduler
Date: Wed, 27 Apr 2022 09:56:49 +0800
Message-ID: <b05f80d08324d52dc3e74b05b463caa8a23f4b79.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f2ba542-3a09-4e21-4497-08da27f13366
X-MS-TrafficTypeDiagnostic: PA4PR04MB7661:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB76615964D648E79D75DCBF35F8FA9@PA4PR04MB7661.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nK9+UdbD17+3cJjMxEctiBPNELCwnU+fnk7YsE4b/HSYKimGWcDO5JRAvEqe1YAcLiIzlOPEWIij6kBSY93JpLWzy6doXnudRMcqZZ2WEriNtQDoLvj7GeNn1iYWTsWEfNqD5WBN0mb9bYaTf+YUuQ3l7VwWaXyvAIrhjfcH6H45ya/m0l2eXe9RNPo4E/Ok3/Z7WcYsw++dizFoUZtbWidxn8ERqZFxUrFAyHFncI93uO2bvHoZmBSJYihXmlg5oSf+g45uLF5yDZeWgr8Vg8+RQ/OsBBMheWTUkkwgM5xaPQ/oQswLe/CMOqVcHMVV9nw3J1uNI+jdOWy1prd/uJmM3nGcZyTrNDveFJLmR5cG6ykGK+29Y8BdGf2aLbC0vobs4wYQf1jFz2X8XjgT/PWdHqNhjNp75VMiQYhB+rnhRnJxDiUsdsu1rbtjx15ZkS9uay/xEyoVmgeBY2/DaFgdBNh5xlxHj7fmIzSc/XJyH0TcMJAQuYx6q0Kn8nR0Hob97lldI03kAFnMCcOjqq27pfYgmSvQzt/IwMDOkXVYxq+Nyu8dB3/DPgsqHz73qERJSut3aM6qLhMeZhm5jjB634UomQ68ELYxQWUPgVlHzkNEk10tavLAWqyPk1GhPPKyJYTmckXd7eSvj4kmn+KyXOtY9vm7eQTarGKvcGB3WFpKhdGSJ40kU216AxWe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(107886003)(5660300002)(6916009)(83380400001)(66476007)(66946007)(44832011)(66556008)(8676002)(316002)(186003)(26005)(2616005)(4326008)(38100700002)(2906002)(6666004)(6512007)(6506007)(508600001)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3GMNzKDMg4ICzSsTQodrtDmRVpzOFRvg50r6h/yvj5fUeXigiggpM4ykyff?=
 =?us-ascii?Q?VCg0T6GcsrbhH011YvPgpJB74YYD1JvQL+0ux4oLk+P4RXTvAwJwmEU1gfTA?=
 =?us-ascii?Q?zU7eZAQtAp2l6H6gBLypjisbMq5NltptQ2A/kMKaY6UWbDHF1S7+lgvq5csF?=
 =?us-ascii?Q?cs1InM6uUptSDWwBkcsnJUaB5ekrld66tXZccTYVamQpQmh2WmDd0NhM4KGY?=
 =?us-ascii?Q?tuqFcj10p+brfERnLdsCrgIIvqBpWeRp4niszPDnEvoilcz3h3L3hi8ou8As?=
 =?us-ascii?Q?BRHwc5YUWxOYvIXIAgZuwYhcmYcYxgoq/oFUxo/AuvnzScdCIVHq7+qwLDTN?=
 =?us-ascii?Q?zuAYfc22+jZDmaKnOXFcJKssPtnkntbM2dKoCYE8KKEuPOqTzpUZGklyoCTe?=
 =?us-ascii?Q?HXFvpBII6v5FT9sK5ZoM2NCSRRIusL358b/habxqO5zxtNEbsq65FT+ekO98?=
 =?us-ascii?Q?4d2LzD1z/AIkG/tPaVZT7McnFaEoaIpi9BhCW1Lc9ni21YBge1xxP3Hc/TS9?=
 =?us-ascii?Q?uidHQvRw4vidFCzeLXwIXbcne7ApQpeG8GhTDFy8504G1/CLTjdfxFEqeE4A?=
 =?us-ascii?Q?LXc9ZoMN14ZY8bF/e8/bjdBvrT1wHm4tOcvlAtY386VCw1c8p3IupEP7VGlC?=
 =?us-ascii?Q?xugtb/e8eiQTwd4B64LIYSiMvdQU1QmoXqNVot6C1s+tHlH4A9DvJcNRNuxc?=
 =?us-ascii?Q?xVJ+ij/S7TQ/mqc4XyBdQwNkcX1gwM31rLWDPyNKi8WY+JTAkdZcHyySCsLW?=
 =?us-ascii?Q?m2vvy4FidoY8WeBAtzZi43mVN5+J4kGELSl09bLKb7iGODPDu79L5zlQ94+h?=
 =?us-ascii?Q?CoGGGHLxJbyXaNpq0HYHgPr4BPBEupdtpcdCfElRgdYaUxrmQUclwstRJIaa?=
 =?us-ascii?Q?t/jclVpUqBaYhIE7F4L/4y/qBYCVJzn9Oi1FGh1C8XnBkoMRtjZhzpjlc5t2?=
 =?us-ascii?Q?yaxOFcZO4mfCwzRQmMBARh8tgpSqT49NGFN0IR9QZbwUvGorq5gMPge/l4nO?=
 =?us-ascii?Q?Y3RGnI0KGFNKychNiFnnlQqkOnGc326u9rZy0w/xDKudy3aaEgbGJ6lsU4wU?=
 =?us-ascii?Q?QLFlmbDECYr6Sx2S2doS/thvRX8PMFfRfZ5na+7BtcBqeS34O+YtMJyzXzss?=
 =?us-ascii?Q?SC6Yj0UIcqJ28WeWvidWufeP51fXrFgfUXpN8QuKop3AiV3amUO8WgQxb0lI?=
 =?us-ascii?Q?HsgusG/ds9BtpF9cVqL+QYWRnq6tYN/D3A73noUC0B9+bLXMdixYejSp33fQ?=
 =?us-ascii?Q?wArYln2Pza/Nca+HLTO1gODlGCZWpwfxcjxlC89ein/zTDL5InwronR346V7?=
 =?us-ascii?Q?eoxFgUFqOZG5ESlBQXzlhaA57MHwK+eWeKyALcGZDsZnGPt+44yH0r4+cliW?=
 =?us-ascii?Q?I1LQYIG89dbb+Q2+2yvemvAm8t8Sip0XSn4fvN6cqEatqR9j9PHCc/7YDXoD?=
 =?us-ascii?Q?xRn2kC+xO0CeZO0Vhw748bS6mlsrKgqtA7R8rckJygACLNla6LNxY9EuVuO0?=
 =?us-ascii?Q?TeNe5nzD6kWF2Y52cmt1YwjkUqsJEOSOSKbvmmlBkXwhZCkHoc00SLSsr8vP?=
 =?us-ascii?Q?7IDRy+6UlFyVHY+5d0niK/0GeXcqp4TRPGQMtv3BcSNswGEzN7P6umgjkscj?=
 =?us-ascii?Q?pT/dccz/x5z1dQbpe+TvQBeyUMbmJazw0HvQrR2I3bFbZkjeWpklVWnO3HH1?=
 =?us-ascii?Q?eMRlqBafiKwgMifKUuGkR4vWYjI+/MhQP3MiU+g9Irei5Ilc0tv6V7Um8K2C?=
 =?us-ascii?Q?SEJuKJg09xwyXNdeZR1e/Bw8lHl4nO4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2ba542-3a09-4e21-4497-08da27f13366
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:56:53.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3Y2RWjhNI/OuRXaCtqUPakCrG8na5P9csyJJFYhaHANM9wheNn2mo1aP/cYu2vc+cZIaGSdWSN7EXi2ji7TKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 +++++++++
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 653757ea0aca..bf9d5bd8dfa6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2259,6 +2259,14 @@ static struct sock *mptcp_subflow_get_retrans(struct=
 mptcp_sock *msk)
 	return min_stale_count > 1 ? backup : NULL;
 }
=20
+void mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinject,
+			       struct mptcp_sched_data *data)
+{
+	data->sock =3D reinject ? mptcp_subflow_get_retrans(msk) :
+				mptcp_subflow_get_send(msk);
+	data->call_again =3D 0;
+}
+
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 {
 	if (msk->subflow) {
@@ -3813,6 +3821,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 221bb6b9860e..65a765c8d2be 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -624,6 +624,9 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinject,
+			       struct mptcp_sched_data *data);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..bd0beff8cac8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -13,6 +13,12 @@
 #include <linux/spinlock.h>
 #include "protocol.h"
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_get_subflow_default,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
=20
@@ -50,7 +56,15 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sch=
ed)
=20
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

