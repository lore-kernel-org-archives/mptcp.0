Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A7256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPa7R9ACLdeZPMrYSusDTUnuEbInXERfYDRR89v1Y9g=;
	b=SCN5bhQMNIu51XqGMZlFL41Wq80a9Mzc95fPhVQVZP7vn0zSyq5IP8PqtsapenNtwcQSrR
	F/MqhxtdpwgYSKVZ2ATFDbsZymEp8ahmoM4CARU1/n36OMEyupiojlIjLoteAdtVp6oSkP
	AOldskq/33ub5yXhx+DQDkXl47BOYVU=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-vifR_mLTMFa_0Sd1m34Y8w-1; Wed, 01 Jun 2022 16:09:29 +0200
X-MC-Unique: vifR_mLTMFa_0Sd1m34Y8w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/0YMTj1f/2UAtI3A1EX/nb/mKkaBINbQkRCD7njqsFQxyWeCWye/+XB1y9sflQLOqujCYpF+ZIUy1bVH9NhoSbXYQkMZkdfnMJnZqAt4cqX1nKyLwkRTB+yIH1LPBktFgjIx0buYZdffS7MVWTBAYSHvMn8yfS7oaNcyfVsDSs7jTQd6lg1TeNNDMSJsD/PLcwYlD4gF7/nIRF0R+S/R6rQ2dcPOQRhQCdlxBKVYWkfjVEpnIOH4VTMwkwzY2UFGtNcVDlaMvdfL3LHJQRkaGog7yExVeaYOOEfuM6OhBMncHk2sCzyIqQxMAbxIGs4Oif+foxI8QuPJa3EoydKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl8vfqCehhAPzSxn1YtSVY8VkOLHykHTcsdloumIXrM=;
 b=OgLm2UwTIpSuVfY2mg7H0rEHXFrqiUdxdNPxuzo9RT7sD9Vgjx7tk8bLiROzhqvEqxL1sQ1j8kYOgEfqQ3g8SUOl5cxoYdaSivW6pXs6pqKAfqebm1NqshH4EBDCyp0e+XXw24zk8gg8mdROeS0cbFPXtVuKP1zH+tz4Cq4OYmVJGQ4W61cFON+QOpdMfvSrkljrlQW6NJofSpNSxL/EJddc4oGY6AyY38jnUIA+CIno5xQx8MeFiXy77mcz94Ghw8/xAvA7kj29xQHYw7JY8zSKt170radHjq5N59YZ7q1KXAyz/+Q9M2A0goH31uRrVnxH+fhLIE2OY+6bxHRqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 14:09:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:09:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 08/11] selftests/bpf: add bpf_bkup scheduler
