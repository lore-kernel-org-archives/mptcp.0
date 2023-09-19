Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360634CD8
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YndIDLAwW6LYAN7rW2oPr2ThD1FgASP6/Z/Gg+qt/wGsF2PlSKrAjvKdx2v6IdXxtmCMzooohBYXFoQ0hJ0xubGmdDBiriKXF+1MOX7PenlFMMLQMvwBCwzWzXCdhMX7RJqZk7b3XdEDIsBJxegRX9OikbViAYSwYMW3bApE8NdoouujLOgOk3hFgwrz7RUXHYsKm5cpDJTsJVHCbLib551rm+22DzOol9FIzAPadl0bj1x00qaIsk29AoMcinphLG3xGhuc6Ke9Z0WWi1bVIC5M8UkIwYuvGALP3ShDApUeslY82YzWy0ss3kVoDBzUNt228yFZocAnpoJpVdTN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh0AThWy/1iY4ohouWlu1EMSH+myMG0i4Rl4xquRNfo=;
 b=SSRrRSUE0kzS7h/xbsyPPFvLRVzIIMEra7EG8O462UFOzeVI5XYz5FvmhaqpAvZJ+/08ABya3wwqn4cT7zva4h3QGi+RcCtcImY1ORhjJ4rw1sZk0B1oiaW8zOSj3leTyZJCEFwe3bbd+inWQJwWfyIYOVYa+f37ggmNYGDTD3yXJ5LnViQQqpgHKCye7so9wiy6RklCSszc8dm9Ucza6OdZs04GMM8CDRZiVvs11HI7g/uL0WL4CyUxFDCYALAd4T0lV1878QVlX4mYA4LcmwNVTBhsm/H6Fi/u41xYIlDRoR6qxqijIkwI+xnnUNOnJS/IT266VVTTC16sZYRgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh0AThWy/1iY4ohouWlu1EMSH+myMG0i4Rl4xquRNfo=;
 b=Lgg8qY1gmWibC9CONQVf6yfDqpurrigWqc1DhwaobrvygOhaRKFZORq2XUBWtb/mX9w8qjhTuoSqk6XwMQnqtzrhBVGzz+JneHk1GBltrrJlDgfQFJvTIN45i8X7X/JWWUwYxuZfNytfStVSW811uMgugnIBK0dZ9U44fv1m+4KOwS++1W6kZArYEfO21nXplXOw+woXD/77lDz51jS8OGtnkvrnX8xw0ODpr0O8aZVNpuMGr4yQlS6SjyoA6/xV7Jnx2wnPpj+LRVVXpVNedKsTAw2xw6hg11aZ7hzRjerd8jy7IINWtrzoqep2/Op2+ai/C04XBvmDSXPdgzmuDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:03:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:03:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 15/30] selftests: mptcp: userspace pm create id 0 subflow
