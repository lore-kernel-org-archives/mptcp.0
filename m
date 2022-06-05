Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C387E
	for <mptcp@lists.linux.dev>; Sun,  5 Jun 2022 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654435840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SsBCKaGSnSib8yKzRg7exL65wED8f+Ur/LUxp2VQOk=;
	b=JrhwwHnQrZsQxD+yKASyu3l8iT6c/x8nbTo2c/n2vozweDgT4fuxf0X7YSoyEovf9zkozN
	kUIbSScTGQLNb2lVkny+6gtr0f1JMkSUfzoDZqw8WwlTDX16MkDqOajDMLsw+BwSWfgP3a
	0zfg9oLpI3JOOJsULdawE3IkekkHNYA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-Ibjy3cadOAuVj--M2VgaRQ-1; Sun, 05 Jun 2022 15:30:38 +0200
X-MC-Unique: Ibjy3cadOAuVj--M2VgaRQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvuA6N3iNGgPIZPkiZg62IjvwhzVMnZZKF2e9C7OyTNbhLnFiP1c+ZRa5zQ1PVf5zjjIU/NDfSDCP/0CeoM7hhXZAsLT9frZbBG3Sx4CgvTq1pyx4YsmPfgm2XYSb72ZitYLo9Cp65o15HX3O5dSRg17GYAW5cSgs0Vw1C0loKy4Q0mt3s6Xj65gnDTn2RWqf5bis8ZsfUIeQppHbeqGIhEw7zNoi7rr2IZUARxJddCWQxI5NJp4QqIHZmumZ4uO+l5BFRrO31Wy8PYD4+PUdIDwsDpsOvSf+1PnEM7FuJCVy+YoiI5sAmtZhmd1QzoFpAWBnchG8QDde/ikACGbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP3UBW9MaHYoUECvpYCXr/Jf/GWdIt6ZXQXJmbYnsTE=;
 b=LobYJjmhurTCDeP5iJk4av1kscZBntSAfOAYw6sxNeICpmHsDemqEgNMElpiil5VvLqbdx2ogv6iwEGHK5xzO3PC2z8zp+Xa7j0avNs2HETiza8HGyiU2fobN/Pl5Mwn2k2OIx642gbVhpG8UHCw4F+Wl1cTW+ocKITi+U9hTTd4MCNR+TnEDyLqGSelwan2tX86OVTxRYYHWh8eh1Kozr2GN8uZCKY68VMyZ/kjSbcAJXsHTxlsh9ZylbzBrGVSs5vm/8jaqesWh7APSiTXI/8r1Pk8ao4zdBMU6BZw0JE3Wk20ps8eD9NhSe+i0eHDwicl1LKhu4x8LjmanxuWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5028.eurprd04.prod.outlook.com (2603:10a6:208:cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 13:30:37 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 13:30:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/5] selftests/bpf: Add bpf_red scheduler
