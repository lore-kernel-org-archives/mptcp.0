Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9737C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lFMv+Ytdj0QTkY9LuMQFBeLSiiLydqyfQQUmHK64Kwk=;
	b=NB0sa6mwLLsCOl6du7E33sP31cIxYjAVCGpegiB4ZWEEerg4kl9vw9Muov51k91r9AGTCW
	V0cZoYCXFFcIXYTBIWvtHlNWqExlJ5nejFxwx6qLfAbcV4KK8UuvM9Vh6LstlioJClOcWd
	ttPAVIV8GMFvypB0P7PVBPWqQEfDmbY=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-hg7YKJGhOt68ta9GbIrFQA-1; Mon, 28 Mar 2022 11:38:06 +0200
X-MC-Unique: hg7YKJGhOt68ta9GbIrFQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIM5RJ/8hMi02pBOvqYHxFvxL6O72SsFB1cDRqZvOd/LzooAWFr61hgtqxqhbcGO4i841Hb3PpVsmh6bGp+nAzvPyJxEWQhe2eRCsI7pnxxvV35/sBqfTFYJNvX7D3LeAS8wjxHgZTDOvvOwaVJgzr+yiQ1YYzoog39jua5+u7GVisSm15uzEUPXDGIGPiafpENM/2ataoAIjvnMVLM5iJ00DtmkvJrscIWqYwxufSHFCvjaS5qoaKrVdLJxzdHM9k9mRTumR7IUjAd2UA4eG1ChcYU7+8mIUAv9jLuFNnFlorEr1wMk6+tTtzkJ05BhPvz9as0Gp0k/dQbB3pL4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yolPwfF+mlA3qLDDjeu6R3hnSqTAFlzVFN7cqLzqRY=;
 b=HDThLThemka+drPggzoE0K4hy8JtxWtxPaRWKUwKZc/DPJ9YxFawmWqXioWL4tkiXBNKlMi1guzj8PeJ9WHMs/SWhdXZzHXYTi786MAqdKK970eY63A4S7CtFX8qcJ16fc0Vc78NQPAbXOXRrzpDUUmqwpbY4YSzPZrpMfrSWwlfIB8jXBhSYtJNpF5CXR76AKQx12ZhcCJCyGRziiAPA9j+u2RsjBs2KYptQ5WgabAmZNDGapO+19bGQVzF9I+iKL0wV/cz0Ajje2y10BJ82ECvwj26JQxNnHPnVOuGBiXhimxG2PrBGC3dq0J0uUJcj3U+ypdlGinntmpWmfR8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 0/8] BPF packet scheduler
