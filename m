Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85542EDA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 05:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWmpaPBOLRoynPtagcZcvqfKpnxTmEiQdkThbdGKoovaERGSMzi1xTzq3hIXUSX/acznR1jtjcLgSnbILyoMoOhX0bFcHPQ9XFi2oAF6yRqyXdahR5JqkCk074zg1XHW/s3end8JPDCYzW/bZB1Nm3MC1jLpEOuCg3qOW6MWgmNS38rxs1D+vHwh0xkI45eK5RYX5rmVrppKyKYyrmc4NcSOglP1FCBw1EFl+jG1hGAb1u7hPRXoSrGiYpdgTMWEm/J3HTHX7WG3NFpSDTgDtAzgUMkTvmQeaeqm9BA+XODZ5+ZtrifIaFkjmOkYsW5WEsHkM85Nv0Xt2SmNy5mTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaVNuBYIi8VBKL4rni6EkOtT9pkzcaoG1LgUEzuzbFU=;
 b=mOjvoj8avg6WQpVw2/M+Oh8eK10XVXZmZn9FkCWBwIrbyb90fs6ZcY5DDyr8ec+89l07IjXD3iTDI6GuUN5AGx8kYmvbpJC7m5nWbK0EOBYbT3MuQR/M8T8sTWbqgJC4gj+lovGOB4h2jKVBcLjaCYF1X4uvrtVUQkgJSceriq3OsH2kfkXTKYBsEbpiqbCd+pmOaXT0TY+SPKvDoiw5Z8a1Z+X1e6ye+sDTXtuvKkgspFrwXFDDS+3lt+AcJO+RspGR6PceA8wAzY1Vmyo9mIzYAJdkY9mlkqMBmdZcJxcLp6rErG8YmyTb533WwOnlUsCVWUjjT/uZq1Qr/y4qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaVNuBYIi8VBKL4rni6EkOtT9pkzcaoG1LgUEzuzbFU=;
 b=2k6TAE6hRw920le0haPnWPDd7UbIpsrnzEj/KsscWcNyLbBnBJM4RobJQv4X8/GyaG8W2zuMBke23BNwb10V88Og3ALmLbyKATN5VB6g2lPQAHrLTcT1bVtoYJEhXuuFL2O7l68WAE7QcCKxVlZGkNkKNGlGevDry6KUd7/PuWnsKF9mSmSv6bp602dlKhIo/lT0EPiJ3HIBFBMKq0CwQ9uK3/UUY39PVD9U3B3yH9OuH9BlDs61dO+/p/l1vJIy2DUj+OwPopCgf1C4AQRdlWbMj0JmcrCXv62n9qJhk9CWuAIMCnUhnpLFi9nRMvDk3Gq15eqWa8B+aj14AdJKyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 05:20:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 05:20:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iperf3] add MPTCPv1 support
