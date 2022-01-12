Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA262CA7
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641980054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjhzF5PoEJuwwWAa22cnMbzTBhyfzDBP4zMPxwH47Yc=;
	b=ikH+rlfRRzUl33NF58gpG1bG053UXTOcE0GXE2d/qYrO4nSp1hRIBFlRVooi6FKbD9UlGx
	L55MdAvBVPMKkSqFuoSO9kNf+JeRwPbpgCJ4bMuBagYIH/glueSXrjKO4PMQOZFq5lK7yC
	6MlOjTDpMDUPAWW7kbEdASUtbfkB0CU=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-hisTuzINM82bM2a2fjpqfA-1; Wed, 12 Jan 2022 10:34:13 +0100
X-MC-Unique: hisTuzINM82bM2a2fjpqfA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncK9XU2y3FpPtJCVlObMa36bgoNLmmxaY3Fv2IDOofvjFfx3hhlS6RQiTEIaayl+DCh/aZ633kW2P+QY7n9Lh8LCUJ6+AyBWyDxNdaFoIb5YqxTKm8bBKwVifj5BaTXzUrRf5+NMjHR181vdXwhM9r0TrEU3HP0C6gM63/F/xc76kWySuKZJ3i30+5g/GZ+gT3dJ+MDXNbG7PwAcTuiMdGnpdRqUUjyzDaG2xNpoX9yIY9vw4FvLeDcGwPViPPcUX+BpYaCIerPpKFugVrwpAGFRoKpywbZDqQpToMHGSp7SHyo+xUwuiKR+Cjlk8pa87MI9st4TAuYVWkRB0i+dEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07GI3ftnUr37Z1HJrB3SsxT0T9Jz3pwnTguJIgU49KY=;
 b=fX9cO8/jCuSFKrum+I3PD7f89L9J90y3JYQctFNeHIwVw/dzuVi5LtsslRYEf+JNGFJzjhZnqCA08Cuue6+TZ7j/j6z9A+5b2G8/iqCrIAH5tCOaUyc/HWXUEszu9zhgyluYvDGzjxIe8NslMsmy7jbAE5HvnaSnnlZDXw3LRi3l/+siyiysEshAp9zOiocHHKIjUqbdLxO46LyqEAN0MKvv9hOo3rLiylh5YKCBYwUJF76s7VhTATd1oFtutMu6Az8bTU1IuZpKWhrVeLEB9SVMZRSGqY/Um8yp7uzIADhncS6w9Apkeq0wjiaMfIQDI3d9N3d1GwfZEQcbdEiBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 09:34:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 09:34:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/4] selftests: mptcp: set fullmesh flag in pm_nl_ctl
