Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3B3D79
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645097004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KzABHU9FKlqO7lQYGLyUQn/x6y+skOkLvBciojskZHc=;
	b=P9RGu8CuXakbhbecYojdAs8QdiR/8i+2Xi2urivynCAIeZ0znm3vHOt0Q1+VSOP+I0Tjbj
	FypWSSYLO+1rA+nrC5vhrfIR5pfJACA3yxJDxgYHkaytjtfTPCDmeZcYf372fvEXthlNWw
	nn5ROE10NZMNxufKAK3DOiYCaADftQ0=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-YHg_tfurPuOIGL8xVwx0mA-1; Thu, 17 Feb 2022 12:23:23 +0100
X-MC-Unique: YHg_tfurPuOIGL8xVwx0mA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzXNEOJMKKuKvGbJW/q78icgyNGFDXTETpRrMvaqyeZrhObRms/1DWt33CFg0oQWhgpUTdARCSA8y4quuqa794WVaRKDW5mU65W5ckWEU76Tm6Wsn6pEl5QLLhpx/3FhitItdemuNNBJB4FxQkTn1k4NJ733fq78dahsM/RjGOxcd6SRlxnR+/33LdXvtSd8D3SnaKUZGOBF0PDixWiI55LB/nyEnTuPFQzY4cR++FXVqc4t9+PIa/1uoZt7gmzI6aK/lZPjJAv7m3IZfL8cwob8fm0N6Aq8Xw8VxvoLzQ8DGPpE8Xdk1e9fi2DF+NB95Q9fXD/UCQgeQREbeaXozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCeyuTyBo8xNJP5IvmqLU+bfKXRRvh2AFM9pC6Cmw0E=;
 b=SkCTtbFPQSX/X4czzCX4poUgaPKZBJ+d6/FZqHoANfyRIDmp8SPXVS/Bwj/yFntPsdi3/G/EaLzpmIVFid4JYcZc91Hs+xfPkwSa66kw+HAL0/Q4wNH79uLtfc5bf/fx+f+wyLeXOehAEM23TPc0Vc546CrTi0sWfGE5VmeIldRxaKsW/r+fMmtkkXNhdR1+5aLONNtPppMc7GIZWpqyOHu+y3RnNmEjWSY0J/64Gt9utmnFtQnPB4mo1pV6YTaoNbLH/mbe/6FLyW8T7UgcbqGt4SJHveEnB9psszG8Ev1htMLm97Jrvj4PNFwE2f5+2mzbK0XlgfpADrkMI7SoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 11:23:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 11:23:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 0/6] MP_FAIL echo and retrans
