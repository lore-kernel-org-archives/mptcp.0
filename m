Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4782F33
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 04:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646712195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oVFWSIbUCQ6jF4hCPNQzapNoA/NkTP55k2ev5612HGE=;
	b=a0Im3p2KkFOHdQvT+Ngt0lc5xPHHU0KREDxleHQ47Bu+HCw8PEVHrSabwd340DzQ/ZG2l2
	FyFj6vFLT960NqEU1Wo2HFY6d830F1cpKzmqfRYuAS3Sc1dCBI9hYnAhH3JhgQlWj9wWOA
	Rx/lQvyR26lYDWfGNnr43fzAmDNvJdQ=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-cGj3EHMBO0Ks1OuPiZ7mwA-1; Tue, 08 Mar 2022 05:03:13 +0100
X-MC-Unique: cGj3EHMBO0Ks1OuPiZ7mwA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfgH/VyQXZudovapCYjBfG/NfkkbnljfC890PPs71iSzUEqAgCSD0IxKuaHGtxlU+QuURj6KskxRMN4ja6mmbVwJzn4DRQpcd1mtZLuy8fkowLfKCxxvmhBGzu4fLlY5bwaam4zhnr7idlwHbfAHM6RIClQmctFbyRqe+rWcsBatBNcU7XpbzwpyclGrosVYiv+3/pRgdLb56xJegwcXkJx/zP+YW52cm7yITvEPEz0IlNVxvEV0/y0+TslIZgjPT9SmpEHcDxJlwIxEKysaSOubeubQucJcadeAlick53zTENF9KU2lqNSdwfQOIu2AVknOiWbcbUuPG+ZvDaNsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3+MK4xohoRSkZJh792DesXo1SZfCyf44SGoNq2DuQI=;
 b=Q3xEK6hnIgX+cwkPEXzCN7MlJcNcInmBv1KDpo7jmuFI5PB78ww9MwMayGGPuQLWU0E/n2lfQm0AmAyfkvVBCuMCYuu7QYRPQ2/ximlJW5+EZx+4EzJUjedk6T/USYEVjeC+cAOJ5Cejc8sdEA5n6/JmIEDERndDsvkLPcoq/Rh1k2ebhyE0FGMaFFm/RST1d1e8t2k6Qt4D/KF9mtz0awv5COCQupil1N503XyG4o9b/kfDFZsuM+KQKDtCaLbtbNG4v9WG/BFUdqarxvtoxGB/1fODwhkUQqDV21OKI4wg6hpDIB/drqbVpH/Qk+mG0EuvyXhm9aUgRflUb41oPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 04:03:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 04:03:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 0/4] add skc_to_mptcp_sock
