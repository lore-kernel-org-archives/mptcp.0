Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29315A8
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 02:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jgwi0mv1I3mxCOh6Igo7qXkUFt55/3lCOREmLg84DaQyYwUfA7gFf5PbZOfuivhxr/m9Do2U3CS7S6Wq+nTGb93imZXbCjkf77W1xCaM5cb7/lFaqAbTEIJ9dYOIoHp6RiY96Q9dr1JMz6hgJoSMWwE87icBni15cg1IuUyEKRTewTSV43XjXKBg9d5GnvgdkGtZC2o0uzAfEgnj6EZW/iCcYY06pBm9ZY4P/96zYCwImmJlJbF+IBY6HeWmmhAdEIrbmt1QsIkGrfxCVh5sCeCKzdriz/J86aReDw1qWoezGZN+x2F8D4/DRLTJs7jxVz8pGnN0iAjc2BRdxO6+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUhlbe0qYjQdMzsCOTWgOZLfHwevcXok4YFCLMkeVxY=;
 b=PrIWVqxtz9IEu7smBdyer2aEJ+f2mDaT5JoJe2iNgg/i/gKgKqXtnfgkCaR48HSxCkIaNIw8hqWA2bN0Mp9aTTymKia5Qm3kKhBa928hOveBcX3pVZa6frYLSplvUnQOk4Ym8rJlHmqqEWXU0sf1IJT7xDDaCuNn7dYtcW7kMm+8eeSRz1TSl7ZXFL8xVQfRpGUnNcMp4J8WLOcNDwA5IIIuFW6j+EcsNMrXPenhHNFvF8x4HnonEZDLWsMBWwUcNtzk0Z1qz/+Pub0oHVMs6khhrNGdu64v47VrxP6pZmRE0AISOAK5ThsXLH3ZIq2TPZvinJyJ7Ptr/zu53iDg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUhlbe0qYjQdMzsCOTWgOZLfHwevcXok4YFCLMkeVxY=;
 b=mdjttteRrK2F9fHcF9Dev9gIh6Zb4wqVu1qiu3K5Cf4oC6awukve/WU3dMHVZUkRLZr6SY+zLNz/mfN0msRk1wQ5tzfLNYt28WHVZKeFIfpJ+4cvlHeXl8dALr9q9qN9cRgh1l1UjvHR12wAm6u1nFVx2rLf3L+FBUAPb2K5MbzJcmvNrSgdS/NHlJJeO5NFw3R3uc3sLgziNBzdBJji4Jwlz3LIgGeoOFQbVYOPVBFbDcFdVY/5E5+mX5gBCAZ2amCyWg8CK1OEUriCMZDr8wztYhEwecXhjMjRADCKBuRpBp812C9NXO/wB8J5h77qbzhB26edHucUuYoygo9BAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 02:12:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:12:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] selftests/bpf: Test bpf_mptcpify helper
