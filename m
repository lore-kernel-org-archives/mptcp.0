Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A01391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cmco0Wf5WwlkecFY216c55rUILEoL6PdNmsEyA5BVNo=;
	b=mw58u+jthuHi2EDjD4+pmtNUQq2ndbET00ZUB4RifKn2aWT41LtLmMVTF2ZshQ2jyZdq4n
	I5m9dwh4nuRwPyeDDafy/BOJLF/hCGmNe4Y3zy/VbDH4hEyS7afTfCZHPaKlSP/bBLhewo
	BgKjSrSXd3YGsaIf0wp55CS9OMMIBXA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-HqoYsrABORCFKiTZE8BhyQ-1; Wed, 23 Mar 2022 10:29:29 +0100
X-MC-Unique: HqoYsrABORCFKiTZE8BhyQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOs8We+pdA0dGiWF0/3yci/TAHVqxMxy3OxsHkEtclCevDruJ5tOYoB93mly/iQ/TMaaEM8BmzyFF93VCK8i6mhQlzdow04/GrpkN0EAT0zG0a1wvau0CxG98f+R0toQ/czt48uBA1A6C17hYA5CUTHS2neNW73O4bkuOclXfotCT+tGneCsEEW6HnYERaIpemvOCC8lmHfNxbkwBAEPZSDT2R73q7lVhGCcqz+B7cptG6qLIwTPaBam50g7uwIDgbyltdzDrPmFt57IXjlyCsaoEKLdpSvpzZdQ0sQosum8iwbzMo9l5/jd50dsuUYZI5RWHvv9VmZN+WjqcZCXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6N+1O3G/c58JzyM6TMxTD6ZtLo1hWUkOLFTflrItr0=;
 b=ebmdEqs+X+OHmTllsHQSYqAyxSTWlh9XrFaY/YfIeDV7zPgPcso9Lpriy2KqQBmXnVKuUNG+KCDYOrzvefZggzA857tzxEywMPE9trGFGX/cWL+AdyJUCbt/DFUsIoDUKJE7ZDD1v4vmGNpXi4fLWi8az5ORGBrILq9NDdJFVXDPmpyw4huujrCHTAB43+iGSQE+Woc7QBxrNB4vd92mt+NFWD/oMxebCrgB2NLWtqF3V/SV8tENhaXSXJUzg8ACXQvXbJaQI2r9Wg05i2bCUof/ihebjpXyYL/ReyfSZVrXOTXv5KoHsQiI2LkRBa2vIq17z3/IgWcf5DVn4W9jtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6733.eurprd04.prod.outlook.com (2603:10a6:803:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/8] mptcp: add a new sysctl scheduler
