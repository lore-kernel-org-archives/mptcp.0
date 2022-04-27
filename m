Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DE621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnSV5a1EwgO3RknI2V5ujKmVZVa0WBBQfbw9D8tOT7g=;
	b=OSqPXowXvwDIltoKY6sdrLrI+D7vm9XqVso9yKHupoVG57m1KATDAwLwLXcv4YvGX6WMPw
	M5zxBT6Gm0ls+R2wyCNQsPsKOwOIQx3lxRQBVxO4HFdtqnyay++sw8U49vYF97v/qW3Xrv
	lBfntujzel/NS1U0IZZ4c/driilxHJw=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-gZp1u4TRPkyQQO5i7mrCiw-1; Wed, 27 Apr 2022 03:57:37 +0200
X-MC-Unique: gZp1u4TRPkyQQO5i7mrCiw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njtiC5EGqBSNxjC33VaAauO8oLU6VDUaUUGAThJTQhpZxaRiwTM8g3NSZt0nDptoUUr9yZec2T2uloVXGaU06QMBAsmcD4GTa7Bqtaf2Fo4RSOK+wGyHutCeJo/I3jsRafnD10lZrfVtWZ/mrJWGk0iHyl/M4i90sK4yhStpaHamqwMGN3XizBzcR6Pmh+dPVxOvF4rnsSn+ScKq98BHk1DPZUARM4ynMpa0te0vZuJC19MC6L9bYgE2+2SckhL/2yBuAe89rLmld8fg9DTl21L/MyeEoMxIb7LJPbkjt7ybvJbA9WuPDGPw3t/xOxWd31TZHbgjdW4msMI0aIwXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaWAbkqCo4kB2a2vFZa9GAp/RL8+LsScjAc1pLDDwLg=;
 b=iPJlZADhYlDu5qJDeYS4S4XSb3TL2jwlTb2Mo3an+0iVTtCu/DBEnWU3oO+b5bGUhe5+sGteXBfZNds/fFFjMIar/ELCHc+HhrYlf0usD9FGO/R1DhiUUIa2L8UTAmFf9+zB/rWdgXE+T0ju4bbgTCDXnqSNgwnVIHwqaGomyOudManLeARP3myCwJYhNRlVmGztdeqBoM/HGboFwl4TsyldArQeJsiccvP01ztTde4uPqeLGv4V7uuVPhVgVD4vY+J580w3EUM7uUBw4lDrySA6f67ALocWs3GocbRkDI4zFfT0CWec2LqAiLbhV0zHaY7mEwkjMHMvjzqQowOwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4168.eurprd04.prod.outlook.com (2603:10a6:209:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 01:57:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:57:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 8/8] selftests: bpf: add bpf_first test
