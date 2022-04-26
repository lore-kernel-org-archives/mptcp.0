Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB87E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnSV5a1EwgO3RknI2V5ujKmVZVa0WBBQfbw9D8tOT7g=;
	b=AXCXRaUxBDK0NgWw2wZtsrksRIr2R39jJgmVFB1QEvmJUtfRR5G6hSoppvHB9z/De0AOhK
	a+FRkeesXLgNyQpem/fds+U5I58wmtvJRhSZiol6ntCiD4H2qECyRN0x9NpSa0/VRpc10t
	PRq58lEJzB3lAms57ByB0+rgMqG/P7U=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-xWCb_sZZODOkDrxY9AzWag-1; Tue, 26 Apr 2022 16:01:47 +0200
X-MC-Unique: xWCb_sZZODOkDrxY9AzWag-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg+c3wBp/Q00RB9+KvjtLyXupEGgv+RaAKKVBkntaW60EEUeZNf/I4qn/PB65IUr6bSj6JV6DhKvgye7dtvObT0vAiQ8bWDVbcEgir7v7MLYKJDk2yvLqzckcXoWLJMz1urRBUkJXpPBAFy5o8S8HRO/kH9XQx81KTRuNsjy9yEm++Gw1/25Ikdi/Qt5QoREOZ8r2bktvlv1cYaJm2Puf7tRI7dBaypUpKx2+hYjDaqd9ugaz8PNsIt/Y3MU/fnJShUzlcgL65dq5UUK2VEHlDbOPLHY8m13RpayZyoqtXji6VDQ+9BrIgzMnIdPEj428rcDJIsOFY1SRMx8zMs2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaWAbkqCo4kB2a2vFZa9GAp/RL8+LsScjAc1pLDDwLg=;
 b=AfVU4WTGEhmuej0DxoZu+9OgrFFsE5Z+bfu0QcGJ0/oc6/JiAXfLXVqB6TFXveCZEc3OLkKqRfnBvbN9nz1KhQs5Bvds/HIXJ2/Dd+GXN4UCzTaDLhn2BLl/BCRSQ/I0ODZ1Rc9/4vIqRkpUyk/BWXOuImc8SGCrEc8rcg4PtKbpMjRVK4Z/dGTWGSeJGPLIthuaXoqlYVEm0kCeRZRlVrIAfIc0GHP0kHjJJKfrWkSxw3l3Dp4dBzN3iIRnhu5ngZMec5ANSvf2BOJT79MTpJBUrlgBJmH9BtwHcydtG6KxTx/kzDQK+iLDOaL1bao6F7eab4YenwMagvNs9e3sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:01:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:01:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 8/8] selftests: bpf: add bpf_first test
