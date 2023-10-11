Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422791A711
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oo31nR/D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIA3rQ/9tMtWX3UwBWzgoHrjiY71irpbb0Fa3f0Q4LeO0sfGuxCHJepWX4f2HAdgouW01kbuy/LEOabS7kh0FFBgva73FQmrJcaLhO9wD98QVIWx/KS10mSYBFtnTiGRapjSACN70nCWtvDyXIMhHXieFdJskHnMkG1oj10ihheeREsnVmL0ZyEmFWxInDUD4fnRzbHI9TofrQy0Puvegl2elEjZnjWzBsaA5eIzBHnNO+YvsGqlDkSm+12l7OCE4X3RTEzGahoyTVNdKlDI5tzahSilo5zH2ovwOWwezp+phTMNittErajECBwzGCXqJDCbcjdEM5ZKmwqrmSH2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZboU8sZxy30f7bENmDMoKvzQ1EsIW+DN2H1xdFteNzY=;
 b=LaBUPR51oIPrfUhvV9RBXjX/O7OZLpqLCGhorKE5iM3AX5Jc+RrngScPQXFEeENHWpnGlnpnoqL/nkw3SuAx5KjjaePxl6F50j2fMrKacE3T5u8xpIj8qUM88OmML0IanAIKOiMcJ9b0wKxC4Gtp8sU94ZAMU1AitttJxXhdM4oxJvwWQof+gd4uZd8UXNdVnd6ft+ToGf00cX7+2i+cbsQyizdWPwu81fLVxj3/IB90icgdyCXMCjJbN/gJcc4rAPJupFWb//Emgk0yE6zvWSKKVsQZfgE51/HEYtUW+cseYnT+HiXSDPJYz9L8hDhglU/hAYbDzq76WxPjL51Ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZboU8sZxy30f7bENmDMoKvzQ1EsIW+DN2H1xdFteNzY=;
 b=Oo31nR/DHCDXGtXLMHQIlhWDsiwkFzb8C0QJmMuZ762n8LYmu3cOedfWxnp/CpMRI68emUoKhVhG+xe+Gl5KfU+7c44SJ/z4t6Cgf53XQMi7ijV/Gdiezo475/X1a21zxmHu74weQegNH46I0z+WLgcmlI/ofcY86TZsWFNa1pTISh4P98uQ1y+Xr2nyB52XPPBioIwYGM+qukUuOML5OV6Yuec+Psos5bGlrgUccCvdCgKuY+s58gCctF3hyj3wM6lUnpelO1+qCYM+vGWANjItPNO4mquyqv4PJ61Eq16s5/SpjM/jKhSdn2A2XZqRxGwsbpLnB4Njlzh1xPDf2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6960.eurprd04.prod.outlook.com (2603:10a6:803:12d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 09:49:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:49:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 5/5] selftests: mptcp: userspace pm send RM_ADDR for ID 0