Date: Sun,  5 Jun 2022 21:29:39 +0800
Message-ID: <080d75df1547c5a9db985c63404f40c86e01ebe3.1654435294.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654435294.git.geliang.tang@suse.com>
References: <cover.1654435294.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb5d0d0a-49e3-4f3a-4176-08da46f79311
X-MS-TrafficTypeDiagnostic: AM0PR04MB5028:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB50283737A889A57E87F4EC63F8A39@AM0PR04MB5028.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gagCUQ0BqVEP5iw1sBlMXXKAFPnJE3gKUjmQlMwUjap4PnGLz6B0tmU/EmXl4lB92mSWP790zaci0d+CgAVi/bXqB9xF+c75/G+ov/FHBcKL9+N6tWPouccs01bn0/aKxyJ11JKLfNumLdobHNY3VzeBdT6awoi9rDiglAn+ckiBvhjYzaZcn9EldQLwETBwDtY3hFcgHnQiyGB7JQlPJsVO/ovqxq+4IfSv4Ys0OECzHAxcxteoJMCNzTe91Rr5QBZB9xo63YwQ2VymZNXUDKAGh/cmXmZKcHvQ/Ubo4vm76twxVHOludlJDlMZ6j/t9c/tTukClrBhLf2RO8KO6lT8UyWoH6zhlF5C6ECBCFMQAsMscyw7Xa4sFN3N1cDrkpRj3WesVIm4TpGrr0xI3aFNFTKYLigOSghp8iyjeYxFDIqGKgJQ7e5SBsrqRj+FOPyyM0HJbLkJtmB4BtRRzsWD9VITd57P/0SCN90WjFcBBxrufDsY0r2goXZ+rzB3qfFS3G2hFtfTffGonRkoJgEmTbPQj57bD23t0KnEIyiwoYuSZVrZir64dI4Iq6HEvW/nShfPzAHRV7XwtB9AEgvMPmVdwWlHRyCDess8xGJJ/tXKvv3bKWNRH0e71e9WoPKJts9/ISckPWYNKRAxkozFImLZQLRtg6YAWa7Hq0CTywYd20qTDVeRpkiQFZ2I+RyTIK8lut9oCfQm5vfStA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(38100700002)(107886003)(8676002)(186003)(6486002)(86362001)(6916009)(26005)(6512007)(508600001)(5660300002)(44832011)(36756003)(316002)(6506007)(2616005)(4326008)(2906002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fZtxVxnbDiC9m7AqGI2aOAYAl1i8+krLB2vsI0R98JnQgcJTD/iaTgN6o5b0?=
 =?us-ascii?Q?Tm8gNAGpHkd+MlpjoVQr1kJkgP+0kGeFw7xFIr3X0Wh9lYYIAuqUeo96Sl3H?=
 =?us-ascii?Q?/hcd3wqc4fdD4R5jNXC83c27BbXnc4i3SBYP+wn2vKpDlTV6P+7RaTnQ05Bo?=
 =?us-ascii?Q?Ir/kYoDp20oGwOUs22aLs5Xfj799SuIbAQqw20Xx8zLkGq2Q8ykEeBApvndR?=
 =?us-ascii?Q?PTNNBUnjOzBTVindUDS1gsOTBG04hTkF1oQcQ5wemvSUpXfbB2CcC/Sv835m?=
 =?us-ascii?Q?n8HMJqQt+ao1jHjn0Yq5A2h3MdLD56hZr9XEOSjGrNIWaQsI1HvD9UyB6JYp?=
 =?us-ascii?Q?f/DJPYoCcc4uwihaNP4eLqNz1UPZj1O0+diK7LEMiVmuOhq579nexbCuUAl5?=
 =?us-ascii?Q?I3/HfDddwO0fM69gFu3Nj4tlWhSkiuDwdMdXPONj9C3hX8gNPMHqPbejwR9C?=
 =?us-ascii?Q?LYFujOuLOCJAvKjUm7EemczW/XfAAbxVoAwMnW9QcTuIW/zZ0xcNsD3LO8fW?=
 =?us-ascii?Q?/N0bveK4rg9iGNCC77avDaoeFxSMi/2ccUaj1UbocI36DAa30MH+FFZsPx0c?=
 =?us-ascii?Q?tTKSBgDw8wl/45GjuDe5/H5V8E9QUQXMjcT0QhKu216TCXXybaqeh5SdArxr?=
 =?us-ascii?Q?CMbzIMl++1mrTxjAbMPXICUCh3g/s5jq1sPGqIJ29aY6+Q4zi3T5ZqX8F+2P?=
 =?us-ascii?Q?LMlL966dB593Cfgh6tn2qKACWOtFbeql2jxUITdz48XLAszLo8yDSPWMGl/B?=
 =?us-ascii?Q?OUjHclD6APPsywgxX/n43ujRSP0WU1rxh3ypNHXRlfSKAwEro51YigfHsQ9G?=
 =?us-ascii?Q?tyY2Jb+35qm74XqM1DRT88Yt7g2NV5bmG/Sp/n87olQUAB042lGm1Ot3Hk8e?=
 =?us-ascii?Q?kfA1Bn8KW6N8oddq61r0UvmdZSyzqzFFXSvZ92AtM97qYIq+6we1s/tKm9WW?=
 =?us-ascii?Q?/VBMFxZQyD2os4jQSW4pUp71qGhfdqLDyW3RnjfNMrN6lVm2R/Sw67BQYI46?=
 =?us-ascii?Q?DUftjKh2qUHjsDpmQELqGGSUf+U58Gfct648NgNqrhU3ffz6DqKFGlyYDK0Q?=
 =?us-ascii?Q?YwQOm/gm/eZC6hExhBdUgKjlPQ58Kkof/k5OndV1f1Lzs1O2L4MkDZBKj5v9?=
 =?us-ascii?Q?ni09v+9TnJYLdXS6kVoLDJNTzSbv5nWQmUPFFZlBpZMccO/qEl0m380IbBeO?=
 =?us-ascii?Q?x0AP4i/AhPDiVaUPoxVvpBwzUU9G8guY5ZWHeEdOV2cRrZ4FYT+mLPgFxW3m?=
 =?us-ascii?Q?2+Ajovzr8GVz41Zf3wObpMCV6NV4IP0U7/B1ymg2LDuVmwn+yfZitaF2NuDr?=
 =?us-ascii?Q?2L8BoXrb+9+XhY1S4QstAtOdiLeCa/urA4wnzpfzxrtPNtfeIa7d1gXhhcGf?=
 =?us-ascii?Q?StHeTGHrIwZs76/JPFD0mUob08esgtcvIzF4I3vdXHRRA93bo6dqA+mMm500?=
 =?us-ascii?Q?2VdHhHRJ8HuL+CH3hye4yLSAwq1qa+tWYWfJxSPV8ggjNigILKPDQ+mB0E4+?=
 =?us-ascii?Q?F0qdiqWmLlqLG0cgFCXBum5Pf+f+2g4L5rvc69L9lerYwzfw/GJj6dNXTm7t?=
 =?us-ascii?Q?7eZiwXkcGJFGcv+xlMFRhlOlEcsYxiDuGFXl6GCmVofexmZ0g55J7LAIuZZR?=
 =?us-ascii?Q?RfuwsImKo83QICsSAIAqEeJTWg0O6+0UEoa9UbYlfjUmnNI2BZonfwj78QY7?=
 =?us-ascii?Q?C62D39XmgJaDo32ke5N8C1CgB2LC6uTIP7OEJI0zwTMVziiXMDOuffxG7qfU?=
 =?us-ascii?Q?vBXtxo7wI/YFFWHNa9KRERFfMk2/GO8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5d0d0a-49e3-4f3a-4176-08da46f79311
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 13:30:37.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnGiRx5hXs40ke5MW4qJzYffZxVg/twcY6c9ThM4Xo4qBGbMXw/LanAoUvwprzxEKDSJoJqHSpjFWMI74R7hWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028

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

