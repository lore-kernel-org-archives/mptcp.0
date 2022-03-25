Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090628E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=el14mbDNzMQKfIz7X8FmdkOL32gSiWivSI0Gycj16jY=;
	b=gkMxqIDM8H13qvDK1rSnuxCDsdobf3NlYipdYhYTPtkhQBg2Senm1JG/iozCPjM0FKR+Uy
	mVto98VUaJQitSLsEb8XxKHVLt1pwnVU+ZMX2TYXx6nhcye9KsZb9jDAOFUkCPgXQHglXD
	X304sLxWx83SiA6Moq996ag6HkHytlo=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-1hg8GeWaO_GYjwNZR8liAw-1; Fri, 25 Mar 2022 17:13:29 +0100
X-MC-Unique: 1hg8GeWaO_GYjwNZR8liAw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2TKpV3NaY6o8/uSjEj3kB78Eym3WXJy3vn27PwvypUo9KvTnBPbtNdtnovjhzlAzXOFG1kCfeaqWMVcAZU8YG4iz0IBPLoP2z0aI4yvLkKXZfJ9fwBPrNr9yYAQoyGp1zRKINiIqeQsyzznv3MxL/Ycs8qNCBoTnaHSvwfGM2D9LTLeknyd8Uajm6pPLLA9RYLyF11qSgldxNiMttmMEaZtSZxds4AQ9bFF9Cuay8HXbsWx5yLMpIwPH1cyM8UojBULsFnDdf2GUrzhn0PiQzIH2E76guS2wo7BxAtK1wA/CVkVvA25yfUsA1yeXvECZofNxOgW5/1hW5iDM7vofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5FH9XtcH7HyTwHY5I1wHeCwYLtUvyGzKzyt2JprDa8=;
 b=StqFlPiBzvKE2bUqMaiPyReUttbApadRhN5X+9yfBF2BctEK9M3sMWsrG0fDTOAWkjbeMDzCjybEWANK4heCYTNIQMPJc8/i/+QVhU3KPsolEKzzlXY9fncWrf13L/SKRIOx6l584Eulo4yzpvYwWtwUC59RBN9EKbv8a3FO3H4iA+b40F3DAssXxbKB+EBYzbp7dKTuxOYBiIrOa9bby269gu4ZONdH7FrY/67rz9SF7ZKbdRVSITqCSnAGtrNUfzhwjmJIjrBCpAEKiA9VQtp8BgbdUgBH88jCkyd0bVz0mqMrQjlx76ahVVTizdIiKPVFOX9Y5c8xJi/jdLWJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:13:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:13:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 7/8] selftests: bpf: add bpf_first scheduler
