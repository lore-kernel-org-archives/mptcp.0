Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477A64C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVOD2Gy8zCGgOD2QzNScoO2Z15qodUIsYgodKoq23+Fgd+iSKHgmquWv3/07SVn/1bcrJA/wFTQfErv4vHDPDaDX3aW6TKr4CcQZt7mb6IwDnYUnIUHfEjfkjsWwuCNXfoTAdIk5nBpsg5ymImrOrDuVxb8Cd4HpJv7Xn81r8fjTtPQ4bB6aVx61I4CEWyA7rJYJ385ugBIZzbR6NsXx9R4nBQihv771UujSK8ckk5Iw4j9Rk7+Nr2BfZsYGbcLuT+BolQyjcyW9W+fxIle5YlRCIRQJRDUvRRSm0+ucXl65zUQ7dKm26af4BX+p7DF3KC/+3jJ7IwD6Jw8cYx85zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93tIdcG1bhCwX7KFZPdNPa2caXUSOyYClQi0J9XSO8M=;
 b=YiPvnRyhSsx3PlJxZL8bI08Spy9OYKXovr9f1yCXwtBh7Xzeg5XEDh4Q/NgC+D6t+G2G+ZgSdRA7xwvu+uFk6I7PO9Mb4jqF+0JdUinorh1t6y98i9KguYzrTovtoIFNRIS4zWvCFcZq645MVFIGLQtL7cSSsgrz1drU8X7F9GQTo02+9jzClwBYC0LOhP6DcINydGgw07vRrTu5Aj1Zriys7NIFjppsU2imR9RZ8/S9Vl7vgSjPQaiP1x3A2/bHkfD4xZBM7C9HZlyxajrKyEh5D44AdwGy/Wu+IuZJHi/hgh1JfBDwLwd20JWdXz1J1A5LMbrYQ3tYKW1SQiUoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93tIdcG1bhCwX7KFZPdNPa2caXUSOyYClQi0J9XSO8M=;
 b=Gan+2K1yF04tcIH6ltH4gEjlT20kn9RX2Z5d0uIUIlGIIbdukD479ssOLzHN2JkEzwSInal/e2xbuTOhYs+fzxd5Tqyw8/ZWkKAAmqz4ey9wEQZtKwCBvVRbU7LFAHUpOn547MSfoGqVUmM7We3YzAWgZoT2Qr8rfVg1U2vqkJVR9frRvdsBhZNeV4Gv05FDsg4mUSpIvggORFtWi61BMjZtuwe8UkW0h489pZMNR1Cn4riRD3tr+z9eOvTyrvKp9YtLrZPrh4A6P6zOMmkA9wFne9qeojMWRqsmETqYINo7sDA4ePCML5hDlIjreHPW81UbsnrILyDKCdZMuPhD7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 08:40:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 08:40:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add bpf_first test"
