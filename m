Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA577C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645009525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAvTiO76msUGyAIySGTSKUCSoDqWFuZfMpYgvLJAxDU=;
	b=RFMw8LLNuhfW0oh1rZUz888pS93RAQAcqAiUlwHO0Bo1PFSJUYWzrna/RsXOadYBLQey6H
	wBA+fWGORfT4F6+bVjNsjXVXxP22oZ0yPczo2icxSRiX85uB15kd3cv2nTmtCJldVXZcBB
	sV3H95cdlWyf1aHu7G8v9qAA3oDd5rQ=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-6FvHA0sfMROM7JpuvURNDw-1; Wed, 16 Feb 2022 12:05:24 +0100
X-MC-Unique: 6FvHA0sfMROM7JpuvURNDw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNe9uKiEHgRzSvVMERYS+95dHxAUHBsmB5CLISDhVxFUt9ukyGIvibFuVjT8Ngp/RAs5G1fOlNZNO/xDloP51Pex0x+S650KS8ncDhD1lZk04t4JXpAbGVsY4toMpghXp1B7y2v93Agy7vfv/mnTiItelVqoBzCHeKKY6mtGxKryceOlmmAzDNp1MSNrbifN1osymDCXk6+dk2Dt7kxSybPWjtLusZEV+GpsYQij5Fup6PFIB+kfco1fgCfD1eVbmGCH/EAPti6iokYe+BL7MvQ/hdFpz1hY2WNouzXt45s8r3jdl/GZAJGIi/Y8vlO+aOPUUupmYZWqN2QHMmnr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMg8XIdh12u5j1pCBKOVyiT876q4765Jwm91PviF+18=;
 b=DTY8RfdhTwysogjafYSZ8A5YeCI5St4k5AG3VZWu2kJTR6cOsGkh+cLIShBaKZ+42KjZ9PfyHf2mNFuEEg7wzzDdHfgU8rGNDEW7q50uLMarOsbkoen2GRwIoeZxaxc6tB/2agiY4qNFWgWyosgsK6haW4OVs8KeTd6k2Gs8PLzodFif4XunrP91O2NS397Thsz+sMCIJMAATyNnIyRnTxtA2l89xtcV0VghBrBuuVJ9vNPx1PcuHC/AEbPAEsYezC4Rxklu1iEUFVllPYA6xa0G87hvEoVwaa3Qu3HRx+CHpGAIAN+jYUCaC5Xq8prtpsHw3D+86Cetq1MAKgLlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5799.eurprd04.prod.outlook.com (2603:10a6:20b:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:05:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 11:05:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 4/6] mptcp: add a new sysctl mp_fail_timeout
