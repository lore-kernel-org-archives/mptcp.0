Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37B7E
	for <mptcp@lists.linux.dev>; Sun,  5 Jun 2022 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654435797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lrQ5gyAUHsxHJH5HuLHAzKm4tFzLFTDYryeaGn5GB4A=;
	b=f9cs4oj/mWu+v17WyK9SJLzuUnWwB0meOhJPlN1My3i0fZakI6nhSKUG8+o71c8EgEEucr
	dfMaQK17sv/RhmWfWHDvV1ZQHxavfCDhz+eyvzBUJeivR/+pj75EIwjPwqWenEvSSKe2ZV
	yPUSpyHHPZ5Ifp47L4YgtfVBcQfho2E=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-8d4eWFEaOw2ECxdQk3whyA-1; Sun, 05 Jun 2022 15:29:56 +0200
X-MC-Unique: 8d4eWFEaOw2ECxdQk3whyA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFGw4/SxhE4M4twV00oQ4ilx6LUiD3N71ME8h8BCm/79rC/lFCFkNbYgUGzsTUxuj4+hjhQtWm9HbHjgP57h/QMBnjxzId8va/yAQJRJvsVcY2e9ZKSUi9GpqTFpyh6kiHbcMqr0yC/mawVKReLUSFV+7joui0aqx224ZIt0e3hA2Aao4+WVosk3FIjXp9+EeoNTBJRUAD+A1ihi1AlqhLhfCPgHEY1TdGTjKOAS6nDJeM6/4yiwZLcS9FVcHtgLxXgW8wrREF4f0WXAskLZtFlvTBHS8eLZqLs9rqMh8kYjnjPlsyYV7JgUG9myF6mc/mEd+9bWgjnZ3D6jh+2PYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS6Xc9kaEpNYDVU4TuSJrfpVKEiRB1iwQeqRzBfjwP8=;
 b=Ys9xVeO6w8+n7yXLSARWPesV76UfNhMWRJnMDP4oMsEwNkZwNXQtxOQFHruZLSGgyT4y1+SyqCS89Wv8h3Q58mVFefgAcvvpZj8tG/5vdEVy1vRruiDzIgimWW4f0VWVH6pFTkq9H6bvczYCKCIYr2wT0MdJOUmSB70LAmsWh53Ysn22BSmeAm+I7F15NvGNKsfHILH71r7FnBMwYN6WbxFFQ8nrzyNNCJRyfAzuuXpIc86ttrjxuXs8Mh4DiCzbn1vkmzjhusS8+QASFkEY3E92zKkq7WzI1ki3UaEjs7+7cya9mEZGVJX6pQFz2KxH+mwyvEEGZ0okugWV7eRJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5028.eurprd04.prod.outlook.com (2603:10a6:208:cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 13:29:55 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 13:29:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/5] BPF redundant scheduler
