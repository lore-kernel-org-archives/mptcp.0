Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF61852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmF9FD2C4ehWhKMe7JQAAc7Dcesv4cn7vpvKdsTPQAs=;
	b=fh4mVwWph/MiSzd85ljs1sYmAU2Zn1tPpL4PaWSacMpI4A6Z725L9Wb+fv4CUZpgIqhxti
	NRrUMnNri0B1QZLrsKXp/9IAJmrTwjcO3yuQO+WLYJjVz2dUBWxhUhn4hzlTAJcmgy+6FD
	FofMjoXSXSeET2kqUQNd4fFHsVbHz3s=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-eERDliXoPVe6Q_YJelUJKw-1; Wed, 18 May 2022 08:12:27 +0200
X-MC-Unique: eERDliXoPVe6Q_YJelUJKw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QC2BKjh+2CToUEn6Ou7D0RX0Ws8P6x40SFx4Dba8zXlFNEPxpiqxgCXXYyDEoMNyD/DdTjjM8kxk+DCSoadLX5l0wk4u3UGb+B7pcSGbVmM08JZ/fJKDm008b1ugmZs9IUaOYySVFxZmiUXMvDw3YpuJC3X5juO0fTMw2MEYsxJKcnuZEOPrbKYtfMkltD7J+gD5/1Ci/2UQyck4ouKsgMPpTziR2O/YGro5kM2EX3asUT+rs3j51If7x0Mzf/ISNTlsxPNf/JrXsXRw1vVFi+LmLMp8xYLiOnrOUis6UGpq+4MTgX3ZYNLYLBhCxDH7EJraXyaw44qmMJSbQ7PqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09nT5rbL6CpHpKwJG0YoGAH0EMQUe75sTEmtwXuqlKU=;
 b=EY5J4NckwjXTynE5bC6lK1NYIUnaBCnIr0B+P1ldnGeXp/at3xHiW8/GW873VAuFJPqhqQNgvnPWwx9wGnfvC7CVWRps5ZrbXKTMfoixnXlsu7Wzi42B4HVNvJoYb+zLRixAxSZiIntvoAyf8JHSibcWwMyTGMJkFgkHXsLUILkbvPML0mDFJbQraR7+O9Qa1lfpkAQQ9h2fbfbccQ4K1pbAs/AVqWYpkJqJ5xycwtCFv+ZNNTJT7s4IC5IhkboXPCX9FmkW+fgvU6kgxy4+QzEFi4OQrZ+zZGUjj7l7MxXqM/SIdWyQpaozIqlQourIy8+q+Kh4UISf+cMhIetxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:12:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:12:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 12/17] mptcp: add a new sysctl scheduler
