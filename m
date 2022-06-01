Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DE362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654065963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9epi7b7QZjqUMiWMwbhuR4SApx2QgNg/87VBK/dEcfY=;
	b=CUO6RVSOwTRO3IukQOwO8T199iwc+YaogV07FGOkEf7cztBbMmH+Fadd1rz+IS7LKoIRLm
	afCt3yyT6eWMYUp+sbyaaD42fm1Td6J7dtCoTLIvVZekA+t4CSXodTnVj6GtIpj+//k097
	F+96bEa89Ir9aoL+64KyyZD6+AQyb7k=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-46-y1tU_PgqOlSLO9v1f3Fldw-1; Wed, 01 Jun 2022 08:46:02 +0200
X-MC-Unique: y1tU_PgqOlSLO9v1f3Fldw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HotBpp078lUBUJOx2ZwtWUZdx1fIhq7UH6yPkoZmagqsh0CXBwATRLKspAnFtkTVng5dzj2H2JesfSPS2E89ON4bj4MJnz7Fz6PCWA6o7sagQgxsbIR3VximIubeHbj6a9j6VYncLmeei3oq/XPDT7cO/T+H3Q7dJuPHOCLtqxKbsfryVQwfqPSEoJSQR7v/MEvQjJGlv8VwnERPwLvP0EPIqc/dwnpQNu4dBX+R3wXGAK77w/jaF74cQOYM+4L0Z6F1PNZVQosRBOUSOEPXAPI8Vbz/0MpBFRvg0GihIrQMuyU02jGtznjR28XX7HhBG6CMBEJHyo5ey5dbOrfiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me7Sk4KkxSvWtsZ8oxoU8p5w3v8NFCTHyNhpQF70BNQ=;
 b=I78S07lGooqpxGXSu6CgFyNZTdUf6IPqgY0LI2mJtCfAY+BLwJyASN1fO2385bbdhYDjN5Two30goUgBZHJiBwSsMCSbBb69fuf89FgSidRL2UmvCZBIZMSREBOYkxmsPlyYUwWUv2jeEmfgyGURMH/NVvTfAbDI9Am9rg9HNHK4kpyEDRVVfsrPlLbChDktSDLcV7JmwbuBev/scAiIMCnBJ+jdavvDCpLz3PPSeGu36Vmk5x640n3aZfd8GWFqDjy+x3xMiKnidvoaqQ1NhX5HxLeS5L4N3hJsVmaJLqzXG2ieYHtM6zeTyvS7oPvcRWC3ZSlL1VM0lvHSf0LJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2434.eurprd04.prod.outlook.com (2603:10a6:203:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:46:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:46:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 00/11] BPF packet scheduler
