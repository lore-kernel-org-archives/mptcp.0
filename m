Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706162C80
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 02:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641868987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RriQMTiCuVoy9zncgmY40yywAvMVHSaoEIRSSOWsyc=;
	b=dBKiBssSJlt1oCf0h50Zl8wSN7ZNRNpjRsq0rya/+IFyIgTruXW2/A+C+xEmSCYdSCp8Yl
	tKWPUCWtIr5uTdNUmSXE1eG5DMm/twFNNJOmvZqIjg8x1BlFydSKwPbQxPQxXUlxDSEWLB
	4VXHDzzlLAcHssVRs/09xAEqGOcTGJI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-w9MR8OhZN421HSy-F0W-IA-1; Tue, 11 Jan 2022 03:43:04 +0100
X-MC-Unique: w9MR8OhZN421HSy-F0W-IA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUN0cSbABEnHGm1INClCRMp6nRXxjhVEVNxZ7MoXsW9UPpRshX8aUzq0MhGHJ9uls8+BvMqZqz+/BhIW4qGGM1nbQ/BJFmzvDyn6qV1FyXFzAnvT+j2E6/Ky3lmX3Nmq64CSnIm8UV9RPocFf24Yn6D1ItZLUp8KxJrkvB5YsDJtHglqBbNCWxGBXn/YWRaDBCKwWDF5mwUlZfiTCdIDbxyNyLnq7X2v1+iAdZZegZ+j7j+YUVBzVpztRBxjB0zFFHVaKxctP88hjahuDf37tgiNAITsz1gafPUuRTdDLntx06gZN3cWoJgKJ8cGwA03MtXqC8Ar32Xqpdl0szaUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrM04xkGEtEYR4nTpHch6N+CeDH4YDyrbGQoR0sbqGg=;
 b=XfJVmpLXq1+Sq1RFruU/WnIsjH7ne2yTQ1necT2oYbTTwalJHkNHCfFbwbh3YkNisqD2JWAqOzsoZJiWaXNOVSWdWh2mwjnTi47KxSFPmeG3ghWw/ay0rheg2sPganSM9dZtcEOWnEzobkdXw+AhEaXGpafQ9scQ1PqBa8Zt0mnUnlzzJsPre8Wfy6k3LpyAn77ZtWsSBJIm68q152RZq8NTA+Xel0zmM8429IGmNqrj87mk0KgatUJ9fx7gLDpX/HrnDzi7gSEW4JaG2KohNCYCdVAD0Cl4fzU8beew5J8H3Dc1994FsW8lK6uYL7dfPWvZ0l9sBGLhWE9JomYVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3435.eurprd04.prod.outlook.com (2603:10a6:7:8a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 02:43:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 02:43:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/3] selftests: mptcp: set fullmesh flag in pm_nl_ctl
