Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60C2C9C
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641290325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fT5WE4HUN616GNAIlRvysbuwH/OAl4cE3AQhA8SaVM8=;
	b=S9ln0hgZxgcnVpF9vDF2itsx7wjgRcM7pLrrPp2VPxYGdx5eyjNeDrEdeih3YTJ3p2lC4u
	b7cobr99n+MUVgFIeQQmIbzZaiKhXjEE+lwpGKF7RwpRfVIdIGGdjaji/Hi9VgBBvotrXR
	r52IaHUEoTyaQNvU2VLdufZR0mpgfdU=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-l3YW5jw5NS-PO1HsimUQjQ-1; Tue, 04 Jan 2022 10:58:44 +0100
X-MC-Unique: l3YW5jw5NS-PO1HsimUQjQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFl4wSsmGcbkQfV4fVi4xM2ZCpwd4d7bZkGyszpfX1KvKmma2bHLoYf09keuosa0usi8rskCBqtwdW9z2sLx0ZTSnHf12+zMMFIDrNYKxADE7fup6ydlZocXgT7a3ihqHPTsBZiMpvD/qc2U3BKjhjmeUZjeRvS3KHycM4hlQl3+rJOJnABw9Ff8pQZD5cP8IJ9KlLfi4++ITeCbxQtydgWJBw8Z3ldO3mQ6moOD+2UMSllv28nPIK+0QBgGtywQgRqMwsXBVXZoyWBkrtHKG/IibHVv4JynhHicsymFyIrEOpWlCrhPWSdUWiz+AyJGQi98fipCclHRB9Z69l33ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t4PGXLM6aZ7d7U9cTaWDo40b9yZWepRTgTE8h10y2Y=;
 b=heiponmwQPpwqFgCFhVLdcquFOdNqkJgJjMFZUSEGkOsEnOGfqwP21yRrPbR9hDBhsVlH/O51V4ST2fQLRr5pwUa9rHNZvF9BZV+hu+vygAbjzT4ndU89c8dOU5MXTP80RfGq2eT1nxjZweaVzSQwTT7VME+jB/gkBwp2smEH0fIsS3CXy4/T0J8VmqBOASnVpziLDN5IxS2afKN3vRz33eeGTKk6dKhcN8V8hnwFB8LLJBuHC80Nl/6RW3kH+LFQkTHVqVp/jG1cYM9ARMb/Jebj2iuBoCXe4x9vrqXtV0lGxDVywo9lkIsCpHjcc0E3GV1dNEXvMlExBVjXP7nrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2428.eurprd04.prod.outlook.com (2603:10a6:3:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 09:58:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:58:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next 2/3] mptcp: add the addr flag fullmesh