Date: Tue,  8 Mar 2022 12:02:49 +0800
Message-ID: <cover.1646711943.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0164.apcprd06.prod.outlook.com
 (2603:1096:1:1e::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 964e29fe-2b6b-429a-68d9-08da00b89006
X-MS-TrafficTypeDiagnostic: AS8PR04MB7862:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7862CC19A00FD63807334107F8099@AS8PR04MB7862.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8dIlMdERLCOsXWVP9Z1LspVSyMUYCpCi9m0JFnbI9FsZGWL8sRnh6/ufs8Co5ZNaOv2c+wxVXPsOkafecruLaGG8CLuitjhOjYAnWr4tYesfdpYwU4muq/U0kV7kLeDBK3abwF/c8t19nAkcNe6Ii3TAmbpCtCBDnWEC+VFxpBwRc7UP8i2NO2uxXmdSKvPSy9ROmjtruC1mWY86BtVnXadbXcCqO5ZU3Vt6wEZRvDs3NRPOzjWi3usFfLP0ovrB7k1HK/jDig6ZemfI8OSKeZB+3fOs8f0g04JNzYl6sVHmJ+RRRlfCk1HZUsMpYazyB/sm9exIkQKEFDe+LEPBJSkSYn/fwWi5/E6X7NPeKZz0DxbhVqnAJYoLnrzGbL76NzRLZyaqmCeQIj5xoTD7o5JvuHtSquOsPc68OIWrpQsn2JxMC2W9VkuSfeVi0ZF8d+H70IHGTDajD6KwL5fny1PScamtG/aUb85PhOZEdUA8va9E4mTbPaViS3ErmENvKzWXhj4esNLnJDkLt+id7u58GWnFIEBTdrmJRUh0CW9LXFhHS4DXRkS7ioWcDGKz2TDj5LZ0CGS60Mm1HGbZfTs4rosdQN7y0jmubL+cfh3gnsd23dyawXQvoQhbYaXJlMDE558ZkVB7NdhFkFmZOxZpIaXB+meICpZe+jHlVh+n9MZuPoqx+0YOaeqhAPgE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(107886003)(26005)(186003)(6486002)(6506007)(6666004)(6512007)(38100700002)(508600001)(4326008)(83380400001)(86362001)(2906002)(44832011)(8936002)(6916009)(5660300002)(316002)(8676002)(66946007)(66556008)(36756003)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/6EcJidPsF+bzUEkObAiHQAVDb7I0qNfGZj61F4IGp1wemdggNd3JsXiJUVK?=
 =?us-ascii?Q?/4QyZunxf+Ic4F9jLQqJXcX/qKudIQ+PUeAKL115esdv0TBRywKPNnj4UGsO?=
 =?us-ascii?Q?RpUVkYFYr+UgjthS/Pdvd2G9e6SDE7xF4l1fjEpSVDLd32rhurFf2HS2Vs3Y?=
 =?us-ascii?Q?X+N+dpeOcHt90LIMoTZNiBo9SbhlpSHaEofkMbNIJ4iyPeTONZVsDP2y296n?=
 =?us-ascii?Q?f/njyBvcS2E8wX6Tom5q/ndbflR+Bjwuoz8KsixVf4Ba0EMp7dFSzTcIqF8T?=
 =?us-ascii?Q?SiBRJ375fIe8TGFqIYVZ7ubqGOu/ipORXh6RZJUvPZqkCnHL+nVImVGic4tc?=
 =?us-ascii?Q?1mgHtckvSccWrfPrVkN9r65fP+mdOJwysTGCP6nchMzDzmPmsCWft8uMZTwt?=
 =?us-ascii?Q?S8lc3HZeoHWqnvALVWD3iI8igssT8G8A/Efr3FpFuncap1x7BB9FzxFV3zv4?=
 =?us-ascii?Q?WS45VghQj55f0Kg0S5/oLT6OzGtAikvuBHLTneIdcMVkiHy1eH2FDVHctqRY?=
 =?us-ascii?Q?5mPfUUSHGxsFenwSzkf9RSGKqqQUYYe/lFnaVXJ1FUV4vd2DIgByIRtE4sUN?=
 =?us-ascii?Q?YMUtKD/9KXy4DY/T++LGbdaLczGf8egDYnm0NIG/Vd8POIZdD6D021QWP6BR?=
 =?us-ascii?Q?Df5jYEinet/AnXq748jmqvwsWBH6twUNOrBUZWcOjECqu7zPL2B7ce/YgWBN?=
 =?us-ascii?Q?OJZ41S8ySOJJsiNL06uE0Abc3O+LqwWRwUWP/9mzhT/1sceVVrCJj6eGF7cN?=
 =?us-ascii?Q?41k3HX7BTikCG1ZeMuwCAOze2jq3IqxiOVyEZqVjubzQXsWbHI7w4iOW2czs?=
 =?us-ascii?Q?B9hdqjPDxSG+ZW31XWg+Y1ylR52gT6fPHXbr1y8fN/sxUsfc6P2mM1cqtEUa?=
 =?us-ascii?Q?GtuuQG58FFvotUeLj73T6aGyVeVzqeeHzHTs2S9sSvAK67Ot4eZui3UK8L+9?=
 =?us-ascii?Q?8+onRrCuPDgEFXMpUq5+OYo27ZxoNNl4/pJwBr1G2TqkTN159a5EUIUJfTIS?=
 =?us-ascii?Q?3w9rqEp4CkbVjqREMLhri5+MxxWhJqkfhwBEmbcAFTXQD+wCQ5g9dhHxT3LE?=
 =?us-ascii?Q?ILfc21CnHzwt6D4kyo+3m4IlSQTcsh9d0JLI56Y3GsXiRGPcjjXrIv/poBwo?=
 =?us-ascii?Q?BahYY+pQfKDfbPYYvttUHdVTG0leJf7po+h9kJgT8NUvalFOAm3rJ67Du3Ew?=
 =?us-ascii?Q?8J/V0ofrPsVxqtb3CGSQHOiSYCgPxzt9czmiIWuYMyZdHJwRQLVg0zdia8FI?=
 =?us-ascii?Q?MlOCZ5giwIuFTzPKBwlD+D+CpFRWMGcE7IylD2ray6LQcS/a9mt4peNIMYxq?=
 =?us-ascii?Q?Ih0BjUcSTY4hmzgY30qpxgtv4XcS1XKWhYRoDk3g3wEUgXN4nNMfSSrvCb8L?=
 =?us-ascii?Q?UPCiTYQSWvaBjUMK8pdF+9qVYdlmtdlS1PeUjab7hX0GOwL4GNW5+uZLNVNH?=
 =?us-ascii?Q?o32mwcBUJhjlKy8Z3VboGXfLeAjAInD8xQSCrzXhUZB8eGwB9qaD+VB3sFQD?=
 =?us-ascii?Q?rNLLCjojAdOFkn0Rs7zszamp7N3QiA3vnE8oxM03AZF4Ql6guy7MuqY+QsVX?=
 =?us-ascii?Q?44TivsWVyS5mw/z+TMh6zyJFS4Pmq/77+RSN0DwRKrkPfy6ig6T5jd35Wk6C?=
 =?us-ascii?Q?+2G80X5x/sQdOY1JGoA6JZM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964e29fe-2b6b-429a-68d9-08da00b89006
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 04:03:11.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7jPQqUHO6vZEEkA6WfrbpWSAYs2W+QY9R7VbJrI2c8+OX1qZluONzjAYMZ8MOatGmEP7uDMv/KqNjym4Lvjow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862

v7:
 - parse msk token from the output of 'ip mptcp monitor'.
 - add Nicolas and Matt's SoB tags.

v6:
 - add skc_to_mptcp_sock helper and test

RESEND:
 - fix the CI Build Failure.
v5:
 - fix incorrect token value
 - verify the token in selftest

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Geliang Tang (4):
  Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
  Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
  bpf: add skc_to_mptcp_sock helper
  selftests: bpf: add skc_to_mptcp_sock test

 include/linux/bpf.h                           | 31 +-------
 include/linux/btf_ids.h                       |  3 +-
 include/uapi/linux/bpf.h                      | 14 +---
 kernel/bpf/verifier.c                         | 20 -----
 net/core/filter.c                             | 21 +++++-
 net/mptcp/bpf.c                               | 62 ++--------------
 scripts/bpf_doc.py                            |  4 +-
 tools/include/uapi/linux/bpf.h                | 14 +---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 73 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp.c     | 19 +++++
 tools/testing/selftests/bpf/verifier/sock.c   | 63 ----------------
 12 files changed, 135 insertions(+), 195 deletions(-)

--=20
2.34.1

