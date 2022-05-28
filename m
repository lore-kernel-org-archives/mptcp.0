Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D728E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuYozgaddlDeSE55A0pVmL81JMQS4al7vBycEmSzRAM=;
	b=PziffSa6xh1pftGtMzjOuAcO5eaXyzqrmhuuwR0DElGdR5GAvI2qkZaCBZtLsDCgmOZFtv
	/LsEjynH7sJh7hvuUBXPOXa1nAd57CLSbQTdZUNGzGnklfRahyUPMR0X3/NqItvANjjl8M
	BWz1OZRne/Gb9v5/PLeR0DcaQ8Tbmk4=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-jImyJdJpNDCHdSXX5FUi1g-1; Sat, 28 May 2022 17:12:44 +0200
X-MC-Unique: jImyJdJpNDCHdSXX5FUi1g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5y3k0uJEW5mLhVGao5TTefJNXksNOZGpzUn5NEbzfach2Xr1UA3n/vsfxkwNA+/vV17V40laTvQ6ZD+oNM6pgHLKfXG3PEtH1wfHzZIBlvrgOV0FIK6wQMPaqJnMFiESt5cGkt9qJaMj8F274rD7VfsVe6u0MGr62ciJ5lQ7wLmNKwQ9yJQc04/nkoYn2PJnfHQ4kPY4RAXWy58eh/Qa9PGwAiJkX+zd/SUqB7tFlnOvLz1QeuxX+kM7Lx8iBva+UEKFkuhNrjJBLrn8++KVX/8dagMGT1onz1u+XxGQ17x9KeR/sftYCrHAXS9j2SEoG9OV0goOj6ZbDthLpFVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wy6I4VYR69C5bQkC3b8AKqFY4DGCwPTwFI/0hBFcvWs=;
 b=bpNldK9kN6sOiryOiM3QM+DToT7BfnTdzBkqth7d8iKiLFdQ1Wf/mHzLLcnqG2BSRkdHHIzaPvLK4KHTlHNbBRTxygctwhOBDac/Vdy0eKCohQfeRaJknkNpFfwGVm499MXXDDakWwLbae/A/Mp/QdnNnQNg6s9v5WcUc4Lw7j2pJ3HTO1docmlkOKHJnEBcQMzJm2BJ6zhY5Ct9poqoXf95o7mkVd4yChG9xOMH3HBLsk8rK028qi6W57kljgo45kGXS0d2WGLPJ4bv/NYGqlN08Sm/RxeuWKWjZ1r4Y3WaiUT8AJRO2I/RJCS6jeGkMakCp022l9V7zNYks0fZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:12:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:12:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 07/10] selftests/bpf: add bpf_backup scheduler