Date: Wed, 16 Feb 2022 19:05:11 +0800
Message-ID: <6128e440e7c60269111533140a2140961e6673fa.1645009373.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645009373.git.geliang.tang@suse.com>
References: <cover.1645009373.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ca370f-307f-4a39-d024-08d9f13c3ad1
X-MS-TrafficTypeDiagnostic: AM6PR04MB5799:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5799A067ECB67131AE7C54A0F8359@AM6PR04MB5799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qR+WwtToGTCr/He796fWtWXbUE9saAUwsAKbUjjsgMOEKtqMZrExTWyHqslZ8OtRm1NCKeUHAsvGdIhTfgoZDnPsbJKG0LXPbWmjKTFl3zEfBfPcO5D17bS/+M4itp7g0AyTy5+6VYXZ6kRJ4qk4ifEsDQeeIxs+UYYp+2jzNIKui4q8YSv1AlRwf/MwcdWQPbsZkNpR8q1NqbByKTuB8mFHI5YeY2lOIIGLVEvPdfmukLa+2ByRC38873LxX1an2KJnDVY0ep+rqKrIeROInmcREQb0Jp88uzIGM6YrOTSOpLXgL8OHCmZM7nXQYEzppHWYWLcc9PzcNvIiMItX5GeNmeZQAAD/c+Pvh1fGX+3KfwKJ8gv2XVt3wegWlJNvm8yiatn8bL7sMH2/Xuc8cremuOQaF77j+ji/a41QewJ8gToAwlJFTuZ/mCS/M5k8AmeK3kuKvXMCXJOe0ZTHWkQ2JQ1hZrC2dUGksPKC1VqAC9bXKC5SyXnGdOiF40NwAbPrVbi9ViBMb2zYWzm9M+3JdghAw75IqMxgY8NRJ+QRkDgzM0DLMEbAGEzTCZWn0HgZDLv1NxY3CL8ERBFz9QFO/uEhOYt8Uxkw85sTmIPPSLK0llQePOx7vvjMHK8/1rLbAnsjP7v5sbeRs+ifLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(508600001)(36756003)(107886003)(86362001)(66946007)(66476007)(55236004)(44832011)(26005)(186003)(83380400001)(8936002)(2616005)(6486002)(316002)(38100700002)(6916009)(4326008)(8676002)(6666004)(6512007)(6506007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WlSR7MHtQoE3cGWeBbXza2XfwCESvM54bwsCAM8smNfYUm5X1qD2wb4aljK7?=
 =?us-ascii?Q?460R/s7r9vI0G03vhTGGk1xmdLPG47U4VAs4+UOSZii1YCi859vPFkaI7ie9?=
 =?us-ascii?Q?C5FJjPEhimKfGUpN9gJfZRJabdXB2Aj3+Rs8gqLfMTZmJR/to4Tv91n1rJfv?=
 =?us-ascii?Q?QuoZhkC+8kQ+aZtofMQK9g4sch7keQUymef1FAts1Y3gau/ShxaTrMU0M8kG?=
 =?us-ascii?Q?mmU7aCYFXF3vdjdD2dYlQFwXaYtUGbVXY7eY+CNUQJR1Tny2jXZbN2QIMCKT?=
 =?us-ascii?Q?NjtNogRYm3xtWbbGqJUKr2KyYgYUJi8KMAWMO8Kj2CaTZznXljvRkLYCRHoc?=
 =?us-ascii?Q?VbhhLrygIBNMnuicHLbVHJgqmyzgTU6IXr76X/Zor9TheGk/S65fvIa0o7s4?=
 =?us-ascii?Q?5GlngbpoHVJ/pLcB14JU0UE2biu5kmuAviSqnot4ahALc57V037B3dS3hzCR?=
 =?us-ascii?Q?acZoLe1tOgxwaDYnh7vL/4OuH9PGtUnIIOMhWmGxmwdmkzvLQVpzugIadAa4?=
 =?us-ascii?Q?5pOou1ewa7gVOPcL9FdKyGr8ujZ+rCykwbDx4wCEMXHu+tXrLUE7dnjE3HAq?=
 =?us-ascii?Q?78E4gZkQpUObU7nz/7/jY5usgTHj88snXHgqn3XzRmz/U4Nb4gMcCNdZZ+GR?=
 =?us-ascii?Q?EvDI+aGi83JlN/egjcKCpau4E+JSQrr13xif43ddS9Ch05SDYBuxhC3Wus1J?=
 =?us-ascii?Q?3UMioJGQk9J6Q2iqThvwXYAbOoOolvdBqo3REASZ9o1NJwe1awWhaxAD12Nb?=
 =?us-ascii?Q?lUuta7TplVtQ3Cvpvnb1RPjjngA4PUKoARcCnAqqY8QYjFhUPy8ZEWX08H92?=
 =?us-ascii?Q?6uRDG8ndAM6jPolr02X7Le2DujjusuZrA/223lCVqUubgwuiBgIRcXzpQ6r2?=
 =?us-ascii?Q?NnCZWsbZUAxUdxaYRHJHPyQOU1vPMQpMGk8hm5FVpGBNJoQXtePmumoh6OsF?=
 =?us-ascii?Q?snldRBbsOLXkdxWVITwu3RQGTXC+7CcuZwyVStBisWmjT2rcaiazb9iATQYY?=
 =?us-ascii?Q?oe8bRdNI9quQnnQxdF5LKVUU7lJpgG2n98a5kVWbmT/ldNmnZbFtKOb9O1HV?=
 =?us-ascii?Q?2cyINAgmDEwWAPz6NY9tSyE+iW2NQNfYAuf0bvDYrHf+xfcr5hyj2/NcPETA?=
 =?us-ascii?Q?g9Sz7WevJ2dJj7DyPixusnl3GCdI509YZOJlXIwsHMkAxWSzMfOR9d+2kvyG?=
 =?us-ascii?Q?lJGdlY/jz+ClrD8W7NDGK7KXy3G3GLCqU9E98BK4vSay3L7KATiIjFWX9gqr?=
 =?us-ascii?Q?CWj1+Q+SmbD1UAHvqhPkYk7Pjmt8VB+N7Ux907pL2+b7VEVatkt1eUV2Xt+w?=
 =?us-ascii?Q?cVqT1t9vzER9t0w/d+OxNvniSimgk29RQK1uV6ly0vL59Z8KVDpxN7hh/x+z?=
 =?us-ascii?Q?8UYL/IV3//GlY1XrLnCmqPgv/srLAJY10cJOm9gbVmJ6l/kRKvdlVKCddPrs?=
 =?us-ascii?Q?GuKRPZteNc4hg9PL03YeXFP6w8qX/8/8iH6X9mQcMylJLWONKGAt0zPmCPMc?=
 =?us-ascii?Q?llc9Hg7Yi78CnwrPA6FPi1+9tligRiexPvvlbjwm3dqJtpz+oNZwFMmgxP/j?=
 =?us-ascii?Q?YOLNm2Mt9gnGWM9o6BhfmoxfcEaB9iqcAqhQSe78uP+HU9CKtW+nIXkUkzjh?=
 =?us-ascii?Q?/74fRC2T/3jqGv5v8EI9Olc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ca370f-307f-4a39-d024-08d9f13c3ad1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:05:23.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tgz1cUdD3GJcAPbf4s0YeZw90tvSXfcp9snliC50+hPUPfDlXTJV7MQZVGB6LySJ76B7euxZFBPSzY1DDXJraQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5799

This patch added a new sysctl, named mp_fail_timeout, to control the
timeout value (in seconds) of the MP_FAIL retransmission.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 Documentation/networking/mptcp-sysctl.rst | 10 ++++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 25 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/netw=
orking/mptcp-sysctl.rst
index e263dfcc4b40..3ad19e04ecce 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -75,3 +75,13 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
=20
 	Default: 4
+
+mp_fail_timeout - INTEGER (seconds)
+	Set the timeout after which a MP_FAIL control message will be
+	resent to an MPTCP peer that has not acknowledged a previous
+	MP_FAIL message.
+
+	The default value matches TCP_RTO_MAX. This is a per-namespace
+	sysctl.
+
+	Default: 120
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..a211af9b19e8 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,6 +32,7 @@ struct mptcp_pernet {
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	unsigned int mp_fail_timeout;
 };
=20
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -69,6 +70,11 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
=20
+unsigned int mptcp_get_mp_fail_timeout(const struct net *net)
+{
+	return mptcp_get_pernet(net)->mp_fail_timeout;
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
+	pernet->mp_fail_timeout =3D TCP_RTO_MAX;
 }
=20
 #ifdef CONFIG_SYSCTL
@@ -128,6 +135,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		.extra1       =3D SYSCTL_ZERO,
 		.extra2       =3D &mptcp_pm_type_max
 	},
+	{
+		.procname =3D "mp_fail_timeout",
+		.maxlen =3D sizeof(unsigned int),
+		.mode =3D 0644,
+		.proc_handler =3D proc_dointvec_jiffies,
+	},
 	{}
 };
=20
@@ -149,6 +162,7 @@ static int mptcp_pernet_new_table(struct net *net, stru=
ct mptcp_pernet *pernet)
 	table[3].data =3D &pernet->allow_join_initial_addr_port;
 	table[4].data =3D &pernet->stale_loss_cnt;
 	table[5].data =3D &pernet->pm_type;
+	table[6].data =3D &pernet->mp_fail_timeout;
=20
 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index febf32c9a139..595222b08fbd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -583,6 +583,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
+unsigned int mptcp_get_mp_fail_timeout(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow=
,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
--=20
2.34.1

