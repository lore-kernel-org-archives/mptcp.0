Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698328E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyT4jemTa9L8JakbkQVefZW5wjMLlv+8fiP04Xdd1ZI=;
	b=efM3rzZpEUa3h8LrcUEiv/D4xjt2ZCfxfeKDsf4AxxlHcj3yRhfbmewy8rx/4sPrV0+GpK
	yTBOo5hCziteXsedR5G/d8g/umbKwH7Tc+BVlHuz3gZJAJsmoACW9M9t8ewG2imL32MMmC
	VubojGL5wUBVtaJDaD5lDoLgrvOQ/m0=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-k-j_k72xMhWyOunY8odDdg-1; Fri, 25 Mar 2022 17:13:36 +0100
X-MC-Unique: k-j_k72xMhWyOunY8odDdg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMf472EerqrQ7bGryfEb7T/i3YGUGjzvN0wfSliHK1MW4QwtW1xkQmnzpKwugmzCpc+jtn6bD0dq1/hOcBOZY2kdJM+YB59to6vHRtuIPC6H3xnYlzJsIZFoel3bt2U5PoYRWS1XUcsPRdJuPywbirIlYZnb09zdwxLd4T1Mqt2qRctT8hJPBjbMkghd7F+YOSbZ8HFdR7Dd5rMzMeclx09IKzny13/7W0YM5A9oKbof4bzH4WEHrsDk4FrI3cEidgDX0B36FYUEdK1YSVG0sERW21aI/HOsZIoBKziR6YHIgvZC53EZHHQzvU5T01acJnyW+vdchM1RVBWeCSW2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7zx/Z8Becx6fg64gvMVJuE3trxQZJhRIm9RAkJU1e0=;
 b=hKf3T5WRPY52vjXxUbXAGHi/CuWYp/BayMERY9/g9gZfIcq6rEhuKmc7Z7zuOkXudQajCHinM9kfLlUDRTdqhAlNVnc2blhWvJEK/4tIwWG9KGBt3HVcYtJ1xWAjmRXtG8heI750yMpj94fEvsFLxcSv7ogXLlrZ0j2xbigjJ+g1lQ3m3JjoeZR7kPzdolKZxsjdooxRuDdW/OINyh6+2zukG6UMxxpyTUmwx+3wUm1HAAMMGfJ+z5Wfi8WBN23RmReRlMWV67wj6CGN3bEbOZnxQsz+2Ul2UHMlH6X5zZkszuqAUgZ8ahsXNThbrvHagyhuBvd7WZLxDdSOtr0hfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:13:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:13:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 8/8] selftests: bpf: add bpf_first test
