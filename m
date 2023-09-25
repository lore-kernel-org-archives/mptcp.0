Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D3125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdG+KkVAvcRt+bXqI6ZiMkKLp1NfHOz9+smrkkCJt3eCYxMf6QYJRr8OVsBXqWX9omPED6p0Rdkogt/zh8sFPvgYLGY1DJ5/rY+KaLSl+E1HczCPaFIv5w9XFbx6MmVBnwoEbcIS8YqDMxIDZ24EEZCKipaWvnA6ZbDis3hf4rFapYVwfosC0o+331gFKuYMY3INFYIBzJzu2AQfW7VbZUWc+MkRvhv2GyqjNjSlCiR5y21bHP/fG+SyQSL4kHj2E+6deggbJr1PKBHiXuBvFOcITrmaqb6WxOfR0zkJPZRNQCd+KAzznsO/YfNfFPR/KD7wzFfbPn75QvYciAx35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NapUf4qgKI0NRdY//931ACRYU56EbV92THDEYGdGTH8=;
 b=d7vphIPALIeGQzyUaW8qClFuWURWToPW6hqG99KcwQ97Rd+FRaunSEE6xbIPLcqGdQHuyLxQb4tHcYEPzeXE3Acr6PccxNwQL6EVF60afHCm+79/SZuT3D5oqzmrOp1XD9v5SeJoYMg++wjCOao5h+f3hW2gumpGRfFIzKnxndJRh0HD5KTixje5ncJSJGirSJtvypZZr/U+vdNeEp0Fhpok8VpeAMdRwjMPAPTWEkViFh+aQveNiR3hXNJFz3LYY8KiJG0fZy/MDaGDUt11zLggKS7Xxq95bseX5cu74f0dnMAwApPDTakpPMYv+nBWwqqgnGWkWfugjMmPBhmu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NapUf4qgKI0NRdY//931ACRYU56EbV92THDEYGdGTH8=;
 b=W1e3WzINA00tvhwkx7zrNCacEKdN8hYzeIr4wkWBlcNAcd4XnuqzUaxh1vL0I9Zc7WC+3s3CnvqEYtx8U+Vw17BCQjWwa+8jaR7a0yYmjoaIORQ8fjwJzjPPBk2hGPmBNR6AzWI8+nXXPjSwn9WNnMe4kRvLeo/S5ul+PR/sfWoYNmp86JxedJyvnsyjuhd+d6xzBQP3Y29tfPlrOBqSkHF8PSAZtTG5k+6qrOp/EVXkPTHliYHQDNQqLxQyC5F7hC/EhpYR3TPxIfzoto9uid7GSri1IIfZXfJ7Z53L3HU2VPlSW8d2s8GavcKes6FZHxLnwSa/HgeOU1fzlbNULg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:43:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 20/29] selftests: mptcp: add userspace pm fullmesh tests
