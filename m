Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A015B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7zQKCn14xxiVLEwTVTt+pl3CZZbVbDOCIkUlcCRSMM=;
	b=HTEE/vL6NZK61B1Hb/C/TdfPlmsVLpgdDZIwdoqiCRUG0NfQ23dziDu242NJfmVuvnGwMy
	ksu7GNP5mT3kUGmPBpOegkAoMeFpLeKVyBkLg2chl2Q418vWdUfgJ+qT8uF8B7K5xMO/Bj
	by3NqCpuclB9TEFNGtZxgDaO734Q2v4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-ETxCLBLQOLCiRwsxZRQMEA-1; Wed, 11 May 2022 05:41:24 +0200
X-MC-Unique: ETxCLBLQOLCiRwsxZRQMEA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpV63D2fyHAb0AOcWPFM3A7cKOK5ht7882OH6slAGBUeRPhHVjpSzVSnmwFzafdMyZcsh7xs2PzouwDTsmsnj4pxLOIi6zZgxqdzjsi0Ar0YaMNDxwi/UXKY0f+G9rCLRgHn0seKattPTIO7gVf1b9XLkwXFmcKvqIy7YeHnoElhQqx0D9C2gTmtVcSr4TP9OYTmyo/86UGbtWUezFfWqopuaOeGlyhKcKgaLZfZFWl2+alXf6/qT4CzpxzDii+oMIiosU4Y1UPWhEf7t4M8PZtlb69fXoYO20oJRlExTkPvpAp+mYHqVeRgig83IJKFy+BlTdkVwMsZ1XIlOCbQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCMa2tjPOfDjxGZRa7gSwnyDial+zK8DZhmU3DmXAoQ=;
 b=OZk00fKNVh/it9O08Dn4UpCukjnveOyjJISQGAyEPIWcVnBQcQRCoanAg0cM2mjO/mS9NGaAhCBpeMFHNJWF2JePH8kAL5IFpZTw+L/8D5yHxj57ot7o8FWEn1HvDwyJM/feplrdZetZ9pM/QoCBjAysJWNwf6QNf6Y6FHtbw32nlLgD5VTdqO6r+E6fUECkkrUPe1BMvwz74h+X2dCS8ddy7XINgh4YxTrMa9iR42OpXq9qB1DYXhTuv27sJ89dojrHq26Eysq/P6V8BzKwmW0hbhwKCOmf36mSHEEVa8bdZdmQg5UscZgSZnwFB1UZNwCTAXkunY37cXJTOPi2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:41:24 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:41:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 15/15] selftests/bpf: add bpf_first test
