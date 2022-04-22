Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD223CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHCR1gwB/FHq4Vuttp5fTsIGltbWDGqZTP/keHv67Aw=;
	b=hz64x2JLICJc1A7wPtNUHNkJ1Zxp0uv6BUysUQRdutJxdRr/t19zpRbQ2eWcQHPr2N2Bmi
	Q+vqmdKGoivva46i1tq3gkuDP2EKOzATMTxIzlpykI3O/TlkVjmtrVyKQYCKl9KA8/Dflt
	NohS7SiXL9N57zO/qjEQ6zkmOoJAxF8=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2059.outbound.protection.outlook.com [104.47.0.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-QPaHyDnDMLaEg__9iy096Q-1; Fri, 22 Apr 2022 09:43:10 +0200
X-MC-Unique: QPaHyDnDMLaEg__9iy096Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYBVrOUpGPDUl21zu9qsbC4L2MEGGA7dIhfApVvbeEijn68deI9MQBVjVrrOjNt/Dra5hde/mJsl5JflnEaiSVeAEObR4XfK6ZSU28V9bP5hK/RenKXyFrwGWedS0pLwG4Zii/JOKuMdtVLyqp2MDXodqfe1XBMLDcLorKLDGFYO4p0rVbVhcnLFqIuiEMa+oBNT41YZEOJLY1C+l3Ku/rpuFbjgDAYQbIyTE8l6JzJT859c8SwWHXksFMeqYueNj9pvlgAATCT5D9Nqh+p4CNA5JuI9F3LKlHXULJi3l/LEJml44rwF6Ow+znntZeaoV9Y+EmUB9yHTUXQyAAeFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2AcYBpWzxaxPOyELuqTU+jcmRnPt3BAg6eDmH1PLBI=;
 b=QjKwlhaJDqbhVkQfgwKgLTd8PRuZMWp5T4z2JfhObcSYwhj54Fqu3Jsm9nd+zSPB47yCC/MuVStBw/5Kp7S6V1PeleAWsqGHFhoBwBwU2vUCNwzK7zsgTyGGICLmrWnCd7pqaMKxt2wvWyRoN5aCS1JHfaefQPO/62dS//dHYAOzQ6jhpSYBIqPGIj3mZvAP3T7rPmmHW+SUJu03cjDyWO+Rj0XIG71fkXAvE0t6XEnApHPByDi3Y7CDuzGyisNQqZh2Z/kqne0af4GrhxQBYXLR4dXHfbmBMKsin8cHhhHSeiCdJe8TdoJA4qKIO/+qZoAuBPeMrDAA6nm1GkSfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:43:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:43:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 3/8] mptcp: add a new sysctl scheduler
Date: Fri, 22 Apr 2022 15:42:51 +0800
Message-ID: <d22c260d42672482cf68874b9dff045d91f8983d.1650613135.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613134.git.geliang.tang@suse.com>
References: <cover.1650613134.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d573e0f-26ce-489f-1e82-08da2433bec9
X-MS-TrafficTypeDiagnostic: AM0PR04MB5876:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5876B29DA50A32668E6363BAF8F79@AM0PR04MB5876.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GaCI4JQDxpcfxjH4U+uYvmRMLTsIMFaDsDsEE0ZFL53RCNSUh9WHOUU4W10Ogs8DaWOoG3CMz4/URVV57pCQC0gx6cYKjTXCx7t34f6nw/AgapVaMxr2sliYaOWFE97CZh90XaoEkIat/DNgU7LXdprFW4SexwT+A5p0oS75rlQ2sgCZyONv90OAVmrcjJLWpHKyoOcooSbhd4sMzap6+glnCMmFhbJIdSps9OwprR6WkEMqt5mfTyrKClsG7n1GJXFK4GYitqfQtes4Kir1HlYNzcY2feraX+mYnClVUnFoKUBMSqBiDwrsYBA7pVAnvSNbJUCKOlbIe8qrqyOkp4JqrB/IRCvdKsYP5LT7etwEjChtwBPWjvq9hkdqfzkSZy5rc40RM5jp/Bkq8FhbbTadP8rG5WVj4PFGsrlciFDWTSVrmuqF3lzPSLC4NZeuH6wMFTTBDwP45IvWr1HpJJb8qg3txXWgeOrQFJhtZWrSNd/j5dVRiC8HUI1cCiwxWv9iMPImUbqPuQiHqWcLM4RQr3SRyuj+u/wTi9uxjmViOYgDUr+iYLViCpLZwkvjZul7z+9e04iOg9Myb7jE/SK8joJVYYjE/KErbLZp11cajwYLfhGUdqyE91TDPbBwRZUc/RTxrCmEhk3fSHXsV0olA/OBgePns6Hdk8P/PUZiTnevAiMjQ0ixVMPU5QowVLFPrS/DS9vis8PpqjU1HA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(86362001)(5660300002)(6916009)(6666004)(8936002)(6486002)(44832011)(4326008)(38100700002)(186003)(2616005)(2906002)(107886003)(6506007)(6512007)(66476007)(66946007)(66556008)(8676002)(26005)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wc0jsXyvpX5MIW/Vizniy8eSQKIFiQGvmuC61V/lPYZA+MBhET+sp7DGLzba?=
 =?us-ascii?Q?fkIiML8501AhYot6CiFvK3qYddbqIpFfXBkuXvIP0/tzV5oZ6AlrJYgUc2iQ?=
 =?us-ascii?Q?Nx5hr3O3L5sqxhEQw+zwMHUoVdOT53IAwKIpge9JMUVZQ6a6xw7DDbW1Vsci?=
 =?us-ascii?Q?lYFzVTbR2YgNf5BglA8RsX+9dDI8ifb0+p8kGfGOG0aW9eGRi1meXDnsGQmS?=
 =?us-ascii?Q?NWH336OgftpO7z3enIzH693tufLn00nr3eSOqyWxlI9VXTQuNponQc30ViUz?=
 =?us-ascii?Q?a4u0MStmFmVbdIvS2yVYasddPxrfGUOz6DfsJlB46lpCFgR1QFMTHMAoaV5i?=
 =?us-ascii?Q?ZNMiEDWy2kLzaz8czukM6S8CHFMymu4UFQlnWwIN9xzPz8qRM3cXL7eptHeb?=
 =?us-ascii?Q?1lEjyooDdD3oRxf7DDRB55n6227nZc1s9W7lybo6BsdLgKEqele76l3MjJ76?=
 =?us-ascii?Q?IGWohKbLcpIJFV7OV0QWExrA6saGEB0x2rbzu547ltS5MoRS1FAULO7esu6W?=
 =?us-ascii?Q?eUkqg7B0162MzDQXcCob0Rwg6k/Yp/sTwVHlkLh1oDAYyeSf0ezjBNJ00Wg4?=
 =?us-ascii?Q?jidMuddr2VzG+bJYdEX6zVEBdhQzc67a5oIAeBNAMxcId5qWIzfbudv3D4+j?=
 =?us-ascii?Q?I07IhqM3Ktf9C/bcINhk8N3g/mipWeQsApyi5x3HaiaSsZnRilKmb95c6qpl?=
 =?us-ascii?Q?Zbt4Q4p1Koii57HNYgxiyFWXTscP8HC80ps0hnB5Y7Ew1pC9FAMrTDNRBykH?=
 =?us-ascii?Q?/3gvYbalPCOz6viXOXgVdUXXsl4K7J4Rh2t3/Oei3yPPoDkm87bR81eCTan9?=
 =?us-ascii?Q?e8LWAXhsUa1ONKlLfZSl8dt3V39ibnCzTa/XcLLky736tlGy9WJMXkHWttOV?=
 =?us-ascii?Q?nsfKvCSMm0K5uh4gLCa07fDxTfNf1T+0gjqSqwo4E4eIyyu4dFwFqP5hRiS3?=
 =?us-ascii?Q?OujHchEw+zy7wd5Idgu5hRLZeoDenGHeLJ2YT64i8un7wJ0hm2HTj6OsBIo8?=
 =?us-ascii?Q?t3VvQLSBFro2JkVjtI1DOiNDs0Sa576IrSxU6jlKt1lC14/PaqV+gYh6syC3?=
 =?us-ascii?Q?ML9suQbU5nWJ4wEfJxoP22by8fbE5BZRQHPZ5S/Uu5oUajQ8/mi+o4uMc+FZ?=
 =?us-ascii?Q?1u14+9xcokBPHVRPODSNzOPU9lBDUqFQHNj0fAdhcozxzVc8d7lxFRvXzNWN?=
 =?us-ascii?Q?zHM/mSnfLEa4Bv+l7dpf7I+SfqCjUhuMWx+p+jpKme1v8xmybFAwdW8dE/qz?=
 =?us-ascii?Q?wlyvclMebCZGwvtjQmEk0m7unTwHSEkxvBNlhK80ZLF2VxSQ4aqiowOaBI3M?=
 =?us-ascii?Q?Lr1sINnQnxX8PpZj5T3Edccs+x9ZMmqcEShuFLPaJB6eqbZd+AUroqfIWUEq?=
 =?us-ascii?Q?iU0Zgg7HNSEHU6s1nkD1hvIJx1vKKQJTAdNKJVPZHhTy+n+AYXw69BdtYvPk?=
 =?us-ascii?Q?K2b58w+06xhu6NUcnr938crvgMSko4Qjkc8zvqo4VfUuv6ad+hvRQHLzezBx?=
 =?us-ascii?Q?kL/4WVHmD1pVVBo2oeq4YCJCtxeMRLQTpiahKNGhCiMzzHx/WPgcYYp7k8KJ?=
 =?us-ascii?Q?D7SgxwJ4r34HVqnXhkTer4mB8fw/RlJcgUP3FdjyIa/AsFSPb+lzA5fVgQZS?=
 =?us-ascii?Q?TMtpp28nqBEWOaNLbHrhusaTbrJsu72ipg8Y0I4dg8ltxC5mr2TnDXAU225v?=
 =?us-ascii?Q?0W/vqKIh0PPUvB/GRo7kIOepLtPgPm/neCMigEsCz40tNDa41zLaqE/13X55?=
 =?us-ascii?Q?LCnv9/7B7V+l6+IcECkq+6zX+dYnxU4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d573e0f-26ce-489f-1e82-08da2433bec9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:43:09.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pPimH3AAqrcUFOdDQhpV56vG72rlWe2NjE7LbIZke3gSlx/vKbhgGh8Rk2Z7K0ESKYmxacWEsMwbbR/DCh6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5876

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
index e9736dfb9e27..0b17b4f7b134 100644
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

