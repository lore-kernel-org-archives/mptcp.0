Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FEB9CA42
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aZ5XcOSp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK+EPVvfDL0voFgrbJMzBH2LZKiN/70R57HRihVUBJnxM1f5mWbDuLyShNUCyF7tR7Kg1dPNVDJ+rfZ9IMaxzlePLdF2b+uNt3Ch/OXdtBgYGUTKYTWdysLsUvjmGaUL23ygwdV+kpYIrHT9LebGZdISQLQLToO3FyQ7cGnesqDUghdL0j2U0Wh6ixou6wKdHCVgxUsyS3WxxmlkFqL/KCmLXGEGvQ8NeL3M9s34eFoZQLey3/LtRw4oi+ZO95sj4zRW4GUL2+kWm/LucG5mRvFwRmHU8TveRJadfNcJCP0sIfoBXPdWPBSgXQu+82ZfTN5byAXgA/05aDRE2pV0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROuMMGJMRfCKgFVMJUF1Xb856vDr2OZfTITup2Ntwiw=;
 b=QQBO0MqjGxtsVk9qQ46IeeL2J28Sumar5h+hARAHRoYlGBKRQDUKaIXZjiGwB0k4BDO070f0TbHh2+WHxnUuqgBfFFEUIRS4SoR/EHXaYVU1+KC+8J4JcDpXw72d+O1RgldYyoTcNSkeKAWhzhnsvNV8kKiNp0E7rf+8ktmRvBQxnkCak54IJQzKWFL/9I96KCgvgTEppgfzGD61QE6MoiNTX+BHKaqSaQs5oKMCUz9ic6JouKWXKWWNgNaU8ywLVTqwRWFlX2Fj1sJtSfKMlHLEe0AO6KGuMycQTMF5ZmQ1TPL7O9rX93S/8yxLn/ZW1jrkTzH1YAuQnV615Ro7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROuMMGJMRfCKgFVMJUF1Xb856vDr2OZfTITup2Ntwiw=;
 b=aZ5XcOSpYaLi2yJKVp9or3MiF68DFakrUkFx6VDgsqVTKydovn7/lqql8BH514gO+jteh6Y/tDJ+Mf3YsfVKW3+PziO/+I1i4Z7We1Yj4fK7puVSUx2fxC5s5+xsZ9KahRqUCSYP84W2inpB3XNJHP6Fm5q4TXxbOrE6Lk4Dglt6fEpAmCs2FRoBA9FcTcZJUY2OpV4Rrn59kGOQQcui0dAQ/KOpH68FUQL1XmPkHtqX4NTHF5t2TWB8tDT2ORnz9TzrlgfISGKGByWgbpJyz1w5y0NmFpOvFebt3jZWCEPHc/c1yBiGYMR+RJWVPtn34h+ZomMcYsC6kDyDnyrwnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:02:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Mon, 9 Oct 2023
 06:02:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 2/5] selftests: mptcp: userspace pm remove initial subflow