Date: Thu, 29 Jun 2023 10:12:16 +0800
Message-Id: <266b27617ff55cb95cedb198723d609fe5f3f3c9.1688004307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688004307.git.geliang.tang@suse.com>
References: <cover.1688004307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 587c56b3-57ac-43e6-5add-08db78465013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZuyBIhVhU+7J6fI1LBNNYFf8/DXwdQ3cSkeouADBF5jNT2z7T5E+n1pHo7D+ymcBFMVOT8NKMaSRfIN/zR4/uscv6QbLk8Pe4uz1TXms3WUIxxBUxwWSUmNV10SMBpvoEbTdPCDPt16DG3g6kTUA/3Xt7ghcRS3uFL0PcoNzVvI1Mmbpj17gXOlWZmXfBdaZuHvJV7HxK15GBPDEM2qHzLBGi8AbozlxjBjxasS/ShxdS0Sf7juEHoAVqvjLfrsOcZjcowMcn4wgv62DqlV2PT4Yv3qlY3EuiPsVMM+9ioU/RJTGvx2giFL+sUxdgaQBu8AbysmQZI2vY2i07/33AJgY6wR++Acg68yYQZ7R/QxVO9d/eC/zrq/C7CgDH1/iyOFvoWt3tTuycyRKqijx0iYQpdm3ADj5on0p6h2TtJK1Jex2eVEN6RU23Qj2jM0oLRokcLB0vqj1u5z6A549Te3iwy1KA7PmS1NrY9ZxD+EA+izJjKs1y27rJ/Yq6BWbrHyBjiHIBrNKPwFgWYIaYBqLz7fLMIVnBXgT06Ir2VX4o3NNKVpl5oztqpbnnxLQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(6506007)(26005)(107886003)(6666004)(6486002)(478600001)(83380400001)(2616005)(2906002)(6512007)(186003)(66556008)(5660300002)(41300700001)(44832011)(66946007)(4326008)(316002)(38100700002)(36756003)(66476007)(8936002)(86362001)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+tTn724Tl3X9NPzzUHN52Tk7lUyNWHcy2wSjbjnEDDvyVzU9J7ytwabHVQ6?=
 =?us-ascii?Q?rRJrdxcGc2IJ+tlmFbhzUv+vRgbIeWmSxHcGFCXtf81ji434WKUZssCW2dqZ?=
 =?us-ascii?Q?ssdOYpC6KiTG9EBAy8I/hmC3JAoBSy9Dcj71vmZBtFSoOOroK1k26YIet9ap?=
 =?us-ascii?Q?nhLOsA3jS/Lx2l8Xb/zIJb5HnlMpNsRsjCTr1lcCINNfl5JWQ0khPRy/a0qp?=
 =?us-ascii?Q?FbM9Dt+HX5xb06vdmcxLiKCy5Y/T7UTjBhUsyXQ4noADJgYBbZ7gtLcNnqPm?=
 =?us-ascii?Q?HFfsUmjMlSq6GPFjxevIikmU/BDM+iHFtQcmTa8OWFA40W6vZF5vRTB7HeYL?=
 =?us-ascii?Q?kMgxPKlPexAhx66/9xWkH1dcTvpi/2jh/JSuJAgXDQ18eStGDkSjM2nOvVHR?=
 =?us-ascii?Q?vAipaRyUYFqk+1s9xJltsv39ZdCZdaOyJacRxEHIDDk8HC5rL/rZDeo+80Fk?=
 =?us-ascii?Q?y3bhjtj8kg5QJVCVGaTKpe8kSNG8KM/gZkksWB2TNdLsRcnI1/nj9gqXLe+c?=
 =?us-ascii?Q?pABmCOskECRW7K+cc2gtlVacnYWuBV/LFD/R9ViBTvP/ivQqWqqfw+c0AWtE?=
 =?us-ascii?Q?f96QVBFEVbG7DeosG1B/AjWc9mkenplTtas7lWJhCKDKnP1E5Kiosj+mdNKj?=
 =?us-ascii?Q?EIxXZ/wZCba6vac3bmSAeCGrJqH3jVC8eww1zu76200Z57odxbSnnpVPSrOu?=
 =?us-ascii?Q?pxqKS4nouj1ZZTLRVwCezUdQEVL5z9sgHut8Ld7aeweFXXO67bqumGo5MfN6?=
 =?us-ascii?Q?uqDMit8aWlohNOZX5KNY0ESj+SDFIA1AxByxbeSFRCpqRWndEssdlkQEkvE8?=
 =?us-ascii?Q?RzNrWfKJ2IKgOqUcaOPW87Ms2r67BU0/RalmTlvnJnjSkLwxEkBaEAuJOfOe?=
 =?us-ascii?Q?kUlyfjMewaMuJHBaERjRGUArOmvo2rhqwRN5Daqp2mbqDpRg/bkhfqjjIuIV?=
 =?us-ascii?Q?zKCwE3KeSdIzNjZA4dfDgyas76rrNC7z2QU7dwXsAMZ8xJToGQa1eRJvWe+R?=
 =?us-ascii?Q?Ht/iMjoKpvvuMLXBJND2BQQnUExmlUCD+3hJ9VsHAnmYR0nhOMhSsinvye7V?=
 =?us-ascii?Q?kmubG8P4cMJ20A26IpSCXU2kKGeb+TTmzDSyjuUap8eK83dFj4POOuR/9v7a?=
 =?us-ascii?Q?wO/PNIEQ+j0p7y0gqpWPZjRbBmSvdkyBk6Z4idF3v5W3O+3bEPfDbso6rFAX?=
 =?us-ascii?Q?UK8s2K80udpM8Gi/UzK7kQQctCF9+ja6ahdAzAicSdjJTIC5eZLzvnEgjlfK?=
 =?us-ascii?Q?yYAtTOnVFBFaepAmLdVf8uVxMJTGpYZza7a6cO7votQidaGHk30X02Anl25B?=
 =?us-ascii?Q?nv5As1AJEBrck0CHvyDwxlc3obzaRG93euQI4JKCK2H+7mFzrA/ilDJaG9ky?=
 =?us-ascii?Q?GIJHGS4J80c93jN1jCyf0VCcmG67vPbaWYSvv9vcPWCjLSn5RKwH2FEN3/lu?=
 =?us-ascii?Q?nQJczGkyIjtJ+0KbYOQo75CaqIFgGwcO+qBWo/r+bwLXRm44r5wVRjdM3rM+?=
 =?us-ascii?Q?QRhcdYD6QwClVukwyhl6KU7ytn2vgDXDDch+GeS4tU+OicZeRYe/hFZqmlbU?=
 =?us-ascii?Q?3sIdRK9JXQ69qfswDHZ/wugHWaJA03CgFnp8AKKL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587c56b3-57ac-43e6-5add-08db78465013
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:12:39.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oy7x23se66ZI5ospjV+WM6vTAiMZCNBfHEr4mK9NpFqWlsnhegppdg1WJYtPYuDidKU8zBNqWt+J5SFSGjvLyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

This patch tests the new helper bpf_mptcpify(). Store the new protocol
value after invoking the helper to a local BSS variable.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 tools/testing/selftests/bpf/progs/mptcpify.c  | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..f846d5d62529 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -38,6 +38,7 @@ struct sock {
 #define sk_state		__sk_common.skc_state
 	unsigned long		sk_pacing_rate;
 	__u32			sk_pacing_status; /* see enum sk_pacing */
+	__u16			sk_protocol;
 } __attribute__((preserve_access_index));
 
 struct inet_sock {
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..0eb167dcfa22
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+__u16 protocol = 0;
+
+SEC("sockops")
+int _sockops(struct bpf_sock_ops *ctx)
+{
+	int op = (int)ctx->op;
+	struct bpf_sock *bsk;
+	struct sock *sk;
+
+	if (op != BPF_SOCK_OPS_TCP_CONNECT_CB &&
+	    op != BPF_SOCK_OPS_TCP_LISTEN_CB)
+		return 1;
+
+	bsk = ctx->sk;
+	if (!bsk)
+		return 1;
+
+	sk = bpf_mptcpify(bsk);
+	if (!sk)
+		return 1;
+
+	protocol = sk->sk_protocol;
+	return 0;
+}
-- 
2.35.3

