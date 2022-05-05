Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D836D
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 04:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651724826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y87hTTL4Bh16hYegYMb+uBlEJd0BfqgkHIwjw/HfqkQ=;
	b=mtJSjXrDi5DkdM3eemoEm7cH6LdZfV6afyVBoXuV2PeuLTCoC5jGvbOraqOUihPRcqG9oj
	IpkxrIW9xokmlUnm3YKitKkfCX283m3YSMvgxg2BkSlYSyWI4/y7hONxV5xEylfMfMUifO
	n8U7+dh7zOPCRIc01UZDoulFLBULtLw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-dSyMXzelPpWW6ha6I3ttfw-1; Thu, 05 May 2022 06:27:05 +0200
X-MC-Unique: dSyMXzelPpWW6ha6I3ttfw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBKXJ5nv4gykO1dSeQtRD7XXPuX6izGtGinCYvYcPupgSGaxSeiSOBM9encMvsFBoH2oklFbwi0ubxTqV3w0Ny6pBYKOPCVldbo04gNkrLvz9Ls7aO2OfagDAJ6FLzgtQHM+AMK9tLymYMsCa6UBzS/TnOoT/dJ0FQJmJuTWHz0iR0V3+34iFym2CixHsTjh9clAqMP0lFJbJWKzMGD27s9bVkYQ5QZw25Hymbgjr0EIzTd1p0blrSLhcT4uVWthXNhTjCqhQYGGPyiXCnYhFhAsWKwfdCf3VdUJO5bO8lYg6O7+DY3rFFIP+E1s+1lRe1EMJQkSsN8EbbANL41syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ii6y7MBqRtWHH8ZRjPrWZz3MT1F+++G/fQ+VMowwu9s=;
 b=FNetjHd74oBJlO8s2r29bDyGz6kLrjQaDE7DfMO90UFNMAey97TJeYSJ9sBm1JKT2DwF/1v8WN2qiYA4huo5zSvIdag/a2VK6Tz1Pkjgod7fwDqG/CyjpueTDQlW3v9H4a2hW8HNMgGdNPloS32jyE7GrM936s4y87lxDwmDsqSOsCouk8dIQguZqiWza+LPyUsGhvq606Y5DoBc9dePeBYx6w8U+y0CcNKODVyHg1j37Ab9iV91YFk7TpXoLPlN6GitqE+ljhx4zenujHHpjwga5GaJhOJW/FbjYY3ENcD1uq47bP2qtisei4nRTo5Zs5dfiahzGRPSzKXIAy1aHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6274.eurprd04.prod.outlook.com (2603:10a6:208:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 04:27:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 04:27:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 0/3] BPF round-robin scheduler
