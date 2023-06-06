Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA951190
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdSM2uR3z7v/XFR0BR5dWBetk+MJ8bmlp0mVsGoFN1ERc/66ZIJHHWdQY9DdM2GlkXVYZ4ayMMM3C62r3C62BR1ohCqdYvKHpCotMJqX2l2iA+5zQcpefKuYmTAUejfmJU5O8/1n4r1E15hXSDaad5uFPt1Nor2CZ3TuzIligvtgD6tQ93a+37hREQ/DGRE1raMcj6fe7aIRH9vYA4omicwDZjji8h7HMojCxSpOCcAm0WWS0u1zAZYl1t1Fpf34WwhgbQyD10rZc9lk0Ery9xfceD/WrZPpuVTGJn2HXkSJYFMyjsFfX0RhLWzoxowwhv8qVAXAfrb9lMmMySPVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=GH69cmLyyKE6uSyVg5kaeeDiPPVJ+HdeCRYYiKkDDPNsoxV38r2ap6CrCIGgxwTH++nIuK2xUgZitHsA9dEgMFalB0KDPy25v34cbmcb9WCwca8++v3fAsdLCTXnn34WONrq5Ct+1pv4R44iOwB5ezsfarOVgzRgAo0E2ZGOv5VEOKxqABzp80BBQTpL4bxeswbhfhdMB+9gHw7cURUHNLz5ycgtvLy3eHtm0OxEBJcM21xxexNCOxTagO8sHRxngF9izYGqijZBrfrxh3J+VOdgA2+vIzNv13yTHuwDJ6XJEcJh+HFlvd1gGRh4BZXCaXg85f1sr60p8hE6wTR3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=Vd+QtuOikjCKIy/VsBZWtV2Z2PkNJtysqIUTv8pEG+T7AwR1hDVzV4Hhr+tk1YYmBTqe1t8cnrltnK+MKU6yXj7/siy+pelidcQwo4yD2UoV3bfmLiTCM23M+hWp8GXEMjxmzKNIOsS58EUxmkob8zhAEXMYLwN0Xfs9N6gQ2ri6prNO/hOiAutZlIRrLv/ifFXZwNcwtmC/rZp2ql22eK2N0DyOmfTPyaTXejazlkAq7D6w92e4Em6554ZW1K0dx78jRP0T+KiBVeNsBrJGxVHs0ZHqzJvgZ7it7+XcXQ1q9XXzwtyAO4Pg2OAhHmfIooAvJGN8D1dMbscUyJ2zDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7120.eurprd04.prod.outlook.com (2603:10a6:800:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 15/18] selftests/bpf: Add bpf_burst test
Date: Tue,  6 Jun 2023 14:45:14 +0800
Message-Id: <aecb2010ace03aef4fed7a1881ea306229bea9e8.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9d2d72-c17c-41cd-ebb7-08db6659d147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3U2EeuBiOS7/HsHd/xQOZ3BI/KOk3v48DtmGIgGbee5p9hPda8LoCh1eOmugD3pUN+RhMzRTwH6IEXMudQLE5cbdCkvsbolViNkWjLkiHBMjdBOUW015sz6SJkxjS5DCCr4q4cGMj+3cMxzq+a6gXiviJw0+ov8mcvDJn8TvwFaFolA8W1yZxhHV5ze80k/qTO0hC+rGMw83XuimsxsAaM4APyAXQE+dpn4PoR47JBkRKIBcjduoNfcuHp36FXL6hrlRAPn5fnGZUkMpJg/ujDHDUhOHUBazy188XEXobXbuwMadaHYDKTQKno4orby9WI2ENOGlLt8dJ03sh4MHftH28TId0bmYO3AADCUKZJFAdIhgPcv/5jNB99l+A/o0hgIfKFvHEdm+3ZBSvV/wYlBi+h6GKxwRAR7Vhr1L+y3DEKuOeG6b7g83ga/YDZrmkhSpv4wawFTXiSZcBRyUpWAkxiAJShDlROORxorCFX7nNSB973zetwmjCK+voWVACH2wk/iHWaivsF3emfmtMquDjyHvpzXo/UCr/Js06LPQ4Uc9PdBza7k+pHS3ZF31
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39850400004)(136003)(366004)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(186003)(6486002)(6666004)(26005)(83380400001)(478600001)(4326008)(66476007)(66556008)(6916009)(316002)(66946007)(5660300002)(8676002)(8936002)(44832011)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vlRz7IVTXr0uCSqndX+hGzZQoUr2ISi7C6VJlnIE3OFWfjb7qblif4Ro4Thw?=
 =?us-ascii?Q?GF1lcTaBI7TcEwHhXvI22PiMjYclkRAtBA9f46VKX/+m8ZbKkXVuZAe7oR/C?=
 =?us-ascii?Q?IIKREngp5pTfebF5SFVlJMuBnfoljNPEb/infpn6mRA3GqrkUhUO/4Rz1KbD?=
 =?us-ascii?Q?JNB0VuzNUeBiIkUWMq0/SPyhOXQLEsAJxbnDsV4eiYwcsePp/U8/V/0y67KM?=
 =?us-ascii?Q?D16A0RJgLESNLRh3rfg0jluYkMDsRd7M0yYmxtJiQz/fUTKjnX0aJCgS9qx/?=
 =?us-ascii?Q?XbY51CPePNSu0k9rY9bQm/fGLZ7g2ui5gfvzW6N78LM3pvU1SRqjWUOqV+2K?=
 =?us-ascii?Q?rkbDyoWKcAObGjfy91GjB3WTuSNlrIh9FNGjojtHT4mfhEpwD8BNvxjVxKsX?=
 =?us-ascii?Q?p6cE4sPNMUkxwc+eSYtD+KGPcqbpky2hJ/ccXLuWv97cFWK5npV9jbgPe++F?=
 =?us-ascii?Q?w8hnu66KDKHJIzsrqKFIDWhKTm+fGl2SEY5JkOzKfblbpLxtCuR7ItdCkHoV?=
 =?us-ascii?Q?0w3lVnQiY5PhgxJgwpQwusH4P42zUUA7ZIxkZ+Z9ML/LOmMtizahSTxdOIoA?=
 =?us-ascii?Q?fn4dnufDK3ewITqwQ/VT4XVWN32sqzYtqma5jDYJy4FCBIZ3JxB9ia8sAXVo?=
 =?us-ascii?Q?JvjJENInobP8PzdN+QXMD/ILtLAoeICeLErhK02VAPUMqcikooeGom5Ku0OP?=
 =?us-ascii?Q?oRrePLZQPQ/e/5eUeuqKSV6gXJyICQFP/2tz7gk495LloeeEud3F4IzJPjYA?=
 =?us-ascii?Q?9mf3dXS7vf0n3SoDbTi0wwXmnOVwpXX42LiwUXBRFlhENj4KiOubS+jNmWWv?=
 =?us-ascii?Q?lX+mxVOAGUTMsIqfonUjGP7tjDmgC86jVP3YI+r/9bd/3W7KC1X6LEf+1wCZ?=
 =?us-ascii?Q?jWFi1thTAJ82zNSdLqdG96M4Dcm7q5tTnWjJqVcVCZYgIXLQ5Om/62y/oysI?=
 =?us-ascii?Q?jUTzNQBsfG+kzU1b3gc2uJ+KYDGr0DKQ5Q1H5hsO8Fv65fBdYm/vkxw3vDPG?=
 =?us-ascii?Q?q8Eyyv5lAli76RghHeNzA5t/evCAQOUZqmlnwctu9Unk/GEskWNnvyFNersK?=
 =?us-ascii?Q?vdFPNk5nEydsIdnXjYEFPhrSkwp5IJtvc8NPAWno8doK+eGxNBaDPkrLIle+?=
 =?us-ascii?Q?5GekDw72C9CKd7g3qSeg6PBQ855MO4B07Y97KnqY356lmY6ARqUmIIBLAxlQ?=
 =?us-ascii?Q?3Tq1nxO2KQM2cWc8UPuYsUhdaocuxoyPt+L6pnN0hOfIOlGs//tcSEtyMRxk?=
 =?us-ascii?Q?l7xESmrvrCgQkdneFDi49TCNWs1zTNbLrdu0deQl2sw/fCniYCP+l3Boawwa?=
 =?us-ascii?Q?dWb5OGiG09sedkZ117mDYgFZhA4rHKZoU64FaL6Q9M5pSIitvl569LccVE9C?=
 =?us-ascii?Q?97biVyYpukdXYhCXeVyPQHiDmi8q4O3c4SM+OW34h9ygivlxmh/48sllJvWr?=
 =?us-ascii?Q?zdL13eKXcG0ZxPlkUv75oUg5WsrlxPTM4DyTGDS1svUq9xJCk8gfWd9UYhOy?=
 =?us-ascii?Q?rx55FU6Hsx3VwSQmHKUKlZFUBIXG2PQiOAKqj3gpR5D/c6b7emJGa+14tH3h?=
 =?us-ascii?Q?G7IGkTbz5QHclgcpMZEG08zZqAuEnCo2h3lJAR7C?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9d2d72-c17c-41cd-ebb7-08db6659d147
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:46:55.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0bbktTngbnkULgO5oPQGPudqa6E8Wj1r/J4/FGglL3xIOqmggcdnoRUXaxGOVuUeAeS7FKDXchNRjGA3deDuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7120

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

