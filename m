Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9815AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUfMKSLA5Bp0kliy1ANdGDuSrdGkb2DjLPMLmhk4Z0g=;
	b=nvgr1B+GmO7xy/mOP7n7deQip66daGZ2Hhycm5xB7ZD5yrkj5IIRm37xAsV2lobabaJYmL
	m/5t56VySUxGKP9au2bhjs4jUx4N8GBoUfYY3V4V1j/uDlC3/UkSHhWr5X0pAfqbIzPoK2
	k3OgMXFOKfnHB8Of57e/OKSABpCBK+A=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-i4l_DNp_NXalZtLuz_iV1w-1; Fri, 18 Mar 2022 03:58:38 +0100
X-MC-Unique: i4l_DNp_NXalZtLuz_iV1w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGTfcV3CaPiKb+72d8PR6nseAQQQsKAsASs5XK2xUeg+Ge0oyhxfKL3xFFiaWsFu7pl0ek+nMH/hEUW34Z4s7SmPh8/WMwhM0r60qB0vZKvYcyetg8bGkyX8ESpN9xAX8tkN9rnCLTTplO5hFfhbgxcn0WXRkwSgZ1KTvQyB0sWu/LdAE2Ro4OUfaWBagelAFUNZbPA9LZ6S6UZQbcn/Teae0RA46AT/m/wGvRpO1/L3IZxwoZ7Zatz1oar5U6NNufOmcjiWWbUjwP7yO3r1jPXIi5Pz26lHh+Zrk3IF4dCYVMx2u5q2orJ6kanrQARHzKyU/c2osz2z00mclU3BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+LeuUiTsVgMDiquyysnuN32qrFMkLGwGx+kyi1viLY=;
 b=VTKojzGySXvGqInxGketnrS5jrAstwIc6L6pmpmBDXCGWK4wWgbX3kfCY5ZCfWrKUXEkonjdGSXgkTNGKZNjqooxt5cqSFQb6Rnr5eMgKNnxfHbqM0y8oj99VzXEnrnqs4SGfbQ6LV277yd9J6AE0yFz/3Rrin/VX9w8pmE/gKPZ4zWdAJxsaOVycs1Zl7VJorD0q2/hh8IG2mBI0EZaH9jcjxQsT5hsobb3Ko55boM0kbRXBGEK62Ps/+nyFjCRMfAmovLK4WVyqI37MXhyNNwRWkSorPflFlq+Qlcxf3YiYyrq5SNYuvsa9odXnpEC/vbAsi4X/zrl9eSUVWp4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:58:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:58:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/8] mptcp: add a new sysctl scheduler
