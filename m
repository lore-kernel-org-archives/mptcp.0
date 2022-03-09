Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8766476
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 03:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646796974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h6NettGs2d/UanYkSFIIGAJuxlcXNnNKCS9pDyOKM/4=;
	b=NGN4MiAC6kCy/lr5/kkq6FFJGlHYAPMbfxVQnmgR+wMUTaLLtrt6m4noama1fkCgpiUXSI
	xJXCeJojUfr1TKtcb7cwlgIyWVrvhvKq8xFoJ1ooNMXN3Dn1oEU3vj5vBDyrjnrrqaJTwx
	sUIPXcYMA8wJY6AuHZh35RZiw6O1EX0=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-qk5oSrrFOBubgCqxKXov6Q-1; Wed, 09 Mar 2022 04:36:13 +0100
X-MC-Unique: qk5oSrrFOBubgCqxKXov6Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs7ZpLK2MkOyMcygFzqxcDc03NDYRZ/nuhmwMDuAZ0KF1ymaYyDZoNBu+iiITw1J9rRKdTJ6jC3/nah/zBy9d5T6R2ab1C+jrU6bMaSzC20XOGSV2jLbL+Hxtte4pFHfH1mEyps8R3HdY2zfKJnrG6QWF6/lqQXP5/3Cq8WPnfo7GodVWxDTQNJKZ0iEoVKYHCkkNA3dL+ZpGu8uTclnq64XWdnjsWZDcVBOyTge5UvEi30xxAqY5J8gGZ8v2Zp+W0stbXrMq7fNQZlTonqB8bhXDfi91pmo4n/bFWBN+Fk5kzO3yatwHomQecOO/DaZlfSnZ3/5eMQA1XIlRz8YFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIbXMSCYfKWYtdYgyD+tQMfdrNOGMqe1+jMH5eTae1Q=;
 b=R+YCX7ftzWLs9sKN1mTCdAHznCswfviP7DRpGaa3SdoYg/+wd4TS7Scd6kXGQd0FYao0dcGam6dh3z9p4kDElCNYkE6u46XFr0dBlLugA6hzsuyaj363XtwcL5lPqOCpg70Q6nerIz7Cu8rEsQKWayVxHZe7C6KucOBXP6fmmvhALWa0gg3zrxlB1avlNDtw+m0ZLx+TevvbeAkMzTXzD38r3l1axr/DcqG8MvGjbvQdq0A3tZphH0+8hCGXj6P2q25nr+NDZHQ7GERcuvz+UAcybqZGQakCBDW5Q/eIKiVR1hPQbucsE9EvxPBQxF2XGJwY+05DQf3P7lof9LNsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6333.eurprd04.prod.outlook.com (2603:10a6:803:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 03:36:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:36:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 0/5] add add skc_to_mptcp_sock