Date: Wed,  1 Jun 2022 14:45:49 +0800
Message-ID: <cover.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0714a74f-8cfa-43ad-3a8b-08da439a6341
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2434:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB24343CD2C75C1F041F5B1238F8DF9@AM5PR0401MB2434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DsSN1916gxjyNNbHCbLX7j2bC9DmKTegH3A6eVtjE/Snl9CeXPMgR2SaYsvzdL9kocGmWfVY6wODl+/NcfZolTH3OXJCnr+06wGcW4t2djJ7biEwJhv5toOwlH3Xyrc8xVR1IFv1qHVkhMjWi8ehYK7DVmmpdWQP2ytI13NXSW0MsRQ4Z7UA8at1OKhXk9d/WjJkzYvqdSutRr5OhLVfV17bdoeJnhTtWxQlsZo2zdmse8/ajopQ35VSV/dpxI5r0hex6klobX55fBnl2PAOUL5paDvQjGwOE4BgIUuJWF7bxnNWcpnlZpzn7W71ecP6iFzGa6zQeXb3viBYgIkTSLiuv8QicGnVwVOxz8xYCJe8Q9qI0CYV8EJX5hDfjW0iNqFzzfB5RZ2XN9tvZgqEzcsnhWRJUxTKjLA6+xjUhUTodceNPBHQI4kOSTEmkQloiHlyKpLHTeqli2sr9H5kaIwRbw49VBreiXqp0b9PVbsuuKp6RJIJwUgn/x+7KBHkwAXfkzH8NQFabHnWVTJ3FcJzGKnuuJJ/CDgPXVkkhhmv+kpwQtO3BcSNobJtTLmfgEKS4rWnjhxPPmDosbQJEnqcOs3+7GIPGzcoQrDqFvqj9hCLP9B0kDRfZXHPH2SIn97VMACf+Ycjg2XxxuJ9dozD02l2AYGmsUiLzqJRyxz2f43ckUdQsHr9A+zBDTcSK5bHuR25Kiw/KmxDo56GNVQhO3PiCo3U9YOVSmYD+GCDAUt3q3OyGBzwKyuauzHFdrmR3aq1LmLechQkPlj4Lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(44832011)(508600001)(6666004)(186003)(6512007)(2616005)(107886003)(26005)(38100700002)(2906002)(83380400001)(66476007)(66556008)(66946007)(36756003)(5660300002)(8676002)(4326008)(6916009)(316002)(8936002)(966005)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iUKo9k1zbb2mNmZi0RsPe0CLZoMKiVWEzthTEERozP6cnkftDSBXWIFZY7kS?=
 =?us-ascii?Q?rTKgbkBikls5C341Zqz6T6QyxAcKTWOjJOcl401zHSvQMrYfcaW1+a3WTIec?=
 =?us-ascii?Q?ijKGccN3JUjifnMQEKP1l25To65Uq7CDzsDEca1CI1MvxS6qzpt4a5eGA6kN?=
 =?us-ascii?Q?lILMFmWINDv/3SxXOpbd43p7Kc+PV1RTpgIL5KCJoqB/aFxuU46xZpxt7OBS?=
 =?us-ascii?Q?K5apA04LAf1nsWU2uXuzuEsHBk26DQzJAWFd1yEml1UOQ15Mia4uWPmPpjA7?=
 =?us-ascii?Q?KNxwT9ZqEMacQXBZxIAqO9/DcuvYs0c/Tewm4HNPESz23QQEtKnaB4ZiuDm7?=
 =?us-ascii?Q?I5iZwsGod8nFiOZyK/aPnDWcQ6GN5CwkbEwrgHnd0Ofmn6GxfMUjya0d7lSK?=
 =?us-ascii?Q?Hv8HxlQgsoiGimGBaDKbmrL5AIK8uElaU3CthnlNIbGLW2y5SSZ1JcnfZAvH?=
 =?us-ascii?Q?kyDi2dKnlH750Qv6l53vlerJT0NEyP3bSJzcpYMOU5CeD8JlxBSiaUKBTTxZ?=
 =?us-ascii?Q?JxCXU/r44Jm8GFvM0cVZ2aiJ6/R6vOZcmwiPsX46TPd+/+0HZ40T0BJ79mRD?=
 =?us-ascii?Q?no1DtWEvKVCZ+FvWjArURacaRh4NRSwpXMlyAlPEx/fF2qFU3cCzAcE1MAgb?=
 =?us-ascii?Q?rypW9DG9hi+dyzvXwqIqjavTBo9Z2Ki4QOAm2aNSEQgdMYxZwqLWi9m6bYyr?=
 =?us-ascii?Q?b1l3iJOovdmG1muy79FT65P7C1DAoaBgeLVzX4iWfe8rOgS1DXuSivwRWv8F?=
 =?us-ascii?Q?YHhFsXD0xbDYADTBbnL2RaLF//Ji0NmaEwLPANcp3l7k9Y9wjDpoSlSSUUvO?=
 =?us-ascii?Q?+g7Mnan9ic/Br228OVV0d0O7OgiDuXQW5ZWVZqxnR/thItdQVzux7aDJDu3Z?=
 =?us-ascii?Q?HuLDg4Zg3HNLTT2X/7d081p3+PKgoCrsxziVNd+kSOSTqLPtFNxTm85pPILB?=
 =?us-ascii?Q?P9dIMzRgW1RDqvx1z+JOozV/k17VAHkR5DNSeEcYIceDmc0G1goUe/IKkDrr?=
 =?us-ascii?Q?pxWKaJribI8xM3YcXtSCF0f4JdDU0XRC3CrHF6BJL27D1cssXPwPTXHohGTh?=
 =?us-ascii?Q?XRcBeZDGcowWnUEARzTyvnS7jWbr4wkGxWrOsEtmrRFrOcP1FLJNhDOTQloa?=
 =?us-ascii?Q?PhZUDl+RD8GynRF71FYZleQ6Otf8x+KOVWCGiXvK0KmULFUZ5qNdHeZRllDR?=
 =?us-ascii?Q?kt9us6yauLfN9A57hX0lT58O3SNS+0VkqCDcqpv79h43/NmFUgJ3E4GYdvY/?=
 =?us-ascii?Q?VwwucVP+F8SdYz8UtN7/Iqww1kiO85gT2teAEgNbd/aDUCXJ3MsIC9qXyvCf?=
 =?us-ascii?Q?sKlluU2MZAj+YqU1XGNtK+YClwO1TNWhWOKtrOjOxvCGqDmTL+MXwlXIj8dN?=
 =?us-ascii?Q?0rLXijughKocRRpHt7D0nehQ+4QrxSQC925leosSgkpfOdkMY2S4GX6Dhn7w?=
 =?us-ascii?Q?lG25jVPD04BDCcbgmgZUU+dDgqxVQb7X8oHV5mdY0i4TNinHJrctSr87ksT9?=
 =?us-ascii?Q?I3mWmoKs7Vu6Ax2dtGxqfAEAN9LRrGqdIPPT5537U1ubV/mPl48QJ0EgqDFH?=
 =?us-ascii?Q?w+cVE6fhpv6HQMAJIYNWvZRQoH62TjQCN03s1Ch0p19A9D+kr0zWAjbLOIjk?=
 =?us-ascii?Q?A90N7No/FM/ach7T1JVaE4+3Jrql+OBQnZFi8C0zwsMmv9nWu6vcFmafR5So?=
 =?us-ascii?Q?6LkmtAQtS15AbeAOaHB85jm00LvLIzqMP9uStYnezHiRUC6tURQHJm/840jH?=
 =?us-ascii?Q?IU05T23h3WOkTfxY/fvFuL2AyGPOrYg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0714a74f-8cfa-43ad-3a8b-08da439a6341
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:45:59.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBhN88L3Ti6iP8CikPqauZo+pg1lkb6gMlJWa3cHUtfeeHyPU4ThenbTPG58ccLYATMqraqfL6ac8q52GV8ItQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2434

