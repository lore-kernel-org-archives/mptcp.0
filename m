Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B229CA
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 07:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642749749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jsmqptivQeaDS/4LzLU+s3CVOR1bl2sp68W09Q2SoSk=;
	b=V+cSUJBLV5hf5edcoZWMSdWqpRUNjQAsolsE17M/C9Tlj/C3Pai/B1WHIc5kgABKI2+4Wu
	Vi4NmcqFc3BXWzUiIFyHEgcmvxmSr4hj+vanhsgSZS84368P+nGiYbPbQh3pLYUVslD6m5
	C+7txwL6j10qXRrXUqzeJQ9a35lOU3E=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-NV72ZaC5PKS_z1PaesoPgQ-1; Fri, 21 Jan 2022 08:22:29 +0100
X-MC-Unique: NV72ZaC5PKS_z1PaesoPgQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPNN/exyWUbZzRsSFD7CxcjnhCrw9AyvKT0N9q6FyIo5OabrVU1YHDm1yb8Do17YqGp4Fj7S1rBfS5ReyJ3PxsqmfEdeT0O1pJz2mOlYWdkCH33xFsH2uyFHxZOv0+17M09mh2X34rxur6CHZPAftY7nk3ZN/RJXsIkUlR3UK3+653aykKZVm3V2Y9X08iKIUk/j0EhaUH8GZEJE0WhF21UVONPnQlh27YgjUlLvb1ygZSuR7HnE8k38HQ0hnVMXFQAFtW8sKRUGWWvASELpJyY1hLNUcQYwHgIXX9KVAABYp9Xo9NkCgOC66A9/a0puEe9dTd4ElcuFHsulYjFnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGqDDJfxT0Ec4mCRyesAiU1fX8EK5hbdU0MAyGMdZKA=;
 b=iGMWTJ936FsPh+EaU2TNsch9y6eWA7sKqJmdZXWdAt0uOFw5AUrXpecLjchIxzLx1UE8Xp/D8DvGCij1XQWrrvqjuPUcx0F7QAYLPWkb18sSpDEDRdYA3t8CYRegbZ77Ioe9Ef/y+SsriDZ74VXkruDXBz3PvgIpdBBhgEY6hO/Ukr9nmPBMaPlXjJMcYcM9Twr007I97GLRGmwplMP66E9LmOA/97p+t3bJjfmfvYaMabAw8QfSr+TMKoZJ7yKuGMd0Fx/21M/J7yM1WQBhnAkTD24cK3PNSOth74/M6hHOYHouGgdnb/3yB2pv3p//YgrPRVVwEjC9FlyTBDz5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5396.eurprd04.prod.outlook.com (2603:10a6:208:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 07:22:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 07:22:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] add the id argument for set_flags
