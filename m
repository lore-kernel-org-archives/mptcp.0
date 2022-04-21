Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A57A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dWZ8TyOk7AS7VsQ8o0D/Y9nAkmAK2FX4Qt2nYtJ1qE=;
	b=PteyXTesPUG1V/qh8T8tu2E8SfCN2Q+v2NHrgcPg4Ile+CH8iRtGyRqmf7JHqTzS/cnniB
	4sihoLnKxtP5B54/grLOTjDvO40vWF2cIP4WeGKApxIr/7g7cG5kOgPgYl+NqpWU0lB4z+
	DaC+biryU+pQrjSWy6HHHvORCv4HCJY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-cBUr0dF0O7q6Fn0La5K2RA-1; Thu, 21 Apr 2022 08:26:30 +0200
X-MC-Unique: cBUr0dF0O7q6Fn0La5K2RA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFuVQrW1jPQ+dHQy8qhpayWOlOEwN+0dw2JUHJZ+RQiT9qYRlOwSKZwIj81EYqY87kS0lkV57SJYBayOh7RrAC36SNfwjaq1Tfh7bz9Ry877b5pKlVLQRzImWfds+vLSibav8bulWKJEtZ+UH3dTXBTypNuehXrQVz1YfrxrWYjVL/fY7f0HRQNUeDPWlX305fVLeKQqvsmN7xcJ3rZCkLQMMeVOdtHjSGXrJVsyCEFGwkXQtH9LqwWaWlkmA0t3ekXOQu5PbrOX+axh2fKh3AA4Y53MVVnkTZp249LkGC1Q487XfqDgOgseJN8gDo72iTLvog5/mKk9JYumLG+drA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++VDcAdr+YZ5M2T9P5qPKgkif88yOkkf9t2AOFqFTv4=;
 b=fmWyOc8NRVVP8aPhKJ2c7bBHPC26pEUxBjPd1WVJ9u+h2Q/OuPFXNgH65SzY2ffZ4nruoew9dWUViD4A83AGsMems4vgZNhQwpvsQryTnpsmYB3IhRXCzvrITte3qeAsmmK38eeJ+AKcatXgr9lPQdfaoVcD1EHzZnURGH2zc4oFpM6TJRuGVlYxst5pjVUr/v7ZGLhmpK/GJ6ndArxkeaQ3LDO2X5+TIM6+ro9evBAvD04CROou+aR6nWjHCgT4nrEb6vJY6ScspSZ4YdN9GDcDhdzV92nLsLU98NAtvngLPmXpxbP3sskf8BoLZDeZT1nfRakpzbgkzJ1Sf52OKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 06:26:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:26:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 2/3] selftests: bpf: add bpf_rr scheduler