Date: Sat, 28 May 2022 23:11:49 +0800
Message-ID: <b9ddbc1da9d1769e42f19118a3bb07c280f1da67.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3473ec18-8859-4105-3ca8-08da40bc83e3
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB848523FDA422E518D20B6474F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UaoDme+IWUH4DX89c2liMMGB3OIsV4AW3IzNnyGQH2dqLZ7WearW/nfP6grkMgIgzo8wFk5SAl3uq4AsenRBnylS+anB3U+B0XC3K3hLq/k3zTEbwNijCHXkh1JK5Omt6tcZpbWo899QYJe8al5K7RcrBLkxby0+G5fY70pn3ywiWaUxCBSmj9h5ZxYh2xnhpsUMf0Sx97A1pye54AudklVgkb0ToD6JNUn3QLJC//560VK4inzbA4POww0seXmZSv9GZDbT857xm4ozSdSphIcD+h257QI3Qj/SMHXslmc7SnU6dlbcyRbxIJ4AmN2X3WepC8UUb9UaKkD4/cYwWOYpSBxunyeiP0ZQ+TQhbDwPdaGmvgk6V1cwXkBolivKXY//ffbA1fR/FOgOJbP3/jdukM1uC+X0gXg8lE/whQdjohLRp/mcwM8djrzqHnr0NVH8DyJNKOLoovNMkayQnnOcSVcNrfD7h0I/iLe49St96MoaHsqPm5A1++RWPiTxTTbGkIQgI1dfRsL4nEyoVWe6I/v2qGM6Be1K2pGd+rg1RbzMSHgzQ6FVDzCgTnCk9W9zY8nXih/6WITy3l1C4UUAnEnoNK4G1uwucIx08gbRIYHdBkMZCo+D2yQdhwbcG9LXK26SlfcnIQtNAKvtkmTvDwLtzEGi1X6Rph+bLKbvbuu4gDLOd/LYNTnDaUp2vflH2oW13UkDRwuKUZXhsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v7FcSPPEfNcIz+qwiNUPH3bwmyiEKf52B0lbYLMlC4B60ojGl7UnAy0eQqc0?=
 =?us-ascii?Q?SHsL2dI1neg9qZFBGJ0shZ2AFMtL1yKC7unuUL8riK2IKvfj7gulfZQutwqp?=
 =?us-ascii?Q?hyO2GDUSVa62gtt9HfEMNJp6zEFLN6ScNc3gMU0y8j2tytSkfajfyKkYt75b?=
 =?us-ascii?Q?5BFtD3SRI3VzIDjvba8YpBI80/05C2KN3YrGJ1+IVzTlHxAIF6stwUNsnQqu?=
 =?us-ascii?Q?AUwl8RcBZY5RZ8IAyzcFPdgaz0aZ0trvfLkTBSld8GuoOemR0ebpIeXUQsKd?=
 =?us-ascii?Q?RXpE9hp76dd1xBkYEyAP/SMQKa17tcifA4X13zbnTKx48syhfT7jzXKKiw7N?=
 =?us-ascii?Q?CDvwY37dGctXU9EOo2zZM0Niyr8VtuFS/idoID3JtoMiueM3hhQ716eYbabK?=
 =?us-ascii?Q?eJNzFkP7l8EM7Y1gw1d/oW/47sadYpXfOt2vx89ZMZ7NXEUQDC0sSy8XFpkI?=
 =?us-ascii?Q?TC4W1MQd2Tm4KOEbTc6XP6kdIZccUPWlQvo8p/gKQLmY+RBxMWS6g1Sr2n+n?=
 =?us-ascii?Q?qmtcWi46WxobrTRGetrMUuuJLJ7dlKUqk0jYzYg5bbkPSpIpNWaU4tF4BpQb?=
 =?us-ascii?Q?I00So3w66akyAxYVffnyJWEr0W3weiO3HlRmxg2xj2/8WMHNu6zEFT/Vg6wU?=
 =?us-ascii?Q?+rdfSPzWtJgMvBV7aIAVIy9C862tHGBs5M1JilezTpfOfHYNbYuGLB6VoLtn?=
 =?us-ascii?Q?juPqUvEtxnPZ3zlXdeGJyfJRSOJ/P0zE6eSqu5GkQX6Yfjs9Hz6tLiuFRmHe?=
 =?us-ascii?Q?cFGAvsU6W3RnDOKKloV721ZQz99OmahYvCsoNV67RKecG46nujb9LEWaeEV/?=
 =?us-ascii?Q?5AcOHpJeIK+U73UFXNCAFEAXH2s7odxpqdoVMPYUUot3j216Uf0ye0AAk3K4?=
 =?us-ascii?Q?H9lr5ecQORsilzCASYnYGqJ6j1fqWondhCOPzfpPiWpUzUEdyuCknhIeMDgI?=
 =?us-ascii?Q?o5TUMF+A5PXQJ4c47ALnFlDprtXY9rWQSd6JN6Ev4x/NqB5nVVfegAeS5xl7?=
 =?us-ascii?Q?p3Hlx78PDJfEHZ8DJWUNRTR3POLgeT/VQoVp+Q2LcDYNF8+5AQOpBcP0HriL?=
 =?us-ascii?Q?fGIJBCz40J9UQFsQ25stJZFv5Z5gKMnlueQkXF5I8BtrvX2Q57QwPRAxLwka?=
 =?us-ascii?Q?2kJ9FoKTmUu6W7vx4ADwGSBElEZjvrN0jCm8I9mperQDG400RS312nRKF7Ul?=
 =?us-ascii?Q?ThOHWD1TdJx7OSUKvoU2I9jsgx7KRmUmxu8tXw2c6fRCWXyyo3aXACE2d94O?=
 =?us-ascii?Q?xuzTLGgKbVukA4W79PiimhfXyXjppri6H8q2RH9KyxJpncheflmdPRCy4ImF?=
 =?us-ascii?Q?Wzl8XOKbEBeqSMTsTRTIwbFow+5SHZQbeJdQQR8MJYiq0vihbYeCkziYMAj2?=
 =?us-ascii?Q?X9KDWQQRUyMJfFSFv66NxJWuIRgsbEUsfqh49cFVSPTpRrnkcm/E4jjFyYq8?=
 =?us-ascii?Q?3LjAMJzGY4DFen6kGv+6Y6cT4cF9HbfJjVJZXLT6n3BslyYty4/p7hWa5j2Y?=
 =?us-ascii?Q?rGRvxYTXpzysda9If70yQorqxCNlxWwLXBkYQOlYK1q4pbwcSL2DMBFL7Xo8?=
 =?us-ascii?Q?AhMdLhl9YkR7tknp29+SklS86qOIhS1BhY/TS6VavHbUelxkEytPW65irXUl?=
 =?us-ascii?Q?suSkE5Oln94sfSGoSC5BAEzGWnzFptwpnsvliagzEDiACELhZXv3IJ+DN7I7?=
 =?us-ascii?Q?cwq6Z3lPM+EZpyWdWglTGAWjmiEPa5QhNwDatJEXO9HzzsZHxZ9WGlNDkVxT?=
 =?us-ascii?Q?OgfjDun4a7R6TR2mjCJLKco/Lm32pBU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3473ec18-8859-4105-3ca8-08da40bc83e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:12:43.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB++mNwa6DPuH3iAaF4gFg4B795jUFNfylw2hKdyfsfSqzNmHrca8u8Rv1/d9iC4lZz47jqyTxUAEbDFIffXig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

