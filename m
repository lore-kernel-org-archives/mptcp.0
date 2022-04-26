Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2217E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wdiQG+LBgIrcJUzlt8SoaY9hoqvSGM7TtHPg0XxN68=;
	b=CYpRotNwjOMp//+9ssdTlWiggQVPzInS8tSNsBbqkm3F7Bp6z2eQoOK2CLkvpNaO4qZZ4X
	gfGmWNbopiJ29qjnHt+9Bp/2md3Q1G/GTivRETMS2AH6PwOz1pPd/zyMrOt3NvIpz0kJdj
	1jFdj/0yd/PkFWpzHE1aiCiaOEH8pQk=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-H-a7WOgQPmG4GZ_nqYOm5A-1; Tue, 26 Apr 2022 16:01:10 +0200
X-MC-Unique: H-a7WOgQPmG4GZ_nqYOm5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grdNmf9Wd2eUeLcY9ZjNFhq/C3FUn+vqi4Cx4LXpJ8Y6tTPN8/DsHoYzmjvwzQKxwHcQkdOnHNCGaGKlvCXCD0oL9r9+ggUvuh2ez/vs+bft+mTOBZ5+MwFjyNe2QjG/czHG+bEcqyCAVvBXJQZWZuhZfyp62oXADIPKqtCBoCTAhrXB5Az4rEVyE9F1GJ+5h1k955G+LbQ8dMSrwGW05Dt6Zegsme0oycuwKATFDsjf8Uv0dg+9yeowOWPKeC4kfLdMzXNIrdH162qJQUNUgdVA3sTxvRVANvarY4yTUZnSOWRc9iUMz935Az06eWfg0jyvB6KgZyAk+GssKaQqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8lC6GT89JCk8TLpLGMc+iHrXZ9DltZZTYA46dBTO30=;
 b=nTdyMWu00CeREKEV4Qy6ofeAmEIQhNq8Y9+xjFNaCaGKOED3uzho1b73WRvICJprEfV9lwfdgAALgl4y8XLGKxFb7RvmlKuSb1ITS3T7QwrniQgAWO/BkGEc7aEsb8nseZu3D/KFs/AaFzQxLLNropF4HaYalK3RjnA8znZtDoT2kUW4t5iBa85b4O8rfhO9PccnAhrvBbEK7MlylYUu8GeXY9OGXCwPKySnG0haQkDXCC8Tss7BYsMEtKOZ48OSkAAp32Ql1IfBgQcR3q97wkG7xtis+ogEZ9T10gZCq8vRaKS1flygBRHdo/ltoKUL15f8xC3ainvKliCDwkiBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:01:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:01:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 3/8] mptcp: add a new sysctl scheduler
