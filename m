Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA533D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647784519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vLsORUcfaCvs7ubF5yVCjX2lm+2X5zeyPC1lbH4pzA0=;
	b=Ys/QbPWNK6m2hlcLI+DYcoUHulaKF91t2KfWLtx8KjaG/7uBH3pGWw5xqgLi3ODfRPsxaL
	V8uZp9rAInVK2KHlJBguKiRE/kPFINyxJspViwA2+jZM2k5VG4EvN34eJVHkaLo53FpJuf
	R45T+N0rmryhBPcIAKX7CG2C4CsVQnw=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-sMWM6612NB-ObTx8EywYXg-1; Sun, 20 Mar 2022 14:55:18 +0100
X-MC-Unique: sMWM6612NB-ObTx8EywYXg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMKjeISKnmaQktelCf2TFwf7uUZlCIJ3hrc8X5aw0r78X5UtavTWW9Y0FIz2KbPjfSrArcar9kwtiy/cZEjrSFQUfS+ycTi9lNuUENkrK4QcaFpSGFxvOAeSYnKcminm7vfn2t/xz2T1ZqfPWQCc8Lij7lwtCLTB6ehOuQukiBLcV0kWSLccnXhLfDNPCTESXmav+nRlqJvEUNuq6zMcYdrHBEggejZD4xIAhCRw81heFPG/FIL9TzTKd4nVISVBuVcXRlLSqM8mchY1WG4kcnlZ7HA6NvHNb1nC3yx4oCAGKGA7Nsn1mICqlmMzKQXYafUWVzKu10appLB2wFmQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSZNKVPFFcPWSN4YKmwyVOUw8GRND/MiE+JT7dTqnME=;
 b=nvXdczm1Y+4fxjSn6s9fkdcPQCzDHNujQgf3bJbbw8dDpn83kQDtUg8/r4Ag/jSm8AIM3eflNtmIcJyF8oB/qQ2H/bLp9fGKl87vdUxwObnU7gft0ss6NzMVLZAQ6iJ8DhnGayD0sjt9IS3FxNw744sGiltM2WXQyApF6hu9J/TKAuDqzdthBeReLSH9olM5NDlUTbGYuOo7XvimgzY/bWt7RGOS0gso4OCvJ3gXTaEa3UciKEMRS4w3rYappZx6iaRZhemzNT6FTz0Jdo9GBVDe+ROQAxh+3HEfivk3MfcAG6Ni/SLUpcxjL1E+wftIDRoqQShaNc46EqtKfXwhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4558.eurprd04.prod.outlook.com (2603:10a6:803:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 13:55:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 13:55:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/3] check more values from mptcp_sock
