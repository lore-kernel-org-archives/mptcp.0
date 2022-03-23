Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D341391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648026587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ocC7a2S5GjYeZZhxr7NH9UJEySwnCVxXQj0PHXMgEg=;
	b=VZ7MUBhTqBZ9M3ubO6CrF1qKhFWTfpVwgb4YVoJeYRh0uX8KxAWVdu2gTNRcA2AA1YhseY
	HBc3VQRZknNw2GdQnxxCEYVo4yIQ1TPG8Jz6pSJY/ghM4BY0eiFPb1ny321yw9ePXp8CTq
	TYQxcIDppi1CKKkvNwMx4CMztl+1acE=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-ClM7tWPOPC2ghQkK_UFGUg-1; Wed, 23 Mar 2022 10:09:46 +0100
X-MC-Unique: ClM7tWPOPC2ghQkK_UFGUg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXJV1Sm3go7fOLudXKkyAgIhF4XS2dka3vRHlJ4gmUvRjQtYwWmihY2NtoQMDpLtDQMMEukLvkveabnww1LHNCgmU4TTEpCxoszMO9TIZVDnb9fmqFX6qB8Typdtd9SYObJIAirCHQXvGn/ASC+nh0ipQsvnJhNnGQjfsGgbpukLT/Ab2u72HJQNHn9Oni5ewl8DEmdyhH8XYbdo9qv1CARoe7P72vPNvrIJMH9bze2nTcDfxekt8DHuzHKPWhlOXzNCbpV0815fJqTJJcUBB425QxQXJZwG8NqDAGQnCPVBX80H7uIsqLHFo9WOoXMcYdLbWZPbXdPpUOaGEL/oWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vtLp1HtJyFNADn8T+RzLASgu7kdcBQbJ5zK70gBK18=;
 b=JnCb0V92Ht9AnsGahRrkt0631i7o57ac8o88qiafw4XYshoBLHZqz9UZY+Vq8e2HgO//ox8e0BwP69RyB6X2ngpMp0PDrwe6FNtcfU0Lv9Tv4hCj8RyksLggl/LonQGPkE82fZJueBUMXUVHcG9DIuBla6xDO+5Y7/vULlWHLq0DR16HA9BV0aDk+MbXWnadKBJW91VFzBQ1I3SFkKzQNDmpMFS5NVWYrDYZu/52lDbyFvKgY7hP3misSSvZ1Ug2ImFy1fbiIjrreGTQ+XwvhaNPeUPP2av4VaRxkkWl5bl8ourW83bkavedTdvd5IQEui+dH1n1rF8DBe5Ea8WnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 09:09:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:09:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 1/7] Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
