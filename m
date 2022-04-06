Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C233D7
	for <mptcp@lists.linux.dev>; Wed,  6 Apr 2022 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649251596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+su2rA5JHc+XZQdCZwE0iZEaajQ6s6c5KXmrGfjDbk=;
	b=FmkvaFTCp/fru0Ebp6+CtWX/hRBZajcrcZOX356cheoglBsalfnDbLiT4l8ViRd5hdH/og
	j3kxRMFsW8atN/0PA9gBLa3EcaWF5+8d4UUA2ArXX1+nWK/lJQblColmgtVc+deqZeFsmU
	V9hlvmIeTElGPhv/nojOWMjDOTuIUrs=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-VGT0fUf8PQOdBJHEiFQ6HQ-1; Wed, 06 Apr 2022 15:26:35 +0200
X-MC-Unique: VGT0fUf8PQOdBJHEiFQ6HQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep+T2gtNVb4M6tBC9C48xNRSxCnP7IlPFgl2aVQUOInYnagcYddAatseyOeEgNpMzOrBF2Q08aLira66F8pmnA0J8KWRJe6mMamkmB/sJoW9Ydah/3UAqSpA+DsjMzxHb+VM2pfmpX0QTcli4ZjrKday8xCPJKjxiRVWGtpCATOoySEyVaP1LzHKtC4U4DFowNODb7VVwiKY96HGfVABZB0S14jtdldH29ZUCtw2XpPbUdMZMY3d4ID1hKLgfWR+ytd6ksi4cR1bWWhSFbNl8elnxPnlG7tzF57tyiDTOzQCukRm/Hlxiq5LQcxLbjGbklQbOUTYuiQee1bKyA8K6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9JrX9Y7q9euTcNMa7aZLhCpSSOuZedhX9xFJwARHBU=;
 b=gTSUbrhfKj2llrEkv6804CuLjdjk0YDR+ylKqjVI+gcvI3EVrhP90Ws0WCjxdncLx9Jzxa12+ZnTDYtoSmbRWAOw1gFdEqElGE93o2D7ms97trf9tSRl9EBldsE8DyoFMtnxV41aGQamb+chANx4UWVB9LIM0n9xx0IDHoTalCzVFYKz0ODpOkgQGNuYE+XDMIOeWmIQoslK4oFldqj1MCD5oTwO/LnE1XjRXGzN1+zq5DqkDTXgm3whizivbFGroGtWaz1tmADVvhexi5PikGhdruZ+x9cQ3sAuMx/0qLDUP7fqiyAXhn/qk5md0kEUPzJVYZdA6Yx8CXD2eJ8EIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB4187.eurprd04.prod.outlook.com (2603:10a6:5:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:26:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:26:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/3] selftests: bpf: add bpf_rr scheduler
