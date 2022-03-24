Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06C1FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648130968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCoV0d/uRHww6crhG09bqvST49mrP6A/tZlk6axI9Y4=;
	b=cjml0ArIvUn5AbKM8lK/oK/woDicuyHcCaQb9ob4ipisq+6hP4iNJ1qpZ26fyJ+2BbQufx
	VH6e6RecYk6BCXJ3zHYpeaTxQN0iKz0fOqhNz8C19x58nIDOb0CLiLkSpZiDjXc5pYkR3F
	GqVD4TLltPfzWNLN9+IJRqpjp617HV0=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-dKOO2KLHOoW2OhAmCEACrA-1; Thu, 24 Mar 2022 15:09:27 +0100
X-MC-Unique: dKOO2KLHOoW2OhAmCEACrA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k14aaEmmPKvG88kcVXK0xScQsko0ksjm0bFiEXnw44uS2W1dUr4hcvZzK06aS6YaPDciaA9PGWztfFZ5qPTYDrIxmkxUDLP+lbcdDcvOy5/K2iUdJ+On1sSNNmPuxb6Yg4d70tI6HO5LLyw+wQiM97n+OtjUKKtvZMK9xd4KcOnDl/QGHPEFFsLdgWx8XECoDxJzMzltm8wnOxyBUk6LLZXATieUAtUkd/N8BnukQZrAhSGLXF/8GLxm6HwK/s+bvcwnEH8CgvlUkICNTmVxUGbpq2MCwprjyyAWgV7ZAsxU6BoleTdudJCWXnlPSjFT8MBdtydeUrQ+jy6QaxVe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFXUxJY7bMLbS4I9DPdfMKmzwZVVyVW9iKmKqjjSxdo=;
 b=Qyw4lcnZzlNkqZSiKhSxZTM8oLqIgB0D4UjkRYJS7Q1h4XDZTvkR4D3c70Bu1DC5vfMZOeJiFg4VeYMVYkAVCJDjpp1ioUSh2zfHGLECkH3En2I9u3q+VSP63D4+vDnTJyYLclQOHYyxcj2YO/c3qAhmbpfxVOIQVCmpY+OHWlo6egmkvxxbL1Gui84cfVXazPb9+bF3GDc8CfvejA/nMb4jciklUDwD4Csl5x4l0iH6b0OpuKafoOMZj6OP4Bd4kNAtC00i8lSJ5CH5TlFB7o0dF1iDRMeToqzEIHjNm+d1fMH0hly/FR3U/lHfEtzS3VWRO7OPTKKKPOi9R3yuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3616.eurprd04.prod.outlook.com (2603:10a6:803:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 14:09:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:09:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 3/8] mptcp: add a new sysctl scheduler
