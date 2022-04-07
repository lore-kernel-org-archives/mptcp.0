Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0EE20EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNG8iEtpzdkuvq6LDqfwpmKo3DfQ3gomG42xVqw+Nco=;
	b=BrAv9k//yGeoGIbMAsgIIv7/3LwFC6BDdpkPKw9xEVoLM4obvRSQyacpyM1sTEaMJoMN8d
	yzB8eNSFb+t2hBfj+W6g2Kmoj0Md2+B7XaP+fwuR2o8cnIwJywp6eeRNiGSo48T6iwyxNJ
	ZRTnEYQkW/zvlFoALi9Sx7if/zducfU=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-qJOHdt6nM7G43X14u_9jKg-1; Thu, 07 Apr 2022 06:04:38 +0200
X-MC-Unique: qJOHdt6nM7G43X14u_9jKg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF41fzpf0PebX7bMWdBaWILNxxS0L7jlUL2eQWqG4wBqnJYi/kXWsqWfrMpv317vGuIWyimuy2eLrVGltBnpzMKr7KSrPBQy1GZ2r2YAPEUl4qfrvgSuqRQQoMW/0ufu4bQw50JbsYgJcqXbiWGUKRrUzAZIDFMue6LgqMuWBrCwq29KLQyWW+mWIbW2itdO5kgK8JP/EnHEidEj60RfdkiHiOQYctDUUkeCF+8Ty7nIYzx/bcawsbDQAsQ1NpdhYcpu0BOE5Ek+98pK/fSCw2nD2jQtRUsn11VdS+j8g/5NV1OJsHvO/IuhEnGAMkaANQpW5xBcoTI7OGrSqskPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZK0VfxUK4qsR2ROUjpij6j46M5w2ZGToJAXYcwSeKA=;
 b=Kil7SH2sofzEBiRLONX/MYibK0Y3z7WsrTTadfEE2HupQJI924q909vQ/CbOQj7zPVUzTZY9TmHEIlElfwr/9x4q0ARP2Idxs3lULR+ZBeqxGp7fj1MFRPFdqNDhm0Bq9owyGDqWnEPoZ+RjjFWAz1I71UbeZf/NG6S3U70JH4XvyZJKLJd1LodxcKzvGV083OLXrGbkgBa3vnE4SXmzx6JV9Psnf51LEKzEKyeW+VKoHliYldTY7w7m46Z2nk1XnHFQl5Q927/jQTjapS7G6LgtnrMBeYkaXv+Z9pzTTQwYd5u03yT8qadHd9tL67rraghjv2XS2mvn8xwJCNZNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3354.eurprd04.prod.outlook.com (2603:10a6:7:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 04:04:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:04:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 8/8] selftests: bpf: add bpf_first test
