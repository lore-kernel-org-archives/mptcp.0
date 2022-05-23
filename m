Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7265258E
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653319574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szKeF7MYZKE8z97+NsQrvgUxkl7c7o9yeBy08lXSQcE=;
	b=M1xz2BKO2tBEMZfdtnr+WY79EmeegM28QWGUxv+KwLJeC9CtpBX1U5AFxFlzQpNgkdcrge
	Rt7XTJxnNIOMzrAeiEFi80KTT2O6IwgUBO3NO6+kiFsS3bng/0HRPJtkx/cQpb3MwTOO/C
	SpC//ZtMJL4RoFh1C+9qxtMokt4x7gU=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-pLbjMzn1P0-r6AjFNnSaLg-1; Mon, 23 May 2022 17:26:01 +0200
X-MC-Unique: pLbjMzn1P0-r6AjFNnSaLg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWMphDk0ViG/thGLdxSeh+fkUeu5Z/tgaJ0ylJR4ZfWo+wiKwt4kWOW7nVULszynZW32xJ/2f5B/qO1Uq86hTNj4sHniybA0xvYn0vqYeh2RqF0p1M3CgEZyAm5/8lANfCS9MJZQb3IA0dhqMiqn2tajCmJaSMZrrfnwBMaRI9k0jVTNi+4QxUFVkpzaAnJR18Gvo1FH6w5hs5ST7TYx2o9RGYSJPyeraBzDoCJ2GhNnHiZonOsr4/VlEipYmn23o1rI7zBDwsBAtSPyVpne0iSEw9pjOqhn2iYyXy0Uv5GIKVEVqkGnataVHKefFhYNIPNPsjk3+6dKRtfCHIbHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnXC128HIsrFxdMWAHQQrUrqHD8gMcgnYHF0mf80ZgU=;
 b=QIyFzTrCd0g8Yn2cY+59l9B74IfAyi106XfKV2hLvrOGlatK8/jljdDGiyrgTb2ESGzKXyC8bh0AolArfo6CFDpqvgpCKTu6SRCztkgZqn6Bom0K3a1xbhp2Yvx8nLcuZkfAdfUZZve5m+uOYdeAafmU4eT211g6nL6WaZnrojxeQpz75EC0Wuzr25oiaoW5UaWS+4ahno/RaGOQ2ba0MWyEDoJNyGbf6vURA691nt/Fg5KYEJPvjHCr7m0TDsknZSfp/mHJ0l4jvKMaqbGJu3LZUa+tAyugnu/cDjeU/M6BlNFiRZENUp+etTZ03oQZXA6XLKpkptCt29Q2eJFYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5681.eurprd04.prod.outlook.com (2603:10a6:208:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 15:25:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 15:25:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 1/2] selftests/bpf: add bpf_rr scheduler
