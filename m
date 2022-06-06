Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211A23BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ewbPSHZ6bkpOaKuCv4x//9wJ3FabYaypX9n0TCL16NA=;
	b=DgiHsGKRSYjvWUmtn6gB65xS0MyRVfNzVu4cCKPYG4TSY9Z16pJAcPNNMQzupt9BGuLdS2
	0ld6/m6JqwraknE3QTA4a+ReQE97VfLhlkaFv9UVW9YhtlcAgWTVM7AQwSRzCcdFYnigtM
	v6yziq4PGZ4CtwwNq9ZJmWB6dqw6IPk=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-44-yzXJu1W6OI6BcPPziAF-mQ-1; Mon, 06 Jun 2022 11:47:22 +0200
X-MC-Unique: yzXJu1W6OI6BcPPziAF-mQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6okJqNGQV18cEFTzFaM/kXSCtW8w3apmc1mA7GEMKAWHYerd3EICpGujgyVAuIlKNbGg19wsa72Rq1Sb1Sqpkg9hbv9FZxw50Av1lfvKcSBzEq1dk6pC6Oh6HHZ05QekCXLWEHUzquRJzB6pqtEUTEr9gaGU20ka0v45bw9rgwweqBUeDTkJ8mLJagIDDsACecNdBUCwaKx+q2EBUvUOoIEXBineOmTw3qLN+nPJjz6RDUMiQFNCrjFDy22gyt6dxVoHo61HTohuTZHmaOraLthdBT+uq7bZo+4qVcnU2fVGeeQMCKV3MRLj/+miO0dD4JUhH0wd1s4A/XUbc06tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkzzgRO/yD4NDNweIvt5MmltC2MOP0hUd9Bd78Jisl4=;
 b=dZhKNjkXL6vcm0RPSLaFABzL+HJ82/T6KKya6HnZxtiugE52BB/H7lD+2U0h5fFhWliLXRGzL8tdtXErMdYIhJoRa6UBGBuuLwt+r1qqfDe1AshR6rXVHqwisn7lM/ckTae3i93H48uW3nONZS773ecYDbJrrrk2MPceiscWCwLtCBrDDxzjfyR9QGdina4BYJ/xWNBeJ9CfAacKHetYenFq3KB13kisi9odS6SyNW6mgnuPJGuePVUJzZ1hO6OmI2Lx9GGqOk/rlwpULOQ/L+p6D5XKG0iOt97ei0tSBrXspahJRlOc9SkDqXQLP0xeFY3HPnT+2qZVeayhMzdI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4802.eurprd04.prod.outlook.com (2603:10a6:208:c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:47:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:47:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/5] BPF redundant scheduler
