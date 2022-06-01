Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D341256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuNkc7nYCWrLqdl6oLEQJFiXo84YMMtK3uMqMyRchP4=;
	b=dqKl2qb8Vdd1EO2twriCZrTffgJje2ehWbvt/9CxvI0TziNUsxa8eQNkUdRY42DWG73Xle
	tuVd3Y2lmYFRsXDEQJ6puVpdEOTY75Vf26XDo2pVL85zCu4yc/ecBg78MqEm8o01LEzLXa
	nNH6Wyggj9ROO39KPc0H8Xt8xpC5GDY=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-gwQ_Pj2zOki1p8Gz6k1ylQ-1; Wed, 01 Jun 2022 16:09:45 +0200
X-MC-Unique: gwQ_Pj2zOki1p8Gz6k1ylQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdDHM69mJ9y8F9avJ0X/5Pkncum5bTZlhg2EPTi6W/uNxcrwclzxOed+6VTidFk7alMzpwQzZzWdLkRT3qt8o2hsv5ilpWDd8ofH6g3NUgqevP1SC8hGpjvjwmLlubajqd+CbB2o4StxtHIElCIcdV27ddyfeQ84J5QXwJivTLUrhF83gDKM6AW+jiGdFqqPrVfLlzkeA6SUifM7u1SzT2mJN47iwPLX1BrtHc5ccabK3XMS9UN4y3AcMM1MBBi5NL8rlUlPPc4+IoWQpR3dHgY7AxS5QoLBE8ABr5iQfvldyWZzGn8Rqwb+eiY4F6AWxlFnlSS0x/nWjKGwCQV0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2kTjjhuEGYslmQtDFpLBcSZGwiWTgjkx8GiTke8H+4=;
 b=RbqD8ri1Esxzi/mHCWOaRtSoRSooAiMPF0Z4SwD9/731FVxqdk3LaqZYrKikyDQ6uSxF9dQWaDHBer1YJlzbxDNep62JnfFDbLD+Xg7AJa7AupUeofTM+D/lm0kHBU2ysel855bSKOqb2F7Kou302UIy1ifuUwMUSVzAnmorrWVrDScxBtVRZb7rPdnBdkz4801DEdnGZ6Xdc5rhQPS3/Gxr3NVpQb/EuE2APWsEYOuUfGoFmLuXHq26qfv/muSgsVCIUJsXH3mE25MqvUduDOe6wkPBDcyzA6nL71sdXzmtpc/tmlFd19szwo8Y5IZ5NVMbT0R95UeOLW0nJx9m0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 14:09:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:09:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 10/11] selftests/bpf: add bpf_rr scheduler
