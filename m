Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF2A31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vHJyDC04U7hjaPjsHloTt3D5uvrlSTXJO0Z58GNl6z0=;
	b=a4GDYYjdei45v1PEJmz9g8IRFe7fq1nyfKvN/gTrCIKXhrm1vhQvurjEt6uPsH3yIehY/w
	4Yod/wW4wJoalv4PC0MopWBgNZ2hnCzkJeA11xSG7o6QhNuR95W9ZpTXZxIHG+Sio6D74c
	ZwnGDa8XeprcmS6PgkLm3pAKRBwxCqk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-_Mok2mArNJylZuVtv0jkMg-1; Tue, 22 Mar 2022 10:52:54 +0100
X-MC-Unique: _Mok2mArNJylZuVtv0jkMg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZGO7/jwoiVKg4UkUHvc0ogHroKlVzSQdV2m8iuYxDDLKXnGqGX4vXk8XDvf9DUta2zWyS8WaMP8WVFyoV26dwwQdeHx5NbkTfdlN36MHCpa+DSDE5WfZg/NWv1aIKhUIX8tojHpjbnKvdg6HDq/UKpV2BhA732XhXxmHsH/qyMXG0Msn7j0vqCjkd/txlhMuHgUzKB5X8rI4XErVnC0NZibj/lW750BMWiYJv/5XWs8UjYDKnpE0/7OXfLaModE2oU163co88ACr9nhJIyiE/fA3yWDWlYySD7hk3VoTL1sqlhRE0g+Fl58OFjhAzMh0KYCDeeRIq2CA6SmxcIMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfflrKtK2pjZr9n2/nKJgKnBU95598Rj2eFYIvxiYyY=;
 b=V7h/9Oo3qpg3JwCj2+8pwmm1jbMeOQ/sigGRnOgraEjsFcUAhe3n9NYj2LpgN4yb2GTkT5tGbmF3mqdZUQIRm3eoyduXprzMscJYo1m4Ibx4IFKYP0DoLKSZ7qqDcPTKXLlnx7b5OwiCiH+zCFQp9jpw/is+3eNGhW/Ae4hDs6kxJlEz+clGJsoxOoH6LQyUUOK/h5yjgfidKR+SKuLRZSbs31asnkuzuhebxq4DQJnwc1vUIYI9uf+/Txznl1p/JSO3z3q2ebxhm9mC3boPLcKG+k27FDZmNzfgPpDdZdul7WAYVV+tJkl5/1W3Bj9Oz2lSLhYj3r9jaY6p7Ebojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7952.eurprd04.prod.outlook.com (2603:10a6:102:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Tue, 22 Mar
 2022 09:52:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:52:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/8] BPF packet scheduler
