Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747007A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNG8iEtpzdkuvq6LDqfwpmKo3DfQ3gomG42xVqw+Nco=;
	b=EUb4+EjOYlz9oxViWl+/NGcVdsx9tzM7poiduDSmElen6nNsXUFGqDPOV4vu7JVMr8WFhE
	1ehqQ9ek4Ix0prbfnEVxqFlMBMaZVyG1SV27xVjt3vt1u0vr4gmvAqy+/bjtfj9fFRX03/
	XVkXpxCWzQrxPU3HRjip6qUl1vl9rX4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-ccyigFIGOGS2q-vghAY5BQ-1; Thu, 21 Apr 2022 08:23:24 +0200
X-MC-Unique: ccyigFIGOGS2q-vghAY5BQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRLTJhNVzJI3mugT1KPnK+qjoktwPly8E8g/Oa65oNfsGg9ialgVRfnsMxMdHwqqTIpU8+jnWtAjcAYtz+PZ8O45sfK9Z2MQn/h7r5up96UV36Ucy3PWpD9rvZj5beBebp1qBKo6zGIvhri15hjdWnAikC6I2p2bTahkX3AuIHMVv0DLBWdzkDhS0YatFI1ERM/EBN2InDicPil9ymCFHyxnmpGK75yr0igTx2L+295OCIZphd8GiV53HrdDncYvVlKXGAGq0qYGMCryjSKcZfA2z6UIf/CFf2NipogSpZ/PX2oQfObCPVO37yjeY0wbtIWZ84G5zD5LMiPHYelqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZK0VfxUK4qsR2ROUjpij6j46M5w2ZGToJAXYcwSeKA=;
 b=jJ1fQLlIGaxTtE7LuCxU7VOoNNvldnQ3BddyJTWM0n1pc5hn+8y4evGyAZY4ClOWBocK3PiJ5cKELkgz7zkL4gtFks7vxXjhzSYRYqKTMNU4V4abZSRlvL7Rlab6Jhd3ux/NLbO10IGmqi8PD2ci+QGIx1VkRKF8YU298Yp2LgMSPj40bcFnYoYl67RsEyqGGU/JSC8IlIXUCgwHIhVqo+3I7uRLyFETuQy1QfOR8OMQ4+7BaDTPI8Wiu0MnORXYw2Dg1OXr2yNE5gSOHYQLYJP0CIQ34roDlJzsjXNqgkcN0OBakv3vmVBcWWKPR48B3dqYeDuCmiDp/ZC51gXdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:23:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:23:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 9/9] selftests: bpf: add bpf_first test
