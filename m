Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330486ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFf8WqQR0hVAofjjjjNAovmkFd5VZDEGsMT3yEaBAS3SkYn3IhKwOE9fVIU5hZPTTfZXyReWNLvLKZFxIjA77jYiZZTE08eS35/REztF6PtD9WrdzCbUHmcXblJ52EQfe4Ev2cG18gYlNiuQOhWflHByQrl7ALB+ls7mR7G20DmD4wjIYpfM6cWfjVz46lN471yzzt7sYsGxi63B9ilRVDhQW7HdO234jQKhG93wuwwTVtZYnwnqnCX0AXLdfhB9Uh96EtQ2uHXh/xdFHbxaaOKmfzsylcElCVEeGZT4bgV7ihEHGs2fVYxbqCFLGZNf355AdJYcyQABZVgecEAS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=bkCQyuKW8C+k2ftNqCOd/p1PLCCoME9+6+v25bYKKHZR+TdJ7FNMeEWIbIPd2gBLBY8Ry3VwC6gjhMYBrosGKTeWEi5nm1bypGFUsFg8HKeoJ5fiNPrKGTfn1gc3iVzQhRmIfsaFsRjXjrcIOwcXAfXnp7fOaUMCyn66cGYrxfgA4NuVEZd+BkBnhZ0eR/r+8hhxC/StSFYdikAPUCcA+kH9B8H2q54KKuI/5FIQK0FueeBBWxi9hrcrqlmW7vsL2LNLqWCx/d/234ofhey7/Hq+1gfO8yH7taS+oEXWRzgVrFPMmNEESO4Ahk/4WVpxgx3fC0KmNd4W1HQRPPld+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=XXr3HWmpdATTgwfCkAK/w0fbpbDia2IehHBHOPiH31c5M6+2xZVl/Bk3OZ71CweyDewhbtjje9S6/yNN7zrqNz1q94mmd7fwU6Anz5wP4m8wFvYobhpaNnlNmQfIp/SF8Hzs3AlXii5riUMmdr7q7E6sN0ZRb/A35vt+exjTsf3BcKLBhJrELuwEfzvCAfcuBQOB7y3D+M4zSZTthuOq9jftjpWeB0M9ouytlZg4LONs+mJlHlvYb7GiwaIR9YYrwbVsDt7QEx1hdjFPp1E6Oo0w3JKVl6kpyBeuz5ctFzldziEtA1xbNlQE3qxIFeJ/ZmPIpS52oKrS9i6QtNiQ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 06/15] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Tue,  8 Nov 2022 17:08:28 +0800
Message-Id: <feb14621c99ecb1f45fb26738c50bc446bd1a1a4.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cdf2a5-ca22-4c72-619d-08dac168e86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OYEKdgOSWoTPRQkidla6lgW6I6Q2ozh8fwtfAuKq/Bk2Ogb+VQbmOm3Fa/JgiTDgCNHFPXF9T8FYzkrGARkIBnEWAB5QWvm6cnS8E8ulhLwuKfhrfziGQEPn1txfiI5AUjXcJJ8Mhw8udNr/0KwRDKm8H9R74xDfiqhlBSmriGJlzBvk9ZPPjYgb/qlKEaswBXL/McGeDalSMVNSzNWVVkcfhRcRQy1LcqljV8OowuyULSUPKMz963ZljUtABRW3BIDhtfwOCp4XaLJ0hYGfDXE0ezg12EfY4sUFO+kJoqblXPdfoY81pbO84N6uP9vHqb+dddQib7Ie0W1rR2i+PlXQJ2mkNPz+vooQCuLtLJ4f8JfEi9qX/g4pgH9hgoNwoGftIrf3MA9fdWVINCNvYcQhSCsYZW9691zGrw9h1FG7DGCmwXeABmu3cxi9g974Tap9gPwQvMOE/Pi5AocxOHTPPG+zgFUJKtm+1kmTk+NfmvwUo+C9L7LVg9rxhVApwOWRW+J3RN9d+cwnp+lxxTmYlVFW0noBr0WoEwkMQcwetiS1kvGDiM6QyAmuT9MoO+zqjAFrVW4R921Zgq7KrBIO8ZEjkRIfkdK6CHQLku/TUCodd/7EQiYsCtaxZXeHV8nU6WyGN08JRIlV/QTLDn92mUbx+BY8dlGfkrduRe0TnpkEZNLxlJzyehnAvxjgwXawhph2U+o2rvU3UWsIfX+ULSgQgd2Ug/aeeDi4s1V4XBZpaOHD3X7qp4iCZmtT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(66556008)(66946007)(8676002)(4326008)(66476007)(316002)(6916009)(2616005)(8936002)(186003)(86362001)(38100700002)(6486002)(5660300002)(41300700001)(6666004)(26005)(107886003)(6512007)(6506007)(2906002)(478600001)(44832011)(4744005)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xxt3X4wxBOy8bl5azfl74mAp6EfNwhBu+Lvyix2Wa+bmxQ12Xc1kcM42mYhd?=
 =?us-ascii?Q?NY6bus6/2PMVTnKRUqdwjilksdUGtfUSzBEXDwCFuGnBRMohmivQO+3+PZIX?=
 =?us-ascii?Q?dxUlMYrLFoxT069p3h77xWc1O792bVXpRgt/Em5UWLI1l1QOKf/G+dBSzTkd?=
 =?us-ascii?Q?FnbFtYOkxgencebqhuW6Qzgs22v0pDs7I/HKuzresW3doXs3fdLjbxQ3g1FW?=
 =?us-ascii?Q?Ad3WdEFrqCXcnxT9daYMVlMH1e3kEaUKQtxCP+Gs9rHwKvz6R8E1GobqrGHK?=
 =?us-ascii?Q?ntMfdusV5caFre2S+P66ymliIvV6lFKyLG12Ub5wReo6IcCrYJObgDXaLszW?=
 =?us-ascii?Q?FOu2AA/a7zmooozKxIkwcvQ8Vu7uGcMdYTLkKLK2EWm+dudDZPOtLAhPPzy3?=
 =?us-ascii?Q?DJpAiSNg/6OE2e1jaYHrXhpgewZL9DIy9vx4VG7uQW9ti4H++VIoBJi2LTsm?=
 =?us-ascii?Q?IzmIA35oHPb5Vd7DsYscJNBe50xI//NHruOrF5NqhibxA9FJ4Iny8pFAb8YX?=
 =?us-ascii?Q?9IecNXMtC9y7VEwcTlt4P25Ec7nL7JsntKAZjU4y3InqL+wKtF5yiR5rjT0a?=
 =?us-ascii?Q?5z+MJEz/MZ8Ms+G0NbI5b3sEt6GkgZCly/vcs8GJt2x/mggK/qZxw6zvHZjJ?=
 =?us-ascii?Q?XOjycHk3ynObVAI4ohfPHJMPqVXDUuhT9XO1gZobbLZQPk5pYrnTNJ3yag3+?=
 =?us-ascii?Q?Y9GOwOCU6yf1bzmK+NGATm/QwYfssyE4r7/XT3VLoQwz6pi6kjpv3ttiEODM?=
 =?us-ascii?Q?B0G/3hPLM0UL+GuL9uZ+E4gn/gc0CiYgXqyQczoGHQjYULsQK62Hg2I0CO29?=
 =?us-ascii?Q?5U+3zmJN3QXuSP8KlCM9lF/Ic+m7tzY09qtTe/TA7kHg3iIRExEch47ML4k1?=
 =?us-ascii?Q?DDph2j5qkUWmNlt+hGWBDxmbXhv7yrr2STnbmO1AoAX0dAEmMzR+pAO1fGYZ?=
 =?us-ascii?Q?6MecRCaJzq4UDMhID9bhxNRf2i64cMUBhVFTm3SaEmYaLJpmllU9C6ny47Uc?=
 =?us-ascii?Q?5BkbvNqGluemhZoHrQ7V+h+ivMm9CpsUPQqlIJx0xf9Apl5eRiASRuBZnBZW?=
 =?us-ascii?Q?oJiTG8ar9nDTQv6h34+06BpiVmHMwDcp8aVlgSED0AsmDDKaWbJqLtyDfOy1?=
 =?us-ascii?Q?lY5B3lzJtRiXOa8c8EdiJvNa6mzLrokU/UPoVlEeb4GRXt5b0wAzPititQSO?=
 =?us-ascii?Q?NHr9ZX4jxnAijmQXApfhdPNV6pbPgtXxsCMUBqcCeBMCmzC8RrO4vREonvXw?=
 =?us-ascii?Q?5u/keeZF23SzEd9rBAZsIkOErLUwgJmTZFFaK32I7higZw/Ba/esMvQ1HsCW?=
 =?us-ascii?Q?pdR+NubZUjmDWv0hCPCFyekPU8w9VpSNgKWSVMfJu7fhFtOMRo9bEbsU1HtA?=
 =?us-ascii?Q?PeWYK0zOdDGX1GvSc7kpXA0zzhbRwV0C2al6JqzNwqPbk5e5footst/NkdfB?=
 =?us-ascii?Q?ZSDGVT371vyILNug0DI3pTgWLhym/KKG4jH9mevJo8Djy9z04dS/ERFLMagi?=
 =?us-ascii?Q?RvGHYAc0oMLfiZRtQ65VtGGhBx7K1h57skgmgfYPeubwlPBBaDazCK3H6Ket?=
 =?us-ascii?Q?Bj3SH7rWTHqjaMtWyC/eoJoDGIAO0spKdaUQxIfy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cdf2a5-ca22-4c72-619d-08dac168e86e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:14.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndqAhHyF95ZyG0uPqHWHI+FQlOU1sUW1aIsmUzJgHyqpODOoHyHD/pwIkayvC62fCi/Le+lg+kfxfTdtQbDeEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914

Add mptcp_sched_data_set_contexts in kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0a768898990f..03decb05755f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -164,6 +164,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

