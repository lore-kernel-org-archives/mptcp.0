Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110256FD2
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 11:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2VOoP6tcYzT74NjKm6PNTGadm8jutp+6FuQWGNIN0O6GPb1qROPIrQUoyQCF2pMnoQlDgpy0vfGl0k0/fcsNS+1RYNyHoi8PRs1E4lDhogmpVKXldvURhsbYh0e4Ic9mWcyL92Kvgin/4ht0LZOmW2xQ/PqsUkPsM4XAPDIHbHXXG0yHk5zz4ZUwSHA3BkmgMy0pb0Cx5K7NgcKQ5j9pWz/JEK3CIiFSs/jt2oUjKgW2HtrodAsujf27O5Ou0/Y0gMTxOToM9HpE+refgy+r4Ob5B+E5YV/ch8UWOVTgkBgNE2wYpSJLCktmEfOuJUAgaulzeDmYXAzFV7Kk8SP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NDwGJLDlQwvuaAJuEih0V9Gp92q86kwfKSeTOKO5ww=;
 b=jT5Z0fkUvX8Q8nK2MdZ8CobZYR3J6wjNWL8bkQQrkR3bZ583fLUbRKjUzE5KZqU8aXdBDHFQF7To8lAJjeM8KT3gQ/m3qR4/E34kUA9sCIHADsK1x0CGVcrO+mi4TiolWBAOMxqBaJjfke7Yc4Zkh8skHvSGIhnW+ZO2gB1zIFQPmasQb5FJF5YF3lTY0kLNkBSvp8HYiMl9mzCjPwiz9Nto5rK/+Mv5/BGZp9TLgjsiZHHhHFl9E8M3VOpvJsMf0yOSKjPiUth3OQV1MR/xMgbCVWH75bshpbmQ9TZJ3ox2Lzoww0XwxhJWq8032S5Ns8I4Q/VL4efA+LEjNrNmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NDwGJLDlQwvuaAJuEih0V9Gp92q86kwfKSeTOKO5ww=;
 b=FXGsri+GCWuj2JY+FFYQRgWtGbC2zo417tszHm3TUEpJgm/QvOTir+qUWmEnXPzC6DtNIet1A95RVCRgKo5P1ezwovxcp9zKZgxqGP/hpfp0YjE2De7z/UYgY5bsRwzJLBx6H43H9kNl3WDuA9lMjxCS42VD6IXubr2MEAXgCKIux1Mb0kJdRfM9K6bsrOxVS4ItYNKMteCSXA3q+Wgf9Py2ssClhfdraNK+HVuB39oXPrQdRj1c/0FRgCgdbAJ9NDIMCXO7jXR0Myg2WEn/69Uze1TDzePph7On5LjCXn98Q+9Rduf+iGnsSYfEGzXzVeqcXIYefQxw2t8CiS/lng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:56:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:56:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 5/6] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Wed,  2 Aug 2023 19:55:31 +0800