Date: Thu, 21 Apr 2022 14:22:27 +0800
Message-ID: <b3a671f28c27972d1aabbadf53057bf6a1f9cb1e.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c3f0a2f-8e6f-4041-0f2f-08da235f7029
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8100386FAE37EA268C483625F8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3R51k4OlRv3oVQKUdexx161T3UVZIyROyNdLLL3xCNDXpBza9criKjD+xa5uztMUdhZOvhzKQ9SnSTlnzXSDuvxhxTGIQ3XYc4kcpFC+Etf/kmSB385pxdRQjZfUN/fDQH3i55n4qbVyj2RzvKN5IzWdeKTc7Xckd8qGpO5DhtMQ1sQjZcbOrDXKyg2QdYBkviMJOTxnD4F6Da+g6dmkNhtzWPfQ0a135wwaOU+QZmsD2C0n+SdXdbHpQSmqr55/6L7rp3agnPzMazHXqxFvqncCJ6SZMs5uTgi4awrLZaPBK8mW576b028ivRIMOYEFez6Do27QgyFFcX635baXRfpvQ/1NwsjCxr7COyfNYGpztJBGTYsq0Wr/NJitBCJXzJHHCuCG1FUr58qsoLB6hEiOlXfs6SihS66Y8trR7WUF2aTvRbM8UPVQEbDJxYjQjTuJEUTF2NFc5/2AabqPj+ZC5Rs2AjIEi7HQfhvuikh4w2wfggiylu5/1S7crsCDVyeijcmWftNsKjfUAK4lhlVLcL0j8jTC07aPqT6jwizC6q8edCxtv+Avb0KQFGtS8eK3ZNal7ytMNxappWmxhSgU2QZheTBB9E7v+GnK8y7h1kqbBGAiR3+o4QgitREJOgGPNBiD/UgrfFB/iF4O/tXbsiQUDql5uL8CwVgUOWGThHHOjEz0PpEmDTtYjGbQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(83380400001)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yT7KXCDZz/iXlNMjm8MBCL1w09953nUdWr9t/zsA2xw19lCWv0pZpS2FaL/l?=
 =?us-ascii?Q?XVfKhnK4Ro9ElRBRjNVV0rd/xbceuPQi9aRXvXJz8tLL/gu8FtDZ8o5b1Mst?=
 =?us-ascii?Q?W6CyNupeptNPAo9c+4YEj8t30GSclZ1vYycc0exvfN7kiWBwZf/jnlDTydGW?=
 =?us-ascii?Q?uvwyFSA23t8lBcmzVOFYnLcO1rZFhBxGWd/uUIteYHcCoASJOINQokDJwfBb?=
 =?us-ascii?Q?aEpKFqHQT7xfgxXX6287dhBt8z4KvkUfOZQEAtUpDVJP+Pnc1COLEB7ObvSe?=
 =?us-ascii?Q?fA0K3DX3hCyR8+i6EMXekGP58vqhjZr53b9CzI+O/lhqbiqLzlyeGgcdhCJE?=
 =?us-ascii?Q?Uq0deUn85VP2Sfea/vYY+Ll6jaTfaKns58R/0ezMPlEo3Jas1OAOOEyzN0Gq?=
 =?us-ascii?Q?6F4EIf82GDWxAKaMThE4wYgmHWcfMcoe5LYl9nF2EkqPl2gD0hkaU8qxrFHU?=
 =?us-ascii?Q?ColVSfY7dEOR51Y4Bnub9IBepI8ne80GnNsu11wh+Jn0cJy00Sz758Z5MmeI?=
 =?us-ascii?Q?0cTmdKiQNv3UuRSfFKxm4eSszuUYZ8zgf7Nn9Q6qzaq1Ba97kRepbUYYTdb8?=
 =?us-ascii?Q?2IBzp0Jx3MNf0UmPYpYEOeDkqO5l7Fgq8Ca+dxuo29mgblnVbUH7SXwCQXeR?=
 =?us-ascii?Q?gMFZDMg+W0I0I1MLJRGkAPQNISbr01dRfso71doD8e41o3qFf7c8zSecn/wM?=
 =?us-ascii?Q?qt9pxvUHsDUAtPJfQ/T245/97IYC3iSLoBP7T+lm9DWiGzOvsW7q7fZ+4ejk?=
 =?us-ascii?Q?83zOIeGPLhmtwsNU+pR4U9FfayTjvXgy2gnLpcAoIAwyty3kidlVa/sKVKIl?=
 =?us-ascii?Q?8phnQczQTcuK26AdgFN32IsLbND1a/KCVYB+BmhmnVjGpDtzEeStd1Uk8/YY?=
 =?us-ascii?Q?M+UeAKU1OvURJlCfJ4sZe1KVzAtgSne9oO8TjIaqRtpnZrSuRgS4kHYTnsNp?=
 =?us-ascii?Q?ShTiRFAiGeMbR7KtQICarcr6pFH+VIM9nQYuYTMUUTewwTGJxdQGtgNABi8a?=
 =?us-ascii?Q?5CyT8d3JS/QCKOz7VaZxpZya1yS33o263Xda8QghmC/CGE+Q48jc2oNY9eF2?=
 =?us-ascii?Q?DR2pmGmHr3rIEONr0eI0gGksavW3NBM8/g68i7zgod7caVlpw5UlO5+Hy44R?=
 =?us-ascii?Q?tojHsZgiIbh121DhLMXdlaSyWgs2Q0xuBYEow8R+NwHKZXoQRFVC4bNUhhrg?=
 =?us-ascii?Q?g14uzY8yp+XvrfLrzXSdz6Dy09XXQoj64i0n8HENM2tZxN+3ZgqW4gFQkYOl?=
 =?us-ascii?Q?++AqJkKaT8oZmrtBAyqOrvE45FgNvXo2a7mEv1u1c+7WlMg7xcJqtebHxkWF?=
 =?us-ascii?Q?uE2YG/7iwvKOGpSxgLPZvfms5Ksi6Kyep+rq7qoI6wAqJG4tw7YyU4VCsivd?=
 =?us-ascii?Q?J4D6mdUlEJy0gVVuHz7IYZK0fSRljiDeaEy7Gb8m27TGTlBnrvvkpnRxawU0?=
 =?us-ascii?Q?xRQtGl1K9kg4y9QtQRVzqmBuj0y56l2vWLbgrEpkpwHUPKQWUPa8prrAloHM?=
 =?us-ascii?Q?7Tu1B9go4wEMWAvL+lFUMDDQ4bXisL46w+mUZfOBBLAtCkV/MWZbWQhP9S2N?=
 =?us-ascii?Q?qhovgKUEIBxOgNzE4JptcQoRsigF9160NZkuZf7lLmLImlvl6GWWksZWdSKC?=
 =?us-ascii?Q?SsTbCIC7DEdoHIZUkYYTbbC3jZDMptqJ1Az0kUOozYNJ3H62nCH2uhge36Hl?=
 =?us-ascii?Q?FX6Xt9Q64Vi2nGqRTuZgtqnUObwSKwZMxswIYcBcwTmJ6ySrZvypK17KSmWG?=
 =?us-ascii?Q?0NsEDr88oNIGUfyFQmTAH39hdEUZJGM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3f0a2f-8e6f-4041-0f2f-08da235f7029
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:23:24.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQyOViw6k9iI52wWYQ0ijhWwGko1Xy3VGLmG/YakjbFB/QQeVEBhvfDKX+q5hScGkeyge9kg081qN1aiR/5d4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

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