Date: Sat, 26 Mar 2022 00:12:04 +0800
Message-ID: <2d4db6f87d2a8f8be36140aa7feabc7cdea87ec1.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648223504.git.geliang.tang@suse.com>
References: <cover.1648223504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476b6af8-f36d-4bd1-23ec-08da0e7a69fc
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB393880E24755379C65D92C18F81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DQZwf0LO5CtXB6HaOnsZ8JQLLNK3xczzz4GLvKWu2Eej2JSstxSrMHbPRNGEgsc6OgFhaiSf21cyLlE9T99qkGi9O9qaW2QrOMYqXkyMfNrx/8xzb4NpmSYbpHBumhXzKjZYUZ0XC5pZ6+sTOLZie3/Ca8U/8bq/rmSwcRFv0WkzY6uPt/4bywRKK0LrP8anOhuDa5J68NUJjJ/OfzwxwUTdPQaK19rheiFxuCK/o2rghPM+UEVe7yhqr2fTJrVp6nYZKxrM53mPntkz0kDvOVTXvxy9zTVTQ6Ho+8zKruLzwGN/EjEYX7ZimRo+bKSC6SseenRJHG5ue3FGCAP0AqLLi988mdIClkf+VP+3nShp85MYm+R8RuE0d577mv9bTbyKCcCrEGqgbYAvo6VY0CgCTwFDC+ANn+qVclYJzh5IhFokS6Z+eO8MqZgICH2D4fnPuZfgrie9npAXPryc90iEoa1ur7pk1KnOlX3W45mdDLT3NeGQxvuuSp4MWUPZprrCTy8SHzatRC+XqJYBi/k0ClBT21gUJxrnpsYopPgpDjhCBKZc7fprstJKRKXFaDu2CNd1ddlh/1rtfDp1BFqeUfXZZFb+JDMuknxm/3TM4y7QXRA2UWbHY6p6SPy9lgNoLPVtHpwUHiA4aF68khz9iLbSZ1cFpDrY4EyMYUq3C/QYrxYxyAJemwSMl5m0cmk71qU/qjJcqOKr3jTnaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(83380400001)(2616005)(86362001)(6486002)(6512007)(6666004)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LLwZYEe6hZHXcOivRdfPzSTESQIaEbLarcHLOKUN88oStFUwuP8a6vn/09As?=
 =?us-ascii?Q?8Wv6P1bLqrE+ACCoEwFqUBLYRWlmTMV2KKRS6WmCPHs8n/4VJpLMc1+QwXf6?=
 =?us-ascii?Q?kUBK1/52Y8u5N6317qXJWB5/1n6phMt1Vv6PUk4KehiUFZiquPxZhwn6PkH0?=
 =?us-ascii?Q?rgf9P7Os9Y4aKtRh8cHZITAdn6zPwx3uRunzzNQV0dfHYVWXymb3snAthH9B?=
 =?us-ascii?Q?03EdYyGQLNPq9hbgvO5qN2WIB41hUEzI3+YwiOQ+h+3OCPuHOU+6GlTsVtOR?=
 =?us-ascii?Q?ZhrqOLpKaRhGdnSVCdHiWBvjOYCL7sF6jsMGbKorSh3hafnzKuGjVq13be5I?=
 =?us-ascii?Q?prCTgo+Hg+/jcBDNMf74ScZ6O9mp+Cj8HwIKk2oArPbdxksKMuK3WJgJdi7q?=
 =?us-ascii?Q?ctcorF8UD2Q8UQMtUj6rCnmT7KStdpaKggpul/LeRcJJF46NUEEVpRE6HU8b?=
 =?us-ascii?Q?+Ai9vJ2QJcQ3oB7SSoxz9SAzdRFOV/qD9Za8JetCgnta5ImZVgDr6HuUGYHd?=
 =?us-ascii?Q?GJiClqt1rGc0eFSzv1O6PCeL5DHKDppx78//r/ocCa1+EKZrT29MUCg7lnj5?=
 =?us-ascii?Q?9npsLsTY69scYK9jrYi3Dzpx5uIRRAx7I6MqO6fzAJhXZtSneHEaNyjlogg8?=
 =?us-ascii?Q?3YgJKImNyCSmHgHZUnJr9zoObHk+QHBRF7/pNhrXpomKDUB8hZ2mXmGjc5Jh?=
 =?us-ascii?Q?FDEW7wIvLLzoZoHf7ufyb7Rb0orNlHr1vBEGTKiDvHsH6TSo+E6h1iuyighX?=
 =?us-ascii?Q?+ANDlHsPAct8AZ80rtaFk/KXB95hk1I95I951Hqda+YMfTpqC0Gh+akIAte7?=
 =?us-ascii?Q?ey6k5fSdOJ26gLYFObf7SrdbQs/ym7angim8T1oNGRDCGx7RGamcAT9+8HVu?=
 =?us-ascii?Q?Tudvs+tnwvBOxcvTRsXTgArAMFISAM5NjN3/RBKfl61+IISG/xtOtGxkUP7y?=
 =?us-ascii?Q?nsEeeX6hIpcZf6nT5LiBPasmmdaKNBf7bAF4ph7Kv6jHufhpj1ydG1bwZL4g?=
 =?us-ascii?Q?ieOoSenWz7LDW59E/yCEaOfmDMw9qRPJBL25rPV1w11fjY1nXYKJKTYIzg4t?=
 =?us-ascii?Q?GieHOZIpy0EDIBVXIKDAKJlyjiGLtv1hBgSRJ+ixgwl1lOz66C+52sNDyVt1?=
 =?us-ascii?Q?VayJm6g3ffmI4k2R+b0sECZtt0xcZDkxfsp9wQozkzD9XUBVeymqOAiLCmwK?=
 =?us-ascii?Q?k1WQ6WKjWE3hdY6mXMcecMft9/m77mPwyc/QcEcYAueLhVKvcSi2gYtQCZWN?=
 =?us-ascii?Q?HQNvSCQR96RLFihZMVnph7bnEITubdwRerxVSm8FVar1miQUIanTB10qCWSu?=
 =?us-ascii?Q?aarMb3GADTCawgA0Kit2COWzL4oS1YBBDVakwIhdXL//h6UxM9oPj1bEj7NS?=
 =?us-ascii?Q?0ukgCdSgernpt+GhbCZo2i/S8ILbge3njq7RgZ11V6rnW28EE/0ag0/YxJ/Q?=
 =?us-ascii?Q?U9pN9CtFjvzGBUWFs+BIgukX1jHGsHwRNaK32DkntXcx2Wl9dT/4SpzWW9dk?=
 =?us-ascii?Q?9BdB5T/x6yS+2j4Qol7DMWLwdkGKuLGGNcnUN12djSHY7pzPILoNDQDhwbkl?=
 =?us-ascii?Q?R+KsaHyW5pf7V9F+vnQcOHABWT/TG6/rBpQ77DUjqeAYSFR8H09+g6XW//In?=
 =?us-ascii?Q?8/9g43QiT5VNO3deTswxKJH0ayhsi+bfy9Fzr41G4OXZbpEfDfbWXVb5jPnt?=
 =?us-ascii?Q?K08weT5JhIQxmwBR2hcRnAzovYrQFrXvSZyi1YDqsLuWA1y7q1ofH+MUktJT?=
 =?us-ascii?Q?BgVoyKJDZVp18u9+OncI2A+xj+iMCcY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476b6af8-f36d-4bd1-23ec-08da0e7a69fc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:13:35.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wXiGPqfTDNRNEazn12HEPPRyk2WJXDslqmHRP3Sr5f05vUqtRRSBb2A2QPv/HITN2+H9P/SazRuPBbD5WHZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

This patch expended the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first MPTCP sched test in it. Use
sysctl to set net.mptcp.scheduler to use this sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 888d9e9b8870..c654df1141a9 100644
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
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_first");
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

