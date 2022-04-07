Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153820EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqtNdeTbKx05B16qyCBV/WQRsi3qZu6i02p1PT8BtLY=;
	b=H28RzqEFGTcnWZfhD2XsXLcWjQzyG6Bkx0pxTN79JRZsXKcaifFYV0elLwJP+DtUs2Wkvu
	r5z9Oz93bti5ek6KCJ3amqLxfL4f7zgPyA6F2ZYi9mhxcqqfigDfG6+b6rB+qSC8Yrw2rJ
	bprsrQ9omP0AhTLel0YyZ99x/ysFcX4=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-249zUDGBPdqrEWbjKb3eQA-1; Thu, 07 Apr 2022 06:03:45 +0200
X-MC-Unique: 249zUDGBPdqrEWbjKb3eQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL+YpbP/DZtGQpQ31qElIi1BoF0VMO6j8x+ur2y3YqFzXtbZyIqzs4b3BgwSYLWeErUDrpYoMTli3pWKnixRkefxLfzWlECTiUh6E5opEjibsVsMsf2VELdWoDwjWvWuEXULmiUqOtAibrn6w6CzXfasn3BiHHq2ftF/hJm6hdqDglwkzLJdJAA1yPTRkf/efE/oEELSxMf7akUdcYFUsiSNcEPEQCI4B8SDzyyss3zQtxU1qoUwMw5puofxZ8xF+JtyNTpPnnhPUK82ccyWJJ/6zFa24JucKcXUmpviEZnkapl5xVJVdbnt+d0qHCahqL/vItaV2sA8Y/YCSukn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjrP1fDKs1mwyLd2rW3BcpPVxO/VBYXmWE9yhmeHxcQ=;
 b=l3qEfUZFqHSe6BJrzLnp0E/h4x5NFwYyVQVXs6ld4D8uaGvTF3CMRln7zRVbT7b/CwqSn+JWnmGnfgyUOGFrzUdrhEmJ1rSu3+m2yGl63z6s6uYIs/cCgS9209KYM3p2DXZCWQPet60+e9DMlhcQvcutMv8xz40V+F2bnASr+digkZ+7N48x2YvAAGiDsrjrMnk/KQApcHUYt4UM5RbKgd8rjRPdXXd0wQPmO2BknUQbliSFn4fDdNUdxIMUpsc4NOjQT/d0zfKoVPcYrluUJtxRIFqOmwqfV/6yoDdVPP+UNlwjMdJVJ6eyWo968JQbOBpNj13l5ApHS/1RurkD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 04:03:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:03:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 3/8] mptcp: add a new sysctl scheduler
