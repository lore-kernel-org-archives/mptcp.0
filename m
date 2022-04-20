Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F487A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf0/uTaZ1616mhS+pueyarw3L5pLQaiyErfa94XSnIw=;
	b=TPKVqcmSMM2bFUC+7vJRf9ZwKG8+fEWYVBhLdnihZBjwQqsck2m2fycWqGuub1OhN7Uodm
	7vrq7GCKaSyx26sVYUarSPr2DXqQmOA94XKHHPaCdFlsmONbi4qFfBL8W0MxSovi/J/zXr
	hFy2K31U60uLMazE3mMhv5OThZRLDos=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-5lcDIN3_P0Ch68q_B9Vh9Q-1; Wed, 20 Apr 2022 06:58:03 +0200
X-MC-Unique: 5lcDIN3_P0Ch68q_B9Vh9Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXbrAAlfgIp7orFYdMdPFgxxWmiwcfSqK4R9tXM22Ro0TxMSTqBR/zEd1xuTcTua8YB3/ipW9cFNeXPX+/nqMq7uNK9dBc0Momh1RfnHcUYFyTIwwe73GVcFeUqtMG6N9L8IdMXIavaOANmUzsTXGOKFPOwXq5WDqa4hurho2DrZAm8c0uTIxs+VjYDMJUKntUPVMP8vd4AHGbSrdHE/Xx8Vk2HchId9zjThWFkByz+uNZLUa5pASnSSz65RxivK2RgEOiwsbE2ZBHetAAZM+3RukYqNJ6hjQtOfd8qvOUWOnT5+lCATgqV/6Ek8SlQnOte16rXlWpiunId16Oms5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSDNd3Msfs7Xm92Ue1PMSBuLrILOFWwnrMShpe95ATM=;
 b=SaJ0ZUAh7KcDHkiQEEIf1ZxMIFYBA3hgDLOXH9S5T1iw+wkmnMh7+VxBkj65JhQY8lmNlJpAwg/bpxXzfK3R8hxAEaKXWN5Hw429n285t9fW3LWtGuHxcYbBVaMZ8rOf2kKEVmwRpS3pbrTPrKvW2x2+41/UXIEcZysZLkUuELU2S6oH8bxtpe3LDkPDPywcLse98SY52QQsVMPTJJckz4pf25FpDdyeFAdMiQS+Ol/hT7zo4KEbLZSJ9LjhKKl0Cq9qBLATCR5hNNlFgpTjeF1UMEQphjzLiL91Xdwtu+VQpMgxkWJ1+9vNT4fRAEHnvi1cot7D3sAXCm+Xe2wRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6504.eurprd04.prod.outlook.com (2603:10a6:20b:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:58:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:58:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 09/10] selftests: bpf: add bpf_first scheduler
