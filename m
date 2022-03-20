Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364633D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=el14mbDNzMQKfIz7X8FmdkOL32gSiWivSI0Gycj16jY=;
	b=JzRk/E/kOKN7cN2Fz/htKS+TYDuZYlePsH4s37PVvMpxfr8F5OAlGjBEGeayfbNz/XvNc5
	HFFeNug9DOgWcp07l8TEbZVf2S6CLzriiEhU+MSYhiHIDGK0xRtip0/+dDgqGvPpaP+/bI
	pMlchFJqqIqrswhivmnVyOhXgfX5iMo=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-MRgSpSBoPtW5vIh1caIyVg-1; Sun, 20 Mar 2022 15:10:05 +0100
X-MC-Unique: MRgSpSBoPtW5vIh1caIyVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LW8c6XTd85QBEMemcfqhiS88XZi9AsbX/YUspe4oK3wrJV8XkiEels8qc6kd6DN6E0lPQCN9FIrx4h0xJ4QnuOTFZYEeK8e+jne00UMzNc59Odm+3T5JPYSiTFyhigi3nyBNN6xANFiE6TwDrs1qodjebxkqqHCKHgO+skYHE/R+n14bYOUjPnh0xM5V7K6e69QRIGk3DDXSEQTIflQYLy/TMuHUFSQE6SWA6J5SZLLIoEqiN1nrhcWie/gKEgc1dr7usPhRLs+C2Sa2mkVwEFusFFyIZSSSBXjeOyzsNRZvanlvl8RbWl60VeUUCPNf4dHjCQtbhBgvKT3MeVJXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5FH9XtcH7HyTwHY5I1wHeCwYLtUvyGzKzyt2JprDa8=;
 b=CC/Xlm9X/WrGlTS0BeHB+BEZOKl+O759XpwHa3FTU9wJZf5MzqDhEiPChXo12tNrG6LA1S8yMqK0Q9GVmyU+180aK3FrJC7Uysf3vqVBCYaXW5BpeEpg6kczEvkSgpuCOhzOQXrm748+NhqftAYjxYKIJBkpVVHaKLdOH5t3KFyamEqT3Lqj/yrLA4d0OtSD/Y6I3gZuss1G9OskvFl8z17AqWEvOCu+7PCUf2wp7xbJSiy2PJbnbmESH/btFKqXLxfDz0YSJQnLvQrM1/Gdgky4Tw/Nvd2DKwrJeVldc0n3uoNFSUgDVS4wLEEccm0FNU/SiGY3pl9pUEINEy9TTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:10:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:10:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 7/8] selftests: bpf: add bpf_first scheduler
