Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2F28E6
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654526537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SsBCKaGSnSib8yKzRg7exL65wED8f+Ur/LUxp2VQOk=;
	b=bLP5+vWU/q8o/fcPhMCra49+lLj88Wq2frbGlNJUdVaJ2OWSrYC917JzN6CIf0evNBEDM7
	fQLHgNODpAaxAk1W4yIlv3Y6AKmIDwnU9lL6yZg+es3bXB+lsXDppfKsdRRtLoffhorde4
	WQxX5dzUHL8ypjI05aF6ZEabDWdzR+0=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-CGnik2giPqytLI-vFGKHSQ-1; Mon, 06 Jun 2022 16:42:17 +0200
X-MC-Unique: CGnik2giPqytLI-vFGKHSQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku/JNs521udC6emg3SydwIe1VLbIbAhLaofipNTlZKQ3aTPhNcK9bPR5yi6ivpPfWnooGcqY7bxxpHoJ4O+dppkHuuaKlNFOCeHYq9slatSTHqq8bGVhTckBxJwizG6O20AZWeXo/wVJW/sHUSxozQT+c239+QxN5/ZZ8lDXi9ucxOjVpgQcNPExm16NrnJcXDeYjQMPvQVnaWg5sQt6eitAlaz7E7sXEkPTn1QEh+owmyKTekGFOc0qFB5lFjdeObdidgZYnASQcD46v7ZeAfZsx4W85SRCqUlq1pLsHZNNzx/nGLVfmNJh9FlmMYnM19bBeHrLmcAJDfeibPSYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP3UBW9MaHYoUECvpYCXr/Jf/GWdIt6ZXQXJmbYnsTE=;
 b=iUz01iZDiSffIhIbHPFo3x8GPAHIFn8ke/pwWqaET2FtxWCpqV4OgsKhwEnX5HIbbQ9rOSFOCD3yX4LtoFVTb0b/QEVv0aWMAqF2TKo1gz/xhW1PIJMheXAmLUXhDsbHaxlgjDA+FaX295EBPtFOFe8k+MfoD2tzybvZrhr1/7cwoLawFZHgV85wQu1t6Se4Dy8JAkbufmTrs9L/3FvDPERaomETLkWZgNqg7AFYsBirxDW3iKnmcl+JdoYTAjaEqnJlUeR1V8zbL8asOVjD0RPpCUd/MvdHntsII1WE/nfi6OlQPYWdt0d0rDpsKbrq1IQXSqKECrMlGlNGcJ1Hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3364.eurprd04.prod.outlook.com (2603:10a6:208:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:42:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:42:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 6/7] selftests/bpf: Add bpf_red scheduler