Date: Wed, 17 May 2023 16:40:23 +0800
Message-Id: <605ac80d58b4d089b74b6eedf003a43862c55b61.1684312597.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
References: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 40abecf5-ca19-489d-37fc-08db56b26d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UQ10ui7nh1ISb3LxfSjaJM0Sjuyo8nVmOCWPX69OBj5m89pvozQof/pZ2065Ds/2Xxc0eo1VNkkuif/oDHO5N32LxPYXnnRrH8ppOmNWVBR0ff7C89a6m4AfVVa71VD3mcf6HMl78jEsUhox9aR3KFtCZPHXm9JWnmq26YsQLINrKBZlSnQdtC7hgvwOJrlaQsidBmpRq7RcBl23v/E7g9AgnVW7cgYOpu5l0cVwi6rhSgv0QRGWJJP4KdOOeSITzw6rKos8slvNGbEb9f1L/C8rZbaRGXj67QOaGWlF2WHKO98vI5WuJzCNA7EQSXSp5L99NNh3ewJdpYkZ08cMaH7wTHKtwv0uvoeoEX8HHXenr0ljm6bKyfl65NMRfs7cU4/qkCcyfXMxjhKs+LmlJ3IRavpWCTBbsmd3D6guVSioscJXIyzULaWskwTM0GEknfRXrElirBvzigeJk/ZpO3jehZzz1c8/bXhTgpsUdAimaZBDMi+y5M8K8JxGT8dZVlLwly1x5Gr8oqvGnLMPP9vZwZZeezIrIqeG1d30WH63XM5/YjMA/6fgYYO3vZYN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(83380400001)(4326008)(36756003)(38100700002)(2906002)(44832011)(8936002)(316002)(5660300002)(8676002)(66946007)(6916009)(66476007)(41300700001)(66556008)(86362001)(478600001)(6512007)(6506007)(26005)(107886003)(186003)(6666004)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngp/4cmg0MQC7pkSsWfimEVkFwleBZFCUHqJa3cVQUmEjy++IhQGZtlvyitz?=
 =?us-ascii?Q?v5zTjCFh1vL2rT6iAxvSDQxMlLp4XqDfsjRf0qElIsDDdReyO4gX6nxrmCHw?=
 =?us-ascii?Q?zQfYVnFUmUawBOj/vBk2mipqh7SooD7vcMfE/oGSHqgTRYULFzU/vkEq2wNA?=
 =?us-ascii?Q?J26StyiZ+jMDvzWgagM6TmSjAgBkLdeA5HzAEAe4EBY6R3E88/hZQjZJyeV/?=
 =?us-ascii?Q?xjk5UUY2bLNJ26k/qo3NL/hK+n/Yntf/Zxn++t+1wXnkDlgCIK8qszqUL/P9?=
 =?us-ascii?Q?csarzyZhSXi1nOiWzcGsC2TPCJyZb+xnKOsS+Z/Ko0IXG07ITr80Xd6xzjs4?=
 =?us-ascii?Q?1gyHBwjGoDHpLgw/hZgns7YL93YT/oeeXHVDMCswC0cZaN8D/DFGRWW9qHlx?=
 =?us-ascii?Q?KzGccar4oKZUB6PLuaXKnZALU/S7mY4iAeM1JmyvMAx7IBKfXXAoQof7Fcfe?=
 =?us-ascii?Q?Y27RGbGMCDDqzvdoZ4NWNfqqEsFO6oAMpvRfBlRM9Jj+3JKnRJJ7fMm/4/3x?=
 =?us-ascii?Q?q+gXFda2mArEyQEs3prkiYW8a+6LAVgvYLvCu2igENp8qF5EZ9CyJDudtdis?=
 =?us-ascii?Q?ZyhT4EpwcKt4Nx1AhEXl1dL8Q7MWY3m2cWDe9djwOSvsDFpee3OZ78kxC60Q?=
 =?us-ascii?Q?NM8RPK4qiYAHhmYVXe7QCXaLgNAQLNyTbS8AMgTa29B3mOEWTN6Uv6JsVLsW?=
 =?us-ascii?Q?ufcJ7/EIEWFB23hS2YHpruEK7PPD1rDPRMyd9dautIOvWqE6Le6GL1SU+zX9?=
 =?us-ascii?Q?47YaoQlTtKBN6zdkCRverr1lc3ZYHBL1hPB8jQoWH494BD2lbq/ZUytouIeK?=
 =?us-ascii?Q?qGY7xx5yDKm1busipMvFSmYMATd50OiuBsxFAlbJ65SORh1u8kwHivrqwlP3?=
 =?us-ascii?Q?rcqgA2pTCDwloXIXrUWFpQFOqfsky4SQawJwMTWxJxZ6/qEoaIfS5Vm0hpGh?=
 =?us-ascii?Q?lsn0s8/gjVQ/7fwlCwA5AbJ3NOpCYo8UzuPQ1h/v+fyA3ourAt/7ugYvbLkO?=
 =?us-ascii?Q?AjiEb2QfZ6nIdPlra5w/Use8hmYmcPtSjkYeKryHYLVRak9z2glw5uT2MpKl?=
 =?us-ascii?Q?d3N0y723UYNW615NIUSAkG79KjD4tqHcJiqwYuqEBPZATSwERCWuk+cj5nrP?=
 =?us-ascii?Q?ZHX0vh1ZnEcep+Mm+v5ghgz/nyTsOuoQZTMOQJM3Q8B+wdSat7sr4RNZ0GDt?=
 =?us-ascii?Q?YZ3Gmi9a3qUq8T2yKZcnypDa2A1xOOB2rxAYOAbVY5GREugJPFZwTHyT28O5?=
 =?us-ascii?Q?EGvSyie2bilwtwbJjAoX0w41Q3XNVaTy8Xje5lTyLYOIxDA7cLJhsTu8ITH0?=
 =?us-ascii?Q?OEoHH5mGgXVPRuzoaxRvnMXsgb5Khk4XrCdozD49jcK1zBrLHSP2tMVajiqc?=
 =?us-ascii?Q?ve9SC2qufW8sLOlhCtvsDyzwunx+ZmydXFM93fpsEt2rW/TZ+wogUESMjVOl?=
 =?us-ascii?Q?byUYMoz+pcmanqSsHXFI8lVrYa18G+1BpNnZonXHeAy71xy868cRPIZm6Ke8?=
 =?us-ascii?Q?OsTlJYpe7ECZO4GvQhpHMlugQrod63CVBIOgMKHquu566sAxK4ZTmr7e04/m?=
 =?us-ascii?Q?6fdk3fiD6m4vudUDP0BwcaaU5Ox9aYni9Q15W8aw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40abecf5-ca19-489d-37fc-08db56b26d15
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 08:40:54.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liIx6gSQ0FMhMZkEB85dL4lDEflPTfdacOgNFV5rMv/5owvFitQsIbyWPuW5QnIMqZw8wqIZkYAv5uKDBXj0bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 50 ++++++++-----------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 77a6997fc82f..bea9c799a531 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -253,40 +253,34 @@ static void send_data(int lfd, int fd)
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
 