Date: Tue, 22 Mar 2022 17:52:35 +0800
Message-ID: <cover.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21ae5626-c3be-4251-fdae-08da0be9bb7c
X-MS-TrafficTypeDiagnostic: PA4PR04MB7952:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB7952426AF5C0B26A34D4A9C2F8179@PA4PR04MB7952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YIWipFNh0+SFvv3U3EPkxuKYB6wNJr+6v2W0vytkyDgocqhsLOH+KadW96EmB/PvBOtO4KoQH6UqvzeLM12NN7andudKw2I+2mOM19udPCKKSpVUoL4O6Coxh/7hP3WX9v1Gden9XfCGQqgiKSqVTn5pEEx/Tu6kMYwKV2qHw0gUrZxdj8gZAvVPyYLJlexvLQ5WOr8rkjEyV4MCkcVTd7OplkNgNpdCYX2xbObEatv5/3APVjnEnWDJ6jGJwmn87BEZDm7ChmMKFyovP2+/vFjADeo1/YBgYSFcj4/KsA6t67vk1oijNOE5vPK7IOdXOTSb9+Ll9uHzDmk66D3v8FwdUaCnM0TKRuvTFbcuHu4qe3uyLN1S7jiTPuJCnzP4KsUpvjGz0BtxQGqHcnRmhkz48UI1qpsSmpqxyrveBx2KDF6Ot+0yq5b/LJoA0A4jzS9BDARc8pvgzxC2fXSp4HPjyH9kD8gFVczPTUUHinhcjYBVsDOfzPw6IQwJSEKWUJngI1oWhaxNiA8LAuFxZldmMryNo1U3jyXUEK5XqHwMNvRvjKa+IVOFpH13T7orEhclTSe/kW2NrchGd981swspoxcdbm/wk5aUYy1Qbpcc1zKng4Q+kK0eETm8UArE3eeZi4cAJ3My6EERCg17HNXsSb4tUnYc1eyLYAPDhrpAJwfilKtiSZJApD3dEiTOPtWhhiFHbXC3FqUJ8U6r2JFGHoEahtAVXnTEd0dYiLqciLzxW7NdUUirF3vz0Ovi79X6rH1R93tHL9buDcVxKRfR9PKJytTyTWN6ZYxzVNPvwYucxRE2qOqW0jpmQu/A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6666004)(2906002)(186003)(2616005)(8676002)(66556008)(4326008)(66476007)(6512007)(6506007)(66946007)(107886003)(26005)(966005)(508600001)(44832011)(83380400001)(36756003)(8936002)(316002)(38100700002)(6916009)(6486002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iGPsPeT4ysC+Ok3YX6vbMncyW+TpYZqsqJbBE/Lc5SDOK0+6CS0neETyPQQn?=
 =?us-ascii?Q?DQOCvdoAmOkIZDRDVb5ucPO3XvqrOWQmv2T9TUOYEi/9dNRV8bJa8ZqtlasU?=
 =?us-ascii?Q?HairFBaGdJB5i88qndiFbjwDixyP1hU7ts8uZK+p5FoxPZytlD8g4K3Ksckz?=
 =?us-ascii?Q?kvR9+9/Gnejo4jmP6lBb9Zt1SABsFBMGlRZDDlqnMQnvvQquA9DvJa4UqVA3?=
 =?us-ascii?Q?nVqXM4I/2HeZoBFI/N7mmY9n/zTuT51I2FO2n/kpYvQEqgh4EiCJi/W//rTs?=
 =?us-ascii?Q?ktVgtO8+Qqighm6J5kl7da3Lybql3fzom/t8y3mzSAu97T4c+dHtm6LrWNn9?=
 =?us-ascii?Q?R5AgZ7PElyu2oRKeK70g00LFF7Zrm9cgqqgkSdhAJfD80JmXdpu9SqRJcjzd?=
 =?us-ascii?Q?75h0l8TeN42gNo4IvtoQfeM0RGvN+cIWOF+dWsZRewJ1WsT6L1DGv7L+ICmX?=
 =?us-ascii?Q?dri/MNGIdYHYV8FB8Y846RI5mpjhZ2LmV7LjqDKHRiBuXP/wM8a3ilWVpxMe?=
 =?us-ascii?Q?W35qNDQYUSD99i5gfb3veG7abtivYEQtAaFJDOB8xzfRG7TUSbiSpE1Y5BXe?=
 =?us-ascii?Q?5O8f/gQ/HfYNZnId9j6Ui5gZTVYbJcXtOj/yeklHvFH8NkETFVsKTT4dQYHb?=
 =?us-ascii?Q?709WBpxs/fWAbJouFI/QVVV5uQhkF9y+2vjDMfDbbAk9OfLcz+7MjX5sCmyy?=
 =?us-ascii?Q?CMUEjz92cUWJxO2Zq1sHA8MXrky/e+HnwbQQbVVEVEy079p9Ip+T1gYbEzGx?=
 =?us-ascii?Q?/hpinLHASkan1Ceqg4vAlTSWJA+1IlzjR0FhTo2gWq9Oaus2iU4aWl20Qy5H?=
 =?us-ascii?Q?z6EkV/PBTGbU/ZbTj768SZQ49JjVIr6G9uhLjPgRGUjl86H+PfGg3y1iE2LI?=
 =?us-ascii?Q?/TKd+R/Goz+v5cNAqg5ltnZkpAQ2L7TGKs1rp2I5bpprMi99pCZebma5OVHz?=
 =?us-ascii?Q?0JU3OtH0CNVZtXZAwIhlJASv/UagcPhSM4piVQ7Ef8/H0POit/pLUussjz9I?=
 =?us-ascii?Q?7Bd9F95CmRfFEjtbRPG0XPK5rnFCYr5pnAzY4ZbmI1zMvD1JSpKoipniSUJC?=
 =?us-ascii?Q?Bn5kHyq3Z2Dl88IU2rn1noB1Ui4iZN3Cm0u0iYObOxA2cRp1BT7vWZZcbv4Y?=
 =?us-ascii?Q?YTHtPqV5liRQukDL+uZ20V0OOOWB2ZeHBSRjK1zksWM6cJiOaNFG0v2iCPgs?=
 =?us-ascii?Q?7otc0bKNMQOyOh3Pj/rux6helhvyy1ZfySkajyXTYUHfawdNDB6g8HGMvx2/?=
 =?us-ascii?Q?hyg3w1NrnOXv52fV10HYxoCEZ5pB5Yf2hlcjMpQJbISmH1Q/rddUmDATh/G/?=
 =?us-ascii?Q?MpoQfKSRscRVEYStGM1Lx+sjZzDqTZQAjqVDgBbvySVqSRWRxaXzAM2ZxbCh?=
 =?us-ascii?Q?ApRCdUjHKl/+Eva00yHcKn5NYUw2EjuW1yCyTuqmtgDQZwzXpeTN6JmEWNCy?=
 =?us-ascii?Q?OYXXTT4EAyiIaBuvcaXTSLzwvJ1V8ii8azqppVZk9K2GcZ7Tjvoh4Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ae5626-c3be-4251-fdae-08da0be9bb7c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:52:53.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5N5v99zin/6c9fSZHbR4EPwwhNJBdDZtqInNcQNYgWHBnGkwb6u3a7e+xtn0oKkHk8uJvEbbVV7tKJdkiU8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7952

v4:
 - set msk->sched to &mptcp_sched_default when the sched argument is NULL
in mptcp_init_sched().

Depends on the bpf patches queued in the patchwork:
 - add skc_to_mptcp_sock, v10
 - check more values from mptcp_sock, v2

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

Addressed to the commends in the RFC version:
https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (8):
  mptcp: add struct mptcp_sched_ops
  mptcp: register default scheduler
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add mptcp_get_subflow wrapper
  mptcp: add bpf_mptcp_sched_ops
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 ++
 include/net/mptcp.h                           |  13 +++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 102 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 +++
 net/mptcp/protocol.c                          |  13 ++-
 net/mptcp/protocol.h                          |  11 ++
 net/mptcp/sched.c                             |  94 ++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +++
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  42 +++++++-
 tools/testing/selftests/bpf/progs/bpf_first.c |  30 ++++++
 12 files changed, 336 insertions(+), 9 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

--=20
2.34.1

