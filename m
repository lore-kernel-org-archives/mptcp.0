Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D328EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651413461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCS7/o0mFEd7aWCvAgyf4JzWsq9+Ec/zl5yXzfeCQRc=;
	b=Sl7iYK//tMd8eziH99EiZy2ReM6/gO6SAXlE4yOHTyGsYzYh3wEgsMTGD9pajREJ7l3/u0
	WbtKCRNSS/rx36qUTFyUR/pN9kUzKoGmXTTL7LPTwvf40MG4SYPGrhov4i95NVQ5yOzOIt
	dERKr0cG55VvYtzTSiAT8/++cX2rzbk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-psTUDpMMN7y7A4y-ip0PXw-1; Sun, 01 May 2022 15:57:41 +0200
X-MC-Unique: psTUDpMMN7y7A4y-ip0PXw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCdEoeGYTTHlwh/JvRydipLDL+E0tbmwJXpxhW1aYaHf69fkXumI0/+19ZEEEfwuflMvlEiyyB8bRKmiZGvqGX/sCZUXOZojAkCEkDaPAngy207Ewc/420vSXemUt1QbV0c03j66Vf0k10jooGKbjkFkrcGRBCemKx/WHtUeUM+02Stno1/XttaNp4CFe0hN4YU/EIj+E/LEyPavf21apy6RfXpI84BmK1l2xXMdc8ShOE5w1uTo7j4Xm3GzLGCDMgKK/VAeprmJMXKZdPoh72Cc/eSAnaoOocGpl8QIPUf+DWiELFVBpv9CxU6NPWouiS82CIpcvgRfuHZFC2nvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlIi8ZUX/4tAooxzno3A+twvvyk5QS7FS4c0RSTpZRE=;
 b=E+NuLmVzOqgu1bZdGmYkwendE2qPJLeKWV3PBEcprWgTTKfzHNPLAc2+RGBfHxEjGEuPU/0+Co522WXIpG4Fuon/6gKbwBeIfFmYxreuKyNJ5vPNmKcIEKm+ZEV4nJReUP4kPawGF5e5LClPVDm3xqJZzTOIy+Z71QJzIUDq91hS44hlMNBwlarowKiduWuzjIRox97kjR3rqJnNikWRefQ8MhDMY+MjGIFTw/7GeOCl9YPj+8vn0sdDuANzvsyGhBO/0gu59/+bo4fZhwLX7BIPskOX3fK/ndyHfKisaKsCGAtZ4Rn0WdecSFqVFlstcsktFdNsVQXAmZMT9/z99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6605.eurprd04.prod.outlook.com (2603:10a6:803:124::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 13:57:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:57:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 2/3] selftests: bpf: add bpf_rr scheduler
