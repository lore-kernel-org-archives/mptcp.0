Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761310F7
	for <mptcp@lists.linux.dev>; Fri, 24 Nov 2023 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g9DsG/Dw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNQ1VqmdZvLsxBVza2Zxj5U+ybE+23ydc+osq5AeCEyghEhOEIMwlp1nTGXoP5BltACTwTA8BteKdRoeBqHt4iWdUSO8v+jhDPzwrxtxP6R7pERT0/adPWIuPxW3iZJ52d0fNczZ2WOtupM4KbBtm163FQP05ahWCrIh2lo7jtKbzH2dTZewmMKEYRziYQ5hMdkCWCU52AU7lj4TAD2L/+zICwuqXtJkVszDs8MlUV6wgooIVkCbMHt5GLlgXoV6i/kMGgyG8Wvt43tAcO+y4obJqdYwVxAQ6GKF0sbcM5FXLWJR1gg+3WdY7DpbdAlhL4UY6xXpAFtIi1hjxFwiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUIWlZ9/Pdb9Jj6fR5EhOTHXS68XyO/LyxpdWukwYPU=;
 b=Uei7znc5HDlTYvGa8BNLsga8RFWw4jMsmxMUznGglEwUkOXxd+ZNAQiMnOpXI0BnjGrmOSnPtJMfYzCEZ+8TvsWVUdTCmPqgM6xJVwahTPXQL4VUlUUV1xliiPggfjEIcmMfjqg+/PjvJAM5d53aItFcp0kWy/0kvhj3eyQHIPYcj72mWjyeEr89TM3xjFyyCXzUlBJgHJ2zTUrG5qBerYVG1NSXbIsMspR0ZI220Ov+dVbgG38qQg9bH8CxPS+Ile6B0aDma8sU7TlK+AFcDHRcLmt0L+DmqE4IH07HqGlKm5fegAiqcjRBFX/KeFl7dAjuqTnL8/6ZrLiP3zr+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUIWlZ9/Pdb9Jj6fR5EhOTHXS68XyO/LyxpdWukwYPU=;
 b=g9DsG/Dw8xhYm4MlTkF9rrXWnq9bL7LKIXKKp+CEb3xEx+XL5Sjwvosd1HF/zEKuwgMZZl4zd72qK1GOoCvyRVci9Jn+48OiidHE9KA30dq+WT1GIdLNFfdI0VpxUuOW7Jsau2kbz9xGCGEgVMMFknCix9AM6hXaL6sZCYU9knmCr99nkVV6n/M5CW5iRh80lGnd4j6xaiQJMXpdQMT8mqXRa2Ai3uOhvn6y2frbPE1e7W971KSFqO3du/KDC7KeQlxYRjz+2SFEpBh9dLBitrKKyA/hDTwYgH/kD3Ht+8eMkm5hZbBOxNmfFHwI43F8TVWm+fRQAVpo5TyoNd4kkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8562.eurprd04.prod.outlook.com (2603:10a6:20b:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 04:55:13 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6feb:6e06:151e:d886]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6feb:6e06:151e:d886%5]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 04:55:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add mptcp_lib_check_transfer"
