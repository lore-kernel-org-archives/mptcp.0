Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AECE1852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2R3aIfRF88N4fKuF7WMISdk28j88e6veR2C6sFhhHg=;
	b=L+j/cXZWK+4G8auI35ydEWWOfJ4NxuqTETkzJFPxfPNl/tgAkiHbgufGXkIg0Pd3f0dwDL
	j4I/NBA5sg50+1C0CBdCjIrb25ADs3qbBDEp9quwsTDLqsQxLZYS/lQXnBSkxU5aDoK9MG
	lwB9z+LkBhQlRZKLbS2KDZBhT0uG5dA=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2169.outbound.protection.outlook.com [104.47.51.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-YCtih7w6OgGfk8lVECFcNw-1; Wed, 18 May 2022 08:13:00 +0200
X-MC-Unique: YCtih7w6OgGfk8lVECFcNw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGaDGjFbYgP9s/36LV9aikHaBQbHcF3igdQkYuWjx3l9VZloqw8SYEXGKzWGbB/GH6Ux6tVmtOXYbknkPPEkgCKNj+UDsBkHyGj6J7bYLBhbIUYeeUDc67JwkmLeqIsxqqfDC2Dg/t1GkjDocn+4d2qgfTx7tw4UVq0C4WD3Vfom2nD7BCgq0l8ptvybakjJ+HdAM1E/Sl6qUOexS0GkCOTXkNEerXw/z4VW1BQz7vuaxF0zA0V6L0Lt4DzSNUG3EkkaTDIoN8ehdC4VrpowieR2qOBev2y+WnR9DPegG71TRVnTy9JYY/hvmoEuFU/Gv+5GRcYkfRbwwbhaykrzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOMM6qvB5KWBoElwhlSGobiSp1e0WnPwL2Y/XX1dHAg=;
 b=WqsyqaJfdkAVECV+WOy0GyqvflalraTe8aAaNdaLF7xynR+LTfADCMy68vw/8vflpOL6DqJtloZPlS8/OSKp2fIevVMFa9foVHer/cko+XOZn/QMnzDMMJ5+6UEpU278iiZoyXRnwIW3pp1fWTottIZjpfDSxcZRsE+l7lgk3xDW4/+f6Dl4nC00A9Ytl0iNP/XjCqo7ioH+wHZLy7PTQxFIYW6CAdc4oc3EZiKL11uUFYzNxQ7emEaEnynWIWlUNqY1nOuaXnZ0eeofCeM2sA0arrrbdozuQdbUqCzLdGwaALph+UuhCOjUq1nW6cZAu/vrSTolJOn9ItxcuScvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:12:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:12:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 16/17] selftests/bpf: add bpf_first scheduler
