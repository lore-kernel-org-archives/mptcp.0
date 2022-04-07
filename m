Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F020EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/N4YwAImiHCBeK+aA6penYR/roFRJ8AY3nas2FJnp0c=;
	b=Diy/J68B6LAWcv1pAJVCeICRUiYJ2fQISFHJLgIUlS6CWpd5Xf/eVKb0oW4KFXEifdl2VH
	RK5fYbDuvj5UTNifksXP6F45yz+DDsNbq2AWYFOf3MOA/aJaT9VFYArEtHzOyF6uhTcbpu
	d+1PaIrsd6ZhJAxgwaKsZOniv90wyMk=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-oqwz0YnrOj-u8vtjxTHVrQ-1; Thu, 07 Apr 2022 06:10:28 +0200
X-MC-Unique: oqwz0YnrOj-u8vtjxTHVrQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjSANUpz1svU6e1noB63/d6hzngySer8L/BQ0eu950aHB4o5JkxumzE2spU9BemU2+aItFteKx7EDkv+8T5iLJTeCeyRFs4sYlt1o3oi4fSxYnVGXIl5yX6Rlrv7xlUSiKBu11lYXsySU+H/M2rn1t2rkSjW+s/DMgPfHTbeoX0yq+mokqEeIJ4DniHTdEg8/uKYPP+eHLkx2NifSzjisFMeL8uN0G/56RrrIU7neSPMXsIPNwtjbbFXP4ItoHFPYDIkbSAepWkeKVdgxzrT6VrmR4hBMOf9gOA/OcMJNdqfLxOVkNXtJ6cJgVLMWVkqA4XUehbIofQd0+uRrvFSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsbQTgKgIeCh1Syk6xyC3yZPteGRkfOkr5jPgiIaLcI=;
 b=j+hjhgf4B0Tsevaag9ahV7J+dVZ50NCMMYku9RABKiem7+cwqp/4/PH8YlYW/cfC9m+QqCMukhsSGv26JWaCKPftg9blo3ZUoCDSbKJ2m0h1doS8JTmQYasG2xRvnMWSY3em0CNlNWpn+xtQRJwtqsVs1zVXKDDEc6ItZG5ZqD1KFS0jV9PzpNsFhwOiNfC7ljJOrIeg3ECqom3nzQuGmZR6+Ffm4JaZrpDji/BG9VbDHm24D8NhhwIKFU6WjTlmK4TigzfS9HBBQtot76Pbk1kkqkjIZhsD6THr1kCSQMaW3vVXBNp3OGTdwc+VXxtXbLK95E8gTZzI62ETaKT9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3354.eurprd04.prod.outlook.com (2603:10a6:7:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 04:10:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:10:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/4] selftests: bpf: add bpf_rr scheduler
