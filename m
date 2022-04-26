Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25001625
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650967763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ejzzCUPzFcObATunq8ru+HfJ5SCFqfjlW5FKmsh7M0E=;
	b=RETGlE+jQROv7UGImIadMkkwWEsjI+wKfbt+o8+xnrzbj3KDBr21qGT4flSsK7pge9Z/5V
	U5fPm8bC7KbRfO9/z/M7If0NLv1YR5vfBVyQO0+L/bqQZLUKCOvCI+LTCPfUjar21Q4cF5
	BGXHvNFNs/RpAMtkvFuR9A7G8OJkSdY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-eK1ORRY1O82oBNJeVnOeWg-1; Tue, 26 Apr 2022 12:09:22 +0200
X-MC-Unique: eK1ORRY1O82oBNJeVnOeWg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsQMWbiSLzkt1S5CA60kzxfb7DeLn5J36sEFm7EEoSEVkJ0T2DyMPds/IZERm+D7KWI40pgMToQF+HfBdhHYgsGPwwjMAa2CVKP5ZkfFMA9jPChPidQeNiQx6JVjZxdeAQXPMRfFAOGeDyrHSvBMKwhvY/evlX8Ah5lF8oTwSnEx6gEafsrxAoh/3cqdGXF2mPrymaiRBSQFYMNt//kAIZz+V29m9hJ2tfa8U7pTj6hDqgjFxhDhBWaRlV6gJbh0np26VpWeTUcxvTymeC52SexO6+4fEEdSBCh38roGN3dg0I7uyRmL9QjPGQgCug7rikrby5VMIXJfsOwR3U/HJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi4umYo/LijshubXEGrk9tavMzMXqBdAiNG/pf+NIrQ=;
 b=eB3OHskuIR5I+F2WFDpMmZw1eAs/396MXSer2u+2yyKZyHA6z2NxRp8GKGu07J+WzkKrXa+WdTZXCKvASztxH9USSIPgb1lx3fXm+a4T/LP2nBea4N1HA51PIr7AGD0VCsV1+xV6qNWDhJjKIJB0PNtrni3CHEsbrJzOZiLobN3uqlx4MCjelXFqLr3C7l70mGvPD6Xjme2RwLFIoH+y27lcay2psTGyxWm77Cc7niY1pjaCdMqkdO+K/q/HC9YoHRDwTZuJ2y7W1NQxFj+CORR8X6x/237dL8BNbof1XIJbtiubH0afAwhHqUWu8pFLWBQUgarzhYlKPZh4QXXsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4513.eurprd04.prod.outlook.com (2603:10a6:208:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 10:09:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 10:09:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Song Liu <songliubraving@fb.com>
Subject: [PATCH mptcp-next] selftests/bpf: Drop duplicate max/min definitions
Date: Tue, 26 Apr 2022 18:09:33 +0800
Message-ID: <93623928052528277b9a67f19a1a102518c538bb.1650967584.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1486099b-90b8-495a-9b24-08da276cd48d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4513:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB451387037CD1BC9EA9462C26F8FB9@AM0PR04MB4513.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y3MYN+pexZRRgV64jUkdFgJLNt6a57ji/2gxhghs3Nh7Pc1EqWJ2bZSZJc2g2Dy0FEbBPNO0xqU2rmdiYvMaamRq87BlcN/K6/xNMBE1gOlGf5GgFJ5B7GNN0JKSLbtc9d1/2MJWIuX5yPHQ+dw45gfC4zR325ZSYJ/H8S7fHD6uMnqEWxDRF9S0uu8LvFOc/XgnsamlDaMYRfaFvtx0ZZHOCtOTuA9944Tzf7rYw16TygYUef7cMMZiIUbvJtXKvNzXT5LsHLBbYnD3Pej2iq6SwNMvl6hEaZE/8MxBKnSPb1WvphF6BSwy/jafShMUkPd+zens+i2oKIDl8gjl1z3ZHdsGhE9qbb0AMS3lfpYN+rxUBTK7Bo8UfbXvcyv2tHp9lH3K/7N+COqzyR2VXTbmJWVzcdYizQ5NVW0BDskLIi7tR0WW+Sr0xzP6wvhqUNXbKnJ4sdt/Oe/zVHZ3u3pQuLG9fg6hfiuVLuOzurE+/iBNfO58B97faJAnM/cXuAMlP0txZltEltEgu/oCnN/M9RchGC51u/Q5onElKi+7A8C7MEHMeeUP292lg86ya4RXUi91HSGm/yliX6zsEIa/0LiNCuEdeexQZmI6Dm/bhosmFF2q26oey2nrvT7dqTXCnbQCbdpjr3DsponAiysnviQUkiceMxADyyWuVU+3NrSOeyh4KjLUNEnsNNkPH3KUSKttWucTi4k0V7YtD5v9qWXMpSJi6a8kEVX2Ur/RfFYS+hhVt+dc83te9hbHAHX1SYogMpLMDplaJ9Fg7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(966005)(2616005)(316002)(6506007)(8676002)(26005)(508600001)(2906002)(44832011)(6916009)(54906003)(6512007)(4326008)(5660300002)(66946007)(86362001)(66476007)(66556008)(38100700002)(8936002)(6666004)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2ADszrUScKj6dYZ+MQdjXtXAeCYJ7PcAF68hYKACnnILBgC3aZsGhX3vO7N?=
 =?us-ascii?Q?+GGZa3wq0K2UBh1mrGEChDCEYo3zuI9pT6BwmXxqw30o0j4ZtgyXKWswz3NF?=
 =?us-ascii?Q?SBZEXmdgzkrB1jlCu4d8MGcpnWm0rIfdzT/Bbmhcx6I/9SfvrxwYf2v05E9I?=
 =?us-ascii?Q?/n19feOuBKT1vJo8CTA15/zL0RBujmoxAV79jscJE+4zT6cVeEgRl3w1hCyF?=
 =?us-ascii?Q?xwe/msXzr18E2LLlxddGbz7Hr1lFUrEzWn5L2IXDxjp2n4oElopKV3WWfgXW?=
 =?us-ascii?Q?KAka0PGiWpDRMQ6tYqQILLVrFs6b70mdbOp5yxTlhpgEwzsBaA3/94PzTAN1?=
 =?us-ascii?Q?pEfbEbiV8nCZofhy+gQ4dSEsz+7yFsV+rSGHZtIQJIdcTj0gTrUp0fzalcKe?=
 =?us-ascii?Q?Mcnpy32N9bZCskFHhP/0kPYS2DMias3+rHktENGcZ/jipOFw954SIeGhjIrv?=
 =?us-ascii?Q?hWZJ99PGM7iBATyROO6h555mI+R7h7BbrLdBouBbwdEGL0Ii2B3f65LBtJ9J?=
 =?us-ascii?Q?TRd+TdDTGpCGjRXnzx9vQ0BuvL+KFPxOVLZPlV6vwLQtZ9Zik+3NaRjCK8ce?=
 =?us-ascii?Q?WvK17jOapi3NPNqwBs/jkQHqv/vL5pfpCXOltW0+OIbNYuQDMKNFXjAiAU10?=
 =?us-ascii?Q?pscQNHH3Ia56SPBCk8mtbMNZXS77ITnvBncE0kwsIUWoem0arYbZLimV8vsM?=
 =?us-ascii?Q?+/qEnF8q0yY5RBFzUk2tazhmBbGeay+fpvpX07LdID+3/+8838XOzi1nrVpy?=
 =?us-ascii?Q?GUxGwhreCROLcgKXa56/lskRMg3u8v+WkUPCfeaOewBqERK7UWGFzlnJq58b?=
 =?us-ascii?Q?L6+AQd9s69JEFLx5sb3ZWn2TJVFNw89EzkOI7v/Bw+uMiEN0jyvBQwhvtOyT?=
 =?us-ascii?Q?Mn4k7667eDuYa2fog6HsBS1HksmN1Z7Bkahq0M6GwDUcZEqGPBBEeuBckYWX?=
 =?us-ascii?Q?Z7i6ufdczB8p7S5oN5Afy164Nw/G2NeGT+Wd5MzPlIfFvuFBJWTm6eWpFp7y?=
 =?us-ascii?Q?IWaVA9diqQKa69/CHGUGPGhFyH8u3QgcbyGMI1PZ9KXAvOG9bcB0ZF0kJFDp?=
 =?us-ascii?Q?kLJHMDJSW2k8q0eFNAmab7JFeRfSZxXEqPF+INTaTjEQtaqtQ3AuSdUsC4V6?=
 =?us-ascii?Q?pmDKn/8Ua/q6/B0ZTY4/4Mm/Ff+yTrb4aHRhTzBsyVITnJdl3AV5OgTXJp/6?=
 =?us-ascii?Q?jzOWd1QWAsqSDJwJgdlOAZii9otzsfXyED9DYy5Hw/cd1GSkfS8yd1W1kLuo?=
 =?us-ascii?Q?1NpfNZVrgXWKfTCJxJzRlRBsggktcdbbkXjhLhSyqXKV4/5/CZ3Lx3JbClqf?=
 =?us-ascii?Q?huAoCJLtumF209/P2eS91Y6e7OcPjVPtMA8xYb/1cRqK6WZPhX5ynmVZRyDS?=
 =?us-ascii?Q?f1K3IB2QXH17y/0CY7HSwpiM3H/H5lU+gQs5elGHHi5cSE7UHoXxtlBDUv1C?=
 =?us-ascii?Q?WCE6lOpxxxFgvRzY8nml1LHkVOCgvgQnvAXimTdZBOEak/sfqZTQmRzDxlQp?=
 =?us-ascii?Q?+OOiG+mQAhHwIQmclEky6NbRlggnS9SLa8AroFLye8gI10ld+JoEi338yqUn?=
 =?us-ascii?Q?HAb8rZsxd/ZDOy5gh0t4gZe2+myND7SrbXRLlMp4yKyNgSsDCNu1eFvP4jAb?=
 =?us-ascii?Q?sfZSf5GSftKTjtQSQLqqonHnxus3iqr/HwOq+HiNG9ZjrxFMokZZThv/MF9M?=
 =?us-ascii?Q?Gx361pzrA/5TcuUI4Useb0z7m4Vz2+rPnDXjnllU7kVWLwccuTVIKRute6Vw?=
 =?us-ascii?Q?7KHeAUtFVuAtMQeyK+JCP3ckETsyAko=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1486099b-90b8-495a-9b24-08da276cd48d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 10:09:20.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aehgYyz6o8wNyQgymGHh42f6FP185XUiICnpTNj/Zy2TsbHH8qx2Ghx5QKBS/FjplT/4DGmnxh5l0C2J+Y4Lkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4513

Drop duplicate macros min() and MAX() definitions in prog_tests and use
MIN() or MAX() in sys/param.h instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/1ae276da9925c2de59b5bdc93b693b4c243e692e.=
1649462033.git.geliang.tang@suse.com
---
This patch was applied on bpf-next. It needs to merge to mptcp_net-next
too. Since the commit "selftests: bpf: add bpf_first test" will depend
on this patch.
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c    | 4 +---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  | 6 ++----
 tools/testing/selftests/bpf/prog_tests/snprintf.c    | 4 +---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 1 -
 tools/testing/selftests/bpf/test_progs.h             | 1 +
 5 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/test=
ing/selftests/bpf/prog_tests/bpf_iter.c
index 5142a7d130b2..2c403ddc8076 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1192,8 +1192,6 @@ static void str_strip_first_line(char *str)
 	*dst =3D '\0';
 }
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 static void test_task_vma(void)
 {
 	int err, iter_fd =3D -1, proc_maps_fd =3D -1;
@@ -1229,7 +1227,7 @@ static void test_task_vma(void)
 	len =3D 0;
 	while (len < CMP_BUFFER_SIZE) {
 		err =3D read_fd_into_buffer(iter_fd, task_vma_output + len,
-					  min(read_size, CMP_BUFFER_SIZE - len));
+					  MIN(read_size, CMP_BUFFER_SIZE - len));
 		if (!err)
 			break;
 		if (CHECK(err < 0, "read_iter_fd", "read_iter_fd failed\n"))
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 8f7a1cef7d87..e9a9a31b2ffe 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -10,8 +10,6 @@
 #include "bpf_tcp_nogpl.skel.h"
 #include "bpf_dctcp_release.skel.h"
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
 #endif
@@ -53,7 +51,7 @@ static void *server(void *arg)
=20
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_sent =3D send(fd, &batch,
-			       min(total_bytes - bytes, sizeof(batch)), 0);
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
 			continue;
 		if (nr_sent =3D=3D -1) {
@@ -146,7 +144,7 @@ static void do_test(const char *tcp_ca, const struct bp=
f_map *sk_stg_map)
 	/* recv total_bytes */
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_recv =3D recv(fd, &batch,
-			       min(total_bytes - bytes, sizeof(batch)), 0);
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
 			continue;
 		if (nr_recv =3D=3D -1)
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/test=
ing/selftests/bpf/prog_tests/snprintf.c
index 394ebfc3bbf3..4be6fdb78c6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -83,8 +83,6 @@ static void test_snprintf_positive(void)
 	test_snprintf__destroy(skel);
 }
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 /* Loads an eBPF object calling bpf_snprintf with up to 10 characters of f=
mt */
 static int load_single_snprintf(char *fmt)
 {
@@ -95,7 +93,7 @@ static int load_single_snprintf(char *fmt)
 	if (!skel)
 		return -EINVAL;
=20
-	memcpy(skel->rodata->fmt, fmt, min(strlen(fmt) + 1, 10));
+	memcpy(skel->rodata->fmt, fmt, MIN(strlen(fmt) + 1, 10));
=20
 	ret =3D test_snprintf_single__load(skel);
 	test_snprintf_single__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/t=
esting/selftests/bpf/prog_tests/tc_redirect.c
index 7ad66a247c02..958dae769c52 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -949,7 +949,6 @@ static int tun_open(char *name)
 	return -1;
 }
=20
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
 enum {
 	SRC_TO_TARGET =3D 0,
 	TARGET_TO_SRC =3D 1,
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selft=
ests/bpf/test_progs.h
index eec4c7385b14..e6ae2e52a668 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -25,6 +25,7 @@ typedef __u16 __sum16;
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/param.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <linux/bpf.h>
--=20
2.34.1