Date: Wed, 11 Oct 2023 17:50:29 +0800
Message-Id: <b729ef20b982fa6a205af202aa8bc12c3784036d.1697017655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697017655.git.geliang.tang@suse.com>
References: <cover.1697017655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 5579ad8d-7fb7-4cec-152d-08dbca3f6bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o43bO6nfQfpMMNsmEwthMUgHRpDDk6nliqECqGP4MA2GmUZBcyBZRjR4Ia5z7nXC8f8ZevMCyZAht8JMqYLjotZn/lyDfyTyhYPpwbAqvVQD7SVW7griCpSBi5boKfOMPpwsj2VMY2bORtjM4Ady5kSL0/B0i7dlfP7Mfj6V9LzMGdodBQZdjHLysxhRh11o7A1gaGnT++7VPRlSa+Idri669cqk5GoRa/XrxvFF/xrYSLjxYEal1c8nMh+X41eYSyI86jUYC78f6FszA16vTyX9VavIY5BBKDAdbwYRqoYEzUpvBaVPrsZ3VMRfnSPl+NXvhcxgv5uv8FQUPchY+Hx5aDfcE1/AmNIsTavD8OEhXEaMKE3uRbngMPHi+FYqtEIzJOgzmew5FULd+bEu4K7+UfPKqN2A4qnAfXYZetJS2qJrR+9UgHA7dgf913T6/dxL4rwH1pej77MJ5q3Qw/ydsMhj59f3/dRTeuzHwAGIBLlEVFcR1NGtbryk48dOkMt6zlwekR5F5/3ZKIA8txeLqVrVszQmqWAcdiJCwbfRqIupj7hLypVLaMdGBg4p3ixzU/5S4Mlr0HyoftD3M909AKeQIAOjNQS8QYeMtJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(107886003)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZm4WXzLV+GU9mYINDTPZNt0MVlcgrYaYArVgJPtjBBGq9y6XZx/DoUm/dT7?=
 =?us-ascii?Q?J9YO+d/rm7pal3XEBMq6jZEb4WehWjPNJ2XANVwcmn+KWkGTzcJqRxFv5l9a?=
 =?us-ascii?Q?lVHYFYHMxJjOvVlQa9ShSNyndDisQrZZgB8hVdXlipzB5EB76BvGgufjuHAZ?=
 =?us-ascii?Q?feDOsQlLJuVdJqClKSHI1LB5tqpz1ok8x0wh96HquafEA8VR/bosrd8hHdgB?=
 =?us-ascii?Q?TAi64ldTxGQula8TOhLcytMOsge97DZT2eQGZtSztCOnMSNUkuF5pr8rKMfR?=
 =?us-ascii?Q?0qVLAd6C3SThuhTicf8cto/MlnTsBgq/l6yhmplhibeHT54itV7kQIhnHJa0?=
 =?us-ascii?Q?GRT/exfztlDuW0bddV3nO3NwhhN87aBJes3xGY4HJp4lzK3Y8wQwBXOwE007?=
 =?us-ascii?Q?NNqk4SOAdEE6fzHHweW6iKKGf8bEpISVauf+di6oYluhkjB5vLxYlUNO529V?=
 =?us-ascii?Q?iFXvCk8RK9Nk0KzmQwU3mULQAXpi4uFp+cyMpEDhxj8NsYsUnqHPHnwAEROJ?=
 =?us-ascii?Q?wvripboe5IzaYlqCr9uWxybUg3hxSIpOfCyHu47alo3rXrK1SLOCT/I1WNLK?=
 =?us-ascii?Q?PaBsev0iUkoymGlNZAsVh0A3WqntihuRdIeQ85ba0SuKShCOo1gkoeJAStbX?=
 =?us-ascii?Q?/c3vC4b/q+rTFYOgUaNEzCt5zPcOH+OY8whf6Jsnnh2btGOVlvuBtSk4xc49?=
 =?us-ascii?Q?9ihe7m8VJ/BJ2Esk22cWBqFxelZ7pXbnTJDxpIikf5uuAstjumsPD12z55+a?=
 =?us-ascii?Q?d333EMN/yAiPhoTNDKlCe5GS033U6vZuCuzdXOcsx68LHuJG5xl7s0yqEph3?=
 =?us-ascii?Q?nbKr+dTlE03b27iJILAXL5RMpy8qz7G0UEN7LfWwEg5+C/1knulTVpVeoZER?=
 =?us-ascii?Q?BjM/e7GQX+njX0sgg9EAS537bEXDBbMVI4y2OabeOtNt3UNH/k5ya/qKBJg2?=
 =?us-ascii?Q?cHM/3XfY4Wn/dUqOUyNTeEenNHHSOOj9OUK82vNzTjtESijzhXYF2XkSSi5j?=
 =?us-ascii?Q?fnXQ/tarHq1Uvc2GVHw9oSku7gNojkV9uWUCofkCm8AjvD1fj9bjNLrKOKDy?=
 =?us-ascii?Q?oIrjLfqIAN74HU0zFndu6ASOrH7fc+FfRwpFOrOhLRx+ffkljYK7SYFHUv9i?=
 =?us-ascii?Q?jxORk0G+0cGfxbHIt0xFCRMKjzhCvcv9XDkQRxy0V8LN6TUvD+yko1lY+IeE?=
 =?us-ascii?Q?Z1mvs2alhtn9db6hJhaYxPD8AxdByFT8I9fbT8wgUlU4ATxOn14HkdjtT8K0?=
 =?us-ascii?Q?LGxq88BfTSC5J15A7GGgDVXwHHUlVIscvmcNTQRw/a1CPx+NfF/hR9GTJJk+?=
 =?us-ascii?Q?V9vHcQrvduiuRO6hKY38WpQG0w39fctKEC+kfZrNUscmp0kVa+Gr9GBVldxt?=
 =?us-ascii?Q?QcvrXBVOrX0F1iNSkQvtjOhXTTg413N0VuoKS6GvR9wj2Y5W9sGLRQS6mLvo?=
 =?us-ascii?Q?KBxM7zXjLn0IfOIA6LFFancD/Bi3Xp8LfK8M5j7+MaUT3kZzRU3aGGFNphQ7?=
 =?us-ascii?Q?prxBWz2MADDWtBL6kmiTgQK1+SMolFzk9ZTvmL3BmFnGnbQmqEntcIFi7p2U?=
 =?us-ascii?Q?34++JYP3CVIv0RDwu/vqtKKKBn0WAXRVUKqgSX5K?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5579ad8d-7fb7-4cec-152d-08dbca3f6bf7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:49:54.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/SFInUAEh0Ga0zOMdx3efMUn32+QS3SShvApTox8q0QW0Oxf8kHvkKOmORm2/7XsVVVCM49Y9n0fjFjdg+vIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6960

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 199ebd0d3463..3e537ba3a68b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3512,6 +3512,31 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm send RM_ADDR for ID 0
+	if reset_with_events "userspace pm send RM_ADDR for ID 0" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		sleep 0.5
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

