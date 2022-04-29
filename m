Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326721365
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651243925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYnPejULAiJ/mwgFCuj88hOWAX84m1E1GRIP00c2MS4=;
	b=VOn0q9KdNfzzWKbmLx4p+AQkUC6/lv0uYzc3ljlvIeL25pGm5vBIqs/VNPI+qw2O8aZUcx
	Vff91evHEcvUU0zpiBuNOgcGSmlQDPacRXBRYCNu5ybdrHAIKPQ35EFET+7AnPGoroWyla
	KLypk7WIgg3aJtrAbZNbkmmfWoYMlN8=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-89gG15H4NC2Re6eKw-bR7Q-1; Fri, 29 Apr 2022 16:52:04 +0200
X-MC-Unique: 89gG15H4NC2Re6eKw-bR7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHuPLjKXWmcQNLaTXeTR8AQiKkZ0MiojEQEzuX1h2W4/aen86fknlWH57dJd2grmmVsPpbzy1DepVvM2tvqmhV3bapZ8o2GjWloFI0F8rDSJm6Xslw6NBJBg0Ug7GaMdcBlJydiEc/3NHiZ3yiB5xd+cOt5zkoRTvEKdgZW+upZi0EXrL6EyYmaxJ4A46S0Lu0YFhlFz8I7yFOZngej2Iego4ERpUrrIzpVWBrlVAjUDhVjixbuLta1xvxVfWUg9U5mVBMTSylO+PasZT7a2o2kJ/xBo5J3VF/4I516jokWkUxaNt5OR2e28+vnR4OgpwZCJbsDwhQunezDMg9+OYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENXOVXSoSQ9XskD9Mpeo9LPSWj4OjTv+jLXenfBqtxM=;
 b=ls72PmuaAbDIJ0vg32A9TMy8XKIY0l2RJIfRBEXtfOmpgRSp+Qpi+DjRvpvQpGNBvuJHWukFGkbSfp6o0OrB3AJAb3RPB7+fdZMbLEpw2UXxDkPRmGSUKdopTd0111FcSs5cmamu4FHIjK64j+bpnhb9PS+YapVWRDS94m99XItr86KLf4EyEiUwSpzowia0i9iDKxgZvp12xo/MJWZ/Ub/nfiyelyXoi6SEZYj7+asMNR/2+zVjxGeRE0wh6T+Zqxvxd3VTn+iWffHoXewMtROprV/XAx1D3M0iEs2Ma7fuEgqQ5F0FZ3ddZGFQvMYNXG9KW/mt8dDF4u6nI3FKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 14:52:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.025; Fri, 29 Apr 2022
 14:52:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 3/3] selftests: bpf: add bpf_rr test
