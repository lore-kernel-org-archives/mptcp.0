Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D82C80
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 03:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638242483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6NUokTcoHPyQONVgpJ/VnPj0Y+8/K5jsc/1lEvoaiC8=;
	b=kkbv5Qemj7Xevf+8FbZdW8MZDbF2v/VXT5BK7NkLXIAfQDFK5D+JFciP8tjtuHEwExVYby
	wNHlUUIVr6zqgzVp2OpaLAmy3LQEID9woe9+j5cO/o2kK9hmj5Hv2FX77l2VoWdwquillb
	s0lJxCPxraUq5aphGYpXt1SZ2VCqeLw=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-tasx67n3OeS6NlEivq7SYw-1; Tue, 30 Nov 2021 04:21:22 +0100
X-MC-Unique: tasx67n3OeS6NlEivq7SYw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRMcnidbBmt/RPcL7GcQQoZJrjTyWUH7nzlB4nay6E3swiWoJGjrE8PBraR4dO8futcELHLz9ZtsmHPmrPxYseo7gLVSEOq15wMXXraeyEOHsLC7sTunefFW1vgQK7I264QQK1s8mTxjgUqsBhgIrn0wXFsTapMOpAGGyn2HXUKLNACRgY8v2v+a+EntkWQskUOek+ujS4wE1C6F6EhpND6NkZdR1DnkInc9R1po4/yEoOLz+8u8lYQ5nbmL+KuxsRmSHrJ7uT1Q38WvQXI4r7M3X0yU4K6v3ECBX94lDbWtcfVJSnci+dzIiMsTKCuTH3zjE/a03mPwn/CdHVrf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPlAKEC0rl811ScwBmrtsyI2AKwJzx0SuEvUPej5mwY=;
 b=bwOIQ4U1vINicXgQ6CnMSiAPmyMWREF23MqpRe1IjfULjGMaZ/R9PuaC4498hEYMvDsGowbeD4ES74NHRCCP0+hFfWDgB+jakkorGBncLjHEnuynG/T36XIXiiCe1mdcIacwUvRyY2WoBegONLj9Gy4WyeN0TDLpxApnBF9MG5aNw+X6ACEEMYeuBIGQXfKwpXju41gZyx4RvgWuzSNLZR2bY8+xNrSvMnaK7YAvfDpP27T+DmfaYpbI8R8A/pQyCo3zCSyndrMYSH3yOq0mg2I5j17AJiAgYLpS/pSXWIFOoZv3AWAudw1qt7s/DWdWoKaNJgL6MFKBfaoYktoboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2346.eurprd04.prod.outlook.com (2603:10a6:3:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 03:21:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 03:21:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/2] send MP_FAIL with MP_RST and others