Date: Fri, 21 Jan 2022 15:22:29 +0800
Message-ID: <cover.1642749049.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc875c1a-c5c2-43d2-cd5a-08d9dcaec6e6
X-MS-TrafficTypeDiagnostic: AM0PR04MB5396:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB53967B2704DB0B5E74742F4AF85B9@AM0PR04MB5396.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAlgbLYc1Ekk3hFbJYv7qOC8LyQX6RW94/KlMGkC2jYZ8CfLtZLEEPmZuZKYJP9UT7MGmw8LOU7NbxtuYXYLWfraFOFSYi1/UM7GLTYiuCVcNF75tgB2JMkO6peY/JkBGF+CYYOLUO864NBdg+d4cKeO8w7isoGnm4iM0DXhzqECsom8k2BDmibOiKmMrAO0trgTPST6r8n31eJpyXMLyNOtiSIqFDYC4TKwt8MbJp+TOG+bTncNu5zz0T1Zm+5aNaBADckC2tUg28PvQ/fjVOe0fltDusVEjHehRHVnjIdomi6tM/+ccf3AILFnhj76d9leGexPiSl7NRixV4uMp2jMxHkl988JTNrTkV3Bl7BQVq8LuI2iDKqchJ3qOSnWtlF1lNCpiCxKcd8sqUd2RwkrFcpBPt/jzUqT5nAMsd7zHLjDA2mAOBKByJ8nMYfqKRE0j51x9BOCeKoOhvAaIdKW+F1ZZjdZ0NW9OSho+OWZtFQ7YZyFFt7rnll7W9wCfRavr77uHooaZV9zuzOYnpnYaEAOacsvTc4hL883wnei+8FPZpKjV2SOEVd8ofiXqeUa+qcqCI4UvqbjCTu270f6suNkhTNFPIYfB14ublR05JlJgETiMB2xN2CIbqdMvS19d7RKNU9bLeZpQy+n6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(6916009)(8676002)(38100700002)(26005)(107886003)(2616005)(86362001)(4744005)(66946007)(6486002)(55236004)(5660300002)(2906002)(83380400001)(8936002)(6506007)(508600001)(66476007)(44832011)(186003)(4326008)(6512007)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BoTf5Hgh6AfNA9qsRg/98BbYg8HnhO6KLBgj5C7jZgEwqmQUN/XVdGmfNGsy?=
 =?us-ascii?Q?I0Zwh/nWO1SSochmeLjAuR5tYH7PgdMAq/4KBCMBqjk4v01QFSgJMJrGX797?=
 =?us-ascii?Q?FWNufLdQW7dsRNlazSPcK1fhw90MVvyi6s2yZfD+0sih/JRbARyyTzCaDPSv?=
 =?us-ascii?Q?LLtLj/ojushziP8ogAeCfd94fabN60M7DarI3FV5P/eQtBoXq3oNCetFwDJt?=
 =?us-ascii?Q?01LPGaGkI9hb8rZzhxVA70a6/jpEh+fIGDsY5sHBwyrMjWvF+RQPeA5h9EYL?=
 =?us-ascii?Q?WQ7pmhQdVJsLd425kYUnd6wTN+Lw5WKJLq7dwkrg5WrvCc3HuTrEnte0I9Zc?=
 =?us-ascii?Q?8xkg6Dd/qXrw6kvh6Jdh5HCS7rkDjCVQOthdST/PovVgKvs9TA2qLs1wGpor?=
 =?us-ascii?Q?AuqunDRxQD1dFE2wLmBoqMmStBhLcsPnVA7FesNi5ZvzWg9g+1ViVHg2OsFG?=
 =?us-ascii?Q?MUU9uINXMpSkSHGlW8DNC2x9MGocu1PEEOc0GFd4i1aOmtJIkXZZjB0g/Oo9?=
 =?us-ascii?Q?+0L2jBtJrb1bstDL6XhT4UUpNVkSzb0pd7hcfpOCbtKfYJzNGUBG6aH7cQjj?=
 =?us-ascii?Q?3qvZ/F12aB1deKAqrD5iWzL5k0yt7Ot86ypl8AWpV6FiWPg+0ibjFamwPP23?=
 =?us-ascii?Q?HomU5OT4J6vb26XQhUYWYxhgT7F+Dm+XFnYkbQkhbU2OVJNPUw3ZmBpmAF6D?=
 =?us-ascii?Q?gDuKgfqQMybo5tWDC4ALdgaKIyQxUG+t7hAKlCndQLWKRcIcuQI8ng3c/F0R?=
 =?us-ascii?Q?3xI5XudV9PMsRJ6Doff3FCaYwqvH0wU74vh2KMrwRgdp5mZRFkIjM5Ru0vgb?=
 =?us-ascii?Q?QvizWlPQ+ujlpAiviVZxEnJ9MHIcf2K7YQmds1gKMu3PcNa2eveDwremU/zU?=
 =?us-ascii?Q?wbjJjPXsshfICZz3QPlmhAIb5PxJv+3cDAZ5B1zz9MMROlSLtNOBlCwyOKWB?=
 =?us-ascii?Q?BfA5SWnFgk8pItDeCzWSg/WTiHLHg7FtjerEWeKBZ6jtSK9YL7dsDiE6Kwc7?=
 =?us-ascii?Q?3rOnwZNLpZO42KNqEAgtQLmsHJRHpb341ZTEoAovrD+z9n84zu58wVfccXJC?=
 =?us-ascii?Q?8Su6MWcc4Jko8LUWkNLJpujR7BLTbrEZOEfQszXcAjSLt2YkFW5l20A9l8Dz?=
 =?us-ascii?Q?Cg14lNRWiu/WRGWTZCQVbsVhy7jpPqI49p49f12c7I/DLJUaQU6uSbrbVhw5?=
 =?us-ascii?Q?rXr/0JxNGjVduly29qPZXfGBf4IGY7dKSqkBeM2JxuwKJ7iN5h2uknb3ZBUI?=
 =?us-ascii?Q?+cv8gGDJkA9ChDk/hOiVCMp28iUAd1u7nri1tzY9HEpGE4RXvirRH/7y4/6T?=
 =?us-ascii?Q?BSSIv/vJvvruEh5pKfa6hqv2GSWGzLuFfG3vUcYUzL9nlSLuFhx8L31Sxsv5?=
 =?us-ascii?Q?9XjG+XrbBSmlyXInnu7nWwm8HOttzWio4j26NrGNqoR/MkR+Dx6LY/7AOSTJ?=
 =?us-ascii?Q?8LJQBZeluxtKd8BuWUhne3MaEtlN5vmyf69J706RXk+BLccpPM/fTYK4Uv/9?=
 =?us-ascii?Q?5aIBXIF9JnU26Ce0Y4dcg7j4LHBDY0m/EkV7pWswe+rwmYRoH65Z8eYEixin?=
 =?us-ascii?Q?ZBDueHivU9rzjkn2JPspBLVuWlfSCKyNrH8sZQsCSrurpCevBJ4WKDl6HPfE?=
 =?us-ascii?Q?ojEbFEKHFw9hdoousXLKUNk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc875c1a-c5c2-43d2-cd5a-08d9dcaec6e6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:22:27.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvb6Dbd18rsXkkarubE0cLebazmBTumh8m4zWd/J33u45U0H8trLXztJuwYDjO3S79SdvN+pX2oqSb/MTzTv0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5396

Add the id argument for 'pm_nl_ctl set', and allow to use the port keyword
with the non-signal flags for the setting flags in 'ip mptcp endpoint
change', more commands can be used to set the address flags:

 pm_nl_ctl set 10.0.2.1 flags backup port 10100
 pm_nl_ctl set id 1 flags backup
 ip mptcp endpoint change id 1 backup
 ip mptcp endpoint change 10.0.2.1 backup port 10100

Geliang Tang (2):
  Squash to "selftests: mptcp: add the port argument for set_flags"
  Squash to "selftests: mptcp: add wrapper for setting flags"

 .../testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 64 +++++++++++++------
 2 files changed, 56 insertions(+), 24 deletions(-)

--=20
2.31.1

