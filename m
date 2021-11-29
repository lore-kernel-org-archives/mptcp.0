Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188F72
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638157222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kwF04D2rk+as1Rv7uWZNIYEp8YlONU2CYpzPDLLawW0=;
	b=Smvi1HJztgvhudyze1w/77l7Jb0KJcH1PeKTfU5NWWwScTdovNzF/giyfCZSsV95zV820d
	BmCfr6bid/9J3zBDf9jxNcsarG9jRIlEtJaAHJ0rIsCPzUR+QAZFDmzAvUj4rlU4HPHk9M
	Bo85NQs48EozT/aa9om+6AwnVzfx5vg=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-PVwqC_PqPsqmybrf6jgRUQ-1; Mon, 29 Nov 2021 04:40:20 +0100
X-MC-Unique: PVwqC_PqPsqmybrf6jgRUQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmxKfYqlN0pqjU8J0K0e0/Zi8QIMc0E8v30+eeqqfNnhHbsLxOcjIw+Y4qctRytirPnR3Fk1n5TN2T3c2rXJzobsfwR4FUMaRxxKfaH18MyJyf3MHn3GhjZYI1ZlkL//CTjiNUYW8fF163rZJXBvqW/TmkOgADYSYsn6pLe1F5rjO4HY6q0DHc7U+d6JJH79jaoq+s7c3EmsXaElWDSM8a6LevuaZlGMR2cUCx8Odo3k6B1eL1H9kwdt29sPnXlGAEyuf/I1cfDG5oYKMq4253PNvJJj7JwtCNpWWd3ogLJ/nR8MMVIQ9jSzlUOSA/dooyADTpvUCG87i/e/PxE+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW3yeHPf0RQuWP32pSXOIijS1tvL8BKueqR8ZiJF29Y=;
 b=EIIzPMe94nDRrsQ+IWZw6hGDnNBbmPuT8Qute10kmyUoVbSXpfDeASfy/hHCci+aUonx4tf21J8pdPPBs7hSahlXgUGwJeADp/hVUn017lM+W/h6Q8T95w5QC77uqeojLjERyMgNNhk47m9qzSZDlIaW/ps2jk2P4fmreirWXyOS631NJZjChBn0Du9bZ16lKpaQXSUCrt2FzBkptB/Z+PdO4kPfFex6OtoxHqIUTtK8WbhBVFbN6js6/Q+L4Jw9Ux9ienVGVZJTAs0lNRyMpHGPDGRAnSYhNzLO4fkBIl7F3Jjy0/5d6vh57FGj7IyqeXZ9ikqssmYGaJhZUqepmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2507.eurprd04.prod.outlook.com (2603:10a6:3:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 03:40:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 03:40:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/2] send MP_FAIL with MP_RST and others
