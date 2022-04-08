Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A02564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3AFB4xsjzNnvoH9OPwrztlRzwU1PI5qONz9ltyCCKE=;
	b=nPVqbuHGPW801AzyAA5gwerHz6Vvb89hPbHphfOKtUI/kS0EZHdYlhvIw0V2KU1VDJanld
	bgEWlBXno06UobyeyJP+xo5Y6biQifRBJgxAm02xsZJgvXfkjLVQ6OzjwQe4Dop6btzQES
	x3C9/dRU+DuQXQhwWoYMHiYStRgSGu0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-RoDo29USPiKpyMQe4TTTfg-1; Fri, 08 Apr 2022 17:38:30 +0200
X-MC-Unique: RoDo29USPiKpyMQe4TTTfg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTj1/mawc+sOfCX1dLqgV3EwUt6r4xpZPYi+PN/b7KTtBGzeNCliy2jEa4IQRHJdeC4ceFXTHRQ1Zx1LswQGpqoI8fG5OlFehS5dhYu5O0o5bqW512xGKmb7aeHhtz5TkA9wt1J0nwWn+tjo4mr/vobdz0FuipzgqlO+AMd+JrK25N/latJFXUS7gWaMMe0JAPbqZeG9eQxuEzGkULGOBN6TV8S8GbMB0Xg0SKvbGq7TIBOPgIybyXJ3uBYNy5WtBk1Nfae3MIpNYt/rEjTk7XJNsYbGf068vUG2277gLrXbEDBVvrdf9NF7aG8yhSgniuoqG67rtusauxZcgy50OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvVBNx397swhU+imhwC18Bx79bDDL+oLxotL8VyNSIs=;
 b=dhhBy9W6sS+0XWG6T5Sg677rkwXTHyxaXeHVrA3JfN7HHLoEVnju/tRYFfhHWC6cAX1yH9batp5A8JeQAxXhmGp7jQkH4y8iKE2noHZhr7kaOEVJhz8Xsxtz6AXqFTJH9KPd83jeD4fl3d4TwNQ9jjvwsKsQHfN/MxIoTWslVx7ybM8GdJbYEAQD8nro3JL/SAdz+LPVbCncXK+N5OR9YjPqEFOCpfmOUYi3bCObUjFXblIl+DFK0OXxO52vAIVLgjy3x+gBMgOPNMLlQkY4S8p0zypKbCONCRx4Sr+X2XcFCJQF7ZdasfK6MOHdXPPDJ8Z7W2XccIUuYTJGtMOPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:38:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:38:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 3/8] mptcp: add a new sysctl scheduler
