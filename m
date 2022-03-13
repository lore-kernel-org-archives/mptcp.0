Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0587E
	for <mptcp@lists.linux.dev>; Sun, 13 Mar 2022 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647178092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kHeSKth+3W4VOaQ5qTkUjBEdPfvylSJVdxkxKPtFLD8=;
	b=lH4QG08qq9PkvjGWwl1O33NeI3q7e/EOosHhtuYoofLiyCBG3yPVkf9VrKuZ1Af3/E+ZXr
	213JSY4KEZuxkdh2wtbC2NoDYvkAuJ8nVLAGyy7suZpUd+HaoZ+yA7cGQvVTRIj0K6CQy2
	oGOkPZQKdzfc3ySHlK3wDoBIOQaGUWg=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-ygnqbpH0PLiNUP4ipMhPNw-1; Sun, 13 Mar 2022 14:28:11 +0100
X-MC-Unique: ygnqbpH0PLiNUP4ipMhPNw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfRTadsqaQb1BMBGjuiQgztqVN/ciZ5jQyZxznpOKeJeXCCh7LZdOHxoIqA5qPnk1xIv6pXBwWFEOs6QmJe45lg5kHxmC8ttH3NBQqSIdFRAUsRckcuCTryAisOaPIl4MvXOsuwafs41kmI2HOmJnTSXXOKMyZRAEHUx8sFj3PPlPdd3sGK6k/ARYpAfauiRMAptmqJSPgbQwYVe+CH/agPP0OSxt0eDp06JKhREHyNN1ocC+UAC+NRHBv5QW11HOP7BnLRj8ojPutQKi5qb1RJNGpw3MR0/0fUl09kV97C3PGKKjrcXpkptE1Y0R1gbdn8iDtaycsneASDDyMR6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtlSx/SVQo6W9ae5wiVtWUB4dxydZYGYMV0rA8v2V08=;
 b=kSOMh+4doQT5xaCl019dit8g0oUufTj/CP9O4NqxfS+JP0kpodPESG8xdbAi8WlqrdJ+ULNMm3SQlrIYshBFn/sx09DwQUUSG0hq2K0cQgUljcbJZFXNKvtaSpKByZcCE410SkbDbvQKGyxeNk55F+PJqu69XvKBu0nGVKluWfJY5a5kh9JtJqecBsGPsH43HgoYaztNiu4NcuUemthuOBZ4j4NmcanIwJpMwimWPCLlY2zSGqLAYp6YF08DomDJZbkryXIZ0uM1Dowo71xKGA/PdaLb1+VRXuihsOZMalWTlQpNCanAF8tJ+aIYjNTKoRem9feYiD08VFHKX/Jbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 13:28:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 13:28:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3] Squash to "selftests: bpf: verify ca_name of struct mptcp_sock"
