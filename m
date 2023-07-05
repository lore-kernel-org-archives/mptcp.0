Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAF10FE
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 06:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3Z/8LwfQeOY2GeXKjopzrDjRLAMWcenKHiOYfQMylAFgni+MkOH9QIzhdJmNLnDz/0n6tbZ5RI7gc+1oIXYyXVsH1RrUwWwlqhcLSaruebBdbAj8zwfHvpJSrQv4Op+WgbbjGAMZKf7hGnmHtB+WsUzG/phvHSc1/dpFzvAxyssasftWNbkmzNsmvcmAc4lBbjcbdLWX1IuPLFYSaq3ZLZrVzdoSuIVgbdTJvEGxPyuUs2fZkmNdT6tHdD5O/vco2oI+kpCpBfRy6R/8/NJxqMe/0D6u+2CKTix/j9xYE9yx//6eRvuCp/huq+NUwnGNHzvzZlBASu648gcmH3dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbQgqogigrGt8UQgTlGHzEayRktH80TZ6EqI9hjgTrI=;
 b=DlbkhA/v0+tZrQ+XE9cnlIhjUt9XBaVZIywFuY7T4w5dRg6MkRLpMIvOk+I26IvaIbt2eJWvS3UwbGBMfRkPzneIErK8f+LQYY7BmcjViUkF41VvOc++tXINSe3mJE/6KzeJNVYnXhzFEvF/5oijHripDHifnwiLO3iTtJu44vlrvEGuUbXjoeClNTdYGUYmf7frCYusphbthMiZJIwwDoyalst4LKE5sBzSe1C1Jp2kBnM+ZR/5qY8jpU4rSvJbGR1FJhoEqNGtJmYg/R58hrHHxKICnsvy2cyh6/HhDW9f2bk4QCE7fIYBToNrW+8aYMhNhVl9knwFNfMthrC+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbQgqogigrGt8UQgTlGHzEayRktH80TZ6EqI9hjgTrI=;
 b=bu1HJppxtn831K8AvOF/YKf64Y0uxyeY916Nrf4GHdwCdIOMpA22+3mwjrx4q2PyrfUfZYNUGfQeQ7FadmVUCB2R8QmBJgD9AZs6r8bTkHIDynrFKnLSsKJO1hLSZH+dD5kbuohTVrbT1ha1m88ehpo6hPDoKbuYk7xCLYkQhNWAbkArtSOQvJFhLlkzKZvSBigXQ01MKdEyfyQ1/JHPzpUPQH1n3MTwzxWNpp6HOCdf3OZA56zhvy2+hC6juECY8C/+V9A6K/DuTrvsibIYEhnmjvgfYFfP8Gfwsv+IzsdCmH0hiu74z/zMEdOYdnJdC9Mkvtc6CW0N5t343C4U1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7187.eurprd04.prod.outlook.com (2603:10a6:208:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:56:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:56:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/7] bpf: Add new prog type sockinit