Date: Mon, 28 Mar 2022 17:37:54 +0800
Message-ID: <cover.1648459865.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8541d28-fb97-43fc-20dd-08da109ea743
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5067594C430BBCDA79A42C64F81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8o3vsYI512MxEsYrFFVHTkmQ6FFk+uNRtRvkpeUL70WG8GcECrtdxOLjNOZ3x5AQawYTpifLUuZxoTr0h7y6uUdcFevpIRsBs2L4zj/51fT7gJNSQEPxZsJaGSHpvJMCJZ8KAfUeMFUiTQUnu4tjOpLPf//riWfjxIqQMf2UZUdh6hyIZMNPQEmSzjqSYN0JSpu5ljIgtJ/s7K2bYH9etXXSibn97ZHBCLhugpJIrap6ZlLAQHpYzUHn+98rnhhe/y+/BmWETr832UGvGfBz+X77/49B05Kla7OK8FWzMihd9YyaO81UwNpKIBay1yDmsnFcFZnUz/Z7WyP9aX2zRz9ar0XXAet/60riPllpY11BUWwaSF81kldHggtz+mxWZ6OZz7z/1TtuSVk6kemRbwVIWIHDqmSGr6bmIbwqXdxRonx7FCMuwBvD28P0hJWENnwvZkxPCrv0GzDUwMTbR9YE6WQTebbVvEbmHO/tgtE/GIMMHoitenZYvlJEmboUPVcHF4qa0H8F1dC5CDOSkbIhv81GP8jE5zhldTJM3Q/fZH4unhlxrD1IqXVSNffpsrVGWj/e/YQwUJPkiC54pDymrTosjZHGPyrxRXMQvbtXV9CxWmXvQTsJulNkR5RDcvIncLJwQZe1UtkIL8c3CUrjZzUKIjWNo6UrFWo6OH9BRSGOrwjrVyFhEK4QH1iftDaURBRPLwM8BmJPl39Nm25gE7W0pOdblvXuYFaobSWDhjih5rB8cncK45+sNNdWK8MkNvWjU2pfBs9KbtqOTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(83380400001)(8676002)(4326008)(966005)(6506007)(6512007)(508600001)(107886003)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K77HVPeOkXKfOFjo735u6RVXjIMGHzeVPXlkKscWkaS1Xkn3ixqcjZWPqlme?=
 =?us-ascii?Q?plO762SdzFhFGawaPEuuVFvOecLPO7/FuTq4Yfvnm8/FhOQ4PZk3OOuenLrm?=
 =?us-ascii?Q?f751ALY67Evn5t/g4DXroHZUEOObUjfNQC/fvw2l8TskXzO6+3PudCI/YBkF?=
 =?us-ascii?Q?t7KYXswO+1sOyl0kJOHyVSWu8Z9l9mhzYBXyXjn9sBMLt07BSkc+Vq63q19C?=
 =?us-ascii?Q?paScPb557//C3TpAjwqJKc/KkkrwyMRo3og9fr2XSYZ7L/cSenkavcylBEUZ?=
 =?us-ascii?Q?vCiEV7oWpee1Zb83JIJ0WwTzQeoWrhm6pLuRgzb3APKDt3//NYWbmKL50Br0?=
 =?us-ascii?Q?Z47iRlHWs37R8NL7uwTd21jpT2GnY9f1oFQ/QLeg6QNP1ToPznNFJAZfkbM+?=
 =?us-ascii?Q?F0s5VYpbA7M65GQ7CLhW7fgpeGByLKeTpqvUA3QbUckFRIR9FAEv7oWsZHE7?=
 =?us-ascii?Q?YeN9p9naXC2wIw9XXSoIvxD3y3vExLaDKGSdWyi1gUDrGgI6rbhB/jdAXe8I?=
 =?us-ascii?Q?DH3ZMimdzFVT9NkcorMRC93gLJL7eXHRV8xwBOgN2dH8toZa4vDe58Looxve?=
 =?us-ascii?Q?H9VeIbwcOsF2F2SJUAV06bQ1AUNVLS7H5+FWdMN/W7pFVvZnhGX4Dkgxf65A?=
 =?us-ascii?Q?KTwIHMTGIZHulklen8MHxuNgfAEkZZTAVWrz5dbIwDKwZNCXpf8SJwIJPFqV?=
 =?us-ascii?Q?rJPFs7ppiO57vTuavGWB05W9Be6iNjmSBogHyXbVA3ca42K6b2w3gtpqJt1f?=
 =?us-ascii?Q?Km7xxQlX5DPAep4chsK7TF0PJQTGmrAFixI30x2SIoYULDrsRGQ2mTZxU0tW?=
 =?us-ascii?Q?n96ZfBLMSKl/zieyuvg6nfXgkWcSM6mG0clo9cokDlbHQOLFfczV7Zqt8j7D?=
 =?us-ascii?Q?Me3aap9kmikj4nFXyYhTvnudaVtpWf3fcvwE1KwfJz1/V7SbeZy75jERD42m?=
 =?us-ascii?Q?Qcgv7aPIAJe5uiXRbDnM7wsBYHeBnFOicmqf682/Y8j39xmUlhN+9wWziinv?=
 =?us-ascii?Q?N9WGrYz25cqiVl4svQCegSXZcsBGjTY7FS7nzVmOPaHj+qc4krdZkaFxmFq1?=
 =?us-ascii?Q?hxB5gTgdUHxeRBRSOszsFFmmb+lg+WX8Dwx99aSJG3Qv+iFQ/AOnm/VesWHu?=
 =?us-ascii?Q?W0UXVMa1qmxgDutRkpbT74QyA6KnmAL5eGfL/bzo8X6/qgBKGuQ8rKHv5v+q?=
 =?us-ascii?Q?pVp1lfr0z8ANChuc2sxsoBm8MMlcrMyingt6jQcp/J04Df3vtOhORl2YndYf?=
 =?us-ascii?Q?QzHAdepHtNo9nN434WtMm0z1KOo1+MDlVthtjW5Y+3jqm7rypgEByBFtfT2R?=
 =?us-ascii?Q?R4x+c7hNe7FvgUvSfJMhEpl3VhlMCDakc97X2QconETFEsvn9qiRgSAxYMQN?=
 =?us-ascii?Q?q/vE4aWjRg9g9HSCp3VuNLuJ4P76d3c1jdmcZUsBfjfRg0Lp9ZcWgJL4Qv4A?=
 =?us-ascii?Q?JaXADfM0I0XSszjCzdUHJxy2vCvfTo8wbO7VGm/bRSU9XuLtPC5l1KWWYDzq?=
 =?us-ascii?Q?ZQT48q9sJRHZp3IK/3DDp6Ys8B1CJo+ucP0LTli37DEleu17AlDqMEumN5Mm?=
 =?us-ascii?Q?7fkI0VzznjD+88OgpHvGzgkP/S/NbjTD/TH2R13Ou4cbxe6FxhMA780/zkuO?=
 =?us-ascii?Q?5nrYrzCqgO9VluWTbiIMZ4IfdRRqoRA15Q+gEND7Axv+kXN0rB4ZX91lqrhU?=
 =?us-ascii?Q?8NSEtfQ7E9T7wWjguOl2JAlAJb6/Q20mxhJgKJx2JBg/ovTEwbvmOCfBiKY4?=
 =?us-ascii?Q?eZPrSyV1U9PyBegNvIoLyXWIC7NGJQU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8541d28-fb97-43fc-20dd-08da109ea743
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:02.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tu9D0aCTaqWBUF/RxYIzb/Vk7wd/yX6XtYbLMhhbrX5eyiuMJxiNoMBpUkcaJ+qurTq7ixx3fRmdZr49Asq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