Date: Wed,  1 Jun 2022 22:08:23 +0800
Message-ID: <b1f391968c7afc7a241d71db9f8be319da162953.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0174.apcprd02.prod.outlook.com
 (2603:1096:201:1f::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1a41d2f-483a-4a30-86ba-08da43d8609e
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2935:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB29351E5D1C3F1DE91175A03CF8DF9@DB6PR0402MB2935.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uIM8Begdsd+uZihwypGXZm3L2hcVL3lOaz5TNir4tpol0DxInzjoYBntoRrtPhEZ4f2GJhsxva7lqQeu6KffsDqzVskJKBEh8LlXl32cA6KqjAzDmTtENrq41vUIrcTe9qMLfFbB4adKlg1RCW4cjLBop+Dltp4oXMRBcwy6lFVFmQOEgp0GgYdJ0GcZu/sfJMODmXLVuxs9IVOSaJW/2KNznOn4iIKrN8+PGwxPSUmhXSB7ScZU7BAN1zoSMcdKUCyrMuIkeKDy5SmJh8E72JUWplHA1twQOwGF5BuQ2A0l720oakTtDaQwphVEsWBtVrcGc6ILM2jXdZFZGplyRdhZ1ukO5s3VPKKldXWDCwWqf4AuEuICC9WvGjgZThE9UdaQxheQR8TfSW9ZHlGAz3J1o6fR4QOypEqKeupWpeQ0tD6Vhn+v1LTFf3BqsktUGAJklsDowj6uysdlOklGhCVCgOdayfwdSStkFzte6e2S71AWGsJe8rGhCXrfxLD4QUSe6F7Kaj4q8NvSS3k3uNB7ceyeFGHAGQO4Hxn3njEoDwhyE4gpBcWup+B3NSc8bhq3T6IJG7vHtgqV4B+jPsv3zKD+DCYOHwipr926dQlIhNNJdCz+2WcdD7KdYkzKuAfvVVoAmvtoSY+pmjjVX3nBA4qz+HC5gL+g84mikHK98OUJwKj4NcLnI6WaIf92+uRpBWfCekqMgLp/1mfHuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6916009)(6506007)(6666004)(5660300002)(38100700002)(316002)(6486002)(4326008)(66476007)(66946007)(66556008)(2906002)(107886003)(8936002)(2616005)(26005)(6512007)(36756003)(86362001)(508600001)(8676002)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Jc8JCFHnsiT9DDPxyQHWB7kq370ZIFjo6/kcR6felkMP0UghzkJC/j3JwW+?=
 =?us-ascii?Q?mlawJexZ+26lcZK8dCOvR7GE6lrJkR1JI2tWf/HtmAwfgLX9wjutvGJ2MlCh?=
 =?us-ascii?Q?1JJSEeue7I7V+dgP8dPpCTx2uAw0FThV1fb+ReUI4BPnQmJVKEWsrzo95tbo?=
 =?us-ascii?Q?c++mBNQbsKFi1VuLiCN13WYlIZPgnzppJTgCD4jwkphD70Azcvv3M9hzCD/4?=
 =?us-ascii?Q?nBcx1p9pbnRmL0nTIqjs3lgZQwbPbmsASMzYUwZ6y9Hy3DwgYbbegTlZjOcq?=
 =?us-ascii?Q?5AF4Sosc3OSn1iMVX0C6wTJTqTQiB0c9lPdaWV65BSiyGu5Su3WGpDVxni9S?=
 =?us-ascii?Q?/JM6OmfPlGtzwRzqiplNejf9sANzMF3lNT3V0iw2EKi7z4FpkQVFqI3QoDnf?=
 =?us-ascii?Q?mTcgjhlU1FEEvpKcWx5/dNIrs/qaZzFullsX8/htOE6IpcHuvF4j0hFzpZlC?=
 =?us-ascii?Q?AukrdZC078bYPx7917CWJyA+TdjIt9dZBVnvvtmJRCdrw24WgXgNFwhgM0ED?=
 =?us-ascii?Q?AZIPyegSz06yaIh4w9o86XVsj2tBSQawphY6bUIxiQbpmjwfXoW7TISdS/OT?=
 =?us-ascii?Q?yTAUbaBLeJmGOWdTNvZw0JkB5wGLhz/4YnxCCVTE5l//K0MuZNuep0Sy/YDn?=
 =?us-ascii?Q?PC3672h5b5ppMhYFFXUOmrd5sQEYJkuVrwQ0vk0S7/KxyDdlFrZl5ypz49yu?=
 =?us-ascii?Q?V53L5aiQROr0X5zHCjqETmB72xUnTaTGClEz4ZKfcWrTbRRXwqEbGNyHV00f?=
 =?us-ascii?Q?dF3qRm4rQDgCx45DqVXAfq3ZDHOVe9lUuRjgHuyKuS9kVxX7h1O3G7H4qO02?=
 =?us-ascii?Q?ZgEA2Rcdm2emc52MWoNk/YfM2WVcTI/cJcSooJUvTsGzNHHuVUHigQ+oBMe2?=
 =?us-ascii?Q?8AouB0SsV0fHOVnZ4l6IoBc5kD4pZYalJrkrvW2s0M0mSW5kj4TfUPCurXf4?=
 =?us-ascii?Q?bq8KUQVFuONDnU2DYpE9TDDqdq8VI0TgqbIUMGilJLk+/e3cOlAwWtya0U+G?=
 =?us-ascii?Q?ejpmIgEx2/hnhV2+oRdwBEygnAeS0ATOI4KSx0tA98xaQnjWmDTEfMCXxOXr?=
 =?us-ascii?Q?FB3I7hZxghQnguBWvE5mWQnLWbZZLVbxQTiYXeMtldawX3m8UAGxY0fQq5Qk?=
 =?us-ascii?Q?Y4b5VUJeuR+CAscnAL/znCxR9pKg3wpUBG1rMmP6d0ULOQVNb7JsxipvWcBB?=
 =?us-ascii?Q?r4+Ct4aY+9HtTLsav3eVixVx6rbSA63LhcHHRR/tMV8wV3xqcu33Z4JErV8q?=
 =?us-ascii?Q?de2tHsVC0CU0etdrI+QmvfLlQR5xCmuyD+PAnkXFO6oasHbubH8yVOopQ20W?=
 =?us-ascii?Q?vaFAJulAnbuL1Ke/SR81stV/dVDP59SitUXsjBvBzgdeUT+4J1Pse+OJMgFz?=
 =?us-ascii?Q?5sp7EhMQN+9NUILcXLSM56X/sRvLEOivDp6D7Ymtth6L2sg1WXth5GQFS2fm?=
 =?us-ascii?Q?X2KHpzAMlwMyqSk1PX8/mRkZTDnDqqHZbelSvrwv4xlFjdFBqCc5YoxchuGZ?=
 =?us-ascii?Q?RmDIzS5RGPwkKiUJGxLUBb28g6900QaVv3ocgmHEjEdHiKQviVEQC4RJbTRS?=
 =?us-ascii?Q?KiaiBUfuKFSxedmI9sc+dQnbYYin2Uw5BtOv3NDm4H7qXiSShD45RPPicFNI?=
 =?us-ascii?Q?59kzgSmIdb6l8DvSXXqIKngBslpV3fHU/4cNx7Y/lxwI7NRThC+8VRLembOI?=
 =?us-ascii?Q?VziY5h5hz89keWGJ6q47x486ypE7WPDtP1HL2HVhTABNFxPvTJzFhz7TbrIJ?=
 =?us-ascii?Q?CuIExpVnGf1nAaY1FdavaxPqQwajH3g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a41d2f-483a-4a30-86ba-08da43d8609e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:09:44.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEMFPZU+fDRSyCE/i/gl/CQ81LJbL7z213KH4jgyPT2wOOmy2D8+T/zUH4/mOxScCauHc/YyUQhzoVXAelXFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 3d4b906435bc..7b8558da64b3 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -257,6 +257,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..ce4e98f83e43
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_rr_init")
+void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_rr_release")
+void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	int nr =3D 0;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!msk->last_snd || !data->contexts[i])
+			break;
+
+		if (data->contexts[i]->tcp_sock =3D=3D msk->last_snd) {
+			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+				break;
+
+			nr =3D i + 1;
+			break;
+		}
+	}
+
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
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

