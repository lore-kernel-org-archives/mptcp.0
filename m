Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE9125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ9JZ2xYDR0hiEvb4IKjuIapC3K/Q4I5//fSUltwWTVkRArwBp6KmTGPbgU4zdX+mlSnX9A0URhDE96ztX2GoIRzxhUtBvE2cWI3dYyQFhXDSXGtk60bu7hAYACf1d8rSUGOo1VcZ8PmaYei4Hl7LrNtHN0ECh32XuCqWdHxxNJtMEHL57TnLdR36szsrZCZoclczX+m6wcCTK87GkA7TN94UBbBhQyHI/jg+nhyOnKX3K1Tt3Ua4aO0HLqAh18DgMz/wNSMwAXYMxzFv9fOTJHfJKH+9r224GYXV7VqtssSuEjUpBNpbvAOU5mkxJp37uqiaUfc9aj0EBUrOOX6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DVloCXJ3mYJju+edLyiaPtl++IR1GJZL3EH6ObiDIE=;
 b=f2ytL/BmHFBSqApqYRe/whuswNAUHsrWdj4PbslW+VRSLzDL7q5t8YH1HpYDZaoeIk+ydKUjIqI/SkEmZEiD2TzHYnAPqswISvZlVT4WKH7Rdq5fJhf5dtF7c2W7EmvTvzgh3+SIPYfmfyi6D5cYbbDWTvDvHaqcOdt+MjL5okQ7rFinGyoKGtdiAZrIv5+YHVGP6e8OCoHi6Dl6LJVt8KHCeSmJ5ve9wXVmVf6BCSynWSwmOtAtFympGgvJJacGZnXNPgOSTFboaypiqqCMMRcHFIro6B/b+wrwos7mRp2l9CthWiQsKlqSLaoAjdzC3hPL+uYlURaEheP6IyG3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DVloCXJ3mYJju+edLyiaPtl++IR1GJZL3EH6ObiDIE=;
 b=Xf/I5BNeRBa93mgO9vfUof0kA6TKSGgDJjLMcMfj1JApSYLmxJsDVciAXze3ZUB8cCICm85aAa+txl+fqOPliQGabsc/0tPXefnyY5vACRt6vQdPpz1vr6EY7VU2LtRIcXiK250B8uHrr7K/FTGp6rQ/GPxgyIjNqxfNHy0ishnI2z5LtL4FdhSZIogR/AwJMSD4kX/Mkqq5QOKiGyYpJ7xrteoHjPJumWwSBlVRxgeYdHWde1qDQ7lkD7BkTpCB0rn0ejSWD2U5eGfNzRS/+FHGhg2iXTireWE8PkvaJJxwb0OQyg0mZrb0DWlgaUZ4zcyOIw0kiU0uvGGkejjw5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:42:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:42:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 12/29] selftests: mptcp: userspace pm remove id 0 subflow
