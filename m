Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B07E
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 23:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648249369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9SMSu3fcFAEyoUohdyxNqZzPFn35ulGMID3P4SgOBns=;
	b=iLFvJ+5QudsQ7P3xHmsRd/CkllgKWOWe1MIdlscxnxwpI6qsW3H73XLBDO/7/O5Qn8Cz7G
	Y6jYdinIibqA0qKSXtoVP/OC4i9bixNJVVIxDH5nO1/jQX7csLiJJna2CnT6280LFgflmo
	ZiuV47qdFzJE1kz/GbWwquR+8qbadJk=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-sykUe7r9PK2YaJdQApajvg-1; Sat, 26 Mar 2022 00:02:47 +0100
X-MC-Unique: sykUe7r9PK2YaJdQApajvg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1COnJGVNqXyMVxupYgN3FTKTK3n2AUv7AA6y+fVQEWkYAwi/Wuby+3zvZqnxzc485Vg9B7p8cvwqsRIr/R6T5yMaNdx7xttTkQM+gLiQ7GnIilzOnDzToR0mPx9uhM+F19MNOp05fXSsVOWJ+O4wgqZ1OXuHX+3ujhMDZUL9EsXYszR5h7AehNDeikwgx99Ty+OfdBGftxI595qS/IYwODO1gJFTSHTaNQPgJrRPGcJX9a0GbsAvApF6Amy2VGSVXJoVzrA9cTjmwiOmdKyltzjDmjj5tGHotx1byNaIdnPPxU3iNbL7Q/io7CZdTOvdTiW5j03vjfuqwq1gqvnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLim1CMbQGDfEkNvHjL3+Gl3AFdIraQ9Quwu6kczDI8=;
 b=YH/q6HSw63Ndx2x3Kkz4d33YAI10MRFTCQ87ALp8az1XEcUvTeQDrTPf2qWdAalMv+P4216Iw1iLRci6I8C4AKGcxk0Mq01EzmedcQSJRQjNd1M0phxFdzM92RCXdm5lggcl0xqL/P4kXan2ucyviwhK8fx/NF99qmRhg0XeiYD+Db0RPus8s4NNcIkaZsCLSD7qBkHnubLMUqA/82NY5gfZoiKig+mrvdM/0jjQREYXEmmxPjVQLsJ9LqpWjCztFF9swM1LW3+jozcSEs43oJbGCpT8FhE3o6E4dCLNJMs4kT3SyNtdgZCcg9aROfQY5JpinqSZlJLw40SyXTMDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM4PR0401MB2259.eurprd04.prod.outlook.com (2603:10a6:200:50::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Fri, 25 Mar
 2022 23:02:46 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::1ce7:eca9:4824:d96b]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::1ce7:eca9:4824:d96b%6]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 23:02:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto v13"