Date: Fri, 29 Apr 2022 22:51:59 +0800
Message-ID: <8ca13c4d35f3b622a13b198203610d600c23518b.1651243739.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651243739.git.geliang.tang@suse.com>
References: <cover.1651243739.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0196.apcprd02.prod.outlook.com
 (2603:1096:201:21::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 526eed59-f866-4321-baed-08da29efd28c
X-MS-TrafficTypeDiagnostic: DBAPR04MB7238:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB7238C021064C589D106F0514F8FC9@DBAPR04MB7238.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OF2pUXSjVa4gYQC+Ptxt35wck+7/Owtk4UnY37Mr72ziY3ovs2X4FJgNcvy069UfS7Y/9Gk0mupfDxPemGXPqUb1kvQfPvoYgRaurP9frDLciFaYvyA3VryoN45r2bnw7sKL8HbqfPq0C6le6Jz8N2XQWzYnVIT97UJ7DVt8y79HbopbRUUP4kpw4cFKO08HAFFA29f9CfvkmW8T6SlECcKP/wKDvdmqGaSwbvPXKogbbR/vbkQf6rVmgGADfDG1wcgixJRfi7fCZSHGh/6/2xIPtflp8TsYDV+06G6Jewpav4kmmAxXLNuBMF1oAy+/TDhxdqJ1SbIrQhUGJGB3k1sJzYKUKXAfuHdJs1I95vetln/B5FjJx/uFeSHpPbceR7sBZAmT//l0YFs4SNcArbPUmx+m6Vgs+waGfSVP2I4TXJ8HMKgExvlKeLEjcJNDZAxUFGB0rT50vs+FqQGNPRrhsBrdVN4m5C2/HFcfIsX7D2bYpmyzxLQUrokJ4e3PeG6iMyaegQ6XxZgAYaPeedSt9QTKk5MIU0GGXjCJGoPDqURDZYdbNcLiWBx+xPuiUs3TJEJu4uScc2QsBMNeNKxdcPGjBr79ib5Npj5o+sXone2yUCK7XNXEE8ApHYnn9gNf0wiJGE7P+eZ58GJP5yS3dJkZkGK2TKT27pWHvuAoYnZzz2eVS7HX6GCcXXBA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(66476007)(4326008)(2906002)(508600001)(8676002)(6916009)(38100700002)(66946007)(6486002)(86362001)(26005)(2616005)(6666004)(6512007)(8936002)(44832011)(6506007)(5660300002)(83380400001)(186003)(36756003)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9R6ZCbtGTvlpGhOqe6CfTYrrBgyituW2pjNTADAWRU1zPIMELfjTeo8YpLvp?=
 =?us-ascii?Q?PxC68JAeCkOlYQKMoo05wfipltXFxWWoSr3Qf+3L7OBqTK4+sTxngc7mtG1F?=
 =?us-ascii?Q?TOXvqUQrKnzRI8s6DvlpHx810kqZvD49lcke8COvp2ldSYwQy+XmcwU9xS5j?=
 =?us-ascii?Q?KYkoZVm/aFBOzWX6K9b4tv/JqAVLM9Y82AEtZUQSmebvW11+Z+tt9URUpHpn?=
 =?us-ascii?Q?7+MxeTxGacfQCns8wbVC/ItsVl1J+nSSsWHORaniuvlJXEPNu9Tnsd0UdIf/?=
 =?us-ascii?Q?7zlKhfiOFQOSZ7rjtAG2+6dbv18gGb5bAv/3LT7XSXhOxbjLwpFP0gkc3nPl?=
 =?us-ascii?Q?w7pQyOWRgwCg0WIddLpYsV6+Bwhq/XkFr010i+aGG3evrHGXw675f/EOX1ND?=
 =?us-ascii?Q?8ZZyrnG9QKwagUYubGuqzS9E7WSYovRHbGQNMAlEcPVMSlXSOHKrnFvMXTe2?=
 =?us-ascii?Q?yaQjOp1HuuIZSYoYtUbFFRCUl4HgBCBkcSfdKYmh+JTP8z92eYQCS2UbsWwt?=
 =?us-ascii?Q?xjyzpfoxTcaRW+x9EW/GEU3cbkNuT+oD4UOD35J2lcm87LvMBT3EdHbae2AR?=
 =?us-ascii?Q?fnMS/b4wyuDTL+cxdpltHHUV9YLaFVPh2pKQdOvqf4zQILM4W9+ol3R7fyl1?=
 =?us-ascii?Q?K21Els01FonzDIBlUr4gFBrxPt8V+TlSsv8XWA2P8TAWPXk0xvA1E1eHgE0G?=
 =?us-ascii?Q?X5DJuNdMUkuA+0XDmYp2YT7IQWevdnzQWTB1BWGTlaTAlmeiTKK6v7tDLIng?=
 =?us-ascii?Q?g8gRQa4KWWYxGM2a5pGa7UjSM2iNVPcM5ped/n/ckuCLZo+YDwWRDr9xFoC+?=
 =?us-ascii?Q?2hElEPyaXzqBzg6+wwjPB5Pt/I2M5tKltsswtGYLejcfId1S23sPHrU/L9J3?=
 =?us-ascii?Q?jmqiUzBbjBGq5w1dQsdMmhALT1XQo7CXweWzpHN8nYjTXSMU2M90KJK7hRaD?=
 =?us-ascii?Q?c8By8w0MzZ38LiFg6s+u2cx98FD5CFFVaw4V3Jr39skFBzdjOUG1plrfs/JR?=
 =?us-ascii?Q?uGViPqb+wsJ1KAu4PwJGCrJKlNaZ6eIwOHBamGjAKsd4IcjRdYUVyuayTOm7?=
 =?us-ascii?Q?FIPYS5oc7s2u7y8nIYi/GJs8UvboIgssZ7aQVXqfM9/I2PPTgxtRqTzaWEgU?=
 =?us-ascii?Q?JfodpGx46DDNOgtmpeY8lmkFw5GKJHYys9uFWvEUSZ3JCkWsvghPsMPpSstc?=
 =?us-ascii?Q?IewzTEkwRW/W4bQCKOOb1Nj1dF7SEWhlKonQOfCtdw3vSU56i5cDuDGHshiw?=
 =?us-ascii?Q?PD+aXL6TegvXuz0UAfrBmvh7DeKby4WcXwTfilmHUIcBNraFEfLY9Emmy9zb?=
 =?us-ascii?Q?BHoJmaM+qPZcBNZhoGiGl3/1RW2l8O4BGMhYXUEanNtZGPqJ+1FTE1NM2pIY?=
 =?us-ascii?Q?aMR/C5+m83ka40htndoD+/VOCpgeU6E+mrqZu4aDYPLsFUOVUTqh/ALj0CdP?=
 =?us-ascii?Q?behgxz5BoWIPriS0Pb3D+s6T8Dv27nX4uoO5bLvMfBbiuCYIF0CArYSmYrVR?=
 =?us-ascii?Q?NpJMwLiV8oleBc+lJt7JcekrSKmQwM3mAHW00B5pjd6cMHki+4WSTGwyDzQD?=
 =?us-ascii?Q?+vM3kVXoAgrV4rVUzZ4/pJZwS/lcKFmW34YyauA04ZDL5hVdu/YslmJS4mWb?=
 =?us-ascii?Q?O8uL+VGAtHghVzGxgrcyhPP1NZzr3a4pht3JsfeRWsPIYF8qse2K6Z5MG1Tj?=
 =?us-ascii?Q?Bt9iAkhveRP0iaJM26HilashuUd+Ds/a0gvi8IHZFg0VKRa2LBoxE/nYvaie?=
 =?us-ascii?Q?L25/M97X9Oh5ABnbqZDPI8UmYXdgbqo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526eed59-f866-4321-baed-08da29efd28c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:52:03.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZRNvd3Blf7Rctf+2QcIp3O/yVTYNkXS1jfZCt/1mnlGYlDI9dHoPTfyLIw3ysR2+9QO3CORbgyVPsFI/DnUcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 44484a63e62a..fb4a4b37e818 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,6 +5,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -361,10 +362,46 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_rr(void)
+{
+	struct mptcp_bpf_rr *rr_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	rr_skel =3D mptcp_bpf_rr__open_and_load();
+	if (CHECK(!rr_skel, "bpf_rr__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth; \
+		ip addr add 10.0.1.1/24 dev veth1; \
+		ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+	bpf_link__destroy(link);
+	mptcp_bpf_rr__destroy(rr_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("rr"))
+		test_rr();
 }
--=20
2.34.1

