Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204F7E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646318900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IH9+kUQv02ud/elnbzWmF7DM3/FVlMWljyY6Jc8P7U=;
	b=XpMApuqGRsTlSUxQil56jARG2zFbqFcNNrHFRkmKf1m2vYVuSHStFS6GSR0GpT+USvFF6T
	af4Il3sJMMPytJnkArFpZQjn5vVYORrP21HyMv7skDfcXXTYmzBUsFmjL55vUSkXsTlryX
	aGeyXWqLCVxvNiz3yG6fyt66DQFxxTw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-3LC0cpTtO9qw__f90o5eLA-1; Thu, 03 Mar 2022 15:48:19 +0100
X-MC-Unique: 3LC0cpTtO9qw__f90o5eLA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmGRavNux5PUbMLYQWG0NrHcka59mKXu1OhZOfK6usUZfrUVoc1iZMkA/hlojoLvqrSbbrFIk3sb75TT0rnf2i47p68//hzEdBUrKl6xUJI6vjTtCXBNwnSjxPGLZR/tyuUmsj3ns9ua6UFUUbXeAw8Sx0TS1cPyOArZ0JR1uur1AUC1Xvjvnek9BWjI4xBWGW3jJIjkU7O5QOIzQaPhX4rLL0NDS4dufUVcA5WXXMEwkRGpmu1T/p7mtJ+63YZN0Gd6PsG4oeeQqLRHbOapMn5t+GFm3ahzEH2X7XuYEA40aYrS+eTjgAsh85wG89mgibzLfiJAlOBNjzrDtrWBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDzRSS2A/gHsMNtV8dH55DKgEtAQJA7cJ0mafdZ0V2g=;
 b=KMaQTSvBQimHuQ1TdbpJwQC7K1RCwsw7D/zeUerdzI8qSpIFQF/Jwrvnui0JCn7oPpHvA0vb8QvMg0UqHEwJ9uWNqrllw1NsmtnjtquQN1iRZIPujq9RsmFAu5wE/wG48VMGxN1LYxA96yvm4Cb3Xw45uK/WHFffTTFZz2CzGtHO4sE5fmBAW54OAGS8Cecul+czllfKLDYmuV7qtlWRxdd9UEp/ghYg/xQL5CkNOK5FLOzp7IVm0mEJfYDDWXSqP8teWO7vD2tndeJxjivYV4EWF+G4iF8lS8jc+lW9y4Q9Y0ywWRc/coFA/lDK5WB22SJaweVUAtCeeNq4lH9n2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8538.eurprd04.prod.outlook.com (2603:10a6:20b:435::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 14:48:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 14:48:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/3] Squash to "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Thu,  3 Mar 2022 22:47:58 +0800