This patch implements the backup flag test scheduler, named bpf_backup,
which picks the first non-backup subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  2 +
 .../selftests/bpf/progs/mptcp_bpf_backup.c    | 43 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_backup.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 988dbeeac040..1b9dd8865ae2 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -235,6 +235,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u3=
2 w, __u32 acked) __ksym;
=20
 struct mptcp_subflow_context {
 	__u32	token;
+	__u32	padding : 12,
+		backup : 1;
 } __attribute__((preserve_access_index));
=20
 struct mptcp_sched_subflow {
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_backup.c b/tools/t=
esting/selftests/bpf/progs/mptcp_bpf_backup.c
new file mode 100644
index 000000000000..4f394e971c03
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_backup.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_backup_init")
+void BPF_PROG(mptcp_sched_backup_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_backup_release")
+void BPF_PROG(mptcp_sched_backup_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_backup_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	int nr =3D 0;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->subflows[i].context)
+			break;
+
+		if (!data->subflows[i].context->backup) {
+			nr =3D i;
+			break;
+		}
+	}
+
+	data->subflows[nr].is_scheduled =3D 1;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops backup =3D {
+	.init		=3D (void *)mptcp_sched_backup_init,
+	.release	=3D (void *)mptcp_sched_backup_release,
+	.get_subflow	=3D (void *)bpf_backup_get_subflow,
+	.name		=3D "bpf_backup",
+};
--=20
2.34.1

