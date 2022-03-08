Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C582F33
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 04:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646712200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QczyTf36WLF6RiwPjZcEUbZdKCp4RFvJhvgbWA4SnIA=;
	b=NKTQSBnrUNSpHT4VQOg2mQtfuqLl45NhIs4yDwY78P3pTVdmFJY8bIIjM1GTy+hAzDJ0cT
	UtbR0nXGdVAE7r+R8OvobA0H6eiwNHmZ7mslSigQReejvjNA91OkV8fIQ8JXlhiursble6
	R8G31rtciE8qnihHw/aMJLkN9isSNOY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-cDPokWbONEKOJ9ZnrOP-NA-1; Tue, 08 Mar 2022 05:03:19 +0100
X-MC-Unique: cDPokWbONEKOJ9ZnrOP-NA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijxZT+MPWV9yUPGM9teu3sVc2X6sw0h6Su2AzWOWwowT8goUdTTngdaNd4Yhix2ndu2Q02bb5iIqZHAaaQthJPGJwknYhRYo4U37vtl/qOZ/NIUASV7nip8kdCR1RjXsvh1MGpgUV0N5hbGmupnW82r/gObf8Zap0R+M1xi5VlgtvbHk+yE4dCPuLP+gBniVqkfLXZxPXXGyWtLTVTfsghtk4Y/RA5cpZFf1D7tmIuig/DtAo535kwq1aLqeKQH+f907xHQgJnSfgrEl1UNgO1ZdXqW9l+V+vU4uh8MMTR5pNKE6wTVEwdZy2u3xLpQpw91U2wjxBIFSzpcm3ZtLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ0l557PIJKHti6t23iVEEtFuxpn33BRZk+pmmHRMtM=;
 b=bDPI5wiF7PlxX7P2SaZkQ6R90xIA1xlTUL4ggHUPFlN4nPROtlON8KyF0OZKA54bdWH0LskLof0cKig9yUwU+NB0LvZj41AeSY8Og1fB+EfGawt34+PgcLcO1psragfQ9kPzZDd/SjOkvNJ/JjyqApDNcaAcGjgclX/4JxCiUQiTNyrOq9ZyfyUdYElRwLdKXEe2Lz3iZ7pXY0/EvfMu3O4ctYbVEq8pAiHtGHV3+keOYoNz19mh71hx8GVdDyJ5uL3onHPtdxeQEdCO+t6Mu4Ihyvo6l0+I3qVs3HJ2SRRhNvhSX/ULWi44cwN/OjKClT/R/H+W0iSBERELfWILgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 04:03:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 04:03:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 1/4] Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
