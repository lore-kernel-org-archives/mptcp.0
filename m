Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373911391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MW8x3gVCm/i03jXXw4PqqL3DPZvowfzj90yFEhZ3wEw=;
	b=l4TjNMWA7TemVgXjhpP05VDSiKpf4l715aJ5I4bPqHcAUjUHennZ0bI0xdXHIN6ceVGwPE
	P0QNCdc9vu5JTt1h20LWbzA0ouiZrYX1p0QHFmlh/KqJV2uQJ6hhfAzX9HeFffuvV3FXd2
	ZWJQoBN5oe9fMyWh98dx5jDhkkURcgY=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-rJeVVQAMMkmfLZVENFvZxQ-1; Wed, 23 Mar 2022 10:30:00 +0100
X-MC-Unique: rJeVVQAMMkmfLZVENFvZxQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyWsYeb+HJSfyq7RZjUL4aoju+rl2ceg4qUcFqXjqikJYgMx6nMIGsaosLs06PpniN++R4hHhDeRNf42iOcjcNRnweJ10VwdqTnZrFis52RShqW1dfJSnOhzGOXmGgTlQ+P0CKCqbbHOE3jxww17m5h33Sl/8tKQa1K3t/YSqin2wB3Ik4Fx9tieP61s9VKhAhkL4cA215viAeqsBbkToE0NiczGCebV4dug079yhMRLlbkmhSrZTVE1URO6Um3YbuFiybtl05A8rPA4FmRkMHIIpEWVRh4cysAgBZ1m9Sh9iwpbwcTrFQTk4fNCKkA0rs/s0F/zRSYSicCgmPcYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4Fixy0a5Pig8lBH4+G9l0eHkbBVyEZjGO8vLZJlPRU=;
 b=PbxBLuU0k8QHw9Y7emUYLhWflmNW3u8tdt41ZYfi7KQP9VqcRPqfKzCar0z29V6P5q/tlSL/USA9Pb8l8AJAjZeWKt+ulVMSHs+r7zZTmjHPnLZJcFoQE3ADf+st7mLSRyihRmBcy4Z67ahjQEjt6mySolwQDpsl1T7GWykrCl7VLdivsrSg0LDLx020LUQUQVwwibmKYIDYpXsVGuqvDlBNrDdY3dkElvEJSL+jS3uPUVhD2rtVbe3olFAn8ymupEUfRlj2fp80C5L0HvKMICFE3KTJCFuniukIE8jYKvrJ7bT2rVMLTRjFip+kBwIwzMk6WyzNLmGAWD3ljHhNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2536.eurprd04.prod.outlook.com (2603:10a6:4:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 8/8] selftests: bpf: add bpf_first test