Date: Sat, 26 Mar 2022 07:02:31 +0800
Message-ID: <6d83590621fb53d2b129496aa92007f6aef45115.1648249317.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 933a988e-8142-4cd5-5f0c-08da0eb391d7
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2259:EE_
X-Microsoft-Antispam-PRVS:
	<AM4PR0401MB22597F74203E8366D68357ABF81A9@AM4PR0401MB2259.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T0uLS3DMIuQBj67FKESgHoMS/Gr5Wv97+YzITeH5QhQ7GGgJVFHMpMZqHKlwN694EvB+8AplWPSDo5VhLU8/6U9/dweWzeeEGRtwHLNcBqqlfkpBXv/byV/8EqyXzaFKvfK9h+3tRmEvn8QhAgEmip4q7+0CRBQOhc1gFG6YCcsHA3v/57Nav7H7wxfXK9UpcCpYbuhxchR5mSRwI8VZYKQYANQGzC7fX1Ey5u/P2VlrUWgKWCItaU73njWwmxYGeetDHJhGCGxIY7HyKBN8f3kf4uPnsGNhjHppvtClaDUCPHmFOePCjUFtSTd8JaWzFvSZA8Epy0yLfDLBFX7+g/NuAHZnlAMR1ZgZolL3ChOQN0ZimQR5gsm1oj72wRsIO+RsxPeDmAy2l5kftopli1PeIimKU6dbbOuHbTr/45SelufmlsJryF4BniDj732kP+A9hahhCU5Hh0lgUOTW/b+WYj7tCCArf9c7ZISjt55+2D1ML/caTmDbhORVQiC4HKVRO+iBwsOHvqIzaMEbA056gC4v+3FtWJ4D9ay4VugTg1Ej6yUptGvYSfEhoDdPcszNwkuw3Qae/PbQre7mGZq5d4GU0iHBrq8aMdb8pFnnvXKPuD6reNP6rkxnM80Z1k/sNJehh/HTbCIEm+ZDVrHZ5QbdnD1Fjs7QXJFeYXPTT9o1OXPzSZKrdNjI+Dhjr9PufqOMQC8crVG9ad65gA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(83380400001)(6666004)(316002)(6486002)(186003)(86362001)(107886003)(26005)(36756003)(44832011)(66556008)(2616005)(2906002)(66946007)(6512007)(66476007)(5660300002)(6916009)(38100700002)(6506007)(508600001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gbKeIK3jSfIdGbB4UVGh6d5OhkmRo9yTnNmE5hOS52bIq8F5EZVmG99C3ax/?=
 =?us-ascii?Q?tIUcyH+ylJ/DHgfZXrBIdI910hhOd+EiLS9vEZKEd525ApYVtS/GOBwKzbfw?=
 =?us-ascii?Q?eeVwmAAsf6+KH2Yv2peDGdwLwHLXCNGCNWw43m2D/CYsROeGX6rW+ZzJBHzp?=
 =?us-ascii?Q?MnGogWCkg4HDMsvXROh6jaq73R5WUHjoWiHB+nqMp8Pi+efNpWD/9OYMeys1?=
 =?us-ascii?Q?aBOisiHvInCh6nnWLUC4MYUhRWZrkm+gGJqHBnhpm4qp56+FYpbjxhu/n7N0?=
 =?us-ascii?Q?FfaCqdhQFtzOxZQp+IFg6nYaLtNnQuJBAwtp7ExvJwfdTo7O9kdyGCRjtfFI?=
 =?us-ascii?Q?VgCO7GfKVD+EJ3SnDLHOZX4Tw5EVl2mHZjbbWog9eUJNZOWcVqcpwVjYzN7W?=
 =?us-ascii?Q?R2WyMSflQMdUxI734A3XUmqhxr/M8mQ3DOBpOQ1yk1YmCfSNsOS3FfR+gq33?=
 =?us-ascii?Q?lmLOIiuZGsJKkPf6tukClasS5Zo+cJvk/fwMVU4OjkCLC+/gRhcMUrSxy447?=
 =?us-ascii?Q?N9qEQFgqoExxlluHg/oBtivMgOp1emc4R9ISHqtT04GkK3Ng4UCn1Xo8p5pf?=
 =?us-ascii?Q?8DEcnWMrU0NvpIoHy5kYJ/8YRrGqEDjSwQypMBvla9WXUSZhG6BT+yhcNSao?=
 =?us-ascii?Q?0LSZQj037/qMvxF5WAMosMYUG5ha2REiuk4cmT+h5u40/jzkXr5uWhHsYij1?=
 =?us-ascii?Q?T9Y8m8Xa9N6kpJFUf6g/hFtI/E68g5jVCrJ/KUND1ogQczq2ngh80cQYBxvT?=
 =?us-ascii?Q?ZGGPjxZInOSlOrE9rJYB0/qPo1/LIZ+yI9xuAk19ZbrXr3g5ACLc2l+bjr0C?=
 =?us-ascii?Q?zdhsYc9+lXwKQJ4YUzCX528jl7gUtSe2qAQF57SSfkGoEyRvmbQmVoLvOvel?=
 =?us-ascii?Q?HBMkPsTjql7ZABOgo8TVtvQenJntbvIVRaO/1PW7UA4nJLIEhUs+PhMnW+rr?=
 =?us-ascii?Q?bsBdWUgvKthfIhBspYTmYTndvaJ4HSbwY2A239aAjHpy+dE7DTOq8dgPoKS8?=
 =?us-ascii?Q?VqGZL8OZ5BW3APH/woaYQbDaROZhRAwaUs/91Dt8PajbEIo0KjGSLo4nvv7Z?=
 =?us-ascii?Q?2qhXUg9O9olQFcvrkyrZAk4KM3qxOzXfr9ebCX2cZFD00A5We1+jdInBHu6c?=
 =?us-ascii?Q?mzou/fHYNnC81hYC2VE7QLZSNv5Lky/CJGULSYwTpGwZ1NWWFb05RGjT25Rq?=
 =?us-ascii?Q?VAFLI+8MWYqFsDzdMiBqjLHdR2KTYVu8qkVl5Jdp4TFPJpPfTzqvA7bGuXE6?=
 =?us-ascii?Q?SFbofKj5b/9NJpwB5/E6vU3Nesy4QOyY56yDU+13+1j5ftoBH2FsVqSnUtx1?=
 =?us-ascii?Q?5gjZFhlBr4cBI/yNTCew13+1Nrr2EG8FZgVCyUxcex0Gus0dGbPnOHY6E0wL?=
 =?us-ascii?Q?SbKbjfg8s6adZNfmQ2DG69fODz4lhLU26smNy9ziZtTecNKTMiGqWZVQxaMZ?=
 =?us-ascii?Q?ElBlvfbePmhgHuyvDgJc55K2+v0hOgz32fbOGxhlRqQ0AIBn/GVhRi6GzOY8?=
 =?us-ascii?Q?CCLDw7JOIjSS7w4YTJyv2mBqSOUILX0W2Z0IP7ww17PqpbjRrnmVxfbW8cwe?=
 =?us-ascii?Q?IackU76XZ0iJZq+TlP0M7NAleWxFfbph16BIEjrDZFuWOH43OI02mtmXfjhX?=
 =?us-ascii?Q?5L3S4h4Hm21f6CkcUOTcPcKwpD575zM3Z6sSzdHMrjfSeiftmnC8yE4mjUlM?=
 =?us-ascii?Q?we4VQl/wrl8s9TPgjgr9HS6WwZFUaeLe3DKe+iowdyy9+ZOP98K3SKVm2xdB?=
 =?us-ascii?Q?uDEVh6wKdJ3vb2Wl6AhHgUsmdysoMJY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933a988e-8142-4cd5-5f0c-08da0eb391d7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 23:02:45.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lQ7kLy1APMuyNFeeBL6rS95O6nlS+AGkvRSS49pU+75NJrSEcJQhpW/kpGiOOTbhrQKxvog95jVYTXcqL/nTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2259

Put 'struct mptcp_sock' at the end of the array in scripts/bpf_doc.py.
And check CONFIG_BPF_JIT in Makefile.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - check CONFIG_BPF_JIT.
---
 net/mptcp/Makefile | 2 ++
 scripts/bpf_doc.py | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 99dddf08ca73..168c55d1c917 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -11,4 +11,6 @@ mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test.o
=20
+ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf.o
+endif
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 0e5a9e69ae59..d5452f7eb996 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -623,7 +623,6 @@ class PrinterHelpers(Printer):
             'struct udp6_sock',
             'struct unix_sock',
             'struct task_struct',
-            'struct mptcp_sock',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -634,6 +633,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct mptcp_sock',
     ]
     known_types =3D {
             '...',
--=20
2.34.1

