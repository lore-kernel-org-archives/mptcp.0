Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33328EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651412962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOBPTlxkFMbhTt8Y3ecj3/tlLaNOgrV1Zy4XMF5XwHI=;
	b=TPii1GRR5Hkya9X7uSb9XWU24hRaaJCv9lYCiDzX40cxLLOHmQ98OPfauel85VCCoV1Q/a
	C3u77HgyF859RIOOVBkvxBXvMtTfc3ORv+kOCIyKxtma/K/l/SVS1l9kVnRCUEY6+WUzDG
	9ROdnmi5QHqNJOMzV3BT7MHViC9Vtis=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-UAawF5CvMFmTyIxYrstHVg-1; Sun, 01 May 2022 15:49:21 +0200
X-MC-Unique: UAawF5CvMFmTyIxYrstHVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keGLPrG/s69IPz7Jm/slGoovq5+Avv9XDzT8k/YwI+KvaT0rgXiD3th3PmzahmLRzJXNRBDLof3I6QeG42O15cpuHuiQs7xIRim1VqPkBoVR7fRjCTWJgzLT5chWIUqLo2UBWlFN81Pqqz3dhwM++p81fiiq0sXIMaaR9nyjifI9lAcmvlaqtgpDMJiJrR/oaLSzec+QrEwnMS5FzHexYGnQJ0wdek4tOdFUh4kCnyULKZwaVvqRaVdvp/kHxa7GCt6QvtXtiqoWFlS9uUT63rCXt/PmqCENme9PZq2A8LNBfBSjK9mcqyrzdateseb6epEsAbnFKdeFIXi8Tv/mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/cvUEig5hCjDu+8NI9C954+fFyJjJZoqC9JDKuPeRo=;
 b=CcBwsVT8VDDZYSnu/qd322JSa2B00n+k+AFU+JPwV5424fFyp5kXVDv0KKZ2YdWLUYFNvHfQvM0eGO0fdoYYTdhJqsHkUBQCkht2m3jNJjZz8JkMmbi9fEPucHMZyBHcJs7gbw2h9Sw2lFpre4vdo0d/1oxT2YkvnLnzr2zqnNRmxaxsWFHwYzxPxlJhNNOJGM6XHEb/Cv7S4BzdEEZE348qUQRqMZzowrU1C1v4Unlsxb+VmwHlNZOI/3aHeCtOKOCQ6ebr9qXTPIAG+i8znYJg57VZEqdlOhfI+tHJqO+uGjlYaRoZE0gayH1Lz/ZhLR3FgANR6vkTPvOuFh+Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:49:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:49:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 2/7] mptcp: add a new sysctl scheduler
