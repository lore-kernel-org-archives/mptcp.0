Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F514F80
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 10:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4SESMQ6gaXfhrbVBmL4T/Kt0KLNbYVYu5JMoasLfFQwCR2zeL4XCHNWx1eo2zq8CtREGM3X9IsuR0aySKJg7DpDdMz64SD8A/7jnEC09aHZNyZ9zYnwOy1m0ys9ml44NlwHCtM4IfeNMdKdRUpZH2+YssNZLn4r9pcX5E6rr+zNadeiL4WTGIj9omyim4IpqqAL42IMgDXGiPizAgAdneNb8HUdID9sf83vpNbbGd38y/Pn0zHxRS3xJo3EgdmEKmTd2eNHAcwtMqzRTREbZZmH1M7DZgG5rlW8EIzNKFTyVb6QyYdERmRvrgxqD3zAe6dgWpjM/QYJ7oMSwuUsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViLjKxCCDd5TyyYnIS4+Pcd3howOc4PZGPJYGvezrIk=;
 b=iORfkkhg4zSSsVBfZ4Bfp0cKZ0d1cS1prwa3ef9R7aTwwxubtD9TGvfH+OknxAwAzeiNmXpnt29LCKsI7SVmDCnvq4iwA/xKSuIcLLHKny+kTFdwQ+SOsHNF1KE2gR66fYhWfXXTLN1NK0ysR+p/41egUYRo7USdi5RpyhQ2+70lRpJuCREYT9qaXo3WvH4FcTSiz3bmRxfW8n5I1ghk+PFTrYk0uassaMxh3v2r2/oU0XSE3lS/DlF/Z+RJ7Ovbva0/qJtMgTQnrWs7QNakxjhDXAwZC/6bU+Ir24UdYoqwmB/bQkr0PNH/AHTPb0CwzTcLyCoDNAJ0+6ZGlrM+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViLjKxCCDd5TyyYnIS4+Pcd3howOc4PZGPJYGvezrIk=;
 b=3evsGKUMRIkkXoQLudJeqVsUn3YuQy16wkjAz3Cc7i2TX4ddAO8KXzbByqHGUgOz63VL+MJw7jF0piApnzb5VjXIRAbGyyvnQb8GEMW7yyO9Pil3rt6mcCSrX7jLbIM+0HY/GTds0di1YNkckrsCtR8wNZPloU80E9BPztncgYnw6lP8ruSvRIEoV0VuiIqJ1m+jRLSoBKCg5Z8G6sVgdP5UbnH5IvfKmENd0J6UKWCAzqFbvZVUX0rA4iFC4rACDjkmqc3R3YUdHxfpAQSO2v7LpVlUW4dVcbQxAKeaQqeiqhC5hAmJVq6UaOSra/YfGJLhPBDo+/399mgeCGiChA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7608.eurprd04.prod.outlook.com (2603:10a6:20b:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Tue, 29 Aug
 2023 10:10:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 10:10:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: update userspace pm test helpers, v7"
Date: Tue, 29 Aug 2023 18:10:46 +0800
Message-Id: <013071003d63b701c3529ce344d70578d22b5fef.1693303834.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: f966ed53-4171-42f6-d736-08dba87824eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FVtC7zgY2mpz7Cr3YXxR0kTa++OixZHuFEWsdfSlarhMTyDTVz8aDtzN9KzCXfu1b9WlGUinbQIKvNdzEJR6XnJF8AkRfGiJwKkiBSUAdW8u8nxqRSN+2tjAIfvsJgN8jHZXYK92PMtBaiQKS/j0r5/thG6qAKw04AGvUxLXYZqD9w09Gi5ms+QvzCso69ri99qkRRg5nYNSUWQeyL5fGYKtkRXTBf03k/lf8eMr1POmBSSutcTAUjcvQU5oZ8Xa5NxnUxlGIwYuWn3mKOSwaYcuIQb1TUAcu8utTRFc2Nu8YEemcn4SVnurlJlnaLk11GIWauwFjo+s86YF0hOvwq1Xd4ujhtGrE5Ywtwo2Nt3qD5H5DxRUGpoa5IdA9UlJufrfHjFQACw03iNG/TMUjJaF7ch5VIvP0ZrR3omgO6YPStnheP8PATMV9CvNWp8YwKR6PDB6ATccukseHS4suznnQmXt6wYfAGImrWvabAXkJx60OMAX80o5MxIgDUK7+w+L+JeyPiaY/zstUxyRcme9nhwxSKBHYDJ9/G3wLfFfqTe/yMKpkvdyEW5UrVpbuKNP7Pdwhn59OJXX/JufrcrbexITuR7OZDjrgdCw6oI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(6916009)(41300700001)(4326008)(2906002)(83380400001)(86362001)(15650500001)(2616005)(107886003)(26005)(36756003)(5660300002)(44832011)(8676002)(8936002)(6666004)(6506007)(6486002)(66556008)(66476007)(66946007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fImAgXZ4kFvhPt9wdm0YqPWOTz9mEwm9T+exV8LKkW4lMxMyvpMfZaQVd4dy?=
 =?us-ascii?Q?f2YXBv09IqA6WNfJngFjS3haejhA3843Smguh/beWSODjY1WE1Gjs7OBOH/L?=
 =?us-ascii?Q?HJR41Xu/3rcApm+xzRgoiCT4OiOWZlKZMGiIqjlGnwfFjux406gxluXPWH3V?=
 =?us-ascii?Q?7UkrFa3abzzPjl2TkXT1uF7+4v2V1Sz8ype0IapvvSdQQJzckftcfsnkD5L/?=
 =?us-ascii?Q?c1X8s3x8nLwgH1wBvTLGwHdBvtMymjXyWsMx6rBFSYFmdS8YF9YvXblq0kKC?=
 =?us-ascii?Q?maiWqaEA7+iggFLMVtjIHq6t85OAdy3Ari+lq/IWSb5qhNiTmbckumGr8Lnz?=
 =?us-ascii?Q?zV9o3EIP39sG/U+aiVOVUzuO09ZxCaGgOw6Gmjz4S6g5lKAu+GJtLDupOWgE?=
 =?us-ascii?Q?9l52areMuYq47K+aHJPEndBSfsWWKz/kq2oARQpFFej+zLA8n9aGcZp4+kwf?=
 =?us-ascii?Q?ed5h5uesG1OVS9rf9mlU6mhiuKeEmmsK2H1LydtMVYHf8G0JObIyIneZu+/K?=
 =?us-ascii?Q?4C9frxex9c0gimn6o4mLRb3FSkfMFLHT7sA/BFuMS6CwnloBuO8SWC18w2RQ?=
 =?us-ascii?Q?x9L+OGYgiQaNK8ciC3U3AItn6TOAU7X01+unpSqOabjzlN5jZBKvdJNC7boM?=
 =?us-ascii?Q?oLcfv/TuBfJPR3thDLj6gnjVOCvrpDP0Q6916mElperRUzgRnnLo0XTZ30G9?=
 =?us-ascii?Q?++tLDEYgZwTt1/nUJqRjSzfJFAhmhJwZe1AEsX0bFO7pvAkOXyI9WEZFFRix?=
 =?us-ascii?Q?115mB0zlY/0uK2pB6a11gqBZC06n+Hsa+43ei2LTvarC9YWml0vietcQNpoi?=
 =?us-ascii?Q?yp6V+vCVjiaf5KHX1IBCbAfeBL+VsRaC6DA/HQgDztT5uMGm2RWHf5LFzQ8e?=
 =?us-ascii?Q?ZvTrBmvJcyXKA76MUVMxdTJKEuco07M8OrL4bI8LBI5UaSLVUK793VFu0Lk9?=
 =?us-ascii?Q?TvhBwVm5l8M6e06J3WiJVul7+Z3Pncj6S8Gziq/qLF4QfmbaEBOYHSrEV1Ll?=
 =?us-ascii?Q?BwF9wpQa2K/m5577QbICHjk3ejRHh5ih8SGlDIH5svZW+aq+USpSt5rHjPLw?=
 =?us-ascii?Q?WCGz0QgXWspemFsmlHiH4E5VNbgV9ykuk9QR/ymmSMYQBi/sk4mfKZ4PnsYV?=
 =?us-ascii?Q?ydWViRjLAlMOs+l8M9pAqoIz44vZ7WbNR7yHS35bpdZqHgv33ZXP7lEl/Qgz?=
 =?us-ascii?Q?wniUPzPfAe6rQOY9jf4knf2Z8M2yGDNTRyaeoUbEWflz+gFV4Nn1+EMq3F8v?=
 =?us-ascii?Q?Wokn9DRCC6sCUkOaeWSBBssNF2NUithQn9q6It7yVBrJQGAY13b+qJOMOK33?=
 =?us-ascii?Q?9R+/uyj2RogtW/EPJ0BYmaX3vMIRmfEyQGr3ZAJcdKft30QMWOUUPb9rv8JF?=
 =?us-ascii?Q?lDxu0VCLWTUTcCge6dIVS6Ua6x5hK5qN/6DpX3XTMVp55pQIeni6cJzJijM1?=
 =?us-ascii?Q?eC8H+bRyvix277aOaTf4wg8N7Gk2khRDFARXVfrKsjt+uHIGSdAfo803EOYI?=
 =?us-ascii?Q?O+aCtcx6hvUA2xOCYNzI7K/thGQWIRzkuzHBIQ3eErSzcZZyuJttgFMHy1jS?=
 =?us-ascii?Q?dPbsePy1HgiMtLw2N7D7TlWW8l116Mc5a1LbcwsB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f966ed53-4171-42f6-d736-08dba87824eb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 10:10:17.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3T7ilulGgBj0anEIoA5R3en/qPeaJOIg9g4o2pNXTEsyQCpUxhy4KTcvss/km+LKlggoD6Rrfc0xjjNGBwh4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7608

No need to move all MPTCP_EVENT_* macros into mptcp_lib.sh, only
moving SUB_ESTABLISHED is enough.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 8 --------
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 9 +++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 983fe4446523..2ebe1692edeb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2792,6 +2792,12 @@ backup_tests()
 	fi
 }
 
+LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+AF_INET=2
+AF_INET6=10
+
 verify_listener_events()
 {
 	local evt=$1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 644d732c64a6..bb95dd967eb3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,15 +8,7 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
-ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
-REMOVED=7          # MPTCP_EVENT_REMOVED
 SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
 
 MPTCP_LIB_SUBTESTS=()
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 91a5a55b2e5d..283c62deb628 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -23,6 +23,15 @@ if ! ip -Version &> /dev/null; then
 	exit ${KSFT_SKIP}
 fi
 
+ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
+REMOVED=7          # MPTCP_EVENT_REMOVED
+SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
+LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+AF_INET=2
+AF_INET6=10
+
 file=""
 server_evts=""
 client_evts=""
-- 
2.35.3