Date: Sun,  5 Jun 2022 21:29:35 +0800
Message-ID: <cover.1654435294.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3050cb6a-2b96-4b6f-b94b-08da46f77940
X-MS-TrafficTypeDiagnostic: AM0PR04MB5028:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB50283AE70800AAD98BA0C104F8A39@AM0PR04MB5028.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BLeu/mPFe0Yyh8CxAQKnixfZNVwRPD/hVpFoQHvBh+UvqwJpxrkyisFrHX8akNIx9TLZe2o5QiCxhV4aOZ9Zl3gPLNBxgXH0YvbPsrU9klfQImEBIZ+uz+CgHlzrd3M9XQEZUw6mavjkbxhsfF6eS8tPTm1QN/4ia9jwF1XCVXih0rccK3JUr++UTSXyp8nLFSsRSPmTQnwhIJmhfaG3VkG+U/IV9HVKCj54LfbaqiLPtPwt6aRuiuzfXXa6ECtlowg5/SqZy1hU1pHcwbCvxUtJAuYbCQIgJ38R3kuLjXIwAZT72ARA0ABn1Q9B2tvRZwrPS4K+rKgXUlHdvhj6cHjJZKcVQkqg7mDUYaBpgrYRg9xgjLBeLwpl3/HMxI1xsYyeByeeq1FHRFEW2Uol/O9H390c1R1r3h4D/O2XkJ66qhR1TvxaZ7jlQ5tjv41PlWldkzTuhNeJzsGZ7JnW9914SLKY1W8YQOwHH8s2g7KqwMlo4T+j1a2d6Nn1BePMnI4akAEzdV83lpRHL6OEA+HU11ksVRA9Wk0oK5e+EBfwVodxEJSilWlAhCEUVHDPaax4j7a048s3CvwWNqibHY0HZl30979nsDwcb47tCFFvzbiRD0dzUdt4fst/t5E0xcdM31hcpNgLezg1jefmff7SKNmHtHEcaZu72o1JLoYJeDTC15TicOkZUQektDY+Lf/+goY/BXZ7KofWbsLXqCL1813s0IQHq87yhcpT7deBXKJOCCG1fPPg9ZG01NRfTfdCqn8rv6SkpHDKMZNhWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66476007)(66556008)(66946007)(38100700002)(107886003)(8676002)(186003)(6486002)(86362001)(6916009)(26005)(6512007)(508600001)(5660300002)(44832011)(36756003)(316002)(6506007)(2616005)(4326008)(2906002)(8936002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZmsjkrQc2tL9i1aclW8vE6D3JHF39DqG7aTFO5am+lSiPh3l2l3aYTpMVZ3v?=
 =?us-ascii?Q?V+PutJyQuA4mmjc0Fj1Hwm23rrVDhG80i+w8e/IBxgci+BoWYbbHyoJMOK4A?=
 =?us-ascii?Q?6zrZyJEj/NDOXQ58eExlLPAbE0DIji1qdOXaBFtl2w220x5T74TAWh9faMAG?=
 =?us-ascii?Q?/iji6bhzmRk7F3NFfDf9X5XjgBp76bJE5aZYli9FEgYPRbYUo35Oeh+FFVLZ?=
 =?us-ascii?Q?TbkVF/3O7MNYBu+Ai62Uq82LR2vIvQBEngqV8Uj0Ax9VQ7Vw9OO5QJlin5zf?=
 =?us-ascii?Q?3ayGuodkdTKmiRDfULbo69a24yFD3qUM2U1tGLggTXBb48MOUxM9rNj3ufy8?=
 =?us-ascii?Q?N5isVhhOUVMnrQalt3M7QfnueOAwQ9KWLjXZDWpiL+Dq91ki5TQtLod3lLcR?=
 =?us-ascii?Q?Kt1quYduARHqrHQBzYeEnUP6QC/13ju46Y4PFGAmI+Aw0Ap6VW1jwmTuEr8x?=
 =?us-ascii?Q?/Vfj2ROF+DBrIR1Cb9f3OiYMFwB+Pj9/rLXz98C0ZbbVv7y2N9qbgjmYnM+c?=
 =?us-ascii?Q?ZAvZi8Bphn/XqDucvp6JXkmHW6aheltK+L/cvHqD35JyPJOUpRJUlg4M/1Av?=
 =?us-ascii?Q?cFLGMKtsVtPOQ24+a3kSVpZdmJiZgJTHHF5D2Urn6+T58IgRzp+CEncbq2gn?=
 =?us-ascii?Q?UIIm9/1dWUWE4b1nSbuWVb+4EHsBxkSN3cWjO3IzVA83OWieLYTHecutwhXr?=
 =?us-ascii?Q?yVJxUrWPNgIKjRriJSQ5gIZHjEO/y/gscq+NCCbxhNJpU2il3LT8jHBbzHUl?=
 =?us-ascii?Q?oSxWxteFUHSeKFFjKeCGliLjeGe/sxYUdvnof4lFwFGQWo4SKkGW210bQVOO?=
 =?us-ascii?Q?y0+yvW4vgY/PoAv8WudmeIrOSk3bkbdMmsNQtYZC2g0eQ1mgLczd8TXM40jd?=
 =?us-ascii?Q?HBKSdHwgj8JOyCdCsF9mE5z+/YzrutedIHQiMNUTQIGP0R4BqK8QiqsZ6C2u?=
 =?us-ascii?Q?98SD1ECgRKOQcPyg5whrbjndTqhyRJrc4mf3Q1defXNNlqhnT/ZGyYZTQFO3?=
 =?us-ascii?Q?vu8VIbrqpyhoDUWr8HNVmZlIV/lwjzNr4/mpcealSFDYX4zgJjb4jwBKkBNG?=
 =?us-ascii?Q?mRsjedcG6hRvnvIp6VbG4p1QrUdzl/VpMFgEK0nnhjd9wmKsa1CmJFNyKdk/?=
 =?us-ascii?Q?upMotjYjmKvq7j0EFIRoFSq+MxqjXREQWPQ6zMdwr+cIKnfN1jDY+YYXexOU?=
 =?us-ascii?Q?PBLPsPXVpq3dJAyJaCoNUJW6nM7G+hFOluId6AnDFQHsBigA0klOMK905fSL?=
 =?us-ascii?Q?y1dyPdc2uM4NV5EdfG+w+C9tZcCmKKKHlgGeUP1y11+wDSvi8dLVDPjZVh4D?=
 =?us-ascii?Q?lGkwF9uCn083R7nfM8Y0brR1ivcrSpkA5uZH74zj+ym661AqYE3pST+UBnLn?=
 =?us-ascii?Q?/rqu6EARNW2xoWFDUnsiuE9JWpb1AgoVLbvjsrAXEJZhRrSs1ru5bu+0AFjo?=
 =?us-ascii?Q?gtX9W/RsvKQD6WNLP2FOvNytEPURkC0M2UdLILqu0a8tsjzVTg8uFp2oSG+8?=
 =?us-ascii?Q?DiXp9Sdub5oG3KlAsBGlw/6HMo/T7/U9a8uHMXQlLMiBJqrZnoCUyaUrCY+s?=
 =?us-ascii?Q?6npS1aLBCteuup9YaxzOYocJMASeFXkyvaCIcmnmmpQpWRzW+VmnCcsLaCGs?=
 =?us-ascii?Q?xQZyhZhyl7GPG/ynBxnaTi4YDHoT3U5PEXcWG9ggLiO98lGVJvxlUjRK8otB?=
 =?us-ascii?Q?f0VfgK30eum0APIf4SQCRo+IyMB4BRaT/gYAdjs+u+KU7AUy4F5RYuySSb9V?=
 =?us-ascii?Q?Gl2aBCzrl5vDN1K/i5YlN8Aahn5sVw0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3050cb6a-2b96-4b6f-b94b-08da46f77940
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 13:29:54.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6A9fijQMX/hgo4PpzQxT+LdtO+T16JEuIY9/eY2jMwOQk3TPlpQNQhIuQz7IxQF4q+A2TTIi0d0Sb4QTZmiXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028

v3:
 - use new API.
 - fix the link failure tests issue mentioned in ("https://patchwork.kernel=
.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

Geliang Tang (5):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: add __mptcp_sched_get_retrans wrapper
  mptcp: add mptcp_sched_get_send wrapper
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 105 +++++++++++-------
 net/mptcp/protocol.h                          |   3 +-
 net/mptcp/sched.c                             |  64 ++++++-----
 net/mptcp/subflow.c                           |   1 -
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  35 ++++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++++
 6 files changed, 175 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

--=20
2.34.1

