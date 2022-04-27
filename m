Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C5621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wdiQG+LBgIrcJUzlt8SoaY9hoqvSGM7TtHPg0XxN68=;
	b=kXT1CCNhe8bMX9nK0z2KIYvQOFVIFVfJtXpcyDfK1pf+LkA9GdvVhz5BDLlScSHvIOd30t
	ggRInbgZIvpHiGTY31ju91oI467OKsf46Opm/HH7BHMpyXFdk7GTPid+Ta7kaiY6BTOkec
	ia4Bl3VbsZStfUL1m4hIw+2bTlG1s+w=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-thGy49RwPkiL6kV3BcBANQ-1; Wed, 27 Apr 2022 03:57:01 +0200
X-MC-Unique: thGy49RwPkiL6kV3BcBANQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpzjU+oOXklct1Pta21hUgSRMTKayBGkb0O/JU032fq3g5eWTCe1SMC+AhbgbVArqiHqWFYYLDNhBxg14y83dNPGu9ICvTcwTdI2hrvBCaCK4+AlrN1HDwjuwESC/lNf3/SCAyygogOFHzKThAyLoclsgq5LZ/TfE1JyFjY1cWHxZjP8KKhHx7Q1FXLO1Wzvnjc+c04nz5j11j+6kOSgKaERxgWlgLJvLBQXkYaELl7zFe1tXTYPMOPEsqzTiFs4KRtLgfwcm+YklITG/jKhgRJo/VESETpDbrwv065Rlc5ztm4jUDczmL/HZFTeBi9rfqk7tk6ucJpEshVRQEQdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8lC6GT89JCk8TLpLGMc+iHrXZ9DltZZTYA46dBTO30=;
 b=lfKVcHT0IKuBhgWfuVf7eZ4ID5itHJl8WHizryWAYtCC3mGppY4JzjO4snxbQd5Ukz/Dvp0Cr/zvrQ/c9V9dvAert2L5KtOPuYB0qti5B1JLY/61yZafrVrDBy+tpOs+lW29BSi4Zf2YqnbWO5nuT/6WAUBYWUEeRKZ20NfCyvsSoJWLYs1uSdTuu91dWaQqWLFCT0zuNh0CozudLpEtRIFhpiGZGxk7U9FvtB44qg8+aZcYlkJ1YI0V3JkwPnixb9tle4eG4rj8EeKBnPVDyMIu+CBSJ5p54YPRCcslRZI4b3SoJ5Aj0bPGrHPOW/HFrlu815xbGgw5Q4l01mUW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:57:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:57:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 3/8] mptcp: add a new sysctl scheduler
