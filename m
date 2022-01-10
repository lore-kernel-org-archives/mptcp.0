Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E842CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641785460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JnXJuQkan/o7XtXkG9HCawbn23OFFV/d5DEByVPb8g=;
	b=iEDLIU2fo/mWRRKscT9QQb77Qa034FK8QR26WrgbHOkW4mpAealuKv5L17ReQNoHVV9TkK
	LntaTJzrzfTyvh9xxzcBI+BBqBxBOd3oBtHrUbWl56yS0b3hg3Tgso4FDQh/L9jQENbUnq
	dKszcpCMIbDWFIl36tixOX29xq7m5sM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-4o0-jpnHOVS2QLoIetWRbg-1; Mon, 10 Jan 2022 04:30:59 +0100
X-MC-Unique: 4o0-jpnHOVS2QLoIetWRbg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeWz3k9Glr/shvK5UD7c+62IJh6cPRkKRrdY6EwU0C6N1sFzvu6ubffVTvuOFv8vts2oa4wZlrx5sF4wBImkSLbMPYYC/ePyU2qKLplsp8kAg7qaTcaYskclc/VRyrwwRJDajj5fz+IX8QDgkT5yF5OHMwmvikxossSUTREStSZcrNLLop4+IsGedbe2MTsyaxMpxgExIibamgYgsrYiFDUl54MMIGxIIDtcCu/p/VXFCfgW9HfiZD6+ZK359OImvhVlZv+pwEJ5YteEZOot2BZa6CELCt0gUewKSKjT1HmBqJnyTJLDtNySPjHOWym5iIs9v9WWVBVV9hf6HX8iGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWvZTyWOj3dnQwRdB+Bjs++OGxSvH8RGjVm0WvP2P5A=;
 b=CBSs9hsCzBpVJPMF1F2Pa7camCi1jJa3+Wgg2faZeqQwV8O58X/l0ODO1eDxM7icz40a9PT/TpYZQkctO1jQFlFCu18Ldg9FUzEaFc6UzcIP7kcMtld5C9zyPXva8zrX73FDy30/ity1tfv7odBFwFBnHBlU8wmAZORMltq1eFhfGvMyMuHbWHOf+LNn9F+TzM/ij6GoQl9/ptT2uoiYZB/h7tb4/dNfQ8JTvkHh+aqBYx/9dJqSuJwYbJb9wXNo2IKdEXPihW5HZxVrIELiQzwDqzfhbfCYm1ct2dup1oJpoN0EVLjqXACwecMLCpOLt/0BodS8Q/6CrerqGJ/nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2569.eurprd04.prod.outlook.com (2603:10a6:3:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:30:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:30:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 6/7] selftests: mptcp: set fullmesh flag in pm_nl_ctl