Date: Sun,  1 May 2022 21:48:45 +0800
Message-ID: <257048ed1df634f47ca5efb71bfe0a7fcb8814de.1651412613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651412613.git.geliang.tang@suse.com>
References: <cover.1651412613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2f989b5-4d26-4a1c-c453-08da2b79641c
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB6283A33FD05A0502CB3D9FF3F8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YoZVp7632WYb7OU/OT10OLkJk7x0ukwyCfNEQPkuZCwuu8foMpJvLfVItelWV4GL2O/uZLbD26P4Ytm3Ssq4Zn5Bz0/qZMpdfaKvF4dQ09uIl4OfEfyhT2DsqX0J2bnSpaUwLv35eKlTPyUT6gPILamVZ+hjKDRIyBeImlDUHASLNxfOjGWOp1glK7XaalJjCUcF9NVoNLDiLGkHTYQez66/0O4sOR4xnwxzzZe3c/ScaVf6IU6W77coVmx0r6BEGsc93Hh3wIeK9NAic2169UThSB21Er0k0AXSLqAOc+MaTehMZnTOO1juckGHFHn6kkA2FgPLbfXd4o121FplZnqsykOzLJxRKNCZylvhi9kcC753o6O8lhTrsj3+4Df/e+dXfXaRxwiLZhsZehGg4MmpGtSOSQgNx32pHcGnacPiuEgZqqhOK097HPX8ux42ueUFqlZPsmNCzLIIO/7K1Va1ZflqG7pDDlzFothSIKGkysRE/MCzKyPJ1k4M0ArWoaq0w6dCU8gKwguAE7jrr4MhrCtUSkmao4OsONwNrnT070zVeSwSiIES/srk3v+r3se0UkOlfjzNvo6S3o3oroHjOsRCcPyRBQwodJzKJ3359KeSX2K5k2w6cwalCbxeFXx7pkBF3nsIb7nHzr8SZgH37TzZZJB73dbYvjnLbNXo3W36Zv3PzyrlcLapqDTGIPRfjBc4Ih1sOegZWK2fRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(5660300002)(186003)(26005)(2616005)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(6506007)(2906002)(107886003)(86362001)(38100700002)(8936002)(6916009)(44832011)(36756003)(6486002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6WkdnMzWV6VH70jBV4PYfifqxN4NyNQnum1uD2Ei6Tm+Q1yGSTiALQTl1UFQ?=
 =?us-ascii?Q?xrbqIVAcj7FxZXLZt2Z8b0IG+Q/0cv4jeCFOx0VK8Sx1T2023gy8uG6NeNgP?=
 =?us-ascii?Q?XRCGj5WIveJcJcwnBr1lBAr/ccVfrFcB9k+kvwwt/u8q6vMU9xye8XvW/VdX?=
 =?us-ascii?Q?lgD58JnLXm0Q0KiyTYXGFhQ/556jBszy524Mha6SYhkZ6oPDpb56f2oIXDpC?=
 =?us-ascii?Q?mCtEOHIwNPX4nSH70UrSPVHnhuzWkgmedBjNOgyxSNgU4Z4WkMyIfIPCEN2k?=
 =?us-ascii?Q?vVcD+jwFDGBA7Sp8sYoL4lX5/w+XfMuZ/nuOhEAngDrGtvp9rTbyCnni5Aay?=
 =?us-ascii?Q?bZwTTiFQBemu6lnNQpwwMWS5G+Go4wJDT0eZCgN3eoBXE91esFW6+SmxRVbf?=
 =?us-ascii?Q?4T9VcUFmmJwSdHelMsFQmbdke0w827xtunozbTmYbWTVzu6LG7HnjfqaEOcv?=
 =?us-ascii?Q?FVlCDdkRPUtUeOBfrTx7ebEmNyYPMBW+t4Tqu35CEXHqKBONK4ntiyhRCIrq?=
 =?us-ascii?Q?80CCIvd2wRMhg/qNq1qW7aGtM3a8ow6ranM0Nbe48yQkZLh4KD1JDAymjpK4?=
 =?us-ascii?Q?Mp8tgF3MXc3K8o8J6wfPJZIFOYIHTY4nYz64B1IpSaZNpVo4LH3lv7ZeWcIN?=
 =?us-ascii?Q?6eysjAdnPYCCYfAKIkCzYU2KZWmLRk7reHhYOANJ/HRFUeFVwXBpC9Yy8/QQ?=
 =?us-ascii?Q?dAni5z+oM8DY+92aISS4BsV3DJ2XarxihWvR9WBItqsyBe00TTqGg1ufEhNm?=
 =?us-ascii?Q?kqF2jIzUNBGnXd3TtLleiGSKM8HVS2yV7iRjAouiLPD4GcLpC1NQu+6LGVFl?=
 =?us-ascii?Q?/6AHHiCaFE435oh5lQZik8FukogbhdXiJx+qoizxNjHTP8+peMWNNx6sxEsl?=
 =?us-ascii?Q?5UnX2Aufs+efn1iioj9wzpFDO7uHkyXTRF3jJFxfkz2/p95WiWMLpxK6bOSB?=
 =?us-ascii?Q?Idhu+quGs9qCIAIQi1afxHueh5DJQAym/ALz9u+FQP2Dd9n/Gj8ozs9Yeaq4?=
 =?us-ascii?Q?FyL60ZwMdaWKTdz7KZdyVXPy83p3WjvTxa+hgkYOksRZe2FJcwcxTe7fAbG6?=
 =?us-ascii?Q?wq2GWtYJINEBihwS03/YayCWcThMMgouXzOI3OYvup2707wBtvqUw3dUH6SS?=
 =?us-ascii?Q?KICzwxXile32PS1mj7x3CiGit9UTsVO0nFKYHnjzsocRWsooBQXQnbyJL0Of?=
 =?us-ascii?Q?+1X6mVQCn19lO+sZwOwuJm/9FDum4irlTCKCoXl8q+rBllQIX1drKq08JgOE?=
 =?us-ascii?Q?ue1jw8pbNG8tmMIzK19pSx1qkvcnESi7Y9+O51KNmw46Vi/9O5DgYlqIarlE?=
 =?us-ascii?Q?FvmAUZaJPyNNpH8jDOgHyi7+8SX6/G8drmfu9SgoHyR5N2+8Yp1H33jVSl/r?=
 =?us-ascii?Q?yBFsJ3WolALlWCL5vOTTXJP38sFEv46jW8Li0Fiqi95vMsTrboJ+gORqPQCl?=
 =?us-ascii?Q?93oth4lT2yrN101+vayZMiz6dMxj+XYJzJ8kuHaSCMrKghTNWLY/UdElQaLw?=
 =?us-ascii?Q?ud6ZgfkCh8jZjpNmvi9ktzBtLFyCD4rpTtd4OgtEb14K9RUzgkVRyiYbsfc8?=
 =?us-ascii?Q?cSt7abcP14ssPUO6UQ6eBJbw8jLEEiqk+pw88C4sIk1kabVWf1yW1237ThLM?=
 =?us-ascii?Q?+cjC0Aoda+/QBgBZ7bUA2RMcVq9PdtRQj6HNuc69sdvJG4oy45XHR0fCZnKa?=
 =?us-ascii?Q?clquvS0HPkXCOG8YJVOh4AIpqjWwFDdmAwSnF0jKCtNWv3JmUSSRNUrlXnm+?=
 =?us-ascii?Q?Z0lRlTIuoL68cLxcwiN44eV+72y/Lt0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f989b5-4d26-4a1c-c453-08da2b79641c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:49:20.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYWBhkXXzTuInv0MnrVQCi0czsF6NMM2Bb3TxrafVF3YLqPHF3LNTw5l6fGVKfcxfTiBxoT3w9MEdAXi2AArdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

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