Date: Wed, 27 Apr 2022 09:56:50 +0800
Message-ID: <78e80c0d260ee845be842178bef748e535826384.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a7e965-55f3-479c-ac4d-08da27f137b3
X-MS-TrafficTypeDiagnostic: PA4PR04MB7661:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB7661F6B27E8D5B9F556A99EDF8FA9@PA4PR04MB7661.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZOxWqprNFmyLGNS33bwyDF5AtxF7YmphuNZBD0ja/hiPgPItjU1kINR7a5z57gurttRf4hu9aj0O4Jg6wqxNQStXbdCyXcg9zD7TRU0xSFZPdApdop8KSGtAJRbJXd8l7Qzleg5liAIj+UBfC7JL7V5jpqyonoj92qJwx8feuk+8bzzX/Te5bST/I7zwx7K6ADmynfpOm7dkxVrZw7y27DnbYXfduAe/XQxlNRPAcM7KL8P3bpPOeg5TPAceLf5ocqC3NOVrM6W14L1GP59VBgLaH1ixOwnex5xgtV08ShHssShTz8jf0WFsHAEP0ia6bBe69UhAbHxYne2b2hThbYhftcC6iSAZFxytu2sCwW7usjXd53PeFkwcfiJJyzkSCUck41URruirzmLzpmSY3dO0+6W1fM1l5qU8rMx++kzXAd4yYJja7LotSvqHTaiA0Vf02QZlhcG7LMHDzKmo/hYuZHZV4kqnsMUZ5M+3WsXGmjQtrWhVLbQs2uCMUCBT8RJt6if2C+O/DyJlWHmFWow+oD+diaq1HXA4Ods0N9c41el0KZ7alCGFmsPQQs6nvDqZwgwUcVzuRRbPRto0hHayFM4/xi35aN2EMkju1tttF+pviqwuClkz60erlNTly6Wtk0Bxyh1BfDh8e5DgxpxZHkvdpgp7lMSNcKIRDCtQwUUDKiDAOiCMAB6lvvA5q2POcBOJ7uPvEOWaqdFWIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(107886003)(5660300002)(6916009)(66476007)(66946007)(44832011)(66556008)(8676002)(316002)(186003)(26005)(2616005)(4326008)(38100700002)(2906002)(6666004)(6512007)(6506007)(508600001)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptdips+StPYX+6sRFosifq9Z1nUlG8Ub8Aj/BvW0UTKbz6hO2bWW5v/pdJW6?=
 =?us-ascii?Q?sEk7GuNSuAlguqR3zOrkMRyQsYJhC7Bj9e6r8FddfV2jhxTStxZfbpSPwyZH?=
 =?us-ascii?Q?rtDnpAY4tko/4L1f0+b4OAgA4FEPUvL2XBqzIzCxiwYehSo9L4YAF3wda+qe?=
 =?us-ascii?Q?okWMz3Phzu1O02b6ZH/GuyPljqnZtQVTUn/KVTJnlU2LWfsK03LPXQi0agIV?=
 =?us-ascii?Q?fgYDw46/l7Xv4SstEXTksSNtuAncjViALtBAFG8qTB/daKZ1/RfTts+VsUlr?=
 =?us-ascii?Q?IWPkmnampgEOssL+WFasuUkYhs8KOEStJRqiim62t1w3ici4sL3CyB2XxR99?=
 =?us-ascii?Q?hcxIaVW4Dc/Gj5YO7047OmCrkior1GhnRKxSNSwCg+smRdyeG2opAr+W8/ln?=
 =?us-ascii?Q?o9nbdhQldFIjqaDW6rH2uwbW1fwItUJJIH/2r3iYh8kRXzlmMgAUAW/ieTi4?=
 =?us-ascii?Q?Vm9/KEYaFptv7NrrHjKBOcjdUL3gy8e8OW+rfyUjlsVce3E4//SWfR7RFLX2?=
 =?us-ascii?Q?XbxRv+IO8697KbQA8bgrpBgQ67ZE8sKC12CYMO53weVaq6v/YsPYjghH2qf8?=
 =?us-ascii?Q?1KPqsVkgUYcb68gqKAgGYzugW/nna8AlTvoEyNGHBFODiGk4rU0rMxIt0qIV?=
 =?us-ascii?Q?AJhWYAiZpIC2ks4meVBB+P/j8RWE9RMT62ABgwfQV/bjNfveqLOfLLaPTy2u?=
 =?us-ascii?Q?0oPT2fbIyptNSH8f9l1hl5W3NILytXuMWbScRdWD865ZNhdnX8Y0ahJQMTY7?=
 =?us-ascii?Q?KfEFTj3mMj8TgwtwQS1B766r5PMgKfIntTW4vpF6DsSDGTT2AFTmBoOQ9iui?=
 =?us-ascii?Q?m4Ito5xq3JckH7o0SfGXmXdBN+LPDUVghVldF46LTCoKT0UAnOwC/keOra9z?=
 =?us-ascii?Q?jSilbAjxx5w2q60par6rnKe4yiabv1VXmhpb8JzmCPyEPG8NiQb4TNWsBun7?=
 =?us-ascii?Q?i9idKXArj/pYW4QYfXLkwqUVvkmiyurWBF/YDcHM2vP0uDnIf/EL3s1osXgM?=
 =?us-ascii?Q?NVRFGL1564z5BacQ1qkZDBuUofG1KMxXB5yNA99UDR8zhEZ5ZFy+eZfFvLVX?=
 =?us-ascii?Q?Im7j1cfImIkNJcFru30X5Am8QO178rvwg1IT+ASlzlqqJx0bwzl8KmKHeshW?=
 =?us-ascii?Q?0spoMdfPg4sTEdag4Xv/F2UqSE/kyc8P7wxUxCxqoSeqEOoqjrD/ZV/gNuvn?=
 =?us-ascii?Q?lkwYpqrVRzDP1APuP9x8+5RX2EkOytgokp/shUujl4uDU3sD4JjwYg7SaVfz?=
 =?us-ascii?Q?rEaq5F14pzY4QYCQ05ObrwlDf8MP1IArdcXmdJpnMg5QVKhuXTpJhiO3tsQ1?=
 =?us-ascii?Q?ryfd/tTiJALcNhQ+vCs+yjfWM6d4MOPgU0g/8fMS/Pk2JAuVioVlPyG2y2pC?=
 =?us-ascii?Q?gR/+ReiDjQ6x4YblNmbkWcL9BSq0qvgL/0WmDtw/GOlCYYQxjh4yl+nyA7tk?=
 =?us-ascii?Q?0kFcPh15WFolwK4WqzhKDzq9CJpHpEv8QhGt3PuXHJAQiO/jpAtRg9BNHkI0?=
 =?us-ascii?Q?0rCvhTshesm23kxekf9OuaO7zMdsl2//95VHIOJw/oFjNwuua4sdxrafJnSs?=
 =?us-ascii?Q?PuNGlG6BFb3qQUHlHrc37BeI3R/KXUQTb5MZbHksITmb8eP26GOPu0nlDyC2?=
 =?us-ascii?Q?nH5Fz0EEibcBrwMzQiREXOHCXefdJWhyO7dqz7qZIr99hrBcYc3dPdz21IZm?=
 =?us-ascii?Q?AiIsXocAO8bk3lMtEWfKMXDYE+w4xVApn0+QO9qiCKf+qC+Fbx405Z3XEdzZ?=
 =?us-ascii?Q?vEjdvR4gVRWytAmZFUBGJKrQG3/slEw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a7e965-55f3-479c-ac4d-08da27f137b3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:57:00.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7FCyRedIdfofifH7wWube4kdM2pGhvhoD/evgrQoBq9J8mt+Cn5PXXph2jKRy/SBiiFM6sBg+TntN0xh/2v+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

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
index 65a765c8d2be..4842a28f34c2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -596,6 +596,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
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