Date: Wed, 23 Mar 2022 17:09:30 +0800
Message-ID: <c0ef10acb7e777096fddcc734199da8a80492ecb.1648025308.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648025307.git.geliang.tang@suse.com>
References: <cover.1648025307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb3bcde8-2d92-4945-0cd0-08da0cacdf68
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB7740A599526A0269FC954640F8189@DBBPR04MB7740.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aj1a6hje9dwxQQkEen8mDPdu7o0FW8ysLK7AsGweVPfHe4+Rq4VyFQF2JMuieSNTfTq5rlwJy+E2VI5DM3sPNsSiTfLlbOWMPbbyi9+ChoBs+aW1Ep+Qbs9o9LXT6plMeWZki2FMfMMSPHrTcQEbB2iyAzMXVN5jklje3T8+kSJ9ZuynivFd+hlC5i2/xOZqDE4vYMEEHuCoEGL5ol9wY66yvvJNL5BBYYIkahRVKPUNy+GmIMg23qoEZ6Lt6KiApvSgpM9AF8oDarUk6ABkPDwrtwqXZRd93hH6F/pIHWEmJmAkKDDagIgWzPdh6Sd7x/High2dOdTXnONvKx8QdZ2hVi5Jy0/JIfaw/QA2wkR/1GSJcf6KhzZfTUqS6o5wEToS3rRSK9aZkpFqdcFEzgmXxWgI0Ivs7WfnH4ckZTVLC/RR7AGHPW9msn1FBx2ihodglvEVgz+jTgagkhoSG1ytYKmsWAA8g3UPMt3lConG/914zGjV5MICpfxUromXwwsN5b9lgOFbie4eVqS8wdM7fr7WWCAonlmOG4xXzLgwLJ6lbO019QzLDbdKNXBb/k6xG6+0gRUxZ2uqxxkC0F7yCoG445xZtcoZ1YYU2zJ6utUhKFAKoRamrfUDrHBIG9E4IoToei2tgPQODsTNeOlUeDYqEvq1b4C4E8aHVs+bU9PLjjQfZRQy8xHxAUG7L/607u6RDhwTKM9Od+nhwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(8676002)(66476007)(4326008)(66946007)(26005)(186003)(107886003)(44832011)(2616005)(8936002)(6512007)(5660300002)(66556008)(38100700002)(86362001)(83380400001)(6486002)(36756003)(508600001)(6666004)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPru5MtblxGyf24zTQs5ALyMgDRV1a6pajgyzBEmAPWgHsq1kmN7ZQU4G/e0?=
 =?us-ascii?Q?RT5sKTGKho3OAjvYG47I4YLcbgGb+a+EU00RiftUMJsgH0yITY/VOgaMjo62?=
 =?us-ascii?Q?5guEb8dYnyFA3j+ND3o79ubfX4mAAG8/R1ISgjMoVC3sNi/3HxsqWvT/qPr9?=
 =?us-ascii?Q?mC8vsXDUPaxw9xnQyuYGoJUWVzBry1/yAYGl89hTGZQIAgaAwYWmoloWw5n2?=
 =?us-ascii?Q?8Z0Flb9D4DYmyKGtfSl4VPbG2Lal3A2nTcNeFoWC0QoU4gkiATkJb6dwz46J?=
 =?us-ascii?Q?+kE+AGH37Dh+mRSDBkkkdLEctTvX7ViI1HP8BZciz0eaESNT3zf1zkg76LC1?=
 =?us-ascii?Q?llTaeGrZW9uBZcv+IZ0WgqQoeOkgH7eS8ZS1ClT9+8Lpi6FNlnAdqD8F1GoV?=
 =?us-ascii?Q?U1RjvET1k6jt8N0zfGbGD6n1CRO1IqJQIadIlFv8y2+CEorzXuudoAcNYkP4?=
 =?us-ascii?Q?gsApqv5soCfJmmc5I33jA1fFjc3nYwDo38OAEtFxjXeNXtggaKpWJuXggz1E?=
 =?us-ascii?Q?P1Ibda2fjaE9BPbMiwyujO4t/kl4krIIB00GRfAt8z+PxNO4t8wdwRNbRItx?=
 =?us-ascii?Q?p04WsES6ANoF9Ms/AqYaGnQJpI3pGbCmL/oegQOHOEXANM6b7fF9aYLYf3vK?=
 =?us-ascii?Q?KIc8HZzaZmwK0rZvoLJyN4+bW7YtMntACTLUk/i+Y9g5wIWLeHZLtwV5ouWD?=
 =?us-ascii?Q?BMO5O0wG394gFf8+pySzELtQ7cgFkns9iDE4DK7e32CUQvcjeFH7ge9m3rlb?=
 =?us-ascii?Q?VhqIG3YukU/9Sf9m/3jlTYBa3AKRFmNJI9fTGSbMj8DwHHYJhysYFEZQNk9z?=
 =?us-ascii?Q?L3tqUNDxkUefgRuLJcN22Gp3Ad5Z4VTzIIYV5qhuwYA89QXWImsj+8SHEzvf?=
 =?us-ascii?Q?W4qSv55MDuzKahUNWlRWyi6OWVn2/oSc1Pa5rlW4qNNThHXAh6Ikrwmt3ljm?=
 =?us-ascii?Q?We7UsQgsqaKgt7ZeEF+aUlQcF0uCJZVL7GJaFOF9E5kP4k6fp2CTd1x4/uEp?=
 =?us-ascii?Q?6PYoyE0zh3JrtNOWMZr4qFJ16YYw+wcAZJzTTvzGq+cVlmanh+qwK6N6m442?=
 =?us-ascii?Q?QjbKN8m+beYWAX9qH96Rm89xOsmlpLAiVuQmCgKQpRCjMbIeUy7aSiy3XMPC?=
 =?us-ascii?Q?jBwt83sGTfZI4lJ2sYKLSuY3SivjNqr4tgyquolhpDZskxiyfkN2zKxE1ZzT?=
 =?us-ascii?Q?cfecdRKKQiXEgq6Gj9Aa3E5jhcPfqiclT6rITjBsl7PCqTYE52h3pkKOtjRD?=
 =?us-ascii?Q?2cWqg/ss/cQntt0L5yS6gW0ZmTDSYotQN2hQzlnjemZ6ilI3pqAAqASoeKPf?=
 =?us-ascii?Q?SMbp/ZC1PHxIyVlU/6Zv3+rCNRcpPrQFpzwilhU1UVtmuUwRoSpN81UjM328?=
 =?us-ascii?Q?oFkx/7P8N4NImRBJBmNS8aEhAZbOhoTV26oN0Nc6t43nnjU+jxbDleiWkgU3?=
 =?us-ascii?Q?AHwx+ZhYKpB/IMRVPIfS1aOMjD50gfFm3B+vB/5Tmr7HuoEi1abKkw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3bcde8-2d92-4945-0cd0-08da0cacdf68
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:09:45.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6p3QYTjMNZX++gLZzNDeuvNBLh9QcSN0fUdYwji08/32Mp01vKZerq8JGDIG0I18GkFPrhkpLLlGajbZ220Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7740

This reverts commit f48f0143286db0d8dbded9542d9a2535533dd3b9.
---
 tools/testing/selftests/bpf/verifier/sock.c | 63 ---------------------
 1 file changed, 63 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/se=
lftests/bpf/verifier/sock.c
index 6fd622cc38d0..86b24cad27a7 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -731,66 +731,3 @@
 	.result_unpriv =3D REJECT,
 	.errstr_unpriv =3D "unknown func",
 },
-{
-	"bpf_mptcp_sock(skops->sk): no !skops->sk check",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "type=3Dsock_or_null expected=3Dsock_common",
-},
-{
-	"bpf_mptcp_sock(skops->sk): no NULL check on ret",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, =
token)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "invalid mem access 'mptcp_sock_or_null'",
-},
-{
-	"bpf_mptcp_sock(skops->sk): msk->token",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, =
token)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D ACCEPT,
-},
-{
-	"bpf_mptcp_sock(skops->sk): msk->token cannot be modified",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ST_MEM(BPF_W, BPF_REG_0, offsetof(struct bpf_mptcp_sock, token), 0x2a=
),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "cannot write into mptcp_sock",
-},
--=20
2.34.1