Date: Wed, 23 Mar 2022 17:29:07 +0800
Message-ID: <68ad408b471491ee86157598acce5a64bb71af49.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648026806.git.geliang.tang@suse.com>
References: <cover.1648026806.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c9fa954-4e41-479d-7e24-08da0cafb2e4
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2536:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB2536A252C852E954D7261334F8189@DB6PR0401MB2536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BCKwrx2D4ZFlYmHpevB++Yd5cKF/NKA850DGW9EQ/hWSpJO3rPyy1y+AAw1D36/MLZgRwPtLAZWXrAB6sPOzAxdQXVGFe203m1Mka+/5V9byO47+nd8KylWk7v+uhqCD6b++nzIK52XNCarjoi6IU21K1tTBnfpq10x6/EjDrl+pBtFkVrdiUBhfwik07QUROnm6jZvnJh9349q4Cq//FKa8abwLeOm3yFTj0Eh8rr6f7rX2Bjny1AEjvHa1NCstoaHiLqGellU5Fxl0B6G0/I6bHZSZj8gJTZO+7dcMvgZ2azZHb+ujCM4FPIjAPdyZawhvvQJUihWkSaS+qweG8BexVs2N2Eglvfc6DPOAxK4bevIh4Js7hLOrrboby8KbnnzWKSGWrjDVJL09rEWCcjgAJ7YZ8SsSAzK5E2zzm+/gDIi1VpcuToU1dm6aSYiCXB6CFKq7hPiJjLRG3evNT2LqWAL6tbmv3dFRn+6JTFH3+EXqlJkeGwVc8cmfjDVeTjioYAiKBWC352ZfPE9/POxxw9dM5RKHQchfr+ogBIkiW02kqPaBWdClGoYcUzq4lO1FNYiyZJLANrBTevA91Wo3NCulg0okFaa6wKzBEb/ruR6NnsbD9bovW7tRBUpCbOosO96lBm7UnM2id85BiiVlM3ngN2I5ieD/CRcvtpSBMFZkv3N52RzOXjXlEFz7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(44832011)(6486002)(8676002)(66476007)(66946007)(66556008)(6666004)(6512007)(6506007)(36756003)(4326008)(107886003)(2906002)(8936002)(5660300002)(86362001)(316002)(6916009)(2616005)(186003)(26005)(83380400001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0NLwZqLb+bPvgiV8+k3vHBmgk5yJIGoF2hLV+YNQV+0mXk2QAX6hBTuS1BVK?=
 =?us-ascii?Q?WdnuLM57+EmXhDgqVNdbFxUnSVUxkwhhlXHJtd4qjAtbDrem0tT1jxU1XthB?=
 =?us-ascii?Q?s3QwPdmkxTZJaHAKZeq/RQQ6/PdGqPomvuZUiN6qaLF1hDC4JSQ1pCs1XlTj?=
 =?us-ascii?Q?TnvGHR3fjsjv/Z+sVjsVQ9CzesrC1graXIwMyCgBXH/8Ih81rb1jviZ++QO9?=
 =?us-ascii?Q?VdmJwd+NNjcsO/kvAfitb2hy5YGQhi/gCyl7kAkKLfb4UjOalxyNUYNAXG78?=
 =?us-ascii?Q?UV7ymGtsNXXxw2WHmuOinoBqy3ZfYkR9K6fTZ4HdFcZlR/MGPfd/5e+Ha+ZH?=
 =?us-ascii?Q?Ia9Ls6Zb0KxrP31nsocVW9ysFDoMf+9ZrAruPEM8aGQNJS2b/ALQNvoZHpsR?=
 =?us-ascii?Q?zOe7/d0qkyCNw3S5WiXrWBfJ/2DEgSMlPBD4RUOCSOw+i9oF8EeuzPAxBNI0?=
 =?us-ascii?Q?vlsQj07YQYYecBo/Js5FHYRHU4qS+zuuaCJrVqoNRZNuCIWG8ZJkzQbO0RpI?=
 =?us-ascii?Q?VwWLSTZioawqQOaGryGfbW6woGDqzNLPkXC1DI/tz8NE21OeY6uakt+a42R8?=
 =?us-ascii?Q?KxuymD1g3S6lQFTbzosbE7cFIo/99UWWTw22L8nJ3V6lBvjsIcWzjJ35kgNe?=
 =?us-ascii?Q?PZJFetk30Ifdb0NZUC7QQzQ7Pr2wicOaAlgo/rcR+P1dBL1d58eFY05NTey1?=
 =?us-ascii?Q?qwJOsqcfMFqvZcfXTFl70tSJ5PArkYrP8TxuiqoYhSisyabUCn/HbjkBo2Fr?=
 =?us-ascii?Q?BQvOjcB9SQVoGCI91YguJAEe83xT4aO8NZ9ljwxRYA65yoixbZxynY76/gpk?=
 =?us-ascii?Q?TM/IkKUdv3Ktpq+U/WIs004j0D3EHeHLJ/+RJAmalnCmse0ABfe+1DVf7/ge?=
 =?us-ascii?Q?Geh9DEp8x3kJ+48sCn090ii9klN6sZkegMvAaFzpJebk0E6Mq0xE7pzy6v2W?=
 =?us-ascii?Q?0/z7i/dkC55kJ3n3eIYimmicrgMrtpypL+0eLNv5TL+e4pF2n/fTWHcEulo5?=
 =?us-ascii?Q?EqrzPiDuQ7TUqn3Zomz8cgYq1gahTpb3W2+fnNDp3Dv0n+1XKWa5zdGCe6ZV?=
 =?us-ascii?Q?lHXF8v/BaGRoLdWnZ7QZ81Vt0iujHAe1miMI024DrugCAPnZou8NTkycOinh?=
 =?us-ascii?Q?ZXPx76XfPNo0wr+VADl8YZFlBf1dQoxYHucis9yDFmjQ4/0OmNBl8ayAjFC8?=
 =?us-ascii?Q?5ZctkCUitnV9Z78Ow5eWFDWZtugo88QaRcZMyBZm6F7cYaZNzEgh0Cv4y6rw?=
 =?us-ascii?Q?fS4PPpmKtvuPTcPh8V7S0zyU6tGV7feFNlrU8rRMmerhW9EyLBCG6fLJVP9c?=
 =?us-ascii?Q?mBbLJtJO0JMDPL9wMwFd5n0b3nTCfoaItDkeVFiVZnLIvRdhDDv879g1wEAj?=
 =?us-ascii?Q?2IIDBbWrDSfUE6p4IMjPio2jIwWhnd08m3ZKgcFXyjq+J3EHAR4Kub3DKvpo?=
 =?us-ascii?Q?ko2/QOlUUCCsrWgDL9DU7498V1tVJYqZ/qXfq0CrzITWzDBiwItvpQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9fa954-4e41-479d-7e24-08da0cafb2e4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:58.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syLhBCounOLfekh2XKnQ5sfDncShuJUo7K11iYs7yxns9tspDS6Y7unUIZ1mkYO9LHMCT4EgX6mJdi9WTJVPqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2536

This patch expended the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first MPTCP sched test in it. Use
sysctl to set net.mptcp.scheduler to use this sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 325f8b51f621..873027cf92fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +20,15 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static int duration;
+
+static void send_byte(int fd)
+{
+	char b =3D 0x55;
+
+	if (CHECK_FAIL(write(fd, &b, sizeof(b)) !=3D 1))
+		perror("Failed to send single byte");
+}
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -185,6 +195,8 @@ static int run_test(int cgroup_fd, int server_fd, bool =
is_mptcp)
 		goto close_client_fd;
 	}
=20
+	send_byte(client_fd);
+
 	err +=3D is_mptcp ? verify_msk(map_fd, client_fd) :
 			  verify_tsk(map_fd, client_fd);
=20
@@ -237,8 +249,38 @@ void test_base(void)
 	close(cgroup_fd);
 }
=20
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
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_first");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_byte(client_fd);
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

