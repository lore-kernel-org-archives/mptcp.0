Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA147E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQV0p0xcL6Cbfv0BvkV2CsC/sGMeZ+nHfao9lDZ2faGwfnqj9Ajkku4VJb+mzOn49jxEOJfap2+hUzxB80jV0aun6AGVONiEPwCkWqtwMgzHfT8r2elJIL+hFRiubiM/YFQRMVKP55IIcpucVfP9YyZlSGjLq58gVLF+BRzFapX7lbRwEZQz5tNCh43tcNCOk6Qjpelae8x5aqvqp5jIlnAEP6FXxhXIrahISYbsufHQTQPJQGkESww2e1+ep8jQqvDjEgOkIkNFBKWVowfdRTulxQl9pwvm3JEB3mMNk96i/37B+5bgZbs5BCzAhu72sIWahLRk6PecHIV7R59iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pb/UyPyEHwNCEtWfz+2KxRFOM6tjZrKIdRapWg8dNo=;
 b=nIcLBE8MUXKlVDq/sh2cKswmph9NEgC7vki6EWvIa+eLGQgSzI0vPnuYm7o5cPn8yopZOWZy0mJoaMLVBVCxDRZExnmADjK4LfqSfYXdSTkthGlTtCmdRxDpwdYHXTQUIWWYuZTb1oIJjeJnLIFAMfzkOG9XJzsYOFiGyc+indbzV7jZb1iwFslYx0+xpEzGfU4HRMu4Ei2Z4N+aHQNFYjHEMM/ntsv+4GxlGsJkMuXjt4c1En28dUahFPFXRjjZ0mD6RpK6zxFXw3h6eW7XsfYxajTuxnLtbyF7Y0Bjs63tHL55nM30fkickc4LxlJYd87QD+6vUWKPjJ2MtSzdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pb/UyPyEHwNCEtWfz+2KxRFOM6tjZrKIdRapWg8dNo=;
 b=nitb5QEzCD+w9CVTd2sktw3tO3bZ00nw5ubIsplN4CeZQ+jbKIPambsnx8gm1EtMQ3CkzeooYRj5cL4qQN52S3rkoLN8Q/HFTjZWWrB4TBTV5gZ5DPqXqX0MJ4SVhv4c46oRA3kuKndAk5VCExioO1BaK+yOOC8H5V4Ib1E4hsNvVaLWQoC68xV0WPwKd5Q3dpaaP/3Q1InFmTji3vHeFa3FMI9VJacpKdc9zVvPz3/mJ2cdAbBJkFzKI+ddBWR/18hPhnBkl8ulxds9wLLuUBtHqcKAAB9EuflgJbe0NijXU+C3SZzPq/WpWABpb1HUa7b6v6xTepAu3BkdA6GKYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:50:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:50:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 04/10] selftests: mptcp: userspace pm remove id 0 subflow
