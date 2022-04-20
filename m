Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43757A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 05:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jynfQ8VDp5q94fEjj0ghkj/mBGOTViHbsgCAl9RNn6U=;
	b=Ki+9v57d1O6Hx5fXHTH0so9lyYEeHpJHyt4riVA6WbtBitqn7YfLZDQySw0cJucYGAAjDi
	LOa4LVCdC1FHv+vLihUCm+dt4keTZXuriPNpjTEwZmiyRKsYlfRBhMqavLN4xxzEszsxdw
	PBY3n0SruA4kycolMDql0486iEHXcNs=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-S76fC-qdOJqkMgw9P8YEDw-1; Wed, 20 Apr 2022 07:02:53 +0200
X-MC-Unique: S76fC-qdOJqkMgw9P8YEDw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtC0v3x7r4PSTdz4KZunUkENb8k6tCpe+CBx/hkc8wIOTyeQ6l6d3/xwqRWaixDI5f9von52/XtHdlT6W6EOwjVkDllg45Lu9zrHsWaIWwLusGcIOyeaPCwsvJvYmJb8asp2evktaJTaF05Ktuf3ZaS3QpjFPKejCIwFtB68pZmRc1yd1g4LPleJhBbhJ28avZrU8FSN8LH3BqqhDefB3lRRUTj7p1ho4ocoeXVaa3IUlniFzfHFKUAxG+GzPnd9M63w+zsCneqYKjqiWkTtVfm0kGWtwICeIThgdfVopa5r9UDP60pDYONA8dv9GCkyVkKsODJfG/Q7x6ya4pAKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl2sCp5gQ42GR+iww1Gfu3UIoGIhUU4TFQtkk/RCocA=;
 b=ncpLru/lI9hX0l3Yqn1oVGj/QJSdTF0XK1+1surKLtdBeVmeYk5+ZgJfFNSxfcZsJik2tMOOwW01LuoXhh2OFmcdqoRFE8H+m7pp1FS+Ps5KaXokItNXtsJ60Me3F77mSZGEwD0Gy8DCJzfBbapJhVGBVScjuFMhsnQYXodj5ilxJIztbYEDqNxC0hF1bDL3+9dOgi9jzo6oC8Nh7vye3EPgD4tiXLW1gakVjQXaao8B070xdCFn4dFLnX/X+mlHY/Npa0QL3wvQLU5dO30OYrw6VAaqMvJEOzwZeI+nSNe3g5yLmJ38Gdw+MEsW+lndc01LDTTrMsKdP1w/qxxiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 05:02:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 05:02:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 2/3] selftests: bpf: add bpf_rr scheduler
