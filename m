Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EE20EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDvjfr6t0NbK4YhcT42Fap6bstjQt15B5MhjeBWAJ00=;
	b=OfZWvOl4tDEFgR1Nf/DbvmF2pGWoNaMQ629hejJ/55zcjmtI1vBxQg4zVbKvVlWbMgLc3k
	6RLB+VOqbG/wEFbg3EXag7hmTqMbVj66kBGTDCW4Y7dpmdS74tszhrUcYXzoRuQa4xKaRK
	vcHnb8YpFo6d+jodY4vBUWBPvBR/rBo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-LYmqT8bVOGiLUiuwjOb5lQ-1; Thu, 07 Apr 2022 06:04:27 +0200
X-MC-Unique: LYmqT8bVOGiLUiuwjOb5lQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJOQlxDhfbLWvcxuXCdh8xeduixahLTKGO6shdyKC2HtaSFLF7wQcIbU1yGVvW+P6O0lzE10/h8bSzH5ldNuyEfX6MsMhkEWPBEUUcpSlg/xsSMc2MYDHkYa6YPIbkN047yr1//7qo+5NmgNeZ1/95HF2tuz0/h4tLGERjXKdV/gNtQHapo0tDnVIXtwJ+RV3G1VfuuUtaaFG6SYfzrPp3JyACTl8c/XDhSGufuxdJ7mSIdHL0BNuJHbItH5/dcVMqa/9PVaiSHM570lO6hIkUNUVY2l/FcdTkD2W5iRFjO/4/a7Hq27hroz9+XgaJicym9VUxAfyuSZuVMkBNMPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOdAuin0+WlJ0xJtAwnzP1+4kZRvBP31SVfaLs0bnZc=;
 b=BxEyHrxaP4SjQH8u54sDqdZbt1IefrLFstkYnW2pBsuaGN6DHr7N5CymS/+S2MgE07mEGAJa4SG9DqbxqwMbCGm+WDC38P649iuScdRhbCpWLv19/FPG7EChIqlexoP6xF8+jktrtVwG/u5Lb3N/DnLQ4CieiP8gjAVVcDq+3ra5zwFdjr83UTsi9YqXrwUaB3Mn5gGgTfNoWTPCo1++S51pVqWr5RBmc4lP3WKHFVz1TW3RAYzCfZsdI9ZxZgfasDVFaBmvrAbOxo50i+b9i3WpW4epO8vEFM6Cv55gBScEZOCAAXK26/sKA7nGvJW0b7bpNqU4pe53QQoZL23HCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3354.eurprd04.prod.outlook.com (2603:10a6:7:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 04:04:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:04:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 7/8] selftests: bpf: add bpf_first scheduler