Date: Wed, 23 Mar 2022 17:29:02 +0800
Message-ID: <05ba880230a93bc157687f540d725cea56fe4560.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648026806.git.geliang.tang@suse.com>
References: <cover.1648026806.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522dbbea-a3c0-47f3-99e9-08da0caf9ffa
X-MS-TrafficTypeDiagnostic: VE1PR04MB6733:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB6733531AE40DF229F87E9337F8189@VE1PR04MB6733.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	krtPsyTtmlHauKmsGVYqOIhyXrfOskLt8nUl+I59kfKZf2UHrimxK1qmEpUSFAzfOG2MeJoZ897ANoqoK2n1tcuOH/049iSBFvDVRFkVUPEFMXkGvk32rQZeK/WRVoS+VA3ryY86wbi+DicEhukh76L6jNsCfSVrw1bY8H42dONCJM2VC1b0Ci/Pc5eM63Dl2woM3adiz39uJKzJC1mo7eCP9ZcB/FPGwQ7eptQFGTOfRPrB4Omiw1JMV2Ssxy1XivWnGIlWzzeJEUp71Y9qe3S2pi0P/66sGwhN9NKBl7MT25ed+YCpamgMPNT44SMhcX76bV0scHTcOlJiShk2+7VDmbgqAhhBgaC/WgxjVeXY/d73boGIchz/02J7/tTH7eXV8L91oWu+n+U4jNXYAhaILo9sY3niWUq4Ea1T+NNRfJ/bowHIqVx/W7qhRz5mSwM69OwwQZDNwIwsBHzfSVaOnEulW1UVYsQPYsofTCB2DZR/cqhEgGiptROV4GXK2XcomggJ05GJD/UYMhLnPqvRtGE9VHKeXcwMBR+P0We6PV2uU+28+9VCpseJ0zTV2w5wGqemsRs7jHZIq4YzAzmwBbOi13CdpIxPk38yyRsiRfW+jyX+aXlE8KrFRWOcHV42icyvEfxMpZPseDmJuHqHkAPj0DjIZwXjzSOqhsfMJsgYK+HaqtsnKoHYTurZymrbdeeow7a9DeCWEuoYVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(508600001)(8936002)(2906002)(38100700002)(6916009)(2616005)(316002)(26005)(186003)(6666004)(107886003)(44832011)(66556008)(66476007)(66946007)(8676002)(4326008)(5660300002)(86362001)(6506007)(6486002)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7uRYdb4Tf/g5oIxTCq6MdJ+Qr3D9CmnUo7L+Vl+caPwGNsD8z8nVesLpL+/k?=
 =?us-ascii?Q?t6Mh0nRIFVmVudgENycsgD9BOhM7hZFi3V2YcuYxs53vKjio1g7YsQHjPMVp?=
 =?us-ascii?Q?Fsbj4gDh7w+8SjuVuJ+TYQHjNrl9E2Ufutd4Cl8gcXSZur8MNE9zrwDkXK6H?=
 =?us-ascii?Q?6Q7BoR0qjWDnpSK2GjHN1G3JvbItK66pUoe8mwK5YBZj93mv3z38ptXDAGLR?=
 =?us-ascii?Q?bCcL0pBD9/BeeQC19zwrTK6wWDyhKfoqeDQ/4cJryZZkRDH5Gl5hMVWBNSY4?=
 =?us-ascii?Q?VnQcH6Md6c+8e1TtBXUuxcb2wCZYmNex3/T4JoKXAhM76pBDjKz4q+NviSmZ?=
 =?us-ascii?Q?P1b6n4o5bO2GLpgiizchjAnpUDX5OZg54lkuTb5vgTWYbKSwOzja0gWfkn5e?=
 =?us-ascii?Q?Zn3aKuXme/eupCldVZN79pfX9Iv5K5TFQTI3VdQbx4wEm7u4SXj8uOfqjcb1?=
 =?us-ascii?Q?u9QArfoiwMvlszuJbRWTMd8q2CzJ41rqJ4wW8OSEmcKs3OsR8v9XQcxl0Rhg?=
 =?us-ascii?Q?8xUILB7dWybZy6/Sqj3ErWBxUpBylwkJYU86kKYWYx/pO+yQZNTW51N6Phk9?=
 =?us-ascii?Q?dEJnjiVxf3cEdHsKu6sfL77jfmfVFpXkDOJRJ0U2H3zXDwVZd3LsXGgypZ3W?=
 =?us-ascii?Q?L1jVStjP9iNjf1CcHcgRcIHB16P9NuoQTBdxwrHku2ef+/O6OgXMg2Y5nMNR?=
 =?us-ascii?Q?OzAXkRaAqUCPKHXHCcJwI36M7tjvCAEYm5cLvCL247LZ7TqiQTX8c+S2SsiC?=
 =?us-ascii?Q?h6hChH14e7o3AtxaRYqM1ajefi7Cqm3uJicUm5LgZou/6h9W7DO4VxL7P1ur?=
 =?us-ascii?Q?sS9i+n9aGC0j1V15mgOMOH4v+kI6UpKJYBCqGREQFjl+Ds3Qgjxadl3T/hhC?=
 =?us-ascii?Q?HCI71rTER7kzfL4KPqLtnbKb9EVLe4HLSS8v/nKurFT+E4ee2FBarxB8MzBo?=
 =?us-ascii?Q?s4VOh2S/XzhURgXYQISoLr2GF9jPF46RkKNAmUIub/jus8q9gsG9PYxQWtoQ?=
 =?us-ascii?Q?MI4H8M/aoK00QCbiUDiIF/+Z2b4HYbhw/FJwYQrDN7Z/QiPgCclUK04s2ul9?=
 =?us-ascii?Q?OFRG1LvqrW1LM3rBmrATo33Cbo2DRU+rH0WPd15U+RaG8ZmoRVGLq+qK6Yi2?=
 =?us-ascii?Q?fKe3DaS3jb3vqgP8Gn9KaBu9VxK6gj8nHS0hOakFaNYYUkorWFkm6gLolZhz?=
 =?us-ascii?Q?1+yJDtz6eyQF6i1UAgXvE+bmdDsuLrZGCEYJ8amUI/ARqAvzGiySpsiqIUP6?=
 =?us-ascii?Q?oXLzvNExHqipx+tRohLinjZgdBisVEO9Fu7lzZr+jbiLf347mTFDWSGHuNNo?=
 =?us-ascii?Q?od71MN0T0+V2wrzAE5zsgb1beo1xz0NJGw3ZuZGAC9wj4mRddi2Q6U9mLhNy?=
 =?us-ascii?Q?yo5tZnWpNNy/t03vAJcldXboHoCrebEM1+6XtfRILbwqNksyK0dF0tmaqj7Q?=
 =?us-ascii?Q?dVg0jwsnQDMj+ZLpHAjQfQ0ngvrBjtKJEMLZ34jboO8r/fn5MbTWCw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522dbbea-a3c0-47f3-99e9-08da0caf9ffa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:27.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3sR8iAKCGlyJ7VtAFGhLpLKQd3LJyCbtmOYQPwImn5lEZ7rpSEB8kdmpV4fqhMNGr+GMDwxlCFwcGNEI/zkiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6733

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
index 85642ba3354c..ffe7e551ac84 100644
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

