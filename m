Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABAA38E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVFRK/NjaL6h2mwDduCLE1Zaf15odWaY/f8nyE84Xbbul1BJDGP9ikz8ZFTrvVmXSBnEhCMugZWykpt3ijM2uPwW6PVMv1C9EgVqIyUWhLD8svtJVmpvlytDeEMgl4tFFEAKMTM0qIB9RDc51PJ0zUkaqmpoRPhEApQTFttjhhqcjWFQsMD45DXErFvri0+fSnkWtIAhx5nshxIxFBeTd6eVeRSwrNiQmZGYbJem1BfxD6qSwOnanNYNkMPY4Q5cbcYIkft+tfg/s38zme7ToH35hrAijqpaDS5S1ZZU72ErDpGJPgJ6k2idh3EY865jcXZC3OABGIyvvhbvZV50qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=B08MRBPk5VIF+n+/0ySxghoxGckecsnM4cEDRb9tix5kgqqdSQWZ04C6QJFbrhVEa+BK0CGh7y1Uzz9iukHR522JKmThdSrAzxy8zXjGeb1iJ5Kojzkov2MSkmnLR6XSoi+Jjs35//atRmTgFERdwtO18n6u4A2gEm84vn+Rgx2d5aqJ2Sezn/6Ph9VOEYnSsrRk/XTkGkRh08ZpkVQpdYDK8q+Ogerj8vvCpGMVeYP7ojMs16Fi1N8ZWZPnaeZUoyGEwab0XS+9MESYB0NFzGyKoKtoWcJg8Rhjo0VrxHp8Ut76EGLqmcvaMSuDWWdot5HR02Rh3qvOdkEv/sYZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=jpcV3BHGrxkaFp28ZGVH1uN29ADIkcaZKzfeeX7TzyVi/382N9/xlQAJ9g1b6NIgH+a5oOqZ9ucv+adaLeXm8mQY+JwBlnBWw1yRKv3nNBZkAybTGtqoPVJuRDNQnWmfUlkQTxBZlSJxQQZYgnIpqsvK0Dz6H5KJdR8M3/W/hMTThDclyU8TVt3ZQD7e8bHJzVnpU1qYcGWXSKT4A+/daMY/JlXQrYNtbsKdfrWeuAkNlM5F7/GBRk6Ve5xKhXVo6x4XC+PrjqooUsyOYJvm92yMkhFb6EE2J4dtM+jxwUtHR2NWYTIcIkD97PT2GLMpGV6r3lcHuCR1VSroj3jjrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:24:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:24:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 20/23] selftests/bpf: Add bpf_burst test
Date: Wed, 14 Jun 2023 10:21:07 +0800
Message-Id: <748bcf5d9f52c4e0ae0003dc56e9e509af340be4.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dfa35b-0872-48e8-3a6d-08db6c7e8968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tdRjhpFV4OYM6kaWJtjUplsJs0q0lj+aNouCiq7lyuK9ki6feaAoDwk9NsrgwqPnvdeGLtH6sliTP/BJ8j/ZN4JcDMU2Ttrd6mcUDgz43554lkLZHTGXXV9+jinusUVtXfi45R3jiductLI4pAsEY3sz/4YsCEf+LXZHEfwCfAJVbdusUBKsXHNF1QwtYqqK+QYr5VfIlewAuiP4I2sRW2OFPBxC8d+gImuyYIaDED2zaY9W2EyojGIAWhzg6B/wP5LPECVySnBwO4vthgksPhY31kMARqQgv4jg6pkgbnU8b1YbbPSaa9jYl3HjLHqqCUt1XKFx3uoyroIa0TKWVz2Y+sOVAVFaopG5fiJk5CPrkmBfhNS2tWDB0ZnmKPyIY58b/IkrWniZ0gmN5ja+1YZAPkMn1n3Ck+bd6jklxokbQByanpNSrQzoFUbIWaWpgLbVYaK015oGSJMLUVVdpcSoDausJ90N5E9u0TACc1CQqZjPteiUJz9XgtQ9j99RdDkxVmWR1pq9Vlyf3z2z5nH50wxHjupCpnNV++feVeoPxHlmMetAQ6J9j3KdMIbz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(5660300002)(8936002)(41300700001)(316002)(4326008)(66946007)(66556008)(6916009)(66476007)(38100700002)(2616005)(186003)(6486002)(83380400001)(6666004)(107886003)(6512007)(6506007)(26005)(86362001)(44832011)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t258YiZL7+Z84AJZGFqNwMHMAWWv1SxHzdNXuNrrzrv1q4ydP1MVwJ34YBJn?=
 =?us-ascii?Q?yZYjt/V24lo1pXFFEUy6tBRMK7oWx3zDkbus17WE/MO5/p470qmYHHdJnf4J?=
 =?us-ascii?Q?xCXeSAuDgjDvy2T8hx2e7hg10uFBSlp/evZ9SPVPj+y8Uk82d1zwBEm7UVTR?=
 =?us-ascii?Q?Ps9LctuZie9+yOA/QClmMyUxA7sQCsrxoPWY4e6Ob1gAgC+Opu1SatSHqjwT?=
 =?us-ascii?Q?MlpPU9yV0OJBpnYh4LndQGjt4s6Kpc6KeR/evKQA2JFztQB+vOwTNs8by7rs?=
 =?us-ascii?Q?8d1Gm+2YS9ThVW6jcsCbtz0zB9z3oXMFJvAPt00TLCv2YH4nwBtvHg4r2mgQ?=
 =?us-ascii?Q?ZoUvcSTYSP+Lj9S5j+SqZRHjiMWP2NSRJqv/QgLh3PInxjT4DN3V+siRPJLQ?=
 =?us-ascii?Q?IuNuH/Y+XpICavRSNRXFW6tprTfTPDnjZkPmEUpU97ICFaz/8yURqO1p9VP/?=
 =?us-ascii?Q?Ko4YtyT4F9Pe8AGWiVfwPC68PkMoeE9imwA6Hvx3O17ad7bz2Zjfm8O0TXGP?=
 =?us-ascii?Q?LafXYtAUhomrjCgsnFKyHEx7Og96f/PtY/Lh/DAkJZst2O2oTfmhziLQiz+8?=
 =?us-ascii?Q?+WIKdR/6FjI2Sgc3zhDE4z1GFVPPocWw2C+62YNbHeiH/rShcWb9HViOZKh1?=
 =?us-ascii?Q?jAoCAxZh36I18UPlotKVmnP2j8RNocj7Sp6fKZBB/3qq05QSFNqLUl3Yj22P?=
 =?us-ascii?Q?JL69FGSshFYkbAyxeYrR3Rak8WVDWVlZ7YvVw47vW1CvRz1eLRy7fj42nxGa?=
 =?us-ascii?Q?YeQsnD607ml3y00KnbYxbcScUib4Zabr7AtZ2L9qr+COuJ0EYaqTp5Upkadd?=
 =?us-ascii?Q?LbR8T62ke5UBGu5TvphaXekKLmcKpA4Ctc2hvtwGhIyuiXY0esTJu7qv/0Pu?=
 =?us-ascii?Q?dXmZMccQY6VxDssOy6X2IRJv1DjnsiK/4r01KwREeBEqwJaylkffjuDxAcQX?=
 =?us-ascii?Q?5smCXl1bxSJEWX8WAlbFVWJ+SdLEVN50f9QYUtGXYNXOdugoFHzQXSG538Q7?=
 =?us-ascii?Q?20puTpjOTnmiixMlOQ5e6R/Fo2XQ39VFYn8B78D30WFT8fJz9GwvtZHVZH/C?=
 =?us-ascii?Q?re59kYnOIL9bDRMS5BtDhqcqbkJzeozWSIEIrgzmU8cFPvLsGiVcjTkoMIuD?=
 =?us-ascii?Q?QtOmQrXxm2SExRcIKLxk1v9/1/nddrgbnIRvGQAmg68ccUdbTgMZDREfEk5B?=
 =?us-ascii?Q?SX+w8Gw4rmDcyZUuxCxmDqmS0KlEIAimCQV0f4epKuzr0hosqIc4NwF1p1iA?=
 =?us-ascii?Q?o3B/1sxoMBD+HN/TTEEnPAMKqEpufSgT2nhAAhhpxS0uQ8vVhWqr7Z+zm5Aw?=
 =?us-ascii?Q?mcJWo+Epy5xucvPDH6Oba6g81DzAcylzq/l1oQ4Fl9txOoP6fmqVEplyxAbw?=
 =?us-ascii?Q?OoIfCcRP+MFcZiHKZWT7UBaAItwzitUGYqi4b6x+aehQn4FL+wlx6AgDY0wx?=
 =?us-ascii?Q?NiWGLm3CYuybI1nTjuabh+c4fewa6Y0Kz2ZC6uAqlh/Wy+ojTHUANq85pDxD?=
 =?us-ascii?Q?3jzR/QSBm6gcnrAZqxjkKXSjR89J3s6wT4kRU5BXcMc4irv7Rwxowqm2RO/t?=
 =?us-ascii?Q?T3SGItUUzEsVMyGpRR4LLQQUxSV7jkYHfYCGZlse?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dfa35b-0872-48e8-3a6d-08db6c7e8968
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:24:53.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwJcG0+3Y7auFcBW5P1LOrN1tAe4QeNZSyctVwrWqsaSc+PoB7RUy6Ffyw5qyq1WOS5UbddQM4ELx+QOknxiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241

This patch adds the burst BPF MPTCP scheduler test: test_burst(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been sent
on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a968641cc94a..b9f6dcf995fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,6 +10,7 @@
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
+#include "mptcp_bpf_burst.skel.h"
 
 char NS_TEST[32];
 
@@ -455,6 +456,41 @@ static void test_red(void)
 	mptcp_bpf_red__destroy(red_skel);
 }
 
+static void test_burst(void)
+{
+	struct mptcp_bpf_burst *burst_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	burst_skel = mptcp_bpf_burst__open_and_load();
+	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_burst__destroy(burst_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_burst");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_burst__destroy(burst_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -467,4 +503,6 @@ void test_mptcp(void)
 		test_rr();
 	if (test__start_subtest("red"))
 		test_red();
+	if (test__start_subtest("burst"))
+		test_burst();
 }
-- 
2.35.3