Date: Thu,  7 Apr 2022 12:03:15 +0800
Message-ID: <4a4f94f9ebf18bfafca5224ecb36a1747a956f84.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649303876.git.geliang.tang@suse.com>
References: <cover.1649303876.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:404:14::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f587a17-1669-4b81-910c-08da184b9c4b
X-MS-TrafficTypeDiagnostic: AS8PR04MB8818:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB8818199802AFAE266A61EEF8F8E69@AS8PR04MB8818.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BWFwxYkxSGCgMpJzDbjlA7zQBq/WToxR4lbm54hq9af9H5hG6FHaZEXMLi7ZK0FpJhvhGQNBilw8Z2UShVmkkg4jRjMnUv2rVEwgYoHCpgfmpdaLcZjHHERDUcBAkyxXL0Py1jc3wqa++Nor+7wd5FrlaY47D6wl+Ne87D+mUX3TsKowGh538+d+fcG9PPmpwc3agOjFs/QSLynN0+Gv5XAbg5kasILscjIj+xusdhGDo2TF7BLXAQJ/UILOjSDNfTBASlZAoRVuu76JRdo+Sv3qNkw+KOc9CSnPQrg0yJjYTEUaf1HUr14RqBcFX63pzkrlnJQ4TQsG2Ax4Lll268TbUNLxH3r/wpM/tKncRlTV4UiQwVGXaKHn/ZDVznSc96gA+GhidDSS0IuYJFI8bMcIk9jBXpXjaA+5nXNzBnMT/WIgEhX4k0p+xF4Yi9fpVFa4RR87bOumndN+CYM32yYjsmLkRRh1x5+akADAgBeZvpz6jWBJtLwg9pBfqTxFb6qlArIasNJULWHZ2E+VMSglctoHr0NvgP4QufjUD4TCMfe7jZR3gi5/ybkV487sx+fF/fsynZ915Avjfek7bjctNsgQi58ij5GRG9JD9eIewVP5bMrN9oPWOY3XsIwDBLDUgNkJhBw1fS0UwF9gXSwkFFd7eBxFmtGiFDlJKyGnldhdKw3L9An0hjITQNsHuEjNykt7P3RqpbkTWekZeg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6666004)(6506007)(508600001)(8936002)(6512007)(6916009)(2906002)(4326008)(316002)(36756003)(6486002)(8676002)(107886003)(66556008)(66476007)(26005)(66946007)(2616005)(44832011)(38100700002)(186003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6+F0BpzE45yYpMJ8QqkWSXh8YZ3ve4FkotWDry7f19lfQ1sp9cWmX5vHtL1?=
 =?us-ascii?Q?UTZxi3+YUs1nq8CdjH9fvrg1r1OCOYWvx6lQYKzNb2L1lqJ2t5/RwB/OTE/V?=
 =?us-ascii?Q?lpBsD9Vukp75WZ5tUCeWhtHerteu755BXyfCj9M4/0m51QLAUPfMAS1S43EZ?=
 =?us-ascii?Q?TtmAELlFViHSUa2xQLKd0BQ8iHS+CtOnBE+QOqavPUwHfU8d6RHeC2we03H3?=
 =?us-ascii?Q?68sZJZZD0RKUIUENzozv/3HJ4vPs9RqJIGJ10uLdEYedLS+VfNw9hoGYQgP8?=
 =?us-ascii?Q?KNq99lIM1xmC/UqjWwuhza7ZO2kd7jpJJaHFav+vQ20ongBFJd93+7TafvfO?=
 =?us-ascii?Q?g6qdxa9a0+YxlgXKu080/NcZZIt8/VIRUuPvw2XZrGWIja/diQtFk46tRTKd?=
 =?us-ascii?Q?Cwi/3VJ9U2vR8D1dQDfBelMudp/c3pwHaGGE/XVAE7hxumYbV2u7lEdnNlfU?=
 =?us-ascii?Q?4aWtj8DZqfLjsjh6+10LQM40me2+m9mg0oLW8uGFT2jlNrceTQteAplb48RF?=
 =?us-ascii?Q?E54aouI/4Prv1/GTiDMfMefC7TAgIPlsALMA5za69UO7Qdtaf30Sg90OTJF3?=
 =?us-ascii?Q?90l+L4cw/6qjkK2++NyiZeYNAHjYKnqa/bbE6rh7mrEMHagtWFoLl5tnRLrU?=
 =?us-ascii?Q?oHMp5JnM7xgKh5C1lM5RKs6OwgjCI5qaYis6artnW8uJk5Bykr25kNwdInWF?=
 =?us-ascii?Q?xFrGfpbtqIlKoTel3R982nSGsPW97GMYV6C8He4jyRmIUJdepPcWgzcBdwS1?=
 =?us-ascii?Q?iQkIWuUuzYy2utxN5+z64MYOHX6/s167IHJZP4Z84Yltsz+6q1Acgf4nIfZk?=
 =?us-ascii?Q?IkPOxsx3miT6P0cg2akdtbPMs1BZExlyN3+Q16D1D81Yd6EeMEBNsPSoYoT4?=
 =?us-ascii?Q?8sd39DRn1g3XkhowfOHdHktTKhOQMgoQjl/Vv18Qgc9xZo99gTWytOzFXfV1?=
 =?us-ascii?Q?p9DOwofhqsTh6CMLKYg1gqN6wIapk4h31fHcQizglXJ5VMUiC2HSrZCryZsD?=
 =?us-ascii?Q?ubd0jkd/9afER1FdaPQrgkU+VIaewoBZdK2o7j96VSw8DE/3n3gH4qAaFdvh?=
 =?us-ascii?Q?atx3slIi4t1Thvv7t4BxmbA7DpuOplR/J9osdfWrK2Dgo2JaHHGEo1DL4D8z?=
 =?us-ascii?Q?2IZpcOWU0ryf40L3aZ8DiVITJZ1dSIAwqXNZrXKtOyNesj3CKkT9lpZtz8Cc?=
 =?us-ascii?Q?dV3I9xB0YqlswF6ez1tk0LzGWIAmMelBymuVEsq+aKyb61cttwAkl8N41RmQ?=
 =?us-ascii?Q?uwwgy5CMNsOnLlZgF1jezGzYe5C6/eS1X9EfvPxKp9mkxd1+FoQlJyYDOzKT?=
 =?us-ascii?Q?chiZkqscpJB//2bPVpOt27PSPJibc6zGHFg2xDbl++37FJ7hBagKNwO9jsMy?=
 =?us-ascii?Q?gpkBIx8wvO9qau1NsnzD68CxIg+yAIzVL+Wc0lnFF3ABCVL40dfsaLgQ3CaS?=
 =?us-ascii?Q?a9fuzTa6qhegfb0mIW+gxxm17C/g8Ue+hWtdh0pMHk2P1gMrHAMEb3sS2uH4?=
 =?us-ascii?Q?I19sAzkXhEk/0fUMyE6X3zgNCp6qHQw0MvY4pTIyEjLOtPLg+kHu0bJSmJuL?=
 =?us-ascii?Q?6pcbB1hB8JlhfsjSh7IjSo0PZ5TaAFLtPXOL9kD0jXPls1jXG8K4EzFLfSnG?=
 =?us-ascii?Q?rs9T2CgCfQ+bMBIdxRtA1D/4ONHMeo2UqYDvEdSml5oeFL+TUA/maXSk1Cfh?=
 =?us-ascii?Q?UxIkCvnoWElI/T4AoqY0FPDKkZfpmPld70Mqr6pywlm6z1p4Slzq33pUQlC0?=
 =?us-ascii?Q?r/QXXIuQ10PF+1lFvbfc1Zc3JjkUrpg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f587a17-1669-4b81-910c-08da184b9c4b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:03:45.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZMsVhUUdgl70KdszTUTWslBXs/kr2u/8kDZQCY5CcQkAjA3lh6E/JJ6MtCSXZU4/TAjGid+f0ZwUfRdy3ZKWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

This patch adds a new sysctl, named scheduler, to support for selection
of different schedulers. Export mptcp_get_scheduler helper to get this
sysctl.

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
index a264964f8d95..65a08110268d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -586,6 +586,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
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

