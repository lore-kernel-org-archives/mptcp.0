Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8510E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=futZipeSLq5wwjempOgWQviwPV4exHGRXmZvfXBCJ+HVu7W5pO3yWjfoukeY/BCjjw/mWe7augepSrpkyO4AEkbYks+LamB94rKIG23eYbjdKFb33Sdo8lhpa0JwVGcvuzrgUd79q70LlPLOiLbTkL+lF46aBRnSGnUT3pZdgVbDyJiBPfjb5fsHoNTzW4KiNnVMKcZ5WPY2MwjqvUEs3K2iHk43Kduzg7Z0Q+Zax9ENytEhlfEbUyr3hNh4jXHhonOVSP/vXMGImLKLdkE1EcMe3YAsy5rnXVLMlvpTyCcU9m6AnqsqZPirvyt4CfyVZCIUwCTGP7Pkd5xLfcz8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=i4Z5kVNMKr6IC/eeM8MfFIWlZvpkuxPWMNdxTGCKDb9IfEV/0Ig+EqHs2LBjLrURzpqqgF9uXfgXRrSjsIr3P6y8Bgq7sNIZXYIRtlquZFCsJANiYA84AJSWjoS3ggSiJ/tED5yPrLQwzRvGGfDv7zriVTHa76IF3K0b+i3gbFtGoi64snouSJHLXtBAoFSjW7M25ejgG62hj2Z+zq7hhE+dCmkphXvfeuM4oMQjrinBJU0UIBfrjNvtmVpy7YXW5bO9rZOOCecdhO1Q0DwKbuWO3+MF/tJAwIbvWeHPNTwji5C3+p993bH3v1JuKcr6HRfT3LVXnJ2Mmq98Gw92IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=vd6pNuyYxeKc8+ghxxoezmV3VMwiKzW3dvmy72oLcUdvymOGebbf4+dywFGV56xWRFo5gB+pDjSDft4hUs29lqodo0hxCD+d6hkWSFIKRV8QyMKL8AMzqGutQTSRDQIBP8IlupaJCb5MDqW4mCZ2FJddXDVpaGMrh4sKSLCEb+7w9aXUsluRCgpqAK5aYskyB6WjjOYjo5yMdEk4dcQeqyuQ9spBLY0fXFYZgILXA+x14ooIGWN1W6sPZOFSzTATsVopSDdI9+iRECVQ99KdH8UiWl4kNylGXSlIv2cxo3fcvuELNu0E76HRawovS+jh3koC4tEiTlytkGBE/m+JUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:01:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:01:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v24 5/5] selftests/bpf: Add bpf_red test
Date: Sun, 11 Dec 2022 10:00:56 +0800
Message-Id: <c521471446506ce253ceeb43d0d792a6d5f7d169.1670723836.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670723836.git.geliang.tang@suse.com>
References: <cover.1670723836.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1ebb80-0e7f-479a-f8ac-08dadb1b9c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WOBKEW+rp3MYGU2di+wfMV5gioiisfbBgotZao7+cmBEmqFkAYNy3nq/OPQ8tgPmjSxXyQzBcRyT4lW+W7Wk0LRg7jMZlzcGF0LubiKj0h00HIvo9qA9WA6bySwWThetMZYqvqPGxu+PvAnm+tbY0fbqDtqKE9UUz4eEvpXTGB07Ldp1CllSW6SJdhjW5eunHlyAp9MsvHdTvc5rnXSbfuk08AiFaXdF+zI13cSN5NjO24rCUcuN01+g4wsz3P1HsgUz3nOEFzE8fTSu39pMjS1Y1msuGmiWBVLLZ2rC6HMzBnHhBwoRyoY/cHsc+qSkQ2N62GMfa6cFKaGnPiGPjTwVPx5jQOCu4B00ADTcpcQ+KYdPENLlD82MHodmyq5jnC5zl8msivDiEC1eKH7LFJ0vdcGGwAay71+CF21XppqvNMkGr8QWReq6Y/qSZtTWfQTwqaQm6yJjfAQ6y5I2xKBZNxwISNN4qMUF3lmiuFT4RbUWTsyP/kljCanJ2VdmZXcSfDBjV5JfVHgMGHWsI5zTiz9sYKYxxjIaSpywUJCdlKVlNRYFdTNbAmq5AiDuMhXccJlhVbeYs/IPzXPkWUS4PDWF49PBpTCr+23LX5+eSGmd3FUO0kqc7tfg2aw7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(83380400001)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w+RfHLSNZqvS5NIj8d4/8gnu/Cz+FPQRFUCgo9Zavb1shQqX64nDKs/qcbr+?=
 =?us-ascii?Q?gue5WTWPiHcsH9kSq5v6J5qz9zg4XBW7J0nHBuF6TN8EKaUB14H1pqiNqSxg?=
 =?us-ascii?Q?UdbHR6ClhEK8uy6abgyP95qSariXYDtx7IyLSDWCwxXqdlL4Ko6ZMgWKgbu0?=
 =?us-ascii?Q?bdbtacVORRlnYplMfI2FOkoGVHt/0ibjjq22W3yl42d+Hm9Um2JvHGjzlQY2?=
 =?us-ascii?Q?uW/Z+ygF2QMYeC9a9w14TyyzXA3jBOYQKBpsBvwWVxJuXu00hT4ex9h5wDfv?=
 =?us-ascii?Q?RgRbTKNL8iDU/FmuYSAMamf78aTR6Uya7UcNrJR4uyItJGs9uOUQHzbRlAMN?=
 =?us-ascii?Q?iCV5WKOgVdJksb4MB82fSe5ketFSnjgvUMheSrY/8UqI6jM4geX/7Um2joJC?=
 =?us-ascii?Q?1EpvUttc/7d4BLFEzmwQrrwZWKghplfI2XX2cl7Fi4kJYwt2hFzrehddPBQJ?=
 =?us-ascii?Q?lhjctenJuX0Xlth2nVi367wm1QrbcHp4Tfd7qP90odGrlCgtBSRgNSuwjpzZ?=
 =?us-ascii?Q?lQSApIHiBWweSjDu7S7bEkHYhkw7N4BEdsBVSPftVPkEBGWk5v/7zFQHwlrE?=
 =?us-ascii?Q?0idRHQSlTRIVSH22aoyROvj3D8F5+X6qL/HdoG/c+F+CR9kSyr6lIy/CZs88?=
 =?us-ascii?Q?JvuVl1YAy+NTxOTb3eAbYru9TfzrTqc9lcSQt5SRIRrBxJFEpyYbT+M+T71M?=
 =?us-ascii?Q?wLBzm5+SEkNbqQ2j9FPz21KrwTcaIzT+yUIE2dILbLQraekdzjFK7UMwJyeU?=
 =?us-ascii?Q?q87sux6rDwj8sJmKFrSKBQMPjIFtISqOFXRAcQTeVYzCZMvJE5J034++2+lt?=
 =?us-ascii?Q?tbgYbjqwhRqU+mXcb6+LjovMcCyMWvI04ROtojdX9mr/DmYR/48+IGbicIak?=
 =?us-ascii?Q?8S/8AfdqeiOABPQXXoFk04feJUg696r2gLEODAWOhAQulPrc/nq7BtBW0eYb?=
 =?us-ascii?Q?898rLA90UVbedr1yqWXDGMHPacWkjisAhck//tsC2ynfeSnbxUxVpiK+3Rmm?=
 =?us-ascii?Q?NgTQkBbxuLoNamEZV3eP8uQhl6X9BzG4PLYdZlGjzrgRu8yg6U7eWHWtknnd?=
 =?us-ascii?Q?mqoYUb+prpW18Sd6GxjS4zOmq3oqWQCyKhU/fXRAqzOs3DqEXe1sJV6qhWP7?=
 =?us-ascii?Q?iPNSaYMMLjgqJ3gMMpb8u+jnzOnDOciI8jej7hTAGDJhRXiyvilgIo3wk5U/?=
 =?us-ascii?Q?Asf/bw5eTKyYMmGl/LCsabT/AY7xy8taWxZnm7eyy02q5iUkp35eHi/BNTqZ?=
 =?us-ascii?Q?wLBYbuIB0EeMt3ofbia7Qg1UlejdJbUrXG7LJmcM8weEtlNNsZ9q5w/ts/JI?=
 =?us-ascii?Q?dW/rDjQ4f52UaI1vlK3dX+Jp4wuBRMmspwfmLiP8o8JHv8zWkQ0XrgjY+ZuC?=
 =?us-ascii?Q?mK9PM1ZjGDQjKPwy4qzUyINcNtMj17IraZUaRTNR1XBX090bi3ImW8C85vgH?=
 =?us-ascii?Q?/K1Lu2FkgbERABPyNZpxsFzGhYh6CE2qAay5gzzTVBmmrDBxRSvFoTlF5h9w?=
 =?us-ascii?Q?qiIs8yzEOqWx0rcu2QhqqEJ/+TFCsfcP1z1/qFo8laqhxYsxrIEIeFT04/eZ?=
 =?us-ascii?Q?DPewRaIuytFt0p3h0iXS4N03r68wC71pinTi6R474EI6/5ewzFnMMCXKVlZR?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1ebb80-0e7f-479a-f8ac-08dadb1b9c7f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:01:26.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLOs7CYuSxAjU5zI37ytcMlnRN8Gv1zejDqqZJSMAGU2JlroRMoNhSqSAXIEPZxqZroivUKXEUiH+Vcij5YD7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

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