v7:
 - add bpf_try_module_get in mptcp_init_sched.
 - add bpf_module_put in mptcp_release_sched.
 - rename bpf_first to mptcp_bpf_first.
 - update commit logs.
 - depends on: "add skc_to_mptcp_sock" v14.
 - export/20220325T055307

v6:
 - still use pernet sched_list, use current->nsproxy->net_ns in BPF
   context instead of using init_net.
 - patch 1:
   - use rcu_read_lock instead of spin_lock in mptcp_sched_find as Florian =
suggested.
   - drop synchronize_rcu in sched_exit_net as Florian suggested.
   - keep synchronize_rcu in mptcp_unregister_scheduler, otherwise, got
     a workqueue lockup in my test.
   - update Makefile as Mat suggested.
 - patch 2:
   - add mptcp_sched_data_init to register default sched, instead of
     registering it in init_net.
 - patch 5:
   - move mptcp_sched_get_subflow to protocol.h as Mat suggested.
 - patch 6:
   - use current->nsproxy->net_ns instead of init_net.
 - patch 8:
   - add send_data to send more data, instead of send_byte.

v5:
 - patch 1: define per-namespace sched_list (but only used init_net
   namespace. It is difficult to get 'net' in bpf_mptcp_sched_reg and
   bpf_mptcp_sched_unreg. I need some suggestions here.)
 - patch 2: skip mptcp_sched_default in mptcp_unregister_scheduler.
 - patch 8: add tests into mptcp.c, instead of bpf_tcp_ca.c.

v4:
 - set msk->sched to &mptcp_sched_default when the sched argument is NULL
in mptcp_init_sched().

v3:
 - add mptcp_release_sched helper in patch 4.
 - rename mptcp_set_sched to mptcp_init_sched in patch 4.
 - add mptcp_sched_first_release in patch 7.
 - do some cleanups.

v2:
 - split into more small patches.
 - change all parameters of mptcp_sched_ops from sk to msk:
       void (*init)(struct mptcp_sock *msk);
       void (*release)(struct mptcp_sock *msk);
       struct sock *   (*get_subflow)(struct mptcp_sock *msk);
 - add tests in bpf_tcp_ca.c, instead of adding a new one.

v1:
 - Addressed to the commends in the RFC version.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (8):
  mptcp: add struct mptcp_sched_ops
  mptcp: register default scheduler
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrapper
  mptcp: add bpf_mptcp_sched_ops
  selftests: bpf: add mptcp_bpf_first scheduler
  selftests: bpf: add mptcp_bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  13 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 103 ++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  14 +-
 net/mptcp/protocol.h                          |  20 +++
 net/mptcp/sched.c                             | 154 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  30 ++++
 12 files changed, 483 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

