Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E87A31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=el14mbDNzMQKfIz7X8FmdkOL32gSiWivSI0Gycj16jY=;
	b=S+wc2m5F2qCnAHatxOKJolTezWtjkC37uQ9h4IQifYQVbQCJ8wkXSCmJwCIPdHj/TdF1nC
	13JQ9c0/XZnv6hFH0hWXRCxEwWxOBFMYgRm8w7nIQeJB1FM5E0c2lcCtn+jyjpRGKRiiNd
	X+U/XQ4H8zFZCuFQ6ErrLH2t9uAegXs=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-xHG0oTYJN5KVNEuNIKwZcA-1; Tue, 22 Mar 2022 10:53:42 +0100
X-MC-Unique: xHG0oTYJN5KVNEuNIKwZcA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhD5+XFesurqdpf83iKs4GPd8PNaPpZXlQBk2oC8yjjHd8QpgVImlW70eNJlhcgbvRhO2eueSrWwlk48kxGW/1R5TXOpY6LJu1u9B8oJoUao1ARG179vGO4a2rtenLgbEW28ZtRviCcJGOBJUpAoc8tpOmlFVyYNtlg5zbKioKWCsoRPLKaOrYcMEUoIMoIp6mVXjez9+8NWQG5q8NbT15Uq3EDg7en7iOW4WXJNhRt8Ec2WqqjacZXjhArogePAbuTDaqY6m8Oxco5892ADLgxXb1BGBsKKIzmoLJNGT6i0p2Uid7R6uL4G4nLtOB1xlropxPOWMn1luiKxha3e/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5FH9XtcH7HyTwHY5I1wHeCwYLtUvyGzKzyt2JprDa8=;
 b=il8N0mmP/Z3I0e0GZh1AJX4Cs8La4lsvXU6JweaNGihI+H6g68jx9BVfWf/4M7U1ELBXsPdF3oS39JTGmeSFAT42a2rGcOfBCC8TssGE6a1tROMX0CG0ygPWjdrKK2aPKBF4/RUr9eeLMuzqVvCqBJXpjcY75y8QHmVr3goiR90aRuCMxkU+G+Ui1dUB2ZH6M0/9gkz136582hmPL1KN1gUcOyqY8S0bflMeK2DUXPbm2bsJQOy03X4pnsYFBbKjmZwvK/dQSzueRmtvr/pvZ829kJYmffiz0YTlnW7SriWTsgujnBD6sGF2eI0s31rDWMj44GLL8EHQDbXnXE3tKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2282.eurprd04.prod.outlook.com (2603:10a6:3:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 09:53:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:53:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 7/8] selftests: bpf: add bpf_first scheduler