Message-ID: <bf46de1436af717fa8eff55a9c20ccaaa261796d.1646318613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646318613.git.geliang.tang@suse.com>
References: <cover.1646318613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39473cb4-c0e3-47e5-8488-08d9fd24da11
X-MS-TrafficTypeDiagnostic: AM9PR04MB8538:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8538AD1132BE2E487FD7D1D3F8049@AM9PR04MB8538.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iMDri7pbR/6gdUlBtFo+77KWpEWol666wmAsperLCZreQGeAtKlhqsX9iDij42YIdvESu9oHDJcIHyJg9BqSVOPj7EnaFATKWYQuF8BygfFM6BeMeWHRajjnR90MDOJTdmzzZKDs/+CR4J0Ggi2/D18OjmQSigZZsddsPc6ZOgx5GCereLy7aELyOxEswnqWP6mJV92jWzQ6oH0nkGQ9iGGE/1iE7frSQ9+VVoiMBxUoJBHPRU7Fs+TDuE6NLsWZkvW8Jf6SJlTw0hXM0Heb2T77ZpiG2mHmKIfy2wHjcUup8i4AKqMPQMDoHgGrxICaNuuydB+WeZjbTFwymaF+RAjaWLayRLbGTz67ClbfHy2qKdpmhmxsLL7LpAkSbuuMYLh9aRn9pbnYU8aLfTu9rWiFfgdb9No6aoO1mptHQiIxzan4vOu5jcS7IbdH0VcIOLE0clEVBwSG2S6SzjOipuZrMNSL/vEAs3ezD5mlveuXgfsJJo3QIcGs1eYOPs7mW1cHfueD8eztYrO23ALyU8vVlVVCfgCah2wql2R7rxvnLIPepSV44hx8el+0re8DZrgpj8BSIMI5YUDNe0f+d+irNDcDnouMTsP+xGSumSzJETAy9QML2wXoF1CXqowR0/f6kv1rJCxzI1i6C/WiXpIBFN2rP/ZT6xE9dy3uQ0Uc/lXqnJFoCcFnlJXwzrc7Jmd1cLstr+AazfR72OVn6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6512007)(6506007)(5660300002)(38100700002)(66476007)(2616005)(6486002)(36756003)(6666004)(86362001)(44832011)(4326008)(83380400001)(26005)(6916009)(2906002)(186003)(107886003)(316002)(508600001)(8676002)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzI2yojv2S4XOFiCtbDofQB/wP2Vv84eHAD6/BfQl0B+df9POxeCaz+dw7kU?=
 =?us-ascii?Q?k+B+BMbBdopMuXFXZIXE/fh3Us6kwav9D4JYFKR8Wr3el1JjURvib2HqdQ6b?=
 =?us-ascii?Q?5j3PMXJWFtLfyy7op04xXWW86bkoBG3VXwTjP5ktngQsImIKYfEb8KdIzSaY?=
 =?us-ascii?Q?0qGnpqXxj0dBN7Fmke/RwKzfdWiEVUWuH3wZPdSiRV1FSY1o2XJk2xfPc1cl?=
 =?us-ascii?Q?Qi7/e6dBkoU8SCK9xb1xC5pJ17zetBS9kfElNQw58EdykbQaVzrD6DAh1U9m?=
 =?us-ascii?Q?Ejq+CiaZf0gUtHo/Nk9Ht1hxQmWrUwNsD0zJy5wxgj2J7is97EKCZYvODACB?=
 =?us-ascii?Q?WcKhggNx8lcR+Dr1OJyhZuW+EpQLkjm3Z6kXJy3bePU9UVj1VTGp24d0Co+t?=
 =?us-ascii?Q?Rz8kjeFfxU7TGtF39Rptd846xs9P3PvBBXtlzYyqAnX3bAtxQdHEus1okrQg?=
 =?us-ascii?Q?d6gIV5XH2Sg2Yu21QUYeJKNdn8yaghKCFgRfYnZrLXWbNxShKNLPi2brW+Ig?=
 =?us-ascii?Q?DHXIBOY89dacgY+vd7f03pZLteON2cuZ+aDa6Y+F0v65SclF94MtHkyPKdYl?=
 =?us-ascii?Q?gaHlPb8L1Tms5E3J0FlRmmUlUBXvxzzlWIMK7GXk7XAViXK3FtooGkzJQxb7?=
 =?us-ascii?Q?vUebNqZpCQnR39gEIhw+TiKYOelQ0dSEsn5S36csxJZzgIIPjuWYfHQkrwUJ?=
 =?us-ascii?Q?TKpuYCWzLzn4wC6lj5IF+tWSa6sfT62GfuDJ1PnJEKR2HQjB5P+pL+c5wPDT?=
 =?us-ascii?Q?f6aYvnK4nGZXxREC9PgdfeoclYhLu23Q6rTJFtaodnh2lctRDBUBaXJEYlCq?=
 =?us-ascii?Q?bENvjkeLskv9tTeYFkS4pPw8WQySql56qAs3dZOCydcXbWMXProTdgz3FQE/?=
 =?us-ascii?Q?IlYZGZ8NwrHw+C/zrH8PiLYCws0b6iBfTB9yN1nJ/oVSEtsjYPkYAevyXO69?=
 =?us-ascii?Q?ctXZxOC2utVRZN0tkPxrpNrxh8YePCoEOQKbfFPAk2TOnmJjlMF69Fs5Di/f?=
 =?us-ascii?Q?Ap3qfRuQ1mqKeHMtSu6Ug/f+YrvKUGLmxEwsoYrf68wP9kYBPBRqLCw9e2uD?=
 =?us-ascii?Q?qsYIQj1TIdf6ogQm1wJDCHAsDJel2mBB3qxiBQzOA3JFdQzWVylijG+xGWj+?=
 =?us-ascii?Q?U/2OYDBv0SjZ+tOYnWZ2MvKf4dipGnhL5yIDxije4zQ4L6bovXMf901WLGwC?=
 =?us-ascii?Q?ridYSyISJWbhM0wq+ZaSWCLJmDfKrtEuZvn/VqtZNb7smPJ2qrN+YBD8EQnz?=
 =?us-ascii?Q?cpSbddt3TlZpBEmdrCu8rPRqCMrQqEh+pnDoO7GRKHIcqBF5nYp7dV9KFH2h?=
 =?us-ascii?Q?eEUnCay2SKouMrTEndA0nYftizLmTk8KKsUAAanfwMRecN6FhiGftNrdep9A?=
 =?us-ascii?Q?K5WxXcUbWprF5QMLdmVyd9gSFGcGmlDwSdjnbeuQ9TTk8XGPDJvgKyYtcjMO?=
 =?us-ascii?Q?zDphrJ5dBXnefD1bljxa/bnXf/YxovPfO/DIbrjOxuKUz6EBIedN4MyE2g9p?=
 =?us-ascii?Q?m88H1j66Ve9AEk8ne1y4z2LhVx2UTUoK8e1gFQOHtm0PgWfqQOKwTnyjBMHc?=
 =?us-ascii?Q?ErKFuYbNHRWDwVfVh7ZvAdgX81Zf2LL9c0uh0MpDTeCCVL7gmIUhyOsavHTz?=
 =?us-ascii?Q?CrTxWG/Pyl+f6hEpYSwK2z0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39473cb4-c0e3-47e5-8488-08d9fd24da11
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 14:48:17.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCaE9deZEZN7GJLXZkJhQFL4XNcjtof9NPviyPlfNQJpde4McEjw8nC3ZOMG2IsEAx2vlZRvAuvX5VA8+JanHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8538

