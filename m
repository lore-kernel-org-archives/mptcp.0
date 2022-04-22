Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708E23CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNG8iEtpzdkuvq6LDqfwpmKo3DfQ3gomG42xVqw+Nco=;
	b=WnLcf+cXJjLfbnTg7ID6kFhxEjSwe0PT41DKEbGREJSaQ9Yvv3vdLZSEBHh98kVL7lq40b
	d1gZg/9NKF2Ccrd8CagcOcUaw2SvaNV253ijLfQ31Uoj+ntCUNwux1cpoU5e8IYWY694kY
	YaFuvr63crBtBDJXa9lL7ndO+k8PxBU=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-F4Bj9IETNqCAVuTLqXFZKg-1; Fri, 22 Apr 2022 09:43:54 +0200
X-MC-Unique: F4Bj9IETNqCAVuTLqXFZKg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW8xhxLMGBDxhgYanFt0H0WCYvopKpnrQ/NJ7yqT4WnFAhWn5AVZ5BjtDcRJDIpMqrEXHvVP1XFEEsvIm/qGI0hGnWwD1s/iNATurYauSDmbGyGd37S7K0hRam/KAaWAOluPfFNun0bJbqYTU6cAinZMdtCIbndGevv7mxwzih47e/azbIXiYvxf77OpZFdPVT1VE1bs8NcFKg2II4/HgkmZal7s18Xc++cD9qrggs995nXzFShOoU0A2Ugtc3bbRfxo8T3RAWfBhRyXKq6bmK1FhxpMMwMrr4M6JQCeM/JG9zVk5WopQN+kAgfldpkk0IWrBSEHM42Ep6k07JgZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZK0VfxUK4qsR2ROUjpij6j46M5w2ZGToJAXYcwSeKA=;
 b=hlmM9P5CsZBxv4gWch1fK8NEE0obR2oKpoL/ZAS024EkNfiBerPvDqkoKuMNhGqdFMFtA54MQRX02hTuJzV59aGdxPPQ9qf07mD6oGugTfEjMH0TQwttp9rOCv+sQVzszY16nKUvDA9MgJueFAI5PQomlBXrSppjG+snxNn6Rti8ztjNKPqEJd2Ax9Fu+ngJC2bF68JXnEkYHzd2AnOuLW+DCn55O6KaBgQtiD0sBOodxYIVgEjvwkP+2unQwqtqj2Ru0XARpzIjtdmnuHIAjla2tMFP1zCTbwMj4f/VpHa5rZSwrHd4DY8GGy+8Ub8Iudc9yhhIGnVuYdTkpHc68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:43:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:43:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 8/8] selftests: bpf: add bpf_first test
