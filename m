Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D520FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBnnxMsNIvMDz4Kz/K1v5EXx5ZLasSvdZFAEktJq+P4=;
	b=XDAW81p2iMXiIJWhCiYFFZkbeA4evtePbHq4+ppSGSH96yevNRWGgiq7T5OR8ViX21uLhN
	qn44gjraEY50+7hz/4R+SKczOg3gggIej+gCgdsb6DIHj0uXM3++2f45di2xc9iVPWjqjz
	TbQqPougxgdLbwYbw924gyTajofoFBI=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-U_8E7-7PMSGv9x2LUXdBmQ-1; Tue, 29 Mar 2022 09:10:29 +0200
X-MC-Unique: U_8E7-7PMSGv9x2LUXdBmQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V92m9Fr8z8FqAyEJAm9N0zYeLCy+6llX8ct1k1aMDsf/OTEPTUkxO5adUYtbhaRH+yWqA0GDdU60kHP7KmYU0/fbyOl7eFUkm/vvJC1//+pbXFPN9AQ2yrgcf1fkXZBo5ZiNHN4nnKetwryI4jt7SNGUKGiyaedv145X99kTSCvcCG+IyrffonuDmBMdpi6Sorb1rUiK19zzyLzGK6/FG9G6OCiylgg66SafqWebPyuwUWqnNTV/L12CbK6/IwlpdppPgoCZyYQfuvOSBw8odoEPabcoe/qntYMPOEgOoBoEv+tnXpIPPnrCz2GGQm4iAW80BbxVFtahrVk2xSCLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAjewwUghJ5yiB7iJ15vJjYmPz7q7hU4+Ycqr6tUtdo=;
 b=LU3CA2+uM+/vIxi5fyppuJQ3j7hGFQRfp+3QExZ3/YRn+hyUuGips7Cm5E+suqbPjWHtFrYPIp0LpXoRWyag1ITQkjQxIAnKMrnWJf7ZhiK3p+BTaQKgWMvRbjw5W3fq9H31oiqNV4nftCI2F2DEAY7bW41hZCggtrl6J4mywDa5t57CMBD06lkZ/QpotKV4tdaFxa4rY96IbpVIz0P1w2jbY5fB7SbkdcKv+LwYon1xGKQ8XdahZwGXMkg2gtqY2ZLbU10Ri2dn9JkS4KGW3IB0gLzQdQcS0KX+7XT1nakL0uEKwDpjek3QqfIvGe5pYrdYudFA1ZDJwCDUf1dYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6735.eurprd04.prod.outlook.com (2603:10a6:803:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 07:10:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:10:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 8/8] selftests: bpf: add bpf_first test
