Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166533D7
	for <mptcp@lists.linux.dev>; Wed,  6 Apr 2022 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649251581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CIgmzZbr76LoEN2W6ZnmJQ51Cgbm06cN8sXDUXYSbck=;
	b=K/OYOXAI4Z49ngNVG0FiuXL+qWoW/1S1pM3NFmByOfXxPXun9602s2Gja8jyXoOrlyvang
	sNJDtj4ekyD3/D7YCT9mpxBOixN+NFAhaqhr/QPzUfhzk2X4g+NO7tn1xbhwraBfGWuSuM
	USU1EcfRm8aJNuHbGARWXGFdiES71EQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-JbS-cTPLNrSivoB9SQwMMg-1; Wed, 06 Apr 2022 15:26:20 +0200
X-MC-Unique: JbS-cTPLNrSivoB9SQwMMg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WajG6JHXxu/VywU1a8NF6aQ9NiSNJjxVxXBoX47Yoq/o4jwXrLRqe61VJjGmXpK8sNLGA/uKbzlg+xli1HQrFbY/EWeHU2uv98Ce8bvx4cl8X1Q963Nx+LN512VzYmLgSvOY5SY1K0qPPIZdJ1URX2e4K7YXDMD3yuC3ZjVRtSpMPJWszX8ZPRuwq/KP6Sr4EbQkVctjhkahDWPN+BTg3kQRvaIsnqV5ShZKcwxboNkTWlKHuR4oIWhyF7L6XYvqSDqkF0T7GAd1USuOMdlfKk77hbSjlUtHScQfqZ6ESAFAwRBnD7Qtfrk8VHPWZ6h7iuhCK5MnQjWevMbSQW8F4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+JT4fYPNFmDMwMJ4kQTMVBurV6qnoKegWCOMP4pIk4=;
 b=LRI0bi9m3vK0kcgzpHNQEn6pZPK43TT5KmUgELSZ8hyApgafNjrXVHgp+k1z4brxq6ZwmZeWezI/tp09hb88jU85eH+Ym1ml5bq97nHBcsKfvk46rgV+xIIrKVytokwaU58U19nDfZfD8ZTnk3+n8NMA8wM+jIv+Ec92nnAzMEIHwp6Y9rXXBJeBCn/uDPbzp36799g08CJfmdLOWa1BZoAKVO4rmGD6TvWUyjmJdw1z93Q+R1ekyceW7VjFc51Ql+gHJ0TtsQnE2DO4mg7Jn88Oxacqhi3a0E8crCLSuCf8abtorKK0t3wR3qaYNQG+Z1iIdPpJzGk0b3gwz/AShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB4187.eurprd04.prod.outlook.com (2603:10a6:5:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:26:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:26:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/3] BPF round-robin scheduler