Message-Id: <518bcc2cd2b9d21934bb9f1d1978e590c549801a.1690976940.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690976940.git.geliang.tang@suse.com>
References: <cover.1690976940.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: fd65bd4c-a2bc-4f95-c94c-08db934f7bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cJFjDJXp4iNBrMwMXN3Z7l0Br++zBZ1O8Ki6yx8F6wMdHfrS3pzJ3rBzqCpB3d3TJcKc//Gnh18so8gBqark21sSDatY1Yy3m4PA1UZuKuWUggYkTxSv+tL22F9gK7JnyUS4bRz/6ZWPir+jqieAzAUIOnJDZdLYtFAnd0KdTLvyAPZLbaE53EoaKzjJz68SWZww+xpG1bzgON5iTLrZXXKtMFfxl4pIYi7i5/gAX6IX6Ej28LW+BfDXhvadaD9FPJCkzXy5gw5ho1ZldCsHH5YNXvfDG/QBq+SS03dwR76jxRhDTfYEBZJQtMzmebMfZURXWrOHmfXlXUQ+YKGGAEzsNwpeLGb0C/KelgTA7GGS8iIAgwLEUmCgfwIW/jdthtNLqJviRyZLKI2LLFf/Z7EPvDYFcwPz177g1pvvZvcjuZCE2BpYv9+WQIeFzIgWglnbItQNzZtJdilQf/Jm0kAMpeKcSwBVebHNZ7DpSqg7+HlUi5Cf2ORIIlotUoej/2lLS8Iu/EyS6cEkAfoCkHtS/qlQOczZMvlxXBGEYq19d74fN3WyuzQB5XrGDs9T8jwR8F06q/1UkOyG1UJAgdJQq/2hqwLfTMHJnLOvA08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(83380400001)(44832011)(4744005)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(4326008)(6916009)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NuVUlFFetpwKgN+PGkLqlxggSfPZe1pT9ef2OZpHVGtAK/GOwZJ4ZqwlGtdv?=
 =?us-ascii?Q?5Rw7fFyWDAczqjJleK5HoyX0t6iiDWmJXDiUiZW0SVKd4SmjNNVK3kwqDund?=
 =?us-ascii?Q?hmxrtSngYuJADb+ZNOKkvAIT6i2fkmHab3Ldb10vcmADZQxjuQgsE9sj/HO+?=
 =?us-ascii?Q?jIudYMAokE5ti7EMyFDXOCqrybbUaEmIX/BdLTu9zxVqnzE1QOKdQ7/oyIsS?=
 =?us-ascii?Q?NFjne2QOyiAJqPYgeYgzaPod5+UXAXg576uAUue7PQNp1wO6SaCUBKkDYDgE?=
 =?us-ascii?Q?uRizaimynzrJ+C8bb+0tDAV/8wZ7OnBL1x/KWYuK36JjUisQdRvYi7oPutDG?=
 =?us-ascii?Q?9N6TMlocc417HIIKg7OPatig5xc2Slv6svw5dSUXHrxMpEQvxqkyCiD/Sb8+?=
 =?us-ascii?Q?l34QJLsi3E8NKkX+/iD6VjxjH6tSbKrAncNscAfaq1XQI5+uv9TfA9kpfGjh?=
 =?us-ascii?Q?IQd8Smg7s0WZaiKRGwTp3etxlzrWDU42piYyXtH8GlfiTtJ4x3nxyFD9JTdp?=
 =?us-ascii?Q?ORcbGqToRxvI28GqKUjTv7nvSTAy3rDHMwXixy0vNnEaO1kuHONceFLAlj1K?=
 =?us-ascii?Q?GN1CgDpeCPtSo8+3xL3XEuBu8cPDwC+/FNEfxQHBnu437SVPgBHic4luEoVK?=
 =?us-ascii?Q?IVDcKPehIwrmJSbX0oixfjKyaC1Mc7K/XPPcYdg9ekFGjvoSPszvXakb8XSs?=
 =?us-ascii?Q?NJkKVLfXXzkDs7WVgoY88GGY+a3FzckLzIY26g+71vukqSGCCcFQjo03LdIQ?=
 =?us-ascii?Q?+IiZl/7uHhYMqIIBhNBBCqCcAWUMSRniX0JyzjfrN/bBgFy6oI2nAFy1KUbA?=
 =?us-ascii?Q?cCkcBNNKcZ5PYmvY8CCRdAaiN6VeVLyf4ItOsHFYta78hyCuTsRR3JoR5BoA?=
 =?us-ascii?Q?MnYISg/8dq0xQcx1bWV1zPIbMUx2riPsT8sg1pQNdHfPi6YwglJRlJ2rMM0S?=
 =?us-ascii?Q?+2qcXKiBQ8OZ9BzpLlT5MFqPKPLaHyNiMWLWhH1ysLuNmsz4ZP0mR+xgm/kJ?=
 =?us-ascii?Q?cwmkIgBB0CdjCwUfTuHW/o5BpRWAvnG1s3YLAWyOR8+tiQGHjS720yA7QsNI?=
 =?us-ascii?Q?d/lJYmRQHcqYLlb0VyPo2Y65UQICaBbMGHH+aW0CXN9Tb0l1/1mN9I5jHryC?=
 =?us-ascii?Q?L5CBT/WzbMUEQkSuiwzBil9ptQ447srG5up+2bFCusM94MKpNXm9haUA5C/R?=
 =?us-ascii?Q?UF5H06umxbUvy3tTg+pb0fTq7nuymuIiQG9UaXliqzw/2pcQhS1SkEftoX7B?=
 =?us-ascii?Q?hUGu1EtYclA/Cco+gpr31vqnpav3/XfEOclQsmzGeKZFoXuTaKcZhloD8jUr?=
 =?us-ascii?Q?z4dEhTi2gtDmWgrOS1XAxdoRGkZhpyiQiuZYxJR8hkOexxYiA2fVN5v4i/EM?=
 =?us-ascii?Q?jDpniQ2Yvci6CB3eiyZ0gphY0Fd0HrFxYGUxYKu2q1LUkZJDqFP9UqBAbd6o?=
 =?us-ascii?Q?MVpMZVljSVOO08BK/KPKEB3WIHQgZTSs4raiv03E7X2owJjHPwupeOXvGdPp?=
 =?us-ascii?Q?rSK5iWh3nYeu/TtQfFrTOz6YzM6ijS3j+GTqFKfEg/YzLfZjt2WlWMN0KEiF?=
 =?us-ascii?Q?beZXZPXcyOTy1kIfcEv6EVu0f/snwF3yUpVrUCIbth6F0AMmvGHumc6GU1lJ?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd65bd4c-a2bc-4f95-c94c-08db934f7bf9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:56:19.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKRnHhIRhiZLbw70v+rsrMuSkmoOQLwz7nNMNvb40agORAG8tV8B9u5Hyg+gLJnSHb6gIButCpSUlHy8szNC5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023

Use __always_inline instead of inline.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 5763bd27f56d..ff4dd13fd8c6 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -274,7 +274,7 @@ extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
 extern struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-static inline struct sock *
+static __always_inline struct sock *
 mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
 	return subflow->tcp_sock;
-- 
2.35.3

