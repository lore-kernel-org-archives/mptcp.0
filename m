Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158E33D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUfMKSLA5Bp0kliy1ANdGDuSrdGkb2DjLPMLmhk4Z0g=;
	b=JmjeaxWqa7s6Qhc1bTwkw+jexaEQy3z3qA0NmCkqLJbzlulBQYudHWleTTCFSAkk52Hb9u
	ay4l3UujwhzXNw53mlQ8VqfDA7fmfY1ne/dTq19mc2SVZWKs3gRELGbULbeXTdjHtD3Jpd
	XyNox/2FKv+FrL+UhwI/rSGvaIM1r6E=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2053.outbound.protection.outlook.com [104.47.6.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-ytGK1wjjNq2LoAqb17A1FA-1; Sun, 20 Mar 2022 15:09:39 +0100
X-MC-Unique: ytGK1wjjNq2LoAqb17A1FA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWjp2Ivp1tr8jMwogBdHiuWfnJSo5GjPu0GQhltHvmW/tbPQpAj83fnNkWUKPINWliiUDFuLuteJ1KaPlSyULoj75g//qDhn0Bj+gDZgbP77SQhaXJExOslAD783MeGvMEyauqP81hATmCigtLooAvJVxN4FEuSZ5ft0MmaR0FaUqbRAbXoTxVqmdXNhv5ZVnp6l6pNBim7w24YWGqENkl7WhUCxm4WReqV7WFtT2vvbnFbPz4ktg57mcS9LMGUle1z8a7lnJ7YbYrprPAiGU3FxYOzKKRHGJmS9YndS4WqqHEAXJld+BVipS9N+szTXCSSx+L7gSjdpAUCSuOpd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+LeuUiTsVgMDiquyysnuN32qrFMkLGwGx+kyi1viLY=;
 b=fB5eLzZ1ao3un2XQjImeHAJb51PPsSs+1qsin+YDvyZ/IgVs3l1RgwwQky9KAauwpyW/gtpYPLSZTU0khnuoIAn7pbvR1ol9OQceirgylgpenn4rGy8jKlNC9X+y9WYVYy5s470DY2A967jAFvneyMAJC1qBVMotTth7GlhHFctlDBKS1HYuswbaUsBTTZ1M/Ver2qE2gEquZPK4ebhx+/dobdpeQrQgWGd36F8tm29kl0wG3rqHfs2HFGZZp6oY11O4aB0hER3pmwW8gdhWQnZj7YTOpQ4DphK0EnnMmy16CS8b4G31y74vFGuALx8VC+LhjrnSv5e6pkae9y5NUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:09:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:09:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/8] mptcp: add a new sysctl scheduler
