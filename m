Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DB28E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8U0HX64BWkupqaQLzJsNx1hUYdCp2sxqpQqPmXJKrc=;
	b=hFhsOEtH50YyV8W8kD+5SJFvSETGpoaYvwbFqzL8A+ObhdKOXZdwKRFABPfcq04ejN5W3F
	IP/kNme70IuIOlpMY3b2nZ/jo3dAri+/TD+PRyxyLaAyAaigcm3shOaB5FUPTJ3YNEf/+B
	61hwNHQMUIKbAXYJV5SKeZ6ub3cXVBg=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-RvHA2Ex1MkOuSVMYoums3Q-1; Fri, 25 Mar 2022 17:13:01 +0100
X-MC-Unique: RvHA2Ex1MkOuSVMYoums3Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msDpxZqNYJEp4JXSmg0n8cps4St/9a18Hu05C7Q02zyJW6y5bzWijc/Y2nLU2MnycnwuAZtaUcNgZjV7W7Ounn6D4izq798srmjCgfBUZrgleM4sWbATnrZisb6dHMSJ/hg5+uuZ/OX31aENIgQrgKe/j8JtoZnp20rqTQ7yOY1ntvwRXiRGugkDlr4Bmx2IlCjRNAbDCayPb7vVYf1gfC6BG/F50/bvXpdTkRX/TK7axzdDFK/gakH3kcKVVUnD6xR2mqFQhJqofkxrh/HEGhPmUFm6CBJfqRiyuS2pX9X7Xj0WHv7lY6McoiypzJXfAwNRmTvmOCqJgfnOs7Jhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbRje2DlHQVD/gGd8aoWkn7Gb3gDmA9ITECUAWaxlb4=;
 b=obeEIyVQebl85+Zi2tldOA7ClwaXUJ8YjdDzlxXjcU4apqnFZXTNgQSLk9aMT4k/woBwYr4NBkkr7k78VXxMWP/d7pQRY/YIlThpIVEIjdWMxRNSNoUKjuikW6lO7KwwXA+D7A6vsL3bz4kXWth8idQQMojr4dTATgAApyS5l+XyrOE+wFbB8qxSE/NDyDKZWOAZVEIGpkH58MdHqnPymQO8oTXzxtjmIxvFJ0q5c9puiM2LuBLGl5t5gf2mRPuU+QzsZfD+CqkCQwpO13BMs7bLyS5MspsOdGESyUJoQD/rU404ojDMgKnmbU+cPu0zhw9W14ky3ubNx0NykloixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:13:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:13:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 3/8] mptcp: add a new sysctl scheduler