Date: Wed, 27 Apr 2022 09:56:55 +0800
Message-ID: <1cdd5e7c527dbddf865de4242bdede522a33102a.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 557a650e-bb10-427d-4eb4-08da27f14d53
X-MS-TrafficTypeDiagnostic: AM6PR04MB4168:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB416863D7380B20432E5FAF00F8FA9@AM6PR04MB4168.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X/uAdzBLzLvXP4DQSjesXpgA9+YrsnZ7raQAhePszbs/RYq5L0DNi+dsyvFnJpDJPFk0ewruPO/m5mCSCXSGSbwACi3knIhWcagED78UZyQD/rlXB4fJ01Op5+FeBDIU4/q/VFX8vQm1CuYYfovgEAIkzdLQ+96c5mmXcqijndSk+EOSt541o4xg3S0K+qlDfNBIsFCfff0fhHceGreKmLhGV21dJcAcnLpRjR0hf4Lzb4muVC45Mw0uSkY4ePmsCGFhu2Fnc5hyp7t+srkjl4rEjXhRGr53Fu+L32zfheW9Id3jnCB+2LFW6zWXnw0eOzn3PRm0QyjKNUptWgQ8BhQv9JMl5N+F0QhmCzFJfYHzNsnvOtq0TWbqF1lY5ZtvGKNRMDicjGCnGLh0zx+PWZZsn+2w7j4B4ZOOhACfGWZWoloIUCFf4DnZVYBvyOckZ1XLiOycbPlsg+PZQjqo3eQYg7wCvPk+K/a/AejkbB+x01fCcUoIHOonLyWaZM2vS58bj+tn+MoNH9jlBaD1cmXgeZl2yk7ggtNokuHRWW8rCpTyzngIng141L8ukMu6tX50PRN69JsklcwzKZWveV7NJmnLsg+oanv20h8QPciUEctzE28bbQ1oDCWKMyZj1tsUVLfLYWwQbXlYr7ydg7qoxwgwuHJVLh+/zzhDOUhfkB7aEllI917GgFk3aiUF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(83380400001)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(2906002)(26005)(6506007)(6666004)(6512007)(5660300002)(508600001)(107886003)(6486002)(186003)(8936002)(36756003)(86362001)(2616005)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mp0+3YTTtW07hMr+2OZA5sxmz/sbUs5TE2DMLIumzb1Bpa/dW45f3zLnUtUg?=
 =?us-ascii?Q?ZIddf7uFJvY6uitLMB/Mq4e4PznL/VVF6eCBADuxgBPBrSBrYL0mRacZYMhV?=
 =?us-ascii?Q?xaatXCDlAR3BRbmGga5sFbuqam0Pt9IXW7fnvAoiewZaACLTpwhUaW1ZNZoP?=
 =?us-ascii?Q?jPtmCPNr44uaS59aOZmyzHhkLf/35cBv2HpNG0otl8g/gis8z4Qgq5DoXFAh?=
 =?us-ascii?Q?f6iQBPNi684TfEgI8GFa/d+VVumgl6BfXEbxQsOr4rBBpuPwV3BKmjgX4lON?=
 =?us-ascii?Q?9NZ1ZMcjBqTesqP+Sn9m1WdsRnkjJSMUzFMpFgmuXL+/Hi3EoSuTuPrsxII5?=
 =?us-ascii?Q?da2Dy8XX+CJGYwm1QVPboje3QsvLw9dIKCIF6eH1ZH9bJvFZJrkjtm6DX158?=
 =?us-ascii?Q?iS3Hn9uy6DRzJgiLeC731RlYwxUq+kRn73OokMY0M7nGs8Lb81yoLD9cSJx8?=
 =?us-ascii?Q?7j/z9Az1sk56ned799vJNLG4iAdbZAMRF/ySuwgfBi+3+0QIyDufuP/1oSxC?=
 =?us-ascii?Q?gfCTfwjLUSk3SkAgabxdJ4WoXz+JQM/cRvkUyjIbClPnNPSIFvqp6t4Ao5Bb?=
 =?us-ascii?Q?iwajQJnrMWJnaWHyuuubfTXetwvAfShZdvKEZsLH5G0+PVZIfMDXp3tUwWTh?=
 =?us-ascii?Q?2KpviVHEw8CU7rqD6/LaQ994GoHd2C2hTajgKmBByENNQfSYzSiHdc3ApQwT?=
 =?us-ascii?Q?mP/SPovmtnjnnAzZnWPtss1GFWD8axb+EvN6NEUSQewmjM39EoWBTWNDfkbY?=
 =?us-ascii?Q?DUWiKA/kAMfZbfd3e8F/+78K9IifoT8dzgnOmApiwJWaOZgc071wOQxdFe9d?=
 =?us-ascii?Q?eCIezooBV7XXAft6Pippcl+hyCRUHjMuGo/B4mV17SugoaprhMJqQNUKDyR7?=
 =?us-ascii?Q?0Rih9ypu/Wikt/I814t96WwrROaf9St0EIRygCK4b/VW7xJ5kPfRs+mjerc5?=
 =?us-ascii?Q?8MBPzgnCaIaVGbncyZye4oL/rPoJ5NO0iloP4kpMGsf7cQOzfOw3awbAKHWa?=
 =?us-ascii?Q?1BrtczJcy1j2IaskFx/4UesmgR21JbVhLOF3kbMcCe3qgw1kmNygJiMYIB12?=
 =?us-ascii?Q?f4z73/nkJlURPHUu6LG0LqDY+oANVUdjQuG7qHsJrwwXTod+FwFBEgN+eL3J?=
 =?us-ascii?Q?GI3YVg0I2sAFDj6k5rGUxVpvqpoxKxXqIwZ5et3ogJ/N1b2udGZh4Rd+SQa4?=
 =?us-ascii?Q?KQQOL5Q4DnnvIrDUGO8DCnI0gqgeohH88pTDPs5zUWxW+wiC2cfO71AK5S80?=
 =?us-ascii?Q?W348IZEJA8E9odGQDMzh8x864TzcNZ2qx6dFJTVdktwW6h1NocWc9KsWBoHg?=
 =?us-ascii?Q?221huNvZ4f8pt3RKdpNxjeai9ZEDoyLQLaWbja6nQE3rvnFjk7sZMY0Htjly?=
 =?us-ascii?Q?qWgwDcYzQhB1pL6K0r2ZjtilOsIoF1qXYewou2mqzHr1pE+IDo2P1vZXSMel?=
 =?us-ascii?Q?8nun+ZVwgXqJskJ1k4wR9vFfIJhZqg9EDAg0LTflCuv/anbwGQtdD6e2wZfN?=
 =?us-ascii?Q?axiLXY38Zk4yNTyEKvCa8EtyrJKB04AMNNr9K99JrbEcoCvZkJm6d1zhQ5E2?=
 =?us-ascii?Q?H1Yvn8LAflKfi0UK/jL+wFEbyfat0bYrIpjUpaT1LEDyVc2ehcoBzqqbVoYb?=
 =?us-ascii?Q?LQ3ubPdvQ277PBJ8WFPLqvInE09OWyCH9RcCK1D+hIH0G6BvaGXm0G70l4Qr?=
 =?us-ascii?Q?+z+78vj6VVQkLSxGqyg2k9WNs0H1y78GSRp2PcQ/MCLOvRxZ4l0+a0h6qJaa?=
 =?us-ascii?Q?4S5lpV/G2O3eN6/mBnG7m3FJUzcqt2U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557a650e-bb10-427d-4eb4-08da27f14d53
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:57:36.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbWrNGssSI4PTmBMgyxep53D1mCQmeUmS9Mz17yPsw0fAGfym+jEVQ2T3+lOO+eCjYD4JX84aQHuzyETHJqXeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4168

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 7e704f5aab05..44484a63e62a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +20,8 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -251,8 +254,117 @@ void test_base(void)
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