Date: Sat, 26 Mar 2022 00:12:03 +0800
Message-ID: <35c97d89297abe349b746582f5db9319c171a787.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648223504.git.geliang.tang@suse.com>
References: <cover.1648223504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 671e3790-9050-4e01-4761-08da0e7a6599
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3938F265EE3C205512158E27F81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aK3DRhvQkS45rzuFbJWrxbQ0inivzS6zmcaWUFzfTFg9fUpF8KQesObp3hGNIOGhJTUgEklJ+qpnaeIU4TpdLza3Uu58kbaycxnDKev/C7NM10JHtRhm2wNISVgj+ZINtXLptHulIEU/IfPzAC1AY1mVkFmyQ03GQ/td0sT09jgTLAIRJ4PZjmo6Q1mHiAy1ayrfNMh+Ba1fFhhoaLt1sIQkeTJFLSo6GPAbJ5eSJJpSHkPV7HO+aq9w1x5kebnI/R2t3i5CbiBEBc3TtcfxKa5abXYapP8cT6HZsnQsWwtCgU680hKoCgjnPPt2/6bfqEl2KD/1BAS656oQNh4vxYWaaUJgNdwpy4ejeP5KX2MxLDoldhB3+sd3SjebPfGz+/Pq6yhHaIhLnkNX+DcbvU5eUpIuGoKSJH/WdcanYWKcNDDjQla/E24VErjOZDsJihUkt1iWCjN6tqccR8waWTDDYFiXLtkgcyGsf5gb+FYeC02XJdcSnswzFWi/p8BjuVzFr3zaZdov8Q5MYbu1S3xzDGxfadaN1rBlBu+0DvuYywpdYuyREsjeGXJQvBzqHuBexKtl0mz+YlII9RFoWGYJxrlaSK2mgyPT21g/zGEVQvg/bzAibKPSpjxfMP0RWi1TIryCsntQtR+tvV8ANiznXO8wkyKGsFd2+gKQIteUPqbNJIA2iZ+OYU/U97KD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(2616005)(86362001)(6486002)(6512007)(6666004)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JSWG+sHFhYh1H8gbIxF0OAh8wC+9AEFyvpE4TE3mWijtTS1OseVdRnmgp6So?=
 =?us-ascii?Q?IVOiLL+BeX5gVE/clTN8SFZYPp/fmUeOT0vB3kd/uJnxIs+Qo1rQxVKC6v2Z?=
 =?us-ascii?Q?gyEN79UjybVd7viLlvFEKAqnQE9El6LMJUHMvJ+9FdR+IyaKufGTKz/OrfMm?=
 =?us-ascii?Q?Lg5qKQeN4etGayxcQTuCJSz5Pm35g7rtAOIg71nhNHdEkt33sw8pYcZzMubu?=
 =?us-ascii?Q?mfUu4ouZ9EnVYTErkujQeKBzTZ+nbGVhEtV2kLL9VFsTXxTV9S3mZqCkNL/y?=
 =?us-ascii?Q?Byumt0IUCe18NuPAynOmvRZ9Q4n8Txmx9X9qBUIp1QhyoET0ei55YFFCkIfr?=
 =?us-ascii?Q?HREOwML2PqLL/jqYUlxLuagreL5Tmv2ouDI6Osk0Fg8ByCzbwH/YOuU9CrMJ?=
 =?us-ascii?Q?Or0xUDya1A3mBBX3Url408XUbS7BjdqDZx0v0AChWi+r6uSEE9zbFvt2f2iG?=
 =?us-ascii?Q?gNh3svSUtHhrKHgHt2WcgAj38bRytcf781dxTnrVh7IDCXurHXu4Jbhsw7Un?=
 =?us-ascii?Q?u0o77kvvth0K0zZJ7I1Ksg0P2DPkQYw9Mfbea0p4weI9wL2FeNUGUnlTFsaI?=
 =?us-ascii?Q?QfPW/p0+59be/RPZb6ZqEojE5YUsbgTRVo2C40eyutpnuwXe1TXn0NP9+DCW?=
 =?us-ascii?Q?9wibiSgtUA3IQAatA0R5plIYHxgYbmHuXM0yrVFI8hBc9kWVNuqtZ+KlVcDI?=
 =?us-ascii?Q?81CWEujcbbiZozzx187FK73ssG7LpxXOG2hsjQqpbxadvRyDLwVCbJPzLhhA?=
 =?us-ascii?Q?rHigjcm9UG3op+xXrlTbEhKcUH5lePmSKFa3HFlDQSGqooM2LbeDuHJxhRXx?=
 =?us-ascii?Q?pULlu6+KJ+L+YfjSwgQcrpDi4TtrPxO7uGJQ7uCPtDJwVOL0Qvek2+rB/sz1?=
 =?us-ascii?Q?eqxJ8SF84yS0LQlmfEbXNxonX4PLmsbdp1MIVfFN45qNWBP4liqTqqr9cpE4?=
 =?us-ascii?Q?/eIPIZAN2fU6Ns9KQ/N1xp+3dSq6ivKj4z2zT2IcTA5xgJBcpYxZ63pdwcls?=
 =?us-ascii?Q?yC4FitKY6OtuvRmVHQ59DOdRpYSTfbZDDMKYkyrCWR1S5ILvm7UlA8sIp+Oa?=
 =?us-ascii?Q?JVDNopePeXuY063mggKAYHI9IWVnuoHGkER+NLbJZAj64WUGzs6Inq4x5mLM?=
 =?us-ascii?Q?PGrScRZum1XWptGZ+hg68g6GZM7HEyS8ED61sFfND+JMcrVjU64jr34HLPAY?=
 =?us-ascii?Q?fUnWctquqII20bo/Zc4zAqowy+rtp/Y5FmrE1kemjbS9y5mcBpaoki9+nkvb?=
 =?us-ascii?Q?jsRUVGj/fO6mNSQ67FCjveCWe3xAoSIhi2FR2CHO8Ztk3yfPoqH4U9+/a4kz?=
 =?us-ascii?Q?zgJW+pUd3YWbkkEB9KkzHDGI6P2MWYE4PEvtBvPRpmrfeYboN/YhPRSrAWID?=
 =?us-ascii?Q?S3NWJu0sEC8zZlsTkBUJVaEk4uOGfxg1sFrqysJU0v4/AehV8PPkRjyfcgG0?=
 =?us-ascii?Q?IecbvnSOuJxQ6XeFWlS+MywEniddd7HX9LpE4Rhy7ZJjoc+CwUMVQQolYS2E?=
 =?us-ascii?Q?+ut0t/AT5zItE8bSsoZVMXKDU2D8VARxYEcBIwyxjYGAuPrRA2K5hBb08qe0?=
 =?us-ascii?Q?H0YxcJxspUFJd7KqM3q2C/wevZW4eV2Mg6c8lpewKj/Ng55fN5DV3jwt5SZj?=
 =?us-ascii?Q?DYJk28AKuxL8EGfS0paVBeqRzkl5m+6rSWV4BmE/XuTrRvWL/yjYSlONvoS9?=
 =?us-ascii?Q?m7EqEJAN1V5YNZg1bVEHLBDLnmBCNWbcJ2KWa/Dlm8JPvZEnKlDiY0ZjCHSQ?=
 =?us-ascii?Q?W65cOxbPpSdiZ5CmD9z47E7H5PIoGsY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671e3790-9050-4e01-4761-08da0e7a6599
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:13:28.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPOpwR6hgmKcXt4iiCbjZxPhsJlnfa9X027Iq8EW9gsgrXEGT4Od5jps+5mOzfHV6NJJZCDtlimZQfGAG50V4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

This patch implemented the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++
 tools/testing/selftests/bpf/progs/bpf_first.c | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f92357597e63..5bb21b24231f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -197,6 +197,18 @@ struct tcp_congestion_ops {
 	void *owner;
 };
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
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/bpf_first.c b/tools/testing/=
selftests/bpf/progs/bpf_first.c
new file mode 100644
index 000000000000..3ae5c1eab5f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_first.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
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