Date: Sat, 26 Mar 2022 00:11:59 +0800
Message-ID: <e68cb1d2155f265aebd8de1b7763effd62515458.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648223504.git.geliang.tang@suse.com>
References: <cover.1648223504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7e289ce-3352-488c-76d4-08da0e7a54f7
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3938D47EF0A3A5B02B889884F81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zI0dIf4aS7j/eVdyPCO3S8VJKIiOuuwlW0PbQGHJBjSR9BOx2/IoxhX0Ayte/LSk1apcSZDn1LdRUztQ2x05aWIaCXJKIvBkCOIS6hGzvYoAxHuQCjygGA2fkFGRxx/ewpW7ZN/g/KKPgPH+DqURzVIlKic7AxMZlXEV17FDRTbIvQY1autX0lgWMtD/5sPJIVc79NnokSy4fRtZ+lAYV2xfZZuJMlhyL+wgyPDvDH9cb1BUVC3XJuOij+bvD4mjxDSauyPSXgv/Fqj0s2NrX+C5QsDZ+Gm8xZCzO3yD+YZ+9ZReF2psoeg5tkyqNuW9REXGloN6NG+6TRpq3XE3x9ruBXFqrCMSEqg+VtcRFPUf5jxYcni/J6FLmlHX0mSsYWkOtNlKQZYpYQyh3Ooaq1JFDcjvYj+nQh+noZN7cLwz4mdZmLsVeHU/xuxgnyhxFtGGbZtif2c+FuOJ14vdi9tqB378YwILqShaOlRQvqHakAgdEkXUyO5QoeB9e6M7ZlsH3ZQHHSlc8eEfwMEz/HLLpowlVnp90cNVGnN9GqTLv5o+xyDwBjHWHg+yKemGdtnchLKsbOH0emmmH/KA8tkSJXnc9Vb6ZOoIhJ4kKIRnFuVZiuTRbMRXR/CsryPKQogVhCD+10mo45mUOYUwO9rR1c3sIDrlN+tWo6igXpdxhZs3QyL0Hxwkj9+v/RHz89J7yLzLC0iQ7tCN/7n8MA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(2616005)(86362001)(6486002)(6512007)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TWSUP1PKw02f8EfipljJyEWQwiVsDMByyenvtyGsOAnPsDXwYI3A79wInv5z?=
 =?us-ascii?Q?buPGnRzyWmtOcJepiKUC7uBNMDnqKrYhQtgBX58jZtPUH4urkdMEQoK+gsIl?=
 =?us-ascii?Q?H90tizqRYJs+24DYAWQm8HE2kJC1XoGywt5rmTYml0gNyBpbrZC6bpbG9Ldi?=
 =?us-ascii?Q?X5p+QpbAzgdtZsbNNo/bz6ul3B2+Yy/a8lzrUB4BNegyYgZ/Ths19CFQRBit?=
 =?us-ascii?Q?yRLBXq3AZzizjB3h/1wfTmDZXht4/K0lkeFhlJ/umgOvJz7Shd2qGL/w1fkh?=
 =?us-ascii?Q?IRpS5TPp81KHj30Joc6AW/UrO5tpJQXWt6XoHJWun6JXTEBW3SrJx991tgMs?=
 =?us-ascii?Q?wLGo5deayJjer+g3dmjHBdL0By2mUWPRNAbN2xsNzatkFxkqoDdZaFNYshYq?=
 =?us-ascii?Q?ynjDcGymmTF3Ga2vpVuJEDg640kzowx/x6iPydTPjO7a1TzvHgFgrpoLfAJV?=
 =?us-ascii?Q?IEPTIsgFpTU3ayDWZrNwTKYzMdbXc8LLwmSofbE1wD5dOq3IChIyqu60j0WX?=
 =?us-ascii?Q?wid6XtqsWVv9qeexC/QgBexHs8Q4raYwyo+AsqKVIG5DYVNnhwJ2dbArpikn?=
 =?us-ascii?Q?G+R+zqxdkqsG9dnV1jHJi5gTfLCEkb7yJDpB9Fp633byJdqw33jYEcDm9FU+?=
 =?us-ascii?Q?gA7G7zkA14BOTQTtmC5z8tYLjnyv9g7JSlNYk4QbziDQ8jzteJmc9eW7IyEL?=
 =?us-ascii?Q?voIFuEhAmW46f3GVxMIuHnq3IYt3n7+AuPMrIMnceXTBYOMj5NxhmLSUPEMy?=
 =?us-ascii?Q?NE8NLKkRR3aKVfNwY+yt1ViAmDqRhprv9XxSwZmCw98QobIibCQ4PfRpZX8x?=
 =?us-ascii?Q?fHfaMoyJUFMsx/K52L10VwSqybLniNHxZILOwYcbzkapnrSz+MQmJWBUuW4j?=
 =?us-ascii?Q?c8S9XeRVz7FROK/Ewy/Ktmi34XX3zXOd+Eod/fHTzE7NvzkAYoWq30sy68gw?=
 =?us-ascii?Q?Q8knnbkDVUyGCW0emmrRuGAgz2OxKIOTZZzgQpE7v3Br/s42+y79zgui8Nef?=
 =?us-ascii?Q?MIzMlOCFpgpetRlwbEO8C3AvERjbLhdhORe+dEwICVpCjZJX9e/AvBleswBh?=
 =?us-ascii?Q?2gaGivunbfQa35LUouHdhFnP1vn+VZD9He2+t4O8DiXIoNYRWtMtT5n5ReE7?=
 =?us-ascii?Q?/hYlHiymGqjNcsG4qCEoKhG/rFE3bN6OXIUZxGWtlu4+CMhJOQwlkT/rSXky?=
 =?us-ascii?Q?vQEQszsG/PGnX26d4MW+oIonO+aX8R+ew8pq2MFJnoCsUcs6c8I7OUBmtPij?=
 =?us-ascii?Q?k/mTvVufdITj14/ADFK3lYZr9jiSX9kkOkGMpgJztrxtN4fvD3upNQ0k6h26?=
 =?us-ascii?Q?WkxkId5ZLL0EgZuvCTGt+Ou1As7lMfdPL/45XBirSNo7FR/I4a5t8sm3LS+3?=
 =?us-ascii?Q?PXwuniF8cG2MUdTn1BxRH5fC73M07k+KZWbVkPsueVaZ6n8G2v7Spt66DslW?=
 =?us-ascii?Q?sfPbZxTHu+vgqMZ3gf+Tln1oyt4yODE4Ts9e6wlPnaA8mH+QYqCZB+wYHACx?=
 =?us-ascii?Q?GhNtJBUMRxYKJwALOie9ewuJfnep1Bt2poqsTXqPYm/8bj1dxOAPYpKCKQm5?=
 =?us-ascii?Q?r8+nk8EbEajLf64tz1FrRH7mz9oFVhB8x2uARBDfat8w7/w16tnATTzpUOas?=
 =?us-ascii?Q?Cm0IJ9A3BtY3Cczj7676Wcd4rA+x4eKP2ma9R0ZGwpD/u2pcTE9cXRmk79Mt?=
 =?us-ascii?Q?6LlhyoF7sC/M6GIsjX/um+62wY3aW/FLN7Lfb6mMGZ/Dl8D94PyzBeq3fjgP?=
 =?us-ascii?Q?Yza3cM0vzLQdRAE9L5+5Axe74hn2FEE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e289ce-3352-488c-76d4-08da0e7a54f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:13:00.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFL/gnQIDjwu4UtqFEWEAr3/fmKGX7szyCl9B8s6whXeXULCEqT+M0Vv3p3rmpGp+rjr1iRd+Jnm8lk3WUBuxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

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
index 0a409b28e237..9ad7d83767fa 100644
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

