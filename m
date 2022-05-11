Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C315B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNw6Z2XuNa3NUByUXk4xw3jn5EgSKzAkowrNy+Viams=;
	b=lGXugAxYSLHJ2oeECrj+Lo4GDDf4hPd4RhkfuXFoio0J/p1manvWTGnPbIugaHhZqZsGbX
	bVRC1CJxWs09xQxp3NidUWPWtzBWqn0jpZaf5dmlPxjMlGjj+vVwpA4/Jp67EINsFYDB6v
	51BAq+1EO2QvUShcK4y4fNWDuDraNO4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-VJpCgwFdPG-qQxtBjowPcw-1; Wed, 11 May 2022 09:57:24 +0200
X-MC-Unique: VJpCgwFdPG-qQxtBjowPcw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPChE4S9qp//r2+G+b8OxCv4AeYmjjAMIvJoVTNIspRP7CcwAtGGqfpaAReV0S4RPO7Avm0GeMvhO/+W8cqlhUya1ZkbIxGVRKaDqRN0viMwBf/dzTuV83Juil/JaAKT8hG7kXQWjTHojsUr5zW8bfBxSVqzQbddsugKmQ1fx5g5ab1s7CM0alh8dj2wc/62ITqkeoaF0qk/Ie1b8RWPjmydOfipITMO20XmZsST4d4XraHoXquRyFrimChNUIK77HGpmZpWvFYxB+iUwsaL6Yyg+FOBdNXnygdH6iyW9rRO9leGoYauze1xIdBko8leuo8Co5db/2n0KbXhDVGmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgVHXz8c0FkJs+CAoq6vFRlqNbJHmy3lfrT7rz2d/ZQ=;
 b=c9fR08qm8acXcdqSHbGyGW6mn1qQKOi6ucHH3QzmulnP0oMefG4syuDm3eax9SnNBEAqBIYNhu6ufsXOzhHsmM8/A/xxDA/wAJ90oSWTFwchTge9gPuqc9RmnihwfaznrK2T6PT2OZbNDdWx5tEsAK5pVoNTCKU5VfhgBmkaFVbbpi9HMgnBMtTKc/jI2UrpwpD7DPwMSekqgK9XZfzorgpdAxma9qRe69V2cC0k9jHwghgDxqbrlcBV65q2vzTsZ2WX9jX//8Ba6Nk9tgyjYmlWpk2KpKBtm80udauem6cqanh1ozBC/GRyekJv3hNEzzqKf4Lj1QteGm2Od4m5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB6169.eurprd04.prod.outlook.com (2603:10a6:10:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:57:21 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 09/14] mptcp: add a new sysctl scheduler
