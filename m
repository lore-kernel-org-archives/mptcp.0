Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C923CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzEHHHPY6a3ZkwKqcOteI6WqGZbRSpRM6WEo32JhAIU=;
	b=MSMGftbMELoP2OTZ60yxGSOCY/Y8ICOcAjVJYX3tCOcJ3KyvbnQv1UNCaWNffGgQD8+1cb
	4JyXi9mHp4HQ0b5HkzsYgYpTiYPf7BtICzKgHhA2kNsg7unQM+YwKEjuySoh0am0qbaIVv
	IoBz+dsjtXjNmfu6RrtEIJ3oU0zbr2A=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-RcVITpnQNzyy49wruWj6wg-1; Fri, 22 Apr 2022 09:47:17 +0200
X-MC-Unique: RcVITpnQNzyy49wruWj6wg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmCRYnRMUOIGl9Z+LruIbL3s8I5t79m3GvaUkJ/jHhJNQJ2Tqhw0hptp7qWpNMdeRQiIGQgO/+NoTB7a//rGyGv07vJnCi4sev5O2Tdh0L4Wx1uXritw2Uz30x+BbSHbezRyEnnHch5QfoPBFKxuKJVT6Du4LjJfUHsNjOcCFZi+kT8Mj+yFk8vKR1mjNHO71Ci5aPih1vBmOWLnp2ibho7xAt/b2LMAdIGJEDyiR2WVwIQtpYF6WbsB96ylqdx6UWNLWesTVaYNs4QcAvbO87GYFjEECQhZXLHdXv0hEM0/eGrDlk2a8CpIsmgtD9W0Ilgm3xlmE7xh3PRLy22QlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqEaaqnZAQmdF/p9sK715eR313hQ4/ucIYY7cdHcR1I=;
 b=WX97WbkzsE53+65fj7qdj6Vor16HRSg33VEIdbjMJJMf+ohoq1W1nwOsmq9Msuiv+C6cnuAH/ea4UBXDlnQI4OwNcxG3xHsOJGMw0SYCAmEzoJbOziok7x5CzpCl2fxopjuqjokUVe0xyFSi36uxC5Frwyjaz5EbCwq02ALr2QDWULZjEUe9rC7eTtDvDzqzjYgzzNEhpaLx6/TIRyfIV8lRI1k9OI/kju0QTPVmW3kg1KCRJAmgE6LyBc71X9LuX3bh2hYW/KJRR1U3FEIcZ9DIDGPBtQOOS7E4Vn/e/xJFsswGx0asEgruFecLQumLxP22itwAHbKnuGRGHaNLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4899.eurprd04.prod.outlook.com (2603:10a6:208:c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:47:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:47:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 2/3] selftests: bpf: add bpf_rr scheduler