Date: Wed,  5 Jul 2023 14:56:35 +0800
Message-Id: <611b0ed15ec0df0ceefe513c1fb5453be551557a.1688540074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688540074.git.geliang.tang@suse.com>
References: <cover.1688540074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: fa34e45c-41a2-423f-c5c5-08db7d2503e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DroLGmw/UTKNHtR8VwShz4WE1nM2H1W0Oy2WiTyGjNvhDQfRkp+KRZSJQFmcP25aTYDM2KQ3I2qoWAuP7qfbqzUYqS/KlEO9C71m/coN6E1PJ6aL5aZCtmashNgy45LpAR2I/M+VBf8hP1V1Q0zgCsZwLYjSI5ckWoy+HVCh9VC4qTwmO1MOoIt1y2WmO++bFkzIL+PfF++1PjJ0ieXXDGQllPDAF+nkOYkTLtbkxsOsrJeUZ2TAvdYC3CPlsC1MgQNZgS4IJKCMYRXTvYAo1KwQr/Mnfqlkm+HOkkzWctPj4UypqgM48QvREm8oPBiAnmtiJShx9xufdhEjYo6Lb+zyYMvPuIfwc3R9kZvj2RGgpg6O24PtZiEuF0PKBRHziSpLfhL7vkCv9x1txuL0SgkgGndtxoGJKDA1rZVjRmAk9JDcxYmQCrBlZ4nQ9GCVcSQ7JGryvovE0eLdiv+viK1X/JM3E8HtOvpHtQQu5PSVkOcyaXOWmz9GJ+TrRMFIU9st4pqqYfgh+UOt5HheNKsqe/KZDjAlcWzNcX8fIghReGEJLCV3Jc9criOhQlfu7TOieBZ0Pz+4NlA4scfdUvaDRsG1RnwB6J06Q43i580=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(44832011)(5660300002)(8676002)(8936002)(41300700001)(316002)(2906002)(83380400001)(2616005)(4326008)(6916009)(38100700002)(66946007)(66476007)(66556008)(86362001)(186003)(6506007)(26005)(107886003)(478600001)(6486002)(36756003)(6512007)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgOO++4p9A+c5AWJN1qh6Pkqx6qcUz8DRC1iAXKxgnMN47M8KWBEwmbselg9?=
 =?us-ascii?Q?PNsAjGCc5pyLLPDvd8hudDepPBDzuMA7rIKgGShI26gUrgyfRqBACDfmHULJ?=
 =?us-ascii?Q?iJkTZCCE0n7IBNR+G4XhiCAl3FfA2cWqjM5+dnl0aM7VPBgYgiqrYIFj4nsq?=
 =?us-ascii?Q?Sl6WtSXjezeTKvQXCVJVWKYuV3m9jU2n1/5Zh3JsBEhRqjCAgULNcnJXDH5/?=
 =?us-ascii?Q?W8YBwNbLQj+02q/NeyD+7KmAzlKo421IApcxVBUMfmiVKpp0REVw2BPcgKtQ?=
 =?us-ascii?Q?0a2SfwsljouSQWdRS9VVWIBop4kS2F1c4rXamI03mveW3+V+aMFw79/kmESd?=
 =?us-ascii?Q?JOBCkIgkcvPPu86PZ3cGpBbbHt2XkiRYl3QcOTHb/YeA05xzBlf4bqNAwwL2?=
 =?us-ascii?Q?n8KX1C65qL2q0fftDU/mQkvPvsbmbcuGYnh9h/g+0mIZ/tWSZnoo/pMXPthb?=
 =?us-ascii?Q?5s3iCb0GPh9MKORz6hykL4iA4G9uuCKovs13t4NoWq9QqILO3RS8Hi4vlZqb?=
 =?us-ascii?Q?oEFnFe/d7PDuJVG8Uzgqeed2ioZV/KUsGHP4HrfKfe6cA1nRVZfKVTOfz1Rc?=
 =?us-ascii?Q?goHYiFoLSikRAs0cn9g50v5LcS1w/xyM+oem4sgTLWXbKttvbRVUnDBNV0xB?=
 =?us-ascii?Q?eIdrewvtwh6skUE+9M1980wpC2/VWgE9lWCu5UWT8p7ETTkk2gkOqStAMaQT?=
 =?us-ascii?Q?E9WO22zGSfAX+qsCwkjygsrgTPSlZpZAeSSMXXCPq3SiHr9fsEirM6UCs79D?=
 =?us-ascii?Q?XJ1MDhv1fg6W3sAc8L43EnGGdMCe4m19eelOsE5UtYn60VaXvofl8GKVR9mx?=
 =?us-ascii?Q?1hBFlPmCg/bVfDUQhfWBTYkcZXYalDCIGU2t2VTc5WxEPX4EqCxeazFUB2Jm?=
 =?us-ascii?Q?qr6FeJpOyiedne7ytFKURXiK/tsRHzHm7wfp+vwEUtb0n/DAu2nNQ/b387Cy?=
 =?us-ascii?Q?Sl9zk6vrcTHEyT73NGTw+w7eDVTtDqdjbXXuVHSp27ZlvJHQHsVHVG61xcn4?=
 =?us-ascii?Q?0X+eru6GN5U2vpgjaXFJfw6ywxR92ur4IicDBsdk+H00UYybNr7BJVL2bGRu?=
 =?us-ascii?Q?/tVb+I6f3PixrVSsH6T12vTXsPLDTbjyjmsAdKw9ucNO9JX9vB4WPjLk+Y2G?=
 =?us-ascii?Q?QT1APb2vXjptKbh7pWsW1vOWQdyLWqgP4T36eZON4sE3CCZE4cYoKdBF2vvy?=
 =?us-ascii?Q?wd4WyG6Rm0xOxZKH9K1HwD7KHxlpSWuBSLuq04/LbfJl6ZQU5wW9+fSk6L3i?=
 =?us-ascii?Q?7KVailTSqeT77ftS2v/iDrsqZj2eX8OJ9HdTelwLxwgD01BJDDFRaz9QZgcS?=
 =?us-ascii?Q?OsihzbX+AFMgBfdGIutD1mhRu/OZB4wNUa66H1cux+4VM538ve4qoB+SBo3K?=
 =?us-ascii?Q?OZVSk4r3vU/q3UEPJ7+h5e4w0vZyGTD6BS4UeZpOCo8J3wDrZ6vKDL5alp5k?=
 =?us-ascii?Q?/Gf1T7goAz1rFWnQG0dXzmXpVfO+D8QseVUwsa3+sfFW9tp9TIV3jjuRtWTZ?=
 =?us-ascii?Q?Y5hoz1kSqM5iE7htrR0PwTne+4TXHi5CzAD1QNzz/I1cydDxxWxXkPFcf7yo?=
 =?us-ascii?Q?IYhhyv15cFgfpT4rIXzrKs6DifpAjrUVDSkOVo1h?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa34e45c-41a2-423f-c5c5-08db7d2503e2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:56:53.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71ZgASiLBuIYziAPA0o0v+96jkkZ+Who80RM1KopvbJgxZ8gNUFYiUPKW3DbfSHmqNQ9ZH1oi2nAV/0LkFwqjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7187