Date: Tue, 26 Apr 2022 22:00:54 +0800
Message-ID: <e6fc560d8ffb8b568b36fc0bd16285d04c60ff6c.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650981078.git.geliang.tang@suse.com>
References: <cover.1650981078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5db8f5f-30cd-4bc8-a330-08da278d36f3
X-MS-TrafficTypeDiagnostic: PAXPR04MB8816:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB88167046C9B8D5D9C2D84DD0F8FB9@PAXPR04MB8816.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3pFmFCSeLhqhyoPGxsUZ6OdFOE5Vlz3BAPty3Us1OHNc3spq3nAtem8yXHxCeESnZyNH1GXPDwHP8xD2541+bUppN8KIDbL8Bs6SZhoTPhQCbVLPhedl8DHpuYl4//H8YDH5h6I7pvZYI9DsYEb02CU9HDI9Qrn3/cYEIq90xKNyfTaCK0bA1fhpU+AAt1bSYdv4r0AuWg+676q2bjdsTuYqheSPvCLz5x4MZdtFh3cC40SuVL+HOFBfANd0Dy0n3Lv1sW4jR3nXqYqV4qHp/JdYil77nLfda3YboVOfCEkY8+l8z3PQCb2DC+xYgzELh20divP+94ayKVA5fmKJtua6vQkXZoHSUlK47b/x9AeDl6xIPXx5nVXoXIl22xbQYLM92uuykC/F9bECmKo/3szjys+JqVO5/qhomh7kZ2JE6rtK/rGiGjo1DY8Dd/LmBw0hFWFwJDgU39OhjtekqbTrYSyiU7VO8RcJARMCCb2LYF5PeQ/J2LTcciPKeD2DDp5j6bvQKXO/AAZJ6mPdp7/riXrNm6lBS5k7GOfR8MRmQXQysaXiiVc4Y/l1FJqABwaRnG4HzHQ0ge7L5bcCYnxM+59FSb8QmM/wtfBkD/uASCa/wICz3XQu/1xf/LZpxyYWdVXWcmCe6mwrc6xuIwmerRPLmXpbYvBlABOk9WXiHGN8o/n09ESA3kAjLAO+2zKsVXKguZwfVxr32JgetQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(8676002)(4326008)(107886003)(2616005)(316002)(6916009)(86362001)(186003)(508600001)(6486002)(6512007)(66556008)(6666004)(6506007)(26005)(38100700002)(8936002)(5660300002)(36756003)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WkhBLjX8jcWWwFbGJfgy9O8OtnMxx5Cm/eKEQ4y47zhUTjBVEq3V7rN0kio4?=
 =?us-ascii?Q?9UybLIku47Nom3oysbYB9TI95uVWGniSKOcqZ/mAKeu7o1lBfRLuxRW70J2F?=
 =?us-ascii?Q?PwSA1vvzxfS6cHo/cmpop/Akfp/qB1Du+iIeYYu/gPeBX99kH9BLuyaCQac+?=
 =?us-ascii?Q?ptjf+Z+ZdfpAS+QxwU8Wf5Jn1X1LjUCkQVdzZ/KZj1nDUluB75FibrAbFS5J?=
 =?us-ascii?Q?P94f5ZPdL5zSYPgowetVR+PSN4HS8lmgGK7laidINzkmEbjMKrDeFwaFkOjy?=
 =?us-ascii?Q?TjHvutSWiazQ252IoXdImlKODOEuCm/Dn+wI7RlG/xnelW9uKNGfeN+57u4q?=
 =?us-ascii?Q?kXAxiMmN+RmlIl8JodZlf5oOAy6uxml/esZy995jrQvIebJggOA/FNv4rKrE?=
 =?us-ascii?Q?3zeb/l7NVTTVlx8ShrM5e4M0bhCJ8dA15SvdJdxboSB1Euycy/dyHbVWWzkY?=
 =?us-ascii?Q?zP6jqcHJPVYs1CnD/5z7CncJruVhU2Rj2obmaTrkOzHnai055ATixsuWWX8z?=
 =?us-ascii?Q?5mBSpkaWmLvtCPi8w07q9CbPfLtiWW4v/6SLWZNKRkgc7ETkrLEbV5fAnARk?=
 =?us-ascii?Q?qSrQ8S2ge2zVHwc+TzHcrJqDvhPiIWhuPyRiOo2zhWpKlyYLtYLd1q2EWhcS?=
 =?us-ascii?Q?XNhlCualpmHGo9S7tdoLp1OF7YfmvGlDWC+WqJc0u24K1ohTT/7w0hlWZ0lC?=
 =?us-ascii?Q?+ocZV/yqVjgbi1Ndtu7hPgPHblybx+m6wxvpptmpcdnGEK2aZ3f3jfG/Bmxq?=
 =?us-ascii?Q?YlebY3Wl2Lhjo6h+qxWT/B5+e3T6mpBa15RrLMr4+97wPFBcyopMJU4lOf+/?=
 =?us-ascii?Q?VzXb8xnFa7PyGAnukEWJpPbwPlYbfBY60xO5x0eMsw5TsO490p5UDcuEYq6t?=
 =?us-ascii?Q?Gh3W30OBn2K9PMzAq6qnLhrx4TVjJF73PH1yfYqAVNcCD8xMtYMfSHvm1nZx?=
 =?us-ascii?Q?JrfrP/9Y7NmKRiv6M6xg/pUXZWzYVAXGVrces8si9iaXRxoe3/9WU63zBays?=
 =?us-ascii?Q?+8x4+JlmBVbk44QBHgfwcZ+NElcj80vPgHwRGP6ahty3fjHWF7ccTk0ZBNQ0?=
 =?us-ascii?Q?W6jhsBMoFWQbosClwwjEYn8unhspupdoi0ulnBqrSv4C+DwferLI2Kw3YEwQ?=
 =?us-ascii?Q?ooh6j7bk3cO9YnhKESALe6SoQd2rMx4Ikbw/mopQP0PaY3vTAcOBQ/2ZL65M?=
 =?us-ascii?Q?PGGRKyEpaja7ntdwc6XsnizKfJyygX9+UdQriGuxc0vpYl4LpAa1ctfJpajo?=
 =?us-ascii?Q?xNxO9D/pCKG4wqT5yzkNwGYpvE4qq1YDMvy8wwQ1Zawsl5qz45Dno2KfPniU?=
 =?us-ascii?Q?K8gPnAuh5lH0nO3AKQUhOm4d9Z4zMORsjf9sK5zLE2uYc976C83LyE2d/ZHS?=
 =?us-ascii?Q?xe378MAkzvq5tzq2T0ous/6p7ED44IfoR/709+drBeRZfZUh6TU41xFr9Byp?=
 =?us-ascii?Q?VIqSwzNonbLkBhUguO/SwBWRQz3suTGRNAKr9V3uzEXyjDtpfSbLLXehpMsy?=
 =?us-ascii?Q?tABHGMnKz0198LLzoUrySq1NY4gtESyqx9pybSK+LOljYQwmsf/KQ4AzaT25?=
 =?us-ascii?Q?LZvksEQj/DGP9IAZ7UBs9p0M+6MJHTKVkEfMzQLwyDn6ljoVH7sHUwKkTPlh?=
 =?us-ascii?Q?5Rd0Z3YGXzTQBOToEjwoSDXtvKZZV3D59KLlREGmpYlr5ju5CFLpNKkmsDpB?=
 =?us-ascii?Q?8CM0u9mDIMagBdLL+n9w6R4YSt8mnWjEAn4vzziw3xCfhAmskmhPXXUXIQqR?=
 =?us-ascii?Q?DWCvaQgBfml2yBj7Pnqp+nMysqq2Lps=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5db8f5f-30cd-4bc8-a330-08da278d36f3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:01:09.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pilsDB/c7tFZdKY+K7aYZczAlY6JeQc8umGfvoaemJV69CNInpxTpbld7ICFg7Dg+IIFJPYobKWjQSnsawFHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816

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