Date: Tue, 22 Mar 2022 17:52:42 +0800
Message-ID: <3b90b45702250a34e2a7942f7a9acc2c487057a6.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faaaca5f-b13a-4842-4d07-08da0be9d848
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2282:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB22828EA3D1CB385B59EFA1A4F8179@HE1PR0401MB2282.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JBlpTbVCoJwpv3d7oGsJ5wS7EPaEDWlhy5LuDC3tcYeIVIEEeHqu13QH6YjNDMl8CJ4Ld6L2RPIIm9LqXtPHdcE+W+BozV+P03j2gD2wnJd2UZC0iZWVytgepWfdJ7G/5yMj5sNwKWGQl5LTFvM22tDU52eZO1XEkgsM0JRyJ/WRFx4a5apkbeijrrsztjbcDMYPiq7CBaVZ0NW9dhBr0fYMvmuGftuC4Ln7CXcQdDpbbXyoEfLVlbW/IJDxK1UoHCsyJvgNuO+ThYsdz30HERH0z4ow1QDFCIoB1aDoAEz5bJU3OcvBr+rLuZYxsDQfHMGgTFghHiIuYUnZCwiCwPHlEzeD5IYgdiCcrQVfLswhF2onZ46HoqZ3uKsLbtu68Kx1IKYi7rTbbe81A5Rkjx8MZOBkl89uiF7+ZFUSvy7Hf04zncVlWwBdBjyKIXBFXpj9NHoxrKl/MpCEREy6tN4bXH8z2xy+e4rseaA4UQYubLSDDlApnrdr8gQJ2Ma+Sk0tnMOaW9XVjZrU2goi1CFZ1wj5MA+oVcWLYBJbS7TBQ/Yk8fqf4IWd27yyHGWjkOwJjy4Dx9PPVgOLSD09POJsvPBUW2Uhu/9zrfSQi4JX6/Gx6L4oh/x5HsyoFM+FhDtHGA93MqK5BY9JCQ8sXgM61BhRnOMS03yGB86y3oXjpnnUgx2GHQ+tVSV4uPex
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(2616005)(38100700002)(86362001)(6506007)(5660300002)(6512007)(186003)(26005)(107886003)(2906002)(36756003)(44832011)(6486002)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQPLzF40atNglR7HPBWDWCv54451l2321sYoyK4oXIHOgMXpASgdVq75HDuL?=
 =?us-ascii?Q?3VyK2kZ3yY77j9HZrOoJLZ2Q1+ineJ64j5Ftg1msV7yVXDDvwyy25XOq+Eal?=
 =?us-ascii?Q?s5RQzC8RlvPlwDOV6pJqQqGG1Fm0R2CqByUeewDRRpk31qL9HIokGjSNSQn5?=
 =?us-ascii?Q?lQjbcxb9UOuwEfbn+ljR9NdZAiSokOMNlwdWwlGuOI0n7PFP1zL/kRtXttMi?=
 =?us-ascii?Q?Vz5KV6hgf7ihXonSmxx0w+tDkTg8xbx6qTdLbT04ct983KcNFQAw3XTHZa9S?=
 =?us-ascii?Q?JSK8W+2QF4/JZRwyTpj1QPoo2OTLvEbUOaU1Fj8Y+mm8+UU6hol0BRkADOCn?=
 =?us-ascii?Q?WOGUv8U8DqxF3ONr8fxeQH662pWk5j9uv7wfGKW7HDmpMdHdvtTySd5Wq5Lr?=
 =?us-ascii?Q?xrhS395xap2tafjXOM7G4Sr+VJh+fIfryCz8ToGeKpEafaAWtbAeFXhHHd4J?=
 =?us-ascii?Q?G5TDRqAONzOfVTms4Cv1pgY8bpeixq6Z1mU83Wh6LcUYd94+feWCXtfOeEGX?=
 =?us-ascii?Q?PEXIsKyJAIKQFpsEU5Q9NSNb9US9yIEQNKXomE0xEqMPXps5dwgeR2UEoc9D?=
 =?us-ascii?Q?TRkpWJ7jCRxAv9839yvzWLwEyH4iEO4qhflzOIlbV8PLuU/xmX+cHBu1ByoT?=
 =?us-ascii?Q?U3kbYOoSI2SdEZE2a6bzvP4QykptFAIBccfQ2heuZhopLHb4KHPWmUVNY9wG?=
 =?us-ascii?Q?Pi5XgH3+iTyaRDnovIndkZP4gTUsJ0uF2mae8ezHL8upaMuLIAmPv4oRHRBp?=
 =?us-ascii?Q?DqDL1czyEy0f6O9R5jeW1xkO28Q6UOhy+3MWg1RY2AsS5DHXRFQOeMYts7l9?=
 =?us-ascii?Q?YJwISBccf0E9CS+DooQTSKPQZu0ZX6mHcw/UK/yfmYvad/61xKMa+bhoQtK/?=
 =?us-ascii?Q?g06oZO5Ltn4GQN7PAwIls9vEWjo4LS99wA4CnJSY7I10Q3l86sbI6H2HPWHQ?=
 =?us-ascii?Q?whNginOowNtJYP36b0llbyi7QOlt9GJsbvx3r0LjsuDhZMbVgHKw7KIX7eh7?=
 =?us-ascii?Q?NVWmXY4biJk1PgJO6omcJT4LZGzN8WAZs4V9XkpzPXKs9+pXw1o5TzDY7BPa?=
 =?us-ascii?Q?8A3KMdNo+96DqRrc13TywacnNJ7mHBPfcGeHA6cCf81NDHUv4WIXtcYoqYir?=
 =?us-ascii?Q?jiHeTdvfPdP6vnRA3OCQs5RFgB8hRpJ0kqHXdihYcTKETxr7UjKgWmcnWjNK?=
 =?us-ascii?Q?wq4+4BaqT6l9a9vtbrfWsJYNU6bNPfT9H1YyQNL4LFK2slrHTB9dfFgg/JzH?=
 =?us-ascii?Q?+djqqMazfV08XUGQ0fnAVEskvvi7BTx8vnGD05YzfZ+bWZJMr/wR/IPRLESh?=
 =?us-ascii?Q?s93ogDywWhyAGIdQlsHnmBtTX+hTyPRX22/9eQi8d2oP7Bb+tpGyChn4h+HP?=
 =?us-ascii?Q?DyDN1fKzyOU3+Js7+bmU8O2dupcY/1uPbz5JxFsh54jbAqB8Wg3bV0T6BoTB?=
 =?us-ascii?Q?YFWAM0dW7Uq0k4yloIuQaO1KjBJRffnROa3OJyb2HfYHrE9X6TZtfw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faaaca5f-b13a-4842-4d07-08da0be9d848
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:53:41.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYzALEd1Ay/rdTA+6eyMvJOzciO7kXZ0b+oQDHmP9Ey0kSuAKsJWSoShstt3XaootWL+v1j+S8vhuoRKkPhq3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2282

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

