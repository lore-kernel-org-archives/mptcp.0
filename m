Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00683D67
	for <mptcp@lists.linux.dev>; Sat,  1 Jul 2023 12:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo0a4aI0JbDN2/mbX5fw3dPFo6nRlBNPv6WGizAHod3eCDjfwz/Ll87InM6xQUZDGr85C1ygye5JaSVXfHZRsTtvB5GiKS5tlf4i0MzvOGCwFdOj9u3Ntv8aoEz2thlKx+R9RdcyoKP9OROvv/WDIxaOHPE6gvqTHiRNQ3+ZglqtNrFvsroFHPCxDs7aO4oUADCjc2ZrCmhUkol67X7lFufiDlDdF+77sFqXlnccDgXf6jM54HhmRxZbJYyX+1dweNkY7NIrbK+S9GpkT69E+dUxvgdAUm633UW+hgbU4i3u0nV8wB/7QHkxuOOpoMN73yE7EGg8fHWiy3VYmCvxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDMQxHo22+8vX6ybz/oAgev+vyfduKDWaVP6SV6lsOw=;
 b=iAu+nlrx+jVIfb0Terh/N+6pOv6X2OA6ygRPd2R8/m9VtxoGJao4uXsqurNzNTfX7PmLo2cOteMMNrH9Fxal8Vt8LPuh4OHEJnsR+h11FsA6CJEj7qLP0h7w8tN7YUAcY4yglNr9vak0YJi353BaA2/Douw2Ys8lUHbPKzrwFK4cJJNu7pBxvLCSaiGrJss/zqKdRQW8JPK6O0Q8o5v6X4AyLhE/i7QvEFBEyJRXwocEeb9seWUrM9sjOZpWj6sSPyNAqu4y/u/ik+KInfAB14eJAGOxXkA/9Dz5zd19D3Vv583ukTMalQOPwwHvcdWjoszEmHle8wT5f6Dai2SE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDMQxHo22+8vX6ybz/oAgev+vyfduKDWaVP6SV6lsOw=;
 b=pJHhnx2+62AmjvbhXnnumLK5tWPfBMBcBbDsEkU3ZUgN/Y4NI7E2YKPEA5aYGU5GmKFLJuYtqjSB/svFsFoW6/BdlMVSNNm7yDGZuNocIMbGvcYJ+UoW3J9drBhKxrb66cikFGkAuXK8c0TNO3FsVO7sBuM7cnn9lUE6luSdeH0Lp1g6yiWyAkA/BBLnnCC1K+7IRt+V30EU7kb1tKVcpKKoLRPMH1nvatviSQAkwxZOtiAhvLy1d3shDzGndYH8kPRwLQtlt//XRcJWB5R5ulEFrSJ9hh9ywpn3sK6xH+Y31f4jHEHLchhXOVZqCLOMNduXK7KnTs+6bt3Kx+i2eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 12:57:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 12:57:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/4] BPF 'force to MPTCP'