Date: Tue,  4 Jan 2022 17:58:17 +0800
Message-ID: <9c8ca06704469b7c1e5504b99b77134ca73a7bac.1641289518.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641289518.git.geliang.tang@suse.com>
References: <cover.1641289518.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 024ca86b-9e69-45a8-ccc2-08d9cf68ca85
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2428:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB24288EE028482989F3033116F84A9@HE1PR0401MB2428.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f5HGu1tDRr+zT5YKPhSseHB0GEK5BP+IpVFxSX1FxSEJgfc0p0llltyZsZrtPixqsPpadp96mmxDJpYvRqYizLmqfAS8QLPsoVk/0UUBIh5p9F/m2sDc8SGNWkehbfPPSyPTyjiQ2xI6GzYMpojr0SimsQkmEDHF1X1ChGP0j3U3kEzu38O7241jAwlOXqv+19g36nEeU9ZnsGYmaJH8BMqbwFMuana/NUK9+sdfg+yhdX9xOxnzfcI5zLk8m+rrOEy0wbjFWFe/oYJ+wum2dP5CdXFQu6ytFkJ62MXP/f8Y3YqPdvasa+p8K0G7km/Fi6Nqy0poJDOnIfmN6MdgAM53qymZNhqEO2GFxQuWOY+3/FLpbnAi+55PgNaRkS6m75fji0JJKxOu1RJsCw0S6pxdLrSxQdOIIAJhJlPN3TPKMVfichIQO/07fx7pW+zvuZPBol8yo6guobsI0Znv8Vbp+npTuX8NV1DzrZW8BFHgYIHXcM1UAP0FStioRk0ki1nYyLyDCS6LGYYsHg4xrUcbq8VEBkoUpYgd2EWXgY3Z2Er3alwYLcJc10d5QQKYhvpe83rTuofcocNcCHQx+ndL8eBNM52duECbfs8irlfUkp82xWQTsb+K00mXa1zW5pqb8qk+906BOF9SlpvGMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(107886003)(508600001)(6666004)(83380400001)(186003)(8936002)(55236004)(26005)(6916009)(8676002)(5660300002)(4744005)(36756003)(2616005)(6506007)(44832011)(2906002)(6512007)(38100700002)(4326008)(316002)(66556008)(66476007)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkJ8UEOY3ieklOAM/IuFXBM4ZjEf7E5WnPBeH5uooFqd43wtp+fWBX3zhCNx?=
 =?us-ascii?Q?YRLgKXtJ/TRWRkCuLL6J2F858r/9woEcVy7gST+rS5Vji9RDnONXiyx2WDnN?=
 =?us-ascii?Q?pNKj5ofs4oTZ24GFnuBdDJgmmdwuzKnOa2u/IT9zObHaXgQx8QwUQPsHN3XD?=
 =?us-ascii?Q?CdpwqRnCpsGskuJIe5feKuow9wMzi0r+0XNTA18e7thsxZRkhjLL7N5gTlwJ?=
 =?us-ascii?Q?ZlrEWC2b9+xJSgthekE+O0z7cqoHvqo2o2zP8G3iDYd5hiunzQTStEIkx4UW?=
 =?us-ascii?Q?ayQKqjafurhsdx8qG53jDUggG+H3yeL+k3IfHHVoAPpYMSt3figyqhK4Tez3?=
 =?us-ascii?Q?f4i9QMoV/Ppv1EEnDRaMeQBJ++fLEaQRbmlYySoyMB6jrKuNbnF3vo7RQDnG?=
 =?us-ascii?Q?oD4EtJpCwQ1SO4w8/AgCZ+XGGYmUaEplrpUxBBnI8wzTCCxmHM95NP0cxyWU?=
 =?us-ascii?Q?iTe/J1XCJJmKeVs8On1zOjnSEFBaxIV+tmgjtp5AGa3Z9sTNiRLtA22PU7cf?=
 =?us-ascii?Q?KAycjhiXHn6QxmFvGFwRDJDG2LHVvUBfhcZ+BT9j0g02YRee+IXUkUaFOBkh?=
 =?us-ascii?Q?IKTVedWzBUUMHtqSRHBgUQk3pb8vVrp9nASnJLoWFAmxdnHWeMojtNW/p8T/?=
 =?us-ascii?Q?1iYgONaUl/Sas5jN0flxHhEDO1KLzyczEHil+ziiSgaONLal/9ZYrT4+UIeF?=
 =?us-ascii?Q?QHl6hbWqateJ74Kuuu8NSz0GpYuGk7IWcCJHw6S5XT0KPy5PFF9pZi6jFQBU?=
 =?us-ascii?Q?PGWTr/5PE3AYsfOsx3OTtlDwumyHpT3fwpUWBy0gc72koDDZfdTcANePoHx/?=
 =?us-ascii?Q?w0JINMnWBjjDr+1dPF+HxSZhFqCNqknSkni1r+00bVuVD7vaom/lSzRp6xaQ?=
 =?us-ascii?Q?s6FXycTyQVsvke8cfMyhxzS1g5SiUBThV2xu/nvj8IRc4HQQNDCOAER8A0GY?=
 =?us-ascii?Q?p/q8JU4b8DnpGrMmA9QyoxEW2uk64diMV3U2F6GylpTvNSxTgK7dwd5uQ8tC?=
 =?us-ascii?Q?NuA0GWVHYEIiJEQfcFOR8Ksp4nxhxYHa4tY/jkkdHMM+qw9Wb4VExUs1qYfn?=
 =?us-ascii?Q?5cnj9sc9Ny6eH0Nir6Q55e31b4gz4sXRvH9h699RGgCkOtXaAG0IFSbvPHfd?=
 =?us-ascii?Q?WM7e5rtkfytk88cKq56s85z3p67ddCUY/7RCidv1eDCOnML3DA1QwXCHgYVx?=
 =?us-ascii?Q?66K9QDAheSEL1/wwP0tcQp3jskSTenoN9L+PPHg3ksKNuSVEDETf/gFut3ep?=
 =?us-ascii?Q?I5H9ycloAtAisQVzr5k3gHg1XCXDKybxA8E+zTiJ7cvBuxno9/02P2Bs25/R?=
 =?us-ascii?Q?Mgl9gyu1KmZSBTN3Jw0FAYcj6kF8WDuTohyw1KBLQELIL1tP4uUb27QtqnZ/?=
 =?us-ascii?Q?SwY6jDK6tDUocLtuFeWoMEQTs5ZSuCmysHl79oZWf01n2cMmpOY/7esY40iQ?=
 =?us-ascii?Q?DXzM402He7L3XJcBjeUpfJ9wEVQnP+kz1O3icY95tWdJkYtxBJGMJcUckwUL?=
 =?us-ascii?Q?Vzl6OwUfRJx24a73cmtnOvu5qHPuYJL9pUJD47707fC0kOlT2s+xTBQTVjmc?=
 =?us-ascii?Q?F3HOKtdMPcRDRG/piJ3PHKlgnn1ni0Ako5pB2NO+yzcmwWTW2pARuptbr68y?=
 =?us-ascii?Q?3CKdQq1H+LDiBkpAHJ15gRA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024ca86b-9e69-45a8-ccc2-08d9cf68ca85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 09:58:43.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fe3u0JACZ4dqqMAMEg4qEZOpJk+V3tFu7kJWGYyjaIErivIfzb7QPeoW85GmrmOMUWSI5Y+Rau3R7SyeorOooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2428

The address flag fullmesh had been added into pm_nl_ctl.c in the commit
371b90377e60 ("selftests: mptcp: set and print the fullmesh flag"). This
patch added it to 'ip mptcp' too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 ip/ipmptcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index c2691ef4..8c4fd18c 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -25,7 +25,7 @@ static void usage(void)
 		"	ip mptcp limits show\n"
 		"	ip mptcp monitor\n"
 		"FLAG-LIST :=3D [ FLAG-LIST ] FLAG\n"
-		"FLAG  :=3D [ signal | subflow | backup ]\n");
+		"FLAG  :=3D [ signal | subflow | backup | fullmesh ]\n");
=20
 	exit(-1);
 }
@@ -47,6 +47,7 @@ static const struct {
 	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
+	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
 };
=20
 static void print_mptcp_addr_flags(unsigned int flags)
--=20
2.31.1