Date: Mon, 23 May 2022 23:25:53 +0800
Message-ID: <0b44f7371325e07fd6cb7d95346c51cdf794154e.1653319279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653319279.git.geliang.tang@suse.com>
References: <cover.1653319279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29bc1c3c-dbed-4fae-1e14-08da3cd089d8
X-MS-TrafficTypeDiagnostic: AM0PR04MB5681:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5681DBE9E1D5C607092A0FA1F8D49@AM0PR04MB5681.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wXOhnjsdynAOVWCSDtGsdWs+zuMG4dMgWvYVaLtPU82/M6TBXVOBrOfpdNYkHe++Z2GleJsUHlYlg+o2INuzyUYnxiTIPw9Nse5z+TF8Wu4ue04bLqXaNwZPNYHD3sMFUppwsfZPPTj1mj6D+T/1VEogpQXrnw4rpaBBPWdw9Ve4xglZrCzLmQ5Stqj2PjhG88mpHxjUfpE5QsrEF7YX4Assetjann+n2XlPz3Jy0X3mvmzwwuX2Zy4z6QGbjiWe59a+hOQFdEyCv3tRkpo3pWheBm+sVTmQkzfvaOVJt0Ce4MZzPWYEOF0fMN7BscEFXja7lw8foHg40wVDHe0CNuZdIq2L+JwjmZK35PK6DpdBbD5H4GCb9jeY8YVq5Iad4ybia+27+/635N1uPLR0cQ9IKGsmqR7evAIYxF0WpvGnb7WjEovPh1aT0gtz/x5DxhTeqzB4I3IRJEVlB+qrWXPSctG1uyjnDrXUyEs02h6lL1SX212RAYBvJgW6eYQqGzObRgFyvUWT8BRrgsyMBHyYZfzQTx8ZJAD3ZV/C7sDbcXxiG57I+p+GPIN9DijYmJFh6VFVnJwVBNePNQActucY/VHsYBP0M8vjrw3HXVpgYeR6Oo416wTQAJ7fdwJfkxC8FinkMNJVKBoBIwBrV71xmcg8I6pGm+TNj5pt/yjxAXOo5yLuQruiS+BUM+mzp4BNjkDPj/KPfE4+4CjAzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(4326008)(66476007)(8676002)(66946007)(66556008)(8936002)(508600001)(2906002)(6486002)(316002)(107886003)(86362001)(6512007)(38100700002)(44832011)(2616005)(186003)(6666004)(6916009)(26005)(36756003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2TPEDz5++GEI15KeO6HtMMnmPp7HfcmCK37VvssVv6F3KREGrybVSuS15s3w?=
 =?us-ascii?Q?YKOoJbcqXhP7CygUScfRx3wpWo9iNbYs3gXzbLKZqWg1vUpWssGv9nRgEMhh?=
 =?us-ascii?Q?zAcQfKqL3TXT5yrJL6Cs1hhXgs3dhpkMpGK3O42P2rG9AqTbqbEKqjogMeaM?=
 =?us-ascii?Q?16BOEbsVKKbox21WF2lbRQjd76oiHjkTRYhf4BY13RuRu12R/C2psSrE7s3h?=
 =?us-ascii?Q?2kr/PDwwPPRCi2YX9ScZ+XovDaVbCrgWdXQIX+bMUO2hyXYLekP0ATFLHhDA?=
 =?us-ascii?Q?P42+aTEX+rNJU3wsccu+UU+eYuc8NcsEZmZDJZ9QBND9t6NmkNpWKLwsvUH4?=
 =?us-ascii?Q?LUKVs1JVkia/vHRYD9jyKajDBuCEAnRfqf5E6J2NimJexWFLz1zdoJZgVBpQ?=
 =?us-ascii?Q?QnctAHlX1Js8vvU8FmTkPhgPjwmQrgMDt6DLj4R+hR0cIKsoJKnnWdoPwCvL?=
 =?us-ascii?Q?fV2cziGStdTyGMQRpI0vsWkxMDWdw03TSjeXEmcj6YDDbitgp7qqZDtXUak3?=
 =?us-ascii?Q?U0hN6kPfyF8UbL1JnVTOr7ZvmO5Z4AgSZDZDeKb0Onwji88pouF6XZtNZkxo?=
 =?us-ascii?Q?YvNQaOuU2xaCH4LJM+3tnF5k1pZtcI6DOjKH1dIN0sYq67H/9C7n3CMOSRvZ?=
 =?us-ascii?Q?BUmTmZ+KY476hpPLCiRhWPierCR5kT6E9JfVeZesTFEU7X/XWLlrZel5wW72?=
 =?us-ascii?Q?tLnBUMnpIiwz8wORPcug/+q1jgEdBYkhDHK+b7m44JmAf6nYQngFMHYwWJT8?=
 =?us-ascii?Q?JbhtETgMCJfdoSd0iqsFRilxSLgz/UXvt8tr02dkudftaRJA7/cfIWWM39vc?=
 =?us-ascii?Q?0bCbbk3Hbktz1yRZai2LllTiDE94srXqHhgdFBiHAeaTLoUiG9ceAJja5h1Q?=
 =?us-ascii?Q?7x4N3WlqyVWC5oWGUqAZIfD2sudqr4IcZO1Abc24xHDWgQA/U7IN77I4CPMa?=
 =?us-ascii?Q?ishrac7oJlNkx0043NIil9tsfpigzzSd0J7CFZ6+Nia8cIN93Dh6vrPv75qm?=
 =?us-ascii?Q?ToJT6ki9OuwXP1IeKzc6FIvikaeE8nqt3Fl6sF2RqQT2BHMvm5+wF/BSri/b?=
 =?us-ascii?Q?VtFljmdWsCKr+0mgA2olQ/KoMaWYMo2rUflsbW+nEjX7nYZdoqs33eqwPxew?=
 =?us-ascii?Q?39d2BbpsyJaaX1nC/krvxnRQwRjHaMecIj6HC0TC0D1EpUJ+pIZ7UG0relA6?=
 =?us-ascii?Q?UHj/5uYwRylKeQnEPwiYwPPZ3XyG+wQkQrPoy/yS8xRFjuEydHolrHmJKUX7?=
 =?us-ascii?Q?UqaStU2ZwoOUmhO2+7oFVDYmSz+TRUjhlX1g4oA2KTVOJWmwJmxyD3p716ko?=
 =?us-ascii?Q?zvzINi9Qvzp75jIaD+A+m9G4s2Iqo5a/FFxfbcvRt+DxXdJhOJ+m7UUFZH1a?=
 =?us-ascii?Q?XOYI95XTqBhoRBBlOB08kwEKgjf93dy95WPe/ocaxJZ/bOZ6wcYiFkYwD60d?=
 =?us-ascii?Q?Skj1LGsHoIsOdXWwcUoAeXpJb7Buii03VSAF+5HlulJpmOcYJAorpuOwjpQ8?=
 =?us-ascii?Q?W6nnkjrpoZbKkL4cchEvqqIoWSpkTwDf+G/g3i8lX7Opi8kvPP/3WvDokXTK?=
 =?us-ascii?Q?ovyekNejg2rzF1AwDL7TE1AWZc5c/a2Vto6D++rEfMyei6FKKxvqORaETAdc?=
 =?us-ascii?Q?ROSLEbSg7FBW7CJGpwU4WBRji4Z5fAJ+XmDHkx3tmTMLBNew29Qd50ZejwTr?=
 =?us-ascii?Q?I6yYZSu4/Rn7r/3xFqqGv9AWAn+rwihbTzPZgrkGHR1aQsBotYGQKLyelk7l?=
 =?us-ascii?Q?b/hBN/+y41E51xUMsn7XTo9rFAqTbM0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bc1c3c-dbed-4fae-1e14-08da3cd089d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 15:25:59.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WQVOnNGlBOhTocHwIgeot8POsFfTS8n1TYOmKpBpHuyRg2cBA9FKyzywt9cKkxd6SVV87sZOrqie2KL/HkMBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5681

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 9c7d33e106a4..0f29b47260ff 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -255,6 +255,7 @@ struct mptcp_sched_ops {
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
index 000000000000..ef475bd33dd7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,48 @@
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
+unsigned long BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *=
msk,
+			     bool reinject, struct mptcp_sched_data *data)
+{
+	unsigned long bitmap =3D 0;
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
+	set_bit(nr, &bitmap);
+	return bitmap;
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