Date: Wed, 11 May 2022 11:39:16 +0800
Message-ID: <b3c9f86fb03398985ea94b7860d9ad142183bd65.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0169.apcprd02.prod.outlook.com
 (2603:1096:201:1f::29) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58bf02e9-d5de-4fae-8cfd-08da33001ee5
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156E40D74B81C4BEFD676E7F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kiaT2Xv4GY0Ydqe9cdckF50nDvZ0wEwj+utG+ooCtgjax7UK+TnHsXVKU7oDnmwlHyDGrE0ASYMjNAYKumFh5tXrRx04/QaMdffM4S2ETI98QRLeXHgVZVjearem+BebU+6en0H8WEwugDR6u4/RqezgbdW6TjBwba5Wr5BgQ3maftAuo9f1/if1pmLOXuln/POZUfZlbRk8gZVdybocREDB5NaApX7uB9faWSijuS6ncENpoLU7NJEY1Pkm5F+cJxnsdybBw4OPtfbY9yLv+MYp9rY5txuFv8dEsvcYxZ5V06PaZaNF6eVlQ2bUUf+8LbznKM8lBtrS3ySnKLmzLmhJsWwGmbyg4rv427nHMTvNAzusQInIaSdb5msAywnMH/bptKknV+H6shk0Py86UR6mxQ/KLF59hjS1PoFqVsCxskIAkTZC79Py2+XuMc2ZuaGY8TB0Dn1mH8D3RHlksccvGk426iP4pWAwBcZhz9b1F71F1o9lZS4E5ds4JWmBE2Bb3LwKqdW11hKv/scGDsW9RkvT6d9IcRYwWSpqf5/7fVW9t1gqOyOIjScgipdHgaGvfJ3+WoNzNKSG78mPwdkIkzbAbx+JIRQ7qJeiLe1Oc5PKX0ZAA3QVm6dSIJ5kP20JMgotmHeGRdrbqlxK9AAdDZPGh6iRu4B8oUyzZLXOohuhajSxZz48eN7vPUyC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTNPurqoADgh5TdX+PqBS4xpWIWda7J/6vT4KXYUsyskWFASApOM7MrqNart?=
 =?us-ascii?Q?VndKWuama7B+PCRyyfxavSPanqIMX3UOSpduvFAOkTlj8niGP7PAhIGNozt4?=
 =?us-ascii?Q?mUrCOkTN1RA7iAbHOCXHPBOjA9OOGdg0ROP+qTfkoKY44dO9TXysd/ukIY1H?=
 =?us-ascii?Q?A/jzCd/st7MZTI0m5LGnbIZRYcPbJdjiJyBdHVrXuqMhg6o97II/hSNxo2qG?=
 =?us-ascii?Q?TChrTdtXhlsGDYcSxsCdG0DO47OKTubfwCFoJANDkyD5eA6FKAysf+vttTFM?=
 =?us-ascii?Q?ws5qqtqSKYQL5S1iR+W02b4OPDB3QWRMF/mzsxTTlglQAZSgXhmZJBcey64+?=
 =?us-ascii?Q?GiGnBYUjUdi4at0AZy8PMD7jFc7rBPF4lpUNsp1tORWWrUJ5OkTMf96qk4yz?=
 =?us-ascii?Q?6HiX6zEzVQRN4bTq9nVPvMKJTynaUaqcpOdwQqgR6045uavcqU47jPADYYU6?=
 =?us-ascii?Q?2RjpXM6zhNtes4nYRRqgX8sThlzuX54HMLNOsJSOBSY4yBrQezWP1Nxn/X9J?=
 =?us-ascii?Q?YgscPm/+309OWXIupSt8WyshEE7mxEmJ2/w0JLhAXZ1qFAzcsVpb/z3d3qjh?=
 =?us-ascii?Q?iUaKh/8UOI66s9EWU+lDNPp05Ei4FXfy8ptLtDGTAMUMurZBTa/ttS5976lr?=
 =?us-ascii?Q?lMigpc5t3x3RAdruhTClfHwlGGA2wQJ23c1KkB8QwqFZMrq5R8WDoHq9Ur1P?=
 =?us-ascii?Q?9pIOn4jl3+7raXPjSIegDk9Qzm/WH28qAkHY1UtBCMjnXqUABMG3PPu2iMEu?=
 =?us-ascii?Q?YK/8va8OEHJ8U3tFSY8sEbXUQ+LUCA7R0FuS+nCECNztuLTgpMbKCDHcF9N1?=
 =?us-ascii?Q?+r8cQ/d73kls5jNtpeIOBaHeBlZ8lz+G4TV833trLgeY5jzMjt4L0kGX1Pki?=
 =?us-ascii?Q?/W//g95CKP2BZ45axFqkZoXh+NY18nWBYOu1IowB6oJQ4im4xspi1Bzmj5Lp?=
 =?us-ascii?Q?iihLr5jXrlUCLYWSVkY12mH3Kul9bQIyiBYuCL6SS5P2MtXcE4MwGNuffVZT?=
 =?us-ascii?Q?LRsNXPUWJCaCOWjQlW67dFpTKbw8hAUf06lsjI1zveNBwYndXUnVqiAY9wnN?=
 =?us-ascii?Q?h0qafAqJuwWV8Xn3OOS0S0CEUuF7nqywVXfvc5ob7/KeZqaQEvtZl20xhE74?=
 =?us-ascii?Q?FEZzVRgluFVC+wJ1+9JV/Y0Hdep4T5Eforfv237TdbFo5PKG4Q/Y+iBDWsRB?=
 =?us-ascii?Q?HZCAljoVqoMOuytdRa4qtQwEB69rMpb4hR1OHa2l0fjGmAhzOIAwCLwoTcxJ?=
 =?us-ascii?Q?8sk6wU9GHY+CnytBOoJowQBNJDIFkezIzdNBTCWlUFDSjFQuqmZf9Ur8p3Sq?=
 =?us-ascii?Q?/a7EbzesjbOeShCZlrHnYIKL66SQcyOAKRBYN6cRVZgKR/bkoleIgrb1GCVu?=
 =?us-ascii?Q?VHgt8TUJEv6GxwaSPeIMv1/ShhCZgFiTa89JoUbZiOgoiTHbSFFEZp0Y09JI?=
 =?us-ascii?Q?6Pv2CHrmoSYYL9H7VvDeWqPCPGz/pyQ2kG8Pd/UPy0szyl0V1pznHgGIpEbz?=
 =?us-ascii?Q?P2r0ahV4xNv50BiA2m2pAQNEc5G6oBJAUc3JIpa+7nWifWKE6EbPFf9cj8tO?=
 =?us-ascii?Q?5S3Rup/QXcJ6AvEmdwk1TEwTG9Uhct8pl/Nmwq3tWkO0V5XOk9ETBkKmLZU8?=
 =?us-ascii?Q?0zewyZWZPI2+oHvMbEwA3DwMFrXP+4qQlTH6abGZ2WSe9xPoO5VSmMTryCuP?=
 =?us-ascii?Q?IfglbYWZzJM3PB4DP/5YPyzeM7AXVDjRnlNxDEbKtaWwn6GDru9OLjoxOl8m?=
 =?us-ascii?Q?m5G6RtEyJSAo4Feu1cDVPoWKaHJxKQI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bf02e9-d5de-4fae-8cfd-08da33001ee5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:41:24.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljIBuuLP8b6dvVluezesq0thDh4MKSuajOPYtN9hf5OfISh9iKtn9xAlkUWwIKHvNN4y6rV7x120f2FLmrslAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

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