Date: Fri, 22 Apr 2022 15:42:56 +0800
Message-ID: <2032cab8c752d0258ee16a6b9b2825ef21b51d0e.1650613135.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613134.git.geliang.tang@suse.com>
References: <cover.1650613134.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:403:a::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df2c2b9c-fc0e-4aef-397d-08da2433d8e8
X-MS-TrafficTypeDiagnostic: AM0PR04MB5876:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB58763EDD8B999CE82296575EF8F79@AM0PR04MB5876.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6GbuDtNIkm+yWxtFn5tONUNozSoHp1VFnXPSimfKhD/ZpoRJGnsZfUiQ2l5zAUlYEijiG64ImsbdQ/wyF6eH+nGg/iZB9JpPbz1lK8eR6LFaop6K9yk284niE4oxp798rlEvaarmLrJYW2hFfxVEzAz1p9cvgshCUP8/9gEbfuhsnpTMsk3SAIewhHwaAfZzcpNoS7XP5xAlkoVM5TRg7/+PYzL1S3oCu0T2hVYzZdUBPYkGIgjPF0QpewDA3GmCCwm3+HLqACo4YskpFEapPoAiK2mklFKkvuBIc/0adDo/agwVaSTu6BGGI2oZ54TmP4m7RxtpqW76biMP12ICzzrGp4N30Ut8dSOuCCL88Yp5373Fn9eIiEl/OySy4okET3FEZlygQ/q9BrphTTeFupe2cbQad+wFg1ZPOjyxHS6MQ5pRB7dURcDqUD+KAt3I7HxlhCvJtMVA1hXRXIs95p+XZ4l/BOEOxzJcx7eBmWNtKghKG44E1o+3rygjXtkFdIZHoEgP6FxQCS9+8LpkvYnloo8zsSnecoW9snMQ2KMOQhXrLIZ4dPYa5JjYMibuiEGBeyE7KqN02drLP68QgTMpZ8peBjq0NLsDL2zGbkHiGobajWs7pWW8mIdR3HxvVIVpgul9orfiZyY7h1ohgLf9K+3qeixVKJiTsxJ5aXM88Rs4Zaoe4ez/7DGhj9Us
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(86362001)(5660300002)(6916009)(8936002)(6486002)(44832011)(4326008)(38100700002)(186003)(2616005)(2906002)(107886003)(6506007)(6512007)(66476007)(66946007)(66556008)(8676002)(26005)(36756003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V6icdSdVrdqmkq2Kz1aufoSwDxtQv0SmAZ2ALLlt5AynMb2BIgrm3nnzLaer?=
 =?us-ascii?Q?tG3xdyQslHzGTkyDb+iEtkK6IgRB7dnLZsiw/bdiROopWwf8PPA9wqdu+hjV?=
 =?us-ascii?Q?mAeVlQdpd8cuUWmexOI6HRWZgV/VpfHCrBRKdRtgas10ZLEQ7FFG6ynada8M?=
 =?us-ascii?Q?zwGkbMHiGu6c/dQdxhkFMzvCyJLoqtFvXUPJxulyumkE59VerqDiooF/Ym2/?=
 =?us-ascii?Q?S6MmKnhZ03xOqYKJJBexExeCCbi1qQrdfduXoofEtU9RNwjDGh9QTx7UlCPt?=
 =?us-ascii?Q?UKGDnR9SH8vLxuOb4rOx9nqyRk8IxYvS9+JIgiZpu41CB5BTXQR0PWroDLhV?=
 =?us-ascii?Q?Vb+REbsEHW3z0hHd388mHSkaM3vteYmsCb3MIIcURi+oIVFGcVcKF0uHx2o8?=
 =?us-ascii?Q?98DurlGJ4cEhIHo7w1LPNeC2q06xQPBpTwvJxtg9qIjeYfznnmIoZt9zfN3Y?=
 =?us-ascii?Q?M4NxqH6fzibFzebUkT7O+vd/vrkfbdfnKlFsk1CIklpm0vN4W9RXSDsKNCcn?=
 =?us-ascii?Q?DlFW8lkIbTHc2B+V9+mbJ3DI+73PDpyYDQU5GfdRYi8BmRTvZnHJq3dLP2to?=
 =?us-ascii?Q?u/H0ktQpfsBnKGBfvPUV39D1jbT9o8X9zancNT8A+ySHXtVSSblf+rKwAvqj?=
 =?us-ascii?Q?gHSlSTfG5wYLoX8jdIIJ/OBGFDYdyfkVS/iB0qgw06n459DjrFfRuNnFbSZo?=
 =?us-ascii?Q?+nmjyemekYXn2ZGKdCPkgeiXixK6ZF1UkBB0SlGyDpLu/eqt3dbXlORnHRL5?=
 =?us-ascii?Q?Cg4bOXiDuooSaAG/veer6oS4t35EsjUrr93zNpklx1zWhaOonqrIAD39C2LC?=
 =?us-ascii?Q?0rjMG3kH0htj0c4bBR2SLassIJ/KTdoR+XZgSLHmJySwYm9uR2UTXeEgJ6FH?=
 =?us-ascii?Q?h1r6C9cjsP+BeM9Sd989vxcDp/Viz6TD0L+M64iEigJ4ygpzrouwkiOFgXU6?=
 =?us-ascii?Q?Xw8UtcXAnxcNEP3VYW5s8eg3aZTZ+nI8sV+5IXGeRw/VJZuJk0c216bmgT22?=
 =?us-ascii?Q?0z8mFDaWcjIgZgf7Ay9LMBMBBP61a47m70dM7/yXfn8qYdUtz+ewl0Wb15Di?=
 =?us-ascii?Q?QrxvFkim7sUeDO74/g4fPm9DhOAIxyONZHgX9hqYHumKJsdEvC2uT0oDRIwp?=
 =?us-ascii?Q?i6Z9qdsHTbHqyArNC+vaaMmA9hTsHLnlrJp1owc+Kt/TSgLTAx5B62ciCcFJ?=
 =?us-ascii?Q?63mKKJajRQg0iHvFUw4xlo71fSsBisXY+T5GvMLqsFkMo9g7OHZ1R2AMLmqp?=
 =?us-ascii?Q?QGUMjbTm3QUtw9C/AJnfYFUCHjDLPFh90Wn3nJhJi1PENY7Gp0UScg8RCPhJ?=
 =?us-ascii?Q?J4wvGx7UGVi7Aan/kR6kWh05425V3sq2sfaxk5d/VNls8xQRjMob3ZNQMKc3?=
 =?us-ascii?Q?L+bVc1+BBtZp1VvSVXFfelG3dYw6ABFh7dTY/3MMpcris0vI6RK+ZgrrdJUJ?=
 =?us-ascii?Q?CWaFKBs+z8dLRzSKSGuIzG5sjDn65SdqNsg4pshtLKrrCOej+0dA+qEW8Wj6?=
 =?us-ascii?Q?w3Jx1ZPtL9oqwnRWbMU5YaN4belVQjvqzpT8tKDcnLgv5h25N1Su8fMOuyc1?=
 =?us-ascii?Q?RnorDNK7aJAq/wXc/Z4OksWKj5pitpSbY3X0jHdkTaqLiB6mOxqhGr7yD7F/?=
 =?us-ascii?Q?65xqXTYuEt5IkKX8RSsxj8we5EwkLkSqMqZL8eiEBx5PlFT/9XhVUJFT3hle?=
 =?us-ascii?Q?gpYm73sWC4b/hvU7VrfmQoqnda3njuKP5Fwr3ontlRLZedMSYe9n4Hmqu2/5?=
 =?us-ascii?Q?zmIFHddaeYyVQlhuFiDJ+4SfU/ozJQ4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2c2b9c-fc0e-4aef-397d-08da2433d8e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:43:52.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++Jc4hhVQAHNdmatNoDpc9+YQrWwt4N21bwKaE5Ciu1RwUQ93D7PWOI1BKWc8Z5pbVT/nO8NTlG7pj820LTa2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5876

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

