Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59A7B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOBPTlxkFMbhTt8Y3ecj3/tlLaNOgrV1Zy4XMF5XwHI=;
	b=F/vJzmN0RyjERGgo5QdGjZ7zJxFcLNEbGijgafy0PWZ60hLHZazsrd0ZiD0/32YB86aSVe
	1PxMML+kosOtw2h2D9ZCX2L0gn85UPaXbb1z5Qftzu30PCXZkMxXEwdkEkM71Go5wNKnMI
	n45oBg/4al2PEtnLA8GjePVITlYAiGc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-YRfkfJgXPUi-dpXXwbCE5g-1; Thu, 28 Apr 2022 07:23:36 +0200
X-MC-Unique: YRfkfJgXPUi-dpXXwbCE5g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPbMIj4MKZ7Z4QK4d4iG2XsVlby2eHX/g5kBqL8to7tml3wOu3Aa+omzovy2u04vs7m4hRIBWAWoBFJX5jp0MArv/5RpKfmTneKk8mBycDOEjFksp+6Oy+PnFR52XQ4TtvYa3wsft2I19otlS8VEbNVi4CGREwXuXB6ZhYSEXmElpUdDcKA74bCpWavbfcpNsVkgUni2TNNh3NDiofUPgh6E1uFoeBPneyS74jLQrNqVYRFuZ8x6GtnaCmAmnGIfUFqveQ9F/YmubQjGOwhrCKlY2Sv332T9WsbAfH+qxVFhINaNjS6BgVvJ0enCDiB/1mWClUy0lbeDdKnC0YSnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/cvUEig5hCjDu+8NI9C954+fFyJjJZoqC9JDKuPeRo=;
 b=a1FOZIlX7ZAgXkn58ylccyhxJSmMNCkX3pUZKAE45YNIeLMSE8E7dE29RPkJBifv4cMSwXdf+i0/8kuYJ5NbQlCi72ISy6aszJa50Ji2wu0hZ4Nwzy84TOyphfUfg90haKc0dLOv53Y5l/Pcxm5dLCjx04weWOtFg0HrFXf60FlvQXIKWs2atgVlexNGMft2K3PUT6EM1eZK6a0WHdhuHUhr6+xF3v+SkTnqjf1PcCeMNN6ca35PGMPpTgVyVz3eRcv65ib/Eg22OO5ExCG+RLcIpHn1AKZtbTBmlK0dv5hNz9u1Cyi/WK8eg0Kx/8ValLttN1mrHZrU9q4TXeW8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5653.eurprd04.prod.outlook.com (2603:10a6:20b:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 05:23:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:23:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 2/8] mptcp: add a new sysctl scheduler
