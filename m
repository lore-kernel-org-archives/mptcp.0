Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF137C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mp3DvHKr1YnoFZXp43wUEVWm6yQsUizr0cfKmKs3fBo=;
	b=gmAW+lyN9OJqSM6avejyJK/n/I2otIAtRgMqk3lqpotDdcEbusxxuYqBhyl/VOGVqeeKmx
	9n+x2drZcW/j7wSNJme5XL/QrHZtM1ocyWz1QoNXK9F669KQFoHljFcElDZBLWnwTl3qBa
	1r+u0ny5knC5z3AafaxQfk+lD26IgJU=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-OfgX_SgCNkKFvUCop0v0FQ-1; Mon, 28 Mar 2022 11:38:59 +0200
X-MC-Unique: OfgX_SgCNkKFvUCop0v0FQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqZvAMKeShfQ7aTYyprSwC65UmrfNt8JKvXyN/H3gKBMuD837G1Y+HThmziscsvvnC4Z6QGEOPrk+ZOK8qyl5wRpW18qiggPdUMjL+PclusMy9HmASkomg7uvZdbNUJtIWvmpETbYtIuxYtvXqoWQE0vupyNPk06i9MKI8uzuLy3/zT2c99i17afD6Tn84UJt3HSSv6uSYUxEuOIanIK/J23OPqe4H0qT6OWC/+G9qCB0sGBrAujHdK/hps0lE3/AlpdKU5vyjUh4EqSxjsNhCf1vbP0sH5GpmvdT6WbWv4zEgfDJZE5o8ng2UzS0MxQvhLfl6+J6OxxEtsK8SsN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPyRmGgyd+/dawP1lqQdRu/CL4HcFe1NMm2lSTx/SVE=;
 b=Mx65cQS2mdSUc+8yVPd6U66fQYi6yg+36VDEN6h0NolnXjeBAka9E/9awfKNOC47TJj/gAH1YrpCibOBT3N1ldzZ2SF4PIc3YQ3SLZisD7Si1Kj7ZEIwMzRS2fbl+B9eRCfvHD7qVHHN2p7inUvBX5xcHf75Npxr/ykfAQF8Lx6b+pD8MOi/041Yd0Hul1yxL3D2wdsfjFGogZ3wOcpdbQgITtJToHs87zoCMDJmnUtsxmXajOVkZ0VQx3xiaOpSBmhtxYRI4iYdWiXNxR+bdjxNUiQEXDX5Nj/ofZ52saV+jKiU8VJ+NcwuSaYofKAMnLCiTDi0AqVTt691PNGqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 8/8] selftests: bpf: add mptcp_bpf_first test