Date: Thu,  5 May 2022 12:26:56 +0800
Message-ID: <cover.1651724418.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 608feae1-8007-4d81-a1ba-08da2e4f8176
X-MS-TrafficTypeDiagnostic: AM0PR04MB6274:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6274B76BB0D5F753261D10B7F8C29@AM0PR04MB6274.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a0aPx0LY4wXT+YzEC9OUOkufp/RFtrmWKxm4kvCI6O70Etrgsra2C+WK55giv2MI6iROF+HMYpYI3k4BywSlwUzPnaEdHSkxQQMG05M/J1M3V838t9qJNzyd0hlmCu9oV1ikrZkf85pgZU8L5i2oGsB/tHZhYqBSwDfI5px4epFxO97dZehx6eOnbHjzvydxeIlQhWK4NVIVwcYy1dwkWDoav3rk3DoubvhPJOYo+hPC3HZ9AbBANjNY+NzvAh9x4nUZ8/j5oWvVHEkyWCJ402BUta9zp0P8rXdzsyX+UIa2XQo38ZbS+dN4PzKdaRJ5PCUuOznic9YSa0QxjCDblnqf6Y9i0wQrdFbytRc60xR35UHtTEuDXsRLTPLtvUUK6r7gEWC7gwEivtxnnaGsjWf7WLnZjqaf+no13P2Ln7c98OV1H4sJvN+53J/DSArIAuUacR1fWc6AhhCJ21zRqgtfAlivai5oNKkmhj8n4ZFFIDY8/HfvbiUhGVcet31LzO22v3Kn0GrShO/4CvjQLWkjJ/Szt12wh+sMB1YpQDIHovehSZn1SF5+DxWJLCcVe1Aty03PFVHpRFEEPLIjhWiTPB4PywFvq5IQ4siw/RXXMqPfiYcyB4s5Hi5PjKo4nX78xgQnOUW4l3h2nwXyltKfz952I0ndbeohBWjphCxY8RIo6v75XPpCsiPDO9SvS0X7XBpGkocdbHlvsU76prH5B2npxBil57rT5NIomW7kyzRvdAxUkDHTNV/tKuZ3sWF+SxteK0hk6qoNbX5gisisgeSkUPuw3gejanyzKSy9ODJk1HBt9miU85moNFOt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6506007)(44832011)(6486002)(186003)(2616005)(966005)(316002)(508600001)(4326008)(107886003)(8676002)(36756003)(66476007)(66556008)(6666004)(6512007)(66946007)(26005)(83380400001)(38100700002)(2906002)(86362001)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fC3VmXc+C/N3R2UX0kJ7S5i1C7Ie8hKT0pHjgX5nXwK+adIim799hUm0qP38?=
 =?us-ascii?Q?fyBsMztpyWDsxzpjdudAnEytoVEORmqMy6SEdJRofIJabtWFa9u1cIesqpnt?=
 =?us-ascii?Q?RLqcdsWT0KP6IDWdRPRbhmODdljFpe0AbQVTCs0jzR6fJ37ly58lkAdjD6/j?=
 =?us-ascii?Q?S+XeVQxOeCLzTVpTXl8L7xojC2JAD2Yjwt9mcrMBZc9tAAaqKnIqiIDdSacW?=
 =?us-ascii?Q?UqWIvNF7nLKBymuh8PaF4He0CNrbooV83KXe+AIIgL/AR0vHw6IrjdBkMdm+?=
 =?us-ascii?Q?Aawvkow6OFaf1+z5pw4jvMPxXrBYWGMubuwI7NX7szKCvXyPs7yQzaGw46XY?=
 =?us-ascii?Q?WOTYb8yNkeZmuvJ1xEd1F3mdPFj2MAEvtWzQr/QVHUVyNKHBtk6MsMVB3cEs?=
 =?us-ascii?Q?gWyGhVYpGCHAcBjXMYnbr7xl0ETPyhrJuzznv3ay4RvF8nvLGW+unAfa/Kb4?=
 =?us-ascii?Q?f2eCNLKTTepAcw8Fst4NCYkPmt9bjXHpNoL0zsGTvDX6NZkZnEInWs+iAjl6?=
 =?us-ascii?Q?o02kQBr49LOmqePUoFeS0T5QOrEzS7WQIwojuhEDu4LRR+zckzBmNtjxyejs?=
 =?us-ascii?Q?NZnVIWbNoSnLxO4LwrRo/sBGcslpi2CFODAJNnjm6sZFKVBz8dQD/4vaunJH?=
 =?us-ascii?Q?caeHzyj3qaZbri6aGwyTuxadYVF4vj6f+5XfbH6cZKIXkUgELYgBAidmK6Ii?=
 =?us-ascii?Q?w4gIdyUtinQhqvVIR4ciV6kFB3ZSzLBpjKDbkeoMCVuC2v8yFVAEI1llu8ut?=
 =?us-ascii?Q?yaaozKJPNZcQHp9ULI+SiacyTHsY5IuDiMIuJi+eT03KyKqad7k2vlqtqEgJ?=
 =?us-ascii?Q?fG8WMl28lRvFHYD1bll6QKqNCa142yxSN1MZLM+knWApstKCrEg9KDr53emw?=
 =?us-ascii?Q?DiUpl6tQwtEwiSQWrOfJgEpbzhN0lV0ZJbO4WyCQwvnKrOWkfZD0IX+UsF9C?=
 =?us-ascii?Q?7iTRlpFhxlO0AIMcF7WREUXLvF03Nkn9S2VT9OsZ/6LHnpJD/SRr0fl4HTSd?=
 =?us-ascii?Q?sWa0fofjMmIK89C1nFhzvI/CNY+4gb0tiC24Hz7P/EKqPikMy1zUyZWHGZW1?=
 =?us-ascii?Q?NGphvLvPDyF3Vdsbvw1RooQ/27y32enVF5MC6Z0yqD4YTSi9vKrvqenR0eIQ?=
 =?us-ascii?Q?LuqsdjvRWTNfAJt/YNkdmt/Ncux8ectm7v/GpLo3Ps4RxrfBluCj+FirbfNY?=
 =?us-ascii?Q?w8EVy+y6sf4iKkPVpTEphdzti+LuBCuELqwf5czcwJNb0ONXJCav7SadIjEf?=
 =?us-ascii?Q?+rpBMNxaFfvt2oRYDGwAUKw1UWOQPZVoU/QuEdHo89Vyi23BYMhoiLmhgJxI?=
 =?us-ascii?Q?YnxOJL3TpsZGG7YX8a0DZdKtAWvkfL7pKwZIelqe0JgB4c10VgXYHXB9+SNF?=
 =?us-ascii?Q?SryUmsCxrLfsmXDgcFF5b0BnlMSLLwcl9WNBxDqNXGZ2ATibgfnfHo37zCh3?=
 =?us-ascii?Q?JY81vmce6ra4GQxejsEOJCwwPD0/a4QqmSne3GlIK87R39f8gzquOo/eIgEo?=
 =?us-ascii?Q?flFX2uN8Z9AoITEsFycvC7oo6EU/TtgiG5I0T54X9UcBfbNotesh8KZlCS/0?=
 =?us-ascii?Q?UeMkas+ArN3Z85rLEuGZisCdOoJcD5ZYvBE133mYesQlCYymcsHwSiU4aDML?=
 =?us-ascii?Q?YJS/oSS2wUr/NrFgSp1nm9N4YVKMT7mYvChMIpVRFxHh0Mp9cOO2XrWYQgI8?=
 =?us-ascii?Q?O2uV2sMd7Ps5qBu2RtcltGu4huC+ZHZWIMJdipm6n7+e1hcRIHLzXjWX1nr3?=
 =?us-ascii?Q?p32HWL2VRPoooj8eIkSs4pEcSPO07a4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608feae1-8007-4d81-a1ba-08da2e4f8176
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 04:27:03.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O733gjN4JA4Mi9kKVb+rzQuiKCNLx1NY8ekkeyS3qjm5tBgFNaeWs39jJx+j38DCTZE8uQjTWdqPjhr3wbYwzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6274