Date: Wed, 12 Jan 2022 17:33:50 +0800
Message-ID: <f870bc639953a686d6d854870c69abd4eea3ac9a.1641978967.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641978967.git.geliang.tang@suse.com>
References: <cover.1641978967.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f6ce2f-992d-496c-7e21-08d9d5aeb113
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB42909F727F9EC16E53B46808F8529@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	92hvjIqw5zCv9lqoiWuZgtFppQBT5DhRSWW4F9yzspOE+q77x9iXIanhyzVqK+k6YG4NYQqkP4c93CvvF0Lg18HW5LnCDzaVyJPmDudWGEBersvpj0iXe16kxVBUYq6ebybjCXYQvaoXueI+G0qBlsdoaNYHrrAa2BFtPLtlGUW5dkxh+E4EYUq8ky559VLTcF4FEJ/VhGJZqexjTFm/fauBCai3YB2srsykr8uFBHDMZdVE3hezsCi5aZ67mhaCvs9USWB5QqhfuLyQRAsK7ymUmy2Fkg0h0bmRJ/w0+HO5MmYICtzCX1Ccbmvy6YpMKHSPxNALbiXrpqCPF+J+MxZOEoweLVRUo9WI7mz4QPnPJpFUffn1buo3oQfOkFSk/Jn0Qb66X5GSMtm+iS7ciWrRgGhWFWqn5fjnibIFzQVyLSIryIjvAI29H0jMnHPYWdInVlp2pRV3imw7ZMX9N4bzMsjBb4nig+bRmdi2+0vXoNZ5K8Q63jGiifcvq/Gc2V/aarSSb3hWnR5iIN7heQdBscy2Btf7IHi7PUbbitSlacYAnxIco6FHbff64ZGg3TPClwqQmGLvPQ/Ql95b99pMJsJE269E2Trwfjz1/FFJOagYtw5iw6EbvVW3ICXM3UguObwCHaS+iOjGXkXdYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(6506007)(6916009)(6486002)(26005)(4326008)(83380400001)(186003)(316002)(8676002)(38100700002)(66946007)(86362001)(5660300002)(508600001)(6512007)(8936002)(6666004)(2906002)(44832011)(66556008)(66476007)(2616005)(107886003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNlG5Eg2vgqdEHAygdenK5umdXbwENS8yJSi6nBNCRuAtvG/bF5C+iYVqS0W?=
 =?us-ascii?Q?LB4iFZ11gmwwMfxWnb8VJu8b7hbJFLpKihdyfOHEuklgkcxZ+Ca3Twm9tc+p?=
 =?us-ascii?Q?LM9NQVO8S6HrB0ko4KKMTy9oB3NmZxPRhotNYHkHsTtGi2Ksi1F9Klpj+arg?=
 =?us-ascii?Q?1XX5U4azDLeR4kQTdrphYEPI6eaoEzBIGliG6YRN9vUVJm217NRue91jBtEX?=
 =?us-ascii?Q?TJiWVypnDd6Y3aHXHTDu/G+45jDdiU9sHE9JU5ewwVMvf0hpPY1LtXuNZ8Ef?=
 =?us-ascii?Q?Ryv6IhtssdQr2QmfbNnkECUuHrn/hImc8DaNU37jAiq8/ApDyffZuxe7NFYX?=
 =?us-ascii?Q?KwBMf+II0tjt7mLtKc7jI7QaWQTTLz4v4qxZG045mjt8Z+8LWG1oBPAGcpX6?=
 =?us-ascii?Q?9JNFXw2OelzF1oMXRmWLkzZHYfUxm61ttiAUQcHrXAgelKg9yxj9bl12NmCJ?=
 =?us-ascii?Q?OL93IUddxfjlfSQEvOJ0Ff1NAdF2hixDXchLDmuUvBtJQppNPqDaE+tvNO6a?=
 =?us-ascii?Q?PtXlDdwR1gRw3Uu4bydkPB1hw2ZFEbFZ15NhOYiJGlCGLQaLa/hVW2RTageP?=
 =?us-ascii?Q?Qiot7hHzCcpgYFcO2Q+C7Ir/r4RcQjxwzrFl3xLOLL20r8iuwgB5MZ1YdSQ+?=
 =?us-ascii?Q?p0tE8DVxanSLbF6zUbvmtvNY3gOPBUt8sAesBTwBc5Moyq+I2Fxhf4Uk3r9K?=
 =?us-ascii?Q?S1DMZ2BSFrhTEMho9hA3DLWQPAsNr7eCChlm7yaIR6flLd3MzFhgpge6UoW2?=
 =?us-ascii?Q?sHygVqtYtomWcSB/jpE/nsabcI2JVaQHKuzwH5+SqapeAUYplOMkTUVxAbnN?=
 =?us-ascii?Q?9yX56LrlovUt7ylukPOPilUV/BwUCMHIEJVKEuDlir1sdUdJp9t2uYtpXIWu?=
 =?us-ascii?Q?EK+MCtdDINfLLmXtJgBsnyuyIIX6haTPxAVP6CoYE/7d3Q2QTZoovJ5z26IP?=
 =?us-ascii?Q?CLmzTCXvNlv6g+PRWfRXYi1pHtym/e7JjTIHSLQ2TNEDx0jaDCqEZ/37STnj?=
 =?us-ascii?Q?/hEdGTtF7A8UOmIIXERKhUK1Sc9iEX1wEnSqZqxsQX8bXo/u0AMfHDwcttem?=
 =?us-ascii?Q?IOs5X8kRr8xA+zdB9yEq6YKmL/svNggPIk0CEsTlzyKYAd2uVd6J3TPMb952?=
 =?us-ascii?Q?klAbeXhbj5BFqDERsg8N0S7mG9jFW51id7wR5QAQ7kqxwsTKZVHwzTpqyEG0?=
 =?us-ascii?Q?iynKs9ZhZH9CEFsXw/xbtTE43yTKSBLsJZsCl4VZQKw3R8uGoPBx2d8nsQz8?=
 =?us-ascii?Q?iMB4OkWXYh3Lt/92S9oyVnkeM59/BUIrepcD8e1N6F19GQ7gFSNDl+s5DDRt?=
 =?us-ascii?Q?fHRW9QCV/0a23o7ylnKozTAJ+F3tKKygKQ8Dm0OQqNXv9K2OmaXbwmbv3d+j?=
 =?us-ascii?Q?YTQwp9hpx+XB0NooggNVkaXv6ZZPpPMoWGcRL2i3gMokPJ0INouyETUbH+a5?=
 =?us-ascii?Q?MmXZb8cmJz44n/at1HNZJpyOzMZ6rSnmOZgc7sNBDBflPRncbaK+RgcI7sdt?=
 =?us-ascii?Q?PTalUOrjvGQ7/xR2YQyVARmNLAyqeVwMfUxcg9GA+8ynC8i3K7X196RKf5ry?=
 =?us-ascii?Q?NgFuFF8qouJEUxLU30Syjci9+SluchfpOrdKw/jXbpLzP8hE7py9+dxQVhe+?=
 =?us-ascii?Q?nBTSflHcLY8DGWZkygOE0lg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f6ce2f-992d-496c-7e21-08d9d5aeb113
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 09:34:12.3693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zg0Y/1dYIlovOQh23QB1j6NDnX93If505ihgpqO+lb/v4qYxa3xrTXgp14Jx80afPD34NGTmhVXHV/vGNcF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290

This patch added the fullmesh flag setting and clearing support in
pm_nl_ctl:

 # pm_nl_ctl set ip flags fullmesh
 # pm_nl_ctl set ip flags nofullmesh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 354784512748..9b6db9d77223 100644
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
@@ -709,7 +709,10 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 			     str =3D NULL) {
 				if (!strcmp(tok, "backup"))
 					flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
-				else if (strcmp(tok, "nobackup"))
+				else if (!strcmp(tok, "fullmesh"))
+					flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (strcmp(tok, "nobackup") &&
+					 strcmp(tok, "nofullmesh"))
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
 			}
--=20
2.31.1