Date: Mon, 10 Jan 2022 11:30:04 +0800
Message-ID: <aced78f0ed1d1703620c5ddae10196933f1765ad.1641785106.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f42be6d-26d4-424a-ec05-08d9d3e99e0c
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2569:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2569D6479E8809193885349AF8509@HE1PR0401MB2569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/waAgSVCTrHlcv9iLQGE7Eemo2kpWnUMGy6ODUBvFv7LUQC9Px3j/cx69cTnkBitOKGmnpAvUlB1YDrObk2Ywf2ujAdZDKYsTN5f+k5WFMa69lcrAykrb5J2iwJDmwzhPtngqkjywoQZXdIiGaTFa0S2rBCyBDyQHQZjY2j8pNedKK2bseAaL6b78XxDbm9LwZyXcNqvQFvZ+NFjgMRHzi304PN9+hFH4g3SG8IhQUh/hTY45pl1tYtuAefYv3NUzsBhWEYp8EjcxPfHCyvxS15U/89iq9e+Lnol2DMlkclT22mZJvL30zargz99CU4iQrfx1a1fQ3SKWV58UiEFgmSBGssoLk3rVQPzildjwJBAd7Cs+ZEt945hmoZlkZq/o1BThoKx0wgBqX8pJsEXZw2GqJC6bxa74eqdjalg4W7Sp9wy+k5nSGnDCLLSYK3tM8zRfO1R/5PuV3cGcuUN1k7ChowXXOkf3GWx5Vt8IFoVcf54DN5urHL5kpZg/Qf+Q52+b6QlfbS8hyuEVYkupCsDuu+t32nuEKErVfJD9QsUbushtoKc6AeH/yX4fe9a4FVCi4YIsv298sPK5rJMGA+4fCaiIjJOFSHmk3RamAQfulgNVIGo3BaKiaLHupu/krdaNHcHRWJteztqOWbGOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(66476007)(83380400001)(66556008)(6486002)(66946007)(8676002)(107886003)(44832011)(38100700002)(6512007)(2616005)(2906002)(508600001)(8936002)(316002)(26005)(55236004)(86362001)(186003)(6666004)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spZ20lXnc0XFPXiUSN+aRO1UfKVg8AgHDA0bY7NUOd2mfOWoQGFk+/dY7dYN?=
 =?us-ascii?Q?7gJ+L+ofp81Y9Esydxj4Z8cvK5oAHNJet6ArMIGRH+BkZLywCFlv5So+AJ9V?=
 =?us-ascii?Q?ZPjb/SlPA/MH9+z8tPceHvXqnZS70lgdvEl3oC86bpdPW5s/4taZLTGlMaTi?=
 =?us-ascii?Q?i337nZLGzXqLQ97ARO+PD/BipAFlMgqFbwj3kS/nzH0TQnrkvd423caFyL9k?=
 =?us-ascii?Q?MSsH9IHrBoE0Cq34o7PF7CUjHX3s9p5YcMdyVkTYUQ5Ty7jEg7oGmrYwVj1y?=
 =?us-ascii?Q?CdfI9sEBwA1cZkZ65WAcy0r17UkPXmwGcbNfdY1V5lsDeIJ4fB4ZiY5qpKVN?=
 =?us-ascii?Q?bTxNtS48pRpmyqeclxraEUrdadq6zZjTzgaxPVBvB+QepA/VnRNi9EVnXHLb?=
 =?us-ascii?Q?jiAq/G7NWSeCAN/vak20huKx+DY1R5u5V6mLYbQVTt8KridWczJMLBwV6Ix/?=
 =?us-ascii?Q?pG2DTvtAJhZRCQfRxLse6OqrjWQNuylcE/MpSszsQ/jM/NuRv1AWpZWA5noL?=
 =?us-ascii?Q?gAkHKG+tSBSmrJ0XUrbJOr7L/P7E4nFTsru6+7xt8EXo0JBIvu1vlLkamUx3?=
 =?us-ascii?Q?15Rx7ymH87n3NY229MIOwpjZxvlsNjprpOcoqTfjvHHJTsknM7P0EXyolFWs?=
 =?us-ascii?Q?H3vMDCz+xcP9YrSBHxHj4ilOu4FvfwNz+SDl+tjAOeJ+iWrjzoN07hiim/LQ?=
 =?us-ascii?Q?lxDfYX3fWjuJjBYXUWDn0P9ac9O9/Fst050dh7x0w6Zn2qOTtb5cB3GPJWKm?=
 =?us-ascii?Q?U4M2r52clcYSgjVDXw4uLyt///RptFcYV2Wjn0vdxTbC1UmYgbhSSh9f+CVX?=
 =?us-ascii?Q?D4DjXI2o197y2XIotS1nXD5SMuFECVjDcPoWVGQo6NezQASbEt7Oxw+V21mJ?=
 =?us-ascii?Q?VZM6VNyzenFBJOR+qwZGqNHF5aykDPVpHB6uS0FkmvXwOFq7rpDS7/1bXW25?=
 =?us-ascii?Q?oYzbGZfuaURczAyNh4gIj0qTIKCto7g36vsXUn0+AryyNCDPciBQdUiNyFWP?=
 =?us-ascii?Q?AUbyW7OBuwQiT3yjwS9fnoAdPBWn7lfoHHyKVpjSETc1+Ba7/adQG5laRya0?=
 =?us-ascii?Q?RobIE4FNlm6Wiqwe68HRyyr8DZtWNvqCT7Ku9MNFjvEpEDJgxhzln2ZQD92a?=
 =?us-ascii?Q?ac1UJNJ0beSK+Xi3V4d21dGDBcqXrI9Oj4EGIymJ6KxUlkd8nnp6iKiGPRXH?=
 =?us-ascii?Q?CRMKwBNFUAYxCiiPpo/O5flABsd2yjmQPca095kb7rFquYPqUaJRxcop1CHu?=
 =?us-ascii?Q?dBtbqhh+N+csw+lb/iKfmIvoJQqTDCL+C3TuSPf4sVT+znATNTl5jDWX7crL?=
 =?us-ascii?Q?/X0n3tabRnPhWDc0+KrdiIWmE2D/CvbVFUYVMbqWmlC0c0QONZOKmH4E7axi?=
 =?us-ascii?Q?FkUgcShTcVvAE164U0EjlxVINFZqNtVBBxk8r4Rp5lPwStxET3Qi5GRNFt19?=
 =?us-ascii?Q?ZAlx+nNS/UK7/TbjMxfB/DYskg/WI18FnFB64TmZryN3OEDgTSxjMFe5q2qf?=
 =?us-ascii?Q?2CPBYBr/uXjmQ8iRMez6Jvq+Os35O4BWOF4RtJxc7/898dBJ7Vbp1xrFWAQ/?=
 =?us-ascii?Q?T/FVeerv7eOTQEeSmdcjADuDvqJn1neJ52FCKtUxUj0ScErDC/8eWYOD6kM5?=
 =?us-ascii?Q?95ISplfoqUTiDv0J+9Lj9vg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f42be6d-26d4-424a-ec05-08d9d3e99e0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 03:30:58.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zd5JO19LPGzwe+ESTdEPDcoZb47xhNU+sfV934MKMNBP5hendpbvhLe+Foqbey5Lt+aVe5EIGNnNsVZbqLbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2569

This patch added the fullmesh flag setting and clearing support in
pm_nl_ctl:

 # pm_nl_ctl set ip flags fullmesh
 # pm_nl_ctl clear ip flags fullmesh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 85ca37e4b34c..396d53d8fcec 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,8 +28,8 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup]\n");
-	fprintf(stderr, "\tclear <ip> [flags backup]\n");
+	fprintf(stderr, "\tset <ip> [flags backup|fullmesh]\n");
+	fprintf(stderr, "\tclear <ip> [flags backup|fullmesh]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -711,7 +711,9 @@ int set_flags(int fd, int pm_family, int clear_flags, i=
nt argc, char *argv[])
 			     str =3D NULL) {
 				if (!strcmp(tok, "backup"))
 					flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
-				else if (strcmp(tok, "nobackup"))
+				else if (!strcmp(tok, "fullmesh"))
+					flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
 			}
--=20
2.31.1

