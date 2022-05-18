Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1811852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iF4JmhbNlrw7eZpQIqhnOyzOBRqL9Hx8YWNatO6xaU=;
	b=c8nAN07l9QRxzfxmH/g3lwpkInyUHT6a5bAds2i26UGur5dgSSUxwakfdF8TuW3N0VbhfZ
	JVdGz+0b7AFbEMj9DP+Lxbf+mIeK/oS0RnLpDWoVCWepGgsJ9A3v5Vfcc+P6UCrKVikIiZ
	z2D1QaF/SOoHcqWj0EOmC4kJ14EJuWE=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2172.outbound.protection.outlook.com [104.47.51.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-cGEDmeNCO_qdqS9GmJKA-A-1; Wed, 18 May 2022 08:13:09 +0200
X-MC-Unique: cGEDmeNCO_qdqS9GmJKA-A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNNpdF+5U/0JmqyYxMPn9p5YUIjbFuE8HJAfTsJtDCY+8qhL9CSVVnYbK1yciFgN/ZqHbKvrJFTOnbkSTNKZIDrOq5gg7SDyndpeZJHx44TGmO6GtX0xMdYQ0PjLFWqso4wdztktCJXuA4Cu+hf9DIXLRDzPXtS8ZZqRaHV9VkLtLm2AMRCcaxgsvcEysEG5TEbd6GHDmBearq7M9XYR69IgTF7JzuguuoYatzSlDbssQdfl96qJZcar614RIcJxD0m2I3j2PZAADW1uVjEbNZQsQ9/6S0nqbddBrWQTg7HObjenM3vr0Dy557USPXpdb/zNY7n5GkYuurkkZMQSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h/tWP+vF263sFBjbitwrKEoI6GCgUnP16e8Vli6kt0=;
 b=k6ajylYKmMunnGEW0NX/v7Gyw5AFk5GKQrQM8GxWwvIBdXJBaR6JpKl8dhM/rte7JbsyjDsfK7m1khco25iw7ZWiz79VSrlcFGr8Hb5L70AH3vnU8H2vn93/wFGc+Aqgbq7xJZO4W/XMgQ6OLPRHvF0nWXbF9je7LbOGUodtsFIB6CT3fsQVx+iBDKBV4KC6rd5bbRAIdR1Cuk+EAfCL7Nx2exITF9uwP5Glt19ldkDdIHspo13vkd9V1aukDAxOUTNWpEfF31TrSNPQKS5SyYMEX/mOxGnT2mZealpgM5Zj2z1XrFnr9Olc53EiKtYvTqd4EkJzci17n7X3mOzTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:13:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:13:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 17/17] selftests/bpf: add bpf_first test