v5:
 - add bpf_mptcp_subflow_set_scheduled helper.
 - drop padding bits before backup, use BPF_CORE_READ_BITFIELD_PROBED()
   instead.
 - The new patch "mptcp: add bpf set scheduled helper" should be inserted
   between the commits "mptcp: add bpf_mptcp_sched_ops" and
   "selftests/bpf: add bpf_first scheduler"

v4:
 - merge "mptcp: move is_scheduled into mptcp_subflow_context"
 - rename bpf_backup tp bpf_bkup
 - full patches of this series: https://github.com/geliangtang/mptcp_net-ne=
xt

v3:
 - use new BPF scheduler API:
 - add backup scheduler
 - add round-robin scheduler
 - check bytes_sent of 'ss' output.

v2:
- Use new BPF scheduler API:
 unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
                              struct mptcp_sched_data *data);

Geliang Tang (11):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add get_subflow wrappers"
  Squash to "mptcp: add bpf_mptcp_sched_ops"
  mptcp: add bpf set scheduled helper
  Squash to "selftests/bpf: add bpf_first scheduler"
  Squash to "selftests/bpf: add bpf_first test"
  selftests/bpf: add bpf_bkup scheduler
  selftests/bpf: add bpf_bkup test
  selftests/bpf: add bpf_rr scheduler
  selftests/bpf: add bpf_rr test

 include/net/mptcp.h                           |  7 +-
 net/mptcp/bpf.c                               | 40 ++++++---
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/sched.c                             | 54 ++++++++---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 16 +++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 89 ++++++++++++++++++-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  5 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 ++++++++++
 9 files changed, 269 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

