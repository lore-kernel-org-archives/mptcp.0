Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F70A7C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c5no2u9hSCHgi/+8GDvgIgvTXaalZ5cYGU636goZTg=;
	b=XHlsIrwTtzUOfJRFRs7+XkVPvHLKgQQIoHhl8PtAvuL8ahDQAKIHqtlbn9hFNlxtcOo3Zx
	8I5otkpq0a0A5YI7EdUmvV9IJpt7IfGzwSNBPhnJh0keelSae/n1g/ayaCHShM5zWOiKIK
	Yts7N7y5biRMHuAGMUzjMnIu7ryOg44=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-Ayx64HEzOzmgFTNoj8kJ1A-1; Mon, 28 Mar 2022 11:38:52 +0200
X-MC-Unique: Ayx64HEzOzmgFTNoj8kJ1A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1lYKIGIaQqxl4i2cFcBtzzejz2ANasndbpJU0E0+a6UF7iE9sTwyi4JbuB8H4dD96ToGz3b1Pi6ULxiEENqfCCEOk+ls6dQHn5Y96PG2gFCLrwP7imsOZxIaA+pcyj2oXdGL68oDs25b8PlWqkLpIyAHbqGV+LKp5s3zEZ74qFIK0o7Hm+G1EIa+PE3SpIurlhWpZEur874ohjyzbZ6zD8lHhtoqv9VKDKxhrEF+2Ua036akg/ptsXKzCO6euU9K0KxogqAJGUX2ly3u54J5RLridf0whe9psY/9DdPakonvqzJJnBNdWhA0AmnOsIa/LBdwDWeWy1mTXKXy12qeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15pvy6re1E9cvLf8VPgX7BMY/saIjVcz0po1hc1OmDY=;
 b=IA7I+8vCBdHipNmKSC1d/hLu0GJg+e9imC+bUJxANQvstinimtbDlIJX9XHCWMwkmw10MwbYzSXwOvQb3QU/qTERfs+8Xq/9aHFD4dTFumxY+CAX8NeX8tfSeM3qM13T53p9A2VSfVncy2RNBytbt7bZfRJGvaZBpGGt9B0RTuwSO4iRnc0F6+ipyOUsQFtRV+sv5pHz+KCUs2fOzpGyYEioQ12EwOKLyyLMjly1Mp6POPCbFDEpiB6XJoRf4BLDz6keghOn2bd2zSbQ6h6w9dcv/xzdqK63FH/pgMaZnX3BsgW7HgOansbdgtQ4+NyeHHO3jMy/AYux2VSk24YJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 7/8] selftests: bpf: add mptcp_bpf_first scheduler