Date: Tue, 27 Jun 2023 13:20:45 +0800
Message-Id: <298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 7620bf41-71ec-4865-283c-08db76ce4545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9zMM9iyM8W5P8++X2C1HNt6X6JMl9ZydHnFdSk1DGWH3cmo8w7XEjJ5bdVhITfhCdAlkV3vnf343nlULtLqwTnfJ/8+nxFKVtvinefFpW8BmJSLDBA2Qr7c2F1BxU5bfQZqDCADRJW+/e7A3vYWz4AZTrvDq2Q4g9HletxlYNE4EWl2OzWVsReqiHxGyw9g2iMFFuAOfLEy/U2vzQs/OLF77phHeereI6Cd+OstpFrt+xfGg3Vknnn0OkdUURa1tui8JLS/bH35zCdA98SxZAEorEN1q7sZPi00C284yfNrUhclvHc/cbGNxwm5zldv8hltolTXNQNO1w1kb3t4eQuHnBpMANGOXXsHROAvnp0sO/h5e3H8238hOaicZpfv1C0KvpPXEC25d/dDtLeMVgqEgsZPc2AwTxkRlM6VXrXJyrF8nQnkM/IGiaLStHsvfwCDRmz86AFzxcZK8NRaNuwP/yUk2W0QhpZ4JcEgL+ulJTaLkPq5ZvFTdgN8frGXYs8orIdgx+XoR3rjI3Q9KLIKKELZFyEYYrO15H0rZGQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(6512007)(66556008)(66476007)(6916009)(5660300002)(44832011)(86362001)(8676002)(8936002)(41300700001)(4326008)(316002)(66946007)(38100700002)(966005)(36756003)(6506007)(26005)(186003)(6486002)(2906002)(54906003)(6666004)(2616005)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qT9eLZ+s0itoiCMTp32xtvxjwcl2pNoivVfoOB7bOtFO1ncJ6h8rYbV10GP4?=
 =?us-ascii?Q?92/w7lCp8hHPX/F4xAWehxoRAvENddRHD1QnMQKJgRumCqbwPs3ReA5W4iJY?=
 =?us-ascii?Q?u3+wgqKawP4qFm5j4OHQdWAWbbV6wetkdCSJlYBHOPNwPZ2u6Y75+YRgrYgx?=
 =?us-ascii?Q?x/RGy242jTqFY1Oqezla+nGKGZJiyP6Ugn3azKbOcdKWS3GHQ2SBDwiv1Imo?=
 =?us-ascii?Q?HI8bGK6wJABuN9eF1VfkPJl6RRCHW+EC0RUU6mD2NdO+UyIJ7tbotiWIC4eT?=
 =?us-ascii?Q?k4DJzmsh4M2FvkSjUAPfLVuxNteyleygrxkub1zRHrgnFX6yfahzefeo4OEH?=
 =?us-ascii?Q?LfUzA5s5RfSc7VKRaa7sVuTVfI/NCagemldpC/M6fNSn9XcDOdv0DzxpuC3d?=
 =?us-ascii?Q?ClHI3O3WXGoFTFGQO4kbwywMsRbWPWuMNK11KneCGoGVB7EXzO8h+l2ke58f?=
 =?us-ascii?Q?12x5FOkYU4ePvGV+GJxYBWepc2cieNA9dehrqI4TCoCvuGZQ/+nu+EXuk8QQ?=
 =?us-ascii?Q?apaNjELchBQimZ0LaCnOe6XnXzPm628i+Q/9lKf+O74reOow7+t0+V9/wdRl?=
 =?us-ascii?Q?05NkUW/e4fxoV+JUqe51bCpVbrM0tzK8W+AGs6EQwYJ8VltGjGlTXYB3KLnD?=
 =?us-ascii?Q?ezq8c+wcc/xsyubFNeLDQ2y/0WgWJnwaCcU7TnpO28LSow9h7GhRTFXMK3++?=
 =?us-ascii?Q?YRl75rD9EQao3e1JmAm5NYkGrlF8I7ZHpEuAKsAEGEMBwoxQHH1bQe3srWWy?=
 =?us-ascii?Q?CgIesltQ+4YCLkeQ/eUaWaD2asK0FxRJydsID2fCaGpxqeRLoBPGIjXiFyXD?=
 =?us-ascii?Q?jUctLGPPt7K25a34GZsgd1aDzlCs8JD0qZK+m/zIko5ZSOl4R2Q3PXGJIGP0?=
 =?us-ascii?Q?HAZm7nNSHY14HdFV59iIUeIdBeItJmKJndtnlus3kw1+xxoPj3fn0j/GfwwM?=
 =?us-ascii?Q?T8xTj+Tx/ZCGdE87Bc9trkw+YCxf+KqVIgsIsLJWWDa2E/n5eadoNHwytK84?=
 =?us-ascii?Q?K1HcAIrgYeQOM81+MbuA86HExjn1gzq6HPyDu4BetRgpusQx0pRGKPPLeMef?=
 =?us-ascii?Q?bBa1j2BY0XflybTr9eEvlZ8QYkCfwLwKuDZkWbrFbg0BDUdhbIJfxoXQEpYr?=
 =?us-ascii?Q?+270rq/3ueyW0bOlYrN6TB4GciYd+QxW2zlBI8tEZxsEFxuKC7VtLIMhBftO?=
 =?us-ascii?Q?cx+hsJt039j3d/qTa2QJT+jXyX6Z/IPPooW8NnuMl6YzpZrc+LCpgVQIjq2x?=
 =?us-ascii?Q?rQL3edSum0lTFMMFouHZAF1BZjF/KRujjIZ+ynIkn2+lSDKkJvBfTCKuHtqU?=
 =?us-ascii?Q?HslMc8N2ViENbKHWIQJSPCCsbx+suJnYASSktJhRYu4j0c0jiPpb9y8dJ0uD?=
 =?us-ascii?Q?TjT22msPTOP6LSSEAQYMyzb5KTIVC70uHUsVTAxMRwvzK4uq0tWO7CyIpn1E?=
 =?us-ascii?Q?Iur0MSpqJLnVzmTkkMI8u9WMurp34pwJW8rMjfJrrWJCsK/JjNpWdMurFLL4?=
 =?us-ascii?Q?iZ9xGlmbpE1bimpstBip82aAU5ZX43ELUzPbgFC6V/sG3z1NNXG0SaezKXW6?=
 =?us-ascii?Q?LoXHGp298FNIlVWkiwlY+L5qfMVdjnmedwqvNUJo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7620bf41-71ec-4865-283c-08db76ce4545
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 05:20:50.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyjlFp/q2sgc6FNQ3DZp6paCx7AI1txdTsKD9tvLgyrPvl9/uZmu8VNNSNW3am3en7oca5SUhHaad/vo/QIF1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in the
upstream Linux kernel since v5.16.

MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
The only required dependency is the 'IPPROTO_MPTCP' protocol number
definition, which should be provided by the netinet/in.h header.

This patch adds a new flag --mptcp to support MPTCPv1. It can be used
like this:

 > iperf3 --mptcp -s
 > iperf3 --mptcp -c 127.0.0.1

Linked: https://github.com/esnet/iperf/pull/1166
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 src/iperf.h            |  5 +++++
 src/iperf_api.c        |  4 ++++
 src/iperf_api.h        |  1 +
 src/iperf_client_api.c |  2 +-
 src/iperf_locale.c     |  1 +
 src/iperf_tcp.c        |  4 ++--
 src/iperf_tcp.h        |  1 -
 src/iperf_udp.c        |  2 +-
 src/net.c              | 14 +++++++-------
 src/net.h              |  4 ++--
 10 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/src/iperf.h b/src/iperf.h
index 0051a30..89af39b 100644
--- a/src/iperf.h
+++ b/src/iperf.h
@@ -63,6 +63,10 @@
 # endif
 #endif
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 #include "timer.h"
 #include "queue.h"
 #include "cjson.h"
@@ -167,6 +171,7 @@ struct iperf_settings
     int       idle_timeout;         /* server idle time timeout */
     unsigned int snd_timeout; /* Timeout for sending tcp messages in active mode, in us */
     struct iperf_time rcv_timeout;  /* Timeout for receiving messages in active mode, in us */
+    int       mptcp;
 };
 
 struct iperf_test;
diff --git a/src/iperf_api.c b/src/iperf_api.c
index a2cd53a..e19ca38 100644
--- a/src/iperf_api.c
+++ b/src/iperf_api.c
@@ -1104,6 +1104,7 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
         {"idle-timeout", required_argument, NULL, OPT_IDLE_TIMEOUT},
         {"rcv-timeout", required_argument, NULL, OPT_RCV_TIMEOUT},
         {"snd-timeout", required_argument, NULL, OPT_SND_TIMEOUT},
+        {"mptcp", no_argument, NULL, OPT_MPTCP},
         {"debug", optional_argument, NULL, 'd'},
         {"help", no_argument, NULL, 'h'},
         {NULL, 0, NULL, 0}