Drop RET_PTR_TO_MPTCP_SOCK and bpf_mptcp_sock_convert_ctx_access as
Alexei suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h   | 20 -------------------
 kernel/bpf/verifier.c | 20 -------------------
 net/core/filter.c     |  4 ----
 net/mptcp/bpf.c       | 45 -------------------------------------------
 4 files changed, 89 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5a17c1e3a6bc..0ae57df2f226 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -407,7 +407,6 @@ enum bpf_return_type {
 	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
 	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
-	RET_PTR_TO_MPTCP_SOCK,		/* returns a pointer to mptcp_sock */
 	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
 	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memo=
ry */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf=
_id */
@@ -418,7 +417,6 @@ enum bpf_return_type {
 	RET_PTR_TO_MAP_VALUE_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
 	RET_PTR_TO_SOCKET_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
-	RET_PTR_TO_MPTCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_MPTCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMO=
N,
 	RET_PTR_TO_ALLOC_MEM_OR_NULL	=3D PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_=
ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
@@ -499,7 +497,6 @@ enum bpf_reg_type {
 	PTR_TO_SOCKET,		 /* reg points to struct bpf_sock */
 	PTR_TO_SOCK_COMMON,	 /* reg points to sock_common */
 	PTR_TO_TCP_SOCK,	 /* reg points to struct tcp_sock */
-	PTR_TO_MPTCP_SOCK,	 /* reg points to struct mptcp_sock */
 	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
 	PTR_TO_XDP_SOCK,	 /* reg points to struct xdp_sock */
 	/* PTR_TO_BTF_ID points to a kernel struct that does not need
@@ -528,7 +525,6 @@ enum bpf_reg_type {
 	PTR_TO_SOCKET_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_SOCKET,
 	PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
 	PTR_TO_TCP_SOCK_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
-	PTR_TO_MPTCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | PTR_TO_MPTCP_SOCK,
 	PTR_TO_BTF_ID_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_BTF_ID,
=20
 	/* This must be the last entry. Its purpose is to ensure the enum is
@@ -2221,7 +2217,6 @@ extern const struct bpf_func_proto bpf_get_local_stor=
age_proto;
 extern const struct bpf_func_proto bpf_strtol_proto;
 extern const struct bpf_func_proto bpf_strtoul_proto;
 extern const struct bpf_func_proto bpf_tcp_sock_proto;
-extern const struct bpf_func_proto bpf_mptcp_sock_proto;
 extern const struct bpf_func_proto bpf_jiffies64_proto;
 extern const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto;
 extern const struct bpf_func_proto bpf_event_output_data_proto;
@@ -2309,7 +2304,6 @@ struct sk_reuseport_kern {
 	u32 reuseport_id;
 	bool bind_inany;
 };
-
 bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type =
type,
 				  struct bpf_insn_access_aux *info);
=20
@@ -2365,11 +2359,6 @@ bool bpf_mptcp_sock_is_valid_access(int off, int siz=
e,
 				    enum bpf_access_type type,
 				    struct bpf_insn_access_aux *info);
=20
-u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
-				      const struct bpf_insn *si,
-				      struct bpf_insn *insn_buf,
-				      struct bpf_prog *prog,
-				      u32 *target_size);
 #else /* CONFIG_MPTCP */
 static inline bool bpf_mptcp_sock_is_valid_access(int off, int size,
 						  enum bpf_access_type type,
@@ -2377,15 +2366,6 @@ static inline bool bpf_mptcp_sock_is_valid_access(in=
t off, int size,
 {
 	return false;
 }
-
-static inline u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type t=
ype,
-						    const struct bpf_insn *si,
-						    struct bpf_insn *insn_buf,
-						    struct bpf_prog *prog,
-						    u32 *target_size)
-{
-	return 0;
-}
 #endif /* CONFIG_MPTCP */
=20
 enum bpf_text_poke_type {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1bb1b5d0419d..d7473fee247c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -430,7 +430,6 @@ static bool type_is_sk_pointer(enum bpf_reg_type type)
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_SOCK_COMMON ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
-		type =3D=3D PTR_TO_MPTCP_SOCK ||
 		type =3D=3D PTR_TO_XDP_SOCK;
 }
=20
@@ -438,7 +437,6 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 {
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
-		type =3D=3D PTR_TO_MPTCP_SOCK ||
 		type =3D=3D PTR_TO_MAP_VALUE ||
 		type =3D=3D PTR_TO_MAP_KEY ||
 		type =3D=3D PTR_TO_SOCK_COMMON;
@@ -454,7 +452,6 @@ static bool reg_type_may_be_refcounted_or_null(enum bpf=
_reg_type type)
 {
 	return base_type(type) =3D=3D PTR_TO_SOCKET ||
 		base_type(type) =3D=3D PTR_TO_TCP_SOCK ||
-		base_type(type) =3D=3D PTR_TO_MPTCP_SOCK ||
 		base_type(type) =3D=3D PTR_TO_MEM ||
 		base_type(type) =3D=3D PTR_TO_BTF_ID;
 }
@@ -554,7 +551,6 @@ static const char *reg_type_str(struct bpf_verifier_env=
 *env,
 		[PTR_TO_SOCKET]		=3D "sock",
 		[PTR_TO_SOCK_COMMON]	=3D "sock_common",
 		[PTR_TO_TCP_SOCK]	=3D "tcp_sock",
-		[PTR_TO_MPTCP_SOCK]	=3D "mptcp_sock",
 		[PTR_TO_TP_BUFFER]	=3D "tp_buffer",
 		[PTR_TO_XDP_SOCK]	=3D "xdp_sock",
 		[PTR_TO_BTF_ID]		=3D "ptr_",
@@ -2778,7 +2774,6 @@ static bool is_spillable_regtype(enum bpf_reg_type ty=
pe)
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BUF:
@@ -3671,9 +3666,6 @@ static int check_sock_access(struct bpf_verifier_env =
*env, int insn_idx,
 	case PTR_TO_TCP_SOCK:
 		valid =3D bpf_tcp_sock_is_valid_access(off, size, t, &info);
 		break;
-	case PTR_TO_MPTCP_SOCK:
-		valid =3D bpf_mptcp_sock_is_valid_access(off, size, t, &info);
-		break;
 	case PTR_TO_XDP_SOCK:
 		valid =3D bpf_xdp_sock_is_valid_access(off, size, t, &info);
 		break;
@@ -3830,9 +3822,6 @@ static int check_ptr_alignment(struct bpf_verifier_en=
v *env,
 	case PTR_TO_TCP_SOCK:
 		pointer_desc =3D "tcp_sock ";
 		break;
-	case PTR_TO_MPTCP_SOCK:
-		pointer_desc =3D "mptcp_sock ";
-		break;
 	case PTR_TO_XDP_SOCK:
 		pointer_desc =3D "xdp_sock ";
 		break;
@@ -6762,9 +6751,6 @@ static int check_helper_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
 	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_TCP_SOCK) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_TCP_SOCK | ret_flag;
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_MPTCP_SOCK) {
-		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type =3D PTR_TO_MPTCP_SOCK | ret_flag;
 	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_ALLOC_MEM) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_MEM | ret_flag;
@@ -7479,7 +7465,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifie=
r_env *env,
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
@@ -10854,7 +10839,6 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 		/* Only valid matches are exact, which memcmp() above
 		 * would have accepted
@@ -11385,7 +11369,6 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type =
type)
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 		return false;
@@ -12810,9 +12793,6 @@ static int convert_ctx_accesses(struct bpf_verifier=
_env *env)
 		case PTR_TO_TCP_SOCK:
 			convert_ctx_access =3D bpf_tcp_sock_convert_ctx_access;
 			break;
-		case PTR_TO_MPTCP_SOCK:
-			convert_ctx_access =3D bpf_mptcp_sock_convert_ctx_access;
-			break;
 		case PTR_TO_XDP_SOCK:
 			convert_ctx_access =3D bpf_xdp_sock_convert_ctx_access;
 			break;
diff --git a/net/core/filter.c b/net/core/filter.c
index a07b28997ad3..f64454722a7e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7850,10 +7850,6 @@ sock_ops_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
 #endif /* CONFIG_INET */
-#ifdef CONFIG_MPTCP
-	case BPF_FUNC_mptcp_sock:
-		return &bpf_mptcp_sock_proto;
-#endif /* CONFIG_MPTCP */
 	default:
 		return bpf_sk_base_func_proto(func_id);
 	}
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5332469fbb28..2e42a95d1206 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -25,48 +25,3 @@ bool bpf_mptcp_sock_is_valid_access(int off, int size, e=
num bpf_access_type type
 		return size =3D=3D sizeof(__u32);
 	}
 }
-
-u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
-				      const struct bpf_insn *si,
-				      struct bpf_insn *insn_buf,
-				      struct bpf_prog *prog, u32 *target_size)
-{
-	struct bpf_insn *insn =3D insn_buf;
-
-#define BPF_MPTCP_SOCK_GET_COMMON(FIELD)							\
-	do {											\
-		BUILD_BUG_ON(sizeof_field(struct mptcp_sock, FIELD) >				\
-				sizeof_field(struct bpf_mptcp_sock, FIELD));			\
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct mptcp_sock, FIELD),		\
-							si->dst_reg, si->src_reg,		\
-							offsetof(struct mptcp_sock, FIELD));	\
-	} while (0)
-
-	if (insn > insn_buf)
-		return insn - insn_buf;
-
-	switch (si->off) {
-	case offsetof(struct bpf_mptcp_sock, token):
-		BPF_MPTCP_SOCK_GET_COMMON(token);
-		break;
-	}
-
-	return insn - insn_buf;
-}
-
-BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
-{
-	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_mptcp(=
sk)) {
-		struct mptcp_subflow_context *mptcp_sfc =3D mptcp_subflow_ctx(sk);
-
-		return (unsigned long)mptcp_sfc->conn;
-	}
-	return (unsigned long)NULL;
-}
-
-const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
-	.func           =3D bpf_mptcp_sock,
-	.gpl_only       =3D false,
-	.ret_type       =3D RET_PTR_TO_MPTCP_SOCK_OR_NULL,
-	.arg1_type      =3D ARG_PTR_TO_SOCK_COMMON,
-};
--=20
2.34.1