Date: Mon,  6 Jun 2022 17:47:10 +0800
Message-ID: <cover.1654508532.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb119009-3f0a-467a-dd46-08da47a18cf0
X-MS-TrafficTypeDiagnostic: AM0PR04MB4802:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4802FD7BCF740534FEFB174DF8A29@AM0PR04MB4802.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cAwLjHGWcCtMb35C3Oi7r1m22j6ILekVPAeUxvaIQjs2Z9Sw/n0rzmgIZ4SEMfvoYsApE+4e3BTzjQewuDi6roux5yeePHG2tYSQrt1Kw4RzW23suTSqy7rWYmGiBrX0idCQCu8tU3IoDGgC1UGUHorj7ZXRF6wZgM7+LLguSXCzb6kJssQSzjfI9rQFe1BWhd0x0Ux6SRtkvl7Llu81wTR2sR0BIECxyN+rtGwFD8xrqTg0fcAnx1Nb+/3UxZXUxjoRRRgtKwlGj3sLQRABwGkF3ZmPoaLoqkCHbBywLTKzMLi9lMtt4XGxvU9QU+6Zb0HOT0o3b0iMgKVlaGx2WpTo3qsNaZWdNy8Ea3ANj5HM55ykrLNK/JhssFSTbVLmyd0eb7F0WxdEFJSx7PBCInTMsLgI4+98wrkU4NZOoEVrKu1WePwFp9ATQiWMLHjGbKVjqINIy1Xyxl7ZFKIiug64/ZbIKgcTgSR78Jj/dxzlcKfO0nkXvSE7kl1tZg8hhrlYqxYLZig9Hr94DNWxZiO1rQ/OHjokwUrAAw9RkdCLZrl3+MgMbEt6faf8/PMkfQE5+Hw3poAxkbEge8Y/bp5C27l/HcsSak1w+psR6Yt0oiJXGdfc8QaiEhkJzZ4Dl3Y0OmKjvIuR2Bt3EVcJt4ulr1mwyCIw2sCwD5FHI7VTR7h9eAcTV2gnwmop87F0aYu8jZRn1TbJ5uCV3XK/rUMw7fVJnxyFNt+fE9CYbrKbo5T9QYsUL4oRiuAo/aNH4QWZy8WmPBfIeskx1md/1E+a/xzNe+gwlN7iJKjF6l4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(6916009)(38100700002)(66556008)(66476007)(107886003)(316002)(5660300002)(26005)(6512007)(2906002)(4326008)(44832011)(8676002)(6506007)(83380400001)(2616005)(6666004)(508600001)(6486002)(186003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nc1Yt6OjM4dVyHdKkfATr7ZmuiGdt8GLTjGeAKigCmYg66zDQcXac4jjLl9b?=
 =?us-ascii?Q?oc8KQ16RMQDUDGwePp8/tuKRZX+7/BpTMZWlTEwYQDQnQpV35m8oMffyVHnU?=
 =?us-ascii?Q?zGjp6qcEJ27yQQEks7OYI8cBu5QQSJlfvU9DmKAhIIi/aYYrjyLYjhMsBmXc?=
 =?us-ascii?Q?razEejpJmDWb8n31OVaDL+qeGR2nZ7ER18FDn/1d6k+SpS3bnaVVGs4OPyRI?=
 =?us-ascii?Q?w8dJFWMdJGFyROZ138QADdqMrEeiHG90+YnMLIpZ+DZ9TQREqe/xHicjR0AB?=
 =?us-ascii?Q?a2C+AMs8SY6XVduJ1gbU7uFjDqqynuOrlYH4CgFlHMJzm9opvbPxVjvhI8vg?=
 =?us-ascii?Q?yzFDaN/vwOmKaNSeNO3Ft05J6Gt6ZGO1XNQlUhpLFplohRmYLAvmhxdEvucL?=
 =?us-ascii?Q?m1joYmb8dVzFnQZvOuc1h+Lcrh7S0I9N3iCA0HUUbyd7yYPv9l65AbWxJj1r?=
 =?us-ascii?Q?iG0NGBaT1FkG35/Ziu53aA5wQ5S0ZuYrK7UwHc+S4v4tIrZiVYmyNSc4adwK?=
 =?us-ascii?Q?HtkyiD9bMjPpV/VNG8MI31uBPIVVqXpRd+zGP/7sjas+DpnhvltV7yymJxfd?=
 =?us-ascii?Q?xDV9Xhhn1odrw/idM+sDzv/ktUYhy7pl7Nmk9BVX59Cac12vwvLYQorw8QRU?=
 =?us-ascii?Q?ts3rfwbzviK8qNifsstTJw2nzCzxPcg3L1Vra1ptTFcWC8gPiI1dIPdov6Pq?=
 =?us-ascii?Q?i+zyBZ7zO4VNASvRr1iW9ReAgtjl9uQdio7vHzS6BCVQ8nWAwBaD9a3J1prh?=
 =?us-ascii?Q?cCwY0s5kO6lxLjYJxJhMDLcRPtsRqysiiHSWxnRRhTxlqiTdvA51eY3RBgcl?=
 =?us-ascii?Q?k0V7nbbNM5iZii38+CeBdshw6qSXJH5c7Ulhrh5qlotjs/t8PrDxc6wzJVvr?=
 =?us-ascii?Q?mfZlzrJ4mrZ3X7l7PnMmRvs2HUu2Vrc2Ok0mrbVOj2Pgwb/es9rr15u5xMhG?=
 =?us-ascii?Q?UO3O/dv8HJPSTuj6xCuFFzFODeNtrishtNXHsv9d6Mz84+ifXduAci7trvoU?=
 =?us-ascii?Q?JK4gBG69ir3FfPYqIlDX1lSz7klbEUyrYUNaHYuFt/1oJaUDce6m8DS3zeIo?=
 =?us-ascii?Q?Z6Yes+K1vp9Tc+2Cofpdzr0jqSqWOUXzqcDme6lpau/JSdiAa7/92Y5AQCp4?=
 =?us-ascii?Q?ni9GB/rJGxCYvS1yfaaHDWtg2DNY0DatFRMrrepijVyCXR+oWehBwg5fMYO5?=
 =?us-ascii?Q?VeBhNn+apFBlT3SQxWcGAQEY1lDg+8ooPNLNT1DWSJgYKENom33dImLrCoOt?=
 =?us-ascii?Q?a1664euOe/5VLTbDh7Hwz13b7jpmXztwavxeORD7eh+VhAtqyxdZarakyEcF?=
 =?us-ascii?Q?DmBstP8I7DCkY45WHqQy1c86ihIKHOwORFu3UejsqVfv60xWK0eqRBabytt7?=
 =?us-ascii?Q?RMgmOeJ+33qY3Q2WtiMTGfKw+xgK2QEL8w2I1jTifmZvCwzGfJKUenkIr8Mq?=
 =?us-ascii?Q?mISlTitIdkSxZQSu0h3CTROSXeU0yXozBywi6bp6PiBrjOFbhdn6+dfz86nX?=
 =?us-ascii?Q?5isRlRYJdJaLvQ/rPJMQ2Ue1Tow5tOZ6+rLsIm4NwlIgsPW9nPq55o0B+OIZ?=
 =?us-ascii?Q?ASpKVClgnvyqBZw1qI9EOb6wZi8/7gPuyyxfZ/icr59PC/X0HtEmBc01bPCS?=
 =?us-ascii?Q?/835Io0R3EfKBNqEriYreSNWozI/n5rju3YTLAOLPysKqH/MC2H1oSj04vr/?=
 =?us-ascii?Q?TfjEI1ETiRG0L9yQoegSyMQKZOEVShTjR7TArqQd+HGF4+oYEyFI0qnb71Y/?=
 =?us-ascii?Q?pTMPaZ64c7R5zQv4c9HBLQqMsX+fAko=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb119009-3f0a-467a-dd46-08da47a18cf0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:47:20.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dznUrbfeXvKUDkpMi+E3RYJppOskAN3bNre0H9EkGMHZGdT4lCr95rcNNWBDo/YKU7EG2SBinOjlwPLW85riQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802

v4:
 - small cleanups in patch 1, 2.
 - add TODO in patch 3.
 - rebase patch 5 on 'cleanups for bpf sched selftests'.

v3:
 - use new API.
 - fix the link failure tests issue mentioned in ("https://patchwork.kernel=
.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

Geliang Tang (5):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: add __mptcp_sched_get_retrans wrapper
  mptcp: add mptcp_sched_get_send wrapper
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 108 ++++++++++--------
 net/mptcp/protocol.h                          |   3 +-
 net/mptcp/sched.c                             |  70 ++++++++----
 net/mptcp/subflow.c                           |   1 -
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++++
 6 files changed, 180 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

--=20
2.34.1