Date: Fri,  8 Apr 2022 23:38:00 +0800
Message-ID: <d0c4c8ab47cc6dbfcf1efc65a7d270ee063150ec.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0130.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a30522b-92de-43c3-1485-08da1975d4a3
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2995A6037BDF5E635C20401FF8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BJluIpkMtvhXjMe2kBQJatb8U9RhEXwfYPaWNFQB+33srO5VvZk74D16KC7D6RktSSF5WD/4XRWHPQW6aWlfNzTt4eusQI5W/TMoOO2tBczDcCu2RWX7VZsDUikLeq7zE3fVTRJpQivdHSiIXPZoFZc9bifI9LiBo6W8k6M/SoqDsitorrqGk1F0B8kFKi30jMHQvBOXMckM26HAroHJL6ibvjHK0g6aa3uHTn8fDT3EFRoaxvfUHJDEZaqrSrB3+bKYfjtPP/VYIeqoGk28aAKyoLA+iJyMv/2y0lr+R/GPgPC5rtSy3nYszmlpL7oK9nYTScQzGF46+cm3ITw39/Eu909v97U/DhXkMB0ocJLtiOs+IN61cOYxD6y2catf36kU3t58Zi/rMSkbuemEWd7XjNZMwHEoDR9MmKnNhZKzzDIGOpLmR34UY7t2W6oTW4oofjWRLiYqehyk+0KfmiXFBY3tSnSpDxt6SeJ/FF9X0gYZE6M4PVEOMr1C3Tj3JYbbWmvcjQXGIL8WtsMuWztFfK9sGVT/6wIIDQLSVf9xHdaSAJF5Uk7aT3UD6v1B7MqwVgEVnKTcrL0Z4AUoKEOZ76mIH8FmbfLGpaU984t8jgTl5AFgXRbixB3/J6khkWsCPais+X8KACkhJ2hBl42YnN+l2L7f1jAwwzZ56EAzh8q22aGcCIwb77jj1eb8pTqOMJ7JOko08affy3oXEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(66476007)(6486002)(36756003)(6512007)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pspPVko5iVRviQbWZDBExuBA0nEUfAPTKk0vMK1UcnjU5I9jk7ivNtEklHJO?=
 =?us-ascii?Q?0b0P9D0imOFuKezc5Zq+E0tk7T79XE1EOFpmg3zg8nGoADLWutc0yLoWgMxB?=
 =?us-ascii?Q?oRFyB2buDxUIQWvvmib2ME85tjeAp3ySIYnJcIRKyycUGETWMVoYDe2vH4Zz?=
 =?us-ascii?Q?spAKT09nZ/6Eqlb02mSLpQCxH2hw6gV9SNc5I61INZM8pl4vcB3uonlq51qK?=
 =?us-ascii?Q?J0yGtjA3UIZDIyajz4+/1UGvJaaxHIrctZnPesu5xz1jyJjesNmfFQ+SALFY?=
 =?us-ascii?Q?ZCt7fw8cfhfYk8TGQYVNotCP1Y7cWxnGfbDYvVrMThY5b4IlS4SXD9c6tUby?=
 =?us-ascii?Q?lrypMDttazO5pwX7fPaEv1spSsR+CSBH91Qcactgg1eQUITMuGXZQsDKHDCo?=
 =?us-ascii?Q?DfwAUYChIWlsVrGmPLBViZHeUn62mEMW9+UtJ1lKbMCRFba2lh/saiVfEeN3?=
 =?us-ascii?Q?Ku27XeL7+agx2z+qB/BvVkq+UgI6zD5P/XKbFIkwXVNypvFQmEGu65KQruQd?=
 =?us-ascii?Q?BnnqL8wtd5CB1KiRkVhysu2I3BnIgTJ/5O44bUNv93DKIbB2nET9L5WMXgBt?=
 =?us-ascii?Q?EK7A2ktE7ryZnRDuUZbhStHysMuyf1ciaRKHHP+Sf/Z/HL8bHMiEk62IdCfA?=
 =?us-ascii?Q?cf8GTnWSYwaFeWxgXz58pgDv3L4yYCX8i9fvIIQpnzva3J45M0/fjm/KFA04?=
 =?us-ascii?Q?wcBZVIW5KLYdw9/7FS5LiLow70GDM+uOf2Nrld1/RKTf4X9LeJxh27Sp+v6S?=
 =?us-ascii?Q?Rm1GxB09N/hS0PSoVQhIX5w4AXCfDqafsuQ39BdiJezGDJyytaKw6EH8Q15i?=
 =?us-ascii?Q?NULbftnpHq2wHzYuAKf8T2DmjcM1X0Ctu+ss1zZlfmOyY68AOIqa2YYDnm6E?=
 =?us-ascii?Q?Fyl9GdOkSCD5IyeiNBFZ7QIxn4kwBpxfh00l/VbHkGziQwGzt7Kh7CkBNOV9?=
 =?us-ascii?Q?Mn3Uf+RRF1MPnyf/cE0X9LtzhhoP1meVzdhD/0MyL7dgjd/x9LzCaUqzmgdL?=
 =?us-ascii?Q?I34HZxe18ImZMQQxMRxRE7D9OjWj7CfcpUbYl/V+9xtos5vvsmA9+VTx+5+m?=
 =?us-ascii?Q?YUXIFMKtMSDTt/RsepIruTkwr2g6U6ZF3919m8I1/vyvI+7Oa81XD5aAQxLr?=
 =?us-ascii?Q?9ql4h11wF/D2VVhJ1g0T5LoF4A/do3H5CkY1Sbcl4nhL9JvN4XpOege9xSvw?=
 =?us-ascii?Q?N8I56Iaxuwl4+ribY+kCp4XdoBHwpCMr3O3d9fBOcZHtwQgG5uviK5Wj6EM5?=
 =?us-ascii?Q?I55rsV1o0Yo98tOZAyjKBeNnpCsa1vitw7D9ihd8owTJqK34xs/cds67LbVw?=
 =?us-ascii?Q?Ff4THdicOZsw1cTZ49Ot+hpfzx1Q2ug58SsMNYNuRrfOngyp4WvuiH2/qHbZ?=
 =?us-ascii?Q?V0sUPfdWcfiTVE05M7HRyIW+XuA35Z9ovwvhpgzWOTkRMQcIQ84QpObbEBO0?=
 =?us-ascii?Q?BMQCE2adeofC97NuQ/laIssMwIWi5xusMDBVJDJqDZHDnanxRw2sfS0qK6fk?=
 =?us-ascii?Q?QYWkRtcZdcFA1Tw6ih7RJs/cQd7RFum0DQvAjuD0u0XBlL1mpDDkU2xsr1Up?=
 =?us-ascii?Q?bkZo3vXhLE5+2YDd+3DH48EWXfHi/pR8HJJdwhjzPrrxVprtg6KbE0qquWEM?=
 =?us-ascii?Q?ssyC1ewuOQK0mXCv6wYTRbUI/pg+DelAYjajidEzDHY6UvqwhlW/DJBiNEOf?=
 =?us-ascii?Q?1jUbvpj8SsDbilHDDit5aJSC7H4blstC5GrAdXNQ4fF8GZKIY1Lp3IuHKmHl?=
 =?us-ascii?Q?fL7LAMsvCshYa+guOPcLqCsjDraGbyY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a30522b-92de-43c3-1485-08da1975d4a3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:38:29.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vd+6Hvn61I90aTtFHe8xub9SXoekOVjAjpr2fy+rWArzVCFQ57zA3eafKwncQqXl+KljE/o7MTDBPWA5/9KMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

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
index 9ba37d0b9fcc..213d75a58aa5 100644
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