Date: Thu, 24 Mar 2022 22:09:05 +0800
Message-ID: <652eaee7a675ab667b945a3ea0813085f1921b48.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f7413dd-c9c7-487c-fc46-08da0d9fe72e
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3616:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB36166F2F98F191917741D0D6F8199@VI1PR0402MB3616.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EqYArvUsQCqM8lEARHL+vzuWhe6d8P9Lf2lvLJ7X7pOE5Xx+gtFsCOvGSGC/R9ceFhMIrlJRVTpYK52YaQ8yMCjVYiPyyfsLGP4sD4S3c8xhyNsA6ZyjkavGtHpkWF5nOs6QVV4etaYf9FBDosGprjWgb8U2qYsw5bCNKqRImPu5sgqH+mPDzD5l9LztGSMWRIKZxt9k89TiAZB2VLyiUcfngJi4N07rzrSg89haiZfHM3lhiUZHU45OTxYpS6SH8SF8sdDRrK2IJslxfoidhkSawWHqXeIzQjboY7qb+62RMybmgWm+S9bXF1gwPEFW9FFOQOdZ9Sz1fN6BSoojKFsb+EtBIyPXmLD45Z2x+oU5aeVxVLR42zD5/tO3U21dDxm7o5TyxBtDVSebLjPRD10UyeV+nZKny0D4Fz0KEpmcREfGXtLfPr5osSi2+NihOaaRegAotSK0oRVlP8/ZsC4GdiKN1Z5xwwRPcRV7l4U7FplV0z10+z0shy2jnjuY8PLARgBp5FmaOqbromDfN0MJ0xuz2M4XxflyqiaJB/+TLk7nH2fz8pD3pwcYGGFZFtJr4sz0JUvn4LKoUL0FFxkIpAtB7Y/C5FUIiOns7RhmwR60gdzcYxht2UAu7gPnZjEqKSR0u/bjqr566vJneHU1cwiyWT5gr1ecpqlmeFJwfBQYhcbOyuPG7kCMbO8FXF7tR08yPT74sROnOFxRXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(6512007)(2906002)(8936002)(6666004)(5660300002)(38100700002)(44832011)(186003)(107886003)(2616005)(86362001)(26005)(6916009)(66946007)(66556008)(6486002)(36756003)(8676002)(316002)(4326008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PHgD8mT/Qb/tkMsTgKsAHFWyI6fZYl5D+hDAg2PuxBbBUAfHGpp6wyy7FGtJ?=
 =?us-ascii?Q?NatwvVQjLGcSSoUKOY8l1ZTCG3vI6vSR6Lm06UApmZk8nq8MXbS1Qp2cz2G2?=
 =?us-ascii?Q?g2h96QOIw2reuISvXGnVyPIKv9RUc00DZpfdQMHl2QEd/Rurlt1ICFHn3lFE?=
 =?us-ascii?Q?Jv+sFHibuKy4GVVSrP3siKgXGY1tqxP7OJjUbfawJPSJ+viDH1ZFPBJFOHsF?=
 =?us-ascii?Q?pRM7zpkfYWX9jZbZuy/0MDGsjYaZohQnFx15I2v0iiZh1kAEyVcP15LJGGGc?=
 =?us-ascii?Q?WAefIwAOOSsl1Md0Y6KqsWFZ63Jg939y0q9A29/yjJRlozq5MipyjO6s6y6E?=
 =?us-ascii?Q?bn0QR1gvwg+VIyHH4rF/EH2kBQGDqGV2af6Yi6dCcOFp4M98aDUue+aOaNvP?=
 =?us-ascii?Q?PJYORUkNeQFl4kd3fGyFMd/kctCqhP+Blwbf63FH8L+m4au83rhlFEWWz1hm?=
 =?us-ascii?Q?NiWTn0RGqNbF7aYSKIOfP28VMM+pVmVEho3KIoFjf7KHdOLICkXMWD7jSIyY?=
 =?us-ascii?Q?9hgzilkHnD1X2qaHiP1zv5/jQktaA3P+9yWK/8j1pS7F+73rbn4HFULW/JQ/?=
 =?us-ascii?Q?GDfSiItt//YcLp2J1BML2K9699R90NfVdryB3p4VFRus3SoKlmQVdM9zIJF1?=
 =?us-ascii?Q?X55mHJBvIXLkewtyuS6AUmWUtmVVyPS/YmOpkafaJjjPH03Q5XTg7bAsulZI?=
 =?us-ascii?Q?6KTD1SsUDH6DIFgHRWbqa+6O239Z4H4bzi78Pu79x6X60NRsUeptQd1D2kfl?=
 =?us-ascii?Q?s1Qc/C0v/J8+B/6Xmlkn5jqWUtA9QlUxYulb3ozOMXSblnY5YIZFI/laLGKo?=
 =?us-ascii?Q?jcLMSGSa0Q89NMfGeaz0Le60w9z+DUDhvapTrlEx6r3hL/xcwTaMHpZrFUTo?=
 =?us-ascii?Q?69n8/rwD4Er+ZpT9uw/gG677POZahyROJ5KRfeT8huYzsbjqLCf1lzqB4GWo?=
 =?us-ascii?Q?Kt5X1wASaZO0k0xnkVb3XxG6JjjKN4EbxjjoeUBqnDRBmZOTfSTyueregO3x?=
 =?us-ascii?Q?pfrDZU2tt13Xq5o+2Pv8/mRLyZjrP84mDaXTUawMEODakG+Xb9Y5YTB9H8ac?=
 =?us-ascii?Q?FWx11HcTFmLrP8Am+90pj1UL9+gNW5HdNxSiREczGW+Oj0M62gxdR+RHvexT?=
 =?us-ascii?Q?GdmmoN9LpEUbtAnWV8Xw0wjXKl8mxiAXp642xc9UD4Ukr+sy0X3f6X9q1c1J?=
 =?us-ascii?Q?x4VnBkaZZ5ej9e9KDXHFTfdZ/IRvLuvnuE5OpWDfDD01M3O2C5Z7EhiOr1oa?=
 =?us-ascii?Q?7QB8ZgpUfUWK3DWE9PrBU3nFUGlMffaUTpmV3QeLX7+QCrsQSoJCUIdCuBx1?=
 =?us-ascii?Q?nm+Ue+qbbC4n3cWMeqFvb5cfkeWupfQmnZVbTFT0KXey61E0v5RgtFLw+fRG?=
 =?us-ascii?Q?pPC4YgjVPakORN1v8cu1a9wv5jQuOSLvrFjTLPMHm0p98FNjgfNC/Wk9XrPq?=
 =?us-ascii?Q?uzcdkriuWEiWD4XaDOnl112vzTxiq9Ut9rTqV/QcfPZJ1XKc5zgJ0Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7413dd-c9c7-487c-fc46-08da0d9fe72e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:09:25.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mygtYsccp/mPeHivcCf6E+7CPJyR+bdh/AUJ37tHoL5GYqZJwB6gQKc119GY2lkVCi63fTBPC9J4S/rmLNkmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616

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
index 46ac5b4528d5..3e69c1e5600a 100644
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