Date: Fri, 18 Mar 2022 10:58:05 +0800
Message-ID: <7613acc6e70e8275f037d1ab64b4e54d3cb61e7f.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647571510.git.geliang.tang@suse.com>
References: <cover.1647571510.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 474d9f83-af6a-439b-28a0-08da088b329a
X-MS-TrafficTypeDiagnostic: AM9PR04MB8321:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB83216D06474B62990DC7C46CF8139@AM9PR04MB8321.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	almgkphaJzKLZ9TBrPBvUzeqSXQB2ln93Xea+nN2ED2JFHE9t4vrufTLR7BGAOx1E++NkB6xZgaHpv7efzzk2Vh1ixFx0upVsCS3pnjylZoKU3aWVgVbrOsgtEhh9wJUpTrpFGWIVihTIiJFevZ9D9zez55p2co2XBaozO7+tlTAPREShSICf2HzXFT+h/sABE4+Vjfpi3eM2iXvewZ1yvSFEGU5effBUL0N3jXf5KRwPE6UgsGznPIW2KpxHbUaJTfzzRm8Z1Il8yfCiNU1IWp98MDlABqWeGA/iTz82NOfcNaO3tecl7zf6xSN0cTrUwcYCOzs3+F8kZokBhQm2WwXevC93Pv67lzQqbp95wAnsWHRBXTIdU2Wdp55TAFsE0JkyA86ljN3raUWDoXuOSB1f44OTp1LHTA2NpuK4aL+xZJAmmnRE93W0N+vrXx7yA+JCb3Q7ULVRUUxXUXHwtFbdyyjRAAkQQSkztIw9yFDKSohvZI4zLYsulHEiw4iBJyKfh2Rk1hu5q1Kr5CdhFbuSr9V7vDR4uvqKQ7+aMj1Rl+vfvirdKbSmlO58JYwjOPiZYsvzbx/ZUd7VLS1TTffvFAZ/ahRCoEhUSxgRzR/AathElPVLpqrdH3BWf0OJYZH2ICsuoUbK5tbDFYhlh1Aw1hZo8Q3Kazd7g9L9QUMNELkaKhnv61JE5Ko8mOJUpnE82GT+Lt0HzqpglIxaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(86362001)(44832011)(6666004)(5660300002)(6512007)(6916009)(36756003)(316002)(2906002)(6506007)(66946007)(6486002)(4326008)(508600001)(8676002)(8936002)(66556008)(66476007)(186003)(26005)(2616005)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juM26n7eBTP38KuM3zDhRZEra0wcklRVD50fboz2gR3vHOIOhIrWkGSAOiES?=
 =?us-ascii?Q?d8kUAEuMgqsYl95yrK0HrwLr52ki6oOXwXikRR49zwSCxnMZeYHGNHwjn3PD?=
 =?us-ascii?Q?JcMCMGd1SeJGBoWqSta5b0D5hZOebJpAKAcRltFBWOKKNoFUE47DNKE2mULJ?=
 =?us-ascii?Q?hxFxLnVfs1O3fh4RUJ4nCJEjuFzdYmBBlFIjjR7ay+SBxj+sW62uPzvNXgtO?=
 =?us-ascii?Q?wV3pSeQBZQPoo1Vm2BN8zHKfRAuoxkBR7jinofwC6O9JQg/AK9UyQVRymHuY?=
 =?us-ascii?Q?fsEBy3VqdMmZ3Pkt9OvwFE3KjMbvGwIOI6ZiZtostnaGRb4L7gB3te+57X0l?=
 =?us-ascii?Q?sruvsEsVfCYYw23idSgyG7AK86WLLczpsGMQGCq8/Fqtx3IcTPdivoNtSylU?=
 =?us-ascii?Q?xX+mOn7G+zOJ1+1n2XDNDtyQV1WLwcA0CIwBKoJzFmidA0p4ghUIP7MOlCtH?=
 =?us-ascii?Q?4kxrFeBzfq8mpCnZ7zV/5TrIjk9jHryinr2M4sstjWv7nKmwK/JTrpoN33k8?=
 =?us-ascii?Q?7xZNuyKeTAyG8lvpLEazK26sQdU1eh7j3df7+7qndpxES4TqnI36ouuMtJeY?=
 =?us-ascii?Q?zximnRbq6WUhG1rSEYSoxcPHe058SA6gtPyWD6So2MR3Y+6paaR6gjc/lfDj?=
 =?us-ascii?Q?HqhPF6VFl8+5FbGCACehvuLjq4Mr2iqXQzMzBJiU/wN65xg8uVIDMUBd1lRH?=
 =?us-ascii?Q?n0Rmcs0jjP12aPGWGxW6A6JGJ8yXOufrMsj0l14gQncx1zD2fnWjaU3dcbzk?=
 =?us-ascii?Q?rUfNvDwUBPEWgx1glKVz/x8dwC5I+TIfGREekryDxPHWh709SAcSM9acvW8g?=
 =?us-ascii?Q?QabDgMwyIZo+Zj/5f1BFMf3OlR9Qm/zVmQPkWSoLgHalwgrHLKmMKPx5rJd1?=
 =?us-ascii?Q?49OYWAeTMZSXCxyP/fMkg3zagdTDk01ykywd+C8riifL2py/l0Y55q9GlANB?=
 =?us-ascii?Q?t0KLMV+LpucU7BCUK2p7JHh/oK/CFfmSwvtdjgXL5XPOVB0RDUAjVuyOt5gb?=
 =?us-ascii?Q?PpRghkMPxCpnRSHNNFc5wLtcp3KY2YQcZPrpvlTvt1U+HI9jNlc049dq+Tg2?=
 =?us-ascii?Q?+N7Z7kKMErIyjyq702G3rkW1dRj0VTEXlLpMWERBvvzN1g9S03Zpz7IdvzJ0?=
 =?us-ascii?Q?sg3lKPZhFxLP8LxD6v107xxybSNiFgOe9m49uT2Jsni5j4LC1ryZOwOcVaGn?=
 =?us-ascii?Q?N/uQp0TSBH+BvsyHTURgQovPJJWxl8Ja3POFoDF8s/Hw7RtRo+GI30xGNtlM?=
 =?us-ascii?Q?YJQNGOkDNT1eLyGOtEYlzKpIND7OMGY6e+FGQ85uCOcxtbDu9931zPPZTKpg?=
 =?us-ascii?Q?/CzvyChXmKnHXNa5XaBYhTO+kPGk45R/SN6dCnWNpdm0Blum6gXmADFjk0zL?=
 =?us-ascii?Q?U+rakcWFVaEgjEEQiBcYrImdutj3V+iLVMtdHOZOIBTsNDnPtzRyAxEPuspZ?=
 =?us-ascii?Q?XlHRKfVzcx7fs2kowhXV+9hDTPuFb5JPNC/0/lib5HXX4utlGqW1hw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474d9f83-af6a-439b-28a0-08da088b329a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:58:37.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CYMl3aLD/YZrqL3kh4OXIj22epI2hEUgn2ucoCsdKPZUkHn8tt0DEKVsDzW9HQiZdTMBhsOVjJi36tQEMaADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