Date: Fri, 22 Apr 2022 15:47:15 +0800
Message-ID: <415971f575d0e2064797c831efe4e462690b0afb.1650613515.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613515.git.geliang.tang@suse.com>
References: <cover.1650613515.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f4d062a-e0bb-407c-4b1d-08da2434523d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4899:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB48990E36CD9D77D0F1C17213F8F79@AM0PR04MB4899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mEkIjjX2WJ8+X6FonYimdwf8iSQ0jmkh+G4TactrFjuhhsy76bTYNLF0P/scOsPEKYp/ilKP59F9j6XfsXapf+kODsIHnuDNwBI2D4XGCM+ft0jmOl8T4Ci1SIjZLURE1700TUiKCCGXsQlCX2woeDphmGoGo+cXrr7dTB2GhKtJ1FoHX5Ixm/Mf8G/XTtCPMN04Mh6vpLp9BK7LMkq4t4t1/iOuh/pZxrW04+/zWVJbuZguAIlFqU9jp3zghTrv2Vgrt02uDd5HS1yRGUNId6EimwlPfge/UAHT4CAx4CDyc9MmQMIwnqa1PU2OQSxpBBCQXx/AnaEO0cODVecnn5XxuVScJnsObEe5m0cz/WE4zzeQEnEU3KqNbqX1JDpKuC9MFaoik4KqKY5NphZvK3xXVeorCFedQ/l4246n+91hKJOAoArHla64gKaioZl+WIGpJ8haVpRu0IkbjXIzt3/rJYcAfnq3OTqznLltsOVkEDYM8Ji5GvjfnzrFszADG7xk1VlzTrNt3wossgAirWdCRRbwv8wErJWQ4xQUnPmTuegbHU0XXooLGPnwEbdRKuzYAgYG6PHAlFhNIW0A3DIJS353GL0KXdUMKPsY4CFdYu40TDA1cTTyn3Vcj2CR4c6hx5OpHEfWzc8Vdawk1ck9MUt43HMEXgbrbh8PLNSx7IQKFiGWFoGLZI98UgFWPHEGUWur9hFJUX21WAv41g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(508600001)(44832011)(107886003)(86362001)(66476007)(6916009)(4326008)(8676002)(66556008)(36756003)(66946007)(316002)(6506007)(5660300002)(38100700002)(8936002)(6512007)(26005)(6486002)(83380400001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ug6nPYVrIBR9bGJE49KaEhn5ENnTSBYT8T0zYPhO+Nxp6seUyt2BTdtjXeo?=
 =?us-ascii?Q?Db8m7NEyO0X8mwXmLvc75WyN01oXeqmEKq24KdZFrz8R7U+EqaT+to8pM2wR?=
 =?us-ascii?Q?4ZbBqzIFscsZjjfhjOg7oQdL5YvEBCiDXB9kn+kp3S9nbz52isVsX1FlpiaO?=
 =?us-ascii?Q?a7TFEkBwwO3ns77VMKMpKqs68nocP0zlnnsyNOCk3BSlD3MighykOdlIWa8d?=
 =?us-ascii?Q?Xa4PRpdhkm/1sBCvzZGf7W+dRXBYmwtKUgcZ9vgBfVahKz2UKcLUyTE2oUmO?=
 =?us-ascii?Q?2AM7FSCT56jjxbTOVXxsCK3F+tDS6iED687RK6LOkgwfyL3rkN5sujBnp2yJ?=
 =?us-ascii?Q?XwiI/td7MMq6v4NzBPe6nyFmZltD34niPwBJiq0a/KI/ct02LhXORrEE2+6v?=
 =?us-ascii?Q?ZJAr/4PySKzcDOV8gzvPrAsgBm4d96WwyDhhWlOTT52z1R4cS2JzyDfl2YS+?=
 =?us-ascii?Q?FPiV/dfdk0lYn9ot29TcOFk6rA+l79jxeZraVDU6zJneQSkmmizuiaQAKl27?=
 =?us-ascii?Q?PiB7Sg7n/DjylwLhFh0k4dZbyGxxgBtAwfSBDJLZdpmJVKId6MJMlS+fvDP3?=
 =?us-ascii?Q?k11uJtYCwcK7jP7abXv/aACxl9e3vwBagGqemPGeTKN/xsHiNnKtYwr5j/Zq?=
 =?us-ascii?Q?HZJQQXA0tB3fqaGIlBYp+cb5kfUKJQm6sNGg4DQPd8gP2eZDr1rHmsVtZVec?=
 =?us-ascii?Q?jDpD2qUX/+Q5yU5J+/g0awEveEkZfAT35HzNeHlB8kJdfceQJizvk3AuQPp4?=
 =?us-ascii?Q?sQdGz+mzsJtIMGaxcfydkOB5xdj4iVjeUN+a+ljk5ocV4Lh4HsfBKLh5xSOW?=
 =?us-ascii?Q?ysrKMUIpy/9J0v4QzQwU3UXzBx+japfWk5Gdnn+LbkttpCn+Hk1fC3SfO2F9?=
 =?us-ascii?Q?ZQfzAbcY/FvUFCb0oui6tJ9ZcKSuOY3fOb5v5EOAZwuLluZaF/5tXhK8EtZH?=
 =?us-ascii?Q?zEFTzTVi7yFsyD1wXPsiiMDpSYxoYTDp7vrsJspxxuV5nKJM1rQIiJWmNPw/?=
 =?us-ascii?Q?83nCGFvXdmtf0TJwSD/baX3j3HIuvFW2jIlMLqdvJ9349vnoqGByK1Pbk1KK?=
 =?us-ascii?Q?gVUPKCRFVzXH6cPdwCzUafT+74pyTe8BoreDlmH2/Pbz8OqIGyiPzBRuXTl6?=
 =?us-ascii?Q?N9lpSwVWRrEugjV5VmTywqgpN2mWLgSwlg0y8zr+cBkd6RGvITb/zLUNW+hR?=
 =?us-ascii?Q?FKdMcCztSiUMCCYIhU7eB6HTRWUWPYuuCGpPku3bbaYTVxUGEXT+F1lGnHMq?=
 =?us-ascii?Q?3sj0TC0GlkaZ/yoHB/FXHW5uHmM6rFMMPFt5n2hckaijvUSE0l9ZfTQ5XLlV?=
 =?us-ascii?Q?+i227a3smhh21OLcvFsXoXo2VaLxW91Ppz6UitZlS+Yi2MmCaeIpCMfbrLKW?=
 =?us-ascii?Q?oZH/DITguKCn6gpCrYK3hne13tAeVR/j43Ly26see5/Xqrt87789d7fsqvws?=
 =?us-ascii?Q?GH8MG33WUktS3ZtIRr1pScYwbdW/oZYNDv7B5gLrrBPCPfOzJnKJFiGj0Z/A?=
 =?us-ascii?Q?atjT7PI+0lUfWmVA9MZdSyhYvOuEovRHPbqhBWQCRj7G5varuMn7gSATK8Rg?=
 =?us-ascii?Q?IXn9oGnhqQ1/L+BiSDTqj2y99EQ/e1sz/G1zUGx+tXE0Nmg6tdRux1ooa7Uj?=
 =?us-ascii?Q?9vWpm9AZBjF2QxQYfb75UwZV9gOpOF5pLgyyGhCAFHKgEGQDolWXVMCNTh6v?=
 =?us-ascii?Q?oWQj3V0Kp9dA/4AQLU/lVM5hXqW5Ms9rt9UiSjXSk5gZ4vzj00Y0dAy5boQM?=
 =?us-ascii?Q?ZG6tBh/oCuaCvr4X6w+OJqZt+jM70v4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4d062a-e0bb-407c-4b1d-08da2434523d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:47:16.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbpgHtbfpeV4Wxz3N01dCGhz6jF4Hif93Vd4RYfvI01XZwFSh2wqhy4IZjQ2GF3ks+q1ZJfwgohjgm03W40bag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4899

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 13 +++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 55 +++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index a0b83fbe8133..f0e120dfe48d 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -27,10 +27,23 @@ struct mptcp_sched_ops {
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
index 000000000000..e68e3753fb4a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,55 @@
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
+void BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
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