Date: Tue, 11 Jan 2022 10:42:46 +0800
Message-ID: <5873528d730c341d64a7496598fcb2eb18e4747a.1641868545.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641868545.git.geliang.tang@suse.com>
References: <cover.1641868545.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4423f8-6ee3-4095-bc75-08d9d4ac1715
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3435:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB34352F1CBEA8336F6D0A1B81F8519@HE1PR0402MB3435.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qoUiQUCepATY/8ZDzwYMZ4IGoDbylmnKPUwE1cxkhRGEaUJhBP6dY3LEzHENEUZd+EEI1XhtpZmWllLBD9iqPfyDccpWccrJNOmkK/39XOPiCgpVEAwkF5wv4XHRSkTIA9fITYgY27QMn+bwtiWebb2250V2qlsgzI/a3EaRT3xnlgYS/ipefWxsQFbA93uP4xW+10rmpXdigxUu99eelgUtqt8G+5BPCwsZ1kHA+J0Snc9UMDtg9mzdrBFMBitfF7kZmjmf3WUnxmvGlOvoAFw9+yCu+77OlWe0eHqIP8lHEoE2GKebG1O3+f/L5n68kyfylAPJ4XiXw+OHCu/mziv9ZLthrrOkjS1WeHkY6imkJWlMT88xhCAB0JUcrxuRAFhqMPz9iW1e2rfP4iwWKs2YnyVZ4DxlsQ8x5sDBZWmNDqCUbVJhHZ3uwH2sF8Cz7Gw1OveJBE4iFc44BCxuOdXs6+M8yE/f6530ZMhNGI4UFFGklBSF4kc1jc3RSI1dl6XIa3EI+GAuBIU99Gh7gv9Rz+QSXfUXdexvYhkUWgjzsQdkoXVGUdfDXFF5dpxE1euDl2foAZDeDaCxCMZbx4YI0Qm+yBsbww5NMK93HQkssSUJkx3AqkSrocWV6WFfCRMRTSsjI2IfjyJcMnExsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(2616005)(8936002)(6512007)(6506007)(508600001)(8676002)(86362001)(107886003)(38100700002)(2906002)(316002)(83380400001)(6916009)(44832011)(66556008)(66946007)(5660300002)(4326008)(66476007)(6486002)(6666004)(186003)(26005)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1E/0LAWF6r54IBSIR+6Sglb6R1nJl0jUvlUg13ghvhN7NULxbBf+emXX0Fvr?=
 =?us-ascii?Q?SrHe3Z1uGpYENE0+mNrYaeyfYZ2Un3G9nrDz2EbKSI/sjBXYwl3wx+K38nTV?=
 =?us-ascii?Q?B3P+gV7T/ONZpEP8fN+JPFhoxS/UXoyVwyWUtj14bOazVDyjDUvkQCPFB7rs?=
 =?us-ascii?Q?VNLGKDWc5MvmFmVLjEj9owYZaRShdOkdsHkIrbQsKwsoPsweo6PQhEhdF3Qk?=
 =?us-ascii?Q?Cc6ntrxeSqSj1AV6L55RMaJOCz/A68hVDtIodG2gfoDhE2bbKo4qoEO22dDc?=
 =?us-ascii?Q?WMx2gwsUcWiyCUwXlsTbUVozLcx+DHGTFPS94RioltXP5xXKaX2pnqRRAIMy?=
 =?us-ascii?Q?xCOt9KuwAaviRfuwrBVYY1Iok5jHqngTkn1O9MS7IRerPqfuFoXEU+TthpYs?=
 =?us-ascii?Q?FPCzkzknzzU+Nj4bkjGRi5s89UX1UAhUeHOJ7eoYFojhHwQM8s8owzOTSuWc?=
 =?us-ascii?Q?2IeBOWwpdIXuJXOSapPjDgdb9MiU4Y5gYLXHCz9zS0oNJ/Dl/N8qx6ZMMwNY?=
 =?us-ascii?Q?PgDd31CezdPl2+CfYc9nhLv7+BedI5W1AkZuk35j3gzHeoKYgPz+NGTe8+Jh?=
 =?us-ascii?Q?HNQeFGtnuPs/VtNfLA5jNqFxnaQFsj7GC02BoDcreW8Lr3K6SkVuwzNxCWRh?=
 =?us-ascii?Q?0k8rFCo+nl4GVdTkDAPNyQjbkytX0R/ghj/mp/u5sXk4wRUQr+VtwLklrN52?=
 =?us-ascii?Q?PU+W7v+tR6b9TzSTPjq0L3nexSgKM5l7C2wP/cybfui2/o7zDX+WgnzVUalM?=
 =?us-ascii?Q?SIppNjskxvXg2JS1LpOJxP7FW9LFeGDHRBwYtzuonseXWtbjy0wwdKZNbGrv?=
 =?us-ascii?Q?UZNGLBECIpR6J3OyYlhplUAblzRSlomEz09fJ/Mev8Zd39drmns1BK1VsLsZ?=
 =?us-ascii?Q?cS3TbaN6r6RnRvdfPRYSLgSs3NTiSCWMd5XknmFGGyTK19jXWUGIryav0iBa?=
 =?us-ascii?Q?OyMj4AakN8GzJpGteY+dCB+i30WkltcNvteYbp+kxx32DZ2ACkwzGFugvGVQ?=
 =?us-ascii?Q?l8O8dTMZl74/WD7Iuz2FW70ZLNKRJgnGmZHpl/fkMkinCZ4u8dE9x3pkaU8W?=
 =?us-ascii?Q?aJnYEpMxAIivLXYDO1W0Zg4ARotxWupDlNbIt5EcLmX9jCSq/DVqfbLVlO67?=
 =?us-ascii?Q?PRv5xt1Tp/djvn86NkcVIE/dXvcRMQjo6S74iO/RwSBm8+Glx8VVJFTvST5V?=
 =?us-ascii?Q?YLiSU3BHUeMEr2DRYT7POyeO+cP6tUuJ1zF6/acUtrbVaT4UJ3hachtiz2Yn?=
 =?us-ascii?Q?sh65HuYD77wf+qu3NXAFtQLDJKGFggRC9Zl8/MIqN+cq+HW1I+td4mYk5/18?=
 =?us-ascii?Q?WFN03iLLBXDlGV6m9NdPGoFT8LbqeyTqHnUL44v+U9LXqyk6ItrXyF66tGHo?=
 =?us-ascii?Q?9cAbmMd85Fm/4QoW+e9Flo+6ubbOONCgy7q9LFLr/LetKq/m7xEbC31IpRaY?=
 =?us-ascii?Q?634wXAvgfJXhvgP2pIlPlLFKnWOtLPWO35ogcE1A8dUGbf4bCxE/w8dyDyz6?=
 =?us-ascii?Q?0APzGkfvb/L/nKlzJAF2BBGkGt98lJGS3WVUVLKbVdATwU90nfnLiSEhMfhW?=
 =?us-ascii?Q?lPofEpHOyqM4C5Eksp8qUqjvqVrAJBE9JsVN4gRZe+YOSbM9GL9RT+iLCPXP?=
 =?us-ascii?Q?mCvzvoopZNCVTvAl9IDC26Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4423f8-6ee3-4095-bc75-08d9d4ac1715
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 02:43:03.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X2+RbVjUy9p/QC6hipm6MFQwcGAaFZ5GqEcJbhOrDbEF6/24jqVj9jnnVNuXj6ZhO5zVIL0MzNbkESqIcqeFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3435

This patch added the fullmesh flag setting and clearing support in
pm_nl_ctl:

 # pm_nl_ctl set ip flags fullmesh
 # pm_nl_ctl set ip flags nofullmesh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 354784512748..db8b9fdb49d6 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
+	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh]\n=
");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -709,6 +709,10 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 			     str =3D NULL) {
 				if (!strcmp(tok, "backup"))
 					flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
+				else if (!strcmp(tok, "fullmesh"))
+					flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (!strcmp(tok, "nofullmesh"))
+					flags |=3D MPTCP_PM_ADDR_FLAG_NOFULLMESH;
 				else if (strcmp(tok, "nobackup"))
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
--=20
2.31.1