Date: Thu, 17 Feb 2022 19:23:38 +0800
Message-ID: <cover.1645096378.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c958d7c9-54ae-4994-7ef7-08d9f207e74f
X-MS-TrafficTypeDiagnostic: PA4PR04MB9413:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB941368D72C42AE1D50C340DAF8369@PA4PR04MB9413.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y+gZUUnyTge/dkIE8uNYMm3eYgYf6djsMyVZGAoZhSAbylsHkBzogfL5llWs0KGC9JLbDfQ8EEgnwA7eLFY6OkeXCEINTnlkX1RMVWjEDnAzANX4dmBqwmiJAOuZPSI9ZYPzesFJzYueQrTa51nbINK08hqeoC3b/np0yBDWfQmleY3VHv3ufp7K3SYqORrGau2bfTVC2xT9frH8ObP6VCaXK22G+bGRh784z4cymC+TTPs25AFFcARFuPqj2GsPr8NVX7OEcK2Gv5y2xU3AOU13uk2EFj1C58CEbuTQ6GZjHVbkZ3wuPKP3+DDVarBKJRs92azj/wVMBTzRV7jWrmmoZj0LR09CIyAhuqPsYuN1yE94kYEVsK2GIHwywSdTw4O8ugqS4OhnYA3t8fprYeq6kO5HEDLgsCfXKnm6aRNpPAPZRVcps1VvCIwlLknQIlFH95z9g/mxpZ9MDauap/ckbcGakH0vn/EGcVmJUKPMg2dEwGOI69i1LRSllNWHLIZiI8fPSuC5OQLS4nVdux3sn0pYcV3/htbS9KgRiwtW8HA8sT0gxEBxfpoBVwOmqKWJENphGvyTHKX60sqEs0BcjWhPts4+Qv821M0GZ8rOBzcvQF9hWBOldiW7UeAOOwnkedAQ1C5ma1yixdBw4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4744005)(2906002)(44832011)(6916009)(107886003)(316002)(6506007)(38100700002)(508600001)(8676002)(4326008)(66556008)(66476007)(66946007)(6486002)(6512007)(86362001)(2616005)(8936002)(6666004)(186003)(36756003)(26005)(83380400001)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o4ywuvX6SQnxMwIdKxFm8+4F5y2bO+CceTfGsBoAZrtTTCBnmJ4hDgMflO4z?=
 =?us-ascii?Q?vpevzMCC5tpeMqocOcAlglb9n3f03WuPkzj7j8UPC39px6nyPjztRieKF8nD?=
 =?us-ascii?Q?pVGh9rEo9ZQxUwOnib9tUtJax5pPfpzLRngXuTJYBqeJYAfioG30Pm9NJSk0?=
 =?us-ascii?Q?oKqTgfT7DOKqQ7bM1QXnzo11FDNrJZU7na/s0BH/SqEO/LNiIx9NgGKUrRG2?=
 =?us-ascii?Q?j1gMvYAKkL7wqIq7f+1bcZnYDXsOmgi0X6U3OerO4OFa22TfBb5GHyLR7AIh?=
 =?us-ascii?Q?tq6q1F0U8pmSIs8+NfkXKcihf/22hrEzx2o3vhlK9pp4AU+QyNkDi4cgMxr3?=
 =?us-ascii?Q?3nVzgnqB44t0mT7+DY/4Cw1TOMZsElqP9sRF+eCHXuzfU8JRTPqF2ZWyNETD?=
 =?us-ascii?Q?+j0LJl4fHo5lKvRaMwKswBkVucRHLFFtPsx9p03nnECIG/2kIU5jilz4q0t4?=
 =?us-ascii?Q?v+LTzuQHzckao3Mkx/wIJ66I2OyYTCtLA6CLAX/b7MJPAoyWRbBN8R5AyPIF?=
 =?us-ascii?Q?NfbEkZHU/ompnOxnePsNSO9V2GP7Z76XB2lFhKQ6BfSa8nG+2Zw+P0hVIYPv?=
 =?us-ascii?Q?k4C1hjWmuQV+2+uRM1CqHVJeBUskn4sXl2oY51Z53Ax+ZMhlmVjW5W9mRb8J?=
 =?us-ascii?Q?SjWJ/R9Zxd37DS5HOfIcxzku+dHTTgCGkcw3kdjyqGGQwddXs9qq2xajjtln?=
 =?us-ascii?Q?cjHLCvcQ4a3vHtY7Edubv3h75k+QhKkkEV+SMCtQwdu6zjqMd5s3kVv40VWs?=
 =?us-ascii?Q?C1SAfNe9P9HZDSo1ptSDQgpBhKOXFVOq2Nw0vG9cb+TB7SoGIoOG5NOPNNb3?=
 =?us-ascii?Q?Sfg9mJf10dKEElL4Upcoqo7MN2BJv9rHs5dgQTMZBxq1bXkjNyDP1OZZ+VQy?=
 =?us-ascii?Q?lHLLhDPgbkI6QHa89CBsPG2HnSPDftuIWGO/6ry4+BUIZBaDIKus5Af8Rs25?=
 =?us-ascii?Q?e0YeUAXM6vq8oKRw1gaoeu9S3ZEvhGZ+bJ/BCZnNDhqnDCk8uYs8rwsnDEz5?=
 =?us-ascii?Q?0LC6lNUH73RkN3VhoL15ekusq02shCGLfTcq9OOQZ2nOygTMbeX06cG3o1kX?=
 =?us-ascii?Q?F6PRKcCJXzFHwy1vgTUf8lulNkzpml1Xd0hqkXEHDOIQjjT9NzF45ooc2iTv?=
 =?us-ascii?Q?zduVATRD/nxDmrO9dVDr0r7HPVTAMZY43hu+ybE9j1fprNcR70Q7VynhJL5G?=
 =?us-ascii?Q?0pZmpXQNmdZwIuCgIimW0Ou+Qp38uBrPzIbYqE/oLmmvFwJvrIFF+pWu8b4I?=
 =?us-ascii?Q?3tJGbwtVMfdaGmkugNOI0u0wumCjKxuuLJUXOFxvK9JoIyBXGnYwMPTDS5Vj?=
 =?us-ascii?Q?VXOu3KhYsuIvRo++wYXZvJpt0DJ+w1W+fr46Mn7zgc7Hfzgp+1u5qTWOpMv7?=
 =?us-ascii?Q?qf1lMqv5fxk8G1NYBwUH9mAXpYEIoWYMT5/fcqKbrFswskeOeT7fvK/Wu5CY?=
 =?us-ascii?Q?loQrA6sn7a6EkBKSj2K83mRPwg5yseeldFPlnXrogvxGQ5GNbO9SVwpRXSA+?=
 =?us-ascii?Q?c7miwLCPFtrJi0xtEM2Sb19j+xauuvoVznQhxlBmTjr7l7L/dY/s8N9N1SRi?=
 =?us-ascii?Q?fa2T0UmLcLY8uHWCIQy/ibdHmcSkUN23awvYXZehohKVF7NDDLBfGDYTqBJc?=
 =?us-ascii?Q?rWhUs/QX8uS74u/Zm6tT1ac=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c958d7c9-54ae-4994-7ef7-08d9f207e74f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 11:23:21.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5XgpWINValGxUOAb+b7qSTFpBWLIsnfNzYwzYmiKeVxzdV3z6r8Htoe5D0AS+VJZaAT1VCilmDSWzg1OahpEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

v2:
 - Only send MP_FAIL response in the single subflow case
 - Reuse icsk_retransmit_timer to trigger the retransmission.
 - Patch 6 still doesn't work, needs Matt's help.

Geliang Tang (6):
  mptcp: add MP_FAIL echo support
  mptcp: add mibs for MP_FAIL echo
  selftests: mptcp: add MP_FAIL echo mibs check
  mptcp: add a new sysctl mp_fail_timeout
  mptcp: add MP_FAIL retrans support
  selftests: mptcp: MP_FAIL timeout testcases TODO

 Documentation/networking/mptcp-sysctl.rst     | 10 +++
 net/mptcp/ctrl.c                              | 14 ++++
 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/pm.c                                | 13 +++-
 net/mptcp/protocol.c                          | 44 +++++++++++-
 net/mptcp/protocol.h                          |  4 ++
 net/mptcp/subflow.c                           |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++++++++++++
 9 files changed, 161 insertions(+), 3 deletions(-)

--=20
2.34.1