Date: Mon, 25 Sep 2023 16:41:51 +0800
Message-Id: <04438bad0ef7459b1a78fa88a6cd2e2c31ebf616.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PU1PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 8261cf18-966d-4678-fe39-08dbbda36476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nOuBS3xn/wNkJ2jjv/5ZP5wpHjM/hdMF5rP0oWIXnIjwG8pd/SUAMHjb8r/ca0MArv5MOTNItQYYm4Vs6gADSdQOdUsX8KKbwZL5smnrZMYSOCNRM4VRdrI9XPvoMbCbrXEmlmDigcTIj7ZfsXowwpjKZ2Uyw2rE1DjX5Aaaz43P8IjhkQyq394cM8fyDou3hffT9sRZtSZqJ2LfMfG7/ch2wvemYxku/ekRXbZyh2XLrYi6UCRFYJ32460KYSghcSxAnHDPs5w3wtcJw2hKKwgCTN1bTZsNS1tzFZwQf1vWGRJypWRcAD7drxE3ZCpXj4EAUaGBP5ZsCD1XCzdcWwxj+ntQaCaXNRYYbeknRvq5QRigW7VTEnEVBcu9ledQYJrLFv0OStpIS+9/N9JpR7LISeWyx1GxPQC2hi31rXrnITjslpwidIyVFKyDQTsj201x1xwAJW9FWmi6FwfcicrlWoenu45GtoXZCJhPec6qCT0xj+iiTUQDOGdpO0Rm09d+VVy/BeFe5e8X+0grqh2zr/RUFUXRp3e/auZ12Npx95tn2r8A11XrWfSFy8u4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrM/8+CXoJ5BuT4OF5OTNW7peMAZTx7H9wK2gy4LhlaC2oIrn3w2rhootaxl?=
 =?us-ascii?Q?BZYI862CnCuoLaj6l2YbYQnwmVV4icDvmFmFxSTuswfQM3YiBwUyw1BlP4Ea?=
 =?us-ascii?Q?F4L5LDXRgw90xzcDN5utQxOKilsrHuxVLLZedRF9YGTrAo4P35t3WILqg7D/?=
 =?us-ascii?Q?/Z1+KVeN7EFoHpNJ9ZE3Qx6Km4FTueIWNX8CIZd1QCbpMsuB/TGXvwBR71dP?=
 =?us-ascii?Q?5o+9Pw/XMxEZ6J/hvrHmlQfJVr0bzTMdWBtvMpiDefDsum7+c3dh0KT/quLg?=
 =?us-ascii?Q?UGmn6oA+84HGTElSS2F9N7x2L0Q8KGOdfMRoKqkJ/SkQcVS+qmc1XFDwrYI5?=
 =?us-ascii?Q?grRFwKL71gN2G9pJX6VHuu3GOhLBjwG0jptMFPah0ap46nq5f3lQNHC06XSl?=
 =?us-ascii?Q?BfS5x8xWePeIXcO75seM2F6U37sfNX97IuVvl+UhhHWZmnXRfHi0z+FuqNnY?=
 =?us-ascii?Q?JJkS3wV21c2sNHRtYxRS1wvuxYBJIjbWG7hzR5x8uduf8M0C3NBoivf7E4pb?=
 =?us-ascii?Q?83pNMlOf5wh/7xpF3rQxNG4Ssndg4dXX1+hP0bK4kYo8Nn6H71xo5TbQ5HEg?=
 =?us-ascii?Q?lJ/cF8BTV3J4d4sBIyBn8w86oFth7dVvCp4ty37bU17BTVJGzYKDCR6m6KK8?=
 =?us-ascii?Q?8kBSOB9o7QZPxzGgrwZDdkGWiO4o0Ugh848s6vAGL3//HON0hDKSYaYWTwGQ?=
 =?us-ascii?Q?wImtKjCfjXBFOOOU1LGdsNC0ejc9hB4xjhjjHUU5p8UDpnElftYKbcMYtTX3?=
 =?us-ascii?Q?SxMuvKMx4qxY7/RsKhzUB9zSrktSCZ/dFrYBTjHVaCakvpNdgCy27fMp/WA7?=
 =?us-ascii?Q?V2E05RPjZG5ZvEe1GYRfgMNriEQKmj5R46RyWBlhi1V4hKxqATYVJX6At1nl?=
 =?us-ascii?Q?8pfdKXrTTGpuBq94lvSjaeHOr/uz60Z/qXwBOwdvSgxPM1hRYxCEeda5XGpN?=
 =?us-ascii?Q?TnGqsLOOTPPMtyG5i+bOGT9/G5Pzt/u7IFWA8z0YCaSLKv0J8MLnotHSrS2V?=
 =?us-ascii?Q?MI5tqlzA4fCR37mgm8UQtEtI/mhuESZanrcGSZ9ijN0l0h5MWAxlQCMKNnlE?=
 =?us-ascii?Q?Sxv8YLGJFQpkNirY0UXIgHjgoJBCmgrqXy2LNhxFK8v/stQ6vvZjs+4TmbZ7?=
 =?us-ascii?Q?e9iU/gFTKXzhKV+tihaZPNpdktym8C1dvRQJkxvdLvkfwv//FHc2U14yIAsF?=
 =?us-ascii?Q?QmQMq0oq5sco6AoAsrdHK85E772F9gOlDFl9sdtFR7xSv3RTQ36zdD7aVkC3?=
 =?us-ascii?Q?9dmzLxkZaX8cgupMmo2mL2RxvoK4j0si/DrW7fluSI4JHI9wSjEbUXGY0jVk?=
 =?us-ascii?Q?nrZgYqDQa6eLKGmkIqZdyKt1kLb4+xx3VRQ4z/wrDNMtHEWLT6HjQbRxI5tL?=
 =?us-ascii?Q?er/EW8/F9mYXELXS9Iwumxrk1IXRXjEZEYr9HHpT6Mis5F7kyyK253dFgNTV?=
 =?us-ascii?Q?eebC7ZbaTr+eYeB6O0cZsfGZOgpZ3NIYvpNIVGPSTwjrEu9jlrA0Yu9rcGXV?=
 =?us-ascii?Q?JG1q7KBwm/tCITRbmfjljmZ4BshtzlwScuWpioW0fzrZE5LyjA5h3DuV5DWr?=
 =?us-ascii?Q?Iq/Vqje7sHQDOlimSHLNcP1OeyYB9jtTSylcX98u?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8261cf18-966d-4678-fe39-08dbbda36476
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:42:46.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYFD4DR6WYa9yKYPx2IC55jY3ddDoYpKXew+e4Xy6xOF7s3BKv/o0YZFI72+PPkS4L6kezO5Wryj7hFy6dW5Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 25c2948391f5..ca75d2c6d415 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3467,6 +3467,28 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow
+	if reset_with_events "userspace pm remove id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