Date: Mon, 28 Mar 2022 17:38:02 +0800
Message-ID: <50798e945994585b9c9c5443ce991ceb3dbc662f.1648459866.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648459865.git.geliang.tang@suse.com>
References: <cover.1648459865.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9cb97de-4b15-4ca0-7887-08da109ec878
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB50674D5BBB96AC76B27178E0F81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fbQTlRzMFMFs16tMPkwoJo5qK3ylb3IZcJ/ukSOhhLIfSA9sTwAlW3w90BZ2nbKzJnRuv5PRlTGrzc6EBX1acaM5nVaywugVbgltqW5VWoI02kRWyZ+vQR6TyAvMGlt0chO+oXDJC1p2zM88fbBBjSRoixwjr7rbyVddnvdzZJUZpWeJ5qiSjeYo+dzB+0MQs6eAsDbpY0IBtC++sWsCBIxcnykJmN2rNeJ7jBkOH8dE8OqQymoR1q0bg8sUwLiX25roQyaL00W1Uaux7PXrtrTM2eS3DrfrOH//7Y8EaovW0GiM3KhbH7jqZOaHpoqs8LnqJNgj07PHrib+5Ip9NnCO/mnJk+fkeCX5kIQiBbAUeRN+jBGmUeG/Bhce2Hs8/izfPuTXkR/+25VYv5lnXJi2nRj9VePXce/0e+EmOp63owHbVdOd3G+2ulPTXOqgKQkyWt7fNl76nBwxUsslZ2MQzFsgaEyJZNaz1y4nRdojTdKxDLJHcSubBPf+TIyY9eR04GErgHSQLAs0IjVNOofIcZplNHwpFD2qQ38xCcjg1kpi8CqM+Bm/iUumdNNceG2zeB6XUyyMtHJ/0wn5myjvCqxf7KgYkPHAdCZtcMuQfvMvIQZXhs5+7K/21w9jivf/GHMolVtoBnj5VHNvvhqKMEjFCbRw0Yb2rey6G7/B61D9H2XjqMhvPhKbiTzb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(83380400001)(8676002)(4326008)(6506007)(6512007)(508600001)(107886003)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PqrpLYbgVLLEmofuopaF+ut1uyoNvUchGYS5iIGMk+qgDUsyuY9Xq2MNGeUA?=
 =?us-ascii?Q?JNf26pjvlL+aT7LPbP2jimwgtG2iXNCoGkcmV5T4DmqTD4BuGR8WKjvSzPKH?=
 =?us-ascii?Q?y3MneCd0WB4MewH8vzdGXdq/kn6q+sj8u52I7jwB4F6/M7ehL/NG1ST52dhJ?=
 =?us-ascii?Q?sErDh2kp4vEBKiGey2ZpNeFtQUK7ySrAaZ12ox9n678yanc3WvPd/G87CjkT?=
 =?us-ascii?Q?TtsMMAYlI9MKLkX+cJCUjKhIx2LcxPkKUYSwYftu+JZFxyhBBX5v7MEE+1wJ?=
 =?us-ascii?Q?uYxuADY7k17jUesCwQpH1JNwAumzLEZY/Q5jjNEFHWHJybaku6LYU0FI02p/?=
 =?us-ascii?Q?97ogwnzOKJikqVgVOyOGlt0bHskY1FE8FDLZMk08i0pj0o8Z9c+Q7KyI4Mhb?=
 =?us-ascii?Q?3RkauywmOTwG0SI9pSn+NCYoEjT+JZ3DPzzDcdL5vnUt82/EUrqzOAsVQf9d?=
 =?us-ascii?Q?j6NzUuWb27S5Oya0diYyprrAf6ev2jY0MaKvsIh95TkM6kClTphAxvnO8+Pa?=
 =?us-ascii?Q?Cqi+7nnrd9KwD1NOtrd0+fdsG4S+HgZspYxPh4m4OiaweGMka/CHbNmV9iEh?=
 =?us-ascii?Q?GuDVKEmnB08YfXw0uiejZk2u+7rZOC6AtJTMiaoS4NfC4HVmJaiiXN6ZYReU?=
 =?us-ascii?Q?GiZiB72U6isTXrivGutbj1zL29U+oLeqqbgZfmRqobrmgOzGEWONpFQBapHf?=
 =?us-ascii?Q?tcEq/PO0eCsbO67dZr15dGsxCdPTJNlPuQmuBWe+2lrloIYXSoY6cdG7e0CK?=
 =?us-ascii?Q?RvV8a3lVMoJCdbeN3CyIpEGiob1i9YRenh++gjlJXCXuXbWfvPF2pfFWEm9n?=
 =?us-ascii?Q?kpHrj+zwpKaNBnrppzNzfXE23KRF0qtQcOaeZdY0yunBdm0aV6dy7ZyCgNcw?=
 =?us-ascii?Q?eQPIXZXNyifUiatz/uEdkIezEohol3m8rEaZKMu3Ffx9248czYEkavtZS8Cx?=
 =?us-ascii?Q?zUaXevE2yIiPOderOwuIp3MUXKp28Tzpb0xkzICQQKobXpVg/S71sABgDuH/?=
 =?us-ascii?Q?WL84/tnqOzxL+9XXPFOX3hszvr1Qr8kRC5wyC93HfW/wj+Lr0L8tCzZuzSyg?=
 =?us-ascii?Q?qUOzZjAvT5n4PSLA/ZXIxnaOvhm5r+Qg4b21n+GNUsQ4s2peOlpVZY00kWob?=
 =?us-ascii?Q?1eAMI2udnyHscStbtK8IqMRddhTIeVd+ZDhdJGIsYqgQUHdz+PzvYxdAbqUi?=
 =?us-ascii?Q?1KQ8Kx2q56kf/1BAo9VgDoyUXaQPRYYlDzeg3QS/qivSnmnClUJ1V8vAn2Gn?=
 =?us-ascii?Q?NYEZTRuiMO0DJjf9Xw+UvIJWqr8bpXR9RlJFi/MripZoPVA0pZavHW8RWqyw?=
 =?us-ascii?Q?qHYJzgCIK+2BAATaoVYBQQ/XaGClmDCxJB84Q06hn7sJuB5vvA2Imh/eWxwm?=
 =?us-ascii?Q?IENllGuoH5u7ypIfE6+LiCQ9JRg7xjvuqWdkhS2RTCbRh786f5Jbox2L85Rh?=
 =?us-ascii?Q?lCKpRzpnO2DmYxRremXZ3thuUXNcH8rd59zGx9ceVJCdhgRC109yJkWt56pf?=
 =?us-ascii?Q?7cKLdev8XqtvTszlA4XpFD/E5lln47VE81CaaxpQQpviyXx4ZtyK74vkD2vS?=
 =?us-ascii?Q?WWK4xjal46z6E/GRs37NPh7ntTt0BzhV+6KVHPwkxTZx9GwdUbeK7EJG0eci?=
 =?us-ascii?Q?OOzQJWeL7P/0sSbQ7j5Jke/n46yFqxF3MwN5OAKMxotRbsKngwoJAh8gYCqW?=
 =?us-ascii?Q?3Wjux3ehrB6rvJlXgCM1zBuPBi0MT6lCmRIObLfw/pp7kt6WvHZ5XHi19CZo?=
 =?us-ascii?Q?db4V2/UUeLNXh8dN14UecMYC9YHn8vg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cb97de-4b15-4ca0-7887-08da109ec878
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:58.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7r+FYxvk9pYlSY8NAgJWgcdKMEbHylYMAzGMEKmQnMtb7miIjLAkP4KBAH6YpFnDSUCx7zz1TyJaxlNraMlOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the mptcp_bpf_first scheduler test in it.
Use sysctl to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 9b73ef62ee74..e5b6f2f4a52d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,6 +4,9 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "bpf_first.skel.h"
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +22,8 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -251,8 +256,117 @@ void test_base(void)
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
+			       min(total_bytes - bytes, sizeof(batch)), 0);
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
+			       min(total_bytes - bytes, sizeof(batch)), 0);
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
+	struct bpf_first *first_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	first_skel =3D bpf_first__open_and_load();
+	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(first_skel->maps.first);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_first__destroy(first_skel);
+		return;
+	}
+
+	system("sysctl -q net.mptcp.scheduler=3Dmptcp_bpf_first");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	bpf_link__destroy(link);
+	bpf_first__destroy(first_skel);
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

