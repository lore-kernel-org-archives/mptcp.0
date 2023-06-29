Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2051.outbound.protection.outlook.com [40.107.13.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114D15A8
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 02:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B755rBZDWkn2p+NwHELz9bEyknTdZJ7WE20+jkSiFyppwGeqPUZ3EmKH+Ln1KB4/sIfVHLk8ZTTELxZDKjsulk6JvI/BI/raDfTPKgri7pxwPERbWAgQ4VmxCOfEUTZCseYyECSGXF9YlFzUDLq+ceVOnEhf0XaQtuWN7i5ITHaMvLDY65gC6rWFDv+bJSyJ2hwpdLZh6GbRUcagM01/do/mpeUnoa9yD+9mIpZlvb7q/3PBYmx2vhjd4gQmiD+1roIBdQZx5Hn0/mffM2WpMQW9rF/F/ns6lD+wApoWzk3hO6LshtibRECdZVzQ1kv2CP1unjV8OQREXsoRIc/wXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhDoLWOFhSWdBz2GPQvAi9QjLXO6hm3ThDyahaTNOEc=;
 b=iPSvBA3NCz1m0WDH+eAGhL6i4U/zQdNamxbLvy+IZxa+bei2pElPJjXvSvatrKuTy27LRAY4w2ECToOgG8JNWbkYHoaGy5GtUzl5wLhQooENk7OBlblPjopSXKntp/a4jcOe9S4UaCsN6e7XR/iRXKXnak9OYCJxGCJo/bE7C5nIXto/qDonon/b9fPkRuM5UcKNeM1JkLmM3MPyOwk9pIQGGfG/24yFnR0a9qV6gujMe4KrWoctfurmEhA9VMzFc8+ZwwZnxDuolFqZC289bPVw7G1VYODhHAZ4TeqVVz9mGR02WuBTtl+Do9BcUcxC5DFOpH4ByQFFRBf++m79Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhDoLWOFhSWdBz2GPQvAi9QjLXO6hm3ThDyahaTNOEc=;
 b=Y7Gs6sAFWE2s29OeLq9HyIWW8Ity/Pxl5ssiX+bZbEZfR13bDXggjw7LFqZBEvSeqd4WJcQLC35TIZefiG3UpblbfvG197DCqlhn+SpKar6XPILwwLOf2GNF/Bm9v9JSBVwysWVOWy1+tQo2HCfKNaEKLdEBgf/ax4xPI/MUJLeY6Bj2cVJ5GLIiynRusYmnYIMxolBIXubVfQAv2K98rDX8AzYMWUwgkoT2shkau5dCPojg8Hb+fYVvrNmudvpCvwrpjiGFXTwnN3NGEJyar7dhcy+Tf74TMVwca6QA5Kj762Q2+xQYXlP4DafDHxpVAIKvUZW0VLvzjAYNJWeJhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7763.eurprd04.prod.outlook.com (2603:10a6:20b:246::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 02:12:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:12:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] BPF 'force to MPTCP'
Date: Thu, 29 Jun 2023 10:12:13 +0800
Message-Id: <cover.1688004307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 993e1fe2-eebe-460e-ef10-08db784643dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3aAjHUWb37SzLD+YhJyOLJTZwSOmXmOzDtBHwHzYaCE7mZjignwQyaOhah8+vfdeUr0W6I2VmxidgapXRq5+NyuAmiied9aUMitiZ7Ps48pTX4/DKlWRYHyq0BOLzpn9abuFnBZphWaoGk5vPxdnVCMktbM53MKv5Dt2bO3JBPzEiiO+P3FnPz/W7lIpSQ6+wUx/kmvh9CxJrkUjaQ8kXuseJ8OjNNE/iwtf0PVJhPCS+wjjZJGkNLi5tNZHIwO2P98d++g41+XfhvzKRzi0XM35SlmYoOdOoWZrCtRcoYDI5+k1I9Cuz0uE9eYvy1XaYRBcZJ4LhtEHtPDT5N5sph4sgX7fnyqQqLUXk1siK94b7J2YdU8uFG1gWfx2wEEwKEWW9JZN/jbgplCMklmf3tlctPBdA2264TRHOcLR2WCGLjzNZ7AYNt8Kfbsd6lX690pMGwbzzLynnBV3SDHFDFOEhdmS6Fo1j+Y4Zp23ChJpu5KCMvBg6x83XN4pX9EsgJfh7IqjGViUnPJv+4z7X+6lMitc1/HoJC5ivt2CoXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(6506007)(36756003)(66556008)(6486002)(107886003)(966005)(478600001)(26005)(2616005)(6666004)(83380400001)(2906002)(6512007)(186003)(44832011)(86362001)(316002)(5660300002)(66476007)(66946007)(8676002)(4326008)(6916009)(41300700001)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7YxQgY6SQt2qj9sYMxyDOtGzPrXXtjv4ThDgzJXiL+O6euUF22vG8Au/TRK?=
 =?us-ascii?Q?ALBqrhZWjLA5q3R0Gb7thUSzv/9yiTR8Lvz3mJG3sn8fFgSjXFh6FvOlJsz8?=
 =?us-ascii?Q?/058u6wO9R7nkvzLCuu5FG7ZMwpgp56kB0cNp9a8ZNhWb4RkqzJPVcP7Rz1F?=
 =?us-ascii?Q?x7OfJQvisAegdebHbWjx1dPLJSBIzBw7mx6tD1WqWq6fJWfiPxurl6fYdTma?=
 =?us-ascii?Q?7++OlaU4HJozf0XZz3VyFeUnI4wGuR3aYj5jnop+P0OmH0tgzv+Gi+lvCoJ2?=
 =?us-ascii?Q?ZQWGKVeHgSl46PHpqGfQCVYx1pU8pxrd9m9qhQAItNiHn/ST9beJA32Xgne0?=
 =?us-ascii?Q?CK84wvX1K0QOP505gM6rUz0Mmw1yScqaG4/xK2vw/I0PPQgQiCrIZ+7tpjJG?=
 =?us-ascii?Q?rv1JiErW7Lim+pWoHCPsD9xvySxahl9AEJkQR+CiHK9kjiDfZhbrZzSH0ts7?=
 =?us-ascii?Q?TghSBB2CsNYZwIwXCAehAJr+RH/Pqeqhl8aqs1bsNhlluVkyx0pzCULujThD?=
 =?us-ascii?Q?2c8aUX3Q5CDBaX3dJABF+vHmrxYJmRDnaZqNO7qWg1b9my9i/n9yFw1u8uYe?=
 =?us-ascii?Q?5iYPJhm9nPzj1q16om4860+6ZREvIvHFVD4BhSHWzfi1KWFlGYjw7/U/vaUG?=
 =?us-ascii?Q?WKhTLtgk8wTtkEe09tTuCRqY7mM1G1UUcyvl8QyT42PhU9g8LZrcpVYjXe7U?=
 =?us-ascii?Q?DSjFsQh2AEFiTblnjHlPNQsAn4t8De/TplroEKSz1hTi8fYmIUbihUpyDv5E?=
 =?us-ascii?Q?YhAHlKcyaQU1POhBxdPa/OZVYAUOJ1Z30Go+6qpBmAnvGdeEeJHvCoMiiwaQ?=
 =?us-ascii?Q?aCp6zhWuuTSVPies+SfhOd7CMr/9bdiPluoHGxQBtkVRpaib3f1aWLo9w0E4?=
 =?us-ascii?Q?Yz3Mg5McwFj0Y3e/1h6/dESLggrwDYODkmDRe5ZdiwtfYpYn1BvIqkP+Zr56?=
 =?us-ascii?Q?tJl2+W3MY0wMoCwBkIliI70aQ6sf1hWVIvc0J24JyY88L3WLrdkqVLOogD4b?=
 =?us-ascii?Q?F6QfBU2FzA0w1n1ZYrNT2wlc9I0iO1KsVasIJ6bVV4kSzfo9BXM0l0hxuu3I?=
 =?us-ascii?Q?ZGiYpSG2Z1WbjytRAy/h3bG8YNfBPBKJdr0qr8i15iEVOun/Spx1PbNjS9TH?=
 =?us-ascii?Q?n9BcrLSwtQpkCcWU2/z7zzrtoe1I5P96pX3D8yWyGAW1XR66si8BV0LbxRg3?=
 =?us-ascii?Q?a87TyhqGCrKHhpJGFUFFcIMpHkasKErzK97gPMKqjqMuES6jFKo75Z9UJIXG?=
 =?us-ascii?Q?i3DDhKM12MOUFtZ9+OGzW1T09jZlUpf70T1wU8oEOTdZ90lBM90L7+fUs9lZ?=
 =?us-ascii?Q?r7wPfYlMEBQaDW2LyPslf9qTrDAB7V1jaGqOA6VYwIzd5YMWOSz03TkQQmJp?=
 =?us-ascii?Q?aKqPe6P7vmPWhroxd9V669WSATbiBIYJ2VM1rZ/S2pPE9qyt4YaCsSjvbDC9?=
 =?us-ascii?Q?Cnmj49p193lPUxJaUqYTcbn29y8Zw/roIKNoAT7HUD+s/+NHo3xxJs1bfAOn?=
 =?us-ascii?Q?npbj5sdseoULQ/J3QE4D4rM3a5VDmYfrIJzG4ygEJV6ew7urjG8eyr7PsYCS?=
 =?us-ascii?Q?mE4D1gRhhYPb0UJAalW0Cec/AuFgwZCWMuxua0gz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993e1fe2-eebe-460e-ef10-08db784643dd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:12:18.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Awjfk+zhAqrDBBJxj3YpHc+I0awZYTGln8C+1AxaOtb8Zhy4xHBbmo5aQSKtmvEB2fxoSifdi5fmBVVX/gg+NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7763

This series depends on the two netns patches, should be inserted before
the BPF scheduler series:
  selftests/bpf: use random netns name for mptcp
  selftests/bpf: add two mptcp netns helpers
  bpf: Add bpf_mptcpify helper
  selftests/bpf: Test bpf_mptcpify helper
  selftests/bpf: Add mptcpify selftest
  mptcp: refactor push_pending logic

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79

Geliang Tang (4):
  Squash to "selftests/bpf: add two mptcp netns helpers"
  bpf: Add bpf_mptcpify helper
  selftests/bpf: Test bpf_mptcpify helper
  selftests/bpf: Add mptcpify selftest

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/verifier.c                         |   1 +
 kernel/trace/bpf_trace.c                      |   2 +
 net/core/filter.c                             |  21 +++
 scripts/bpf_doc.py                            |   1 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 123 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcpify.c  |  32 +++++
 10 files changed, 176 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