Date: Sun, 13 Mar 2022 21:28:06 +0800
Message-ID: <4176f0408a1543b567e201668d97c2ffb52a9eb8.1647178008.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7fd6b24-185e-4992-cd66-08da04f550d6
X-MS-TrafficTypeDiagnostic: DU0PR04MB9442:EE_
X-Microsoft-Antispam-PRVS:
	<DU0PR04MB9442E0D6941ECDDB423A58FAF80E9@DU0PR04MB9442.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MeyJQMKF0tLNKlX/Yty3RaNo0vrtFTtfmXNF7kyT90vqz+zoCDR8xHdtGMQhVwR5srCyCxu+Gzd7j3+erwY/9bmkLgT8GQE/FhXlOoUNkboeaWmn6Tu9EpD8RmGtRINUxV806Xu3m2JW94Axnl8a2Rq0mh5cSvABrMOk/0qRUE+F7ZDMm9yUVwngJhbaD4Clo0WywH9CFn29p8HBCc0JLDsoBEM0NLaSIq9EhDv6V+Mntmw/SGHFXMnOYXfLOtb/TKzU4gZmux7kWOCVPjlyjdcSZRNC1jIOa3uCeX4xrl/ucWU7+e6HzcaxJx1iGrA7RZvKkhXtwvIeTvqeAVAAsPGXxx+0OMORvThZX18Qy+fNvpgkQke3L5HRxLoxvhFqRuUu9SvsBXZtgfpSTJYjuonkwxOFlW4w/JoscZn6dDTd1R6HQy81i2/i8L00atkOSZwqWJ/da5Nwe6kM00qC0oiHfZSjZVEcbICpedzWrTl6d/y6p5oOpn+K1RxQgwBENnrq60Y490EeCl705xYpX98eBlomsKXKM7oOvk4McduTfLP0rZrA0vfaNunwJMFB3CRDDNrEYtE1uOp9/LdW/hh0yHvhJLc+MxJ8izU26A+zfKkH6SZtyXZV3lUyMFrBQNmuY7BbK1DYE7aF3/sqNsshAkQwpzoRVLUTeSZfJ3mj3uXADMKFMEl3yr9qOOkTS5ODtJO2E6r6vdgbicBawg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(508600001)(66946007)(66476007)(8936002)(6916009)(316002)(5660300002)(4326008)(6512007)(2906002)(38100700002)(44832011)(36756003)(83380400001)(86362001)(6486002)(6666004)(186003)(26005)(107886003)(2616005)(6506007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzYbx5HqS+ryy+nUDkxoDL8/MOQAoOnVeiE7LcZd6bpWJIluhghO6k0TZH1b?=
 =?us-ascii?Q?uEMa2G92dGUEYVWEI8n6cJd8B5DLrv1jc89mdzsJuinqjU621GeMWRFAF05e?=
 =?us-ascii?Q?UVk6phEx6oF2WuaZYnevfBu6zBOXd80k6wP+k6+7GXzALYRXmXkCuWHVfRur?=
 =?us-ascii?Q?IuYinF7CtUxyHxpVa5nB/sC6NszZVurMWBXKaMsTxrAjX+INGZq1jGROo1mV?=
 =?us-ascii?Q?1yyO2CKacSlUhpvnC4Z3qIpPpL4zU6RBioXorqzIPVghY5PGj/1N5t1mtnCi?=
 =?us-ascii?Q?CEuV+OlvTz8/i/RGxdYZ1cci4L2lzRU8Nqfp061hHLDhrjM8XrGHfNeLBDFF?=
 =?us-ascii?Q?q6EnC1VQLU1smG6AqcyHTExe2UZU8Y66cVi7J7e9SCXStbd63VuZA5Pm91UG?=
 =?us-ascii?Q?FsYQueAiksaj9v4IfERfMBU1yIFeNv3FBIrIPpuEcTshm1dTwBsPOzQETnnk?=
 =?us-ascii?Q?JGf3iD9cPiJ9QyZbFI0rvF3n9CymfcG7u102u1GIhXvwRF+w44YrEEi+Ql2q?=
 =?us-ascii?Q?N6pCO7VYZQxCLu+/j/2eNDS102YKy2vmFMNhWeI/KVu7FcU6WU2XInW24bog?=
 =?us-ascii?Q?/mF+RnzLp72SAryQnOr6LaIypFc3bh0/ZGUlNQ9g9Gu9QhNx2he3wQavt2R2?=
 =?us-ascii?Q?yT8hFXJCwxp0/7zQRH6JhnZvteyiZAFDiI8a1i/v4STt3u10VHu4JH5qzj9z?=
 =?us-ascii?Q?0dM7dTLaosxFUzgFx3b+++0j67yBL0FntihaUQSfWs7+rQw4zYWBpsgGMFVk?=
 =?us-ascii?Q?4YXAZN/fc2UHu5aQJ4iXTfxvRFj9R30X+8CPEZBT/ezw4C0iOgMKOluTXnP6?=
 =?us-ascii?Q?0MCLBab72MmjCmxaivJIJmXDjIKB7IY80tHO/E39WYQTuIP749kFWImfxLxd?=
 =?us-ascii?Q?5z2At07F3j8q6MQIpfgD0pmdowsSUucIdUMushb6ub+q1N1/xBm5R6Gn9E8f?=
 =?us-ascii?Q?EyWqm5MkOSBG5mLiuj9OBfaBaQwdNDnmJBmBPGK14F26dhXsDkt/u5CGzBXh?=
 =?us-ascii?Q?/eMNbHsqbl9LWhP7i+ME1MHvUDlcuK22CEYGtdWxqVUrB7DKhsS+HhCPRoSg?=
 =?us-ascii?Q?Xrw1eKwWgj/29kmw0j5wCrcRJusXzWkM1cKx7HglA0hmsoD514EtklFt+N1Z?=
 =?us-ascii?Q?EvLQV8rjuO3C9s76zoQiDwPvFH76DKcwMZgOiXUJqsdWnu/bl+FpXyQwAUWy?=
 =?us-ascii?Q?ZGmGx4gfRNVN3j/pq2F2QUKIjPEMaecVP5rXreL6IUwWC1/TkNC06ZTBVXr2?=
 =?us-ascii?Q?7OVAJJMPajGwoR9Kd9RjQiIh/77dyXmb5wk+GB4/LQTsah9yvNdvlBDowcs9?=
 =?us-ascii?Q?IYKFRkJIzo3rLU/DMPLb+7SLONLpadsANhu3SX2td1AAjRccanGIkD20rYAU?=
 =?us-ascii?Q?H3lAkOaM6U53x+fmtvKRAP1CdzWTh4uidyKmaMtX2fwp8uHthRATXTJAjq4p?=
 =?us-ascii?Q?zjEpGsz0s/kohyYDsashkPPDbrSGx/SlKZ++sDJQPQpT0ItnKg1o9Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fd6b24-185e-4992-cd66-08da04f550d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 13:28:09.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPFPRXT7e42PbPU6yky1Amcp/nDH2Ieh5EqZBW97uhI1CHt9nGPlS5yicOrGLXSQXPNyk+Y7tACndk2TWo2wfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442

Drop 'err' label and add 'ifndef TCP_CA_NAME_MAX'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v3:
 - add 'ifndef TCP_CA_NAME_MAX' in bpf_tcp_helpers.h too.

v2:
 - add 'ifndef TCP_CA_NAME_MAX'
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  | 2 ++
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 57de5ca5ed50..bebe382bcc7a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -16,7 +16,9 @@ BPF_PROG(name, args)
 #define SOL_TCP 6
 #endif
=20
+#ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
+#endif
=20
 #define tcp_jiffies32 ((__u32)bpf_jiffies64())
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index aff35ab33379..d2941fbc686c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,7 +4,10 @@
 #include "network_helpers.h"
=20
 #define TCP_CA_SYSCTL	"/proc/sys/net/ipv4/tcp_congestion_control"
+
+#ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
+#endif
=20
 char monitor_log_path[64];
=20
@@ -93,12 +96,9 @@ void get_msk_ca_name(char ca_name[])
 	}
=20
 	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
-	if (CHECK_FAIL(len < 0)) {
+	if (CHECK_FAIL(len < 0))
 		log_err("Failed to read %s", TCP_CA_SYSCTL);
-		goto err;
-	}
=20
-err:
 	close(fd);
 }
=20
--=20
2.34.1