The patch introduces new program type BPF_PROG_TYPE_CGROUP_SOCKINIT
and attach type BPF_CGROUP_SOCKINIT on cgroup basis.

Define this program by BPF_PROG_TYPE(), and implement two operations:
cg_sockinit_prog_ops and cg_sockinit_verifier_ops.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf_types.h |  2 ++
 include/uapi/linux/bpf.h  |  8 +++++
 kernel/bpf/cgroup.c       | 66 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c      |  7 +++++
 kernel/bpf/verifier.c     |  1 +
 5 files changed, 84 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..44afed8e5444 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -52,6 +52,8 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_TRACING, tracing,
 #ifdef CONFIG_CGROUP_BPF
 BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_DEVICE, cg_dev,
 	      struct bpf_cgroup_dev_ctx, struct bpf_cgroup_dev_ctx)
+BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SOCKINIT, cg_sockinit,
+	      struct bpf_sockinit_ctx, struct bpf_sockinit_ctx)
 BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SYSCTL, cg_sysctl,
 	      struct bpf_sysctl, struct bpf_sysctl_kern)
 BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SOCKOPT, cg_sockopt,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..cb882ab8065d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -980,6 +980,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	BPF_PROG_TYPE_CGROUP_SOCKINIT,
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
@@ -1013,6 +1014,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_RECVMSG,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
+	BPF_CGROUP_SOCKINIT,
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
@@ -6829,6 +6831,12 @@ struct bpf_raw_tracepoint_args {
 	__u64 args[0];
 };
 
+struct bpf_sockinit_ctx {
+	__u32 family;
+	__u32 type;
+	__u32 protocol;
+};
+
 /* DIRECT:  Skip the FIB rules and go to FIB table associated with device
  * OUTPUT:  Do lookup from egress perspective; default is ingress
  */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..93b9f404a007 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2505,6 +2505,72 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
 const struct bpf_prog_ops cg_sockopt_prog_ops = {
 };
 
+static const struct bpf_func_proto *
+cgroup_sockinit_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	switch (func_id) {
+	default:
+		return bpf_base_func_proto(func_id);
+	}
+}
+
+static bool cgroup_sockinit_is_valid_access(int off, int size,
+					    enum bpf_access_type type,
+					    const struct bpf_prog *prog,
+					    struct bpf_insn_access_aux *info)
+{
+	const int size_default = sizeof(__u32);
+
+	if (off < 0 || off + size > sizeof(struct bpf_sockinit_ctx))
+		return false;
+
+	if (off % size != 0)
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct bpf_sockinit_ctx, family):
+		bpf_ctx_record_field_size(info, size_default);
+		if (!bpf_ctx_narrow_access_ok(off, size, size_default))
+			return false;
+		break;
+	case bpf_ctx_range(struct bpf_sockinit_ctx, type):
+		bpf_ctx_record_field_size(info, size_default);
+		if (!bpf_ctx_narrow_access_ok(off, size, size_default))
+			return false;
+		break;
+	case bpf_ctx_range(struct bpf_sockinit_ctx, protocol):
+		if (type == BPF_READ) {
+			bpf_ctx_record_field_size(info, size_default);
+			return bpf_ctx_narrow_access_ok(off, size, size_default);
+		} else {
+			return size == size_default;
+		}
+	default:
+		if (size != size_default)
+			return false;
+	}
+
+	return true;
+}
+
+const struct bpf_verifier_ops cg_sockinit_verifier_ops = {
+	.get_func_proto		= cgroup_sockinit_func_proto,
+	.is_valid_access	= cgroup_sockinit_is_valid_access,
+};
+
+const struct bpf_prog_ops cg_sockinit_prog_ops = {
+};
+
 /* Common helpers for cgroup hooks. */
 const struct bpf_func_proto *
 cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..2952dd88c614 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2513,6 +2513,7 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_EXT: /* extends any prog */
 	case BPF_PROG_TYPE_NETFILTER:
@@ -3574,6 +3575,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
 		return BPF_PROG_TYPE_CGROUP_SOCKOPT;
+	case BPF_CGROUP_SOCKINIT:
+		return BPF_PROG_TYPE_CGROUP_SOCKINIT;
 	case BPF_TRACE_ITER:
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
@@ -3640,6 +3643,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_LSM:
 		if (ptype == BPF_PROG_TYPE_LSM &&
@@ -3682,6 +3686,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_LSM:
 		return cgroup_bpf_prog_detach(attr, ptype);
@@ -3726,6 +3731,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_SYSCTL:
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
+	case BPF_CGROUP_SOCKINIT:
 	case BPF_LSM_CGROUP:
 		return cgroup_bpf_prog_query(attr, uattr);
 	case BPF_LIRC_MODE2:
@@ -4717,6 +4723,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 		ret = cgroup_bpf_link_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_EXT:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..d0ade7759123 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14316,6 +14316,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 		break;
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 		if (!env->prog->aux->attach_btf_id)
-- 
2.35.3