Date: Tue,  8 Mar 2022 12:02:50 +0800
Message-ID: <f44e1094d7b65fcd79c8813b8674c578377b42c7.1646711943.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646711943.git.geliang.tang@suse.com>
References: <cover.1646711943.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 016c0a46-ec73-434e-c248-08da00b89402
X-MS-TrafficTypeDiagnostic: AS8PR04MB7862:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7862C73693AC2CB41C362645F8099@AS8PR04MB7862.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KGf5mgLjXHg4O+W+TI89OqHzCWvk2H07Q60ttL23UumbfSFaalbuaotMikdOYrCHOsebNuhu1WLIXqwFTh1btYvVl6u/Z5DZ1Qy3w84NovYY4zctpGph+Pz2JjaSM14N+jmJu2OScjfPHiIJCpqOEmnwpMQMrz3C8FItcdWDUnR43ekpqWqXV79xaAYTzy3sEiOPeoFi3y6BCebYk7Ieij7cyN0QuxgVTyNpC37aKEAkYyWvYUsMWQ61pcleQjLY6hN8gTw95NzvJkjQ3Bgz+/nwNO2PaN1zoEQOY9jHJTyy+1zlH7xVaFNoGnzieFC/Ny1fRk6fmB0p5aTWlSm/1unnKLpFGXi7txtmKEz0tkG9nT1ss5LsuSoNKH0m7zgGK7vPuJkg308lMzR/yr9DCS/grIVhwlZbAGyc7FqpanYuERI0gkiLjJdLlOsCF9Oar49VfjxW1+MlEDaWMrfyNsfpmSuUnuo2hP16p+tm5xOK/Z3+5Ksj8zN4jIuUtXs9pGoeX0PPyjj0LCxXpNT1CcR9Wb3K6mF+5xqwRKCPU9A7h0VBHLjefHHqty3QVWacBXdpXjGAeSLZQNbDZJcfeyhX3UnOos1E6bz71LZrrBFCi3OThSd344l2rRvrIeiPOxlKPQ56pRvIbouHQSwg4KAt2X2YLOGAJq5+kavEFcjjAkTHkWe3D5UDD7JuLto8mHxbi+nqleQmtxM3rvw3ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(107886003)(26005)(186003)(6486002)(6506007)(6666004)(6512007)(38100700002)(508600001)(4326008)(83380400001)(86362001)(2906002)(44832011)(8936002)(6916009)(5660300002)(316002)(8676002)(66946007)(66556008)(36756003)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xg8zGbl+6e6a83/ZjgKc3UXwAKTsi1nKuzE1HPQMZfHfSth7UOjZ0rwbLOf3?=
 =?us-ascii?Q?7foOp+rhbnJHoiggycH7kaASmvA769Bv+Sa63H9rKLtQhTYVO7BOL0LjVrOd?=
 =?us-ascii?Q?v7t/B2X8NeQt4J7ovNSiw0UucwdIBJFmnxjaS6xRavxW0x8eHw7JK2Tsnvnl?=
 =?us-ascii?Q?AoHkV3dJTYmSB7cikZYg9pzftqzDqcmZEAKPb3tEua6GlPJalxyEeIL9qhJq?=
 =?us-ascii?Q?Y7SZpmSwCqmbgTN4Kqs8/9SQKnopbfia4wBQL5pWQaOhQxxXhJ00DXdUZDKm?=
 =?us-ascii?Q?VUr+HJrlVlyI2ZgAI+II2grf2hy48XSasCTi1ZWvo18+g4yBSW3uAihfjcLy?=
 =?us-ascii?Q?vh8hcS0jC+94BznjnLcv+1b0eDl4pGxIHhLElZRvwHkFYK4kMu7tMfLjJwIh?=
 =?us-ascii?Q?z9mrIv8ADAP1W7ZQY3CfXGOKofu0ovUlJfR/cOam7LhOuyjXR/VnRzOrFtfk?=
 =?us-ascii?Q?ZF7Od9cnle439SLqVB2vQz4m5hymAmgYNbP/Pbo7nZmSDk4lMsyGoJI/FFCK?=
 =?us-ascii?Q?jGlr2NTH1lZYlhbrAopTx3IvthwsOPrh4lK6isd+oGaDApRkheY62+ShdhWA?=
 =?us-ascii?Q?AOas30kDG93F02YecGLvwQTOQijTPi4THhULc5OpaIEj5VGywfu3MZBnWUYp?=
 =?us-ascii?Q?Ym90DVSVATze5HD/bVJSGhyQaGOkkl+z4vYkVDRv7cwxvdzePXgaRD8fJef0?=
 =?us-ascii?Q?FGaLXM0IjBLiOHq1k7dXC+0Iw8t16LwSLjZr2SvAD5cP8/3C9bMT5fhwjrpc?=
 =?us-ascii?Q?CE9GNFD1RChnR+4UpHhMNwzmeQM9mthFG90bh2VDZgwFSZnomrAKI05NQ3sp?=
 =?us-ascii?Q?pB0/AD5D5TQaBa/2GVYmoGwrVaS8J+cqKWe7bwopQmK0Zvs5l46HpSqh2zgE?=
 =?us-ascii?Q?BilrFKjz0hgyX6R7TXuLYO8ydHOjARwXXTi8o3A559pYNGWzlP3JghbUlhdZ?=
 =?us-ascii?Q?8el4eKj3e2svCFlYwJo4fVZGPj03HxaMfNkgnfYIDGWOufar+BUuJFeg5e/l?=
 =?us-ascii?Q?JIN5drBPtNIgWMDPq1op8d4XL3oWCy6t/+NbRejZjpvJWk5f1W9cK1D44shQ?=
 =?us-ascii?Q?v5BAVEtXYNPQyeBj9uecv9QMknln1vSfKqaSu+SfCCilt1b4ytPzLWX4XdZw?=
 =?us-ascii?Q?naMTjLBsRPmQ1+sM60w29w1usKIHt9VrBjCj2DEE11wHlquavg9VGwuKSLeV?=
 =?us-ascii?Q?NTKfdc33UgqyF5bBFPJu0+i8C1klBcwXvrgxAzbA788VJHZrzy0jLz04ydQV?=
 =?us-ascii?Q?dtNQG5urFxWYVFMKX6EKlH9ZFwM3uBF7KLndQkx2PTPQ/kzma26K8OhS9lZZ?=
 =?us-ascii?Q?WopYARcYibO2I2IT1MOU02ka6omH3adYyNOuCPuplSXrE2I5Te3yeMPycil4?=
 =?us-ascii?Q?baRh64QXFyBPst3wcjtUvKiZ9Y68sKV8rjaTDPHK2PeRCZggrQxvBZIL2HQS?=
 =?us-ascii?Q?prm6aa5sVzcKhtUSu3+qCxzsxQYKUBrw/1Bss3Qi/fQb6w+A/vfheXWjzDJn?=
 =?us-ascii?Q?KzP8098BEwA5/1McV9SG6PltiUecArmb1+lB7hx0vMn3/upBg87xpISBegKh?=
 =?us-ascii?Q?s25Zb3qeBDVxjRBxRE6ASdSrigWwgVGCVDG18ehJWSCfz0gnOI1oSg4osqz+?=
 =?us-ascii?Q?1z1F77xvSYqTfzvZkBmG8nY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016c0a46-ec73-434e-c248-08da00b89402
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 04:03:18.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KRG6BlC0BEiCdftP6DVhNFA7VQ56qGp0pmO5vGvQ+jv+PB6dx/YG1OabYT7wEartrDAfcZLxuUFPSfZLerdcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862

This reverts commit f48f0143286db0d8dbded9542d9a2535533dd3b9.
---
 tools/testing/selftests/bpf/verifier/sock.c | 63 ---------------------
 1 file changed, 63 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/se=
lftests/bpf/verifier/sock.c
index 1f85588091ab..8c224eac93df 100644
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