Date: Wed,  1 Jun 2022 22:08:21 +0800
Message-ID: <1bbc1cbf69af658c86e65ce332c93d47541ca034.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0011.apcprd03.prod.outlook.com
 (2603:1096:202::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 688d4929-e5bd-40e6-9a0c-08da43d85742
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2935:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB293551E73565EC6E7E87385FF8DF9@DB6PR0402MB2935.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aLWIajM43Vdmt4nKC8eEsK3JMY1nKr5mOQCjc9tNWKIziuhXwcv//tGZTTzKFC7Zfei2yr/2rIaL3QcJpoGgQIbgCOZcXxfpIv8VIIQNfn5BceOIPadXHXBSoDqnJrFk+1ioptaLbB/8206Fu/W3rWk+fVRYR3Af4yKsviuuwEgm+eajw797GBuAZDxDVKM7Re5rLm+UIZ5wIRmNDMHyAiq3QCSjUCoVExLl6vpbzpWSwG/5o3eWtXmcnR4qA/jEinO/SrI8T+H9RD7DtQMBDyZJS1d1awgyiwKeEk9Zjusljhf8KakgdLHKCHDiXxsIItYd4bMJm7gNkLdbMuNIyB8n1xCUPNMDNVKfitQXFhRoAuY609cthqmeD9YPmIW/U3nk1FaF63ZgzHQbPj6FxGqPgoi7G6Mqvj+TdnHWvna1FqgNDoiyld7Z+aRl681Bt/h0Qwh9Avng/68p89dXZEgGly4SgGoeu8qnGO1GWSGb7HkZmwvREtBZPCmQoWPgEsgByBffgWKpi8l9M7/abHT+psTe42meUFwJw9GmbHm4DmoAdEKYY0cMxtgutwJ/4yMkh9drWqXAd8ksZOm/6BnHg9+2F4OxmH3jCcoNTJbngC+kT5QL2tmMwsOGBSKcZJIjpI2ZSkmdG+O7ArWxBOCXLDyNPgGCClHh6/Tn40GRSXXl1TRY5bmeaMr/L+OvJwYv2YEOFldD4OZWRLT0ZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6916009)(6506007)(6666004)(5660300002)(83380400001)(38100700002)(316002)(6486002)(4326008)(66476007)(66946007)(66556008)(2906002)(107886003)(8936002)(2616005)(26005)(6512007)(36756003)(86362001)(508600001)(8676002)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xhx5i09y0p+tkPlJyBjm9usIrkV7ZTvQ+2yJZ+rP9nPKwaRxlqkLZbzoAqrm?=
 =?us-ascii?Q?MgBW8gvt6WMmmkz979+6OhU+WTFNd1qKX7oq+d00J3+s7D69eNvZd6oJZPBe?=
 =?us-ascii?Q?85tDcbBSSBGqwNqq5mbwrAhwB1QY0s8wVql9MA2xdyPHyMXoYferl+v5R4WZ?=
 =?us-ascii?Q?tcnwuKFazoVfjqkn+4QgTkf8ESzKhdLyEJISwO73tajH16n7Rk0AockUvl6n?=
 =?us-ascii?Q?6IphQDPfFmBfOmvQxCBvgFtVZLyi/ad6wel+FhPMwxmYdaTZQpn/dIK+rcxZ?=
 =?us-ascii?Q?gvTxjMnBJxHZu0Hy0raiJrQ0CJwLNZnq2l8KnpAp+qs7NnAw3vAniI9XU6mE?=
 =?us-ascii?Q?APn/kmjwCyPPvNWiDat3NEn1eGfIAgKd9v/vQxkEicpZ/1zI32xjE2Qzeq10?=
 =?us-ascii?Q?Tw5Mr+17qIkj/S6LpJpjcKHv8JFOCj7VDF98a6huGVGYRyeJ8sQKlLqHeNwK?=
 =?us-ascii?Q?AtKomfP5gVdE6kiNgveLQfrs/Sx+Sis2hl7Boi616HGGPcM3YEPrRjKOxLK1?=
 =?us-ascii?Q?uizI335nAXU5zk4I3A/uShZib4crvInAgw0UQq2t6ke7P+NLeg+dtboBZhAl?=
 =?us-ascii?Q?LSroGCTfo7EvyzSqiya4g8Ih3f8BqFyimFiWS2gfuD4aWOBvCO7VOGSE44/+?=
 =?us-ascii?Q?9ZaqKbV3DOmOqh6lBr4sKYbJNwS8KUh8bObxkuWWhtBvqLsSj/BqAtoaKfzv?=
 =?us-ascii?Q?VIB2tH4K4hGxjuLiDWnikEloHqrKywlfnJrjSfB79673vGmIvFmViTkO8552?=
 =?us-ascii?Q?Qfst7GeHtE/ERy3nUlB3lqjQaK5154W5ltjxaKWyDPutLie9YPuUyiiDyuAt?=
 =?us-ascii?Q?Nr7CCLLX0xcbOAKsG2GHMGcOPT/uCeMcdbmFlNoxi/u8rWu0gsIXQBdkyAXh?=
 =?us-ascii?Q?BanKgB0Yj6mhsE+yGtTtOtwl0PxF2oQQzypGGbbVR5GSC2Lqt4ucirjuMsyc?=
 =?us-ascii?Q?VQK9zTFfC1GWK1A/17d60eOMFKLZlMXPVenvOhdYuoFAdAHmcjbTWFS2fHD4?=
 =?us-ascii?Q?idVMvxRr72EmuCm1rHU1lWeADvUfmjPjUX7zQMCHzp0pWVG+TvCDRJnjJlMx?=
 =?us-ascii?Q?/ds3ehvLzJo8/Q1bIiymPZ6+dw2I+IwYfR60CUxNdTN+K5CdPlZbXFTsYWx2?=
 =?us-ascii?Q?JyB7Q9XeHoLq/OZbH0k8jN1OpCSz2KMkPHgvLwzeU4+4pBWkEfyXG4mMiCIP?=
 =?us-ascii?Q?C9BqVq7SkuSMwapwb8Jf47bOq3y7pWWrmWQ+ZJrtL5VWnDmGlmCNn9odUICk?=
 =?us-ascii?Q?QmAzuwGiPhAd7hNJLwXjEZW9UxLklCnhfzdANood7+yIDOLOKhchDdJjBWzn?=
 =?us-ascii?Q?Q7nrfTt0Z00OE9cKnT7OfOLuNJaP+KP5eVHVLtUOOKpwLCAzUoV5fUUwQYhj?=
 =?us-ascii?Q?L41/WuFOX0Vo3TUcEwtlV988XioIaW2wTqmPhip3LPklXQivHeLYz4fZTdha?=
 =?us-ascii?Q?x7u0Za9J2Z5OmtWNZByPQiQ396ch/UPJ70+j32UB1SprHzmTdmZRJ7xLYZXd?=
 =?us-ascii?Q?Et0/eaYBrQbXAsliQcI7uKPV9dtKDtB5iSxzhAv3Fwb+FuT5TeAa6S0p5lUs?=
 =?us-ascii?Q?or1/REjan1PJ7aZaN/Moy+DC3Ido7vg5KSSeLk9c/YVEYKm3tBx+C2k+8n6U?=
 =?us-ascii?Q?ccxLRd2ebUcvqzvB6zKJOb9fYpTgU6R1pVG7/XRoF6Ch1w4flLjmjkDO5o97?=
 =?us-ascii?Q?Oy3RJYUauthlb0qu2YbJFl5XQYWOoGxG9gAr+B3ixLTSjXhtusW7jP2rjPi3?=
 =?us-ascii?Q?Yo0e6YpuiUxWiX+2UStyvDSH4VaJYO0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688d4929-e5bd-40e6-9a0c-08da43d85742
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:09:28.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fvweZpveik4Mw42LQpDht6Lsc9YkIFdsNUya3zV3Yt9QO4QbxqES6Wi+uWUdcJTnJzmnc0c3X5uVDynw7wmWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935

This patch implements the backup flag test scheduler, named bpf_bkup,
which picks the first non-backup subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 5e301e830a0a..3d4b906435bc 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -234,6 +234,7 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u3=
2 w, __u32 acked) __ksym;
 #define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_subflow_context {
+	__u32	backup : 1;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/tes=
ting/selftests/bpf/progs/mptcp_bpf_bkup.c
new file mode 100644
index 000000000000..949e053e980c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_bkup_init")
+void BPF_PROG(mptcp_sched_bkup_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_bkup_release")
+void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	int nr =3D 0;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], backup)) {
+			nr =3D i;
+			break;
+		}
+	}
+
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops bkup =3D {
+	.init		=3D (void *)mptcp_sched_bkup_init,
+	.release	=3D (void *)mptcp_sched_bkup_release,
+	.get_subflow	=3D (void *)bpf_bkup_get_subflow,
+	.name		=3D "bpf_bkup",
+};
--=20
2.34.1