Date: Mon,  6 Jun 2022 22:41:21 +0800
Message-ID: <1deb3cdb95a1e4e274fee02bb01298cf617abb67.1654526068.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654526068.git.geliang.tang@suse.com>
References: <cover.1654526068.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75616a9a-8159-4df9-5bab-08da47cac01a
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3364:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3364F0650ADE9313CDC07B35F8A29@AM0PR0402MB3364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XOqDOOfdsJ+3aVdkT2FRptOTcyND3DYmGJtww4ee3uX8xaw9jPy8OYZL3v2nFCPDN1bkt+8Dk0T2cU8i0RKhWUo/SavwOE9NrLKnkM1YgZUEtQ0S7DqDN6L9N0dk6zVhY5qOs8iStRo/5dTTqs9t7tzpXnAGQHmggMVh1RE2bV1/rp/1gcU4CKMTALkxBHyUr7jK2DLJ0S3ds+gWkc57dlw7wiOt/9nJKcY+0tcEhYGW16+1OVJyxuSYCM8Eo95eG/5F4Q/JR4hT5oIY/pqZTxPt00B+wlDT20g4MTA4EwlQmLYpW006v8fLc84EA6fwlZ6FxAogK6NjN31OYJEUU3Cnp6JdtwMVtLbk1xGgyUeskk4D16mBVlr5mEvkQuiNqNHz223kmumYFLZjFHlzqCTKKBc6E1cwHvtIfx9WH2UDp+685BwKdcbuCmfiY/1u6H/DDfucuIbXhwKyvz54+cMfueGB1CrxDo0iNKA6FtftL/4yqPgKC13Oj/s3GBr+tHPMtCPhvl/SFAkFyOtNNQ8xu//XYi9cLEJ5PcPTJ17T51S3U8RZ2QXUF4ejz9UcDcigwZKoHG1HifU4YNkmYZW9myG9u97uEMdJOXRPRcXsocNcaYnlKJw7yTfmvz/4ULAko9i/Yt9nFG18xuQ3q/suCOE+Jeyg+4JfOuo7vBIQyyhgb+Cg7P208Z6lGUPAtX4AeWuxy6tXfI+VhYcI/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(36756003)(8936002)(66476007)(38100700002)(107886003)(26005)(316002)(66946007)(5660300002)(6512007)(4326008)(66556008)(8676002)(44832011)(6506007)(6666004)(2616005)(508600001)(6486002)(186003)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eonerbmo5/0w9mHRtS0cIyyAajbIEnWlvr6LrKlwSnCj39CUj8MQsJCaA3zP?=
 =?us-ascii?Q?pmw11hQP9qZt1aMhTIC7yvoywlNRODSYG1POyCA/xZLHF0VgXOen+G0yMXrt?=
 =?us-ascii?Q?rhbwCgFgHVO5zbUKDVGTfOZj2FbhhmM/BFQUM24T4vdKYHLFDwY4okIvqZ8g?=
 =?us-ascii?Q?ruhSdvopb7s9AVAhNTkHNbPRVKXhkmzHEweH0LOQmuBd1F3EMJWD/mEp8OY+?=
 =?us-ascii?Q?0xFroTKR0ow+Vjr7daX3Zc0WR3YMdcf24sSiqEoh2+EmPhifP6h1JnI+UpyU?=
 =?us-ascii?Q?CbJ+oQN0lvZMddysLwuS5buK1JLF5xgqzOTkXj30eqwtIU1ixUJlT485lk3o?=
 =?us-ascii?Q?V0XB0XlmYkwOlCGUuFWNy/+zD/RKo/pbt1qwbl/3dhy2h8zsxpl84jgVhY9K?=
 =?us-ascii?Q?HtGpTRb5v8RItmuPQNn6r3B4OkdO1zKJPTqQ1F/IR6TJVwuyt9KtMl3Yx5Lt?=
 =?us-ascii?Q?20t7MIUo2tEHBGRXbIO91qqLCIeIkS8Rvq1gArhdrnBY6dqGW22rc+Pn4rm/?=
 =?us-ascii?Q?+McPiQevZIiOXY3a4Yvlh15eTdXdWS9QgzeCxDw07KhKopFt3/E4aFuQkNKC?=
 =?us-ascii?Q?eceIT9gtjxSRb8nSPpMmpgFvhp42aSBXbMvidasMDpWNkdsMoqoFn+aZFdJo?=
 =?us-ascii?Q?nhb67HaSLDELKE2+kDr3ArXIk70mQpU/OxwL7DYTLGe28pcG505tC3W6trNJ?=
 =?us-ascii?Q?WrFg88BM2ppf6pn78KgKnfUmr2m6M7KnPcHB1qbJhyCROc0sufsFq9toyssV?=
 =?us-ascii?Q?XjCqNQo+84d9ksWTv5zxSKYMHLj1eVRV2q+lfuHC/E17Iuoip9QZtSuAxIOr?=
 =?us-ascii?Q?5JxiKESte8kiOWr630gOzn/i8UanykyuA71WJcYz+qTSq8DbouSPwdy9GDv3?=
 =?us-ascii?Q?kH0prfkikBpt08F43FKmK+Rbnpkng6GeEzicHWloT0zlos22Yyn44hperE9E?=
 =?us-ascii?Q?7BlfMbraDlVBkqRJkxEM9bc8REDgqmhGq9lxtNW1Yq/ME+Qkv7ja0LpvurxW?=
 =?us-ascii?Q?146gmiKYCggJaeV5bFNt6AUBcWOrU9iEdK313bsEDJk88HWoQ5896VF6nRNW?=
 =?us-ascii?Q?vf74/137z2lFtyNKpVYuK/tzEB/g2kGqD29UYmjySgyhNk6RNYIoRZ5K16MG?=
 =?us-ascii?Q?gaW0DNHad2ayyEp2eAw+Fl+vnWSvolItNoeoy3ONTug90ZVTYgDg1v8fXC3t?=
 =?us-ascii?Q?+Yo/5eu8K6oRHNNbJcOnqxpAIHNFiqZlx9ufS3v7IDdOD6Ze+9y7GAakK5oX?=
 =?us-ascii?Q?OKjzKkrECW3BgBJNPW32+ZTk6i7MmnOFwWYeV2F8o6BLEeCZgY1DvAlsPW0i?=
 =?us-ascii?Q?jC8q5B8gN6SLwEuKFUeTdqwM5PEipbQPKBaQI5h0ENvAJFU0iH3375fiu+A9?=
 =?us-ascii?Q?clbHx2QSlRSMnz1aPdio3wUAmQf5RrlJSFfIluklfEwmUPaTICebGyDL5h+d?=
 =?us-ascii?Q?38E3JutFYds4lPGBRgnTqy+F12EOfmL5FhpVzgsbGnZIaGlwj8E8MvSN6eQk?=
 =?us-ascii?Q?33PJUgmrhv44ptyjSp0QV1N5sy/KVvz+eyAPA0eKoLExs1DeD2Bu8BOpXOwT?=
 =?us-ascii?Q?h782W5qZDlbCsv+TKdQixn3wUf9MlU1P/ZhZx5ySPGrCTP/KfjVDUj03a291?=
 =?us-ascii?Q?J3nbRgfO+l+a7ILW1g//C49vWgxYBt6C/Ym2N13i/vUqutSA2NDH82hRQKNK?=
 =?us-ascii?Q?Q7Zlyv1GUEd26goERu8LT/bOp61+lL9qMaQOFuN/Aay8DC4ZFpnLmhtnweKw?=
 =?us-ascii?Q?JVchfkfme/imIim/YtAbd5MuJlKWVYE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75616a9a-8159-4df9-5bab-08da47cac01a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:42:15.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2aaa5kHsFGkDEUK42qffSZPB9ElZDU2fSnB+RoFziuYJXvInkpFP4PQ16/wFnvlMvR5qQIc2npV8J3ZmDrwcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3364

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/test=
ing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..58f90473e495
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_red_init")
+void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_red_release")
+void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red =3D {
+	.init		=3D (void *)mptcp_sched_red_init,
+	.release	=3D (void *)mptcp_sched_red_release,
+	.get_subflow	=3D (void *)bpf_red_get_subflow,
+	.name		=3D "bpf_red",
+};
--=20
2.34.1

