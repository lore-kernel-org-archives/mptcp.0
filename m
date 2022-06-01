Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA9362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654065969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb4iPGrUX9cts8HHtjVGVyh+GzCizSil68EXyz2+Sv8=;
	b=SH31nsPfxjXZNisSsBK2ztN9pN4AVHA3b7nfIwzrwoY5SSRUqyXQFfwiDCeGJ0J3vHbSoD
	6rmkgVrkltlo88UQ8auJP7ml1Qvsu8ADDBlEwmcqY37OYtrKsl7c8j5tyTuUg8AYBf7ooK
	uptaj9Dhh00E6iJ8ZY2kXnOlGaqO28k=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-as_7C6rGNu-FxWk1K0w0PA-1; Wed, 01 Jun 2022 08:46:08 +0200
X-MC-Unique: as_7C6rGNu-FxWk1K0w0PA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3d9eLbPBa8sOwBGIB5R6p4lZioGbyuyTj3fZxY9TcUYzQfa14cfsey/WiufWhdx2Z3F24LXWo1uxWHml2Ngp6Xe2SYkH3zsz74tXz3cw3tYbCp7BhMNSSPBQvkfNuJOf2Q4BZXNx+ihHGR7EyYCymkhxYxqYRQfgXBm0VDSmI9tRyQ/kI/9JKhUeRs9aoc7P3Yt/fwU95c4Z/fnnmeTcQXvDqlM/kOaH2h2gEMZbBsqUSnc+24APK3Vn6yG3rlFpDqpfTQco4q4N+eupUR59hX/ih9NvU0Ny030lTtrQoxOkFTWxVyqyEbdQbPFVUc4PINAB3oYEvJxtVDTN7THvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1kX8/zRtbMNU6ObA5bAo4EHAJ9E2/txENrsCWcWHVI=;
 b=dmkDtqHO1CdfsKtyToV/pK564HC+Vuz8z1XPIj3oFX7PGnvIzYzuDeF43FUCu+VmO+r0PIzfvRO+eQysqpMx//B5Q209PTbsZ6Mz9fyVxbBo0zQYwtcc++OW/YB+S4gpscYd86fJ8C/nL3gWYzLW+7ySMemkvgcYdq9VNIi76lBtRIupb3P2yP5GSKcrMZ4HBmgt8LCt7i249bozGHI+8owapdR5KAU5k3fK/GrWTQ/ngurq4SkJkcypkjNWRWDqO+Drqsl3+RgUKJJs95Tr27mIZ/2SJkTeasdp0npXqcDJyQMilw8gb9WKkFuFhaQaQFqUCxcqJrHGLr+7c3iG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2434.eurprd04.prod.outlook.com (2603:10a6:203:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:46:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:46:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 01/11] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Wed,  1 Jun 2022 14:45:50 +0800