-static void sched_init(char *flags, char *sched)
+static void sched_init(char *ns, char *flags, char *sched)
 {
-	char cmd[64];
-
-	system("ip link add veth1 type veth peer name veth2");
-	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth1", ADDR_1);
-	system(cmd);
-	system("ip link set veth1 up");
-	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth2", ADDR_2);
-	system(cmd);
-	system("ip link set veth2 up");
-
-	snprintf(cmd, sizeof(cmd), "ip mptcp endpoint add %s %s", ADDR_2, flags);
-	system(cmd);
-	snprintf(cmd, sizeof(cmd), "sysctl -qw net.mptcp.scheduler=%s", sched);
-	system(cmd);
+	SYS_NOFAIL("ip -net %s link add veth1 type veth peer name veth2", ns);
+	SYS_NOFAIL("ip -net %s addr add %s/24 dev veth1", ns, ADDR_1);
+	SYS_NOFAIL("ip -net %s link set dev veth1 up", ns);
+	SYS_NOFAIL("ip -net %s addr add %s/24 dev veth2", ns, ADDR_2);
+	SYS_NOFAIL("ip -net %s link set dev veth2 up", ns);
+	SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", ns, ADDR_2, flags);
+	SYS_NOFAIL("ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", ns, sched);
 }
 
-static void sched_cleanup(void)
+static void sched_cleanup(char *ns)
 {
-	system("sysctl -qw net.mptcp.scheduler=default");
-	system("ip mptcp endpoint flush");
-	system("ip link del veth1");
+	SYS_NOFAIL("ip netns exec %s sysctl -qw net.mptcp.scheduler=default", ns);
+	SYS_NOFAIL("ip -net %s mptcp endpoint flush", ns);
+	SYS_NOFAIL("ip -net %s link del veth1", ns);
 }
 
-static int has_bytes_sent(char *addr)
+static int has_bytes_sent(char *ns, char *addr)
 {
-	char cmd[64];
+	char cmd[128];
 
-	snprintf(cmd, sizeof(cmd), "ss -it dst %s | grep -q 'bytes_sent:'", addr);
+	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it dst %s | grep -q bytes_sent:",
+		 ns, addr);
 	return system(cmd);
 }
 
-static void test_first(void)
+static void test_first(char *ns)
 {
 	struct mptcp_bpf_first *first_skel;
 	int server_fd, client_fd;
@@ -302,17 +296,17 @@ static void test_first(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_first");
+	sched_init(ns, "subflow", "bpf_first");
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd);
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+	ASSERT_OK(has_bytes_sent(ns, ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ns, ADDR_2), 0, "has_bytes_sent addr_2");
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+	sched_cleanup(ns);
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
@@ -334,7 +328,7 @@ void test_mptcp(void)
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
-		test_first();
+		test_first(NS_TEST);
 
 	if (nstoken)
 		close_netns(nstoken);
-- 
2.35.3