Date: Thu, 28 Apr 2022 13:23:29 +0800
Message-ID: <54cf9081326d816824d2a96ce72bcc2cb5e28c06.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651123078.git.geliang.tang@suse.com>
References: <cover.1651123078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:202:17::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c6c73a5-04aa-446f-5fea-08da28d73db0
X-MS-TrafficTypeDiagnostic: AM6PR04MB5653:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5653133E446EF7030ACE920AF8FD9@AM6PR04MB5653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q8WgpdYeHP5TxbQkPNpnUEOKe8JmX/o3aLPLhPM3gvlCJjd55v4wEIlBsHSS4fYK0j6jU1lGvsT5YxQILZtHzX8tTS5N9IScyPRk7kFa+oKSL8OwQFfOSAQkTl9wgKFYj9SFgzGv1fqg/ZiIKbGrIr7IcIuTnDBLXsmMxdraMrEDN1OoksuJf9hjUKn+YH+EH9LQ3NxMMzonmeTIuPHZvZezLHAGDUpAg6E8EpoYEUlMW2Lmm5iMYfKIqk7KMPUn6g1Y5CkW86p9rXBQwPo0xtg9sdT5qQ6WzDKxXCA2lHMwH0OY2O8ZW8WwZWYbn5MRAqrDIBXsaEH2tMn+PaZHHoQ9kk0p3wqMTmPtUFEq/9OQKS5jMHDhEwi/PmpnLksUAeSCAUQt0ug7s+pijLjA7DhxQ619bzE1QOocLh9fWeKWt7XkWQIHPq1/l7BxqtA52oTsHERroClljUCTvEdsP//9B6IfE0qlm2DmD04rSrFn8C6S3Sw2BYD9mZ4F6D9VMiC1h1E34pSvqRjaYtMdT93suAdzoTRnz6DECjK3SNVU+JWw1viZSYHg5wLX1XHjgsR/+zCFydnt+zbXNBtJ38PnXJ+37v6AcIpkkmrs2fVXFL2LzQcKxwPmzRidON3Ubfag4YJ6WPReymPbxBtu8DuJZXvAqVy08xcvWbB5xjPxzoDZsHteiucik2ZYn1hGtYvGQpGa61VzdjIIUWZ3uQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(8676002)(66556008)(4326008)(66946007)(66476007)(6506007)(38100700002)(5660300002)(86362001)(44832011)(8936002)(508600001)(2616005)(26005)(6512007)(6486002)(6916009)(107886003)(316002)(36756003)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJzy5lEoZmtE4Nu2ep6wuhhHqQLAq/99fNgz/fI9sD+QgrdJK9OCQA38/LOW?=
 =?us-ascii?Q?wgTDgFj1Y8UICwjC+9WQ8u2IPEmLM+YkrbagpQi/G7CHCXcuXHeDr/A5o7Aw?=
 =?us-ascii?Q?sYq3vF3MVfoiM1k431sJf23iIcKM92bQz7nFWb3Kq8Vf1G6/hDVV/P9M7I/Z?=
 =?us-ascii?Q?dGxqX7nyvcWcyp8IPlgZ1Jb5/35zOVf8rljVo0XAqsYj9iHSN5hbrFw/w7TO?=
 =?us-ascii?Q?qfa44d2W+O35NyE+b0BMlwr1A46Myo5gfZcCBbb29Jv8aG39p0mEGHTGXmfe?=
 =?us-ascii?Q?ZIwDZt9FwyrSrJl8aO0/O1b/EusB+6eH7gIEf0BE0/HF8PaRudNHskoeqAxQ?=
 =?us-ascii?Q?chJKLcSjCSwinGNvjiY1JvF3NEMpmn6JMAE4RtHtRrhu4FFJySMjThcJ3X90?=
 =?us-ascii?Q?qcWTLwb06tadOyE4y6CVF3lfg8FI1HwpMx5Zgw6XB6tZ3GeN7QdCKKH13a9Y?=
 =?us-ascii?Q?FCCOOvODL9RnOLrTWLW9OCcVHVjIYzWpFpT4fFCT3+/A8RNrT4iW1GZ/h3QX?=
 =?us-ascii?Q?9q93EokZual0f80fBFGVnJ8E8mY6MsLs48W98FmhlxQx2pHXmhTfs+2/uwIA?=
 =?us-ascii?Q?/vz6tFCBhwZEZ0b65OifxrO6642LI3MVaTCoQA3br2BzadyhPC+lry8nBNoK?=
 =?us-ascii?Q?/vtLY1FDribSkvZmYyeV0rWCgE2UY+zIVlQ13CPxslOWJonZTmkBIMFJU8EB?=
 =?us-ascii?Q?t+NzXT/96CL/3IfPw/GDGTUq3Mh/AhH0OsPdTJ5cVuSeGGofqtJ19BZP9f8z?=
 =?us-ascii?Q?VwJlErRkY/5g6mNSONbKaRBFvJQTB+3tumXge1zkeAhX6a3nptXsfpJZXIks?=
 =?us-ascii?Q?MG4dVZfUwz8WUgIW7INcaocwn3IC/AYD2DFoWjoGVEWmfTQaRX/gwXW7Vjmv?=
 =?us-ascii?Q?zI76sFpmS+EFerJrTgqSmfTzCs/lsLfeHb2r+ypKFS7hZnlnEtU++ORv+4lQ?=
 =?us-ascii?Q?6FqTr5Q50qhj1Bn73SoV7oRLzi+iOeGnRbPJkl1caD+TB2eOdeO1ujxTJAjo?=
 =?us-ascii?Q?stVgqvRHDID7arRzS4B5yHDmbInpE2mWN3auidBsfbDcwM+sdih0XyEltkc0?=
 =?us-ascii?Q?RkhX+EQ++WVTL5u6xEGeOsCqJvuSor6A2LpMBAjxi7fnq9KIaFwFvc1uRx4e?=
 =?us-ascii?Q?Opt/ZBfVt62qe5FWMJoq+wcQorY/IRwLZMZqtfCkGmjdQ8Il9PSR4zXw0Qvm?=
 =?us-ascii?Q?vLT5Nj+BVrCVXLyyyEyv8thCV0YV7gXtIvNVZ1R/JtNcE1X6/D5O9+lF9Gcb?=
 =?us-ascii?Q?7Frjb4pBUKRcFUn2Bl2Npapa1PHbjObMAzjSlqhzHDMh2PRSgl2VZ/22dnIf?=
 =?us-ascii?Q?YT2dQ2FdmAt7f8TsBIHOmQ82A5aJq6B62WQtoiqeZI0mxZqr8yK9/YdwgFl7?=
 =?us-ascii?Q?/Nn4zVQMJiwqUQQo336EwWVBfWXACR7TiiLitvjNWhKTIK62bx8UI0SMEh5/?=
 =?us-ascii?Q?O2Oe2lhbcLj3nG+ayCUwqDvgqeHSHFN1JP7xX3ZfVMSDVLO89hmob7+6R0Hj?=
 =?us-ascii?Q?U0f2MYQHqXPrbJ2gSWBPcU8Y3nnoLU3KyxVt7n46jG42lFMgjNZ7yCpKBBB8?=
 =?us-ascii?Q?7LlPIDX7KXfg6UkFGqKKyz1lca/q4z/DXJH0GUmGESBqQbeLn0FDABT2CFCF?=
 =?us-ascii?Q?hx0n27m2yRDp1elgNKz1jtJmHsg0MMzKe2P5pPwcBGa+knAt5MFkIuDes0uc?=
 =?us-ascii?Q?TMIuUixEadS3wreJGi0h0esKHYZTZbDa2MocSdswpQE/ueLOJwaCtm//SmJN?=
 =?us-ascii?Q?Iz1yxC9ZcZLb/a1B9fF5pP8yfmkzxbg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6c73a5-04aa-446f-5fea-08da28d73db0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:23:34.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +trL5IT2CRIU6YmZqwLxU9+w/gfIXGx+G8ypqMRLTbQczuGVBslK3iutqxOAa42ZPl7OX19nmGYbK8ZU737RrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5653

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
index 221bb6b9860e..2f5ad12601cf 100644
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