Date: Mon, 28 Mar 2022 17:38:01 +0800
Message-ID: <cac0b1df66bccd2e8432fc9b24e1b4e7c56fc2cb.1648459866.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648459865.git.geliang.tang@suse.com>
References: <cover.1648459865.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf4a7cae-bfa9-46ef-e946-08da109ec423
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5067BAA6C38BF72B6BDCEDB3F81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EbmG4o8Xnw/UfeVJyeb9/9phbaSZxN8SLR+KP6bWdKQjwa8Ae4O8g97slP6HMna6RnC8ekOoD/7NFXJD9VBPXWHyhW6WtA8P/tiZmOq9nA5K7eAcmkpu0sjVd/D/TgGUufwRSaXw0yVK9r8i/6v7xdzyrZXf7x3MDHWnJkK/F5Jaj3vvdRb1igLDGD0CCxfbht2zdHEdpaRDtV6hoJWg7jgFo1R/OHmXcoZssOF0pu5Cwslv30eRd5o2i6qclXV6rx3vbVyte8hkHICpEr6O6OOB97B6MLRhBSYqy05A0Ta65QfnDHbqG/UVLfpBLsvYZLSGEpS1ImF9ZcErR7DioctPc7mHZu2HBh6OOtausevyP8j77bw7e5jHjdccJUP+qP3EdCPiGRsl1ok5hBB1wJguNrAPHDw7+aGfrsN2f9y720FwkN0Hbcrp/BRfSp6CqaxiKu40pSbrZozkgMy/RbBfA4O6VHeB6oSImIIggu4mUR/RJjHEf4ytP67jyf5JHCFHD02VXnnPNe+Z+Yrv70GPI3LVZkDmNStm8J9NnM7o070FDQM6VYhuWRSteZ4xxtE9t0P+ZHqSj5/BtlxtjX5I8Lw+h24Ss4fYa9dqRU/8cInCZNVWkmCAySmubu5jS4N5KLzcoX3IZWb9fmOVi6yYm591nbvZqdXI19eUDM7Oev2YFHhWqEPHTBbG7l2W+X64/iF39nPj9+omxIBjKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(8676002)(4326008)(6506007)(6512007)(508600001)(107886003)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GlbipZLyjhV4ojpzlrbhZLUdB39R2I2cmn5jz2yWXJxegYue56ShIjjByx8W?=
 =?us-ascii?Q?J2gG+QZQHTCTzCPYwdluGIQwVZPLbueWqQ4Oz/xINYRpmMEm0IVskngSn2JI?=
 =?us-ascii?Q?92AlX9NEAHOILe5lTZmQNe/alBjP6ptk44yFnNmo220nIeUSK8ZY+A0rcS2i?=
 =?us-ascii?Q?zmHOori9ROl0jAJwBEcM7cCpS66c5dT8kZC/ZQ6cRUwgXMOWv0hopqbUBwwh?=
 =?us-ascii?Q?l2yRF9rfhoMIgen+MurAaL1Iby/u3NXeILRpQt124ZRPRb97iPglhlfG7xVN?=
 =?us-ascii?Q?zp4pMlVG5keSRt6UVXN0K7GvbP1g8pneCN1oJHMuMDU699hLJ25IbkbRAPsC?=
 =?us-ascii?Q?iYkk8mTB4PfWq/0vqsXiE8Zr0ae8PyzpC5OhmBwDLXfxKQZzk+ShfQKIT3Eo?=
 =?us-ascii?Q?NWuD2t5G0bKAl+lP9gozFy1lRVaZjP1Q+2L/xknueg/pBDF6o2BuqPXeLq9T?=
 =?us-ascii?Q?YAzNAy7R5c9he9lAcOS4K2aKLuFZPZawM2Hk8t9BkTIfPvw7rzjkIOckKJRN?=
 =?us-ascii?Q?FALiXxajf6QdUtqskea7uDATLmUa5UuzdZHBE6VF2M3pDg7Plhcc6aKwHVgh?=
 =?us-ascii?Q?/defurEwCMpZxsPxBWcqAO6YM6H86aMj5y9EKsOLgUYLK9LhiFwANqMqKerj?=
 =?us-ascii?Q?mJRv4Rg/9JtqiFzOFTAobpUj65XnRnnWJX5sgcfSUBGhHiFcJeqUQd3y69EF?=
 =?us-ascii?Q?Uu27Y7ly13fNbI7eNAFL3IL2mIY346GZnvAOjXNGA2o89hafNHU9BraIGtfG?=
 =?us-ascii?Q?i15dSdWieck1V0DGd9KuHGxc5jYQ7tBiAVSMRI/PgLSgBxFap4BUXVD6yllS?=
 =?us-ascii?Q?j580MKShPv6BWLJAHhhRl4gmSaVHdWza6rA4w6k2Zm/PVzS2JqTX7vT0DNhK?=
 =?us-ascii?Q?jyOmI36YRlhYViqskJd68TIYDQeJygKQQfo6itoEQfz2JlZpDt36Yucjl3JN?=
 =?us-ascii?Q?Kx6jATfPjxnqkXmq4D79K1WRQPTxtmlzag9oByLitAHD9M0KdnJ1RvUacyrD?=
 =?us-ascii?Q?cegYKABPitU0cALFgSlAnKOEIC2RXt+C88EeTOufWUMso7fTdezNDZG2C17e?=
 =?us-ascii?Q?wuMx+hihvyV3v0ZU3sLlft76fu49ug0kqbxj/yzPnyx8lr8x0YjOZifnxpWe?=
 =?us-ascii?Q?aY1xAP6ZWMJh9E/gh5+rBskb70DyRY0h0FUOz9t9u4fqP1fg+6xmlAFHuAPL?=
 =?us-ascii?Q?g4eU1bp8w1vZiUROgCqMbDlHVjp1N0N47ZwSQ1qMawwsyoqIKGgF1rzzdXU/?=
 =?us-ascii?Q?LZj26POeVTZFdt6sp1avGMbL+pk37chPfvLCCz3QLs2Bm7k/gqIrfqkVZaiP?=
 =?us-ascii?Q?GKiVLgmtPt1YG8saveUPHR3bsJeQZ68/OLMv3G5ewtj/DLcN9XBl/ZuPnqo1?=
 =?us-ascii?Q?gnX62ynFcL+s2HkfMKn8k+ps4FvDaViIZ3bMvJ/dJLAlY4PeJwYSVt9sRQm6?=
 =?us-ascii?Q?y1jMMvrVAagXu/ueyi1jht8eO8xNfAfiX1Lo5f48FjJg9Rqf8x+V3dVfrNqf?=
 =?us-ascii?Q?TYzykTjq0uKBYC/Vgwyv4g693D2bdY/GC7exeV5qYJ6JeBSglpUvhZ0mEcOw?=
 =?us-ascii?Q?bnNCcvQTJkCGgpUC6ihZr3EI+BOtf/NfX8JXRFOglCRUwEM63epo7dD/0XA2?=
 =?us-ascii?Q?KJJMOpEEPPbSaXSYvkIjFyYLw2+KtJeix4JhZhhpmf9651oCLQYXQaPnj0MZ?=
 =?us-ascii?Q?83IqbAE1c33n/s8+hL43MFDDKR5fbL/SgLCjYqUjG8Ec4Sid73DLaHJjGx17?=
 =?us-ascii?Q?yTApwKjHcZkY9cB9hshVRl4wMEedhbs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4a7cae-bfa9-46ef-e946-08da109ec423
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:51.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mb0qtPkxYGoMmw9ZR/q35Dh5ZfReGuJrYE3iHvkaZt2hXKRgseIJwH0fK4jcKXUPqaXCXTcp7TdTX4eny4+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

This patch implements the simplest MPTCP scheduler, named mptcp_bpf_first,
which always picks the first subflow to send data. It's a sample of MPTCP
BPF scheduler implementation.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f92357597e63..5bb21b24231f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -197,6 +197,18 @@ struct tcp_congestion_ops {
 	void *owner;
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+	void *owner;
+};
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..3ae5c1eab5f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_first_release")
+void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
+{
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk)
+{
+	return msk->first;
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

