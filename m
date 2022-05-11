Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46315B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7zQKCn14xxiVLEwTVTt+pl3CZZbVbDOCIkUlcCRSMM=;
	b=EA+IeNcwLH3Ov0SQ9c3mfJNhAUdVp+fKSaNpbi5QA2tPFtfaNtwEQGeQRQ4ePrzSN6aRNz
	xPK8hxPc6d3sy5fUUyNX7P5XBt0oIe0xpTxGkj6+JNKyE6M0HgrBGWEqJfis6Q8XsZ76ZY
	LVhPU5k/V2Knh4pqj3Xp7tRzHqz7FmI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-6y1UVRiqOm-mHQxCMdIW5A-1; Wed, 11 May 2022 09:57:59 +0200
X-MC-Unique: 6y1UVRiqOm-mHQxCMdIW5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjH1iqXvadDAH4CUeYU+xOLr+okkZOzppBzk84LlGlEiyuON8DAHPxkZvG7mDrd12y0fv5R7JN2PptC7wmfReau79hM0OmqNFttz22zRGAhsgfchaU23yRHTYDGYpOaSG08sDX5sn2ZFYDbmq2ZJp84b6k2CLavhNcuuhXo4/xqiNqsuIAablAAtcgGYyTCEAMVmO61ySZUTTv46wBuW+xKcSV2viwiglYAOKb9s+YmTuXOKNJJdys43KxilKUK8cBJmGgsVW7TaTPQfhy1LeT7H9HVWrPIYI0ZdhF7wSiobBQT8qXhcDyW9wy0TvkvgI+GZ6f4Gv4VDt7pvVuayvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCMa2tjPOfDjxGZRa7gSwnyDial+zK8DZhmU3DmXAoQ=;
 b=hIXGJ6t3gICwod8sJIkdX2Kp3MLY/S/xMeQhMHfSuLtMnbPg+FcSw3nT5R0d7NJHhStNao4rGUuEpPEWoFJM62uI05GG6aHfhSa5PuCC24/x2y75usnIimjach7M4vQUHC7Hvyiqj5SAs3TmYRDWfEZTd6S03SxzcSLcJ5K+WF3f4hQYkc0USjxxXxafzkFLDFCFyoG1O+ssLf86KsXi9uHVLQE+uvElPKaFAlKaEEAUZ9aZWJ74ZMmYhwdKURQAYq8ryJNQuF+LuxxLwgUD6Fg8QvP8FAY3y6orW5H03DW/ISEZEzp1NGODfM0xOFN+IpW+z5a74IoWqtXFk9/eLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB6169.eurprd04.prod.outlook.com (2603:10a6:10:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:57:57 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 14/14] selftests/bpf: add bpf_first test