Date: Wed, 20 Apr 2022 13:02:54 +0800
Message-ID: <112de8a5c8d37e37300019fe2afb1b13a5eef00b.1650430881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430881.git.geliang.tang@suse.com>
References: <cover.1650430881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a375510c-a36b-49d5-5927-08da228b058e
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4303804BAFE0ED71D80174E9F8F59@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G0rUQnRwDujlXgY5dca7uWND75ZL3QS+HA0cqA+wi89IYtuwH7t7siw4nxuMbR/S8gif/W3taSnMSlkpLCjH9fnBVyiF5/k32ler6gzqt8j/CDr0KGkMeutVfmNkklNrgUBt4GCwysts1SrXR8eq2G1bQAN1nGqsM0q2b6wVZt2KNmk5LeiNRIlcuREtB0zpzNkiJcnTkRpFG/Ds+wBx4YUF+sRZwTrOcwFVY/j+unUoxhzbTUOS38xq1NlnvaPTlnOpwhE/w8+dPGJmN3iN4GOswkmvU2gqGUTnJbE8P0rLRAXVQ3ZEaUNFtkqpaLsYQqxVoiBbeeocZdavMJs6zkkQfmtzAYNTbMID8NPvXC0b+Jzh6sUkBLnfWK8sZcTiTy6uQXvk/6gSTjkmdGP01N8KK/9L76APzZLMQH7RGF1czMFXhxvAVnq+OHLy3TOTmugwVZJN1LCaDydPYK3TOkWsLDbWcPxw59EGnCODwVYyGmGWJPL3nZ3C2Fy4Gh67YLHELHWliavr5LSVLCys6XNWK9WltJObr670cmAoa/wCzEyIPr5Rj65h2o24k9YmJU5QZ5ZaduU3qMncdhjs/AdOWsUdVJ2w/a2tl5QUQE2VkDiltQjWWDYflnJr9M/nbN1+h+rmdqsX99GseMFk3lkfAQ0uSHNnwMLRty0t6gEwncFeS4DfQONEgp6BuMFBe/aX7qny8+JuSFLj8+YR0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(44832011)(5660300002)(26005)(8676002)(6512007)(4326008)(6506007)(66946007)(8936002)(66476007)(66556008)(186003)(2616005)(498600001)(36756003)(107886003)(83380400001)(38100700002)(2906002)(6916009)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lf/Gq1AlHw+NFhFSLhODSdHx3N/2G4cb7p8n9i4a5FTN/x3Rqahuyj1sDCsr?=
 =?us-ascii?Q?hnHSj8fK6PRkthFVGdhR+VGqUDcnu/GZYSld69Zp8s5TRGbaUQEy7B5Un0aq?=
 =?us-ascii?Q?d40B/7JJntBilHHuhlcYg0AO6fislsVlYnG0Tz4EN+Bp7UFnHRNyyPRlE5s0?=
 =?us-ascii?Q?FHxjDbBYxuw+1LJZFIXP25760CtyJIpUmz6uupmr68nk1UcTrYfjuNexs+59?=
 =?us-ascii?Q?n/g8QKf0Qtt2zpDzPsXAx6ygAMe/ERpzNzvl6HHDwSsLZYg2g7n+Vlv0m0/g?=
 =?us-ascii?Q?wKntMN4UrnmP8s/2v0RIaL5KjJEC5MnUurycW5fKqrfZUVBIqG470mcJXYZn?=
 =?us-ascii?Q?Ft9cCfYzq81RyFAxlZqQZjkw9lC40+uSPrOYoE2o3S9NLL/SOzFnd5iMV/RO?=
 =?us-ascii?Q?0IPBmRv37ZqnPyiIBf+AQgTgL/TKRO9hiWBWfiFFGwuxO/gvTrwXnOj3r1ul?=
 =?us-ascii?Q?sLBcE8s3MVcjDe04Ft5oz0au58z8ynw+TIdJRTwr3vJFTEUDFqHuqn+fSlsV?=
 =?us-ascii?Q?TTT5G9+m1szUBh4FwTPAw/diK/fbk8mXPakOMf7uZUss8gSpAbVygm3zdn1S?=
 =?us-ascii?Q?baCLDgy53v7EDfLM7cG/vy128RO4J+EeSSqDisBXxkLZd4cem27dhBjYjzOP?=
 =?us-ascii?Q?fxECn43kYpQx7dcZxU/v+o/wvG38K27z9+FzkfyhQvUT+1DxFGbvfMavIPw0?=
 =?us-ascii?Q?CjwDFgLxjlFYLuMb6i8VNzBU8l8O9exSDfdLd2vSUMfT02AKhMedaaEsAFeO?=
 =?us-ascii?Q?/KdJYmtBF7wDaihEDtXplzpRX8mtcKzFkBjNI/epp4+E9BJ8pm++BBmu6GfJ?=
 =?us-ascii?Q?NtQUpKIO+PQ50j4DOV50NGK1xtHvV2PQz4x/MwOPKtlVZNoEHuSBvaVV19+S?=
 =?us-ascii?Q?vwM4fsPVGFv0bc3COdpLMCzGMIUCU9EcgzZ4w+vfC4H8cdRSTbEQGTFEYHpE?=
 =?us-ascii?Q?7xVHICKt9OnsxrIwnvUC9DF2cPLPhcg/nLuJf8C/M6PF0KQGjFai1JO7Iric?=
 =?us-ascii?Q?R22CI7dzc8Jk7t5GUttkUk4aYcd3DiaMV9K3ix32JIxYgCVpTGJt06uzfTXA?=
 =?us-ascii?Q?Yl37SHrz9SD6H0VNggDXGd2wTEY+IpzqMslW1Pl4ny5BQ87fXyY0hxrbhMVb?=
 =?us-ascii?Q?uBiVSTj+G7dISjfFTDVhlIgtouAn1dCz6Zeo47bmBSOqIL2lHPK8rormqlOr?=
 =?us-ascii?Q?LC35b7b4Cpa3rJwVaxRZI6xmy0+sX7mqPNhQLIqF8hFtk14rlgq5pwfFerBw?=
 =?us-ascii?Q?2jWdiCSLxJPvmGRKVZsvWTGlZdJvPX5FKOvc7iLO0CP+sz25MJW5T3psglc1?=
 =?us-ascii?Q?Z6CUTi/cxyDBfxC1lPZ+HTEg45aB69Vmzo9Ii3wMxGnNlozvMOc95aXbHyBO?=
 =?us-ascii?Q?yiCBSj1oHCoMWWjs1kwEgYpumq9xDfbftc8dCBA4lCmemrneXAjdW7aT5p49?=
 =?us-ascii?Q?wnVB+fng+OXsteBuK9J7V7ouulil5Pv18N6ybHhRyl32GiM6YxIf1ff26r6A?=
 =?us-ascii?Q?8oZE2/7wnbKs6uxFe6r3NnJhlf4nIer4nhZVYQg6ujqfhLtafnf7M6NemgxZ?=
 =?us-ascii?Q?znO0Ieyt48iXQm9BZ0yF9w2niMLQUD5WiPNGQxN+Te4AZNgB6rtXWMca/Ir7?=
 =?us-ascii?Q?Omp0BriVCuler+D5F7eJZR8GJpxkC9bIug+/JMdsgupd+s6eI7nMSGazBgh5?=
 =?us-ascii?Q?ygoLZoCteNVT2O8h76MhvUs8IVm+d4frg3yVEeFlslvWx8xs3nlnxLphzkRd?=
 =?us-ascii?Q?hAZWbpLnG73CrgQS0LzsKORJawVL7eg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a375510c-a36b-49d5-5927-08da228b058e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 05:02:51.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aN/92kUg9c4/GuFAs7rfnwaK4myGkl6x+EaWsxaJhSy+IuK/vuNo7WXjbA27bxYytNkBZeuSh2EIBUIEobashA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 ++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 55 +++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index f02d75f91e37..047cdd52dfeb 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -29,4 +29,16 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+struct mptcp_subflow_context {
+	__u32	token;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
+
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflows_array {
+	__u8 nr;
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
+};
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..1a5398cdcdd9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,55 @@
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
+extern struct mptcp_subflows_array *
+bpf_mptcp_get_subflows_array(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_put_subflows_array(struct mptcp_subflows_array *arra=
y) __ksym;
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
+struct sock *BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk, bo=
ol retrans)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflows_array *array;
+	struct sock *ssk =3D msk->first;
+
+	array =3D bpf_mptcp_get_subflows_array(msk);
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (i >=3D array->nr)
+			break;
+
+		subflow =3D array->subflows[i];
+		if (subflow->tcp_sock !=3D msk->last_snd) {
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+	bpf_mptcp_put_subflows_array(array);
+
+	msk->last_snd =3D ssk;
+	msk->call_me_again =3D 0;
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

