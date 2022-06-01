Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C5256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpG6ENw/8D3PwJ90m30Sg3WYwAOt5cFlzsOTeYTz8Ck=;
	b=fBcBAKX6Q959qDerZBA2eq5rcHz72dldh2JPx5/2Y2i7oiQC+fByRGWpJ2PY047eykL/PY
	kpfOqFJf9PtswxdmCK0XqjNbckQA+ObnJQlGwEdhSGy4tGkTqaB4OlzJZzeNKhwsWVwL5o
	IDYGEFaO9TojHbvNvQVLhAz5uybIQq8=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-yoSEDgoxNjOMyrbMfDJ2CA-1; Wed, 01 Jun 2022 16:09:37 +0200
X-MC-Unique: yoSEDgoxNjOMyrbMfDJ2CA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlVKUdgMdUO9PfNpAGigipcpQhmwa2lSXyz6Pia4SIYrwxfdUygc0ItPl5WvOyDVHKlSrSIRYBAioyFmHXDFa8M+TaYH8jhTRLIPFmWsohzERU7cBnp1PjCw0tIiNF3vk45YynpfZiMqw8hnvPsKFWyRIhVlx8DsDhKmVnOXlmBuC0d3YiibTfZi9qtfGJqv8QjeXdXDIOXmFgz6NLLaMNBgbuozYsCROUd0OIjRrK8I3+qT/V/oPkd5i6+lwd0S14GpA7Gdj9jALRL6/HvpQ5yWFU2xEM8gIkYrCebTHD1g3u6B6E5+aYWFfErqPjGoq0RcSbeKEUL6YSWsQ4hD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GcfFui1g5oBNt3wRa0fwp161zlANUD9TuVQAshuDjk=;
 b=WqCsKHJOHMLsiQ6z7oh8qgml7cL1hKb0k9MDJ1u8jB3Yu3kIkHdvODTCM0iBAQD5SzwvcdhDN6tUiPioYDBoBM228CFXhj128T9s2+35Ech76eujxpNaLnuLb4eP1brm1begmvIU/XQre8U9nHn3w2OV3CpRPyYKiyz0iApsanfNze4wOd0uonn/QDlVdqJQIYmWT75tAG+lobOQTEfJwb4395DpA8dhprIIqDB2wYgvXwlvc8nrRAZcVdEz7Z21s5qQejmdkQAFehv5XzRqEIXGYx0yKgvwyC7ccaypO2TZgpUMgu7UOrqN/sAHuXqb7P2csqMVb4F78IUJDswHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 14:09:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:09:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 09/11] selftests/bpf: add bpf_bkup test