v12:
 - init ssk from data->contexts[0], instead of msk->first.
 - cycle through all the subflows, instead of the first two.

v11:
 - rename array to contexts.
 - drop number of subflows in mptcp_sched_data.
 - set unused array elements to NULL.
 - add MPTCP_SUBFLOWS_MAX check in mptcp_sched_data_init.

v10:
 - init subflows array in mptcp_sched_data_init.
 - for (int i =3D 0; i < data->subflows; i++) is not allowed in BPF, using
   this instead:
	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++)
 - deponds on: "BPF packet scheduler" series v18.

v9:
 - add subflows array in mptcp_sched_data
 - deponds on: "BPF packet scheduler" series v17 +
               Squash to "mptcp: add struct mptcp_sched_ops v17".

v8:
 - use struct mptcp_sched_data.
 - deponds on: "BPF packet scheduler" series v14.

v7:
 - rename retrans to reinject.
 - drop last_snd setting.
 - deponds on: "BPF packet scheduler" series v13.

v6:
 - set call_me_again flag.
 - deponds on: "BPF packet scheduler" series v12.

v5:
 - update patch 2, use temporary storage instead.
 - update patch 3, use new helpers.
 - deponds on: "BPF packet scheduler" series v11.

v4:
 - add retrans argment for get_subflow()

v3:
 - add last_snd write access.
 - keep msk->last_snd setting in get_subflow().
 - deponds on: "BPF packet scheduler" series v10.

v2:
 - merge the squash-to patch.
 - implement bpf_mptcp_get_subflows helper, instead of
   bpf_mptcp_get_next_subflow.
 - deponds on: "BPF packet scheduler v9".

This patchset implements round-robin scheduler using BPF. Address to
some commends for the RFC version:

https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (3):
  mptcp: add subflows array in sched data
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 include/net/mptcp.h                           |  2 +
 net/mptcp/sched.c                             | 14 ++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  8 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 47 +++++++++++++++++++
 5 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