Date: Sun, 20 Mar 2022 22:09:11 +0800
Message-ID: <596c0daebe83e8a7b36aa10539b17db48e07ca62.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647784679.git.geliang.tang@suse.com>
References: <cover.1647784679.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fa27d37-5efb-4feb-4e13-08da0a7b5448
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB703571526923A3E8E23524E8F8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lK7XA4O9ba3rs7Lo2aFUpH4ysDxDtm0jSJk97So3nI539G/fxYt/ro9stsxGz0Z1BSlW8719bxodyuYDFdk2+rlQDbfGZKgl7briOC3Om2wSmIKsuAAfKvjyuyUlTxzQPaEcPvdVHIxbHRQVl/N8H0fVjm/VO0ABaHGpvQq9zIBBpoX3XHKNSUc+K+79Dg6W9gGY+W3wj3Yd+xaF+qeWLBV7pNf6+S5zLk16xGQZ53p10uFRwYuhBfl8Hfq+nUYoQNyT3rc/jaUa8aC+9mIqWS3JUAvco5v4Yyw8+7uj5UAUZH52R5JXd2QANlLSkKuZPhZwhWU09fr7QOPubDvAfDHzvMe5ldBna0lSjR1ax6GvzI1HQmAlmncVuDbaJwm2fz7RpZvsCOjNzRcHA9h9XGX8/81ZQZgZb0GOD1RgJ4WfhXLkTqmXIhS+KqTteERc8jdcoEwO3VDXPM4Knc/YsYnb3U4DkCfUoDDlS7QrI5vqzUUsGGE97QSjfqYEfWRTH3u3tB0fHrn2tge11615BUxIJZAtymDESoOXwopn1ejXmWH8Alls2IHJKXXkngTvGDHMLaOL3Ygm43PyHlTaO2UEvl0a7nVvAgW0eM2c2euH6cqM2SeYtLSWnqtN/Yh0khkdY7jul0iLa9J/qE5qJlDCHdP0zLx608nzf38SZvBrqLRaUBP5+mQv1GUcaVEn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(6506007)(508600001)(6666004)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pkGSTVjVJB0IoIePiUSxFnAbOGG9SxnxwpwTi/K4xPJNTZPhi7O5jA8sNPFh?=
 =?us-ascii?Q?MpyCHHrmurUwbpAbYPLPHYEusFWaRc5qzUIizwJLOfJ1qi6KwLVPx7DLjsL/?=
 =?us-ascii?Q?n58Y117DqZHL60dT7mv0VnZW1tHj9YWkxksDcaLfAVUmm3ynhdRW5ownwpwH?=
 =?us-ascii?Q?tMkuaL1U9E6AysAQfoAt1yK3u8tgMjyoKmxOCAhvWoiKDNzkQ4uOh72cnsyZ?=
 =?us-ascii?Q?loY85agpSJWB+TFnM20X613QjtaBiGho19QV0Byv9UL3+009zVveWI2XHTkO?=
 =?us-ascii?Q?Kry+mi7WKuO5FvzL5VIwPW3necIGh+yq8+2ASxp4aNawF+n9bZm4Z5L2MqWb?=
 =?us-ascii?Q?gQppumWzrtQurW67bZfC4rY73GJ5FycJ5dkslJR8kPdTX1YOIDz9sl5R7T8i?=
 =?us-ascii?Q?0hYkPT+9UzedTp5GNLcX0TX20ZKRaS4QWLmhEUYwNqXuA0J3ZTwnALNHBSYw?=
 =?us-ascii?Q?kj3fnb6Cq9YdZdw2ay87yZjcXVN8sESa1aSk2FmsBHWOfVH2wnq3UIf1T0JQ?=
 =?us-ascii?Q?LZaUDxZhEF/cbeU7r4hzqo/fwk2YYafEQ0dTFYLdS6UecL81+2GiX/Q72/V+?=
 =?us-ascii?Q?7Cvs/GzPIOk/lldgpCd+mDozQVUsNS9110k3AE3aTiOSZKVD/r2z1cCMoGlj?=
 =?us-ascii?Q?5W86bsQZqLn4+Nt1eUen+DJBiBgs9uC+kWOPHQPqAvmOjf7BoyHiXSkKNm8c?=
 =?us-ascii?Q?+TIEwoaIoCvj+zIHzM1WKPQVP9K4b+R1OMhoRjNr7iliREw0kMud1oRSW0GV?=
 =?us-ascii?Q?SKLwInEST5Yqe5d7GgeRg72PC1INFm0AWafIz+Ehh/GZA8Nb2P3NW77gWUsy?=
 =?us-ascii?Q?E6cPThUK5ETv6UVDx1YdKv8DGnpgDxgGwt7tDxL7JzgXnatcgjdwhnq7QQ40?=
 =?us-ascii?Q?MOH1EXeSagaGG0eWZHYSKUjQpBKCfiPnWn9i12eaWRjikmtxdjPwmeH7pRON?=
 =?us-ascii?Q?MFkVJ/oB2ra7k1xyDMSloboOBt497WN//aZlPZA7+djUfO7qTXPFN7O2TQ91?=
 =?us-ascii?Q?rmGIZmzaBgWf95Cb5fO81qwWWvMJicl33L/s9Timps9lZz7vNw1DQ8/smD/5?=
 =?us-ascii?Q?pU1VnUcwCVlqopF3GG1N4+pFWC/gEdd0uwULmheJQcYMD7oTH23aVbWTPna1?=
 =?us-ascii?Q?qzbIeRjJF8vyxMydplTo+aWzK84JQsQ+FLT0O/ESY1LOYYjbz1ZwM3ZOSlKw?=
 =?us-ascii?Q?deCJWyw/Bzq9M8YPhMgs7AAeG1KjDOcJ7KdEiXNYEjotMYuYEnsk8ZCkSl+K?=
 =?us-ascii?Q?FLVDZMaJZTDnu/H8syXVyp+rczJ9tB/vNgfbVkBwRREpD3FHlhbqETHWGOVM?=
 =?us-ascii?Q?ytMBKH+JtewAk9D/uurWxnxFzmyR/tgOHWCqqjC/THo0UdPz8YzrfOHm/a8O?=
 =?us-ascii?Q?1IIP9rK/eWBv6HSWBu/rbEZ5gwgL825HWTvjTK5NJSdtb30L0oserM1SaMok?=
 =?us-ascii?Q?vPj/3Q6jeTT0ZxF+EBGNHxZ1Dl7oLJMp2qSsL/3ZfNA2RBJbRA4Ucw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa27d37-5efb-4feb-4e13-08da0a7b5448
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:10:04.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaefG2fJZvAxInGnghb4WfbSl/WBvBC6935deLG/9O8XBToRRyLkW/4/2OaZ64XfmWXrJyIfBzv7r86b9bDwTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

This patch implemented the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++
 tools/testing/selftests/bpf/progs/bpf_first.c | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

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
diff --git a/tools/testing/selftests/bpf/progs/bpf_first.c b/tools/testing/=
selftests/bpf/progs/bpf_first.c
new file mode 100644
index 000000000000..3ae5c1eab5f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_first.c
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