This patch added a new sysctl, named scheduler, to support for selection
of different schedulers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/netw=
orking/mptcp-sysctl.rst
index e263dfcc4b40..d9e69fdc7ea3 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -75,3 +75,11 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
=20
 	Default: 4
+
+scheduler - STRING
+	Select the scheduler of your choice.
+
+	Support for selection of different schedulers. This is a per-namespace
+	sysctl.
+
+	Default: "default"
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..c46c22a84d23 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,6 +32,7 @@ struct mptcp_pernet {
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	char scheduler[MPTCP_SCHED_NAME_MAX];
 };
=20
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -69,6 +70,11 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
=20
+const char *mptcp_get_scheduler(const struct net *net)
+{
+	return mptcp_get_pernet(net)->scheduler;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled =3D 1;
@@ -77,6 +83,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet=
 *pernet)
 	pernet->allow_join_initial_addr_port =3D 1;
 	pernet->stale_loss_cnt =3D 4;
 	pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
+	strcpy(pernet->scheduler, "default");
 }
=20
 #ifdef CONFIG_SYSCTL
@@ -128,6 +135,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		.extra1       =3D SYSCTL_ZERO,
 		.extra2       =3D &mptcp_pm_type_max
 	},
+	{
+		.procname =3D "scheduler",
+		.maxlen	=3D MPTCP_SCHED_NAME_MAX,
+		.mode =3D 0644,
+		.proc_handler =3D proc_dostring,
+	},
 	{}
 };
=20
@@ -149,6 +162,7 @@ static int mptcp_pernet_new_table(struct net *net, stru=
ct mptcp_pernet *pernet)
 	table[3].data =3D &pernet->allow_join_initial_addr_port;
 	table[4].data =3D &pernet->stale_loss_cnt;
 	table[5].data =3D &pernet->pm_type;
+	table[6].data =3D &pernet->scheduler;
=20
 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c186d199cf5b..f0bd2e17f2d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -583,6 +583,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
+const char *mptcp_get_scheduler(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow=
,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
--=20
2.34.1

