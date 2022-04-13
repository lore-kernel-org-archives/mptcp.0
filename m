Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EEE23AE
	for <mptcp@lists.linux.dev>; Wed, 13 Apr 2022 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649860249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88xXsfWKltYVYgaO2dObpHZmAMB/KMKgRuXu8j/L6AI=;
	b=clCmmVz3+RCkGBNZOGcZo7hgTrNbRggGrNsqYfGa+oGCwy8Xn4IhKt2OrbFmRz/DhI3H8E
	+hDhnmhoV2UYAOuAUNFkq5UvJmeXLjpxKvJ9LjBcF+D9QPUezZZx/RYKFuyf/jYH3wjo/S
	GCfqbezf+EnQyQwTkjCGTIg03jXDEzU=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-mSaUFeDXMfW_8I-c3SqV4Q-1; Wed, 13 Apr 2022 16:30:48 +0200
X-MC-Unique: mSaUFeDXMfW_8I-c3SqV4Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPmCD5IyeCtIIDO1Dt901zmgHzjT75qBLlwjAbFJEYpWACgGMMp1TvKCuOTiXyp65QcZPv8vh+g4pyOu+/SJeBsfKWVhaMtaVxTxcyUEIhUs2hqoTdFtXVUkMpcP+O/yMDglFa/IXlFKApTCzH7+4q38VQ6FMLhWgNt+EmoUvsdjB/mlpmlK4CGKT0iJnzLLVQb4KvP6DvY8chEuPPf1drW7bzkG/fX+VX1fpCjQl5Q83sVafOUxsrN9G8f8AQGo2I1/9VvzH8+tswaPAgEpzAZslOP9Curb8g2287qrtgOplj3qtrGc01curAq8lsil/zrhbej3ik9KRewkuwjmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvDIX/6AmD6vX7TSqlJnqiJCyI4T2tjHKxDCh+iU+eU=;
 b=ampAx96KO+G/mTfW0bOvNNbnLl+NyAlRRDVHkf7KACaVpOmKM4HsbQHMgeFSueCzNxZlfKdLjFaWo4dCs31BM7J6IRGf+nX9YtqTFdozXVXOYFMpbHyZTH86zkO92KPWIi2JBZPbUWAtY+3bAQtx8pKVX0jrC9ReKwrDj4LBfV484QiwqJMhMviJ770I3k3RdSrDcy1/26SLG73uG9oNKdkvMJ7UGdpMNwKB56lhGIEgsKv8XBkPrdBSwOBtEC9c2D5Ubm8GkRUl96kG4a5xGKkqyZnKqfcO3Fhvd8Nxj5E3Op1ZsLGxw4TojtRUe4MkRe/U/tNCbHJsh0lDju0STg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Wed, 13 Apr
 2022 14:30:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 14:30:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/4] selftests: bpf: add bpf_rr scheduler