Date: Wed, 18 May 2022 14:10:54 +0800
Message-ID: <38e7693d9dc0cd06d03d0c1ccfec84180185e381.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0068.apcprd04.prod.outlook.com
 (2603:1096:202:15::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde4390c-605e-41c2-87b0-08da389574df
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB2584843BA7652CC378E11A31F8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2mWXx7h5vrhZ0r2aJloPBNzMfgwVM4A4SyXc9xPX3SNFkCU5rzS36ReuEn5tNJ5zCcO9uVyC1xM4GymGSuI42hpxOATfPzkfN7Qon+sGvuR74pfxyyB8+0q3GY7UWuUW4IJsCiI+dsW/hL7fOOma/vFNFtdll6iVeU+EehdD5Pe6S4aS1hY4VofZHyBGuHw5wZvkH8MPSApktZwbZe/pSnAGOYEh/20ybEYaCkja+Vt2D3yA1eO7GvmazZyVJ36K3092WI31dxv7EYr0lO4Y8HN3CDSzdJqik2K9ircmiuVYwJLhZ8moompd2gaLUdQwe4DkOHueEn5og1YIfUxS3S6o6Bt+qvQMqZuqNWtJkc/9PBepZK4It8XXgQBmOF70HbmMxzqvrMZK7k4VLsRQFhB6MirzG6QZQ23A/iDx4wVOGdSbQs74xwtFP6Sl3GSS6BfWDh1x8YwWM3KjnHgINWOoR7+YpC6KXoXBNecul1m50OWNQ+imBcOV18ARDvCTvoz01jPa9rOf2tbJHcnAeySeUswHs8QoJQaymCpr2+yzX9aHFJmi7U9girsZeqQTOLqraj22aF3FQFKTPA568QgCc0Z26K15voxb68cNnMm3D8oJBWplh9Lurg5ZavGWoHoCdMq58zQn45PxEI4Ku51sZcjoe+FgJ69YheU1sTKCZTaWo4d07lg7THR3PwWlrs2efKQ1djApBxTWtU2czg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(186003)(6506007)(6916009)(54906003)(6512007)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Te47eBb2t4YACqXdIK2tMCXC8g1hWjZWr02wH7eSQ2U9wqOfFHZtAah4Ma2P?=
 =?us-ascii?Q?wBbm0C+hwJLvitMKU8veGn2gKBeZ+1LCsEKIR1CVwyefw7x9e5QYveVp3qot?=
 =?us-ascii?Q?vZaLrfOMNDK8EgGRtvALJMukzk+fBlo1DICAtukER1GzlePNyZaj3nxRCu7i?=
 =?us-ascii?Q?JmMjLgtvuP3wPheIzPry5187glxc2IPMNOAUepUR55jEPDtAg0PtKqrfcfuR?=
 =?us-ascii?Q?nzEpGDZFUD2nann122wbUpDk4inbGDINXR+Qi68EANYECBOQDfBYYYkZ0c3Q?=
 =?us-ascii?Q?lNjcCbYWjpltykNu6iSVZJgKlb5QG6rpmXGEbShTbZM7ZApOYYz+eNXCz5LT?=
 =?us-ascii?Q?nEnIqFZDdzILwvlz21vFf53f29F3YB2ceblA91Gi+mqv/ZE31tlpyf+vL7JZ?=
 =?us-ascii?Q?sr4ma02uRB2jwF2X+/mzWw9rLsvsotbUeiWohswJLMg/3i5SKljeT12kfcVT?=
 =?us-ascii?Q?A7i+PAJsmNVmYmWFxRp0TnUITO0IWX/zKYAelPeLZ0OJxzx0cZBorbTGYGvH?=
 =?us-ascii?Q?IY1AGWhOuM2Wil8SSPIq6yTxVodfGl98oWf+F8xFGI41cjnJvXzqWSTiVZYD?=
 =?us-ascii?Q?7LHbSCOBthsfU4Icj+2IiwZjB2+JAz96+lLPp+R17ZIRBJNbeV1Oy5xGFo1X?=
 =?us-ascii?Q?HT7G39vTzfKCcPn3G725H4jIYVQrnh/9t+jnwk7ppVkpzZBZ3Bv30WukZFDz?=
 =?us-ascii?Q?ZWPsmU3x0RryPEkGoRFimer0Mt1MNQ5NeyJEDg022wO5BoBPzlBFwTADR6r5?=
 =?us-ascii?Q?57bZByl9o2adC5G2FCFxY5O+zdZ+lkdEM3xppfseSuxyFr8dYPVpcUKrYMCg?=
 =?us-ascii?Q?0r4VIUrC/t387t1Xx5JAwfHdqm+boLwohTKSHPXrXSr+Ai2A6ornvc7I6SAd?=
 =?us-ascii?Q?W/yYMBhQLBk7/ZNoWCHLjrrYWRWoWvYhk5oM0u0UJN+HrGyRRufaglPhneSs?=
 =?us-ascii?Q?+f1qAcjSb77Ha1QTnMpI/4i0L84pJO3oa4Y/B7b2MWIIYNu4FX/oJy/SFrzD?=
 =?us-ascii?Q?6P2Dg/Dv7oOKa+s1u0EoQmVF5sPUgxdeNl5hrzZN5q3ZsDTiNDB0Uny2myHk?=
 =?us-ascii?Q?JMrUVP4tP61xu/5mCftMHbkpYikBvvx9zbWBysP4MmjEhwRpL1drpL2WCBHD?=
 =?us-ascii?Q?xwNBidO731PaNCUBOQmhAHMu4Sso39maN5qbA5unGpkKUwdUt5CCU8128CK4?=
 =?us-ascii?Q?P6XUvl1nL7T9VFlKbefaOGjCEhtkxax/TTPd2Fn3Bx2yjTRJqrVSfbEij4rE?=
 =?us-ascii?Q?akUW/yXcLAXNBe0aW6PH2N4eEfXaKhYwi9SZiOghXrdOLXjODk4qZx9vx+pR?=
 =?us-ascii?Q?F6RmieGXTEnbA2AP5WpndbCwkHUjsn8JgNmb2LU/ejWfdCGpDUNI9a/eyhJ8?=
 =?us-ascii?Q?SK3t1KsRvbqTrkKaaScmaXHhUKxnfrWhRJOVKvzk7nHG+eUq5DgvkOdzxuSa?=
 =?us-ascii?Q?AjOU+BcMBXbLHfRI9TvV7ya/XDPsZtjJ6DvOfzQmDAqYeEDbd6R0Mhc3oyTd?=
 =?us-ascii?Q?C5LwkLkKFDX4nRhLm1a1KBMhTCcn82gwYeh7hZuvY8UVOFUkj7MTid2Yfp7h?=
 =?us-ascii?Q?319+0qZzulO8qDEcCYqcNU0xwXkgLoUiRwTB4RKZlO+fsWBXissXGAm0bDyZ?=
 =?us-ascii?Q?DBY+ZFIuZveR+Rhxm1Vr7U8RyZ51cnYB+IuI9SYL5fn1BnRyEZF78vcOmKzh?=
 =?us-ascii?Q?hmd5c/D5HZiz8c4IajBtkAK/QYgceUf41LIESY3U1sKSUNrSX4ptt/zdHaj1?=
 =?us-ascii?Q?p31ONUafjgw+RjwTtys64y3CQgdbFRA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde4390c-605e-41c2-87b0-08da389574df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:12:59.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMGMMAs+yUTNMUas5ynnO+8eylyqyp5PKPP1kIUBEDzz8DlMGXsx1Ij/w5nzRWam+1NAt7w0TVWq6i6FZ+b26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..fd67b5f42964
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_first_release")
+void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	data->sock =3D msk->first;
+	data->call_again =3D 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops first =3D {
+	.init		=3D (void *)mptcp_sched_first_init,
+	.release	=3D (void *)mptcp_sched_first_release,
+	.get_subflow	=3D (void *)bpf_first_get_subflow,
+	.name		=3D "bpf_first",
+};
--=20
2.34.1