Date: Wed, 11 May 2022 15:56:15 +0800
Message-ID: <7b4cd095352f764e97827e1c845d472e0b4f7a5b.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb5775e-9f13-4872-7ac4-08da3323e0bf
X-MS-TrafficTypeDiagnostic: DBBPR04MB6169:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB6169E47EEC4EDB1675C6C989F8C89@DBBPR04MB6169.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l6ozU2sA8ur6HzPTL1vbI/gZNnXuSPb/dnvKoX23mg8QJu8KQsaoJVzBRV7vfxaRhx24RMHI6IiHGdHgQmskFkCPYGKO8nmRQopDW9a99FErHbCLKhv0n0cSmk4UU3aMHl/Grz8f3UyWWF69X8Szk24KLUIBJEfW0VJrq2dsOxxpaOiNVp6VmBSfyuxJpYLBYEgbhGtc+OH/OoFiU21KJ52V1QIOw4qTzpg3GZu+B+g/IICNblbWOE51GhmlUzLPzIUOjI+tGwDn67EitNqlRQRmNklhKjqyjh8A5bhIf1bAgSo9mGJmQdmSW3xdlvmZnGKb5HZlmO6bFYP1YhI/fIUjsGRaMXTT3PetVDPNPa07yAWYO8pv7u/SBZtb7BQeAbkKvMPyeolI5QrCT12bkJfXB52ihfOt/JJTMMoagZPP21uic59UqrDn2jR3+jZqCjI0GT4onOvmtk5hrh4q+AIY4kWnmKbWvMSbutHb5ss8kOtbuTiOuFEbn5hJYbkyserBl+s8s0DkFquOTJdj02bva8Ui8ssYXbcdzwLvj27TXsnUeFjssDFrm8k+9LuWAjYcrHB+m3ebLFOcDTqdysLj8uiH7uCjSEFcgklCsqPcmzJKYjguDni5cwC3DdtF7fCnCT1xny4+wi66YBoWqkW3N8LHStYWz0wpHnNu8X6bWrDDLN+6WAMW9CYTH9Px5i+ctkbHeO+OhRhLevVKiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(186003)(5660300002)(8936002)(6916009)(44832011)(54906003)(26005)(6512007)(66556008)(316002)(86362001)(2616005)(4326008)(8676002)(66476007)(6666004)(6506007)(36756003)(6486002)(2906002)(38100700002)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ejejxRcMH0EqZrSaQJ+7hh5DiwmkFArTGovkZNIV1FvEaLaYgiWuUo+SsP8U?=
 =?us-ascii?Q?dv92wtVOrVKhi6k5+YqytKJQMsQkAYfVErhFXBp6dDeCoSkC9aKUe3TusSHw?=
 =?us-ascii?Q?x4GKgEQUmjLzKkmNgDzeh3XZrHdwU5N2fXA59NzNwwOhUp4+9UbS7VbfDCGU?=
 =?us-ascii?Q?UGURxzHGDKzaQEeXV9M8j/aFjFTrr2Ll31c/bxi4Nja1XTKEVl5xjUa3KLL4?=
 =?us-ascii?Q?xylRPw8TphH/73wvbBuj/wFFWXGGkZY0iPO83YGhyL1zLtbKKOBzcWi/pFhA?=
 =?us-ascii?Q?s+xy/wr18/k6IYo+W0yu+3WX6cy2nC/J4ph8/8WTcFpbWuqDT+03gEwaNoc0?=
 =?us-ascii?Q?Cobcwomr50dyIwFdZ5QoZD5LzEhg9EAUeSsluRu+Jr9Msoxkwutk7pH6poW7?=
 =?us-ascii?Q?KZPQe+0Lg6okBCvtXs+lzFQSvVbzFBQ/e34N4wHA+VtopHDEglShSYZwXwm2?=
 =?us-ascii?Q?AA6N6ZTiFL2htmO06JipwhtZTe4gtZmFRNubMdoeBO4v1sDQtHul+rbmdLdC?=
 =?us-ascii?Q?RLhHZ2rzZavSNqXHUGO81/ryO2pARGzwkZ0xDPGuhGiK3izXRrFftlmIcuLu?=
 =?us-ascii?Q?+6Rcgrf+bTMrPtJW6zPed+3X+qd+pOoX1T7/3kZGi1WJpJ/+Y6dR68Bqb2cW?=
 =?us-ascii?Q?n13AZ8Zgv/1QNowS2e5gK8Ji9N/BweYcjoFZxvFXr3x8apx5dZ1Tdgp0NXcp?=
 =?us-ascii?Q?EWWju/lJxFynD5wYTldL3QB6z2v+0RSgMYmqnrVwZuAyPnsk096sUvLN4rT9?=
 =?us-ascii?Q?X2TxYg7SZS6iaFZ+TRwr1ik7rgU5zXpkaLOQ51CP0ti36ezvk7eToLZQUYRX?=
 =?us-ascii?Q?RVl0WyRfmkfLHC1T3WjtnwNPLHlUDQWjTc/bCTYyslzhYlPg1aKvEzHdJKG8?=
 =?us-ascii?Q?bDNv0ZCmS70v50A/kjI4DUCbIz2ehOpmS8CWZTTtVHLM1mfom4p9Y+gRCU/4?=
 =?us-ascii?Q?UkSAUMVvirzJ/Fzj1qjt7IDeszE9mgvbjNWX1ZfnLPwiA8pQNJeMmQ5eljiz?=
 =?us-ascii?Q?5JbPG2cULP5OI1co5FfNhmej5kTyEWcG9QuETaMdNVEi1PcOnzRNC4j6snWC?=
 =?us-ascii?Q?HKs/NvusPPHjdgwL0wKTW4aRAXKmdkE0dXh/NywpBC2cuKut6suu4PYzl4Tp?=
 =?us-ascii?Q?MDXTDeWvmvdAheTJin9ZvmcsX5xnAfrLclukWV22bFdDUEKn8HbVku9uRStj?=
 =?us-ascii?Q?60lGOI8sRpdltyDNmw00JxweBaEGR4q/PeJpFVxsDKwnXV321te8OAZAqnWN?=
 =?us-ascii?Q?lQN8ScnpzLDwoAg01c18Wt/V+AgPLfaYvxM/5GkT0YTex6L0E9Jpp//EAnm+?=
 =?us-ascii?Q?pNNXC6Auffk5GsgNZwTxjHmIRmGRzgxFe6j1EDYzyq3nfR0j5IBiPZrecP7B?=
 =?us-ascii?Q?3/g1JwphK+fTxkyCRZC4duHUkBG2yfOBSrXmI0t667lNwGS2V+tGfH687P5C?=
 =?us-ascii?Q?Nfa73LykaPQYGvUQ/YMUPALzOuFyRSxcZC/+E1vzydk0KCxr/GLzK/7BUDU2?=
 =?us-ascii?Q?7pHYOu8w59fJ2u2xR6/1qVmxAuVrDBriLJcHIOMKy+zWEvHZxRNy2jskZvvL?=
 =?us-ascii?Q?p4zmzx4a0duL313vZR/72ZAQryinu9Txz3DpQBoE2Z71kWFWqwUu3McPcOQk?=
 =?us-ascii?Q?7SZacVZypxLRTxmPZ52g45exXUz1NUJd3FyyZMheD94Gk4GhQd/bOIQkNmAa?=
 =?us-ascii?Q?/n1wn6SR3jKZS0f1JRp2fIkAbBt10XCn+K6EKfzgp3O9yh6+/EqaVOwzdjuu?=
 =?us-ascii?Q?IFugPQ0Lal/+n+yjzhjVf/epksBxwmA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb5775e-9f13-4872-7ac4-08da3323e0bf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:21.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkWZ3+ig0u+9BIN84Eyfy/12CvaZNThxENEZfwCNL/HcdWg7Svv+O8tXLoMlQRz4gHpg803jSP+mybX13L20ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6169

This patch adds a new sysctl, named scheduler, to support for selection
of different schedulers. Export mptcp_get_scheduler helper to get this
sysctl.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
index 2f6c4486a009..b52cef5fdd9c 100644
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

