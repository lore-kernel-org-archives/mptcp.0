Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFBB3FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAJcDYuFr6p0S5r60/9wyyL2cbbKjRT5s7MJwVPeJkyZN5xWjcOd/SopGJuiNGY9p+zYk5rQMBYA5Hh/iRLCXdSE1Wg8TMSlwqqgVeKqJlR0ChhmMkwZAE7ISnUMnupZMnQL8ZJWbPas8ug/qCOPQ7EKMM4WAlfQVgkkScilySK5tNw+A2of8QAd5JGYsYGVMZVMGT9EgjWSrK5uvh6YNs0JDEl7IQKwgPQTHwZD/VXasFzDqH7VosDN6uQIPXUcerTsQ2buV8QbHi/6Ya7Ii+x+w9JmyRUnLFlJ3Ti7/1mJ+YTE7gzJ0+tkyjSP/nhIETyaQSKPvMh0FDOw0o9zfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bydDROSsm3rpJY5/kWMfWLhNClfLekoVJ45cKwtN7s4=;
 b=NY8gaY63GUne7Rae0KHso189WDkInizI0bE4vBgTB0ngojau9RejApe35K1KPsbxg2maUCiV2Nym/aZFBCWIz2TWYnLzwSLb5IG32+RdxXUkEyCuAX2ePZVE2h09X9ZdnegOH9OpS/dXwv8qIpR8DcrpBQqwCCI+YoazA0MxkOLR9f78WlMnRoso1Em0SIxm2PIiPnAkOF0NBJtuIx/I6JRu3ld33Ti4dp/ZS6ad/5Ni1h+RQ0j59vjfzIts7LdrY79/dymrPKr7q6p0qqevo5KvEhhPnc0zgc0nQwWHJBBGMd1HH3UChMtVFuXuFmY4AIHre4pK3Z20/ny6FDVFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bydDROSsm3rpJY5/kWMfWLhNClfLekoVJ45cKwtN7s4=;
 b=fMAHEoFNjHAY63KtoqTc7mXzfS+sQBeJ7CazNy0+lYC2xdP/SvoBcEc3aXhgAIdLM5PTsc6GIEt71aO2mMw7u1563sZRYjjBetCtuYX175KLzVpBjuSzpS60vlw5dIxomwjRbWDLRmwApenJkAS8nMryXA/kahDU/zEOIUGHWh+DtlGm0h6RIQitA6D9x6nxCID+hAEUtT9Bg+Tl/Q+H6rK+RZCJOEaw+e404ZwsFSBr2NyUE1gtRsFAdOa2eOWRuQASF5OyxSVlcLGklxc+2hJ6HTin0Bw+ljcmR0XqaS+KAhDQCPxFbiAgMmOX1BK8YonvP33fm1yPZmw21GbNZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 07:45:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:45:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 6/8] selftests: mptcp: userspace pm create id 0 subflow