Date: Wed, 18 May 2022 14:10:55 +0800
Message-ID: <04d7a1dc53ba95a0900ebcae266661ff97a4f6a9.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d2587d1-3bea-4e74-2f24-08da38957a14
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB25843B936B3795EFDAF048C4F8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wQUHKlaHzHuWBr4qIBEt+/xCEjW+DIB97bM8Yq/+qSLBEVljlVANjAM98sbRmdAkF1cQ2yS79Cmk7PzLUiXXnnv7KOtfGrnuxQlE4R1EpFm2dNqVTlVM8P7XyTsRigayzmTaHnXQnaefmU2kzWwUjA4e1WfE27GIF93eLi3T4QXFeTqXgsrjzTclw9NUyWvHIlfu2huc3/GhQVS/GrJYKv5n7hDkX6dSIjh66Y20uKlMp684T+sOh/l1xpYYocgmFEbKMz1ZRNmKwdaMCDJX0kw2qYrHbNdOT2bhC1MD3EflwnOjzStVcm+9q6hy7RyMFri1G39xdEoThw6A6zEoE8b9ppNudheb47ZxUJoZEDV4VxgWX4c7x1Rd/svlBHdcWStwXGlcnbvwaHCB+jl7SjAkew8677Q1yuHow0pmn5wrhjl4VvJApUDwomAPyGcKjPuNpChb8tK3sJzr2wzFUEXs+MUPMXjgHJUF9KdYqZ6N0Uplg0hRwbPVWUY9jLRDZ6OGbKpZyGRXQw8SOuuNpf/MvQ6wH35qwCEeEgICNWKFE+pAeJDbM1uKXVlWBThwA9FrJFj6fGvn2Z0WPkaYFd4ZS5t3bUz9HbIZgnRfR3K8co3GXodS06n1DgUUPJX/c7aRaWGuOZaAr7HUVEFK6ow8vpV5XLQKLyi+DroQXNTWUN/K2nG0vguHRw1uv8TT910ODWNQih+VUuRITPoo2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(83380400001)(186003)(6506007)(6916009)(54906003)(6512007)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0Z04T500s04t02yc38Sqf8kxCI62KQQtfEBu8oMd9FAbixyZ5nu7ipotYNd?=
 =?us-ascii?Q?qPKJF+nkv4A5LfuVTQ0miLVwMu/2PGo2TDScawR0fj2PdS4IMqEUlD1A+058?=
 =?us-ascii?Q?hOAeHNvjzLU/yD8VDYU7pMzmplYY0BejqSLlH4tqKy7i238yAV7qDzYUKKQ9?=
 =?us-ascii?Q?MtcoFAqT6gSmXNKRANG7Q3fibSRMWkiQ7vrNfxcHoF+ITdo5FNm3N/LGNpHJ?=
 =?us-ascii?Q?lJKlRpqik3BdB9MnWPw+0gTAPK/l5ozw8Q2MJnQO3/tKZ4J/O0HSTbjSei1W?=
 =?us-ascii?Q?gzsPFQknv2xKOCDrfW5pyirSDodzlMDCId0Oc9b4pqUfuwOnCFD2xCoum3vB?=
 =?us-ascii?Q?yezxheomCokZEy6jnZdQikJfJgqcOWKDvqWyltOYoQZZ7fKnALv/dqriCLbO?=
 =?us-ascii?Q?klDt2yiKNKvjnbqMfydcCDrXXUh8NIq7fe8dX3sfundTWWYWn+0PcUsjjqF9?=
 =?us-ascii?Q?otuuLyNF5UUNm/FjU49LcNrS/ZQmnuhMJu6YTUigv3UNcM6812yY2yy2h6qY?=
 =?us-ascii?Q?quz9XrSr38QyH7UCit8yFN6f7e2LPM+Ec1mv3vA9Mq0WhHSLtCnt+4qcRfUC?=
 =?us-ascii?Q?NqgDdHe9NF/VyOz88AAMMruA7YPpzD8gyVL2Gw5DiYbZRWI1Y9eXIr2ceLuQ?=
 =?us-ascii?Q?uTT/aDSJnUx66RH4FTdnWJLMT+YgpfO9gtK8ss8MzRq6m2hOnbHzn3M0xJ+G?=
 =?us-ascii?Q?xbTLJeuhd0Ue39eg46xFwpTey9Phi1Mn3mqE4n8hv8O300sPoT72e4y4X5r0?=
 =?us-ascii?Q?YOKDjKKeqJ6VE8pKZa0DmqcO29QgEjNMYne/zo8fdsnR1oxX/GobHvuE3IcD?=
 =?us-ascii?Q?8hHY4EPP5HO33Wn8nBRObzv3+lk2/aP8fFHkzqas0jr4vq+uA7FlS5R5aTXB?=
 =?us-ascii?Q?kDyiAmHMukj8kWHvRGSxdiVM4rVdRdlJ4lT5JO9kZGGRkjcqivf7/Li5pTxf?=
 =?us-ascii?Q?+oChbKdJm3wFihHMx4+QySOSd0gflH4C1RslgWhP+bkm12+3MDEcvdSk65bt?=
 =?us-ascii?Q?1efL8pzFJHys5cfaVmyrBR8Aam6H7QsC3p7hbnjvCaBbTqaxyuSJZezmLFwM?=
 =?us-ascii?Q?FGpEzOWmByjRZN/8hUMIteYKcUEsNYiON1VAIeJOHTxsMMtPIM72XS3z+Y22?=
 =?us-ascii?Q?GzUIbkY3LQqOgquD7xYQ1OJLelDQYcVBwIdSN9gK4Kz391PSugQW8pOowo4N?=
 =?us-ascii?Q?zrSb4V1Yj/ijEjpGJFulItGRcFIAWltPCxiH+oF2DSO0kLerbMfOht8PG6PA?=
 =?us-ascii?Q?A5VESOraEfKh3hqA35Dp3cCsUIKkKOYDpQMFIfOgY2LwwVYxmSibMKhXXS8J?=
 =?us-ascii?Q?/lDgJIsFsglLZtflc9NXOWzuA4NY+u/jwPyz5YX6JmpaEUvFKD5eZQZ4FUFT?=
 =?us-ascii?Q?CEr2jZrWbZ6T+R8H8W6g5XWjulaYuHeIsVkUEVveOq28i1wQw6lY0nDLWpcN?=
 =?us-ascii?Q?3/AuTBrd2FjnVCtdEwnjCiR0cQxFGT/0iS7OkqalOCYkbUIMpCR55GFeI7Ss?=
 =?us-ascii?Q?2uoZxs7JmeHn+ZDoSfYukwZkAo7u28ZTX/Zt+zWdeugvTwtMFjjBHc13/Q+y?=
 =?us-ascii?Q?NEtbKFQUkKAq2hj2dvMUsF/MCoqqpoeu9iVJ8I+i42aO3nOgRfQDwldA/EPv?=
 =?us-ascii?Q?gojdCfHuhLNbBwn/onaJ/S9w/tzSfdpAUKPrNwFoe0bbCnV3AnMb/+aKSqsY?=
 =?us-ascii?Q?OSJ0ufPYWcGgKyoZDb02IXHBZ1G5DN+NdwVQUbvpFkxC7phpjr3i77AKRYqw?=
 =?us-ascii?Q?6rQqTxRRUBX/VN4ZqMgOdvpVgQD7XMM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2587d1-3bea-4e74-2f24-08da38957a14
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:13:07.9053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBv9aPS8TJZxwl8dt/BoZe/oMy7MaiRqG/xN8j0waxXDzKpN0gUPDybls/eZbKZWSUfLIVd27hldSOXDPA2YYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 257a8668ad40..9d37c509d3ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcp_bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -20,6 +21,9 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd =3D client_fd;
@@ -167,8 +171,118 @@ void test_base(void)
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
+	client_fd =3D connect_to_fd(server_fd, 0);
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