Date: Wed,  6 Apr 2022 21:26:20 +0800
Message-ID: <821d10426af05c07273bb9264aa31e5d4bbd327e.1649251279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649251279.git.geliang.tang@suse.com>
References: <cover.1649251279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 138ffa71-1966-4982-97b6-08da17d111af
X-MS-TrafficTypeDiagnostic: DB7PR04MB4187:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB418798D3A0C9B8105C34713DF8E79@DB7PR04MB4187.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5VPQ0TeHyLRAez1BcwJCr/c5K1BvtOs17ZzG3WcOSE/cvx+iidZNMUcrhJS8FTZqDO8dNpUAvgNDTbELxXU1E6hdKNUm7EJJfy23QYWhMnKWCfkK+ip69HNHkg430RnVscE5who4b6S/VGdG2F64/peHYaIeJuRaKOsAsjCfX58F2Q7cfdx5rYdexsnYOlk5b+qlK6zaGgm3GH0np+q9uE0BAaEt0aknIlswAIccczMtshoxYtFPvHmYEQxioaPHnH6A4HL4ZtbpuXcKagGDTdUHvQoouu5fhWxWdZ3IZIPp3AsfJWLBvuktXDdQ4D/uSSGRiVLUlfDKBfcTPwjnIEST6dQ82pYjc9O4FU7nugdvKV2nOxQAIKZDc1Mqa6yUcM0saduTRQWWKxNgmoVfKP0bCBkf493EqAhrb0mQjnSAEpOyK1ZxPL2t3cJQdOYXzL6m0r3eHVucQ0Ov41y8TVdMdRqcGuBobrvLwQ7d4DCIf8L0A+d1uPgHqboE8Py50YRCYeEpKjRDI8iImTgCFIb0/mPsSdxfsf7XuNAc3Ja7EnCN+s46/9PwI43FRKATZIEU4l9aWeo6wBk+KyJ5k6i0KjA3ZdM9V9IMqbq25OhvzkbjhFvLQs7qIHRAmHjaBZ5WhMu73+bkhlguEoBlmwgL1DFgd4A0EgsokgIO4GY29V5hka6RDTjlz31NQTaCWHHf+HiqMwPbCILxL3BP+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(508600001)(6666004)(66946007)(4326008)(2616005)(83380400001)(66476007)(66556008)(6916009)(316002)(86362001)(6486002)(6506007)(8676002)(107886003)(38100700002)(26005)(186003)(44832011)(2906002)(36756003)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1V/r+mImYOCrHIX9ekopFUjouI6fXpbKhemPWniYv4b9nn4JQngsr7vi07G?=
 =?us-ascii?Q?33rezScxUzTtvW8DPjdKqI7Cu27emoh2OmoeeohLflDaItTAAbLsOz3gNHQP?=
 =?us-ascii?Q?WK74NPG9a2qqxO1kMq9a1UnuNQvKhLT1ohRnJJd7igFB6Iqbds74IDGcVoxw?=
 =?us-ascii?Q?0sUbh6ldFcnuvAf3ykQS1jYqYLbYOF3za3BC6ZbcmcpoPnz2iKh85vyWbhaP?=
 =?us-ascii?Q?YTGeLOugig8/yf8dcRGv0h8aBsp0IVU6QAMqwChe5BWnWbnSl/wlBh9izCwf?=
 =?us-ascii?Q?bK3hzAT/ab/c33pVxXbEREJ3M66K6n7OnfKOzwJJ3F+zYvMEpPdCBkGcjl78?=
 =?us-ascii?Q?+1PjIpcMEoY7XV8eLFSTc3c5lNEhwAKeiFXUAyCvMhSN1jB+wBtC0g5QWKNb?=
 =?us-ascii?Q?A7w5Og2j6PO74bQEq7NUPK/X7qn9pRdfiBAq63IE2/Efag7Q9XZpOEKtK3Q2?=
 =?us-ascii?Q?jbA0axbf7jLfFEVAV1VqwemCdt0+HLXqn5vCl23P6jDSC1x4wwUcT0dvrAvl?=
 =?us-ascii?Q?LpZkczRr6mj9NLWcavcsrZnJ7DjKUK/PAbUMN1X1t8p2NolDSH7bjRj6deus?=
 =?us-ascii?Q?DYq041GIWthfP0qVLtJHXGH7FlW/LydkQqeKIeY/Hss5eTU1DxYCfkjBpB//?=
 =?us-ascii?Q?fjl5yv/CzxyN9B6yqNmgQCKXqJioKIVTbfmxwu3QR7CBTRIlUs/KbJhEsQBE?=
 =?us-ascii?Q?uEHwEKOsblKiQwUNG5cSq+vL++W3Gj7nvqHCWkdPcCEcSiueLaeLq/Ns8lZT?=
 =?us-ascii?Q?uRYiK9CxFOCatN6TMMPRNGkkqYnzo70uZE6L3DZc1/OWp3nNI/DfdYEPOA3D?=
 =?us-ascii?Q?Ba7YAPl/wF7tvT4xs/ek6LWhY3WYzheZZVplli6pYeh4ABb2I1KWCFnHEl/L?=
 =?us-ascii?Q?UVpc/ULX/jnpZUKDjlhIN54Bk0tOcRnDjN0h6zaW9gSnhoEj9N4qUH4ooBB1?=
 =?us-ascii?Q?IGVvEk8KL56K6ZZusEd1vi6uvqjvDFYiu7Q6f1yHTKysmL6RD9X0PV5cHzOT?=
 =?us-ascii?Q?REkZAsC95Xq2wt6PZgWg5BUblzoWvbygL5DsBiGsKiy0VKKKbOTKb6un9hik?=
 =?us-ascii?Q?D2Q46E93dis32JCSS6q8sPRTwlZlMvXrzznBeT6/bqSlQewPv8uiYfwy5QmD?=
 =?us-ascii?Q?4nKsNVEzuKaMxHwKnWd8C8tpkC8ry3nyqhcu1U1eQILAjAgwGQg41xNRBjRF?=
 =?us-ascii?Q?0Z/CJUoT+A/Fmn1c/zvwvJ8qFNM4S4Oh5502amMYKhOnVacCIiirbFyWyOAX?=
 =?us-ascii?Q?sFCR9QNdpxjjIERU0F/J5TAgx4vYSq/JinCfdBXgor8koteFGLIKT1zwTWME?=
 =?us-ascii?Q?u10Yqodj6qA0ncO9JBAxO6LCxkTI9jV+LLRS4GyMzU/sZEwR1kbXzUEQxfS8?=
 =?us-ascii?Q?m3BTnKC+ue6AM6aoUMqiAuyxFFgbirFZx73KlMaJWaCgJBB1nLuXBIHxb8a/?=
 =?us-ascii?Q?072+J94NTOxmdmQ4FcfWw8jV+DW6rN1HfXYHBark5vktCYLf6RnxUvU6u9+V?=
 =?us-ascii?Q?Y1uJMXyqrMdWAi9OkvzVoqKoj8uKdCMedbVeHt8VyoIP16Uq8rcHANY7PvfJ?=
 =?us-ascii?Q?pf/ghpbUHEGJHy6F0azkms85S5yR+UApxew2s2m1sGWOr0veGCikKemMhcAj?=
 =?us-ascii?Q?VuV1Fpj/nPwk6mO4r6nx+h+QY/OkC1mBCw9yBSBsUZfSOzjarwZiRP0vsVIo?=
 =?us-ascii?Q?S8swIg/vy8MCILGUSPyFFbu+L68QLLJDlV7yAWgwx49fFH2ayk39Ut18QSu/?=
 =?us-ascii?Q?JKuMRg99sWjWAlKp3KYHgRh1RpZGkf8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138ffa71-1966-4982-97b6-08da17d111af
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:26:34.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+4bNtqR07FA83NWK5aEEaqDUoptPd75abZ9ylKr1BHV1++NT26sbmIkvo4Bcn/EKsw6xJZLOlXy6KG+RnliLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4187

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  9 ++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 49 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 5135eb6710e8..6acd62fbdf24 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -6,12 +6,16 @@
=20
 #include "bpf_tcp_helpers.h"
=20
+#define MPTCP_SUBFLOWS_MAX	8
+
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
=20
 #define MPTCP_SCHED_NAME_MAX 16
@@ -26,4 +30,9 @@ struct mptcp_sched_ops {
 	void *owner;
 };
=20
+struct mptcp_subflow_context {
+	__u32	token;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..3e83c94971c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include <linux/stddef.h>
+#include <linux/tcp.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+extern __u8 bpf_mptcp_get_subflows(struct mptcp_sock *msk) __ksym;
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
+struct sock *BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk)
+{
+	__u8 nr =3D bpf_mptcp_get_subflows(msk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D msk->first;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (i =3D=3D nr)
+			break;
+
+		subflow =3D msk->subflows[i];
+		if (msk->last_snd && subflow->tcp_sock !=3D msk->last_snd) {
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+
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