Date: Mon,  9 Oct 2023 14:02:57 +0800
Message-Id: <0d19b716240142a60b551119042bf6b08b73d92a.1696831239.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696831239.git.geliang.tang@suse.com>
References: <cover.1696831239.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: ef59e8fa-a66d-448f-504e-08dbc88d43a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ou2pY4CNs2njJ3Qs01T9eXZ3ywqEQzuRRlB7EpkqsLEC8TjJFBPUqB+RZkpWp/74q/YfJuWp52SFe283O3vKE9aJN7x+qZ6nKEvnj+zCN2NUXf6a2Q9JfUboJ8zcB1tnqwnjzaK6iJ3Y9dP0fkK1Cj6Y6VwzhQ+dqAZWloXWllVHRNsXgMWpT0Z7wZJbKDqTeT8rvm6JmYUcSSK1IuyWs5EIEYotVkWk6IX3OuU9yMt6Zl269m1zUzhIP3lH9KySvwLHL0K+WKBBaPUJHOJsbbN94eiucSvG8FldrIIskWhT46SflBwPwVe8G4+smJIkV6egu3gLQZihAtEx7RBUYaCRqci1W3hB3OTfsVywI7RsqsCCJ8/jx6US0TZSsVzUUc5kE11rNmfuZbrkt/SZCZ0Vd1oTVgvDtMKTTg+cPAij/BFFVp5Nwv+PdzF9RgOJAl0zp0lEDLOFAw9tNcTHHF+9tRcf1v/ug5340a/CnZzC2lMn1gW49854IH/rTYpfWlJ1wd94WdhAk4qnc5dNPboJhH5LMAYvjvTUcnR6BUv69HrXeLhGfObXKRN/+Vb3I+XhI4PUW53WRZ/Gao0RyPO4bk5Zfpro/L+oct9miKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(107886003)(2616005)(6512007)(36756003)(86362001)(38100700002)(26005)(83380400001)(2906002)(44832011)(6486002)(6666004)(478600001)(41300700001)(8676002)(4326008)(316002)(8936002)(66476007)(5660300002)(6916009)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajunNpOHif2EuKXKCo/mCYnTq2ieFZsMd76lGGeCSxapYCEt3auGelqsloFk?=
 =?us-ascii?Q?fVoCEqJMV6yUlvQJrigLeyHcFJ+4RFs+8f3rtXVwEQjljOMywzTFeQ6CeCc8?=
 =?us-ascii?Q?z39W53yIrwc7iouejozivp7+zZgl28sV7Dik6tdAGS9FgpYfG3zCURJHb3iu?=
 =?us-ascii?Q?HEYlzTaDTKPf/cXR1CPke+UPGMNOkjVCqlunK7lz0VnJ27lSlMgQqnkWCulb?=
 =?us-ascii?Q?BJC/JSmuwQ36ilgwBEh/TSjxVIv4cHqLQHa3QqNwp6lsf+UK0WTmuGuicAqa?=
 =?us-ascii?Q?kjtgqaYJ2jEarTX508BAcYcZxKbxyJCC2TGhFzq1hO2G0C7ioWaI5BKSb05T?=
 =?us-ascii?Q?+ai/Xo+v8PX4VwwxgEqyqdubwbT+uf+kGEhNItoTE2W6aLzvsF5BS94ApWae?=
 =?us-ascii?Q?IE8eQa/oaSolzhnWYXsHz/bUkZtxtIW9iMTjZ/2UIMSY1dNU1FtXWWyF8Wzc?=
 =?us-ascii?Q?cJSbigPoTrMDPMSHxQxDyIFzFsjaxpRJv8IzfdOYVq44hpKMB/8ub6WiKg/3?=
 =?us-ascii?Q?4qs55jhIlsCIjJzXErgjMDxJYxkyrW2FxPEvbNS7FhUhhV5sspF9lFO1Rum7?=
 =?us-ascii?Q?cxvSfzxsN/q7Dd+YVMeQ1zpSowJaUwSS8HDe7fNp/wAowwOwF2GNPDB94Vmf?=
 =?us-ascii?Q?XFHO/yhzGk7AjuU8WaD64MVxohqyCIsVbCoyDq5oSr4ZRoigdHpJy9VmPnOO?=
 =?us-ascii?Q?l6UxukeB6L5VoHJEDReQEJREaJVH4hs0dFH97bbLc7HKFp70Emv7hNmpMlC+?=
 =?us-ascii?Q?QvfmuAiXdU8lySaOGn8mMKkzpbW9PLPh8PoUJMofIbpFgzR7/XBwb6d2fZls?=
 =?us-ascii?Q?PqqIKTf7Yrnex/BbDkxrv/RK5By8wE8U+d4TDNcs+HtmTH9RbiXqa6GmhbzY?=
 =?us-ascii?Q?Ocl1X9hGPl7rNyz4JMweGKpO+7ZozvOD/bklJa5fa/wQ46bh8Kodc477lzG0?=
 =?us-ascii?Q?9osFOdYpcT9h6oy+RxcDilhQQONxfKsynXCzzk1rV5KatExEsiWOVc83Lk+b?=
 =?us-ascii?Q?de8/GAJeSMm2j/zbm2nh+U2Y9TCkr/GVOxygh8Fg+mEdepo+3SgkJttxIHR1?=
 =?us-ascii?Q?0JteaNx56x+pwWVeMQCqhsBoWfZpFTZ+u/SONJjxLsRWFH36TSHE7eehV5oV?=
 =?us-ascii?Q?CKr4o1rQeJUOGx0nXx/gwQDsdsmldVddsv0p5AVlQedSRMYmUq+bz72sfJaf?=
 =?us-ascii?Q?YKZ4SNnwhUsXxEO82howB6C9ahu8FQw9HRk3cCfwAKXpmkw36vbzKZBsJHib?=
 =?us-ascii?Q?tlkbPkGvSUQOxXfbgtjNZCDHg4k22c+TNCyjD9TxRqjz2dSQYBvjNFtMGLDY?=
 =?us-ascii?Q?zQJAKxufzs56YlkPq2FqUxOH7y+A2bg3PVbu+kIiLT5nmZ7xCU1qrVKdFDUT?=
 =?us-ascii?Q?G+ho3jtxXY4xo26vOcxRuR9ObFRuEM+ksrIcT3mLF7HtLG4PEUVVXPGUd/IJ?=
 =?us-ascii?Q?hnbDczUR+F0v3w8J/StHPmwG81y4+hqzgE2ycCRhi7/k1sPTw7yY0jAQvXPL?=
 =?us-ascii?Q?xFoObnwwfCQu15EH3MnN8Dt8idru/xfWF2+OzDniuhkn5nOx5U7L5wsbJL4f?=
 =?us-ascii?Q?SzbQpokOmiskjJ2E/1Ka6Gxbz8tYmclSUnLabJ3N?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef59e8fa-a66d-448f-504e-08dbc88d43a1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:02:05.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O76b/914qnwGdUGy2Q11Im5g40kiLCuh9d8hJgNjBk0eGd9P8lWRj36ys5vbP1HqPK/mrVjkgJTItOAUrivnOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

This patch adds a selftest for userpsace PM to remove the initial
subflow. Use userspace_pm_add_sf() to add a subflow, and pass initial
ip address to userspace_pm_rm_sf() to remove the initial subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ae38b428e42e..d396b290e20b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3490,6 +3490,28 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove initial subflow
+	if reset_with_events "userspace pm remove initial subflow" &&
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
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

