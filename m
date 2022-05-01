Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41528EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651412995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RDlydWiAwHZ3O0hxyi4E5TKaVuJH+Dk8t/1KIGdEMI=;
	b=Z5YSaH/yiDQl1arJp5Nd7XSOj050Jt9fGlfIvy/PqAmH4bEaI8CsmkJkD60DmiEqm1n5RK
	ong2rP2VGnyzYBPcqnzHObvjdSDYt5agxo0WkYL+aPiuWTW/xIkuAYXtF1bzqI33wKUty+
	ck55eumdNjXBRqpu6S/q7x8tJaxFb+4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-UIGCeykbOWy4Cpa5aIYkWw-1; Sun, 01 May 2022 15:49:55 +0200
X-MC-Unique: UIGCeykbOWy4Cpa5aIYkWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA8g9Hq+t3dBnzdbNQ7AHShERJa/SKAQpXpaVtXik8PUTdG1DJLGw87uUFl49Deeo9ir3uS3RXRhqRhw3skNq4UBf1Kx7gGEJymQL/pPgYAL9pCa4XnrmDuB3m7cEgy8jnhvMc6cc7CKJl/Ar7TTdteWpywOP9lkItVdPdeFB3g9gogIlqxLkFZQF5NLGpLqSoAnE4QOC7dPzfjqVjb6vfGKDagddY0mGnb5+0+G1VklNpXh+wDPCYPdBj5BEZrHSmcd0bJiXA/igUDQfx+Y0kQdgGOkWv6RiOsw0HHfrs27C3KgM96x1nIXFD09jABbz70wm/ceCCXOEbPdUe/1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2K1eTcXjHmFeX1syZLtPL8603gz/hgxgKtqjwkUSFk=;
 b=j1PsdU+PSw8VEoQiK0385AW0QC+zRWIPmbH1nUzRCp4/65bFj+UaRliq2hirxomSYNZ7Twwjsdybvw8ehPoovAjQk9gscojoMNtioAhs7fJao0F6GDj92igIHE91TKTZ4ktmgdfEz4/PVVPqvB50QLHbsQTy6sGfXx3grga7MMs2j4ZTWzVYSSfyqSQ+r14WMdA9hgl3Ej1q+UhXQ6ObQXsvjKkBY4Ilj49MJoe5A55HJ/Qk5tB3a2HvYjAz+xoG5cuBIduwYTrxqIpopymjOat3DZgdeN7OjdNQl7Eb40leRmvdJ1GWmSOhP1wCYv9dJ2Lqfz6SUvBiAbGy8di4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:49:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:49:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 6/7] selftests: bpf: add bpf_first scheduler