Date: Tue, 29 Mar 2022 15:09:27 +0800
Message-ID: <5ec49efb1dfd2777e779bf4362c6bbe67d89089c.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2864595-c3f9-485d-6055-08da115331d6
X-MS-TrafficTypeDiagnostic: VE1PR04MB6735:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB673570D1D171477E495A2E26F81E9@VE1PR04MB6735.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tid1WuOt4Sd4fgggv6tKAWkZvOXNyfFhrHFZ0+Ufa/BvSztI1trNsuKYMugMVK01yhr56OiG/NkqLliKxsLC24Q2L40iHKVtzhcOU6q/ob4HJrZeo5L71Yd9E7VE1I1MvPiHVVUTc2we469bBvb7diL5iqj8bx0D82L2i5Ad9iYZz7ZeE2sKxHQ+kDGXsPDdmOK4hQ2ONYhQW0Hg4dD5qXrX8pDneOgpuWnXz37hRDWi2W/Pl/WaNTM6VpLPh6ZDq3C9x8z3fmhb/EIN4F5NmnExP/xrSpxJgjeI41p+c+XSBOz6/ORcebCJj8sPjlGREVJrHO3CDJvYyuJdhj/BIAhvH4FcFTy6poe28Qo/5eTN1kGWmo/BCqdZgWHA5P34odpSm4KgmgC8nSsoOD2+igqVZi5Vycj+QRcGWZ2WNl+izBHWwZSa7mcJK7k0p9nUByW4hKpER6ubojGmfwW4DKIm4fHwe7R0QeMcO3Bp/4Mj8vBz8PAOSbmLv6zykmZxeA5O67bp9QxAkstPmjbtkEarCyNGaoLbARBw/ZPFujbqqL6GYhseqSc0RuyQk9ODig+pJ2s6h/ZMOMiDhWyh0Br41ean96SKEaeo3qRlYYm6TuWO4fnfeakGM5w2puEPF964qee9S3dDmvu8x99hxi4XjNVYN28w0I7ASz22fpTSIPhLuuFOnx6nzq1Z6ytB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6916009)(86362001)(8936002)(8676002)(4326008)(36756003)(2906002)(6486002)(508600001)(316002)(2616005)(66556008)(6512007)(66946007)(66476007)(44832011)(107886003)(26005)(5660300002)(83380400001)(186003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pkCey8DCIJURV6PL9I8b6SzSg2WT10tlcf/1rs7KnnIey2kGHZ12RlGg5lTN?=
 =?us-ascii?Q?AbGfGf6euI6AldFPQNDqcB8IKt+we3M4Th6uskyMGL+x9vSMcjsGyWdrFReK?=
 =?us-ascii?Q?3Kpl7avsNEjOaDXq3ZJ4LqndKPBT/SdKFbX0r+FmWMk7fkszCdBRjTKlvbFh?=
 =?us-ascii?Q?Bs4a0oMscEkv0YPFe0Rhu92NKZsh0gupsknUieqCl2M50zkxc1xx8Ri1Qvil?=
 =?us-ascii?Q?MaPWx3IyHayTI50X6JNiWvAfp1YHLZLfx1z0MRiEK2FN6bTGEpXQpMiGnnCu?=
 =?us-ascii?Q?PfQFcEbdz5tx3YF/R/n05A289BmQyIm5zt1AHF+Mh1PNJFB3n//r5dqORJyN?=
 =?us-ascii?Q?ij0Ayo8ePH6w8OLT5bM5sapgzCvG6GYnkdPMydOt7GjglSLvYBHPYOJT53py?=
 =?us-ascii?Q?b7YCE8VCc7jpCny6DKU4jcUdHFgcR1IQ94dLhQRFN6qwNbQQDOtEgj8YYWWt?=
 =?us-ascii?Q?wKz2acFp8HjjlmT5lQO004hiX5qZIvtZ8ybqr2rluisqP+ZsUCTad5hjHLIc?=
 =?us-ascii?Q?epw+cJ/BH9Qmc7fcetu/LhptW8a2wzyLq6uQwxNrzQK3zNecUuanGk2E9XTn?=
 =?us-ascii?Q?Vslf/EMPr3KDh0sMf1+GQ66rgShDJqSsdWPg4CRelFoDlRB47HPmmsdyKW9y?=
 =?us-ascii?Q?TACqswPSjUIE5N7IcAXEwkdOEU0SIrfU539cmwIJBYRojp9CqJ+3oMqqXS+Z?=
 =?us-ascii?Q?fZGI0nrDkp9m1797RhzGQHZ03i0NdCmHyOXjlsT6c9i9l5Gg9Vergwi/2yR6?=
 =?us-ascii?Q?tIUpnlWwBPXJ7/YPjgdd6+WLznxOZ4IWON3enG1uCxZ4s+rpyyTUf2nsoVBQ?=
 =?us-ascii?Q?B9N6YT+BzclxpsjCUzFUW5ebDa7GB8PWnfQPW+Z4k0H7tfHZMwNOae8C1ah1?=
 =?us-ascii?Q?FnVMP7VGnFD9b8nCn2IfRBfBNI8eXM1QNHZI6Z/ZQB7TuCIaIwi/LZI3rDtk?=
 =?us-ascii?Q?j44JvE21byN6gsvgIn+FVT4tbhknpvchNYoWbjwoPnah8+xei1O9R/UXljKX?=
 =?us-ascii?Q?WySxQUpxTSosLh1QA43yThq9xbK2+XuzzQJ4VGOYeMaO35WxD1ngmIKh9Syx?=
 =?us-ascii?Q?GmBbTbE232tF5QJBnisgSIHCEymHoEJdF01FtUOzKfFi74keHiP2lB5ZzcNX?=
 =?us-ascii?Q?st4I0S6j0RCWwQzaHWUx8W1heOrAs1IdlNQiqM5zxO9rMX1Ruo0dw0rFxE27?=
 =?us-ascii?Q?TPIjQzcsecOMth/1yBf2xOeotlgADs7H2XBeFWFQXmJ+B9N3w8w0NdC3ixlB?=
 =?us-ascii?Q?2fq6UaGQH9Bx5IJPVW1bo7K16iKya1d1+b7l6+EIc7YQLYwp5tecnh4Z9yD4?=
 =?us-ascii?Q?2+RJl0aiBucl7wxecKvCM6M0cYWUoWaaBZd81LNrs1P29oCYotc/1mELZ/JM?=
 =?us-ascii?Q?bESSAdzqLch977He8wHuM+JBwYBPwIxHRhH4GO8GpLrxfs3rWu74wwGff8nC?=
 =?us-ascii?Q?wPG3wpxR3loqAiLP6TlLcK3IXSSzdzoYqQAvvqxe20HyhMcmKmSENWVRQefy?=
 =?us-ascii?Q?ZZB58XrwYk1wy3gRElYZRdN2M4Y17IuhdWQNbh0+++h27VUXpslRpjvYiq0y?=
 =?us-ascii?Q?XCgKnL3l9JmO0afw0GwQ1ZFEpch+7n80HLYUD9CYr+s4AWPy31DjJvkvZ5D7?=
 =?us-ascii?Q?O2lPEM/4zhaJWYABhr+72G38E4VWUE+Xg1LaXmZZr1yoFKS54IPYALnoXdKd?=
 =?us-ascii?Q?Wf+5okxlKKWNYYZKxSE35RsuLUxdvNgtKU0FxdIIspgZm8tEsT8tWr+oQJpg?=
 =?us-ascii?Q?s4qkq2Ag7xus+OLMP5Mtb/T0Gt9iwSI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2864595-c3f9-485d-6055-08da115331d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:10:24.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oL6A8RfZATK3fhHW3WaP6lco2IGy95FIF+zFDrutcjJmQYEGBw7FZBw8ENk03WWeRKOctqp9rJwZoQDidhhT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6735

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 9b73ef62ee74..715d1b2d6fce 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,6 +4,9 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_bpf_first.skel.h"
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