Date: Mon, 25 Sep 2023 16:41:59 +0800
Message-Id: <212f56895715a7e17577076cbe3a7dff9e3ea360.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dbe57d-d27b-403f-9621-08dbbda38e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LxmZmyu1e1bSyfDTXx4CKdTGkFW3OJdu/lTNMC9znYol0wjiRKqsV4yQ+/bQoJ/JCYftTww5NnQibaHuQf5fACWia/m4yKi1T7cWG7uuQUu2g1b2DAJTKY20vwnPruR4ezQz8r0E9oT3lkrFog2HXEL1UYfqC7HOyPps/9NoSGMm3LkNKjsllXjdNCW4A1xfhlZ7bMTqWBa6YPHxg6agNihIkqkgN6QcqiYstrXtAQ3M6AracNIQZQr81Zy5mLGawYwQeWaHOgQNqnvf2CkoT2FAfyrIcfVg/Vwkt+KH9+QvFgrjSn17swe5rbnDSTNecVy1KmGhLBzsZl6GuZBmzluh6Zgsk7QEbbrd7bV9/JR6j7A2cscKPuAJ1jo71ufrgMYcgBg8y1x4fGvRNuNO6j0ipmwIsuEWryFMtlMnF1IuTeHwMnt85KhXMHPzjAQJb2wU89OfZQ0o4A6pXOKi0bIXm16CcrTl7JmzT2gbUUNxwV6mYi9GObavknWZU730AZYfmCFiu7gsuJBPRl3uiMwcvyplnz3NjtDV0kwRUBWGFxvHj7/Vtk1iZaKgEJTF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qn26AaunAYXxhLQh+DbKS8VjPAp29kqSIHR1xcNDs0mU7X4hHPqZix2PvsPz?=
 =?us-ascii?Q?C9iMTS+q1H+UIqlhWFfXx6gri38X47SxgWXQjQyj4alCpOE4G6K3kOHkQ+2B?=
 =?us-ascii?Q?FeK1mGjr0B6q9XwjD1ZOGI/alCuq7E7TBT+pzqAxjheX53Zc9Tb/qVY2A+yt?=
 =?us-ascii?Q?6GNz8DmcTk8LhBcymbTrDtAiOR8NnoJ2Z5c5YdnzzA0z2IfPetJTlOcF7yIr?=
 =?us-ascii?Q?Wpqe6GkFyBTMdvBQ7Ur2SSkBk+6hRqyuyaJGPT3yYuUl1D4PbDr/Wu4/NEhc?=
 =?us-ascii?Q?uS3AhVKtKyFNgHYZDKulbtslshrir6WjhhdDNh9dAx95xAzv98zi+xCLCeL5?=
 =?us-ascii?Q?1RySdDUvC1tIWpQWlMS5TpLC2g66CvET4Dc4NqBCrAISX0JVUYDxNzwx4TKs?=
 =?us-ascii?Q?pMnKnZ1B8Lmv0oN/+YNWqRGDkzs5/D5G0kKJGmU/irVVH8Jdvbgz8rKwPIcN?=
 =?us-ascii?Q?gtHtf5HKULrwjA8nITdpy4tZ0Ew7SWLL9nmflkr03UBZq6A6Go2QG2O0yo3r?=
 =?us-ascii?Q?Uhv4aN1M78kRfCwUAyfA4dG+1tl7H4+TISSvnNPGVLAKXjD2mTvhraL0Anye?=
 =?us-ascii?Q?lj3Y+GXRajb3t2fwO3UwnRWaSN/1E1XUVlZ9c261vvFtgcPuql4H2zV0neWz?=
 =?us-ascii?Q?TLBpJppOSW28Lmgblo0I0ON9CVofISEz8NOKaqvNKxgEj6/4QONybp3CwWcf?=
 =?us-ascii?Q?wUqL+9s3A06dgjyv67uS7HWpooLLro1p4tAyxmv4DoA/vrZRhQ6srlTi2a6p?=
 =?us-ascii?Q?+3cw7/ByQAkmnlVKmmn7G65msLajp2BMF4ZOYfEe1XF5K+8BIFYzvzu0CtGE?=
 =?us-ascii?Q?+UxhnKzoGvSPeC7CTcjs82M5LP4Bz1vt9jTsg1YDbK8QgUprc82ctYO8Rhp/?=
 =?us-ascii?Q?m5HmfPzzJ1V7aA4jZoLSrzDPMEmy/apHrA28BcMiRVLLjRcLuYQ8BHockX9t?=
 =?us-ascii?Q?lwCf1ZLVAv5GdQbUt/00LSoLljsbVF5o3uJJHCe0zbPDqfPOVHWTArD8NOD/?=
 =?us-ascii?Q?kfuJYzhQOIIRLNuGThAcrudYMkuLiWgCNJpAcWrdASuh9zC1vjqfV56BuIma?=
 =?us-ascii?Q?t1/BFQLsEXMbSc6lxgmStqaXNPTdDXhCnnE4wdNwH3QKDj6wi05YYWU+048n?=
 =?us-ascii?Q?+K+dGUhx0UgMeKKVgurty6uAcydKEW7C8+zTzEmkH6QA/frJ8qiWrTaWib8o?=
 =?us-ascii?Q?DnoiVObFnuXnNOMms8apK5HvvS4fWNQpIDIws9MX0DyfPRjQ++rzvwIkJWBw?=
 =?us-ascii?Q?2KoJh3N5L4os/9Vj3EuP4jjKI9B2IdJBfgj029/XankTAxfAM0fZqR53XMuT?=
 =?us-ascii?Q?uWAY2fEd3TzjXMhn407C/O95yDWSgg4NIRyaB217owD0lpzZLam/q3LcKU2i?=
 =?us-ascii?Q?Xmx6Ze+VV9tGMfEE1ykFY5M3el1UjYq4x6O/ZnbH0xYBSBLsSetNrapMNiRJ?=
 =?us-ascii?Q?ew9jxFMQ4XJB21a1w3s4UtHffi0p7DYe6eGOEVlKEwUSC7B2qMjEIL7WEZBH?=
 =?us-ascii?Q?8nqqk4yr2HzTVBjJgqEkorX6gdTujv9onqdpmohwlPhIyj5V1/QolQQPmybL?=
 =?us-ascii?Q?USlAhnmlit+/uXQXPR0jbcxh9+Mxti82SjefzHis?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dbe57d-d27b-403f-9621-08dbbda38e7b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:57.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ5OyUz2tSG0W42kUy77++7v+KoxsnB7p6Y+I92WGldZwY+02Y6LLW6s82k8g/aMh4xyOEfx13Pd9MS2J6kmjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

This patch adds fullmesh selftests for userspace pm both on server side
and on client side. For the server side test, add two endpoints with
fullmesh flag on ns2, then signal an address on ns1 by userspace PM to
trigger the fullmesh connections. For the client side test, just use
userspace PM to create multiple subflows to do the fullmesh connections.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aac50ef86785..d883c6c2426b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3532,6 +3532,46 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm server fullmesh
+	if reset_with_events "userspace pm server fullmesh" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 5 5
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 4 4 4
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 4 subflows 4
+		chk_subflows_total 5 5
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		mptcp_lib_evts_kill
+		wait $tests_pid
+	fi
+
+	# userspace pm client fullmesh
+	if reset_with_events "userspace pm client fullmesh" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		pm_nl_set_limits $ns1 5 5
+		set_userspace_pm $ns2
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_sf $ns2 10.0.2.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 30
+		userspace_pm_add_sf $ns2 10.0.4.2 40
+		chk_join_nr 3 3 3
+		chk_mptcp_info subflows 3 subflows 3
+		chk_subflows_total 4 4
+		mptcp_lib_evts_kill
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