Date: Sun, 20 Mar 2022 21:55:08 +0800
Message-ID: <cover.1647783989.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:202:2::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e221519e-9263-4add-f589-08da0a7942db
X-MS-TrafficTypeDiagnostic: VI1PR04MB4558:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4558D72DE8A083DFCD8E60C2F8159@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CqKoHWdfEC3j9eFmxVlbkxvhyxMTI0Cqxz7TLIPnUzpsC9cBPfT/FrhOd7L35azhM/BAGqxWmwkRbfHZRuBniKRiM76iJzNFf75cTbvhxlIJ4R1HQnif5Xrty0+uGoAjxc4ApNmIVZhNkW85CPROh4zyh9NpwzJSlJ7j191KqbCdEfjwrUJBMwg+50aGFz7bx1W+CS06FiHd5jeCaLNWTGlFm8CUC6wb+VnvOSE/PcbgxxcsTlvLWBhH7lo1mNcSeX6/dgKYwqFUNeB/dCS+YUn9gC9Nx+C63yhqHMZ/Q1TNLSG+Nbt/nkXwXBqdQ95fXMazwleB2k4L4HoRrlXrg3/E75+UOl7KzTJCIxxto6X20iR7NVYgRIJQUVIJRSF7ILf9/bA4CgN+oiGC8hB21r+7OWJDI3ZxQQcDW2YupYup9AQcM9qZLXx7MAAu0CPQgr013dI2L71y+f8UZp/1hhUNKnkPy9F+nNh2mxtZl/fAA9Ofl+HckT+vE9pQFQcC7ED/iRVVfBUE5wVN5JisCWO/FZzZx1d3Bcj/EmjjRmtyHhbfk8gLKNkaFx4XTI6oCbh8Qxznoai0X40VuypXndywctk+qh23fg6FQzqhAD3+XTtgwHAEKvh34U3zhsRi7f5DK6ssAzxeHgPaVi9xnOmS9YQot9ZyfBefI947p2rQ7o9xP9bj2EKMs86p8NTo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(5660300002)(4744005)(316002)(26005)(186003)(6486002)(6506007)(38100700002)(44832011)(86362001)(107886003)(6512007)(6666004)(2906002)(508600001)(8676002)(36756003)(4326008)(2616005)(8936002)(66946007)(66476007)(66556008)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lKx7PubSZydTg3ohTWBykXiFRrIYghb3cuCe++omMVqXmdvLB4mBSMnWscsi?=
 =?us-ascii?Q?v4nXf914D4CLH2H/b9EaHaBb3Pfvt9CrTM3g9WplnBFvzMvsvCyqjXtniIhI?=
 =?us-ascii?Q?aUgDZQ4BePe37dva+54r9hs/puw4txnmaI9K5LuvRw0x9/eAWQHHLONbx2Hz?=
 =?us-ascii?Q?UR3h+QCuHBa/qSqfAuYJB0zZl80BzIWQ1cI3APCv1AjZIJb2bRqr/w/roPts?=
 =?us-ascii?Q?Pneq/m5joKz3KmshZzS/SHSnVcRm72bzFUmIgNaoGaESNqqWMrEpvRYSc+J+?=
 =?us-ascii?Q?bkz6h8Q0dEixUMqzpwva2SnkD0z2tCd0/W+gJJcg8J+vTyjkwlmfQI3KUwZ0?=
 =?us-ascii?Q?5XnCbVo0OUTachOHeCWxHL4c6waizsb09mhUIDFh9FGRBo4Yw+7z6atqEKpM?=
 =?us-ascii?Q?U5fkFkph3BbesYnNxOch5VUMcrWkG1j0DEQ74qM7nBuZWVXuqHynzDpE/o87?=
 =?us-ascii?Q?U8V8Iv/HVux8RSUh5/94GlCUyV9saqbFhw0xZuhixtll56IQv2RBW8hBv572?=
 =?us-ascii?Q?NlFO7j6kWCCp8bliEqtnLYx/pwHhJDgXCdKN0pQkW06f8QSyLL/CUsGg5tMO?=
 =?us-ascii?Q?mzxRjLGgnzn9er2QahOYvRJ4X8mTVNvk1aEC7gOduygdaVQh8aeip7mYWl+k?=
 =?us-ascii?Q?fVUD8wCVE//Ng/MeoR5mo5xGZtWeP4jx4ryHqh7+zZ6yqo87S+kZ1VD7sqFR?=
 =?us-ascii?Q?hRZETC85gGXMgCkWP4aU9LJOW2ZCPFxKmhMHQYFedIigEYSkhZjOG111upHg?=
 =?us-ascii?Q?WvV7/TCPwHY/Lz4X3x6se7bHX+hC7QWQrCW5iYnRgHpwwmxlCKVJH25lhHJI?=
 =?us-ascii?Q?0ppmDWjhEb1scE/udi8y072JO6VPFnjtKP9GFVFMXGuZIP1ipvPG2HxI7Rqp?=
 =?us-ascii?Q?Ohrfjt/qTfpoKG+K7nusOTHwyRva1oFJdrePNnnPOKyHrtlrYYvr/AIQzIbl?=
 =?us-ascii?Q?g9Z9nRiGfh6t7cv7o8sjObrLOVe+OOAgk1ZP3WFeKJ3Tsay504zP74W6g/Lq?=
 =?us-ascii?Q?LCNK0ORGQfyI/fulBSw7SVq1T4knOgL38nUaKEV70w+yruXxOgFDPXuzip4s?=
 =?us-ascii?Q?lPeq/v2zAPxuCh9/2YsyWBySFuxmDEita9igQAQWi58jNXoyyN9k6S3IoVUk?=
 =?us-ascii?Q?Xf7uw/fFNZg2tqnST+f+I6PvZUvnJb0bZatG3EB3jXC9htS1T8cpF0qyB3Pi?=
 =?us-ascii?Q?D1RSvzp6Cd5KTdX25X/WNZ1d5qllu5BSEddo0d3sGnjFEVW/nsGK0tJqG7yI?=
 =?us-ascii?Q?kXjKBntJyiSOHiC54Qe4tY2FDebj7nm0SXBPnMusaY2lwGkhM6HSnRq5ro7c?=
 =?us-ascii?Q?aLldPMgEJhO13Ogf9l8YcvVp3mA5/mRiAziWQD6l3LHrOVT8cKE9yhpTFos2?=
 =?us-ascii?Q?W1SGWgyjZ7tEcVTG1dO3OgWHAlaU224+SQ/Q41Il6Q62NDxY75/DEag7aXaN?=
 =?us-ascii?Q?EPS/V2ZdANWjsFKWz1u+rhyLNyHQaLz8rJRaTVoF+ytG1aDTZmiiKQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e221519e-9263-4add-f589-08da0a7942db
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 13:55:15.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIDzsXAAp0MGjbkqjvsB7WrfAOJWV3rOVuKCnrclEEb4brH5X6PASDQ9Ir/q542V70dMbH+sUQZ8ZE+nQvURow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4558

This patchset checked two more values from 'mptcp_sock', ca_name and
first.

v2:
 - merge the squash-to patch.
 - drop bpf_trace_printk() in patch 2 & 3.

Geliang Tang (3):
  Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
  selftests: bpf: verify ca_name of struct mptcp_sock
  selftests: bpf: verify first subflow of mptcp_sock

 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  8 +++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 43 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp.c     |  9 ++++
 3 files changed, 58 insertions(+), 2 deletions(-)

--=20
2.34.1

