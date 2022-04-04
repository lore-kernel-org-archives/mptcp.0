Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF023C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqtNdeTbKx05B16qyCBV/WQRsi3qZu6i02p1PT8BtLY=;
	b=RylIw2ohuaP5A/D0Wg04khXpAT7GFkhQ00MPQYZTE6VgWgRpNby7qhA5XBzXi7DBCp14DA
	1cP16jKAummxh8uc+9bp6RJzCWwXhqBqKr3724SZ6hG8lF8W556HI8yJN+hES2KEzv/Z5I
	wkYmfhKg8ZnLC/GXjAX2v23pCLhdIuI=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-c-1kLoMlOvmbHeXJX7NlRQ-1; Mon, 04 Apr 2022 04:10:34 +0200
X-MC-Unique: c-1kLoMlOvmbHeXJX7NlRQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkAr8mMvMtucrYwORjwBI5OM4PY6EhmxgBpDycO7Hr6yHLCyrDf5+F74dq/ZCIBOKjwLK76xejSD1gOuPmKJ64JoBmTkfBo10S4b4wseT8K7KjzNpjUIBqDxHYYx0PUwBYcYcxurmYp7G8Q4rV55+i9a18HcZpgcRG+iOjNMzd2rT8qYESaJnzEBQlboyHeAB9U8affmIkO5/pdyA3M0ihuyA1ZCc78IDycHuifuWr/leempSNyUI1WsyuxOmNDBCw+4E07W49r3zt0wiykULhgZlJAH+EB6soUZ50HZVIRjjjO2XJcuhDkRtG3pC2K6PtuvlqupcEOfFJEa8HE9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjrP1fDKs1mwyLd2rW3BcpPVxO/VBYXmWE9yhmeHxcQ=;
 b=LkbGnl9pn8Mu/7GUEX7bSmJ0CJF0Opt5S4AKtZQeiqUWJkSetFfqX/ZobCHOimAvPBbopnHIjsVk6WcxOuGQSVd4WkkjiRZLKXd55NYLMjB1dUW6wjCXhwhu6plZ2W8RYp7gvOF49c3y23XENvi5xO5mSSxMwCB+dbOAvEmYBBNKaYx+HQuu9oOD1njKMGP0ZIg8U+3mTdGnSROGA+rsvHeLqlfEyZAZNJ89CAf7iGsK0ul31qJoPViAXWlfXSj3gCLm4UZFl+3L0anc/F0kPTnP+2QxbWgijGXTz47LD0zGu5Ao3Hwmqt8rHiVmQP8NGlTPOFiExOUd/ls5ceTXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:10:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:10:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 3/8] mptcp: add a new sysctl scheduler