Date: Wed, 11 May 2022 15:56:20 +0800
Message-ID: <d2d37c87c56f64d469e918342995d6e420e8e548.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54c62680-6d64-4adf-afc2-08da3323f4af
X-MS-TrafficTypeDiagnostic: DBBPR04MB6169:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB616948B4BBA3A779E49D74F5F8C89@DBBPR04MB6169.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3nLJaVF5t/OFC7HOMUSNdawlglVkdzgBP68YLpxCAPQQjtH1q0pF8PcJPoj4XGa3qy3EzrfxZ7utuy7NFqaoXQ/XOr6f3/UY9gxX9byFKezRV03pEeRvc3p9+Ycv+khq0jxwSY06V9hkG4gCRZkUi8ciuuqo2XtRvuo/o4iWWge+t8KN2dd/5mxVjBW3ZKFbYsphIinQc8AwIjE2wynfvtGPzDPcx9JCaQPCWstUZ7t+cdqvgxcL26iokZOagrNk8qulr6TK6YtJgQbtN3ms9BHQlnbVGUb5YozKyFXzAOyeYzKApyJeh8DU0xEgLLZAIRIN3hPUAB6+QY3RRG4kx0u/z+LJuSOuDlO/kP1LZP0XBGWHO175MTKhcPk3doUB5g2Lhkkawt3Xy+j8yFp+3mrZ4NpH9ZMSWwcKGyfVahExzzSUtxqduqB83vZL7TXXrCL7iBnsQuXNp+3sWBHPK2jhedTOBar5iAz9KL8MmORq7mVzoI9rUuN/C52Vfkcaiqoz/8KCInMJbZPRsmgq9d/EUlFcFGXGsdTYPOVTdnVdkqLMz23z+zkPMAKbrfM7BVZg2smRvJejLIqiGJhEAB7nlZ0AtO7OVVYY/xC4KbMDDvfXMqImqtYwZetjKkUe86hTTJeEDI12OQTO39W596YFUfgfzZql+y31GBmioavTDtyZMtf6AvJoKXLzcp7zXaJtUTpMv92yHmGOxXNyuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(186003)(5660300002)(8936002)(6916009)(44832011)(54906003)(26005)(6512007)(66556008)(316002)(86362001)(2616005)(4326008)(8676002)(66476007)(83380400001)(6666004)(6506007)(36756003)(6486002)(2906002)(38100700002)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eUtfCPj2vZ0yVvAOS7E2KtLalx9fdNWpXv0ydv1vnh0NR3+ddT1fynjRqyZ9?=
 =?us-ascii?Q?d3ZiBjRbfntQkFBqh6kIYt1drmBddusrdZmO8GKS3pzs+6iw4r6AR0Hnp/Mr?=
 =?us-ascii?Q?Z/0e9IvJAOc3BH4X0K++yI1H/57/ckHTpiWALjp7wmMvGdqI9RWhItvFn3zF?=
 =?us-ascii?Q?5hSQQODe2TkAdX0kPyvcnM0LVgbhVyVCWRuZGzJWUbRlPL5c+4E4AOVY/NlP?=
 =?us-ascii?Q?Fr9JxFNuwjP9LW8JRaLsr9UoygeSFWwb42cjjMazsd/Kk8YSPfnTsbGqFSph?=
 =?us-ascii?Q?uwT1ArwZXYQwK6gfpetpz90jTf2V/68CoEcAIwamylHrAIpsjMS4Nj6EqAs7?=
 =?us-ascii?Q?3PK4W6VS4eK5PxTgNw4FBEeOLSVu34+IIK5fY98v9CgVUoewlP0+qlYO6CSq?=
 =?us-ascii?Q?H1UKdtNm3PE4J55uk3ZAI/iZWeCh34I2aRK2TsEbrSeDHSaqeAEDwOvm8DjM?=
 =?us-ascii?Q?JakEUfFSluz9b88lZX3fb60M6UQ+FyYcnlG2sC+RV0RzHZaWHJlVANZnDqso?=
 =?us-ascii?Q?32XFXbhPJM364ovMHeJqTNfC01isu1Tsbrh3aOYKHTvlCT9W7KZktEZR2uB8?=
 =?us-ascii?Q?jdUkCFcSr7N23oBtJVB0rjMEGewqfRjU/JEgpyZR1ccv4AKSizr5vRZL2+2v?=
 =?us-ascii?Q?wy40qNqoYUWsblQWdmjJBlVpYm+kZ9z13KwT6IGHdYJOsXKm+C8uKS7BEWUs?=
 =?us-ascii?Q?CZ0MpTLN5oIFS4zFYgaqMZrsjXK5l/WT94o2ZbBo7H1ZjFDXrJSOxxAFDt01?=
 =?us-ascii?Q?FlHVXkOMopOjhJeXEDPZDzeJBQNKT3koKlFDAO3YJz2nB5hzEnP7cxlfDkDd?=
 =?us-ascii?Q?yuHr5pTxPap/E7CtCWpA7JKzxNC5huJfCTPtJ+Tt2GJaOaX6qpfPAuYEs2NR?=
 =?us-ascii?Q?KZOAiH8u9Vk2rv7/vzXwPPDRQ6CBc8vHkBiNAJzjPwWYa2dfFfNTpNqzK5aN?=
 =?us-ascii?Q?Ok8VMTrBupX8GjKuphqaYnc3bzsV/Ny6+s+JsnOvwYqCidr81mr9/R1Vg1HW?=
 =?us-ascii?Q?2pyqoh1Sienz9mLzW5Yoguj2zXZDp6aH7NmUcD/AzKrmFD3HCYJTxp5RUPxL?=
 =?us-ascii?Q?dYu5uFpyAdBuYtHN8f0JrIsOgVO0cj3Th6GI453olKdYXfipCUXf3UM9OBd1?=
 =?us-ascii?Q?i+psOiynJfI+QdyWBr1a3DlX1smck5aTDjtzcStmvUm+D8Q4rNySFbi5LWVK?=
 =?us-ascii?Q?ykZutgy9zggmSqjYMkRAq+FEsRg2obendTLu/6u+he89oKdIcf/IiQL0og3r?=
 =?us-ascii?Q?hhb1nav2pOU7BhDmBJoiSfqRfZnTmMfUUlpcsp2i4DjpORu3ow4d+zHyINY+?=
 =?us-ascii?Q?7jHUTYABx4HvWAd5e2PizzCYKekv20/z4NIOG7hrGLKbaYcMVJQt7GC1JStB?=
 =?us-ascii?Q?4lDhyQJjj5kADcM+NpLFvIqRZ0qzpO6v7SlaH6Gmiejt7UcshYVURzdPvC4a?=
 =?us-ascii?Q?xqCSc12JbTT8wjBH8++iz0lcTQ7a5kqjNbMk5fPavw4OGSBybmuiKaHKE7kA?=
 =?us-ascii?Q?XK3YoJikVbbENqtBfjCdbPVjxFaSDyVJcbTLG4V4f1wpFqwlntESh+ManE+E?=
 =?us-ascii?Q?XGeERwEOP7CQ39M9ZCEP5PV58NondJYWkcmQlBLKRQWEboL4VN5q6proBHot?=
 =?us-ascii?Q?Iz3MB6tb/mMB/4vh0mI7gAWUac9qf74r+xY69H2X5wzqYon4AR1h3H7fi7N5?=
 =?us-ascii?Q?kUVPWn1BwD4pCKjddifkiO81rnZAEHn8mb9yjwo+0J4/L3xoMdm57TXt09wy?=
 =?us-ascii?Q?CZLlKdUWNTHV0spn6UvfsYf21Pwcc/U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c62680-6d64-4adf-afc2-08da3323f4af
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:55.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je+qx3RFtrfEcdzoL5666HqKTQA3MAKFLM28SvfkmxSqo/pTlE0xdwMGdQ32OoU8UGXpz+f/nb2SnmgcScO5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6169

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 51a3e17acb9e..93a5739712ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,6 +5,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -20,6 +21,8 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -258,8 +261,118 @@ void test_base(void)
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
+	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(first_skel->maps.first);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_first__destroy(first_skel);
+		return;
+	}
+
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_first");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
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