Date: Thu,  7 Apr 2022 12:10:10 +0800
Message-ID: <de363f39f71a10a52697f5eedeb1317fd9430647.1649304364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649304364.git.geliang.tang@suse.com>
References: <cover.1649304364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:405:1::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d4f630c-4086-40f5-f675-08da184c8c01
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3354:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3354B097A2DEA59EC2DB8610F8E69@HE1PR0402MB3354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pWhzqN5C8DzECu7AtTFJpEG3y7cedFApJpyiWEvsoS+quj8s7xB372+gHFfLgk/qbqgw3NsRLxZRjOdDV+7aC93yC4erV1dFbu0bDAnRHYI5ALg6YJ/7nF59ByA9Tk+vf2kqxHWo3KTQUid8lBtlqiViVJHK6FjHqMVHipstRNafWQxZi82eZ/jDBaGaNQ2BWD1zNMwOW+p1UBd3n+BCWeeK76fHoGB/+n43nYLM8v0mthvLvJz7JClcFZfnRnisLWSILrheJOaQH1P261Xn98hQb4sPVdRjk9dGhrThEhHRAOMmL6JhDhck/HMs8I5HBx4YTjz4ooGEPBVSON2L13n56Qtgl954qbjo45vXoreOQkbM/10U1JcP73EqOPKfKO8+vwYLZAevUu9r0AmyvpjVAAtYfeKZQkAoncpBPxNrLF/pcLgjZmNXLIeYv60GekdF3JuGnrFBGaXZnkGsv0YPR5/LrX589pwpvVsBwQIHbw2RGGmWzHJHKOEnnWhCIEVb6dE7/k0DfLaeW4m6l+/Lud2mf3O5fISsv8YuR2qHr2eC/gNhKAEOf6cnF6no4n01flYTn50P3rcCVtB1Smia0wI96FBZQw3V39YvgbWrxk5aXJHR8nNKXo+9WyQ+W/T8mIyPtRnuvYy4TV9Y1dWN7IXnW+AifYs/HV0KP9UuHug1TiFqIWM3qVcI0/IRMi0TpvI6cx6MQv9dqqLy5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6916009)(107886003)(186003)(66946007)(8676002)(66476007)(83380400001)(2616005)(6666004)(6506007)(86362001)(316002)(4326008)(66556008)(26005)(38100700002)(2906002)(5660300002)(508600001)(8936002)(6486002)(36756003)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdkJxFnr6+3Jchj+PF03Nl3U4cdLyG/pf2tbfAPtSQaLnhpoCJu7Mi1/Kjld?=
 =?us-ascii?Q?KkQP+3Dm4WZZKwvAA60AsWiOREFNCzkAreaJ35qqa7YuQC6QedXdpLRv2G+2?=
 =?us-ascii?Q?R6MZVRRWwnCPrX+zWJlp7NLpUq4hIApdlAn6nwRJSRUHCAZorrpEYm3YThol?=
 =?us-ascii?Q?ZMs+IPixKgJo5hvJKexm9gijqXcJJsUmuo3ADGOgzygK+Cu7jKCKhH5yrVmv?=
 =?us-ascii?Q?3dfl1aUXtU9Tkfa0k3UyM+eJMV7ZGPpR5INGk6Nc7lRE61JCdMCu16hexBWd?=
 =?us-ascii?Q?574Wu9UjDkZ079OKT7j88VC6AlWp692M8sl4IOAv3nbJbLWQeTqP5pxs2mWZ?=
 =?us-ascii?Q?88wLQQLZ3qNOqhgHpBRcmzaghBb6mRUx5DTDLXjNYcZxtt9XFHKg44c8sF91?=
 =?us-ascii?Q?9u1TyNovjhnzdlaLAYwxf5VM/O0F2jeIsvRIf9N9E0V4hrfUuQG7KUFpmf5N?=
 =?us-ascii?Q?LPo7Apr/DqrYpO9juuF6dPYypUySocc4YDyaAkB8P7Lu0NNqgSZqWG5LihOi?=
 =?us-ascii?Q?PDTEqbBabK/hbRN6M2FbNOAItJetGbQIhWPLbDEkJIhXXandJyrPRqRlTR/G?=
 =?us-ascii?Q?kOPkT3yJXFkt1DdHczVitFKwe/onqDUVWKTkp4IK6Ye73lb9x/ggD0TXyt2E?=
 =?us-ascii?Q?HKhWNZn4T15EeVCgYhknTW3unpsw41D8c+ptw/TPUpMXmRpHGJafpdfgzolw?=
 =?us-ascii?Q?yeQ4595IOBExmnwq2U+p1NPZkpisZakzydHMrbsmfWUjEWbZMxlG70RlWqBb?=
 =?us-ascii?Q?WNK10pufQp7TwerNv+qBjKulCIUP/Yn/zRZS/0z7yVEXz//70YdD1seXzWIt?=
 =?us-ascii?Q?kZfc4OzTJ5muSZktji4oHa5lBYPlLoLoIwqKgMg96C2YQngN++1c1ww5WlIr?=
 =?us-ascii?Q?8sDI4nW7UPXqaEJIOglq08LCIWYpDPCgBrF+p2Nh+4qB88+qYLyeuFLS7lGe?=
 =?us-ascii?Q?EGgBppIaJv9ep3wRVKOO4ZeDKdhhPj0+TjEbGEmLt4DtDEtMKrMwZc6w831m?=
 =?us-ascii?Q?qBku8Yn1YrL5L7JWspUMFttr1K7pmpi80k8UBwYhPmRVnQOICk7NGcvhcVqB?=
 =?us-ascii?Q?v2X+vye0C/yoeLbzt9oyeKTFyEgsYZAmYSkCrGp2rFnHCdwftZiv9G/gpfyi?=
 =?us-ascii?Q?AaivbGVpoaEYaJPzva21WUrAoGpF1a4JmHZO1CfaTqXW2t09i/u5Tk2ZoClh?=
 =?us-ascii?Q?dxTz1gl0nRcfKRDxZLBbmcZr7eipYjT2Gh8wmgd8oftzHFjqpMrDSk8WIWUL?=
 =?us-ascii?Q?DR4j0hQOBUT4GizeYlszjWU36Blr+khh3uOuiBGL44oKYnkGzgyDZmbthift?=
 =?us-ascii?Q?PmAeg41wq1gTBP0sas1Jvs8tCw8f18wZkJUgDmgOu7fmm2/OkcCArdD/IdTB?=
 =?us-ascii?Q?OhJDYsdsw6mNdZdgLn5eeYYK7V3G1K43aQKbggXLVdTksOlW+B5lLRCtw9xH?=
 =?us-ascii?Q?b88bGrpK0rugLlO7Qp/UA5PifMVagzOlzaMyJTutcsIPYnBL4t6eeJ1dHL5k?=
 =?us-ascii?Q?xA5QSkC6OfpyLEVbRwloV5HFMyNsSQaBX9Yuib6CGicvx6nDjCoBst2ovsNb?=
 =?us-ascii?Q?hhbQeHTjLmRaNhRi/tB+O8jOemAyNsqTx9cnDgQ8NGCEdfst60wU9bhmUbND?=
 =?us-ascii?Q?F7JfALjTOXbdfJWI5cFtoZMH5JtAmYvTiX9MslCKJCa3x54g2AF2jd3l3oas?=
 =?us-ascii?Q?DfeoEoN9ZzorAyta//wHjwxyWJN0a/J11cE27PEHhxQ/6dFObFJa/gmUS3HH?=
 =?us-ascii?Q?TbKKUrB1R6qHW19YkrTomZtWmZZtfBQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4f630c-4086-40f5-f675-08da184c8c01
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:10:27.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsxkVuTfWtgeBXVqquyFN7eFDvJ3wBBunXzpbqGgxyLa19izjUPHyJ6U9W6VCg8PI9fYz9s66jkklL5idQ1OdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3354

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  8 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 50 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 990ccd2b6e96..6acd62fbdf24 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -6,6 +6,8 @@
=20
 #include "bpf_tcp_helpers.h"
=20
+#define MPTCP_SUBFLOWS_MAX	8
+
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
@@ -13,6 +15,7 @@ struct mptcp_sock {
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
=20
 #define MPTCP_SCHED_NAME_MAX 16
@@ -27,4 +30,9 @@ struct mptcp_sched_ops {
 	void *owner;
 };
=20
+struct mptcp_subflow_context {
+	__u32	token;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..0e823dad4e59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include <linux/stddef.h>
+#include <linux/tcp.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+extern __u8 bpf_mptcp_get_subflows(struct mptcp_sock *msk) __ksym;
+
+SEC("struct_ops/mptcp_sched_rr_init")
+void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_rr_release")
+void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
+{
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk)
+{
+	__u8 nr =3D bpf_mptcp_get_subflows(msk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D msk->first;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (i =3D=3D nr)
+			break;
+
+		subflow =3D msk->subflows[i];
+		if (subflow->tcp_sock !=3D msk->last_snd) {
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+
+	msk->last_snd =3D ssk;
+	return ssk;
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