Date: Fri, 24 Nov 2023 12:55:37 +0800
Message-Id: <f45ddf5a45d0c8052406679ccc6a10e2de0f74ca.1700801705.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:405:1::35) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d0125e-246f-4f50-897a-08dbeca98ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sAt6a8XT1Xk5QfqV+gKo/MytIqQUHwJXnqbWZUZvmu3fBNNw84jlL4VNR7ysM9xhsPNDmgyFJobiWwrIhABlnwbz6qOiNGcSJdKsooHYMn1eyKToK7Gizzd87mFXGceCir56GIFBuvud5FMj67r9/sZrN2yhGRKzUrqbhEuJ/R4IxcsLsDTY0Licav22nu+UYe1bV8aPeMvTPDPwdEQKlXGEjSbDRGYQUUmi39Zcj1Aqblp+U8C17qIs+tOMNl12UpqT5TFWF56LjPj42BBFBPyBAKABSzCPhrAf84VysejwIPGx0BSslfe9FQcaGIdgzs1ioeeQf/ia2hKQdXkLh1jlWNu3PBZUMaWMP5QresTqAbsjrRrOqgveurPU0whotlf/amufHqjAadsygdybveTc/CHauMb8CziEe5BMM3UEneUAoFLag0HE7cD5a/HzFVZxK2PFsKB70XkVJmVKTbz7OGPNsghlvdVZZwHtU0s0H0mt2jkSTxwrwuvJxxPpRNTDEgn/J0D1Z353aYbG5yLQmFPzqLCIL5PAPfCyznljp+WZK3gzXGfRnOHrczEv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(316002)(6916009)(66556008)(66476007)(6512007)(107886003)(66946007)(26005)(8676002)(83380400001)(8936002)(478600001)(6486002)(6666004)(4326008)(6506007)(44832011)(5660300002)(4744005)(2906002)(38100700002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zysyTMwDJtiGsbGH8tKdloxjXoTjFKBxOtpZq5RMA49yTi2s1w0k1ru0g/P9?=
 =?us-ascii?Q?H9EwanAdoCn61mgZBk8fhPwV7Nis/RZRox0GaYt+ga6lurKuIE+QkNnQXw/T?=
 =?us-ascii?Q?S1maQZ5UNxClv8TLK5npNNJOj+yMcfHOQq2CZRHjIsI/LGcMhyuFdJXvUtHC?=
 =?us-ascii?Q?JkZDNCSMADQXLJoXmXfxf8U9x4z2aGznvS+GylI41cyw3MQRg/id8bFzKxs/?=
 =?us-ascii?Q?87mvXt4vRD7vrt3UB8LC6wO17DhSGSZz0VbaZHGThLmL4ejGYfK3qjkBIA+/?=
 =?us-ascii?Q?8LFkpnUqcwaxP9oemaR2g0uBe7bEn7o9RTb5HeL1XUjNkrX6UEwMo/KeKknK?=
 =?us-ascii?Q?7MZPKdftcSkCkIeK14fb24jWOEmDKs77K7wS1V1HMliD+oqPuV7dbA3ewM4g?=
 =?us-ascii?Q?N+Yg8d+v/gZ6/KPdpt3ple5PCw61vi23lXBj/ZlK7HR4TWRTmaIQCWsb+/wi?=
 =?us-ascii?Q?CQtNEUCVomY4d3NBjfTRP7SJKDmVx/5kUfUPv0SVH9E7fvgcPVtbHc1RBGpi?=
 =?us-ascii?Q?M5BBMOOxPbxsDHCQ9d7pRPgYIdUorykryJJWZB+ReWBFQ+LBiHkiAzy+F4qk?=
 =?us-ascii?Q?mC1J751Ll7+3Zw2/0pZf9c1T+SJVBpfgB+Np4hJNieT3xTBCyZCwL4y6KjAc?=
 =?us-ascii?Q?PToobgsEZWtiYtQ4NNdSbSvmQJLEHTpTzzX7Ln40s9zgv7VLIgsjXVsJT48/?=
 =?us-ascii?Q?CY0AKACZbPHkKhrQEcw/xI1eu5rgYWbaECTnjvpG4r2gl1gfOqLAls7asGxP?=
 =?us-ascii?Q?0t42kN10Taq4mSYkQQ5KRbaPWv8VQIYAg3lwDoG/TRUKcZErWgvmwc33Ke8j?=
 =?us-ascii?Q?JVHpj5beIZQEGwOS+17D7tK6CeMBleafr/T9CCY8jumyAIs19x4MHsbCwjOw?=
 =?us-ascii?Q?PRSJxGgbLwHXxd3DyeJRaAx0yQkE9x8+C1yy6d9+wfvjQh/wQ652GBeJgykO?=
 =?us-ascii?Q?GB/HVa1V/NSZUYi/G8Z4uTTt/HEQyd4UfcI9IhwxjpnzkCZlPlv6iZBkfc4P?=
 =?us-ascii?Q?pwtch0pyCZyFUAf7VeAz0XN3k3sA1jR02Hz6sGmRU+td3TKaI875fUtHiv1s?=
 =?us-ascii?Q?JqMAzkfBGOXkwr3bNmZFrphTo8BPuQg3UcpY8tCy5GX8ZTvMGSxoTHTQujd5?=
 =?us-ascii?Q?0Je9bZIBvAmAWVl2gJapJhzXztABvxTjdbp2E64EepRUdsKrufPoWYbEJY8+?=
 =?us-ascii?Q?453dq/Yc5mPh1rVyo5eyekozXEFUDQ5bdYJw+gwog1L6BA0YLpp1FYO845xc?=
 =?us-ascii?Q?+LlozZntrcw9WocArcdGHoMy8NWXttQSvBCiQTNTPn2tU+z7XfYlq2l8PgI5?=
 =?us-ascii?Q?YYsuxJ8vzBa7Q662ZnFCybQyBLAxntfH80URuIigrHl5pmV2jY5Z8Dy7oTEl?=
 =?us-ascii?Q?t2xzaKwj6AKfft4HUq4FRWTTXt9s641fmzqIQ7AQLqewkPo13x2BR32BWJTP?=
 =?us-ascii?Q?lF/60Rm9I9mAYT3P/Mmt0xdZ3UZEFTADl5Qg1pfhif6utSm1EQ9l5DCGeZnd?=
 =?us-ascii?Q?euWQpQqvr/QAHA7jdtfDMmQ6Ftx/AObkJyLrwuX85ya1+oTw6JJiC+WVJGIm?=
 =?us-ascii?Q?a5RI7tBNNPMqq6/hFE2zW9FE4geE30zufK/vBv9G?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d0125e-246f-4f50-897a-08dbeca98ad6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 04:55:13.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfNKNvxFph+exZ8rtfDiNT6mL5X4EhSpwbuiXdj6v3xzjLwDihaqNuumFXRCmUPczuQ79CJjBzOsDGBQwbKU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8562

Keep consistency with other functions in mptcp_lib.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f8be9dd0e20..022262a2cfe0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -258,8 +258,7 @@ mptcp_lib_make_file() {
 }
 
 # $1: file
-mptcp_lib_print_file_err()
-{
+mptcp_lib_print_file_err() {
 	ls -l "${1}" 1>&2
 	echo "Trailing bytes are: "
 	tail -c 27 "${1}"
-- 
2.35.3