Date: Thu,  7 Apr 2022 12:03:20 +0800
Message-ID: <e639177ebf8e08c94df288a7b0f430718de81b5f.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649303876.git.geliang.tang@suse.com>
References: <cover.1649303876.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0196.jpnprd01.prod.outlook.com (2603:1096:403::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86000af5-6371-4cf5-a227-08da184bbb8e
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3354:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB33543AB26A522674F98DF970F8E69@HE1PR0402MB3354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XdVGLLRG5CEqjomYPkvlRHb2znUaL0dYy2TbG45lXSKe9C+6OnqYcckilLka54AqvtiT5OjVvvPxeWshh2aC5wwNxQgVwxORLT89POAvFzjSGNdqk00WYjIRYQVG65a0UmExNO84uIwqad4rAn+SKH5pWp6QDbSVrzJvI/FL9ywWkBdhFfPDpoaijjZ8L3EkA4/51vapF7q9AUHbd6aIZIBbzuCZI/b8dlBq6iBjvXYnVjJ4cKH6Xs7MYQgonXtsNOIvrHS0x6MWVzXP49yFXjgutxZL3hHV7/d7h9slQXiAnXFQ3vvxsfj/KasK1Oi3WI5relBb7LlG5eBfR7vNPudbv441TYc0LLm/hpTlGCE+ysNemPlY7dRAjhaPH/YVNfpi9WF3K3bbpwRvigl76jZ/MpmaymkFLZg2v2HDjozft54tpt/v31GY4yphw+6pULGnbuP5QcagPrj4YkrdOjuYZ4EMFHBMOD7PULMMH6bel8Uo9J/AKCCfgUiqOjuYFonae6aw/BVQNJUJSzL0bn6HFI/tscYH9XksC/KXR1kDZhxmtXmFKfjhDVQXNcDUJ+TnbwCQ2CT0Aqg6NCbABU8ow7yhO5pBjuRkAWt8LuSGzBmHgnDg0Hbds/SGF3lirZwfDsuVICwy2BiEUjZtg7MhQ1fFmCIg1TLoZU9y6tsgFcvlvM679lv9mNLIgjYq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(5660300002)(38100700002)(6486002)(36756003)(44832011)(508600001)(8936002)(83380400001)(8676002)(66476007)(6666004)(2616005)(6512007)(6916009)(107886003)(66946007)(186003)(66556008)(26005)(4326008)(6506007)(86362001)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?blo3LqqkFPndt0SA4rEGaVsIW2MZjh0YJLSjjcLGcCzzYKnB5Hi2mkCzugxQ?=
 =?us-ascii?Q?g+/enN9GvvGjMYq08IkSJnD295w5eS+sgM6ylbuFynfAbQnxGI7ANkAtgR+W?=
 =?us-ascii?Q?H62fd8GzsugxLz7UV54ja4+bLTqD6DrxvS5JfS2nJE/rZfLoew+8R0CvfOOO?=
 =?us-ascii?Q?SLX0D95uiLvmXWp8SG+zyYl0cvzEZ2zFaQor3ztHJphQjFjw1JfWmnKFYa6s?=
 =?us-ascii?Q?WxxU5TfeDL1zh4w3/iLD4S35bRfIOP/7ViCnk4+bBEdDnPfE1NOc0lFBdFh2?=
 =?us-ascii?Q?jCHp9W88AZKuGeP+fZ9TV+X6Ykr5p8CZeINoy8et6bvPgPUx6E1r23hrn50I?=
 =?us-ascii?Q?ioYiL8Q4m77Yv1ibfoLOxOWIQoDAIFkcHzxn7V+PngIAz7eWr95rMU56gZ/T?=
 =?us-ascii?Q?aRSP//kOGO3v6wPUjpm1jNjAXX6R8FX7sJHMvrI7RemzbwcdFCTsugR2nZo4?=
 =?us-ascii?Q?9aVQJe3jpasB5MZUNIlUf9LrYnzV5Wu58vhN22ovZtngLGLdPBHhpdSi7JbC?=
 =?us-ascii?Q?KoNeSuhTfuPByY5FK+Kc9XekSh3iwRvd0OziEsC2LCVPQMiSPtqy48OQ2OuV?=
 =?us-ascii?Q?Z5Thi9VLuucqwJfdgXzwT7d5yqpvANmlDeppH+tsRf7+bv+FB0SoIZoONSqg?=
 =?us-ascii?Q?QN5Akl84AF7nO9zfE8TOWPfl5O1Xi9PRVGRLMgYCOyVxDqFptz5Xy8pPLD+d?=
 =?us-ascii?Q?DeeRJ1YBoSRXprwvUQwIKiEBEFI4zN7jhYVByNjTCkN3vQRZX6OuWKhNQ/30?=
 =?us-ascii?Q?MEfLVh5TxvpmUYZwkSuPbZXFm8bE7rHkrpydCgYUJxPv8RFNcvBGv3cWeL3g?=
 =?us-ascii?Q?nr9Wy1vwfCnbWvIdu8kbVmGncHw2XWjEtOmPV9ccl6FzHz+WAwKpxlJMUNNn?=
 =?us-ascii?Q?ng5U5NqAdcZpkR6ta3AawCqiTNc1KF1SKkpbQsdzLRA/jnqCBM+j2bOBwXJw?=
 =?us-ascii?Q?e0siqGKWvtdT3gz1/TWMWau0t27gY5+B56nUfpgAc08bh2I4KqxQ/6mNwSlZ?=
 =?us-ascii?Q?KzZfVPM7lDEJ+PAVlkSDONvsjqA2EE/MKZRXu3KTcKnPWNNvGCgskHAT9mxM?=
 =?us-ascii?Q?a1Zbr5TDBumj5CAkv64RpNVFdE0ReCQsxexVV752WcSQsh+WDgywAVLl2axx?=
 =?us-ascii?Q?WavgnOFLARclC7ec5bhykpKgYMb+lMWXYgbrFJc7UC8tbgXGW1heQvN+vHdE?=
 =?us-ascii?Q?EuR6XhYdenT7s5fpyj8t9AXm11xgg9NEAXCmApAt9qP2vJKIsC8zqTp5aBo6?=
 =?us-ascii?Q?E/QQIBaMKGthAprKYiPxNgwXjxS9c8/8NZnUTNo/gyyLZN/ljFKV+cM/fzHQ?=
 =?us-ascii?Q?c5fhgg/krhrZibv8fr0gcpmVeYXR/iGeTRX5PfBAXmYmCrX0om3yShdYN1vw?=
 =?us-ascii?Q?YBW0GbWCS8NAV5wet2OGBP5TAVFdsHJ59dop2fJd3wbV/0iT+3YBLG+UVLqM?=
 =?us-ascii?Q?kb5AOCgxk9D4Tm+Rg3MimLiH9uzQEIGh1i5NgLSfqNKT1ODJeAnJbRx3o3Sr?=
 =?us-ascii?Q?nEqIbWkqv7FFDuVZ23cvdYXIFNivZXkZPGhg/gPtYu5KtqxZ6HeKWA8PLDpZ?=
 =?us-ascii?Q?4bkVG7DVSaZ5icTuIDjMnyr0FZ175NuWwLc0zQSoxxNwypQ1CdTT71BZ1Xm5?=
 =?us-ascii?Q?bEIU2cf7hiaBMMMQd9uthJFs5enW+/SUTVCWaNCit6D/9Q+DPc4v/oSEFP9d?=
 =?us-ascii?Q?jKtEVW6kG4RcP59BRCh9Dzdkr8iZ+B5blrXCCMOeKY+JMwe4zHmp2Uka33im?=
 =?us-ascii?Q?WvbhqqXP5oS3WLoAxSgRS9pApmacL5o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86000af5-6371-4cf5-a227-08da184bbb8e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:04:37.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwAQglWtPVLvMhRauKtBcDqJ9Nj8xNcItjXZg77sdZGyn1CM/dsflEbRWk/Mhz8RAVMCybYtzi4jBgz1KHLq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3354

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 7e704f5aab05..377ebc0fbcbe 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020, Tessares SA. */
=20
+#include <sys/param.h>
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +21,8 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -251,8 +255,117 @@ void test_base(void)
 	close(cgroup_fd);
 }