Date: Mon,  4 Apr 2022 10:09:55 +0800
Message-ID: <89ea2aa8f42ef3bcb80c7e29ba2cd9a334319ff2.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649037838.git.geliang.tang@suse.com>
References: <cover.1649037838.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0016.jpnprd01.prod.outlook.com (2603:1096:404::28)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f50be0c-825e-45f8-a749-08da15e04c8d
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB7189CB102550396872062A05F8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ei78eXbxxoyL8IwohlddVNiTyZIWIOR2FNRxvw0DVn32GSEQ3Y8dAHZWVEICAEyCxsFqOJmR6CIErZ+Awrm7uZ9dnyoKkxje+WZdH8c+WekMiyqR5Q+29xmjOlyMClmVNhItNJx+ZJaslCFXJH087ulz6obavgEMuiRxVYbRrL9ysR66n7rK8BkA7yolVRS3PpsLY0HMv9RpRUZueZu8OiElKvjF7LVtlG8WYW8B4G/kvrmnhBZNWoCuOBUoXU8DxSLLWSkeXfO5p3py7fRohDACJHra/RZBRS+VN0uL5iRtlh12xZQ0HXAWBkDAT6hfAkKqSm/OzZa61s1ApqDyl8Dxl0EelVEI4ybIxum0X8lVBEPhuJwN5ds3CHdjQJbRKhQlTumBZhMuULNg+Y+WpCdjidP3SmyjvVXELCQuuzMaNkyF1E1EKvrO0ECPXlUTyeWfNEwY+Az/o0+70v8IzqLrkLH86y5KuMvWzfhcmXrWHmitvn2uheD10JBpt6Gv2EAuW2ratToBRDDSFUdsUTSSAi22LC1/Jy8oMG4xIuvHu3R1ggIv7BbWeUh5f58C33GEKR9BdTuAkd89vDudhPDrM+U2zwsizzrP35SAv/9+3rxs/Gs2i12RgEJuDebEY3ECOJrho1UzPEHS1eBua69pQNiVEd0/k85h8yn72TgJPa6ONeZgXJpMx2pqBZLZ1lRZwl8GQECP4Fkfm2PbgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(5660300002)(8936002)(36756003)(26005)(2616005)(6666004)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PHHH8rDahJt/WYrOPo0TikMn7XIGNE+yK1i4KNKCIgkTzC4LH2KNGwzx0AMR?=
 =?us-ascii?Q?kfcHuJTIrTv63fUJ+UkEQwmlAH178GZh3jb5+4J7yDDkLB+1r5XCM9M9XrKf?=
 =?us-ascii?Q?8FRPfvNFtSc34JiFdE/T0Vpn1FVUosLWjp6Mw8JnOR0DZ880Yf0oxgONLLrc?=
 =?us-ascii?Q?VOPLxNokzTo85ce6UPzUR6CJWqQnWpAgZRlXYiqrt/ZRLjiQ/fdTX9POAqiK?=
 =?us-ascii?Q?QitcmzhOWBJEIWXYS4wf9Nc3deXgcKa25IZwKgjNY49oNupOB1cwom7yh6Tj?=
 =?us-ascii?Q?d0a/ah/Nq5W130aViQDdaVpULdF4u/ANAsWsKvRh5nQ4W7JPEHbABdtJaHa8?=
 =?us-ascii?Q?R6wxjBRuuk3cBTshFjetZfaIErhohU1yDKb8sv9bLcr7x5OHu/yhyfqjHxVJ?=
 =?us-ascii?Q?JWH6fYhn4E/iSOgih5WFj05JUfbw/MWz+Nf2Tith2MhJZJDiWP136NQSqkSo?=
 =?us-ascii?Q?T14mHcb0hdR2Q+D2Q/6+ZKsP6PpXT0eiz9PhKvnVJt2J3ayhiiTlc3KbCl/x?=
 =?us-ascii?Q?pJwRlTSzAbiBHrPtt/ap42IOgGTABYkh3xhqc95zg8xCmuDWOeoSlq2ulIn9?=
 =?us-ascii?Q?usJR8bnu2I8BbuMwmFw3BIb/xmTdpRRrDwM15zNHet+vRnyCD3uDMB5fg2aX?=
 =?us-ascii?Q?u2lFs8IlXjVtREgttaX8ygDti9QOg/TMxZN+8w6Oatm9IJ+xB86Xx9B9cHkM?=
 =?us-ascii?Q?vTyxlTGeusEP7XOazLNtGIQjVyXcow2hTvOUif9/gthAU8pzWV9dH2TnsE6D?=
 =?us-ascii?Q?8QqCHzkeeDUN0c9khmoCVr9AYbzwjfSaVvMhd2dEAcGYSkdooue0+ES4oPaX?=
 =?us-ascii?Q?C/iAODLnuab/n7QG+MTqW1KlxcfxPO58S+n+9ZC8kNdwZ0oXZS6E1RUUMjdD?=
 =?us-ascii?Q?Pysk4OGoIzrsDXj/NiPpbTHDKJzhr+/4MvkXyGSPYbo7lWT2dtpNouWmGPIH?=
 =?us-ascii?Q?w6jSlM5jht4DhU5vs8qEHho6c2VKkGz309PIMdmiZdHmBFvNnMXWzxpZ3Pzl?=
 =?us-ascii?Q?iTkM5C//RkuF+/IdAGsrtxBLEXbG4opuzEf7I/+XEuVMziSWqLbSQ0V9ISlF?=
 =?us-ascii?Q?cWO3CId1KRJZvX67jOCDHAofruGDOCzkVN9bLbJ2ecvWcuROkeqdy4rC9Nxw?=
 =?us-ascii?Q?mpB2K6Ot47V53fuwgCegEMfW21EM8foLO8DnEw8vfiZKAxFgLTG2Pdq6ISiv?=
 =?us-ascii?Q?TF77hgQmbzOlfjZG22bHQk2jc3J8lALpAil/Snbun/QDpkhqmoZrj9wi3nSP?=
 =?us-ascii?Q?GUMW2K6rwoFhvLW95LigL71iwemK2WCnDPyBJuJhA4Y7j66Hdg5W8SspfZJw?=
 =?us-ascii?Q?5jYsRxNm7c5pLyIA6g1PHe1oxv2tXStOxLcs8u3YLGWaYfTKofAH1x20DYLu?=
 =?us-ascii?Q?67LhHcA/XAUN7pkupasgn44yARvtPDrzO7Q7IdqUx9WPBZwrBN+xxjqSju/k?=
 =?us-ascii?Q?aeVKeNiELx9EMxYV+AGHNU0HD59sPJDHWERS4id3rNGGCrkpAnVQkS/8PNsF?=
 =?us-ascii?Q?px7bZeHexIyWWfEtJ4QGV3gbh4+mwEoYp/jJG/8ydd8C7y8y7PyU7ZU7wdc8?=
 =?us-ascii?Q?sOvj4d2Xq0+2tPm4jfJqQdQ9zWX25YZrCw3QmoCEvE4Nj7zk7qXqRHVfjy7E?=
 =?us-ascii?Q?jny3Pb4KdIu96h9q6V1S9VvxsAenMBVOJ6319NhBQwgX2MlSAmJYD4JhidId?=
 =?us-ascii?Q?MZMISZaR+DHdFNRYvpJ9mpyjhbfXzLAwZygExZsy3N1G/ZB9IrozBuVqs07f?=
 =?us-ascii?Q?QjBcICbZrTs++chtXoOtSRktjmS4gbw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f50be0c-825e-45f8-a749-08da15e04c8d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:10:33.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxyI4C6PHQS9SLhToRPgrS8fLlnXLw69k9fnGYypjd8VPf/yFuJDFjkPGFZndabpGyzj8bO6kJGYo0bDxp0F3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

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

