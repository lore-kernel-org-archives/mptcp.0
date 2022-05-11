Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569C28F3
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652270975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovcrUPXYT2NGf/lbGCZLF5moeulJhQwLtH52VysaY3k=;
	b=c0c7jF7RFOJ4J2W7zyUVJtTsonMMfnXQ6D9vHu8bpay1/JlzXVsslQae5PMcEY2NA2RvV2
	h4h1pJ1QkNrCmfcsQbiSXIG2XOyJB6vUGoIWw/m6klhjP09Qk6npukVgeii9x++SMXsh5Q
	cjPtL6xfgCHgf82J641G++cAgUPQ2B8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-i3igQs9DP5eJn3i6_4Qkjw-1; Wed, 11 May 2022 14:09:34 +0200
X-MC-Unique: i3igQs9DP5eJn3i6_4Qkjw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddC/W+Bbrmr1HkKy/BkS0EnEEnjzC1IQiDQH6Or7HrB2DFi0BlnnCZ0vbTUIrn/7U/xTINWSyR2uzMWQDia1c/Jp6YTQ6G679qaviTdqyHpD2ddTZGoE8dV5HT044sh6AMyGPHrKL1LPbpPch4jLVBBnrsbRZJ+mMyOXVbKsYSMSbL0kwyC2QxZ/CHfOTrBncjdasVyxXVRT/cn9nZ5XUr4s8yHYKE00OvIwYWT4yUdrGP5VkJdlzSKqJeDdZQ1TGqtb0R1fixJg+ZWdH3OBMM3BYGdp6K9bF2u8i3mWpwK3hsPiB03gkEVYeApveHu8j/+2H6I7MslxSGKthQCqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQwsbPEKo9l6OAFWDHUq+2A3/mMBFUHCz9Am7r8frAg=;
 b=Ummbb2kvwq7wNRMTLbAi0oYkXrzOh72fbsZkYLonacxeKLa10jyhazH7t7lZgrN9kdReeaiQBm3FgybAgadXLzZKM1gfXIdRmY9ngyfZvMf8QH2dpQZRe+3PPX3rRSSj5iAFkzBI1jAy8veWHfB6Z1vsPzANrPQSVC8Qcg0TBasmb0oYz0M0IP9dUT+kU/O/aIMSqFtpjM+jMmxTXMfSWdyOmt0P4wgUZubZqNDaAizGP2ztGjIE3GXgUNodb67w3sSFiyOXHWNf82MJ4Qv2CL4bkmm3oo0icVMrtVgR+jx2nQLRzpODn49/lfG4pbThEpZrbdrkC3mvyYcFq46vXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5716.eurprd04.prod.outlook.com (2603:10a6:208:128::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 12:09:33 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:09:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 2/3] selftests/bpf: add bpf_rr scheduler