Date: Fri, 25 Aug 2023 11:50:22 +0800
Message-Id: <7a391b794a4a440a9f9b205e9e45f5d8383da4f1.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: c67941d0-f9c7-478f-6d30-08dba51e7b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DL4ELoPS4hvvHx3D/NRPA9/gRT8yj7f/rAPjkKrnSHZwiMvOAnh4E5zEUuvvfgV/NBlOlfa2nh9DsWIzhuBlIqyHpCJz1AKjOq+aFa7QSUbyw28xWru83fclW1P8jT8eAHlx8DskPLNzDicGcMqEjt4fuBHIsIlRLGXBuFMihg4eU2vcG8PV6zKfL9iN8ERtKwwaYHi0hyI9FrcXQNBeLPmgDk1LK6wX4BShNgoRmCqIJkyXKzjf7fbQBSBE4eygsC6ApxulVyZAa0OUcPRKDJ+XWIDB8Xm+SYsiL1mdxXpE6IhD121gNuMd3/+J74a/4aj8ZgkYyVZUiqLGIq+G3F9gqsc6wlGtAIswsmzBSL5w+0Fd+ZM++2ANMVz1PPbAgMIDaroBmyR2eeTqlvp0z3o9ZBt4EUNgJxXrMC8ydLdNTDuu2vCUIkBQxvp97UwqwDADVjQyqnVP+GiAjJ7fuwZAGCA/quzj83SMEfpgUoksWBX/FHmkbAaV6xlZ5mAhdtL2kmY+CgNh0AKXZp0hookFiaio12d5LZOqZWckfHKMsBwEpZtcKktX9Gmp0NMfVnrobw5HlcebWjcLkA86D5JDn98Mhdy54IT0lIsHXW4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cgbtJWIXcbzMyvz4azvczSvF8AxlMR1QtpTmSzwK7jey7QIjUk1WQU81eLbB?=
 =?us-ascii?Q?iQbQhgvHe+8pWVd/1YXndVR1amXvwCoFOXR91B6ZQHDZUElIgWERf1DKyagW?=
 =?us-ascii?Q?UqqhNGqtjIcLjbHl1ElrKRnT6l+CZuhR4PgBoWo39qek2Mby6/s9wg5sF/ld?=
 =?us-ascii?Q?T2KO4UYngMgj/QP768TTrow1zJMa0fOWLxkS4p+ZH7owQUufb586rPBf5PGW?=
 =?us-ascii?Q?swSUORZ/ckGUVJG1U/Q0vS2VueKHxk7P/dyQP30ikJdCKcOzuSKCGDMPPGR+?=
 =?us-ascii?Q?bGlU0WNRJT7+/S/zc3B7BQ2uO8FupvicXObMFFDmhqPlhyjyvJH9/xH2x/wd?=
 =?us-ascii?Q?XkcYoecP1AHu+KVtc3lQ9a2fiVuQhdP0T77XoFC8lfb72ZxUq3pYzd6MOVoj?=
 =?us-ascii?Q?wf26NujAIzQ2jzp5Eu0wEk9ZaLFuf8f+yz38VG6eAZLItCikFnZDQ9Rtza2b?=
 =?us-ascii?Q?FY/0lBfYHNgr0InAqz3PRerE5YmIk1OW/Cj9jslIRxM7S41cSWJIgCsYSO3L?=
 =?us-ascii?Q?k2RksfWTftCyzrSIGkqv3ydz21RuZ81d3wCdeT7LtEtiHJcBtJrHPZHoqtTe?=
 =?us-ascii?Q?cJ6Y1V0mkcITDesoiiaG8VeODcVuzLJfVwIs+LzuDcBpI/9hVM+t1GvFn+BE?=
 =?us-ascii?Q?Fx/w0+jJV6KJ88keuJqvETvsq9z5qant5gPSYJ/H0a9XMifAyRCABUwwsNN3?=
 =?us-ascii?Q?MIdn5LK3esiyV7GlW3hZUW9LJKpw826/2exPUZuws6ybAH8/ppatQKxSNlHz?=
 =?us-ascii?Q?Ys7uf0SBNbyZIByruBLjvrXgLZLI+up+RE5ZghwvWqZU4p8p4B6p2gXTLH4s?=
 =?us-ascii?Q?4vUlDSHD7dJDl86bdwszw26gvKKu4NAU8oOVaI/q6HfSsz1AqdQ13bxNliFf?=
 =?us-ascii?Q?4l3FUDb0qBWpzRrRoLh+ID01hToQan+qTmzLwrTkTx56Mkn2bktp6sJLLZoI?=
 =?us-ascii?Q?HJkGXmOcBsi79fF5n5wDD0bn569LgelnP7BcVoiJx0XNqA/dYDL6EqWfBQkT?=
 =?us-ascii?Q?XhLjh09CbfAOrEbNaMbXEjqMGG6R/o5p/6WjdjWGY1QCfc7dXTqa2MaUoL8u?=
 =?us-ascii?Q?Gxnq6Hyb0XBiUrl+X0zJXetEuAlSJ25P/tWOboIsKZiH6+TAgXNvaCJADs2z?=
 =?us-ascii?Q?nTp/nvReutbU5HoNe9YajlPTlFu33cc5hv1xjqdTJIQx5erz+uUW5Rpm+qj7?=
 =?us-ascii?Q?YunavDiUW3NAYqcrz7QL2VA0gnXTh5nyj3cARVEwDu/4C91Yq2OZoEBiKgXe?=
 =?us-ascii?Q?I9dESBc0L48scBVHcO6rPe15fIoMqk8kFIWIuz/KXKjEO6MZtBc3K2XctCSs?=
 =?us-ascii?Q?TR7w1jLFxtTv1u2q2KzkMgP4ATwXAaezXj9fAfkacOP6LFXApijfAzozIkTt?=
 =?us-ascii?Q?0crhOmpni0D09MnILBOmzb1UreGrZm/ts0LqdsPc4TSV9dm+b7fmRMyjIZs2?=
 =?us-ascii?Q?oc50fqEBAsczFrP9l3dubjmjOHntq8jsNB1sJl2lL37YKLndsjuQcP9AZ3OJ?=
 =?us-ascii?Q?hEPYJfa2VMjKN5IhpWJZZh/0DMJhW7V8WEKTRhfoXeupxYnnEWHWJbCUPIbO?=
 =?us-ascii?Q?glURyuAErmMK5bByY+1n2y74VvuprCNCYJZIvB9A?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67941d0-f9c7-478f-6d30-08dba51e7b98
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:50:54.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgvCHiyzkbC9LlHTmKO7XwJccSpCBB7rG6fzusMurC0lxzYjXOeNhsT2zr/RzpF7qxLYA4kse0OvWLm2XUn3JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

Add a new helper chk_all_subflows(), in it use 'ss' command

        ss -ti | grep -c tcp-ulp-mptcp

to get the "correct" amount of subflows, including the initial
subflow.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2017f14408b5..c6babafa3b47 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1850,6 +1850,31 @@ chk_subflow_nr()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_all_subflows()
+{
+	local cnt1
+	local cnt2
+
+	print_check "all subflows $1:$2"
+
+	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 # $1: get value of this info $2: keyword in this line
 get_info_value()
 {
@@ -3441,6 +3466,28 @@ userspace_tests()
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
+		chk_all_subflows 2 2
+		userspace_pm_rm_sf $ns2 1 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

