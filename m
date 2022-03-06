Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069E10EE
	for <mptcp@lists.linux.dev>; Sun,  6 Mar 2022 01:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646528520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QczyTf36WLF6RiwPjZcEUbZdKCp4RFvJhvgbWA4SnIA=;
	b=TafdHwGugXFAHj5RQ8nx4szewFJJPykZnBwH5AsX2F5FzB6oSe2W5gaGcrV5CFC+nFIKtR
	KDHA9sVHohVu6U/y8by3J//1x4le61wBIh+QeEcxGO6h3B0U7qudEZFWLEsHl/CNNxNn2K
	5Gi0YhddcyJLz9oppmE+eLYQsa0OJmY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-p-mNzMpHNRCFUKN-JdeviA-1; Sun, 06 Mar 2022 02:01:59 +0100
X-MC-Unique: p-mNzMpHNRCFUKN-JdeviA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqc+t1pffjSia2Sa/XHuCGbiqX8Og11DMRu3tJ/zQK0IdRG9MQ09OeIO1WVLptC3eW5C/SvMkztKkWdlgvMhHzsT6q1t8mxWqpFRNTN1GKqeZClHuKENlgHqSMkTg4UPX0yShYTNHXnafnWwp6zpp2JUraYQz4+UoE0ZX9Mauo+3hOkj6GG8g4aseuaO9YZiiM5lNXDGzfzltKswyPMo+cWko18PVMEoy9LI11EyhnIDmLDe4W/GSngTbStHJ91WWMMuEkYLg+Dd8+E6+ldUiZdhkTcn+14wcFAf76/qdgFmyYmh8LsIgH7wxqz/7QfpnTM5v/6XrXNVju9unWbL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ0l557PIJKHti6t23iVEEtFuxpn33BRZk+pmmHRMtM=;
 b=L89AxTgXaNVcn8ArMUIZtyRkmmWK1CgWypvMOgHsZdsN7qby2qp1lAylzcPfKIDnQ2PumGcg8+PO4Ymlpruxs/qHqjv4Sv9zMdihuv6JaQ5/esnVg5HinsPNapBQM4GPxTWd7NfxCXzVcc0TlVUUScf99c7YCN8K6jyFkLyXkYj6vZE23KughVXF7D8z/XDoqZxuS9gLaB9JUW13CSBzFucmnfyKuanrLdQ1GXo84Znex2ZChzB80KuMXyPBx0g8JCB5nDXqx9wH4K+Y1b8YFC7HiEzp4F4Dq1odCeNGnoHmhrq3nMy22+h1fjnsPNRM+pnN0K2G0fwqaDz2RD3C1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5724.eurprd04.prod.outlook.com (2603:10a6:10:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sun, 6 Mar
 2022 01:01:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.020; Sun, 6 Mar 2022
 01:01:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 1/4] Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