@@ -1594,6 +1595,9 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
 		test->settings->connect_timeout = unit_atoi(optarg);
 		client_flag = 1;
 		break;
+            case OPT_MPTCP:
+                test->settings->mptcp = 1;
+                break;
 	    case 'h':
 		usage_long(stdout);
 		exit(0);
diff --git a/src/iperf_api.h b/src/iperf_api.h
index 171006a..79d19cc 100644
--- a/src/iperf_api.h
+++ b/src/iperf_api.h
@@ -90,6 +90,7 @@ typedef uint64_t iperf_size_t;
 #define OPT_DONT_FRAGMENT 26
 #define OPT_RCV_TIMEOUT 27
 #define OPT_SND_TIMEOUT 28
+#define OPT_MPTCP 29
 
 /* states */
 #define TEST_START 1
diff --git a/src/iperf_client_api.c b/src/iperf_client_api.c
index 5833068..83909eb 100644
--- a/src/iperf_client_api.c
+++ b/src/iperf_client_api.c
@@ -378,7 +378,7 @@ iperf_connect(struct iperf_test *test)
     /* Create and connect the control channel */
     if (test->ctrl_sck < 0)
 	// Create the control channel using an ephemeral port
-	test->ctrl_sck = netdial(test->settings->domain, Ptcp, test->bind_address, test->bind_dev, 0, test->server_hostname, test->server_port, test->settings->connect_timeout);
+	test->ctrl_sck = netdial(test->settings->domain, Ptcp, test->settings->mptcp ? IPPROTO_MPTCP : 0, test->bind_address, test->bind_dev, 0, test->server_hostname, test->server_port, test->settings->connect_timeout);
     if (test->ctrl_sck < 0) {
         i_errno = IECONNECT;
         return -1;
diff --git a/src/iperf_locale.c b/src/iperf_locale.c
index 9eec77b..0f854f3 100644
--- a/src/iperf_locale.c
+++ b/src/iperf_locale.c
@@ -124,6 +124,7 @@ const char usage_longstr[] = "Usage: iperf3 [-s|-c host] [options]\n"
                            "  --snd-timeout #           timeout for unacknowledged TCP data\n"
                            "                            (in ms, default is system settings)\n"
 #endif /* HAVE_TCP_USER_TIMEOUT */
+                           "  --mptcp                   Multipath TCP support\n"
                            "  -d, --debug[=#]           emit debugging output\n"
                            "                            (optional optional \"=\" and debug level: 1-4. Default is 4 - all messages)\n"
                            "  -v, --version             show version information and quit\n"
diff --git a/src/iperf_tcp.c b/src/iperf_tcp.c
index ce6a522..954c299 100644
--- a/src/iperf_tcp.c
+++ b/src/iperf_tcp.c
@@ -194,7 +194,7 @@ iperf_tcp_listen(struct iperf_test *test)
             return -1;
         }
 