Date: Sun,  1 May 2022 21:48:49 +0800
Message-ID: <714655ad6f356914c4353376c8e5ae7d647cbb9d.1651412613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651412613.git.geliang.tang@suse.com>
References: <cover.1651412613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b60b796c-bd0c-4f19-08e0-08da2b797871
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB628349D25FCB6FD09FA09427F8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KNNvotL/biC3ijSrW7WFY5+A2O6y1IgvsiKTnEQLPg/0mO3CT2W9oEywoxP470rixs8qCdRPTAsD7BzC+oSOxdJKHcn9IgZZpVSfCG7iE+aPZjyKMF9UfIzrMu50uDrYxu03V9wlmTV6HCUVS23K9r/Wx+In5JkgmYlC0LcT8fwTDg7rJRkIl1CODILWuyT3ZL3ZywOOVMgL9Nw/fK911ddbyoiTFOnPlFZRiTtgJogrPrB5p8rBDBmImbWB8oBIEAgc79g9wSIoJgCVMbefIEeVMccFcZimcGVDYm08VPIkwyH+Eb9b72FoWGlhw/+h+Z83Xaa3dLo5XPpWHy3kxVu4oHNG1ZJX67FFxAR2ncdTa61dZ1IoJb3qpAE8no4R5oaY8N483u7nRXUEkEfMaSqNZsvmVRV6RNcYui5QEySiUQFLYzXnTb+smMJofSnXD6EkL/tsMdEk5jxsb4qv5I2C0H67qIXwUsA3D/DtHUeB5WrZLKMw1UXuwdKIQcXEi3Od9feO5y1on1diT3p+rFDza34SN2z5SDazYcjQ0820Su+b5sGJfZiG7TAZWZR0AgnPp2ZzcGXA3eLjKO3Mt9ZFATKEKbnAj+CZl2SExIvByY9YhmgoDrBpGOloHQs+ZJkQEiRek/Uff+K3JA01nsrnALnaYjMhkdDApVgV9ia0bIFAyc+ow74fZqYkjyF+eexd9Pk3d6t5XwHsjVUxMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(5660300002)(186003)(26005)(2616005)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(6506007)(2906002)(107886003)(86362001)(38100700002)(8936002)(6916009)(44832011)(36756003)(6486002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVvYPC/Gcglh+1hyXw01hvlH3WydoqefmPliB5ntlmVxhT87HO545M2GbX9k?=
 =?us-ascii?Q?SB5x8C+CdxyZkDgQ6rMHfQdrrPDqUvYP3aHsXIIJC9aeyLRTQeTke2jawF7/?=
 =?us-ascii?Q?xelrIsDC+HCynDuvGXdOYpXFLG82AbuuGlZINhUJvYYAhY6TrP17v5+EV+8k?=
 =?us-ascii?Q?ux/99L8Z/Sz+f08eA7wIyx7j8yyshjz3KMswUv7uDc56fZ6aqkkaNiz+P08/?=
 =?us-ascii?Q?HZ3UzzOj5GDXOtzcFMkgkhiAcShGqYJCKjXcYWNFYMg4bxLD4didZTRvVvNN?=
 =?us-ascii?Q?Wpdc+5TWALJzxWAHg5BFRbIdpT2bZCxYBJ5uNC81X7VWk3HOHv0SLfqqWXXZ?=
 =?us-ascii?Q?zhKUxwI4Xw28jk8yBFLboa83zeNXAOjFcA4D5QSxdSzmauqRLwRVCq+/asIu?=
 =?us-ascii?Q?cM5YGhfS8nD5BavsTqvWzN3FWk4eDFUUw54E8EfWr/ZggWuFxMVRFD/4T6Jv?=
 =?us-ascii?Q?cshhtjswEUc3OOEim4D+d0/rCJ3qsVhdHuWb8Xo2mSi4D1/jZzQ9E/vyLDX2?=
 =?us-ascii?Q?QPTxgDHQvqSFtsT3pFzuOevuknANI4X+Xb9HFuH20mOUuzRabBOlRJcgjXJz?=
 =?us-ascii?Q?thzJNlp1UCiBODiWZksO0CecfzrUZ7vNJvPwrvUE+5vK9S9TcQW1E9OMs+Kg?=
 =?us-ascii?Q?5aP905nqznU7l27sCu2h0dC5KAhr5pX3ItIkKiUFsMNK8KxwomB9cK1eFVMx?=
 =?us-ascii?Q?YxbzqHtCTKWaw1Zu5/yGUtF5hS3HcUxRLU+tToqT9UTuGq2EC4GcmhSwLoOo?=
 =?us-ascii?Q?xgEgGyUmH4WQRr4ZdmuP1qqIHZMEq3peD6KTWrJFl/jf2QRG8h0r3cpaTZzG?=
 =?us-ascii?Q?GavDURIiIpnHrUcdz8BFyULz3/9LGGSrWz0n3yjEHCbIFfdl6Fu0CPln2lmX?=
 =?us-ascii?Q?CbHS7+uiFEgEKsz3mUu1Ec0e0c+5MNzUA3WbErEjCmmOxOeCCKdB/+YF6Y0O?=
 =?us-ascii?Q?1IB1bGErMh8091inC9GMrfvvjV9hKbj/ExX3L0TazC3TG6wUWH+lD7X3N6hH?=
 =?us-ascii?Q?TlKAPW9tsnwl29/bQH9w9sAvsVxYSOZ6mRe2Kup2WzcEYxt/xQ30BkNJxK80?=
 =?us-ascii?Q?Vk7MnBOau8jk0UU5Gs+ujNAQgSK1Kb3+2yIvc4QfPWVLw+yhS2OwhUD6n36E?=
 =?us-ascii?Q?bacqASyOfkDbyyUJPHYCSGzIl/zpEd4UaC3byhJMAlbxLMxlTv3loWEeNgmK?=
 =?us-ascii?Q?PCNR7Jbf1pPlL4Z44I+iIcEh0THOVSRWIWIQ+xDQhrEfAIRrnvOoBxsu1+zs?=
 =?us-ascii?Q?hfoAwdGL3mDDCaZ6H/pses5bfo1h80V3MdaHzsNNBFy6uRC8pHKC6a8SlRbF?=
 =?us-ascii?Q?c7Pq731y6Z184fpKwr2F/oay7LxDlNVMyPTBy900Fiq/HRlQoB10N43x+78H?=
 =?us-ascii?Q?mvbFFhXKHpjNEsUkkyhuiTtKIKK3IaiLBE0j39dr2dazs1ucXrPn7WBH/hzS?=
 =?us-ascii?Q?u39eSZ75W6zKu0FleTlFH01JtIVNSymVmokXVKbbIUukFH4buClZ4vsBmDni?=
 =?us-ascii?Q?4giCEA7oWMmlxnht98hO/UoCX6QuDkmo7z9v9E58Nc7hhxaM/3j0M1G1sgAN?=
 =?us-ascii?Q?bXWT31/Z/AZoj8miqSxmNuGMIogE2+RQNy5jJ4Hlp4MYCo8c3x0b8WSkko2e?=
 =?us-ascii?Q?ugdx7fEEtQfH9q1y23CuaCEX/fkOtEB5IJOQ0A9JGxX+Gk7gyEmyY79k3HCT?=
 =?us-ascii?Q?siHNwu41ueCZaXEe/Txsn1xG29h5LgRTLWvgBfdwppzov8LpTkikHkSS2icY?=
 =?us-ascii?Q?3Xz6dPSZ/VLqXT8QjDJeisVrYgsSz3M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b796c-bd0c-4f19-08e0-08da2b797871
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:49:53.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMHfmKQ1HqkmOrPMFrPJ74aBRbpwhJTRSOKLa471nwX5VWwBuBLrjJjNWCmYA0ziLyPvmuLk7pYjDYSfN2icLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..0ca9754c078d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,32 @@
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
+void BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
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