Date: Wed,  1 Jun 2022 22:08:22 +0800
Message-ID: <fd6d2c944b6d733a384011556fe9fd2f0adbc752.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc9b032-509c-46bd-3863-08da43d85be8
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2935:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2935248AFA03A9CA0C27B25CF8DF9@DB6PR0402MB2935.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tZMTQoIF2dwcdDK8yDID79cjDx0JJKb0YUrRCazfdrwGxnb2W4cuMSEF1dFeMtpph2l2RiN2J5l6NPB4oFhjXqaCI4GDn7Eh3nn/LHtx9MlFuP/qjO0aoqLuXOzin6En+zvIBqlvOyNwBiFnsCwErjyX9J0J/XQ3JE7Bv/t+rpxy8KNacmSa/qjZbQLKeWGyHbJZtjQric+jiF86lXX6ckySD1rnw1oF3vGO6k7/xfTYDRJSpuaqnEuo5siwvhfZBDNz7BaQtPKaAhpr9CD+oI0QmdNizpI/m5FqVd2ujq46Hn3qkKa4+cDQkPNiiWBDb27W8o4XeEYX8jiKWF+sZlZ5JQy/g3ihsue+kMAeh3u0mA67irUE+TFb89PulEJDDfzynx1vw0Cj9TlQC/n7bfFyKNmSZHOF2hmreNhkeKE6y7dGJ9rt/nzYgiJIJ9AoAqv6mwk0fzBn9wz9POp6CGIpxQPPkhaaJmzZqfv3EmqJ0t+gRE+322PizaPrUH/OJZySylS+Cl5+Q3cF1077IbBqhWgrd4unxKyvKiKZ6oMhADKv1AR92ncKoB42wvWkL8M36dTWgM4+jjmZgFDVoSwUlSvxCsEKWwXQY9LuHVW8NZrsjloDLjYrhkYINT3Un1D9lgY5VFzhGCMgZ/e0isNoUhRoi0swuBQmiWQgHuxhPn7+knlVTbCVgALZKfla
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6916009)(6506007)(6666004)(5660300002)(83380400001)(38100700002)(316002)(6486002)(4326008)(66476007)(66946007)(66556008)(2906002)(107886003)(8936002)(2616005)(26005)(6512007)(36756003)(86362001)(508600001)(8676002)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nDMn3FpEJA1FnjKQvpG8ZV3TIyhrwNfCLGDWc9OdFcYrC5LpQZkPfkUEWnb?=
 =?us-ascii?Q?vpE3vCloBvGsubeNsYvta1vyg9sRZZ/54FLpR5HEVDD77lYb8Yu9JVeKxv5z?=
 =?us-ascii?Q?/CWvLA1extpiPO1YLlW1v7DZEg3dS4S/g9AawLBsxwBDMl+W2jJZgCzv8pWU?=
 =?us-ascii?Q?jERd5bXwFv/HOz3F+EPbGFNNTHdVZn3+KLPyUsNseF5XuWCorn0KyotNboKz?=
 =?us-ascii?Q?SX5dBf6dow7NNt6g0nqS9ljyyCfZnnQiaCfmTpXQE91JN0n4SbebRkEvLcp3?=
 =?us-ascii?Q?1F96wb1lVg9g8PozQM2u/QQipTVXT6EGEt6NzTRmmfFWK9XEaW+pRywY+oXg?=
 =?us-ascii?Q?0ly2AxI0Hig+6inHxWeluYCTknc4GJcemDrZKDLKVMazlTk5U6mU3YlGYRjS?=
 =?us-ascii?Q?NeZ7Upf6IR14y9pJ1IUGD+alTNR7tMRySh+lfptURvPPqvbitwkM8PTf3psg?=
 =?us-ascii?Q?97hG5kREz0INBLXG0dJAMVexDPBRM2tbFsYhS7692RJFB2i1hCiKKOb78E1a?=
 =?us-ascii?Q?r9OuNdljXUp+MSU9IX0SFBtB7Peqt/0yNj5uw5CVc0Eq7snuJE3+x0SmlAqL?=
 =?us-ascii?Q?PqWUWegWtk4adkB8IXL0JdF9aESh7AGt7NE3ATPlLbidaetIvvxHXpYXEh81?=
 =?us-ascii?Q?2se8ks4z+coyRUQrc8MxmtBU9kvMaEE+KVGDRjoMQUK3h/42NFeEiU9pj6LP?=
 =?us-ascii?Q?Dmql9NV8BlbfK7PFQdahdNHPyXQl+xoKF26uG9lKZTOuyPs9yGpERbWBNIXZ?=
 =?us-ascii?Q?3ybCtzkl0q91DKjgHMrXj6UqzO3jQ9xk2qnLPvyGQ3fHbWVerJHalYuy+Q8u?=
 =?us-ascii?Q?Kos7LCZP6RtBkN9t7fwFW+KAeCQ0fIO5RLl4g0gGbTSM451fI7Psc4DEk6L1?=
 =?us-ascii?Q?82RnGx4o0whBwa1t99jK2gOo4lPq3svF5yH2FXPB8xaYgM+9XLr/ooHpQud2?=
 =?us-ascii?Q?n3XsDk9AeGDBKewJQiJxUuwFzFe6FdjL5aeu1w3iEokVnYLCbXB8VvDaZ9c1?=
 =?us-ascii?Q?/EywSj6UO9ZuX/mvyb9or0DNaEoOyFU9ZLEylER7zGzTreSN5AtKMsRHd8jI?=
 =?us-ascii?Q?wDXpNSnh3/3KxL8lixATTUu396X6mMLkOEF1o28cqyaPIx20ki1lE2Nwi+ma?=
 =?us-ascii?Q?KFXqJe6IM9TOsjlLKCLJ/n6ggNrJWsX/My0AdtHRi0eAbZcI+xyfH/YSU0em?=
 =?us-ascii?Q?fGtMujuOkqtnQ0hLps7n7X8tyhGdeEMfzoJSWyB5CFgztgL8ZYKhYEW+uwfm?=
 =?us-ascii?Q?dXR5Bsb0KnzRhJB89Shb+2q6LwF7w+LzuLTsCmfmWwcBAiozdO9zQd2umIjs?=
 =?us-ascii?Q?f5cKm5yEeoA9ahMq+W9vv3W9ZNqST96nFc3ClZa2i9d7A+m0LlbxYnI8oLhm?=
 =?us-ascii?Q?67GB1Ez7oWk8qqxnujeL0Sbvlmg0h/XxdnlbDmJZcSj+r1Sh/bjRskQ2EaJ2?=
 =?us-ascii?Q?5iL6YLq1+dMAfmLvNghf4DpGIKx5eXlcD1QG9jSFHtV5ZFagWv9vDIBk2EZR?=
 =?us-ascii?Q?cC9LwULe+wSb726nWWCK+h1sf8Tmw0FbxFe+VDCEh6XRl2xWP7lQ+NMgEE8W?=
 =?us-ascii?Q?jZSaiCAT+tztv5U78wMJGDiDP7bGR+SZ657vJhS9//S2GdysOmadSX/aCtOj?=
 =?us-ascii?Q?Qk5GowTVXqd/1qQhwwcqJN+Z47EZVJ1c6zF9y1Cjbdj8lfiBPwqQ65ANqamW?=
 =?us-ascii?Q?jgtzob4mSNYyuvcAnYFmtc/pDilVern6moJbWtL4E5ZxOfcCH0KtHpnpTMYh?=
 =?us-ascii?Q?lY0cCNwCMB8wEN+ToN37AszgMx/JnSE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc9b032-509c-46bd-3863-08da43d85be8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:09:36.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otApuvfl4pfIx/ZlkVi5sy01e1K6lpJkzII5rWxCN1CAZL7qWoDb5iRDmwAlHSZkbijnFsZwn+gZ7sYuasA3sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935

This patch adds the backup BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command
to add this new endpoint to PM netlink with backup flag. Send data,
check bytes_sent of 'ss' output, and do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index eaea4105728d..f3c73cd2c786 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_bkup.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -296,10 +297,44 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_bkup(void)
+{
+	struct mptcp_bpf_bkup *bkup_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	bkup_skel =3D mptcp_bpf_bkup__open_and_load();
+	if (!ASSERT_OK_PTR(bkup_skel, "bpf_bkup__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(bkup_skel->maps.bkup);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_bkup__destroy(bkup_skel);
+		return;
+	}
+
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow backup");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_bkup");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
+
+	close(client_fd);
+	close(server_fd);
+	cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_bkup__destroy(bkup_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("bkup"))
+		test_bkup();
 }
--=20
2.34.1