Date: Sun,  6 Mar 2022 09:01:34 +0800
Message-ID: <f44e1094d7b65fcd79c8813b8674c578377b42c7.1646528337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646528337.git.geliang.tang@suse.com>
References: <cover.1646528337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34e38c69-a1e5-4e04-4763-08d9ff0cea13
X-MS-TrafficTypeDiagnostic: DB8PR04MB5724:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB5724F241A6F7BBCE7CF37905F8079@DB8PR04MB5724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KJBloQRg3Y0aNj9X4b3A3VelHskjzg2hXL1F17YEHvPAycPAxQDACz/n9DohF6EHEfXxS2aemJv6FnIKHRVYuRi3FHvZea7AAxO0R6rBAKPqXm+8FuMwG2h6aoJLE4rJEWX9Y6OqdoG3nTidd8EiHSwFPstmqXgLx0Ain+hVWxnNOpFKAav85obdpEl23Hrv90Eu4ekkWHLtCPAhLF5heGlc4G8fmvnwJjz0rBs+k8l/Or0qolCXqEQT25s4JyEah+bZ53c0ocVeuBjf1y2+IR+AbIN8lOlPCuT4rZbE4bQY2/tdzL7GC1uCIIwTeSeFd2aPbWRGgLnxIn/zhwZN+eDDbEXQUBFnV7ZVr3gWQTk13F/YQ22cqTrn+6zJXOzJCZ77NMWCD0WwIXbRVjEZqKxvWYY1B7DYz7XsH8LSEXEVu0njI9bxfGV/pT2FNEjwFTURUylMEMCt4bE82kfOpgg21eSeNKzIv8hpWIQSOLr9KZO7jp9wb6A1+9TEcuDpxea+iEQIz2P74FALZygLpJ48iCgQ4rpZVJaaXYorhCZKnoCRxvXT/CHRAcBCQVXwZjeichhoK7DodiFHCLowmnO2aDa4dSsxRDmtadYvfUwZ8YGZ+NNDlLZi7aeLcG2ZfDu1NjKvryPDWBXm4em6eh6PhKxR8Hd42LnCZps81aG6WqIiJOJjvpuS8mfD2wbxItTCXKH+eSSPnMq3E7fQGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(8676002)(4326008)(6512007)(66556008)(66476007)(66946007)(44832011)(38100700002)(6666004)(2906002)(8936002)(6506007)(83380400001)(316002)(26005)(186003)(107886003)(6916009)(508600001)(36756003)(6486002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oIWAAC6wlqWa4npRBD6aNLDl9QkQpoaZoxoWGCYKleAtg+X3tTa3RWaBxrF3?=
 =?us-ascii?Q?AwBIsD7axV2irX676abrr3Yh9O1ifDWe5rC51B04Bs0odJp0WPpGFrsYVIjF?=
 =?us-ascii?Q?OrZdCU6bQMFUiHdv1kvLjIqUz69nm2x+O2Nq+IPxtPyqVkl5V6Kvdou9zf2S?=
 =?us-ascii?Q?pIgF5AOEbuCCn5CTdJq94Sl6BZX7V3CHrmsnalW/LGhpx47N0G406qzJjVCe?=
 =?us-ascii?Q?JUztfYhnqDWiTyHyugSvUFMQgzIqoNvUkRlUFxdpbWehV0IrzZO04hDYsz7v?=
 =?us-ascii?Q?hwL6EwACSfRY77WSu3p1LMMTX8TqjpNlcOovavfH8RM+UkJTVgY4vy8e7g2a?=
 =?us-ascii?Q?POsghuwWZbdmvJrHhLd++dcib3IWWm9+3MSmzMqn9TCOQ8OxQjoymUw1T61d?=
 =?us-ascii?Q?UI/yhMp8IktHZc+akWRVJAwYMFndlZ+FJkiU8eD25OjFKOaqEu+ifcAbMg2X?=
 =?us-ascii?Q?WapAGdDwLw/mnsUoCno2cnsOk+RBVIFO52xKRcyORdVFy17alks1NTacWKVQ?=
 =?us-ascii?Q?gWO6HgZLBE1JNkoeyL1wrURSjapPWQPfsNLWA+CypH0bmzvXhBBUXuot7xFu?=
 =?us-ascii?Q?vr/J/aY3PteTLB+gS/SrmSxjY6UfdbiYvhKHbW0xpAIAT3uw2V8wjVU1hy1p?=
 =?us-ascii?Q?DsASMq2E+bQwhLQoWWDB3rVGzFMXLdiRDqOcSn9XUH/WBqQ2YneC6IGzUBVD?=
 =?us-ascii?Q?jeTIOtzfRtUp3CLpjUp+ZBkpaBJjLP4Mm/DZfOYojpOoTkmR5dw+8OwTsMwm?=
 =?us-ascii?Q?79cog5rfROs41aOtPByIa/aPqPbHMjrGhggJwJJT1feDVTUe/4If2tqNh3lS?=
 =?us-ascii?Q?xOzhKNften9NdGiVMf1Q4C8kA1b33+SOiIkKxhNAE1y7ObGCvDzQqZAyY5fO?=
 =?us-ascii?Q?vvaGW9yPU2EWJ5qG4vLOow5nb/3DBHKoQK0NscXjUi7mh7ixzqU8VecrBD4u?=
 =?us-ascii?Q?ONEHrRhSgYdRwJ8GagP02opuy6N/QX7QEyu/zTTClXmsI3322YCuAQWwZzoF?=
 =?us-ascii?Q?t/I85ruSmUn7rL+lwOl+vyARa5QxHuKgP0YXMNC9iLYflHM/7BZOR/tOR/jC?=
 =?us-ascii?Q?QPFNhWjPlvscZFfmrPa5w7Objsz20ukB7yaVbitzbbUEqjouHfR2yET9yJzI?=
 =?us-ascii?Q?5OgMf+O/ohQKeD5jcHXxHgGuPgMtPDcLATTwwoW9NrJMkhBf7f0KR8tYunrS?=
 =?us-ascii?Q?q10GwBIJL9xyTysmaT5WDXw2FmsU2gqwDtsF0VC5Bw/V2IVDIN7BofHrBg2t?=
 =?us-ascii?Q?1CYybZjd8+wGXSfvCxd4cnOMLYwp3l7vyvBGx/cmTPZx9d0piaxG8A6PWvge?=
 =?us-ascii?Q?KRsFFJ3247n/8FIEE0vhr4kbQyXl3gSKcJF2Iy+Mhn9/egaGjjQKPOq88jmE?=
 =?us-ascii?Q?tWIj6NL6McmLI69TfV7GoFuPSjsYN7vnYcw0cezQ14o4nQ8QYzLB1wyfAT1l?=
 =?us-ascii?Q?ayQM4Xwi/picivedAv9k97a21fNDkDmbWIlvbsA+yCCS56UsZK2/qyOPX+ZI?=
 =?us-ascii?Q?y8nS0Div4JNex85DzySA4+Gnts0BkD7IW71jH4/4MN4VMemBAQCBSAE/C/dC?=
 =?us-ascii?Q?F0pYc+OCiVZUFFz0QF3JvOvx3X3n26/CMdWCDXj2f2ORfOYK3AQ5e5BV8Q8I?=
 =?us-ascii?Q?Mzcq/EuYJ1uAl52diHEjnfE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e38c69-a1e5-4e04-4763-08d9ff0cea13
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2022 01:01:58.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtdAyXOI7E+Q7+3Kwac+++ku1EajlfrBOODAjCY8mCRee7lcOz0miiHaHXcbmPhFzq5tH9yl3vF8T/Adsrovfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5724

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