-        if ((s = socket(res->ai_family, SOCK_STREAM, 0)) < 0) {
+        if ((s = socket(res->ai_family, SOCK_STREAM, res->ai_protocol)) < 0) {
 	    freeaddrinfo(res);
             i_errno = IESTREAMLISTEN;
             return -1;
@@ -375,7 +375,7 @@ iperf_tcp_connect(struct iperf_test *test)
     int saved_errno;
     int rcvbuf_actual, sndbuf_actual;
 
-    s = create_socket(test->settings->domain, SOCK_STREAM, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, &server_res);
+    s = create_socket(test->settings->domain, SOCK_STREAM, test->settings->mptcp ? IPPROTO_MPTCP : 0, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, &server_res);
     if (s < 0) {
 	i_errno = IESTREAMCONNECT;
 	return -1;
diff --git a/src/iperf_tcp.h b/src/iperf_tcp.h
index d53b052..3071cbf 100644
--- a/src/iperf_tcp.h
+++ b/src/iperf_tcp.h
@@ -27,7 +27,6 @@
 #ifndef        IPERF_TCP_H
 #define        IPERF_TCP_H
 
-
 /**
  * iperf_tcp_accept -- accepts a new TCP connection
  * on tcp_listener_socket for TCP data and param/result
diff --git a/src/iperf_udp.c b/src/iperf_udp.c
index 5dc1422..ec1163f 100644
--- a/src/iperf_udp.c
+++ b/src/iperf_udp.c
@@ -514,7 +514,7 @@ iperf_udp_connect(struct iperf_test *test)
     int i, max_len_wait_for_reply;
 
     /* Create and bind our local socket. */
-    if ((s = netdial(test->settings->domain, Pudp, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, -1)) < 0) {
+    if ((s = netdial(test->settings->domain, Pudp, 0, test->bind_address, test->bind_dev, test->bind_port, test->server_hostname, test->server_port, -1)) < 0) {
         i_errno = IESTREAMCONNECT;
         return -1;
     }
diff --git a/src/net.c b/src/net.c
index 1a88155..c0d185d 100644
--- a/src/net.c
+++ b/src/net.c
@@ -121,7 +121,7 @@ timeout_connect(int s, const struct sockaddr *name, socklen_t namelen,
 
 /* create a socket */
 int
-create_socket(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out)
+create_socket(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out)
 {
     struct addrinfo hints, *local_res = NULL, *server_res = NULL;
     int s, saved_errno;
@@ -130,14 +130,14 @@ create_socket(int domain, int proto, const char *local, const char *bind_dev, in
     if (local) {
         memset(&hints, 0, sizeof(hints));
         hints.ai_family = domain;
-        hints.ai_socktype = proto;
+        hints.ai_socktype = type;
         if ((gerror = getaddrinfo(local, NULL, &hints, &local_res)) != 0)
             return -1;
     }
 
     memset(&hints, 0, sizeof(hints));
     hints.ai_family = domain;
-    hints.ai_socktype = proto;
+    hints.ai_socktype = type;
     snprintf(portstr, sizeof(portstr), "%d", port);
     if ((gerror = getaddrinfo(server, portstr, &hints, &server_res)) != 0) {
 	if (local)
@@ -145,7 +145,7 @@ create_socket(int domain, int proto, const char *local, const char *bind_dev, in
         return -1;
     }
 
-    s = socket(server_res->ai_family, proto, 0);
+    s = socket(server_res->ai_family, type, proto);
     if (s < 0) {
 	if (local)
 	    freeaddrinfo(local_res);
@@ -230,12 +230,12 @@ create_socket(int domain, int proto, const char *local, const char *bind_dev, in
 
 /* make connection to server */
 int
-netdial(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout)
+netdial(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout)
 {
     struct addrinfo *server_res = NULL;
     int s, saved_errno;
 
-    s = create_socket(domain, proto, local, bind_dev, local_port, server, port, &server_res);
+    s = create_socket(domain, type, proto, local, bind_dev, local_port, server, port, &server_res);
     if (s < 0) {
       return -1;
     }
@@ -286,7 +286,7 @@ netannounce(int domain, int proto, const char *local, const char *bind_dev, int
     if ((gerror = getaddrinfo(local, portstr, &hints, &res)) != 0)
         return -1;
 
-    s = socket(res->ai_family, proto, 0);
+    s = socket(res->ai_family, proto, res->ai_protocol);
     if (s < 0) {
 	freeaddrinfo(res);
         return -1;
diff --git a/src/net.h b/src/net.h
index f0e1b4f..cd0afb7 100644
--- a/src/net.h
+++ b/src/net.h
@@ -28,8 +28,8 @@
 #define __NET_H
 
 int timeout_connect(int s, const struct sockaddr *name, socklen_t namelen, int timeout);
-int create_socket(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out);
-int netdial(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout);
+int create_socket(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out);
+int netdial(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout);
 int netannounce(int domain, int proto, const char *local, const char *bind_dev, int port);
 int Nread(int fd, char *buf, size_t count, int prot);
 int Nwrite(int fd, const char *buf, size_t count, int prot) /* __attribute__((hot)) */;
-- 
2.35.3

