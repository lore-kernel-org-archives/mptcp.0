Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05762F38
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647515123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4S7jculaTldcqJjJXmc+XRXuvqmBElCqfCGU7sSGQ8=;
	b=S9Ds7qoaPEEfmMqapSubfTQH5eXIB8zC2TsELZHOkuvRfw+oK0a5Qq0fw3yBS1jJzJSMpL
	ze/dkeOZbByIXf02yj7abz2k6qjDvG9K9KGce7tFD3FKlzM37EXO7CDNdsMNrU/KE639f0
	53rDb7b94YA5TMmwN5JTjG5lyaAVgi4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-L4MBeY0iNUuJXi7IuBwPZg-1; Thu, 17 Mar 2022 12:05:22 +0100
X-MC-Unique: L4MBeY0iNUuJXi7IuBwPZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBNKkXt6diRI/ROILQqp1dDl6fwexoT3NBOrBSNwVWJXXLqU2ZceZRVLBzCcHpZZ6TEmm4XGFkE8YB5QDgX2g242vn7PMm6k4TzeCTwREANlso+9/TgzlvsIJ568HLtnVMFtOUQbni+d4kzdnsUoLkFiv9SL2yeoi91aybtMpliNum7aNyQrvVYWd58qWMp47t9OH8hYpyJq/s4dm30GNgAKfuZckF6Ck2CP1xF0430xzJFMfRcJjINf13oLP8khkK/zy0njr1lsBNWoGLvLy68wa3R4rWKW+4Jaw0oX8ExJDEVnnPortxTnh70jmH7Hsgu96yX6YlWVUFNbyDYDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcohmn6iGS4c9uI5OJVZ0eOmojD99A+NG2U6qzT2nQg=;
 b=SLCR0a2SFhaDibV4DsD25zZf4kMQBHNGVqpfqMqbSzFyG/BNUYrGfp0LH3IKYa2BFsJ+Z3B2oecQqUSDJavvf2rELiRLer5FIgKHAUVe/wiOikKoMVQL24ugv1E5k7l/86C81aK7m5Hfo8Xcx694qlFONoh1tlzlNkwnqXOlqBzvhr5/S0WC0SDQFA3673lIcHk9hHEfFayp88lUdBRvcveNWeiiF4PGrtFs2gPu7M4dlEgL+sqDvru2UhtgzHpAsaXROlB4l8bue5ya6X7O0UMRbHeZYvE/cQCWJKRdDn0QgX5lDia9CNGfsZOXx7Em9513/DPQxXQgtbPTC1RxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6256.eurprd04.prod.outlook.com (2603:10a6:803:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 11:05:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:05:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 5/5] selftests: bpf: add mptcp sched test