Date: Tue, 19 Sep 2023 12:02:16 +0800
Message-Id: <ac0a86966c06f7012690520a8d5a0f33d366b774.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0272.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 049e5f12-3032-47b0-3d38-08dbb8c571db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P1bTRDk9AzTs9AijnLPBZg+rarNnhpQQFmaXdyarEsdXDjNItgoU+wOfuPskVU9vP7yFERxs0f8KkcOw3ItynnpdwcC5ugIRbtp86nMuaN0NkMmzJBXVSATBHMKBsvTATggVOVWM+w4E7lBcyEQXyk6ngO2YBObNiB3ogg5aRSjyJg9IsEDIQwimSMZWciLqsuhzukAo7p8oK0nZfwHQzA+/vpxh/usp+yVwvtLAS3DqaYzVkEoS6o3BrOJnUYPc24C/PNuTgneRV4IJqqUpTwgWCqJQS1CL/XJDAX48UVmmZmGR3ZazT2YOrRfkS1yWyZxQ3/pH4oiz9kGH6F9S6Q2N9uopmhb/FuHuINocy5yDvnSIf8F2gKJfdTg9AVCObzJcVi+5txB/DoELWGgUWWTQKC/0F2XpN51drQ2AIWUu4N50JgvTaZVeG9Qz/ePLU3hQcoz3bim8dQTyVlgi/kHhwlY8YHtkmSR6CNwAJ3dCHofTmkn8Uc7NkcyzCwWcFoiyaaA50aifpLUG7kHtNRY/FU6O3QMkpurSetmTD4k/7WwS76A7LeOcFrpeXbV1FBx31xqfVhp6TwCVxO/8Azpkf/0Yrkm0Dou6ybptd4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5oxQ8EU7hiI7AHmB9j2ZYezTZrjVwCVuYoAvQpgTmB9J8OOnLetcIUbdZk3?=
 =?us-ascii?Q?SmoXtTM9PUjBzj9bQkPfrQKBt1EPTxpJb+ikEWwzUnZRMrjqndtUgBT97iZo?=
 =?us-ascii?Q?G73DK1jaXg5x1BoANRI/I+IocEZDa1iEucNlYQt/Z/Fsj5al5txCzy4KS3jv?=
 =?us-ascii?Q?a30Zh/pmMcsHjOxbGac3wraIoWl8IWglXkt/87yIQVk/oQvtiGuEJ6a0iXLM?=
 =?us-ascii?Q?xVuofa8A+wvfRrg5a29lzF9fdwA5r2MOvvq6S8WzdQ2eKr54zShNL0Bu03D0?=
 =?us-ascii?Q?vWzVQsfZSNB9ppA4Tbym+UczY3IyRhf5Zv2w49A6C+DUEthtVCJ0b5XRUr5o?=
 =?us-ascii?Q?WT9HZYje1KvaBDQqFalDh6zs21TitylGrSSPzz1gWsVt/SDOVFtXfjJAMu6J?=
 =?us-ascii?Q?q5XXtHOxLF30TSSc/TfouPV2OYKMCOxUjE4dhgeGncXl0QMrL/38mMlC0MU/?=
 =?us-ascii?Q?A2XVEXb4Z800C2FLlLhByeZV8BcdiJpzGLqni9Sm4G6jIcEoDYSny4WlGkW1?=
 =?us-ascii?Q?yOdD4L2u7DYrzIVw+2qbETVXB9WhI5Gte2L46B+3ILY7HrQ6Vlq04RXxqgsh?=
 =?us-ascii?Q?kAcjPKOr0Y7nKzOSInH8P6XwwBBArGRJn6WXpOJcfOVU1Gb+9pug23VmbZxW?=
 =?us-ascii?Q?WwNV3Y1+JiaEJ9S7YXNyJIJSHEGiZfdnJmY5w99u2E569cbLRCa0diBsADHP?=
 =?us-ascii?Q?MZfzoOKsAonwN10MJ3+PLErxHdTXapO7B1cg7mGa0/azhibuGEpCZNV7sJVf?=
 =?us-ascii?Q?/tVbdUXI0CnlF5ijFeOst7TnySmNVoeyHBBD0v04C0udLdMoIXlktkZdiaWi?=
 =?us-ascii?Q?w+lTcq6X3s4WOU1Lww1Qzek5DT2K4iWcFCN2UaPVvJ/qg9ryGT+nXiFOSsyH?=
 =?us-ascii?Q?79YUVfu1oBlhrQAgllnQE00/GXWviFsAk2Mmk1yUlBVMz/S9MhtL+wnFnRZw?=
 =?us-ascii?Q?IKim+ouhMxh2lmJftPgBBeVlqvsRC2NxbJ0+s4l7oMYv+ouzsQrtS39L1598?=
 =?us-ascii?Q?JdPAAYvKx8VPm8KBZUUbSYBgI6+csGTDMBw7jBWaRRgPqX5nFynHd8VJemZz?=
 =?us-ascii?Q?gLfLvUEgapXIYOrU1v3QEvz7BluNrIQY3qaXg/9bnQtjz7XLZ0sg+xV12Vq9?=
 =?us-ascii?Q?2/NzgE6cHMSYpW8NzjykEG+Y2pCJfvk6MXJBKmbLFQLIxg0O9f2DpwM5UkD4?=
 =?us-ascii?Q?2+dxYDwL5NkZi9ZDBdLKBaoy/vt3BqupWEVJHdVxHeKzcihaugnOvBUiUtIx?=
 =?us-ascii?Q?VNerMUMxTt9bmCVX4zQfuMhITPHnfvKf8RhkcESVMJdhIGOtVsdkq/bzF1en?=
 =?us-ascii?Q?NIqSNX3VjX9VsAPMASGc0CcDcyaJDgIhW2dFpw4QvHDx1wNsFwJV1uY3jtO/?=
 =?us-ascii?Q?2yH5d0nf9zBs0HtaMpQ0IDB2qrUNU1UPPrmyTq0hIvqvhqQOqk7q5R5gdhjI?=
 =?us-ascii?Q?mHk1r2FbUfNNXuJhVhWbs5rwNTJI9LIpJc3bXHj2qad5GwbghNEtHL8CxiIe?=
 =?us-ascii?Q?tdt28Z4y2SVP7y+T5JooMY5TwUKCQI2TX90gZCj91d6mvdEp/c7gVk45ftzW?=
 =?us-ascii?Q?C9V5rZjU6gQJhGabaxDVJUTbSmD506nDrisGZxoX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049e5f12-3032-47b0-3d38-08dbb8c571db
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:03:56.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiZpQVMdW+MT9inlWBJg3N8WGZRwWI5qaotrD50GTE06+/+HRbLKr/DmlhFcfMYwAmGgE4PcTsOQp7AlJbnofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_subflows_total shows two subflows in each
namespace.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ca75d2c6d415..22aa69db87ab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3468,6 +3468,25 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
+	# userspace pm create id 0 subflow
+	if reset_with_events "userspace pm create id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 0
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
+
 	# userspace pm remove id 0 subflow
 	if reset_with_events "userspace pm remove id 0 subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-- 
2.35.3