Date: Sat,  1 Jul 2023 20:56:56 +0800
Message-Id: <cover.1688215769.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 414f7cda-1551-4fc3-738a-08db7a32ae4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YfbL/DlHL2oPeHjIf2aE7G6fLByogQ1kCLj4yzywGEKFzgEITztmdXlSAdrBBPwgKLdarS7WzKkG9JGtZoIMxazMx7zxcqat1zjJCX9mAqxv8QU6l0mPi5XhGWwZbyC7NtWQHojhmAMWpzXiFckBBAsP9sqUxD8uvilwSm4pFNDKtOEKjCDMH0S+41dzs9j8MG7C0tiakdr+L1f28igbtZ+U98R51nva68/KNEedeuuGxsoDtLY6b/TjE/qY4Kw2PvGJQkp91nF3q/hXx5fb3pr3M0BOpcTbjO/k9kIG+6E2IcOBytzrIIpkNGcU9jNEA2HkxK8XvmAHUbVtirp5e05EXcfm50Qk77RI1hupqoxRMkd/nujjGu5INIWPBQvhoE9l21be9oJgPHyzM01kaD1llKMNornwp9RIWpzIvCuwYHn6Mj3Nstjd2fEgT52vVntQ1SdlL04LfzGSiTMUaxAqGI3HVAg0oCsxRBerDWJ8XU8oHXB/eDvHe9QFkNDoH0yp/g2FWbdsnseuKBEvlq3EY3a+cCKBm8FnJ1WgNag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(5660300002)(8676002)(8936002)(107886003)(36756003)(478600001)(6916009)(4326008)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(6512007)(966005)(41300700001)(38100700002)(44832011)(186003)(2616005)(6506007)(26005)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4fMWJB9zEqVkjNHRqG0gCm17ewA7QDeuk1wBqqEu7lgS4ge3gO/LroErX4HD?=
 =?us-ascii?Q?DrXAKsYEEoPuxfqJo1dMyG9PW+4Q7L0DLZ1R26xVtR8YjsN9ZyivaF/TvJXB?=
 =?us-ascii?Q?fv3LQblVf6Ixr9xypgVwBOBTjxOGfS1O4HffmtRyylPn3l+ty+HJX2E1fSP8?=
 =?us-ascii?Q?RHmgmQBZ3ZqoInEX6yIVvMgVspfgh22bsk54JoQ96gZyJ62b5rpufFlwsJG6?=
 =?us-ascii?Q?st3/WY+k19JD+Rfjw+q4KjVhBH3c8dRBTZoEZMkai+PLgFigcUFDq9i3mPWI?=
 =?us-ascii?Q?hKptSZdUsJOVeQs+ZQz1fg1hVLHTqBYdF+gyFeMWsrpGQcg3gV0Q2SJe5VQh?=
 =?us-ascii?Q?VjBe712PWVU2YJ+aX03RoiwUY1+5xJ9/rrmhXC97WXHS8hzlKXUp5lN++LCo?=
 =?us-ascii?Q?8WVCkw2H+l1ksseY/1pkpf4/XeHu4LNyiedkMxYA6C8VdrMz7p893GWwxxDN?=
 =?us-ascii?Q?Yit/te5q2eel1mBYLW8jXx7MUoetxyatX5rm0+jrlUgR/tgctRc7wNDe990V?=
 =?us-ascii?Q?2zSpWjDw/17uPlHpwpXYC35m6esdbl1c8i86wqGsGmx5R/XjyPEVOdAW4k+u?=
 =?us-ascii?Q?R7+/05Oaz4opvu9+cbN+FyPPi6M7j8y4eEXw+itGhcH+ULLofA/ey3Ef0zj/?=
 =?us-ascii?Q?obX/fI3B8xQ43xs9FVtKoGjbxg/ZZqHNkzleSxg6Igma5cF3bbSkFAKJQHxX?=
 =?us-ascii?Q?eIssWUB+FZv/2FMa8kMCQjiB33/Jbtk0zqkPIIVFm5izvlnKNNof1vaeDHT+?=
 =?us-ascii?Q?ERxX3opHK+ca/2M88JYjwJSVHM4k9F9c6S6Ne0DHQhHCL8j9FhucRH/5q64W?=
 =?us-ascii?Q?1lVpLwEeKvDlP0YxMa8b6O+k8IwyzaBJTMJ5TJXBNCBu08dU20rUwvAvDSpc?=
 =?us-ascii?Q?RAHGyxydyZ+Is8gdNlFL0IQfRf3F5eR3OetESE6We9x7mXerUeI00i6mRlsG?=
 =?us-ascii?Q?2026KkQaZUcFAbP7sIMH3OGJIAkLbImMRIDyyhEPblwEy6Fyz+lT8sd/l2Ld?=
 =?us-ascii?Q?bqdqrmNPcR9etNfktPsfo8cVI04g9GTk24g8H9mqIyf18fQws94ef32N1EdT?=
 =?us-ascii?Q?q6Vy7cH2rHV9PZnzFFi7GmhnBUw067F2Vm2ZdtjDxb936QKDEPLiSSuVMiIA?=
 =?us-ascii?Q?zNdaQ3RQaVujoqtQppMFyenvrx8FpQntv83WyV70GK7l+yBbie4IN0duvGYG?=
 =?us-ascii?Q?YHD5+TZ04VH3NO1fbNNGJ0iuxAtIoTvKrQA6UKcOEEPErXWMJ7URxwhtrU5E?=
 =?us-ascii?Q?g0Wk1arIKF9ZZAh+X9N5GsKS6Cra5kixmjVKzByjDJ0bsImw3kso/sNnpRMY?=
 =?us-ascii?Q?XW3G9hUTCrfbuC/5gEctYYEhQ1YPtLzmX12xWVSLEfaDxy7+aU3XliO50xwO?=
 =?us-ascii?Q?bkY7HNedAa3xh7N/2oBl+uWRw6a1Zo1PqFUska2nPrcE+dmsOrr8XKsGCnlJ?=
 =?us-ascii?Q?yJtkAJVVrbUghj+0cKZ2i61m88wC2TZwfJNr9gUqTPl+U/TJM1xpBXcmhzMp?=
 =?us-ascii?Q?uqSGksmZ5FKdTxXFXIBPoBLjXUUBQdUP8WkhQ4HBhSaQDcGrfGwPhKHBRLvp?=
 =?us-ascii?Q?FvLmlvSEIpnJ4AczcVL75WnrRt/hZqLxdQiOk6Jp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414f7cda-1551-4fc3-738a-08db7a32ae4f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 12:57:10.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bx3NqIF8V65X83aHnmk6I2eR6xCRBWJJGZ3jRu/Izm+JXrPbCli950ADROaVQQTD/uFqaNsqdqechWNI7JQq8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

v2:
 - Address issue #79 "allow 'force to MPTCP' mode: BPF".
 - Define the prog in patch 3 in SEC "cgroup/sock_create" instead of
  "sockops".
 - Update other patches correspondingly.

v1:

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
 kernel/bpf/cgroup.c                           |   2 +
 net/core/filter.c                             |  18 +++
 scripts/bpf_doc.py                            |   1 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 127 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcpify.c  |  26 ++++
 9 files changed, 170 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