Date: Wed, 18 May 2022 14:10:50 +0800
Message-ID: <57dc5f15520d771e71005ab213b95028daf4bd5c.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:203:d0::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d47a75be-d3a5-4c9e-9810-08da38956166
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB258430ADA834059C2DC990B9F8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pVjm+A9vWLTMu+efosvKXNctRgWemZ/XjV3Uymuc8niLnEZnXvJnWgqkfxtnvfqe0V49Tw1Po07o6mKW5tnBV1jgb5D4t9zTuCgwat5d+G2ByfBRUQNPG841sbBrgnOPOoacn5eRxo5XD+tscMXiHooOOGeO9mWVTv1PFIy906+f64qm2BozItVpANjKMD5+Mul712mzV+fUIyTWmhsZ2ADAzmef8RdEm7Ub6mxZKSB7shluCgR8iTJ0L0Lus6H+NnWVEBEGaWyaKHZibrljWtGuavhtwxvQaz48MM6+9ss/kUlqsWqrftNssB/drGEAuXcCzfVku+z9af5/k9srEdOxbmMHNHazKDkrf9rLyMxsw8mX6aZuW5o16Ml+AIFjG9M9sXvTMLLK4dpa/st2UAVw3Hdn0mUVqeeskhFvzvEMjug9kK+JqigYnRcqB2f5WsPUA/udXRGBiHkzgOQ6YAp6Syxv7ZhwAcEuMyVjaWqynuMOdTqOhlY+7uJTweorCjvVWsMwjrYjjxXqjYMFbadTOXK8CTJ9i5mI2yWhOwC2GK7hp/sGJ3LWZ0UqrCOzPcDokSR/WxB6ACYwLQ9+lkSHn9pW3ooDuUSdi2k3kiT0xAcTC5pu0Y8biJ384cg1eXS6pOKSj4E1vQdNwKzAqoL7rA1sTrOlWuxSdx7YK7Y06QMq0WVYiIkrwB8RjWJSlSs09jiMuigTgSj2CLDbhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(186003)(6506007)(6916009)(54906003)(6512007)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X6fY/aqu0UtOLuJD+ZVdg7jIpgNF7+uDKUnmhY9KfdDXZVU+huZUeBVZ+xE/?=
 =?us-ascii?Q?t5drwB7WIzkeZeD/9JxAB3DjXirAbUTF28V2xc9P/tvotFXuUuGqMOElIeB3?=
 =?us-ascii?Q?x+1ojWf5vsOq5x0X98vb4Rw/TgxCE+35rUINIj6YJSaFJgs2Yj/2Dczq0q+x?=
 =?us-ascii?Q?nYQs9uOpNtthNCZisHJ9kpTyrycqUzX6PXSnjopH/5+ryV8Zwdtc4ujlspkd?=
 =?us-ascii?Q?9hakEPWI3KAZkphcE3YHvPbuHDHHZ5+6hMlJFU0tIebr1Dfw83Ohq3HN+CAK?=
 =?us-ascii?Q?Es1SZofuJv7O3rtDqhIj7rzy+hSaCQ0RleTJR3NfxvDmp3ohYAtSWbCF6IPm?=
 =?us-ascii?Q?jjYpzduak888GMN//1fs+DbB1sx6OwWscniQeFM9TrC5RsuavDnjWyfOAtTs?=
 =?us-ascii?Q?bRv2UUEKUeQM9rqzK1P6AJUkE/I28FI2jR+vIpPcIaGLabV2Xe6ExrctwBRo?=
 =?us-ascii?Q?TiyyJJFaZFO4pqIotRZMOMpudicvjRObXTVY52D/q+v2kFx+xIQZ02eldi6j?=
 =?us-ascii?Q?nRNJ6qDE0OEmxmBD2tUuiLpVF/c3rMxKPJFtaKBzdhuBjUSuLWjx00L34lBP?=
 =?us-ascii?Q?EoJKS+GYAJzrQyhbjO/Sdyz2DC49K2C2R8pYBMMMi+Rxs3i5VcYEy14qIJ5J?=
 =?us-ascii?Q?wUzJh5mi8IvVa1P+5PtdOOynjAE1ZWzDQEU9ke6DlWAkm+7XKIHEufeyTB0c?=
 =?us-ascii?Q?9EQ3taIW23WStbQsB8vGZV/JsQjmvX0gENrX+81ZDbiU3td0b8YEz5nN5tI/?=
 =?us-ascii?Q?2PzardBxGmlksu8NcN+7Nu9u6l3Ws88m3rMLgGCdj8YAJ3Jj6+mzxZQuOIHf?=
 =?us-ascii?Q?OZ8fRW2seIPe/9cIDCGeSVVsqsaPaD7WTFdwLFGeX0AzQS4eXcC7UYsOQsXF?=
 =?us-ascii?Q?6ieU85oCzkdMFb8WIQ6VAkFLG3oGbhLpkO65FGVkcxvAZyNQNGcOcjT7wx5M?=
 =?us-ascii?Q?zRm+zhnDMLlz5djzqRieIFa2TuzepTEBicSAzjukna1Z1lGfs2LFcYOhwKuw?=
 =?us-ascii?Q?fWN7GdC4xHF1KO8chcUSS3b7evCpQikb1L6Prfr8m6opt5tCPIzWpphdcBrX?=
 =?us-ascii?Q?KYiBXOGLph2krl0zsECFh41Q++YYDOkauezfr59B0iOzowrKRMLmr4fyfWh/?=
 =?us-ascii?Q?o00gOCvrkPjyLdD6XHHj3IkvhChTHLCWSoWmgEApvluEw6a3bl5G0ejk9avV?=
 =?us-ascii?Q?7P76EqwiW9n3WOgPmcKwGQ77Xfy+uq3LpELK5sw7l3IaZ5cThhKHUL3lVA9f?=
 =?us-ascii?Q?9uJpKmlIEuuDFFP2E2XSb0/aGw2KfJMSTjg+UzKGynadUSPYohQn5G35QGar?=
 =?us-ascii?Q?OndGS875BQeoDdc9OiNk4ePk5/QlvFxdFN52xPe9Nbs7bj6lYjA5R1MqYy11?=
 =?us-ascii?Q?OQvXfqA5Xdcq5w18H1DMJFOFQtTiJYkBtBUDI3jU/dOnBcybhi72EHB0VBVx?=
 =?us-ascii?Q?MebeRzQcQNq3nqAg+Nwjwd2r0EYq+b2PTxmHTf59+FVZ1BfCfdREZ8h2ykcF?=
 =?us-ascii?Q?LEtLvEzZVopsfZlPiNmfe6mjBNk6gPGcLXokXJYRlrcWTqnAdaBW4G+7b/9P?=
 =?us-ascii?Q?sPmmcFbuUSN0VbBK53sp/rFghn1Sr+ACH8Hycr9BqxMGPyvoNDT2ZFOsT2Uc?=
 =?us-ascii?Q?8D7SXiYJDBI+2SIXYELJatRWahA3Did2I36nurJlMpvbwVmqvcdSf8NausOH?=
 =?us-ascii?Q?GK0YaJt8iRLQd3+EFSZV1pd+ohabaEJlM+WW4zMSghv9GBxQ3eYH7PPj2aDB?=
 =?us-ascii?Q?UHzmWAKFCyPh67YvFGGYvgGYRXcUtz8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47a75be-d3a5-4c9e-9810-08da38956166
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:12:26.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwBMqBWpGBeDaCRVdV+ceSZmISoBpN5MzDy5ubWcJlu6yyLRkbxoLyinYKMz0T/Oll8W6YO8zFaUomj/Y+Vm4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

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
index 86efc5a6d878..86a5ff5d3fc8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -502,6 +502,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
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