Date: Sun,  1 May 2022 21:57:13 +0800
Message-ID: <b02fdaa461bc8c887fe39fb9d659cabd1ebca08c.1651413062.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651413062.git.geliang.tang@suse.com>
References: <cover.1651413062.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a061c2a-5fb6-42d0-232a-08da2b7a8e13
X-MS-TrafficTypeDiagnostic: VE1PR04MB6605:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB6605DC0A0386A3E70A38CC1BF8FE9@VE1PR04MB6605.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jgi97kMlW6OVtsLEyE9OKQxq7tmPGm/n0FPh3v5W3tf4qFKVw63pRyLyYoNQHcSZV33GxFNBBdL30rF6mXsBl/tny3xVQOaBlBjjhPjNkCVheoGfALsyxa3hWm0aGQkzi9zK3/AgIR4Jw1A+TYHzqZZ1/Rwcrpg2A18CEbq9rJkz8PKYTQEUwaCkgZfNuKljcNZpS0AWsJ0Sqk9lLkclqxNHKQVUWDfpeRMQDdeZKpeuQms56nFgYlFXUOZqdDzICqbyCODtxezHJiRgDKY89/EFBlT9tbAWVYWcxdKI3bd5xRejbtT8RMIz/7M14h8xUi2bXGX6B3Yu8GCOF02u3y7qpJfS81jPYijmY/eyDrQiaWbieM+X15Gz5ZEG/mnC2jX86UVMXFihlWbXJ9o8UxWBaqls6W3sBTaZ86tGP6Qkv+YSixQ7hL85UkKH96qZdpzTk5HArY9uG4FUCGvMfyRpR5q/R5Nk0lYMHzAwN/PKFqdNd3zzZyKcVJqR2zeCOyoEFPYyF+Yygku93V2Sjz/kRs1vHEwAPYeSmmiT42q2p2XzDoY0VDOperbmC+qaoCQK6l7XVxEsvAwMNQdQ2JPy9Ky+JRJGP2Rm7gU+ZK9gf3BQadE/f+0VLg7sOe+TtwDW7pIojja0j6f5xP9XbmEWxKjqM0y9bEt4lIZjCcr0FfkLcNY4HSaaI78e70iQfOyAoHR8lDofnpH5afKfFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(107886003)(508600001)(86362001)(2616005)(6506007)(6512007)(26005)(38100700002)(6666004)(66556008)(66946007)(186003)(66476007)(316002)(44832011)(2906002)(36756003)(5660300002)(8936002)(4326008)(6916009)(8676002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2HCHfGt858WrJWlnAGh8ZXRh2uhFuF2D2ZlB3uvVzpZdJdu80EI/6JYna2Ph?=
 =?us-ascii?Q?MI5OpMNP+TlIMWdfAGEVp0KS3LzJ5T1Oy10LXkVBp1EuckQQj3y2dcQauhM6?=
 =?us-ascii?Q?eDigxM0vt4/MuoFEhC4jYx17p7FRW6DDkE+F1RSqiECEaM4OESil4tGCyaMY?=
 =?us-ascii?Q?Nu/4GcwzGANoFUzMfMMu1E9YvBkwHnzDyJOnRNsKThvU+zTrisyKK1sRYheQ?=
 =?us-ascii?Q?58U2x1sg56ptbr8pXJBLkN5w0vh1qEHeq9WWn/W0laNmPKhqGrWr5MTnx5Ns?=
 =?us-ascii?Q?IEW8YCqfM5eulvVzMzd8qsBy4VxBtiE2JfVuWj2OGCB+JTrrcYWdrq2LkrW5?=
 =?us-ascii?Q?SQE1heoq39ps7LUWlVL6rj4STkmHM9sRVbwICDpV/X0dLThYDOx7gJVDrD3l?=
 =?us-ascii?Q?boDPZuhuxxQSHmRuEAq0kOtTTgC86G1EG5JxqSLC0CPSa5jvRZCpHbx52hob?=
 =?us-ascii?Q?vbkIE0cOyDNYcq2UtbvSKiy9vTfkpmipdNEc2uvOXrD5AaDVGgA/1wZQnyG8?=
 =?us-ascii?Q?SmQ3DoDI9swQVnpguw6ud6tbK1x3ZjWVCSl14IrHhBo4vNoR/bEbMW16N34E?=
 =?us-ascii?Q?wg0s9eLPAwFxVB93qAf54/x75M0mzhIA71HBETIc7AaxB7qJ1vyjrF35n8Qa?=
 =?us-ascii?Q?uip+B/sQl0XqaVKJzCLOOZyXbSSEMK0onX/7rFaazNkQhtTbAd3qTesvv0ou?=
 =?us-ascii?Q?H0rPkiEHVpt4u5xkW17x1Zuu/xbDkmUaqp/0m/AVNK0/te3/iruAu5D7CpLq?=
 =?us-ascii?Q?EL92j4YLS/6Z6CJUvetcUehgCUp6VN/jQdObarsU2FLAgZ1vmhuLck8Xkgjx?=
 =?us-ascii?Q?1QVEorHKuDabeqSZd+exONA7qLeRbMaA/oEUZMlQvENoSlh6Tfh2tO+9KMLo?=
 =?us-ascii?Q?licpmSchpzfk6J+y2xpvskmPwSdFr4ufFJLnFh0eGG8wTDruOLc6iRtzhk9v?=
 =?us-ascii?Q?r+PqBr318Lpsh+P0omPddOajcmajbaRLlXTNSEoZAzwtyBc7hujGCyI+aK9h?=
 =?us-ascii?Q?Wcol2Ie4OM44lHQ/6Bryw8Um43wOjiZLRnIA1WiBSyKqeb8LUoMpU4xkZKO7?=
 =?us-ascii?Q?WZykEUjYT8dvuWV49YGrI2c1QY+vybkel9qBZnxMQ3TOX4J9BxE04AqDQOgM?=
 =?us-ascii?Q?mfB4mdqh4Sda6+xT+r6Kav5DtQcnF7dNQCIBP6a3EciXaL1eaaIeHVUJeq66?=
 =?us-ascii?Q?yEOk5r0GXZ0j3RsRE13fSjbAnTxCjfgazIOeBeNq1Ym/IPoodaJOsbV//si4?=
 =?us-ascii?Q?nCtBm9D4C1VqR6kt3/DRBf6SM6Gj3MzJdNMr+sgbm4Ca9OszxBviz74jvAHt?=
 =?us-ascii?Q?Rim4cQLc9wbgdn8BMqt15kXjMyf8qyob2Bvh9y4YPF3xipqBVj3pqsQFCZ+Z?=
 =?us-ascii?Q?Nw+Kyu0MUl9AaCbK22gGc5lrUCnR9UqilUC8LWl7IbqFZPqKqeDwm1xAi1rV?=
 =?us-ascii?Q?XDExYhqUVTuS1dT8pTjOVNfCjBsID4P4peKq6JNEH067sONkAc0xdVnn0ywU?=
 =?us-ascii?Q?+Lkd0fcPn0Q3K3ttULUVX6Af5uGafL0C1Wp7JlGHMutEJu0Vf5lVrx68QlbS?=
 =?us-ascii?Q?u4YgMTzhfL3jCziR9DQf6/wB9YL1LIA1cXww0cq4i9e5sY7zGnVZKjtn2U4W?=
 =?us-ascii?Q?S6cVasT5GOiB58pvLOOo5br9PcqoH2Fo8k9LtkmK7kvkiAJW9jtCKONpN5+w?=
 =?us-ascii?Q?SiBfh0iBox1X/X6+3It2SKHAtMegnwGqmmvyr5JN6/YXeIr6PCZrNevvpucG?=
 =?us-ascii?Q?VmXWJtuzziZNb/bJgQRDFjPLCkFXib8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a061c2a-5fb6-42d0-232a-08da2b7a8e13
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:57:39.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0/c6n0a/wWJajItmWlqaM+qp4fogGurF3naRW6QOIMdq88ynxci8rKcUTJLgnplGkgt1w9a0QSa0rBFnBSN8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  6 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 45 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 1f991ff2e325..8ce5b1603962 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -30,10 +30,16 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
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
index 000000000000..3619bd622b94
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,45 @@
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
+void BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D msk->first;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++) {
+		subflow =3D data->array[i];
+		if (subflow->tcp_sock !=3D msk->last_snd) {
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+
+	data->sock =3D ssk;
+	data->call_again =3D 0;
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