Date: Wed, 20 Apr 2022 12:57:08 +0800
Message-ID: <017efa90a2ddb36d4c9a5b88fb07e6c7bf8b6b7b.1650430389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dbbb48a-7689-4714-a61c-08da228a597f
X-MS-TrafficTypeDiagnostic: AM6PR04MB6504:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB650438B610D20EB1814EE047F8F59@AM6PR04MB6504.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zKwe4HSnqS2feAJ1EXV7D/mJirH4P5JptAbnSJi8ArGrtGd94X7r8AzT6OsLrv4B98Aqh9v9sUT20Uf4qae5k/ZqDt9uPVs635PMXWLOk0/fHRcP525WJaS9tA161WDMAcy9S4hvgjWCxXrAaBVAF2bePRH0CoIizcf4UcMhiV8eCabG6/UOgsyNJn+QdhjMYVmMUFy9+tMK/EesfhmwBsgOhc4GGF/AAcr8s11Gtaqp6mYKBalYLOEINed99FuHPGSiO2hPUDmyv3TTgCI3qEstIW3BQ4uq3vxqwXuHyObFf7CY/cFy8Nj8Jma6PH0pu+/PV3quHO5DIxgyNX/EHD1kuoqmaDyqNLBpE/s1Wu2igfFBHiUKCmP0gb+DdPbl4cLUuY0RaAcxB44XhnjLiuRGfa+Vtb8kVDssQMLA0F/bWtBLy1EeHacsfvIDisrQHQedFfj8ol6HvgB4QXNkul+8n3R9cFyKApZtj2TtGP90ayaEZvD6u7KQFIpQwW9t8mucx9q1uC9XxojjZ7BeVbVyp62cPD/u1UEhZ9sd849NbNxsEneVvplpU1lZm/Y80Dq+2NF4aQN7RjlbPuz2hdctl2QIMlUCLyDyhT/mB/uQObwfmqvXxgKiJZJwyGU5P2fDZqUJAeVYkD9/di++vJc28dCl3O/zRQdsKzx/Ninh5xEB8dUaBZ78ZRLAHiRYazD8aw11dA/Ar4cYFGqSWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(44832011)(2616005)(6512007)(26005)(186003)(38100700002)(6916009)(107886003)(508600001)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(86362001)(8676002)(4326008)(5660300002)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMVIfcitG6Vf09Pii0oNuI83sS82+B6+74G8yTkt0XAt6wc/vb7kRCJeUWlU?=
 =?us-ascii?Q?6dSFVTk/HcQSGXYbfPSivUmnntyidTS3t4i7hn7+ohP8kuzOiatYbtNr2X80?=
 =?us-ascii?Q?KHVgDUHelY57dQzK7g1O+hCJ3YbKusxxHOqmVV10SRvMoDU0EExSmm8or2M6?=
 =?us-ascii?Q?j9tz+WquFbb21TYtojKvYlRx+qOAghgJyooCEhUcomrZIySfD8GCZGOYgMnR?=
 =?us-ascii?Q?rwXk7o+2FhxJA2MAhiXBotP6h0oSvOEpPnLlF508rjhp792fgcgY6eNcuiiy?=
 =?us-ascii?Q?pk/nzSDIy8W0Imcsoz+UTzd4X9luggK0y2OJOqgq1wp6VVuM1cuYeS9mYMoz?=
 =?us-ascii?Q?4Ux1WDDWwxnHvRDnWaU+Vp5OkoOEN8iNlytN823tQqXnwuQZW300QCUi3V70?=
 =?us-ascii?Q?BDZFEgZkvjA3R14DDdDtQVlS3eUhiR0HCRgsUo0H7KQ9L+0xtnlY2TWWB7aV?=
 =?us-ascii?Q?fu5Vfki64Ms8jCHyAopgHf1itCIC7IYQGEMXcUdHvZm5kXHoSGMKdK7Q6yFB?=
 =?us-ascii?Q?QxYYV0dLb1AZUMckHqMqGaoy1BbRPAnGMauZmGj5t8A1FZd0iJiHdLB7z2zM?=
 =?us-ascii?Q?jLr967Po9yBZp0a8/YoSgV2hI4V6ZJpoR30igR30vF5SRk9DtXwfTTT3S5Om?=
 =?us-ascii?Q?MgK/216tDICxk58hSX5zE3iDo6OAAGCFLaXe7JL+Cqcrf4+JdpBHaWD86g0S?=
 =?us-ascii?Q?SpKybrScjrtpSSySX08GO2EiPyRbxm0E4K2EKjJs8uJ14k5Qdi79+hk75hbL?=
 =?us-ascii?Q?NYijBtLti3duJfZvNNtb1H1V9YLRlLOSXWdgLpiAyBID9OI4pUTJaC5RgHy+?=
 =?us-ascii?Q?Zw/GE3EIFYM/0rPMDySx2YWb8weMpnKpDlO6UsoYBvbZO/5q8UHfTSkTB1hP?=
 =?us-ascii?Q?xc3oYsTqq+DFyrbxcrIsBKdAm5kDf7VSSCVroRtnvEF/c7Dxa1ryHrh79zVJ?=
 =?us-ascii?Q?R8d27gsM63Lhf173uQAdBOJDiKJTeNN52PBGkkSi8t5qU22VSx/6A5MFzqyq?=
 =?us-ascii?Q?Q6IMKFQ4lcjPbZD7bxq4sU9TO1UqvrTB+oKtj7P8L7QuYXAWKjHWLzdPTzOl?=
 =?us-ascii?Q?kFoWwUsoHhGXhALGCgLpnbPmr5EkBNmlvLU5pTA73YwuuHq2RuF9tLtYToPz?=
 =?us-ascii?Q?YOM+gvb60+keSy1vT6vfbwcctkbqagYvCR+mokoUc7raOFju/WKT/7qv6vwi?=
 =?us-ascii?Q?kl8xYvfKZG6wSeh/j2dARj7qE8TuCUvMp5PemEBNqHIsrvk2N1l1DbhKB1tT?=
 =?us-ascii?Q?48w1hSp7ix7ehkM0OQrtD+/+jjTHemHoo7Ovr61PvI9amjKQwKGAxq7QF3an?=
 =?us-ascii?Q?i2swDK7KqYkPb6TE0XP2jzVLJnTAJQ+YMRNCS/2RoSFv1l3WUfUXKuOJ6unV?=
 =?us-ascii?Q?bXBSg1s4vPIcsOErpEilZ4P8IXo40Z/pDE2HgUQrvLJkQO1fStjYgtl/CkEB?=
 =?us-ascii?Q?lecLPw+NauBl3aWVEqWy1VsmHK6Et/Xgi+56Oyw5KzymCKuccaApoNDYCkX2?=
 =?us-ascii?Q?Z7+wkCkDG8S9NDO/HUcEwQ9CwGCexifNnz6CPMcO57/XYO8X6Jl6yCbpiFuJ?=
 =?us-ascii?Q?4HlHB3k6sxkpgWy9lltugoieXQoLwUEAihzYMkZihG0eySsbGK6rw/3hvVMJ?=
 =?us-ascii?Q?6fOSg8cNsdaSLueJlYY9R6BVRODEeDLmCfjmQh4WUY6B40Aotgs5kPFXWMZ8?=
 =?us-ascii?Q?cIw61M24F+yCJMgNzCTi+zzfUJMShiV59mEsKPEC3A77vg0pEU8pidX59deC?=
 =?us-ascii?Q?//QrefzxjnhkK7fayBBL0J+xfoibal0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbbb48a-7689-4714-a61c-08da228a597f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:58:02.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXMbOcIt3+VH1zw5KLxiEfUeYCTjbM6GVhphJWaNpBsL0vRXbqoS2f/Eo46DwxEVOFOf0oonc3tixpAt6xSCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6504

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..425b89c654b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,34 @@
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
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,=
 bool retrans)
+{
+	struct sock *ssk =3D msk->first;
+
+	msk->last_snd =3D ssk;
+	msk->call_me_again =3D 0;
+	return ssk;
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