=20
+static void *server(void *arg)
+{
+	int lfd =3D (int)(long)arg, err =3D 0, fd;
+	ssize_t nr_sent =3D 0, bytes =3D 0;
+	char batch[1500];
+
+	fd =3D accept(lfd, NULL, NULL);
+	while (fd =3D=3D -1) {
+		if (errno =3D=3D EINTR)
+			continue;
+		err =3D -errno;
+		goto done;
+	}
+
+	if (settimeo(fd, 0)) {
+		err =3D -errno;
+		goto done;
+	}
+
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_sent =3D send(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
+			continue;
+		if (nr_sent =3D=3D -1) {
+			err =3D -errno;
+			break;
+		}
+		bytes +=3D nr_sent;
+	}
+
+	CHECK(bytes !=3D total_bytes, "send", "%zd !=3D %u nr_sent:%zd errno:%d\n=
",
+	      bytes, total_bytes, nr_sent, errno);
+
+done:
+	if (fd >=3D 0)
+		close(fd);
+	if (err) {
+		WRITE_ONCE(stop, 1);
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+static void send_data(int lfd, int fd)
+{
+	ssize_t nr_recv =3D 0, bytes =3D 0;
+	pthread_t srv_thread;
+	void *thread_ret;
+	char batch[1500];
+	int err;
+
+	WRITE_ONCE(stop, 0);
+
+	err =3D pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
+	if (CHECK(err !=3D 0, "pthread_create", "err:%d errno:%d\n", err, errno))
+		return;
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_recv =3D recv(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
+			continue;
+		if (nr_recv =3D=3D -1)
+			break;
+		bytes +=3D nr_recv;
+	}
+
+	CHECK(bytes !=3D total_bytes, "recv", "%zd !=3D %u nr_recv:%zd errno:%d\n=
",
+	      bytes, total_bytes, nr_recv, errno);
+
+	WRITE_ONCE(stop, 1);
+
+	pthread_join(srv_thread, &thread_ret);
+	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
+	      PTR_ERR(thread_ret));
+}
+
+static void test_first(void)
+{
+	struct mptcp_bpf_first *first_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	first_skel =3D mptcp_bpf_first__open_and_load();
+	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(first_skel->maps.first);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_first__destroy(first_skel);
+		return;
+	}
+
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_first");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	bpf_link__destroy(link);
+	mptcp_bpf_first__destroy(first_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("first"))
+		test_first();
 }
--=20
2.34.1