Date: Wed,  6 Apr 2022 21:26:18 +0800
Message-ID: <cover.1649251279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6af16ab2-b3ec-4bd2-2b1a-08da17d106c3
X-MS-TrafficTypeDiagnostic: DB7PR04MB4187:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB4187F277CF9F68377EC50166F8E79@DB7PR04MB4187.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JsBIh7QW7l8fkUea1RjmoGoKJH33iOLRkpqkPTNUdXvjo9ngUqunvEwt5K53y8G3uY0+YuSy53c1yCZ+cJRAJizLRVlwUX7G8HHYGmoaT35LCCZkwgcBSQmwVNosieUlHn2dRi7Bp6zxwZrzgDrFR9i/C3He0wmbhQkvSnnHWA/VmITeqw2N0BH70qxzGC+FqHzEQ2YWUdlx08fJsB4IvNQvxfRKhTHn8/+4qcI3C+cg3vU2uHSXCXdxSvryBAqxhSxnbI+IKyZq4Mi2VfABSRgZTwBOmms5tpOjmdHvyGiKfu8Wy4MM6EnAutEiPkH5dwTLr5eXjVpRoybeofvu/wpDxKQ0iyCId0eIrSoR7U/jSwHIq+zSTlmt/KTqEc34ZM5MucsJKZARtlL82/Fz3bX47HpJpmojmSXsCK4l8mC0k0OWGRZVJCNol/RSPH4tlhwF8mOR91bNZ7RnokL4Ex2LzLLjCb2mlMWwNy5U4wAQXyxKONTo/R8QeMXIk4dmf9c0/eNxJerYkYaZJdf8DrkDAAJlTpSYx3Fbi1cJOaBVwu38PrGq/Pc91LUSyICQBJ5p2hsq87rcbdpOhu5G4O4pA+0/gyREW3cdmvm/pQIBJL5QQUCfupO6jdIZmZvhlJtjS2NuTjTLI2Zhi+yhXJVqgcR/5lwnmPZ9TBcimwG7rX2evwoTXEZ8iiF5n/J6oUxcxrNslRvXVwlxFyCQ9zaqrf/8vpGtReWowEDmZzYbuuAPFoYl1RJ/WDaB1SSeUbTMPKR8Y7HD4z085X/1UxPW3jrXHywkWNiPkCAXEbz3vPPWvoIRIc82k18VjddM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(6512007)(508600001)(66946007)(4326008)(2616005)(83380400001)(66476007)(66556008)(6916009)(316002)(86362001)(6486002)(6506007)(8676002)(107886003)(38100700002)(26005)(186003)(44832011)(2906002)(36756003)(5660300002)(8936002)(4744005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Cg4NvWEiz+kgMufoh3jZ0EYtYMyB+EmjtNbOJTF9rQUNOLdXP46PGkxd+Fx?=
 =?us-ascii?Q?NKc1mpJb4tgLvyqmTY0fLlixffGeeAF0bCyxB31arzWmCo9NwnBQL8EMMm0Y?=
 =?us-ascii?Q?e2RFxdRJ4ktIVLiS3MYYPLdeQbraDBnatDigC41KwY7wQ6/xsD6+A/5ty3VU?=
 =?us-ascii?Q?gtn2Avjm9JOscN7EsIiGYYF8FRpnRpIhp2rB1nFU42SiOAL9RKT5/NJeEuwl?=
 =?us-ascii?Q?T6U5BWhTt6yIZ6OaatOhOjxyNdXE3+arF2uyGMSbpc8jdmyWvQBzvhiOc06p?=
 =?us-ascii?Q?lelXNp0ydBv9o7H5G7taIP2MztKLnV5MXh9qqkp1YULmc7vgQm+9cETk9JfW?=
 =?us-ascii?Q?FeQKNvj6BysJ4GClDWTZExR79m9sSrhp9fToyAx3JcP5jaivPyAZQgcAPl4+?=
 =?us-ascii?Q?USb9oFZj2bxuM3Ik03/w3ccVrO6Mor+zKT4RhsAk9URjMkGsooRblnLBu0Zw?=
 =?us-ascii?Q?/QKhcoy1GwTpT/1CEEa94fOPvlqmhDlpvhvgxqNmaDH9NpvVqfo8UXFYIz8S?=
 =?us-ascii?Q?OhApxuiqWZp9/Ddh6zB7Wrn5rOw6184pKJN+0gRQin9U8yYzd+7aEAOsvR6C?=
 =?us-ascii?Q?042OdCW5dGFvx1EgIsm/t6MmdGv9mFf/n2syiA5QxeB+f9UwATZ2UeKluXcG?=
 =?us-ascii?Q?OOjIps0P9teS4GWB/AdgrWJFAFhsWINhFEUOtA89kWoeqj3k0A/aePO7ME0U?=
 =?us-ascii?Q?o9OCPakKjNDcGHaJs7jhHFzQTUlS0yTPkLmWsh+i6YpbjNZGluwtuNdlRl6S?=
 =?us-ascii?Q?lMGpv1DkJV0sGsxXirreacQ/TW9N8uUayYEbPQIQ9M7efnTNCsO/vH2uWCdp?=
 =?us-ascii?Q?or06vkuuXrT9IHJ5DTW5UQKUzOjOQFR5pxlSVbr4/Ws7xLF/pDj19P372hwV?=
 =?us-ascii?Q?HOPSsoY+KPW8du0IN01JolnQDra8XDhhBtpLCUXOdnPF0Nxfdx/pdmDxb6sN?=
 =?us-ascii?Q?uO8UGEOsBqv+27Rd84NJjYhXFaOjkPNZX/PYaF+hxJwlV49wlCG9m1Uea91b?=
 =?us-ascii?Q?qgfzZrKC2kTfWEYdXB1x6xJNoQvizrnHLrl3Cy6RC1+Hh1hAmBpLmTi35Hq9?=
 =?us-ascii?Q?wiegDMwn0NFeLXWWHzsYruONsEOmRfv+nAmDaRUpGO0Exul0DJuFJuaAdFvo?=
 =?us-ascii?Q?Cu3mah4GjejZtqXqWktmSvKrxFskWTmsaYAn8OD8e4EVl+pKL/1QTssBIWw5?=
 =?us-ascii?Q?s0C4rPzb4RPIub436lC5LgoHIMqe0j+2NUzJjj2hle6/oDVAepsxyfwC3xGU?=
 =?us-ascii?Q?UflRooJBgeuOI1cnc/MHsiTJnD46STMWpWwOkgV+8H3iGtDm3ySY9ruIDnDg?=
 =?us-ascii?Q?Ox5vEN50lHZkF/J6TJywrgi6zemJHXVx2/YTiWQ4p7SmgYzpVWicKQ15LpxW?=
 =?us-ascii?Q?N++QJSn3ok944maO74GAR1yo6AygT2u0q9BAOPdRUNQdKBfP9pmDee5CDMZY?=
 =?us-ascii?Q?bgIZC3aEjkPmSLjkAmAJQ1nj4fng7JJdoWmZWeAIziaiSJ7AZba9xxZvORlL?=
 =?us-ascii?Q?6Doe5hViF++TPDbStsmjNpbtgKze/xyFNLS+TiORDbI+S99E/ZgmBqQhhSJS?=
 =?us-ascii?Q?5hp/cyue7GCBN8tlognfuuKvp5gzrwnEnuCwlZKKtSAz1CNrBJgqulJwSyF3?=
 =?us-ascii?Q?JKaSOzvq8hu8p5cjPGK1gMog9zlvXzWq6buIC3rAS4DDWrfFbFwdZ1ZmZpiU?=
 =?us-ascii?Q?/99+nmJJlQJ/jq3LvREkrre5Uoyv39FNbHpMujanuFaGAlyof5MeMMAsfx+s?=
 =?us-ascii?Q?73R3FZ86wLQpvE9bm5BNMf1ejYpb9ZU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af16ab2-b3ec-4bd2-2b1a-08da17d106c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:26:15.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYjkCFalTvT37D8YTkByS2lRuRoutrybrnraP/GrNyT3EZ4WyV/AGDHbleI5GyJ9gu+D2rsRmxRDK+W8NnZ85g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4187

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
  mptcp: add get_subflows helper
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 net/mptcp/bpf.c                               | 28 +++++++++++
 net/mptcp/protocol.h                          |  3 ++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  9 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 ++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 49 +++++++++++++++++++
 5 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