Date: Tue, 26 Apr 2022 22:00:59 +0800
Message-ID: <291525366820384758d3a125465e008b95aa1142.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650981078.git.geliang.tang@suse.com>
References: <cover.1650981078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b30baa0-1da1-46d3-2b14-08da278d4d1b
X-MS-TrafficTypeDiagnostic: PAXPR04MB8816:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8816800653ACADE4142393BBF8FB9@PAXPR04MB8816.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZzUz2oAgCKv1YR1Lay+Jzqs60QQeCiW54jIGJwRtASf9HQ2oWONa2mACc2XorJFSc+iTqexad/UuK8sW1i5mHoKWVUpzi3M6LhnwAgrYIoFHMIa4XmVJRxGR1QobdNjlxjQRohrP7hPTZl2op/Xn8cta2m5TY4FjaVfXmWRLzR771mPn+nunf+MqTc7FBoBzZgLU8rjQAiMEWfanEse8bH5UPKMirx/ocAPAt3tZh1yKIacrKvqXDwx4PWtOrTme22Z76cXiyte/SZrLNlw0Up8xX8RxDOEnVkQalD4Ea9ldVQC7MoQqo7no9rxb2EzbFs6dfGJAe/3EyOI5NJW3cH63jUw1k5tYf1zYcz6H1gpNw0pSPwyLiY2qKhXiK3t6CW8HYzJbJXhwnGFf4o9JEdugK79E+P43+iEhaRVIHM4Fq5mQtB2vdYV2y2Mgf6eUpNe7i9g6XvPhLp5M7Y9FGb73wnuIoXOOxvHVSiLkXy5aVrFEvhcEEACYEdnvj5l+vf6+cTCniLEjYb68IBNgpujCFnctuOy4kVK5Dblj+kynYGd96us+F97v3LDIUtvwz1a05KMIuGn8j8cTOrymtW+E2wWZjt6JemusQwwcBI/fWwmZdfCYbqsOWGMinQiUSalqqs9N9Ceyes1voj1/EDB04wmczDWCHWoSZqiVp/Ldq6b5v3Lha5zpJntzgQBM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(8676002)(4326008)(83380400001)(107886003)(2616005)(316002)(6916009)(86362001)(186003)(508600001)(6486002)(6512007)(66556008)(6666004)(6506007)(26005)(38100700002)(8936002)(5660300002)(36756003)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cl77Xa96IMms4mLdUpYyayq7oSPh0nMhMz/qNEsSx/0fI6WDfgCtyGG7xU8p?=
 =?us-ascii?Q?2C5R1WIOfVEWsY6iZWHumjH2M3dNxy9icKxVghMh4n++xYKPWZToJ5mLoW36?=
 =?us-ascii?Q?tSWgvoFfGZnRK6k1WCWyJrdLUkL6E/CJNdNUoFIfPvi0oW5KDUE6AdwbmH5N?=
 =?us-ascii?Q?HFU3lHI8zuvqnhXmfTzj5mmnwH7sjpumtu/DR95UVaVoi/Jb3/Y2Om6XAJUM?=
 =?us-ascii?Q?hltiWOEMeePjRBKoQPIBAeC9tJITFXq+aGdXejvvNAFJszSIejhBGXpUhEDV?=
 =?us-ascii?Q?HZxKdSIB06z8baBfJNy4j2O7NHBNmvC0TZPk8kog/VyeoEgxUvsEIr4vZhXd?=
 =?us-ascii?Q?3mmgCLct8xoQj9YOEuONXf8F1tPBbi5cLT0pdqSc/cALN8Un3ZKh618Npgum?=
 =?us-ascii?Q?WPg44EEG/r7jP5mW6WuRbs7hT/oJoT9IYYSjZLtgMO0011IaLmPKg4Rbr/G8?=
 =?us-ascii?Q?KPUgpyi7SVgPcn0VYoB2R58fMHnMVzDIMYmIW3C+f2YCSFKfd//vMJxGT+pb?=
 =?us-ascii?Q?RWWSQ+Z0thcoTEsWTeZ0TloxDbaEsxompa1wxj/g3/aGd4/RVHW7J2TgCwcX?=
 =?us-ascii?Q?gwMmy/q1TOznA+Vd8vyI3EAzoHBfDfmzaPvby1KYA4xRvigeENO/DXqlWLXV?=
 =?us-ascii?Q?oe+g4rqFjevvrjlgXZWNedwHpttb6/AsMs0GL1Q6/wgZfOe1rPcNgaolZ1Fg?=
 =?us-ascii?Q?d33+f6l+9gnRz9u53u/qSQp8JRnG0ga+mmgX69QCdmE5a/YCLUsbkZMQiDm9?=
 =?us-ascii?Q?5uHQm7YZvjbpYK4GND7Va68DNFPnmMnqhJJiG5A4L8OEtWNOhwLNvAikHoD9?=
 =?us-ascii?Q?Lv33RoEdNwDUaShPM9XpUPlN8V9apXps9bp/mxFxKiADbePY9JITjhgALfAh?=
 =?us-ascii?Q?e07zGaMBpGoGtk7sP4fPFmXCkn0kVWwJCysk/Q3lfmLYpbvOHnf22ruSZy2T?=
 =?us-ascii?Q?c0du1Tgyae3O/BOlOBzy4oeSYYLUViy3RuH3WR6INnojb9ZclXJfHwG/cv3t?=
 =?us-ascii?Q?pvrPbOpoD1VohVHHMFWVCteTttB50LOHXyiVwPv3CR1VpTwri9Nhu/eFngdi?=
 =?us-ascii?Q?b4SNgx/qSOJsQEv0JLExvgG2JGChtsu8JIj7Cp7hhPzAH08PoVCzL1njZq/f?=
 =?us-ascii?Q?BxY130yWU9SX1Za9wsEqvyndkyuRNwBey2FVjIGY/vLihiR2eHJLcM3JYAoM?=
 =?us-ascii?Q?PCp+oG6YNU88e+Jw5Y+/FdEpAVCtjMoZva2NeQYs03HiogypnhUHR4gUrFXT?=
 =?us-ascii?Q?zwvGU+HmuNurFM9rY45eI+Uq33lq7SIIAlNFN2EYBk8iXsucONcWdNYnO2uz?=
 =?us-ascii?Q?F1qGXbnWHiajiN5sm4CPqvr2y3rCHjMqt3WiNVXSF6ccGugmGn+jTvba7DdH?=
 =?us-ascii?Q?Y+Nedt7uyphW83Wg9Iz9zwCeqs9Wh3vJo1LB7aJaaWHI5Zy2Bw/fbe3H6fJ6?=
 =?us-ascii?Q?aTbsHw8OIbm1hv0m/BpxArvpXn4o62QOt+Nhpm0+5yXmeHsTXyASPLbsKWPN?=
 =?us-ascii?Q?sS/FQB6y9VwZssgcfg0Wxgx+2Efpfic5aYfSduvktdhtb/jV+v53EVspv5GG?=
 =?us-ascii?Q?P8JzO4cp/X7VnwuxyOiLdLddLQmHFMxx2eRNN1W4o4K2iT24buxOFdBWmcRY?=
 =?us-ascii?Q?Xy9V5UWKK9T3Ov9FK7wUBXUGP8DlwNYpYgITKYvtNz4VFH/P0ysP23NMBI3h?=
 =?us-ascii?Q?QYPcWymWsWHAD8LijSxleNet8xOIEwUfWwBsSUyv2fYmo6vRkfZgypJNWrlT?=
 =?us-ascii?Q?uZ+bI0B5Gfj2fRgILWG9PGX28odRtpc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b30baa0-1da1-46d3-2b14-08da278d4d1b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:01:46.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqYLEYbiXRaHI6TNgZ2XduAbWkn7IHuSo0llRy91IVG0XkWldBts27viR8XUURrUcZtcWMuHSt9ED0SySKYy/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816

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

