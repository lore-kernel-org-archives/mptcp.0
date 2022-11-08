Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20089.outbound.protection.outlook.com [40.107.2.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44E6ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtRs2BZNEGwyPWTHsEalr70WXY5KffNbtiG4PFIWCQvQD9RV5rTeWaOtF/Yva/gMcTmBhSEIU3D8gmU0Y2plR07u3Soz/ZYLJD1Tb8gRjZ1+ym50aZ57UXeS86K+zwliad31j8UUShWomyv6cjJEmAoOSzDCVNW1/7boUI2yYRwd1rLkotdXHIJ+Zx5Y4la2fnvsPDM/LzL1nNy5Y0soISX1CHfPiug/yeOvGKhPw2N7ALaxcNR+zFV8BBheaNbqyAHgQe71CSPF1AYyUzKJMEy7r1tlJ+WeQTzssiAJjcs3CBwmKIcwtEMucoAd0NcmZZhBJ68Qxrpm1H9f0N3wMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=AEEKkKtLldwBA1R44dIsZph/uxkzzpEQH34ev8wdBtW8j9AEQbIZfuLLI1bNOGVfc5pu71WFb5K0uW+GKKNMcV0e7g6YkJkVj3S9zATEeHXYvd8omwqKH6paeLZq/gqRjItGc1z2TCOWDCbl4DSpxZGeovutR5XJmaN6Wo6FPY0bAJLZf4M88nV4tvRPWl+aLMDCiplkP5RtCGtjKhlfmnoz6PAzfcywy8Y2sCqMt8KP9JWD2T1kVEscuVzWRmDSKK69HUOJG/olPjcCzGfT7fTVnXsTko7KIn9zsPYHQnR9DxguqbfdlhMJLYEYgBAxvwokYkfsivsNOuuzr1kPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=Et60ChdBXYxhVbYwmMnui/0zNkys8g4d7w0JKRaCQ/RDLPZERZuLyfjlbOUHLkrPhst+yy0LMG5wG+X5FywUk03rvBCw/K3UWly/F5H3Q418WEwMsGwfQfqN/r/f8qDfG8bODSludUus4KxRfvx5eTg/x0weiHlC8aEaIxdcniTGAIKZyVjMb6z10YCN4F9iMHn2WwluaeDaWstuXnczMruR1nkQAgYcX1/UKnB1BoV28kQ/3RAiTHwpwgmWykgsqo0dBis75+cdelQMoZ4JvSonzxI5exA9rH0t0qUS94k5HEwlL6dyrqEunp9tvsogRAkYLLKNAju3V4oPHmr4Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:10:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:10:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 15/15] selftests/bpf: Add bpf_red test
Date: Tue,  8 Nov 2022 17:08:37 +0800
Message-Id: <92d945d60c7a97d26d30a7dd8dff441b5509968b.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 25216723-7f3e-486a-3b93-08dac1690fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gwl63xddDcAX3abA7UFf8IvmWKXsTMI7jfzLu0pnKVbM4kNUXKgP9iTPydfK9rgXPkHjgMEkmspiwzghIQaEltpL7KHsgAvZgD81hFCCyfsEpasNSFJPW4+YhNnE21MdtyYv9S/HQT+W8vE4EAy9ndeKbo2uaBI0Bdzxqf7kcaH3JPCySPL/hoGYggsVzBp49+sRAQ0V9FTAsBkTvaedtIs8Hi5S8DNKm7B8GA2LMicVHl5h5JEVHuIZ6bN66ZVkBpv7t42KzPcHZl8hEfSVzbh13TfcVtbbpNMf+CdgW63iphuVCZTxgs0S4DvhHZxntlEKGhNUqdO7DN4G3KeuciZ0xJStJmqTu2vyaSAxTt7LGNBOkNXoxCIHP3EaGL+YquK4dRFGxlvXroCckdgcRTMdy5xyfUJKnzrnMnADf3mdKCr1SJ4gb03g9f93WEwzSwhKq00Xi1facLbDLHQmEbtuwSA09LZRp3ZdRHK2fLpVg1LHOTp2NGaomp6CijyMZtBOlCdzrX1QibUcIwaJQcuMOTnn6FxQRVvOwgCJHW2s2mP9ezLpqv22fzzrldPzSLDWzBYqXiy5sEmLVOfYBE9EJMtov57N622BsItRsTV8XqTbwRJw2WZAkFvwXvzGCsVnkeMstqc/IfEIwHXn/x/AjnOPUkYfBIxr+4WoXT/mPF0K24HqvPJ2QuLR8yAx4BcDknPFCAUthvBCtIdcizuE9bUFV9LLxQ3GJq1XnzjuI90J7GEq6AllHUr5I1kx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(41300700001)(8936002)(186003)(36756003)(44832011)(5660300002)(4326008)(6512007)(2616005)(26005)(8676002)(66556008)(66476007)(66946007)(6506007)(38100700002)(86362001)(2906002)(83380400001)(107886003)(6486002)(6666004)(6916009)(316002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NO5ATMLUgnxwH0W51eJRyx3HfNabAtF1AQLjPFwuE3dLU8q+eCF5IHYfqbOP?=
 =?us-ascii?Q?jxMLn3DkiHc83Oz88fmkhySactawVnEhHPfznEKzJ9cZEDCX7Q94XJU8znLR?=
 =?us-ascii?Q?2bJiWhBztJbW49iKA+6OWRWuGPM86POM/tztEH16mFbY/5ST7+ckNiqmvWs0?=
 =?us-ascii?Q?zYCuRAiyWvWNuWmqf0dhCB37dWcqvlP29HGKl+O5um6Qs0hxorOb18gytc39?=
 =?us-ascii?Q?2EPGDkPYlsemdVcqtxX0ZXkMMOF8f5CONbTydFr46dqLJT1wZ4NqK+GgNKfK?=
 =?us-ascii?Q?Rdjlq4h+5+3rPFdX8nrx5DId1E/+CmGkAOl9G8TVHsZAiDYzlbNtJ47z0uhN?=
 =?us-ascii?Q?mVi6eDrzDRAYF9FomYqPyQpFvxVSpgUDbpXXRrFzTfkySlRY9NJUAhW2hBM1?=
 =?us-ascii?Q?eJ+EmHUwPMd1GTVfXsSSOYX0s/zNfDUjJHF6dINUGaMhkI/VAsgnqVpcJLNq?=
 =?us-ascii?Q?MnbZvKcasMXjRUBpJtpui8eff4grDGv2XpxkqZY8u+Fz/xFWowavYdKPW4hY?=
 =?us-ascii?Q?dgo0BHnw7HguECOMDZ+an91S3A3Az5QZG9afcX5rM2+INuPV5wOD/ZCLgAb5?=
 =?us-ascii?Q?3a6ssEDTPR5zdatDrsnWbcTOzVVL048wx1a/bAr2GPbff7tHVXu9plLjs28p?=
 =?us-ascii?Q?qCXqhAlPrv31EkwmIWYzbafuCYFXnriipmZu4eOBU1y73imMYeN84TGB3Cf+?=
 =?us-ascii?Q?ZUeJdLkxaRm3PiTQO3BdpYYgHPQrDPKFWMlwnviMLtz01U3yLhh4S65Oe0lH?=
 =?us-ascii?Q?L9pCQvIPwgJGog7NTo647egCcgY+WP65IVqPRCn7zEyy8xlwES9DtPFzMExy?=
 =?us-ascii?Q?10CZCi+YhvPpGAfGdt5SF83kfW7u4425SsQM0XFh2V4R5obyY7lPvMKFaYE2?=
 =?us-ascii?Q?dn+cGSJ48u3Jl2qQPpKZO7YeqAA6giMomFrcQ58lZtVDDxPxQOfAviykOtFV?=
 =?us-ascii?Q?3Kljs8lcK0RI+77G/gNoxfxiLL9cv+MyM6ZxA0weXuNVvi/OalMkCc3WndsN?=
 =?us-ascii?Q?MvqpsPxx2mT7uRUPUSV146cKzkHe/jwYDXLEXDrGRxOZYHHle9kElBUqKvVr?=
 =?us-ascii?Q?LfWucPlsz67e1HcPyF+e+DMYX5NInf9BaMnO6yN+RYnIdZli1mEQb9DL2sot?=
 =?us-ascii?Q?GBOB00meMFMGoXUr4L1MK8H+f5VXtMmDxNufayWce/uVHab4vJeMV3rhje9x?=
 =?us-ascii?Q?7yby3pw4u49oWfo8V5H/cuSiyJ0E1IciRlEW/93TH06cM3hezYvrRx3tPv2a?=
 =?us-ascii?Q?mpHyGiwGHTTkyiGV+Yyqr8w36SKcpfzkD1/Skt4iFNTIsQ22XVGEGz0sZUoj?=
 =?us-ascii?Q?ScOXvjBmLaSHDfiqanvegFJGNEDDq9QTqWUcf/sP2A1an6E3iSic6G9dJo81?=
 =?us-ascii?Q?94pqjs8ZxlSpMpt2MdRKgAlee2z9P/kY4jAQh2vPdjQ2BF/bWYLn0twK82iA?=
 =?us-ascii?Q?NylFFpMsDzm+ZrvtJmwOdL1YOvdZdAWm4kfBhe+t7p32q6oPnVl3OOlFU0jT?=
 =?us-ascii?Q?vDfnmkBagdLksCQ975SEOzd71nkYnyDFZa7gfXHY3KGooAWQ67UD4XnsFRWU?=
 =?us-ascii?Q?ZVzsq8DxPR1Rc0S4Bb1cnxVtaotSd6rs57dZT78C?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25216723-7f3e-486a-3b93-08dac1690fdc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:10:20.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVoTX7A/IokVXCyRuANXoBmyCgSeqOHnfaFywS7NecOwgaTZFos4rVOpxGqjCaIleTw8ZZOARyKp9URVPgM/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7736

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 647d313475bc..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel = mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
-- 
2.35.3