Date: Wed,  9 Mar 2022 11:35:56 +0800
Message-ID: <cover.1646796538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da2b6f13-a137-49a6-75de-08da017df443
X-MS-TrafficTypeDiagnostic: VI1PR04MB6333:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB63334C64422A33930FBDFFC4F80A9@VI1PR04MB6333.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HvWOo4+NJEbI1itYd1yRH6yIZkjPgnc1bj3aq+E6+oQ/qUqkE+lyymsp4o+dboL/oPmY94d1UJ/6bfq9zqf18l+djZzhgyr2UdGxAE6H/aKsg5QbqW+3yllBis97bJCE0IjjcrSN5a32Fj1Bsh0bsm2Qlt5nmXWd6+4HThlodrpRalmYMxdDG+Eth313ZlM2FoGkWyFl2gSSf5RSausKvr1N6IxVUyRAmGMjH7b6ixFQNBf72qX1dmtE3m5iRwUwB5dFTFJQ9gRa40wBdO4EBnYwcaSioSIV3iU7manQ3vmr/o+5Mt8EUmi2y6mlSwHXAXlXBavRsHXM/+N8PFF/oKq2s+HYhDczmOif7Udh+vM3u0kT+Xm/hx/X9nplIOxE49TFLQDFKvSVaQozlyrSKukqeWQ09fSl4UmrunEMJFiGxmWubs42u0LC8SFi7SZ5itAsc2SiOvUM4TYBawPF2xnjBqV2rfaswsqK98KN6KJiU8nEgU4qMHL/BOJspK74MKu8OpMRP1JQS6LKjYqfPsu+J6XJJeNBMizn3GO3IgeAhB0EtoicRvebm/B/E0u7ryLbGS4y6MRITeMYDBjoYjRi0Murmcy5ABrYtMv14Ez7CXmK7srTmZEGHmec8qUpElh7QGJ8/hIp+sOL76qT4Jl+sgWh69UczEMz9NL7rhRoHn+MVVRxbHwTKY0eSbNX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(508600001)(2616005)(107886003)(316002)(83380400001)(6916009)(66556008)(6512007)(86362001)(44832011)(66946007)(66476007)(6506007)(8676002)(4326008)(36756003)(2906002)(5660300002)(6666004)(38100700002)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TjoBzUr5KAtrlYUiYTj5itceNFXRljzO66lcgrQXVbzgpVDlrm9zZu9LMMfr?=
 =?us-ascii?Q?VMJRRFjbc0H22dquyssNAhKo3SbTBFW53uQ9qGcY7NTwUtP+vCQnJcS683Ld?=
 =?us-ascii?Q?iGT3qHCkLN6Z0VkdBvt08aIUBd0cao7pOHq2FLsccApZjXCX6EVwO2REXmy0?=
 =?us-ascii?Q?MHhHKNj8fAlwq9E8R2UewLYsbjP26x7Xwfy6zj8F3PY25Vn/leaG7JZMYzPJ?=
 =?us-ascii?Q?gvIrDv4IAXQ6OoOEF5JDNLXj8kj7gQTwrFS09ui8Z0YeCMjMDfw9Q+WnIHJa?=
 =?us-ascii?Q?D6jXstDjjXdmRqzjO2qTX7YatLDV5Dpr75Wyi359w8/k4vkT1GrBvXI7CYy4?=
 =?us-ascii?Q?C03Jh7x5L5pqKmHwosJUkRGeDlAKzNwauUky+Nm48iof8XMVHwZAqJl+BHyv?=
 =?us-ascii?Q?+OCRQP3rOpBDHYCmez4UQykM3tnkDxgMJM2Z1jb2uXU9IACdvKrQ1o2RWKh4?=
 =?us-ascii?Q?ZlZ5oig7rqmPcYP6x7oZiqRpJae57hIIzCKf5Tobu0c317fM+AzAhFW1QWLr?=
 =?us-ascii?Q?6t990pC+AD9yMUHjHm/ZRjjcUgef/pL/tbdmb7vQ+yXaGyHyCKiPyIIMi/xL?=
 =?us-ascii?Q?7szQY2b7r4qVAhzoJk9Jk5Z9aMQsjOKjN2sJ/M3dwi/K/44XrP1kaRm9QYYR?=
 =?us-ascii?Q?wIJHnbYn4ttu+GKev+1g5sYukFagyN/pG8ZTqjZSAXrXIgjd7KVEIY9/Jawn?=
 =?us-ascii?Q?omky2mb707XZCQA3dlSShTwCMFy2kfwcqasM8gr3JVQ9F8WRMmImDPDocFnL?=
 =?us-ascii?Q?iEIiTYp+y9hYfF6F7xO2FxsYcbdaQ0ZazxQXQwZNoZDM6eGzR2SlfCsHIlv+?=
 =?us-ascii?Q?EFwP4fBQjMTbm4/RmK6KaT9o44oQkK71lIowhdSI5EhHjWDXexBhAYkYzLu6?=
 =?us-ascii?Q?tOnKH4+/qWR9umfYtjH+leVMp3usLnhPLnBErsDY7qu+eMrEBjE6vtnz47kS?=
 =?us-ascii?Q?KxGO9xJQw3B4SnrtXif1CRCmfDURILF7RJyp33pM3xf12bGJJQSqyIUvbzl5?=
 =?us-ascii?Q?amT6zFA3kQsGFkXmfQopppqUXnx7U+X7nm3ZmHqAk0Dmo5TR5F1An+ER3ih/?=
 =?us-ascii?Q?hg7qHY15ip4WLpvaW1a0MSC+CbvsiwOkcp+dwPaBZ6ckbV6DkBflGBL7BGOx?=
 =?us-ascii?Q?N1erRxYq18XFsQCVjub1pqfRBId4R1xekc9uo2ATgKoOC/1s2RJFLjAwGuZo?=
 =?us-ascii?Q?EfsZGu5eKMGSewKkl7Bfj7OUVK4+PXks5FnVHu5xu2FjbQ/Rn8xSqo0TaGWf?=
 =?us-ascii?Q?thk4e8JZnXySzQ7+uryreHjVn3x8zE0B+VDUGeVxEP0TgRtMYi7Y6HqhbUKz?=
 =?us-ascii?Q?7ETiYzaCzNM/kfMiqF7cEQPEkCYF66/mIK1hF3sBZA1EFrmoMgg5j497X/aR?=
 =?us-ascii?Q?GvTupwOLnsI73mK3fLzUAXnUojniTUEtBJNQ6MHeIl6KFu+Jab25d15FigCh?=
 =?us-ascii?Q?ROKEyLh6Ko6TVP+rP1cvokmMJ36gXr8JRux2/ll8JA7zp1hnLpfKZn7Xy69I?=
 =?us-ascii?Q?WicYxpYM7MRQYS//d3uwMmxKMUuD2HmQziVSAAXVIRrlGikYpEKF3+PZ2a+k?=
 =?us-ascii?Q?2E7P9vf9L8/bCs5JQk5Q5aHNiDOVVV4umid3wRzc8zut6E94/QZpWQlbFx2I?=
 =?us-ascii?Q?VDBPpsNETE55u8bNyaTa7ww=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2b6f13-a137-49a6-75de-08da017df443
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:36:10.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmvCJW+blUuZh9VXJJxh6y3E7G6VYQCpZAO85gXm8EOrr0eMCfe5pItjxW3a+jAGtmYRzDLwE2Tq2lTe1OzxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333

v10:
 - merge the squash-to patch.
 - update patch 3 as Matt suggested.
 - add sync() in get_msk_token() before read().
 - add a comment for get_msk_token().
 - update subjects and commit logs.

v9:
 - update progs/mptcp.c in patch 4 and 5

v8:
 - update as Matt suggested.

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

Geliang Tang (5):
  Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
  Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
  bpf: add bpf_skc_to_mptcp_sock_proto
  Squash to "selftests: bpf: add MPTCP test base"
  selftests: bpf: test bpf_skc_to_mptcp_sock

 include/linux/bpf.h                           |  31 +----
 include/linux/btf_ids.h                       |   3 +-
 include/uapi/linux/bpf.h                      |  14 +--
 kernel/bpf/verifier.c                         |  20 ---
 net/core/filter.c                             |  22 +++-
 net/mptcp/bpf.c                               |  62 +---------
 scripts/bpf_doc.py                            |   4 +-
 tools/include/uapi/linux/bpf.h                |  14 +--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   6 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 116 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcp.c     |  36 ++++--
 tools/testing/selftests/bpf/verifier/sock.c   |  63 ----------
 12 files changed, 172 insertions(+), 219 deletions(-)

--=20
2.34.1