Date: Thu,  7 Apr 2022 12:03:19 +0800
Message-ID: <2ff358a960acc528e430c5826ad8150028a8ee95.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649303876.git.geliang.tang@suse.com>
References: <cover.1649303876.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0203.jpnprd01.prod.outlook.com (2603:1096:403::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846d9047-fecd-4a69-4b31-08da184bb51f
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3354:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3354CE1BFA5349EA8C62C6ECF8E69@HE1PR0402MB3354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aUlGk+c25e5iw8ThrsxJ7SAGZx7aRoWlwobRFm9rL9oO6bUzcCVXwQ790LC+rTVGiEE1ZOB36AJpy5Kw8OjzVHaDy7tx+r8ATxHxGzutW1cKhaUKPQ9Gw69FbdYtTuUCENlL+jMd1HnA4YKqPUuccH0NUDvVtJNOcB86U+JGLuSF5+CNrmIfhbbQ0rFSjP6leP5G00uvttN87ki2S0bpGMqVtS7rmivPv977/1rPGIrCMU/I4Y++wd8wbFqUHQIGxV6K7dZ3ZiECSb6ug5co00I+nl14NzURfvw6pgmmKrlfbOa8elTC0J4qgyOEfDJDe8mBr+8kuy8OSGKitGgdlBFp7KKehIsvgI1Zuhg95Y+llTbFWY2zkhEBK8MxAyM2enb1ihNcDGuvLLkEjq8KjKR17YsPaFPVX0HtihJ+MPNMGkFgNY8MmiilMnO8nO3WtXvL67lPeHgmujrTAcNzZVAsc57/zTIoGoE7cgoxi8/u1foeolst6ZLbnt9DbXkXjAxxBaZsKHM8X2K4e8W0cjPbpibBj2rE7tfeEaRecDANhDNM7d2JwEn02XgNj/wKtuRFInl9hhcplqllKYYzughbX1tSG7vBoinqd3rTDdb1nktkAEueLgsnG1dyCmP4Ls7aIImvaHcHOXMJqDvIRKhocAt4J+646DfK8hWofkIPsxrXYaBwsgewBM4fqF2RwvmBPoDFyWGVIfcltxx8DQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(5660300002)(38100700002)(6486002)(36756003)(44832011)(508600001)(8936002)(83380400001)(8676002)(66476007)(6666004)(2616005)(6512007)(6916009)(107886003)(66946007)(186003)(66556008)(26005)(4326008)(6506007)(86362001)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWVjw0OezMGxJQORIgLCfo1OwuENA7dd3A2B6hFD/5g+Fu8376VjiK0z2mAb?=
 =?us-ascii?Q?E8U3/krvbBYXq9cjJ/v+PJDGooLpj1qzT+GCXcnH/IXVfFb31jenfwxKCauD?=
 =?us-ascii?Q?F8JSoVXng+HxrHPNd/JeBEwM6AQtJnZr57zMxYeP+BxqsEkTX6BUrUMtqO9b?=
 =?us-ascii?Q?bg4gX/s6mdGzeK1f+0xRMVx0PFhztyly6Xvzmvu4HconZo4p0cwK/cP0oPrU?=
 =?us-ascii?Q?dZJoVNQT3L3tTo5S47yJZp6dQYD1k55eHzqotP0nZLfy9csQ6do+XwMsNeM+?=
 =?us-ascii?Q?J8rFrrlHOi8y6Ne83EkNtHu11zNIfggPAACqUlAGbcy0QPay6F9NbDA92eJr?=
 =?us-ascii?Q?Q4xnAe2LQbkQUI0Oc+NSJ18acEv2FevHc8QN0azcQy+MwEbYaiQrU6f0tz1B?=
 =?us-ascii?Q?dnDOdYELofEYsrpbUF1pRprHmp85UbTG5y8tNOX2PBHoGaIupoUTYBqHzGRs?=
 =?us-ascii?Q?C1bGBj+sTVVRX8813BLnvVmTcNdhuXxiOZ/szVPP/Bl/fiBDSb0IYqI4hZdY?=
 =?us-ascii?Q?qaCVWFqgdye1BbVic87IDX1FAhproHyJSWzprmVKFJb5HvzB0FBlTTIU8Dxm?=
 =?us-ascii?Q?1/s3T1IHA5g6WAQ5ImrdbQJJizC7zNIZkxhJoj3V7aUEACGTx2P22jLkE8ya?=
 =?us-ascii?Q?z5K13FgSHI7AY7g0WgDa6HqAez+KCbXbjhfdJzUoX+UWyx2ERPpxoJJJp7zX?=
 =?us-ascii?Q?h9CoZQX+OpEh9cm+fCYVCqzg+Mu7q99EpPuuO0JtTVkwX43DlTersmWxt2PJ?=
 =?us-ascii?Q?4HAtwSexAA3SiibF+kf698Xv5jRRK35KzitBbKQkc1THoaO/61siCxXpOrMR?=
 =?us-ascii?Q?iCq3wBd3ogmDf40qHPJ+zSGhCVXTBJUvO7u7b9/HLFPYmDVCa3r1mBrVaGvU?=
 =?us-ascii?Q?xNnjI5E7u8mlMtS6xtIYB+mRRVCMwUylpmlsKtyRm7qW2paJCBuHFxpiUDLq?=
 =?us-ascii?Q?7McZWiiYtq4m3qcCl4E5qX2OGmPshohGu5SQ7oAzB+TKXE4Xz3ltjwqWkMM9?=
 =?us-ascii?Q?EYYS9wy2CgWV468bt9qLHckX9OKlIgLMbPt/3a3sZXL+R7g3UsgfZ2tA4+e7?=
 =?us-ascii?Q?cUMBnk7A+eD88Ut69y+eIMJTLdGK4Pdw7l3oparVV6+Ms8J/5nWl/QBQne2Y?=
 =?us-ascii?Q?Mb7jUDeOvVUXkPdQTWhTdnd8bQAe5cEYEYRjwB2DAjUxZpmZjdkqoxRitUFl?=
 =?us-ascii?Q?uMsrf6OpBCXnVY9fIJb2l7Q3T3NKDqV+QspZwQkMqlMyXvKWoICW6ZfYTOjY?=
 =?us-ascii?Q?lRhh4IfnXS1Aqg+c+VDzEV+dH9CShAKjsTkl6Umvp+7gUxiXfIbnNvX+CE5n?=
 =?us-ascii?Q?Drf9yGNde45yFLWaazanEks4Vw/X452dFnPjnH+6beP8ziC3+7Qsiz8rHp2o?=
 =?us-ascii?Q?0A03dlAhYcb+jkZ2V7Oiyc2y4AcUJ3IaLRa1HYYbqFzY2YobigYpNbDqWM7K?=
 =?us-ascii?Q?LjyDyllhGDDgEaTJKtVhV4FzAhkFTEvw0l0eRwUg8tNw1bQ0MBkgvtHbpRXk?=
 =?us-ascii?Q?9XgTSePMrv5+Hhjo8y+189LmHCTsLc/0th0wvIYicFo9IM58cp6UimmNXmQc?=
 =?us-ascii?Q?2RqeuHz2uWiQpvEfuBbO5elk9QqA/aFtbX6XqFPosEJPDHC6gic5fNdhXl41?=
 =?us-ascii?Q?SOKGOu5ZyAw2KZERGzUDksQ3Jq9WjRuqLP1qKhQCOHK2daZ324k6ABXVA6Kc?=
 =?us-ascii?Q?Sx7i92JY/naIrlR6yRwHjiUQ+VIqart/wYJ9gJtEbIPXYAlRRHI8YO5etzyt?=
 =?us-ascii?Q?F0oD6uqDXHbRhCZNveXN77xrsvKJJfo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846d9047-fecd-4a69-4b31-08da184bb51f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:04:26.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkTc7dgdFjF3whXuJ3aYr2JCKv5ih4gRJuhMF5V/IzglSz5Ywgg/QwsNNpWdqLv9EjzEWOz0MVcnRj8QOYkBew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3354

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 ++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index b5a43b108982..5135eb6710e8 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -14,4 +14,16 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
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
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..b1f9a376ab75
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_mptcp_helpers.h"
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