Date: Wed, 11 May 2022 20:09:08 +0800
Message-ID: <249c2026fda409a0ef42f5677a2eac55fdb8d6f3.1652270663.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652270663.git.geliang.tang@suse.com>
References: <cover.1652270663.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 071eb2c4-6b80-465b-e60d-08da33471bcd
X-MS-TrafficTypeDiagnostic: AM0PR04MB5716:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB57168CBF1EC0C61FEB22D96BF8C89@AM0PR04MB5716.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gF6GVnkUh79NKrNlOKyNBKOmS4v+4U1nH0PoBaNxiMW9QpNT8yH1iHnsNRclQTgWzTMVzgcJ62FlXOSS+IKMHLTnJMMBmmX/rSJKCm4naMPmEhq5V5+T48+UtarnJ591UfyD6INXJ+ml8so3x7sUxwSWLSsR4SJu8B9K8Wfkaydx2byIH0FkaxzjVzmYCmdHkupzgnVF+lwkWuHKtniGF3XYlEH3COwrmf+mg/MsVZHKsvwOt1T9WkaBbgWd5feA1kP/6kI20cp4h4q0TEMYIWkIN3iG25J2NZ3dSwF92yocaUicvhzn54PhdeLwAoUcU/3CSd6Ns0eWELky0xX+E/hyHCusNdHOKmSxuSJsb//ELi73Vx2+nFoU43m1VPMlbwQJWGo6gI6i2/OR6YqP83IeFPAgvC3urolSdQJtQWloV4Eozn1rKeNNuqCYExxbE67F9aVfgWAxlA+p/ByEcrtyb1Wm5gxsKvjuaWbLVBAFCUlGva2oLndqqNBT0kofGneKTBcY90gE3MXINv/pSEImMSOtAZdb8yzrDRJ9Zg3+ZBM1Q4y6bHL0bNqKO0uF76+XnZkuWRRWXXO6rBVanHyNQwlafWoHhC4CCQXDrQirx/zK08H6Iz4sbNOYOY9lM7h11Hb/krhFlX4UI6dPo/JdGsjC93Z17lXoVaonR4IHS5ijqgrUqSLAUT07+XT5JrFpH5y3j9h+G0F4CFbB2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(6512007)(6916009)(316002)(66476007)(4326008)(38100700002)(66946007)(26005)(5660300002)(6666004)(186003)(6506007)(2906002)(508600001)(107886003)(2616005)(6486002)(44832011)(36756003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tck7pkS2/qve6e/sjIX7jux8Iha9ms0tbwSxtKCjqpLFzAhHyEwe6az5XMSQ?=
 =?us-ascii?Q?0WbFHu8Sz+3YSyRiexhNJ1ZdsHMLL/wYVL9XuooGSjyz1hlw7s8NhyGOj4B/?=
 =?us-ascii?Q?gPb8QxXOa15gfli7VPbZuq/Mdi33hariajwEsFzL3JF9zJD0q+v3iXE9kYfc?=
 =?us-ascii?Q?4kIRi2JVpmNA3FltHQAOa7SJFgDnicrai9stemioZ/J/L7oh1cjCYk/ogbng?=
 =?us-ascii?Q?4QcXe9gsaQvKdaZ/ivcuOkAZdy41DK1IdSWe5DEEVbUPoEGJjM+EGSP5kxKo?=
 =?us-ascii?Q?lHaEJJs0j87fo5uSnmjBC3m6XOPce1gDHkoHdQsKbDmVfJSEPb3FBPBPa2xW?=
 =?us-ascii?Q?lEjW/23DqeUAhntpfUoFaMuHgC41TjzPwHbB0uZZxsUMeFqhbTlu6+19zJcx?=
 =?us-ascii?Q?FgvvLI1Sb6Dr6XBA7Rp9i4SWsyjwKjIiq/PQfATHmSVzTMJBUpFhOC/9zHrj?=
 =?us-ascii?Q?MU5HQtKLFkazM0DPuAnl2sQ8RwJWpHQJ/aH2Dy9W2mLNwQBE6r0ujs94WLJT?=
 =?us-ascii?Q?AcQ1jx66kVnkvk4XZCDn6NPF/AaVQlg+oXqBbbUqNGgfslfNMb3nsIGQj1AE?=
 =?us-ascii?Q?dlU6EtzdyhTH/NMbXUTUN81SlhYig7spDP+AIFp1gelYkFA6FDVluGmWJrkB?=
 =?us-ascii?Q?Dgw3aAYVho+DsgxURk2o/zNhlYQ3sJ21pkeRMuFOZCHFHluKA0b8qed/R9UH?=
 =?us-ascii?Q?njjEIfl/VQqHbJXrWag8MCmmIJYB+G7954F0u7bbKqTErDcO/8rfiRPG9lry?=
 =?us-ascii?Q?MpqwEQ5Epukpt2CmKVKgl592u3XMeMEHfyss7RrL0p6EehU8PodnkDYfn422?=
 =?us-ascii?Q?GOVvYa7PqZJ33flwMsiSkL5HrwJT0sJkwkckeV6VEN4q2kdadhbHRrVppGXD?=
 =?us-ascii?Q?sCHirazuQC9RCS4Xk+qEU0HJIdNnqQWxua60hSkxittYGlBic58Ygx7Gg4zw?=
 =?us-ascii?Q?DBKlBahRjg8cwUFwmYIvh9ZkK9lhh+cVpkLnFcWyQmp4xgXR7Ib3JE81IvqV?=
 =?us-ascii?Q?vDgiBhpt7JbYuENN7o4puSiaA4GF0l1NYVl4BLOrkcvOPI6jnJnGCR34GxCs?=
 =?us-ascii?Q?OEcxj51YW26A/ZOdBHVwAo7FVBD5BfzGwggdMgOOVC071pKhGhmci/YOfF1w?=
 =?us-ascii?Q?bkt9ShsPCd6/VJqqghQ9/QU6I0rfRa5TfKKv0V50Wp8Dv1NbhYtw/3ENplo2?=
 =?us-ascii?Q?211Wlq7JzTl3bgRqz6+xPB7aoYBLMe29PBXoL3sh42TyuHVTxsnw++R5eQhA?=
 =?us-ascii?Q?NTAVGEPi0onQsoSJ4qZOH8qk8lAGDA4kW9Cb/oe3fHdhBEBTnOYb27DpvEzJ?=
 =?us-ascii?Q?ilG63m6PxcHlDTaDoPS2jI6ubpOSiNSoyKF4NwWrcP1D8DIEI68cs7IdG2MB?=
 =?us-ascii?Q?/GKVv3ORm8Ca6LBgHVE8U2eWoUWLN6CcODoBdj3oPurSReDKXc60aPKxlDSd?=
 =?us-ascii?Q?Rez1VsCQ1Cr8JR2AI+GTl2XBf1PsMuW3YIoiKfTiCCtB+XBOQyXlNcDTY7xZ?=
 =?us-ascii?Q?5dC1szb4+7FsX6XfCVgVko8YzGMZzhaHk+esn8+1HJYybUlHPn4Ag4kqzPbA?=
 =?us-ascii?Q?Q0iV99G4wUxEdDJnzgrXKMZCDn6ixXGdm+KGohR29uSCWYovcsas2/qLbC3d?=
 =?us-ascii?Q?D3hlb1I4EVsZtQmxuMJMHM4DUMRCxGCP3P2qzzxIiGXmVcGJnZtF3UVF/4jh?=
 =?us-ascii?Q?jRGCeY1L+Du/KztKNVuLJqvpbVm0SLFrJBWCi8laxZ1FthDNRypq3EZ4piJd?=
 =?us-ascii?Q?9qU+iX9sarZleGiYu1kUCnPwf2idl0Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071eb2c4-6b80-465b-e60d-08da33471bcd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:09:33.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqhaOiCbk6dAsvpF72cGrUf7CgMNerk0gkHhenAepg5GHh3RCWQpU0ProQ7Z+XaMgjmhGlXUszAnP0LElSmHaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5716

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 7fa96e3a8318..d08117f6fe64 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -259,6 +259,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops *sched;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..d1a14f5dbfcb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,47 @@
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
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	struct sock *ssk =3D data->contexts[0]->tcp_sock;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!msk->last_snd || !data->contexts[i])
+			break;
+
+		if (data->contexts[i]->tcp_sock =3D=3D msk->last_snd) {
+			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+				break;
+
+			ssk =3D data->contexts[i + 1]->tcp_sock;
+			break;
+		}
+	}
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