Date: Thu, 21 Apr 2022 14:26:33 +0800
Message-ID: <ceab2192b8f43b23400751d35d1f0a15847666a6.1650522297.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650522297.git.geliang.tang@suse.com>
References: <cover.1650522297.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f613904-ebaa-4416-7409-08da235fdef3
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4290C2CD808A82E991D4465AF8F49@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XtHyqScNMAZ25pqBOQuJaV0MW9EEjj0fFQTuXfORiSGoMJ1QUiyHPo6Cl7vuwZWqaVWsIeA5YSsX0dHpIO2Jys48F22uLrBy5G8tPMt4JSuzkfC+ut8hmM6uSrV3ur4+Txqj3JKBlQ/eZc2wsCiQzC/QN6UwIWi8oFucwV7p4jzCT3nt4g7ird5jPqxKFiwx1Tfey6jN2uBE9fG+ziaxUeMUqrxhwFOksNuUsKnhenuwTE0/5zFvzB0yW3MJoeLvcSW6+EStJH20gFzrhb11dxfHpvEfQ+QXJIJBXNoR3QmOxrWiwHPBEqZjiLY68D5ji6im3wQUkR9keFl/7OGvXN26ShPLnlR/CeqXn0Dxr6cvshJJWTqLGk4clHs/+S1sIexQ7GZ68WYn5Uy6JhSLvniWCv7JymdQ2x2aNL7K8t8iFYPS315WvOlZ3vdZdfb2zfjsKn8bn6/iCk4syOYC5tTVvPS82gcW3NhhgPu4cbIwLAoQEHDZtg4uZ7XXb0LZzf1Yaa+y8jCMMlO+sBiMZ6svTfkcsapF0UqAWD+8ncC7oAR0c89VqIm5nREuA7JNAywAy90gTEbVe2D82mfM8eNUz7owrud6s5dHFVwiQaa9iN5lMr67/rthxpR6cBwbyQ3g+wIFadvAeBP39wv+chMyd9sQDsmIEGbulVPmGCjlgMo14ZcX2qZ8kSvjmym56QWoeoUw/M5UriQ6pnr6Ig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(8676002)(66556008)(66946007)(66476007)(316002)(6916009)(44832011)(6486002)(6506007)(508600001)(36756003)(6666004)(4326008)(83380400001)(86362001)(6512007)(2906002)(38100700002)(107886003)(26005)(2616005)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWzxXz5dR9xSn3UKmJHZa7kipMkLHefyw3ekq2Xg9kfHBKSI+4VZFWzbsBIn?=
 =?us-ascii?Q?uDrlV7QaPhRwyIjO82LHFEiRA7yH/6HNmye4b9+vJZOKOhEWCL9hMtnairnC?=
 =?us-ascii?Q?qG3I6hZoisndJjPrgfKbjXpZVFcuy930qOk4I6hhvjylbeE715lWTs18bt5Z?=
 =?us-ascii?Q?a4ZLPylkkldRQCMcwu3F1nG0b5BQocXbZNmfE99d3iUzadcx6ahJawuG2B4T?=
 =?us-ascii?Q?KmJnh5hB7JxwwZ929dvObt0bV/mnIkqpUTR8HMSC/PGJHxJROoOtmfOFrMI/?=
 =?us-ascii?Q?H70g2YUp04mo8tnzHJD9R2VlKalLjxAX7Jerlepm8wsnXOuAcNTPLIxWXUR4?=
 =?us-ascii?Q?YU21agYuxy0C88DJUZ/MS+Fb9OobsvafEK7uNyqBKoGxDXWwT+cUuWKQY52z?=
 =?us-ascii?Q?uauSFWFq98yXcJcPejtiUm/frwPB36EZQa8q3o+gY7EOqggw4vHVBg+LF9wR?=
 =?us-ascii?Q?D4U64Sb0+A5qzH0K6C/Cn0cRzYDZ8/kj5Sesy+MvpRDc/TUQxkxk0pwr4dq2?=
 =?us-ascii?Q?f3X4/4eZ5xp0YifnLvxc+G4xNk/W+RPS9bAb/3Y0spRbrWQyIjaTpXLN5Wp1?=
 =?us-ascii?Q?UhDwVGVZuVIs/Z2PNNTS2pelyCnQNkYgCF+1k9iOB5RphYNDbaj+alLoQ6Cu?=
 =?us-ascii?Q?LM5jM971WsR1br1w44EsjUNwJ88IyPq/mF3gfQdR48/u4y4W/0T0jAcD4zJU?=
 =?us-ascii?Q?3+v0bFxsrve58PnVe88CTvRmKoZyblFdUdyWucVqkR8L9CU4ACbF1UhZbVl/?=
 =?us-ascii?Q?BQXPPJAVJtGGfO/GVWQZDiqjlJFIaN8f2BHgq6Ydv/HE8zv1BPoIZrtevifq?=
 =?us-ascii?Q?ws5gZ5dvksCZElGzUCIQPFhy3ld1sRHLdU4QOS+hSeGA/uXVtuuLq+/EyboE?=
 =?us-ascii?Q?NqNhK3ZzgaubC5XGvv37NpHLAB6uZU7dfcQJDwBP5SS0wmyfTWthrMs7FvoR?=
 =?us-ascii?Q?WcfLjYsriLSduU8pdwZsJolx3u2wPIu5yMn5j5vhBQk3Iv98CftVfusUL9EN?=
 =?us-ascii?Q?4wIkM1BZAMujYFBo3DDLatM87jJJ6glgVk36HTkyC4TBGTA2ZDqMcJLiguY8?=
 =?us-ascii?Q?7ocJNBEpFgOFjEIGmxLxnxk3BIaEPw7LeO5tdL7j/QHStpn3PJdmGTm/0AKM?=
 =?us-ascii?Q?/ZLpEFj+38bpCOz0CDeG46MjUZytyM+r7SlpQiCg+suSCeb5a/4O+PaiIdr1?=
 =?us-ascii?Q?JTc4bOHnRzBEKw2/jd6lb6O3pNVupshqnmxPQe4L4WbGm13Km4rXDH9JaC+P?=
 =?us-ascii?Q?qc0bE/iH3uBu9qDDpr+TyMGDZE84f2VAE+eFD5Dq6PnSsFfafraRzE4fEHH4?=
 =?us-ascii?Q?ZIb60A0f0nnO2A48863WKJzFstldgF9+Wz51AKkC3LrLPYtTz/3Hlf6LIXay?=
 =?us-ascii?Q?2NaZaCWdKqux8+dAB9Es/Dx72qqZYNjRhY0t3JHItHh+E1vpQNF/EjxzVIkr?=
 =?us-ascii?Q?n+CDZJFVteZaqziUkr8NIpwfAMXz6kd8Y3nIQMKWB4VTDjKsNrsQVRyszYnF?=
 =?us-ascii?Q?8PYvyFEKC1BIlWcPQStekFvLNpVAVoZNcCdluzMvmGHWnizTpBWUjmHwZEmw?=
 =?us-ascii?Q?rvMPWSaIquFc8nLeb0mxs900Gdbwwnm1PS7mgeXwlgOVmT8O70nIC54JEWmS?=
 =?us-ascii?Q?n2fQjHa6BD+QwwaNuP5C4cFsutt63woMn8Zmn77Xz5Sico+VTvDr7OLhBR9t?=
 =?us-ascii?Q?5sYzgW7vD7G2G00hkd9sP/YTPmjro0OMTGVHNEWtnEK8bKk4/1a8oSSI3MaK?=
 =?us-ascii?Q?d6z/Tf57ghp3FxFtSdglpp+8CvyI/fE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f613904-ebaa-4416-7409-08da235fdef3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:26:29.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIcgzncTCxeMRP/YSeHFG7H2BDnsKPAKRqhlG12yEdP7zGRIAx4AkAURdQVYrknQjPcDE0G024pz2+TkFLiJGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290

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
index dacee63455f5..1301da334028 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -28,4 +28,16 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
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
index 000000000000..92820a6f0cdf
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
ol reinject)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflows_array *array;
+	struct sock *ssk =3D msk->first;
+
+	array =3D bpf_mptcp_get_subflows_array(msk);
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (i >=3D array->nr)
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
+	msk->call_me_again =3D 0;
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