Date: Wed, 13 Apr 2022 22:30:22 +0800
Message-ID: <949236c0076153b4a0b0f6baefba10a197496c29.1649860043.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649860043.git.geliang.tang@suse.com>
References: <cover.1649860043.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:404:15::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7e4f51-4f3f-4cda-9762-08da1d5a3376
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB93512197FE5171F3ACD6066EF8EC9@PAXPR04MB9351.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8QARZ0V6MiG/nfj1obKpV71tmF0PB4PGiyFOGqecIF9fORJiLaI0+ssKn49GWb1NjJWqj3y1BCVYPQbpgSn+y5L5lgpFiT5e+R/K10e22ef80OKXJ2xErgEkzwsbhnGEt2TV5Xfb6LJHFJZzFibzxWg78udQ6VXpVNXd3TsePm749K7USfVayCFgGQZqEgGBR1idyX4pNgjkODTCzx6IBPu2NzvY33RkO2Ndjob6b1uQO9iu0u4sCgiVkI/w8Hm/LokxPFvgYGSiq2QiJg8g+9Prj1ALD903kC5X3fTLP6WfAqtad7GT9XQneB6Qmobvd29TUzs/ONNy/i4UnTRRBZ7574jhyWCAjtNf1Be+tfiaKGn05ELQi5KfvRl/pWT+1DgUYp9AH6Mjeu55rUjiBxljr+KKg11UVrsFabsK01Y6bGM1KiwkVjZLrUepX2NFWOjkwv/anke+fVr3ziijKysayMtzVOwkGX+9spbNJP1mGKcKt15cx7yCwKR1BG5fjHxbTKooC2W9p38enl78Y9WDK6VVpx2qW2Ur3OS/LqD73VhyY/PGSiZucmGBb0aTorij7x+W+1kDmzqvGWpCCrzjlvbHhwWfcNyOPNqQzIZeLw7bAcdcFZeM9x2fgTbGthzWJemCvUNLQ4HuM7CDPw5LX+01xbOVpmakjPDyccJ5DCr7IlfZWEUvqBHr4GrOBfy1Sz7W/wwZI9iFyakM5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(6486002)(2906002)(6512007)(8676002)(186003)(66476007)(6916009)(66556008)(44832011)(4326008)(107886003)(86362001)(508600001)(38100700002)(26005)(66946007)(5660300002)(2616005)(8936002)(6506007)(316002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EE9zEzvZjtDWEqGk7xPvYPkGELG+gQopaVqBTWFf/4BcUCIodSA4Wg/7NmOE?=
 =?us-ascii?Q?07YX/Wp4b59hVZHp8ilLAL2BSW5bc1H0rIX3wFfcmR+52pZzU9RoyeZIGWYG?=
 =?us-ascii?Q?rRWk9yKvXwkKHiHNl2duSu1J/mgUKNV0FyLRvSd58X2Dbr+BUaYqv+DLVCQb?=
 =?us-ascii?Q?S2lFnk4gcVBwMLIKPuMu5SEcAe7RXSgQzobfj1RKu7Pk55acC5DNDyc87b8O?=
 =?us-ascii?Q?WbotzMwCGau21CYw/Sx56uK3UwiJ4u4tLf6HV8ymVV/hQitHDTXDab+adCYt?=
 =?us-ascii?Q?n4KhbGJ7baSKO+xef9S8GJB674MfbkkYckt8N0mSrBbhCVcoPpledTapJF0W?=
 =?us-ascii?Q?V0AJXRQugGihdrEmdXMRKqrXNZ6SNpnhL0zDhrtGwVQMKsc1cMQDz0yrYYxp?=
 =?us-ascii?Q?9IOGSC/nuD70hAVRYhqXNV4zA5ziUDMa3Ypofm8ctVS0WerkjJVfljBsDiX1?=
 =?us-ascii?Q?UnPqcf5W31ec7QjEciwaNStEJ8VVA8SVzoUPR68MgmpxKDGuI5jD2hIlJavE?=
 =?us-ascii?Q?WLS2Ep4JXjmMcIgfZBcA0PPYnWMhTf611fEToUxCHtv124at619WBy7zBc8K?=
 =?us-ascii?Q?5bjmD6UOq3CQ8u5V6xB8vnH6GGC3rTO575N+yBEslpMeEkpXUBazTlzArPpZ?=
 =?us-ascii?Q?f62dkPNUqVc2GXrWdOD5lLrH+/kiTA+qliq4OmvrRPQsL7FlKDBdflWcYBS0?=
 =?us-ascii?Q?cr5GYTm8Vq49oM7ZYtj4lgQf8T0D7GuJUJFBPLLRcKYOh4S7IV9mC7RFh4jc?=
 =?us-ascii?Q?ucsYNrrcvOlB7qbD2SV4dqsLepNaC3Ys7hSJv9Nr6e24wxqZrr/hvfbEB7C6?=
 =?us-ascii?Q?uVow3tZjfpXh00i9jUi2YIag7n/UjMPVGL+fVKNie6qsjfWT4y5OUFLNOkT8?=
 =?us-ascii?Q?az8sVb+NPJM/35vIWRaSc8XZFlxFHNwuW1wBAHwYg8LqsdpAUc07ULH42qCu?=
 =?us-ascii?Q?XMfJ3QkqEO8MXHNMz/XPrFjTwqN3jXh7A3+cxERHTuxlk9l4hXTZjpkif4fn?=
 =?us-ascii?Q?8FNwNNBD+o68v/oLmbQd1Q62VNJnvwh8QNx0j6/TT+ws+n7wGmaQzJstD5Lk?=
 =?us-ascii?Q?9sviwwyFFuEvg1h7+HkXgTPWt7D+qS8mdxf6oQ60bHMLNwf+woc8VhMN/szr?=
 =?us-ascii?Q?Q+ZCtD/29np4UJHrvhpPN8H6gn2oY98l0vGsiKj/BD42bYPDEJm2iq1qzaqk?=
 =?us-ascii?Q?g2UNQUwkD3+HLb4IoN3hIB0wVoB9ev97TafCT4Q+IJHpXJ2zc4s78sJPSLaw?=
 =?us-ascii?Q?k3qrfVaSro+a6XbotPXK+3JdoeYnnx2hRJRKjt73ctvLF0MUoIy7c2hQl3EG?=
 =?us-ascii?Q?4BkglU5np5WCCzcmMIf83wsBPUVDFhLufOe9XbJkjKcMchuEWLWuqjj/NHAB?=
 =?us-ascii?Q?fDEorDY5liAoax/G2MN0tzvP6V7lej91eXXKEX0U9H62e4dsBYoKuaLTvKum?=
 =?us-ascii?Q?O2BOOauvLU/xjixEPl/EeuDTzQHt21CofanrdJusRPX+7pyuV9MFPah3p+F0?=
 =?us-ascii?Q?94FYdvO6AbKTZRcgofjyWhgRbNyqZ7WM/nhrpM5NetbMkSmitur3xZ/bBPZd?=
 =?us-ascii?Q?WB+oLwtITgLTXgv9h6LIBv5SnYLIZLrGQDFqmdLW1n6TueBLxI/laI5ZI83x?=
 =?us-ascii?Q?rqLKnU5wpYQjf9yvGIFn0hZ3WBsDu2OPbXg1WrnTCmnlRn99ue4OAxAccHIf?=
 =?us-ascii?Q?2g3Zt6PekogDdD4R/eYPc8neQjN+NrHwLhxr0dP9CwO8iFR1P+h3IboypJNv?=
 =?us-ascii?Q?DtZqi8o1BfToixysuvtUrLJ6ScAqfGI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7e4f51-4f3f-4cda-9762-08da1d5a3376
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:30:47.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsgYuV3qiCeXxEYxL+1lAeyH5XXvZADP4fYLE+dctr86tAX+j02WNu40PHY1JLqdxNPpH8arQ2sbJGQC5+Fj2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 +++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 54 +++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 4f82baee998c..140ead91e2c6 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -27,4 +27,16 @@ struct mptcp_sched_ops {
 	void *owner;
 };
=20
+struct mptcp_subflow_context {
+	__u32	token;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
+
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflows_array {
+	__u8 nr;
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
+};
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..531ab12a93b1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include <linux/stddef.h>
+#include <linux/tcp.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+extern struct mptcp_subflows_array *
+bpf_mptcp_get_subflows_array(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_put_subflows_array(struct mptcp_subflows_array *arra=
y) __ksym;
+
+SEC("struct_ops/mptcp_sched_rr_init")
+void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_rr_release")
+void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
+{
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk, bo=
ol retrans)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflows_array *array;
+	struct sock *ssk =3D msk->first;
+
+	array =3D bpf_mptcp_get_subflows_array(msk);
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (i =3D=3D array->nr)
+			break;
+
+		subflow =3D array->subflows[i];
+		if (subflow->tcp_sock !=3D msk->last_snd) {
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+	bpf_mptcp_put_subflows_array(array);
+
+	msk->last_snd =3D ssk;
+	return ssk;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops rr =3D {
+	.init		=3D (void *)mptcp_sched_rr_init,
+	.release	=3D (void *)mptcp_sched_rr_release,
+	.get_subflow	=3D (void *)bpf_rr_get_subflow,
+	.name		=3D "bpf_rr",
+};
--=20
2.34.1