Date: Sun, 20 Mar 2022 22:09:07 +0800
Message-ID: <0e1e6ebf2c8098e9bd1a86d4390eef5265bd55ca.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647784679.git.geliang.tang@suse.com>
References: <cover.1647784679.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21fd9c82-2703-464c-dbdc-08da0a7b4510
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB703578E04E5E083F4015AA8AF8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RRNo3SJHckV/cTXBFQHg8EsIri9mG9bVLDLI2SGONrpxlgNw7xDv15vuXffiLR0PuNe+lwOnps80CDqZsW6KdmO9AfYGkuCkdlQa1SbdL6rZ4FdCEfg/jV0EgG5lXxapLcJSInGBsh96WLtNMQk9Gaaivu/55QtANLKiixoDcsyPeZtf8bjVxsozp7bS/B+f7YGshElcYNiBsrJ1Cs7tSRoE+lkBnmidsswir/H7bLaNQ3EhZMhvhGeDBGYAAYWGs+n4vO2Rf1/T4gDl9/pam6hK7OzsNSpsFBz4F4fa2J3pWFIYkA+NtZjqpRKMKpZWmmo9sg02RZk2fG1IDCm8U88qrdHbg8Pnz38mDg4A5StP352SPwvwX382qSTCTiX2fKA4t9wfe4Melhqikc9R5mLvhBD2wXYj8ivfU53VY7VrhK0d20ygct7ynnKNhFoQrRCsq9aysrGoJck0hKywxNSb2c8+JB3G1S7n76tylVdo4lK7xh2lVuIh3rPgcZIlv+KsdD4nnvDdV3MUW/lNnfkXeZF2bKBvK/lGqTnFNEaPekQE9nqYw3lbX7fKdpqUS5LQWUWEU24FLZ+SlkuGp86SZisJvhv1+d9hDDmwrBxFxXrLucdWQcSAfR40lup4WupLg17UOWQrZBu4Hc+tb+8hrnDYTf+4vq+6zb2/y4+kC9dx/Ni8/34O97Q2lktEx6YwTSdBnnQUNopddD8MTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(6506007)(508600001)(6666004)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HMIVgGkgVClqOOTQGLtGYa5VkF0UtXrhevMmUnmrObdYCF43WzxNigYpij0H?=
 =?us-ascii?Q?XyTYGrQiDGThJ9013Qh2wPwnwG7Bec+QtO7LwTRbJMayrJRlLKdEnF7JTQ1G?=
 =?us-ascii?Q?2mHsYik8BKVYG/EdhdzdfrCvyqM+gPmJfak/+MTdK8uwcfCIHyshJv8xHB1h?=
 =?us-ascii?Q?hON2pmsu+l+h51+jaRhGq8beERz/Cm1hwVIUeUZiG8k+yOVXAjHmPzjIoKTl?=
 =?us-ascii?Q?pO1PLFNtKxds9cdN6G6U1nnVwbgvPVwzekWLcNJJNOY9aRRaH48M6jXH4c37?=
 =?us-ascii?Q?0/Lwqdgj2qcK7mkVj3lB3VLl7n2r46DD/omuMdHQf2hsnauWfWjNt9mYWnuE?=
 =?us-ascii?Q?bCvpxjLP63RU0Rcbi1YysmclNJAfUuJ7226q605ttgDdHVBC5WxiVfKCLezD?=
 =?us-ascii?Q?Hb3bVS/yPFF+BOa2Tep7sYgwzLU0KPvQYwwvuTXWFF+O6ljRZRKq5jvOMqv8?=
 =?us-ascii?Q?EZjoSTGeaVf4kbb4Q1NaDSUSkJLQgKM7mC5R1HgFY5frRGRFFrjASiqAbAg3?=
 =?us-ascii?Q?/6t8IRf9/PGcyxBDSM/4iP/CuSUEiDqIwYjfNK5BsaWEEzbERecs04EzHYYs?=
 =?us-ascii?Q?YCI8Ak+UgpSyIYLiAXVeIrPa2fCRs6YCtE7H6+bXybgTUvsGuROMBj2MF3Bm?=
 =?us-ascii?Q?wlalVsUxYE5R7U3fPjwZjv7AEtiD//suLc4HrEQz375wAJ2BhvcYC4Nmflpr?=
 =?us-ascii?Q?AYaytv+qM5dISkzndVTybb47BSD6/d4D/eQejt2S36nhKloPDnc9m57a2ZBw?=
 =?us-ascii?Q?dAvagka7mypY3G6DHCMYuYHsTfAvC4u+hUxSP2TEzAgaYwU/I3gZMeQx4Z/W?=
 =?us-ascii?Q?2Jv+oDzaCMKIbHsDcBZ/s7RQJCaBrUlZoK1yeGoo6NG9CQ8H1IoyaMw9jt0V?=
 =?us-ascii?Q?leJDSNuVKSGiPasib2D6DqLKViw7SVJhfJ63nVS7nGwUDpXRpgdE/GevsL8d?=
 =?us-ascii?Q?xDepvuk0dSBSreoP/nUT/2RgC7qoVROyi45iXdoD0UOEQeWcaqcAG06uoibe?=
 =?us-ascii?Q?C8KRWW7/Em4W+AdYMKrnx/Z6sDBBMyya+1D4XwHNlajXZccg6/V01RxHrFUa?=
 =?us-ascii?Q?LNRVH8wZkPTLLeIo9XPRD9QnvshTydFhDHiq6vXhX4Xkj1OPSTzSACXBJwXN?=
 =?us-ascii?Q?Z7jsXyN9Ur3UHKTiH/G9Ew1QfJOWfUu51JRc5QP/Cx2Y/R/eAlLGfH1qNzZm?=
 =?us-ascii?Q?F0crPMySvI0QMR/ZcM9WgdNoDW36+inQlYjKA5Icnl086TpyVxQA4mGgugkf?=
 =?us-ascii?Q?S8wiwiPF+f43JRmcXaxH8Mul1MyJrsVGcB6OmJiGNersKXHr3xVQ4CWRFjAs?=
 =?us-ascii?Q?+DKWyfEuQrG6A/rLF5GIy8MjLBgVm7iTqysaC1vxnjoy1ehdfK8/y8eY0M8o?=
 =?us-ascii?Q?JPK33+enGK1nKiRhr8c2e2cJ1PQ6BeJc1ZnKhJon7dzlZVqCBK59zLyPRGZo?=
 =?us-ascii?Q?EoYBUsZ3DkobtsAJN91BvIfKrhZr2vyZE2oPmj1WkdBSC/vvAftkPg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fd9c82-2703-464c-dbdc-08da0a7b4510
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:09:38.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F20rklfXxl1cSPgl+pPE0yM2EG6HnqqjYdaKcYal35YNHWvPxmhjOvsoGR1Vaj5UfuZ/I21YNFckeMyuZ5g2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

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