Date: Tue, 30 Nov 2021 11:21:06 +0800
Message-ID: <cover.1638242181.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR04CA0066.apcprd04.prod.outlook.com (2603:1096:202:14::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 03:21:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 960c046e-bd59-44c9-7935-08d9b3b07b0d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2346:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2346BBEFAA48D6DF58C0D364F8679@HE1PR0401MB2346.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IZoKryjulPNdhbeM+b+W8BXW2lXH3nZkmEGNyhUdbFD6ieXZYZOCyvCsvjWpCNohAuvN9LNVyU5AtpN5QUeflZ1SPzfhMqx3uid9O4Tf4NTH8lob9N3+GjP6TupIsCCwZV7QCSQDFY7YVF/UN95yZjaZtOtDQ8CRCqLoKypuIBvVaXR7O0+sPxaUtlP4cIzqQtb5KM7U6dgbVeWILBCT4o7JALrTCyuyP6Nd3ORA31nGquy4+Z9dp2j1O15r2jWuyH+abC8o/33X1SJPNiJli50w8qhuXo8HSrz2i2ni7L5PQxqDQpoOWycTs6prPRyoTMDxS7SzU18X+pTbuI9vzRFTxnGVoNvszzyHLCTqEXUILnVkgKdShZvtwc6mn0mUrLc0bDaoU5LXKs/qU2P1IvOUwaFm18eCbGCRnQy3xIFfKYzL3jhGdwVEuUUWUtvfh3qcT6RV5uPyi6Fc6LFMvA2kIPBb3s3G1gXbYRIEcn5YgaVAzglNNOgbJuveYNrAKZ+SvTiVUScziBZsVHOcUVbCl7r1hQwN41rIMLfYF/7peVdl12NKRvPzLaaDm6ZTvxj/YpKjinucOgGSE4+iM30FnBgg/mD23456jQ2vYWgWnV7m0/B4DDl/osvGXvvRjXBp5i4OxGoATla+5AjErQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8936002)(107886003)(83380400001)(956004)(6496006)(4326008)(508600001)(5660300002)(186003)(316002)(44832011)(2616005)(86362001)(6486002)(6666004)(36756003)(38100700002)(6916009)(4744005)(55236004)(66556008)(66946007)(66476007)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxwtfn1zwrPUKYMmDbMvNwdXqopi+IvX+ZuA7DoGQ/qqfyEaD2qlrgtZj17y?=
 =?us-ascii?Q?+R0o2Msd5ZejqcsxMugT7zpQQuPCMGuELVrPRbF9nLXbBRQPcyQxMY/FRinR?=
 =?us-ascii?Q?Ys0qIhYxyF3kOApNgKKd8T0CW6w3ukP4QIr2TBD1In8xZvquamfS+pLERxKh?=
 =?us-ascii?Q?DqCZtT2nJp9agRZd+jvjjSCxy8p9Ok/F78U3jIdIsbUFp1VNxt+hvGENJ3CF?=
 =?us-ascii?Q?oYuoBgAtOkD6bv//UL1Q4plUGLDkZQcKi6ztYACy7QrTkOieTPEnbL+uaNQa?=
 =?us-ascii?Q?tx3TC21MY+SxA5MjPUSBeKlKMeLh7IQG4wTEn5u+8k1M6tUG9zB9TTWjS4Z6?=
 =?us-ascii?Q?G9JTAYzq+va/a9kxRiiDlaARrFtKNX5OUpk4IUYMfZ0jlinZ63oZvk/5DNq9?=
 =?us-ascii?Q?LZ5YQ/9uhs5VBq/KlIRUsQ5X4vCuigzJSG65tuidZs99I+MMklo1UmeoCGMR?=
 =?us-ascii?Q?65JQyOTw4bIsB17siE8ULrFT9+j8gz4qGvNxofokJ4L9G/AaRBy1HNjDe/iS?=
 =?us-ascii?Q?It/wveBSCIwjbFQ57ypyHRBVWSNpLt8dg+ufyU/HoHnyO7ujIBj6pJhA/psp?=
 =?us-ascii?Q?et2Q5T22h8eDKULI7GX7O/4FdBQ9R22o5A5f4wCnH1+Qhv0oUoytL0+5Rw1V?=
 =?us-ascii?Q?0KdHOVJyuj/x4WJCuUpjPgpBWcRvTIJ2ZdmZnXqmut7eLxemXU6WEs41fKkz?=
 =?us-ascii?Q?ZOQ4uV3EhOZHOWQNIzktEtp3xOyjCTz0xyDIT9pJ37mCty1g1zyQpPwpY3A6?=
 =?us-ascii?Q?ARiF2zFjETstvJ5YXYCV7FT4zDInw6QRSi6i319ITmXKM4nBDv32Tqf0aNwE?=
 =?us-ascii?Q?09uWh8BhThhSt32gyY3HsmYQiNUrctm3Oo4e/2sJV+vxxi2B30CvzNqT1iRv?=
 =?us-ascii?Q?G1k2wC1tuf3RQ8zLX6bYk0x3mVIuZPvvTuNXBT5yuNeTtFlF0B+6qFbfq96O?=
 =?us-ascii?Q?ncuAi28hFKUQX8gfVwARpZbfymV4nwXJhGymEpPmcP7ul34QYKDP71awWH8Z?=
 =?us-ascii?Q?B2UkfxEAQdKB5LdrASSK+FRjIK+3y6Q9AVW782WWub1romPkOedhPjdnkqo0?=
 =?us-ascii?Q?wgxsYDPA+BY6yjCKTJmPdF+oOpgpK3wtzMf+97cmUZq31UXhb/OvH/0F311m?=
 =?us-ascii?Q?j9SrplsaQp1K7rb06oqaqtsMoWUHcAG/3jFss9jrZkyTiLhAxNMWO4kXl+NH?=
 =?us-ascii?Q?vQRFxUFlNnSOiuPoYIlXVi/QmBV6Y9Wfk/RwRMLjT4tn208J9XFnxgfGejFc?=
 =?us-ascii?Q?5gNUWqt4qbkDk4e400iwPSpguWXefCqevtdEQURgZpWNxG+BbR/ntMwvWFVo?=
 =?us-ascii?Q?TRWVFlkuUNlP/rC/2vJNZJixSRoY335NkFTPfWVvzLLioMhx51fqHnCr2str?=
 =?us-ascii?Q?aIsXsYkuk9D4Be/Cy0VvrpqbhiCuJiwjLKNndbJyziYD3lAjHp8oCw1AdkrL?=
 =?us-ascii?Q?9GPBalDMdp4vHslTw4Ti5JNZi5lbyajpPm2D4lVbaQBfulYEMSkCwu0HBGWd?=
 =?us-ascii?Q?cO0oZ15IduR24i05TwOGng5bgWo0S32ZdC8rtPXU/KTreMgTScKegfisBlj3?=
 =?us-ascii?Q?TKPOIyH/hiAR2cYdXsI0BFdN9r4FpCgF2DUyJOxYaV7wNcLBD7gRMd+muSp1?=
 =?us-ascii?Q?JCIxnLnLKnzPPvx2OK78/Fg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960c046e-bd59-44c9-7935-08d9b3b07b0d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 03:21:21.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgUVnUsoy+3bKwaTLotMkMshDRMJFm+W+or5ruiwdLm7tckUeqaT50TBqwXqiW6/BV7hJk79L4NQsNMskkiHlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2346

v3:
 - update patch 1 as Matt suggested.
 - do more cleanups in patch 1.

v2:
 - rename patch 1 as a squash-to patch.
 - print out reset_transient in patch 2 too. Please keep patch 2 as a
standalone patch, not a squash-to patch.

Two small patches about sending MP_FAIL with MP_RST.

Geliang Tang (2):
  Squash to "mptcp: implement fastclose xmit path"
  mptcp: print out reset infos of MP_RST

 net/mptcp/options.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--=20
2.31.1