Date: Mon, 29 Nov 2021 11:39:57 +0800
Message-ID: <cover.1638156809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:202::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR0302CA0016.apcprd03.prod.outlook.com (2603:1096:202::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Mon, 29 Nov 2021 03:40:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fa50396-b534-4af3-509f-08d9b2e9f62c
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2507:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2507AC5F8D133E003863814FF8669@HE1PR0401MB2507.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uHv4Iw7JcwYqNjSuvCuBK4lCE0Q59N4PRS7t9rVACIoOsqcTybmaitfDZC9zkFIIMsjazh3ZQWlaxtUOl5SaWeMICOV+MCUfzRRsnbsqNYFkdfmQSK2S4fhFq19Uoiai4ZnlJyc59ndq+BlfRYcsc+pu/6tOp5DDqk40kPxBFSL1vTY8kSYYH1HQbOVy6hdgAEvvmyKpWzABP6cnPFblTJQqKarioGZP5BOzIaLpvG3MftVJYS2hI+0NzIgI9R1Rkxc7vY//nwb4mrKwJ7lKwHyZartE7LQCy+cx5bDM9UpCQNDb6wwuK8+7NYYdgYRR5r5Ral8FL6x5GBxhKr5oQPEqZbqh7q3Qy7awS56wy9vIaArjVPO9h3roxjr/jfJU5/HLXJ6hs7+A1fJZm4V1c6GH7RZJLceZ4YF8YQZTem69owFpRMn7is98hNzYsqOQR1VxQnGdLHWc1i8w4zUJvCJrI9otaa/0vrOr30dmx6U1smAqTlRjjSceqmV//Mp6EMTNyueIimFuburmbo0JOtsMQgMfRxvjeOw2cLvLQw7X5D7TWtzU8o7Of9RSDPt19CShDCDjPOFNpY3IWSsslw1+N+6/5XCdi5CD38AJROfymT5rb86/H0CXRY/Pw8ONUyZOGN4yE8TU250hINgLKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(2906002)(4326008)(36756003)(6916009)(8936002)(6486002)(83380400001)(55236004)(38100700002)(26005)(2616005)(107886003)(956004)(44832011)(186003)(86362001)(66556008)(66476007)(66946007)(316002)(5660300002)(6666004)(6496006)(4744005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sXZ9VMyFbbx5MqakZi9JWBfW921hEmM83OuaBG4Sdce8mYMjC8Ce95XtpkgV?=
 =?us-ascii?Q?u03ebBCqg4bevMSxU9JO0jdz1TTvuqbcVi6PHnuvCsFMyuKsKnsl7/x9xCDK?=
 =?us-ascii?Q?cLWwrBnjqw2yUoGUX287s9XW/iLeQLPPrijomr/CcH6f1mhcnGEIQyC1r7xo?=
 =?us-ascii?Q?h1STN8cUfQyRy3KpfSUvtA2KsxS+s0PcccTu3bVmzmbPhHe5+FZQgZTVXMxK?=
 =?us-ascii?Q?GgXeLmutgPvchKNGjmKdvX3jvs4fYi08rBzqZMZIY582UQytno/L1n7IBcjL?=
 =?us-ascii?Q?fq/LqekgPMkS2jgduRzi8xunP5wHdV8WC8nvrkN0ZW0ZsuPzPnczVJBmPcBX?=
 =?us-ascii?Q?TSXWBAY5kzKdh15iB+yFp1pPS4yzalWcZSxzZ5S3+LEgSiGkkLCWaA33PMA+?=
 =?us-ascii?Q?IehL3lNWdXB0deaEtXVyrYygFHZmP8+PPaMOJYn/NSRSAKpNW1Czs+/IC1FH?=
 =?us-ascii?Q?calZps+8zGSWWh3JMSSfhdea1gFaAoNb/JNa/IXkFODJ2KxhyKE3oBDasmJf?=
 =?us-ascii?Q?UFHdOt7N6hAEMQoTE0dZ3RSt+dn1I6A0fLImVfmjyXP3SVJ8Xx1+2Uz5Qh68?=
 =?us-ascii?Q?wQJ5gUpJg2hEvnRYAmqV8M8osJYJxckFOhm/+IAluX3iGakYp4nD2GOETlGc?=
 =?us-ascii?Q?QpiGrv8XOnZaMH2DCV1/NzGPVN+BKeCaVxstN2rDjgv4rERGee5MetSCrUeb?=
 =?us-ascii?Q?UIO2dSCFUwOb1c7+JYU9pNTsPcx/3VDOsZVJjG7ZJmu2uRjQL9CYVgkOYyic?=
 =?us-ascii?Q?XX9YSxRWqLaeKyuT58ZZ7RwgB2yL8RKvvA7NGtkmAGBifgf/PXEZS2KjvOVV?=
 =?us-ascii?Q?BiFB1qtxVJP1TTS8SEjopfqKCbVUA4L8wfoEscr6gLTO6+asNTXgrqfR3lnP?=
 =?us-ascii?Q?0YY024/+R7PLs9VbfQ4dovstpzYGkskpHeZRATtBfkSU6/6W9TSf11tTlAtj?=
 =?us-ascii?Q?XDel+GHfF1Oi6YHk5/Y4cum+M9441M1MAwa4rSuIK8SPUrLsyNWLpg9/eOlu?=
 =?us-ascii?Q?ZIBGVQJ2NEyCrGWZLfck9aqmHl2Um5IgX53ntkIi/ZfNtM7DjCiQcozm1THS?=
 =?us-ascii?Q?483m2Xf9SEvJvcJy8tj89NZpUEQ0qCPTikOeQLtnvlyuFiXSDch3u3AQXXqE?=
 =?us-ascii?Q?v0KSsdMUzU8iO2EB95OfPKBm+p15c3TD45sTxGIIPY3sdMhPoAD9eAZnC+uH?=
 =?us-ascii?Q?suj6vX60TSJKlDe59NBSVihWsM20hVv9rVgxXreEnzOgu/5BENA2GpZXe+3d?=
 =?us-ascii?Q?IxNukUWnekkjAfgfPKKq+87dMPOhv4pdfzIgMmVgMKBnlB2HP6Ckb8OQKWOE?=
 =?us-ascii?Q?q9tmk42dTFE2XCGD7b+xviatELvup4Qy/rGEQECP9rZdA9LUNsQKqL+khiJQ?=
 =?us-ascii?Q?6VTQtNLwXDTKdnIQEamXg7MsqrMcRGt/dSHTQ5yIm97Va2swbMtlJ94l0FTl?=
 =?us-ascii?Q?YaN/ki00dPTjaMcXjaxrMtAfmpi5vMgovs6D0P8TtKinwQHvOvNN5pSbEWcA?=
 =?us-ascii?Q?w0rI1OV3LYOmP8RsaDZokiaao0N2PgmyRsWppbeuf2g2uoVCO+z3Oe3rDscq?=
 =?us-ascii?Q?daD6J+HTk8146Dfpse65KGED+yxg0EijPLhX5dVjh9oazqPR5XmvgNsYMm8E?=
 =?us-ascii?Q?fOCeXNkOAshpevdvyka3Eoc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa50396-b534-4af3-509f-08d9b2e9f62c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 03:40:17.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJNfapymzIpR7QQ8smKT2FsRq63ICEuZJAht8enRpPpavfMlWNB9b8ZMKskXBYLgAqGLX903tfihUdiPxNULWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2507

v2:
 - rename patch 1 as a squash-to patch.
 - print out reset_transient in patch 2 too. Please keep patch 2 as a
standalone patch, not a squash-to patch.

Two small patches about sending MP_FAIL with MP_RST.

Geliang Tang (2):
  Squash to "mptcp: implement fastclose xmit path"
  mptcp: print out reset infos of MP_RST

 net/mptcp/options.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--=20
2.31.1