Date: Thu, 17 Mar 2022 19:04:46 +0800
Message-ID: <7541fe09cf06706f5de855b0c7b62bd0cf5de444.1647514852.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647514852.git.geliang.tang@suse.com>
References: <cover.1647514852.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0171.apcprd02.prod.outlook.com
 (2603:1096:201:1f::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2876558-68d0-49d3-9587-08da08060704
X-MS-TrafficTypeDiagnostic: VI1PR04MB6256:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB62562CDD95E7CB3D8DD49CEBF8129@VI1PR04MB6256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RXhsk+9L94OMOFENurkGuO5jzwv5nJ3G5D26mbazMYs+W/CRPRCX4iOpYvET3DgOJ/bJ0I2PEP6t+tu6TzK+KKRzXuvi6svMxEYpOoZNBaRlsNtOj6PxZ/rCEZONbukZ+mneTqFa1RIz1N48vMoU6bUxHcvEVDcMy87V3INujkT/MaXaN1tgaxHF0UpF+RqfmtqtERc+B1iWYXYk6e4wQMICMjGWYWqIOqANWh1OyK2hX0UrzpOfWRkhpXR5K3JdzFQetHn38AzvWCXJw3xgVxJ2LZ5G/36e/eYOc7IzXnh64EgTHyjVP2tzWMM5SXE0L5BmsVv+py+7GMkEfraltjg/Sm708iJpOKKX9FIuRszkLxshgaFIL4dQ61o9lbjqkHcQ05BIDAfBOhKAGVL/38tuXDFLVFAe0O5kKdPaYkDMWKqiqPETLyFy7xC2QQ++rKDlnmYBFUcHRRALdodvUXI2J5R9EtD8GPPuNJtFyXm3KV9IYgaHOsBkAV6AZCSPGWybSY+sIZNEPecMYX4VABhB7OtUd8bfZcvlj+tWs4Li7dRrcVsFXKeKtTqb1T+kIRiwVTWzBHbf4m7LbLs3hVOduegbIBlUXaFZdcn+btAiIhoP2oYHfEje9ansNLnc91BZQ9a0SBTjxh9BJI2jeOChXX/bDPi7qJEWGZo+eopccdif3g2UnKAJ2pNvToMuA5rxSbY4BvhaqfT7R/OyEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(8676002)(2616005)(107886003)(26005)(186003)(38100700002)(4326008)(2906002)(6666004)(6506007)(66476007)(66556008)(6916009)(66946007)(86362001)(44832011)(83380400001)(508600001)(8936002)(36756003)(6486002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tDtR1iQLgrbhILSp6pwhbOQE17pnZGVHDo3FOZIdT1pbvwg+N/IBoEFRRdP2?=
 =?us-ascii?Q?cMNuCrhB/B76AoOrrBiwDIYelYIlSBZhqLPh7dS4VM6ptE03dkTgwRmjiN6h?=
 =?us-ascii?Q?fXQEx2XXNW4tXqIc9A6KRrTO5q6eEsNJ6QotzA5hGI7b1elsE0/pOqoSs1ZU?=
 =?us-ascii?Q?24vFKETWZWaTbFnSubNMH5SiJGEKvFma1pFtyY4XKQmfRuXkrUtPgTVFa+ha?=
 =?us-ascii?Q?X1otgDy5blQVVspuOH68gIQP2n2CbV0EeibW8qIUTZ8Hx19sjhKpjBwex420?=
 =?us-ascii?Q?OIdh5M8EE61EPry3du0pLC61tv9Ji9Gl2BjmNUI8vaT/l/N3pcggKVn6ouAF?=
 =?us-ascii?Q?7v6Xw3E/6EsO2qso0tY+7+nFCfilB8epy8J30UBYzQpAuPiRVy8mjTD3bXGQ?=
 =?us-ascii?Q?9WFzTinkiJcwRtioOppdZfDa8nLYuxttRY4yqj0D6efhwtAWexxghx8L13Tn?=
 =?us-ascii?Q?ee0WcFCxI09VT15LVm4vx0Yle9n3gz+yBB9YrFBIDJ6F+mI5/Sjcon/XMaJM?=
 =?us-ascii?Q?sxZ4/Kdb9CXBiRc5a3U6L+rsbJIHuf9DZMsJlP8LEuLsJMeJMS6031mr3eSJ?=
 =?us-ascii?Q?Fn/6l+wlajQ5+WqsxQAsKrB7zG/1x24WrUUcX0v4Q6mj9HiN8JESLvYWXXD7?=
 =?us-ascii?Q?gsXIGBb1D10osYRaCuU88V1vkWreuZEeBVe4IA9lFxVh02wxSejWC+Aq/41j?=
 =?us-ascii?Q?HbD4g0fNKQ4bSGqp3XbeTs2iKF+z54tB+McUwOeuA/comMDSSJ2leOjPPHJW?=
 =?us-ascii?Q?bo9XAPccvhSQdieAHZOsgXjHjrcL4WbZgWdGDb1g3AkeLGCB37M1UdIeaDvX?=
 =?us-ascii?Q?uscVwLjE00Q5mxSzkMVfPlejplW6oRGQ+bzCIrSK3sBRdBatooXmPAY67nnZ?=
 =?us-ascii?Q?lOiVwHcLVQHZpyVc06DydoBVqyOXeYgZEOZWBYykUaI66juSSdwgr1EjaOcG?=
 =?us-ascii?Q?O/8jW+gSpJCotI2evLzpQlD1OrPCkdrTd9Z18E1P33JmTCWQRJlel4LpaezX?=
 =?us-ascii?Q?FtNYfIuwVmtgvgVcOCz1iUiXjX1RN+Gy/jRm/eXx61UZ2BVjK6pZunQbej9s?=
 =?us-ascii?Q?BdcyvR68DTVaK+2y+CjkhuJHCue5zMhf7JywDkb59YoyKuv+Th+GOtcjtwNM?=
 =?us-ascii?Q?OmMb0kBHLNeyJPy79Xhw+BiGV88EgEWooCC0meWVDbSAOBKT2fdxoiOETX+s?=
 =?us-ascii?Q?Jchff1CgEvObSoG+Ts8Ie6z6xA2ALac4Rja6WbYLUfksa1qlqhqG77BmUCFT?=
 =?us-ascii?Q?1BjCq/S92aQuHwaZcJDH59C2agPQ64pUClZsTwqKdFGHzs1PdapGza6nrB4o?=
 =?us-ascii?Q?3qhb4X19q7PNg1eihOyDjx9kb/Q9gpbwi2pwqjgb5PiHV94MSy/14UJbH7j/?=
 =?us-ascii?Q?Dw1fZZo0+OZJIWiXne2At4E+v2vAeDD8x7GcotV2Bd1IZrOcZa0cCBi1fSva?=
 =?us-ascii?Q?86sldKM8KZweVvq1aBa3KSW9psGvc6HxV+wna5fNVGIhM808a1Gwug=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2876558-68d0-49d3-9587-08da08060704
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:05:21.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfN2oEF485G+RgDMueM2YeT70lIPr+0tpPtCA1Xwbfyn68KSuMEluR0tg4/9j3JaIkDtbGUI7nIjkQRuNB96fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6256

This patch added the MPTCP sched testcases. Use sysctl to set
net.mptcp.scheduler in the tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../bpf/prog_tests/bpf_mptcp_sched.c          | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_mptcp_sched.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mptcp_sched.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_mptcp_sched.c
new file mode 100644
index 000000000000..b351ae260903
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_mptcp_sched.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/err.h>
+#include <netinet/tcp.h>
+#include <test_progs.h>
+#include "network_helpers.h"
+#include "bpf_first.skel.h"
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
+
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
+
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
+static void do_test(const char *mptcp_sched)
+{
+	struct sockaddr_in6 sa6 =3D {};
+	ssize_t nr_recv =3D 0, bytes =3D 0;
+	int lfd =3D -1, fd =3D -1;
+	pthread_t srv_thread;
+	socklen_t addrlen =3D sizeof(sa6);
+	void *thread_ret;
+	char batch[1500];
+	char cmd[256];
+	int err;
+
+	WRITE_ONCE(stop, 0);
+
+	snprintf(cmd, sizeof(cmd), "sysctl -q net.mptcp.scheduler=3D%s", mptcp_sc=
hed);
+	system(cmd);
+
+	lfd =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_MPTCP);
+	if (CHECK(lfd =3D=3D -1, "socket", "errno:%d\n", errno))
+		return;
+	fd =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_MPTCP);
+	if (CHECK(fd =3D=3D -1, "socket", "errno:%d\n", errno)) {
+		close(lfd);
+		return;
+	}
+
+	/* bind, listen and start server thread to accept */
+	sa6.sin6_family =3D AF_INET6;
+	sa6.sin6_addr =3D in6addr_loopback;
+	err =3D bind(lfd, (struct sockaddr *)&sa6, addrlen);
+	if (CHECK(err =3D=3D -1, "bind", "errno:%d\n", errno))
+		goto done;
+	err =3D getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
+	if (CHECK(err =3D=3D -1, "getsockname", "errno:%d\n", errno))
+		goto done;
+	err =3D listen(lfd, 1);
+	if (CHECK(err =3D=3D -1, "listen", "errno:%d\n", errno))
+		goto done;
+
+	/* connect to server */
+	err =3D connect(fd, (struct sockaddr *)&sa6, addrlen);
+	if (CHECK(err =3D=3D -1, "connect", "errno:%d\n", errno))
+		goto done;
+
+	err =3D pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
+	if (CHECK(err !=3D 0, "pthread_create", "err:%d errno:%d\n", err, errno))
+		goto done;
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
+	pthread_join(srv_thread, &thread_ret);
+	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
+	      PTR_ERR(thread_ret));
+done:
+	close(lfd);
+	close(fd);
+}
+
+static void test_first(void)
+{
+	struct bpf_first *first_skel;
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
+	do_test("bpf_first");
+
+	bpf_link__destroy(link);
+	bpf_first__destroy(first_skel);
+}
+
+void test_bpf_mptcp_sched(void)
+{
+	if (test__start_subtest("first"))
+		test_first();
+}
--=20
2.34.1