Date: Fri, 15 Sep 2023 15:45:16 +0800
Message-Id: <f702dcd004dd39971fa21914a43183f9b8202538.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: c12305cd-5432-4484-1293-08dbb5bfb737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	puH/fvsggXcz+g6AEQP7ODJU4ODc/3NqskKRkWRmtKy/wNyahHeldmS04CBJPrAVCHEtQ3FQHcy83kd+mR4QSR6D+rExzLIppurUo9VTMRtHoaDtGAz7ln54gS9rsHvM2QwBTb5fBtum+NJDeu9Fxsw8MmVK5CD7xrl7IbcdphxG418x6jnNnqunBDOXBtiGK05ydYaavCSRpJlbl2bJpufPHKt8sT7o4/wU37+r4bSY721gF/OkRZiMxlwNIBXDlyQbWFbrTQbPPRRxnfDaRa+yJPEz5oXCaBmHm2tpgimi4cLUeMikmQbdIzqXS/WB5rSzFO8HPqUphnNCAxRJOA46MTK5bhhcDAJDwBUCof5CEmNcs711o3q3JgCmh/iLsAiQ9cOGAzGPxR8FiQoQLspdWAIJz7ION5Q3WOdaEXv5HwqOqSIFZd7lSggs64VNqMw4XBFkfCXWLyBpVqEMgMXJyo6PH1oQMPwUUr1g9q0/f1GzIQqWbSb2UfCqS3pb3Bme5U2Qm7TncWJ8ZwrUbR9bTuwGQz7q8O7DzE0SSYKIW15SkKTlsvw2gMTDQHGtBhqfUP8hZ+onePJ8aYsqyedVfdQjIf+jx4miAAR/hhc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6666004)(2616005)(26005)(6506007)(38100700002)(86362001)(478600001)(107886003)(8676002)(66946007)(5660300002)(8936002)(66476007)(44832011)(4326008)(316002)(66556008)(2906002)(6916009)(36756003)(41300700001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?46OC8kDisoBE0wZ1DgXjT5x3ZtEp7JDTOElB+iEhv/gqcW+XZUVB6yebIV23?=
 =?us-ascii?Q?Vnie+SEsY4i196E6rAJVF9sZwE0cboDeij9k/MUyJ18J1uZ3dv15t6SNp81y?=
 =?us-ascii?Q?Q4Zy59gdTi1OIHomKfGZAuvrPEWqFvxoMDOcLo2AzdLRJ17jgqSbNnLqQ/7l?=
 =?us-ascii?Q?AjIgfSx+eGs3A/FAEZMg4CEjDNDHpTlcUZWjZS34VwQvmAXSzWJj3Eaq4DMN?=
 =?us-ascii?Q?4jBKHLRTeLzTMuP9Dav5Cg3HAM/2vqo2TDBF658Q8ArkNSr9w4hCXVGxKK7R?=
 =?us-ascii?Q?7/ofvHhL6LTOq2rDcrHNEWyHeQ3hwgTNiG6kqm0R+zVPMfS0mAP3slFBiTH6?=
 =?us-ascii?Q?M/wYDsik1kg8t32CpVui1Y6PNji4iervkX7ZJdS+9HI9r403iEAsmwj2bwYg?=
 =?us-ascii?Q?lyb49ko3qB2SFTbzPma6wWO2DwLUNUGQXS7H6AHvttx+aLcpllda9UU6DJKh?=
 =?us-ascii?Q?K53DjSNC7dlJGXgCHs6d5VzYDXrywUHfWA86cMdwKXqjKAzK5wIRq6Bn/QrJ?=
 =?us-ascii?Q?jwwDyMKxtWs8UBqxT1lYK0sg8nMTt6JOsjSsSaRhSh9sG5+bldUCxwMTYR5Z?=
 =?us-ascii?Q?GTFMfbsUA5KF/Mxh6ksLOAix1Qre3gjnXyswwXIDtlQdmbt9aJgnEilo2Z+T?=
 =?us-ascii?Q?ASQwUDvOdn7sK12hs7ww+CPMnmeTXCMo7EvSeP8IfLFpHQ5wA+znU0aTTUbx?=
 =?us-ascii?Q?V/f3a9qPhpMVGTxmq6sRJZY5eCS4wI7D39gz/tdd/224+jAcnPxdLV1D21nY?=
 =?us-ascii?Q?iaj3z4pN9zPsbDSLv1vP9v5w4DJlLQAAzJ/qpPpgHQj3XIdLRWmTiYJPJAc5?=
 =?us-ascii?Q?O9IrVmikKRBAjqG4eTqacJaaviGxFP8rfY2KNY26CldKxOsnE+DLwI1TQq52?=
 =?us-ascii?Q?0VEv5DVaQB0b3K/2pft3vkVE7Zhc9+I9ibzAg+n5AYanfYu31ts0xXTFIr6K?=
 =?us-ascii?Q?cjJFV7iVUVsrZ0rYmW1777mWE41Bq/ggLq3+IS3wpsf/lXYrPzj7LBcR0ztL?=
 =?us-ascii?Q?KDknQTlLi+kNSZi0pDwFL9MngXevEQAKB1SaCi9+/gBv/zspCEFZMOBYalv/?=
 =?us-ascii?Q?U10aDt53L5jFwX6p22huoWLSMZUr1qzawU+xK51h0gsWlIPyzxEJzUtwj0Rw?=
 =?us-ascii?Q?yCwf2HOzlCflji6zXI4B+7G7AVdn6lj37/TADgbTsOQFKqyIVx2HF8le8tg7?=
 =?us-ascii?Q?1fciaCbYz5E6ADhMvFVa1Qt9fzrKnD00DUq4RSB9FdG8X/SUB+Zm3GB3Vz5Y?=
 =?us-ascii?Q?tZneWHfyvlkvlLYWJCbs3nojPwr/qbj9jZqqpI+lBc9WBLHVWZSn15XGfBf0?=
 =?us-ascii?Q?QKqE79wwwNYShVbSIv/fLWpSFlclBlZPEPxAZA2mySLZAkrFqDsa+2fEyIUR?=
 =?us-ascii?Q?wKFJQeXGqK8+NELOgCqaRmTIMnfpbNyetve+vU5+dXNNfZLX+r1h5Ys75+nN?=
 =?us-ascii?Q?fi9Wf52hzp/wlzyeeKvsY2NFMoA84SN3ujSJTbaglx/tNE5ILEtej5ELDUn8?=
 =?us-ascii?Q?90nf38y70z6j3IQcbJJlXEFnspj4ORiN506cC+4qm0ygUlLOuBSER+9aAe0g?=
 =?us-ascii?Q?x/R+f6pIzh7yIw559MIl2pfT1mswcOB66XM+OSPo3pGXEhEU+O49+w+xX0pk?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12305cd-5432-4484-1293-08dbb5bfb737
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:45:22.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnGSM5o/qopfe1qYZEq1Y83vm6HZpU7yqeDfUJ24rxzzGz7B+i1avDutxAam9nwl4T4SSJuqMzOfdHZkFEbKYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_subflows_total shows two subflows in each
namespace.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 662800437a38..2d5815ce9095 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3462,6 +3462,25 @@ userspace_tests()
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