Message-ID: <6a61daefe1888661fa63a50c108b043bd20775a1.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eabf3093-5554-402f-edea-08da439a67da
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2434:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB2434FE79B070144B490488EAF8DF9@AM5PR0401MB2434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ki7SU7ci1BdXx9t3p5p+TBz38j7FcWTcLMyZjN2I4TKdfES0530KOK+6Jmd/g6BNv37sPbHLA6i3MlyzExdOPXj6Ugub/GHELgzgpysOAMeTe8eCUEpXpDq0fZYPNLBOsuit0mc2Z8kjwHHmhXWnhrCGxfMdNxQbvTik5Q08yNwHArMG+5nhrq0eV6vdZm0bC+ZDnmtyiuX+XZGDZUEqAr2XAIuINb1gEu2v7Xe9YQRgPf6SRMUH9L5Wrtkyklq8Jz/yIuhtjqlgJliMpigvKZ5l2EzEoeQ8/3458olBDGu/u0YmDFXqOke9/Vu+YaU6AusadMP8ecRBCM5JiWyFnKt+c0JWk4iPtS1qBuUyCwLWZyZTfAgEKaMTWDZedxcGvYNCz66yPIbSZ3r3jjAJdjAPSaEB6hczP4Y4MDn4WZRoC6NcitsbhPmRjhJcM9l8utUHzTeeUYsSg3wL3bHFwFk3aJ4338/leHKZ/Fa5bqvK1ANG0DK7Efe4z9Ukke2Vj7y3MIwNKde4s9SeGY0C8zEG+8JjLbB4Wxggzfem+/h0pg2OAPCXRrK6Sd9w4BLnrOCx6fbZVDmFYoLlzBEGC/hIXyW4pwtVwPn1/3ZzfSFpYCJN2NIHsHuXFO8h6S+NItN9g4FbHOT4G8CMB3fu6rtwMuT7OmzBZ41g9OCQ4S67oO2edBm70JuP5QJoaVPT6mQYlRHz0bazUlJJRs5GSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(44832011)(508600001)(6666004)(186003)(6512007)(2616005)(107886003)(26005)(38100700002)(2906002)(83380400001)(66476007)(66556008)(66946007)(36756003)(5660300002)(8676002)(4326008)(6916009)(316002)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GkSDiNnFT6rSZfyznbXptH3x6qLgJ1faTCQmqbIZKWNqJBGt1SUzQzeMR1NR?=
 =?us-ascii?Q?gWz3nzvqB7Xs0yGfK1z9KhxjN5aewqbj4ylLhz1pGMYN5mmJTjxFCqPYkBCQ?=
 =?us-ascii?Q?7DdIJC4ij/vjNaxyzE9rg9zY0rWhdLbLeVyWpvcMHh+aWALVLGNESmM+xk8R?=
 =?us-ascii?Q?m93ZRbZ9JTr6XrsjZYbwYlL6fdaaCsYihJcDyioWEYDzeKJZ96hfXTMkfQrF?=
 =?us-ascii?Q?Z2xehspDu8uL2jshUlLyD7zyaohFL4BBLwJvxVVrYOAJuvTN0TYBWtkPkFPB?=
 =?us-ascii?Q?4KDYTB6G75y/t96EEM+nNWKQa10g0od4xX8qdP0F9/JMpVW1yyaE/Va4PwNO?=
 =?us-ascii?Q?xXwQ5ynPDFRkOlmZ0+qeC3OeaN5ovZIcBKIVzbUaDvZl3T84eL5FAE/rkwZk?=
 =?us-ascii?Q?g5M4TxB5P3Mg1P68dzdLpi5xaLFOHWX95w/AOUGzJnLUXJHU2LU2Kl4wK8m+?=
 =?us-ascii?Q?1TarnmRbuGEycZWVI3xGP4MXBB7n7pgJD+PqRmnB87JuKVyvFjee2Dksq/xc?=
 =?us-ascii?Q?r0C07rdD9uMkF8mYOKu26e9VopWlN7bx3cY7mVA9VI9lPF/QatXyXWmI0V2c?=
 =?us-ascii?Q?ytJDA14L/vOMD5839HBdSU13kVo3q290SvrkSkB7JwEhHGy/qM+UnfHo3MH6?=
 =?us-ascii?Q?dfMqLfw8bKilAcg0fEHambNwnpAMLZXUffayi0el8qccGEHjAv0QP6uaEPrz?=
 =?us-ascii?Q?4I+Y4NrjUf+2DpMlzsSe4lU5SbI9ytuUr2XKP2Ya/KwuXgKAKpnisZBQr0Pb?=
 =?us-ascii?Q?GqE98c015+9MJixBF617+vhFdJMbwBmYcHMFx6mtxQ22gRN6xZ9Cj56PlrAy?=
 =?us-ascii?Q?lIqmr1vVvZCU+l4ocuaJNoan6dSoyq2k63IsQjVH8NZgvFy8teA8YSqg4uFf?=
 =?us-ascii?Q?y2GV/RB9Vspcw5wpyJlIGMx2sso1XqmMfqJya5/RWUgug5ydngsKWv2YUD70?=
 =?us-ascii?Q?IaPD1HMR+vSIvH3LX7V1FGWG98n/mUkKYv2H74U1Wxe8iRaG+5RynGx44rQY?=
 =?us-ascii?Q?x2DloBNjC3Uuhdfw9D3uCn0qFRLYRRGeC/QGUEk+Z+1tIZfBB9wpfayGlwG5?=
 =?us-ascii?Q?MoDVNKibYIV5VZt1m2U+PltkFskXtgG8YUvIFesrDDBjeiclK0hna7F2kjhF?=
 =?us-ascii?Q?parGmUPqYEa88XkbdEHpYwa2Cd2XJwhlywdTWA8Iivc+dRfF/iRutbaESaNW?=
 =?us-ascii?Q?ld0dPxIOELO8hO2qZ3IpALLITdG+racXU6ITiEnQqgNT7UMMQgYO5cyKWPs3?=
 =?us-ascii?Q?+FTUkGdazZozUrfj3gbvxp7B8x9d0sPTn9KuBhfpaBGWG0QgTMO/TaPKhS6i?=
 =?us-ascii?Q?KYpR2HZGgh9fLFC9qV/XYqJDFqNidnr3VwJ4ZdMicaXeI/HqHNSCEyZkgXUl?=
 =?us-ascii?Q?rUCI381HEyrl+dY8Hr3u5sPNNRtV6t56yKEgW6+1dlLxeL3XA0bPOEFERL72?=
 =?us-ascii?Q?rBBzfBZ/STX1Ug0Mun20Ma+gG6zX4Puw0U6/KIwRb7vmJ5UMLgOeN602d2A/?=
 =?us-ascii?Q?U0UyQA0nQAre+Tbn+FnXNSzjQiTNnDVC9qwzaA01uaqLAkzEwAmKC5XFJi/W?=
 =?us-ascii?Q?BK6mOoMmb0C+G5EIG7TfPh08ZETAlglJeUFsVZNzSuXvvg7D56L5xiOAtFEt?=
 =?us-ascii?Q?WIOnXZoZC+PeSLwfZtBPL/fo/PFV566H6ygCvafh8ghGaSeU+7E8LV9IAbSD?=
 =?us-ascii?Q?clHGLErASM5DLkRh1LbXE5sQXbxr51W8YmDe+zQzfOjnl92D5fw+3vX2OJ78?=
 =?us-ascii?Q?b2VHnZpqaNaNO/F2fKOj6hqiirqZuBg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabf3093-5554-402f-edea-08da439a67da
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:46:07.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDH8ngJXEG8Y7vmV4Kuf4QYIL489zSsr3dEStZf3psT2jColy0WTAIfZ+WrjAeHi7fzRtpnZKaLusbjzVbCIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2434

Use new BPF API.

Please update the commit log:

'''
This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init(), release() and
get_subflow().

The scheduler function get_subflow() has a struct mptcp_sched_data
parameter, which contains a reinject flag and a mptcp_subflow_context
array.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

Add a new member scheduled in struct mptcp_subflow_context, which will be
set in the MPTCP scheduler context when the scheduler picks this subflow
to send data.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  7 ++++---
 net/mptcp/protocol.h                          |  1 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 11 ++++++++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..7af7fd48acc7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,14 +97,15 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
=20
 	char			name[MPTCP_SCHED_NAME_MAX];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8739794166d8..48c5261b7b15 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -469,6 +469,7 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
 	bool	mp_fail_response_expect;
+	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index aca4e3c6ac48..8338c7b31f87 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -231,10 +231,15 @@ extern __u32 tcp_slow_start(struct tcp_sock *tp, __u3=
2 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflow_context {
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
@@ -243,7 +248,7 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
=20
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
 	void *owner;
 };
--=20
2.34.1

