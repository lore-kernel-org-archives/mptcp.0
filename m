Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5519B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="29lhoZeZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C97h0jNcQoDbgQzwwXji7/u06+NeKo/v7VnIZOqij+Scf77l7aZfriO5/IAcxC1iQ+k1anqcGJIg6PZFFWxltv53QhPIgxEMlWX2EH5reAxxLnVRb4qvktYi8son8/l85E5LLMF3+Q+tkzpG6OrLScSm/5yjZ1LqJTXmoTDOtekwJL2SXyCaboB8a/vcNrzARQLeiD2iTb3robr6OZBgnG72a+T57076rjtoPeJ8keGO+x3mHTPdkirJFyDHVMp0uitC2gMzv9N8HIlWuDBPDgMwLWTNjApmEIiqNtDLZyp1lNJSHahgoFUNOwXRFcFm9GBcfPTHVPbZWhYX4PZyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x6RUQi92ZQ0TFpEo2URyNwdp5s4hXRrx4TxRlASQ3M=;
 b=OtOmME98Vnfz9AxFeWsURt5Urd/pozfQN5a7Cnl79g20VzzZX9ErcEp5N7v62w+l6Q/DE884BBtPEvkfcfK/u3w9XBOi/hD3+Gw2WEIM/hjyZQaO/KEtVt0VeMswfYUGFcy3Sxx+m9Gf0p3OAO3hzFX0NVZYKgkVkLCQu+RDT33SP9cE81RTR1Jc8cIf/G79AAlr8wn0pwGFa+WxLe1IoIneLcXPReSHb24svNs+F7E72VJMwu0NT8hq+YEizyr3GkAuVw1QnGigJAlXN8I1DgZu7MLElPSFLcehC6cd7LmclXerJnYQq0++kLR601nPP1q+KAWZMIb0OWy/7sOZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x6RUQi92ZQ0TFpEo2URyNwdp5s4hXRrx4TxRlASQ3M=;
 b=29lhoZeZ3CIpMIS4vmOaIla15sLcE7h8CCK5MvDJmx0mGCWzhU1xuYpshXLTcu1ooVETtqD0lQTJVkz1zdbHADaLd4JPn/Pn/VRW9Wf4bDy1wqLQMyGW5ig2e0ey9dwd+aHlzwOK7r78wDi55maNPBAukbB3XgVKfAjnpTRpeC6T0H1tGdv8y8tNS0CeQhgJlhZnvYIuTwh4KJ9qm1734z+LakaeXPWoq+KbqaLiM/b7s4HA0n0eY8XY3uzOY5KKCkdfPYpApYzeImUDZY7al/sDmFJ8lfDjUzWmcVHAywLuGLtBRFtJIDPb0PW4RZ/xWhT7CQbt/vn3WJt8aVrx4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:57:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 09/26] selftests: mptcp: add mptcp_lib_cleanup
Date: Fri, 17 Nov 2023 16:56:02 +0800
Message-Id: <ac52d66e7d7234d0621361f24a55ebce62f799ef.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:404:29::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: a58e74b3-436c-44db-af8b-08dbe74b31e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KwVHBmCdOhjJAuwQo8BYYa/Iz+iuLfvXP7Xndre0OsKdgW3AdGhobF2HNZ3ag4S/sgYCOsHb79pqLjqb19azlTUHqQvjEm7/ieHGqz5STCPTMLJ1YkUm95Ov82uOg5alW77f1GcLE2DoFY7kek54kzXJuN581kPb/fYjiZ6ftXtiPFzKVgRGy5zk9zY9T5xpwkuiXOEKcwbDalh0oPP2f6rveWq5dARoT6zIKSntZifDEoyGs/oxJBb8ozRPZrEb8N9aUoOyKfodmWl/fkkkRuslF8x+dZjZNTH6tl9Oyw7jXi53EeUAPYqJlCrCfz+bLk4AhY2Ia24ev1AHQHuPxenph2+pAZtjv31HyYcbGwzUGsJdN7pcgSGUWFuwp/tB0Rv519as974WOH3cRrnJTlYMjgZRVKSqAjlJa/pZnjn5w+1TBLZzosZBQCbgy+NWocAE+VYz18fCzFQSdoscTv1IjaSIb0BtiYNeDBovfMmWi+Isl1Ieyol/E4o2CF0+aClMfakTXtUKHdu0DLbG5YkH2MepzH8nqknFzNQgIFUBbRd0M02O6rm8uJApbtmo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lIiDkvpgsxP60WAJKXCCOWar7uzQZH7dRl+TItQob+bBL9arIHArqKgYgIws?=
 =?us-ascii?Q?iPW/BCXG46jeu4FxDp0pYdfDD7JwgyeGtybLOQLNJGGZUMBCckoOYKpbEqBx?=
 =?us-ascii?Q?yyd3qypMzRcfdzsBvR+Yv64dMyxmh/M7DnfrHc+YD6eoIdESIpENdMPu0nGf?=
 =?us-ascii?Q?X560ztgEYtdAAWUtMiugvhWIILaYoJZuuxRn7/K0jH4wkJnhyzVrkzge7P9B?=
 =?us-ascii?Q?XBxRgPA32qejDuKIgzc3LTkbGznunonYwPw3/09XPNvTRejI2QnU41+fUrAh?=
 =?us-ascii?Q?sDqfbOO2k5jcF/VhEKQekXOJtEM2F2JAuQmGSZc7xb8klKePz/ps+Nd8SYhS?=
 =?us-ascii?Q?ZVgJo4mtmXrDwcb26QdT9P1dHQvBUeZUi7k722hhCBbNtmfITf2QrjJ8WeKV?=
 =?us-ascii?Q?FvphLn2hRIPcHnCL2vjtc15WmGtctkhfbpgo4XgU5fnwEjx4bPF7xH4pHMCo?=
 =?us-ascii?Q?CHcwQJ7Yl0cC6cY5VHUYiKcB1L6Mqock/YRIC+1LnH6pbVARY6agvDSoCOJ1?=
 =?us-ascii?Q?prr7PN6LpoQzayS9mmB6ugZxd/fi3HhDqhLGIPtMJ2aTg8d/1DMeMjAqe9ER?=
 =?us-ascii?Q?NAaBn0TYeVcSX/o0N9MKYAMt8ifuiIm/0mfF4U9NQiET/M0kFccc+g2WWz35?=
 =?us-ascii?Q?cdmhpOhubiGFogt0T7eojBhm9uXz5i+Z+A73JU0X0QPfzCOVglRcoxwJmERV?=
 =?us-ascii?Q?mRJTR/CQS7adGeS9Ycrmh/loaj7KuYD7sBCBdaJzSgK7PBOYNtYaj8dfQvPN?=
 =?us-ascii?Q?I8NFeHKS9t8DADwwbC0964UHtXZ3pFFU8ePZ95rdAdTXrfh7xmhc3V4khogY?=
 =?us-ascii?Q?W103DE0NXL0Whdj7yWh2iPrpPfnuthQaJGwghp2JU+koYMB4EAPAukLdvdlF?=
 =?us-ascii?Q?+wG7IPOrrx7Uw2F24GlIlwpSG05EtRCJhl1gsbcmd0Z9HCizBePDy8XrZpSK?=
 =?us-ascii?Q?+UZOZtYfF2rpsvCaU7yx3NNnwW11zqhnBL0XG9KARXqP4ksmiSiJXTDeTj/T?=
 =?us-ascii?Q?h6Pob7FyVrtovT7kjYtf7ZG0g8y5CfRR9F8vlBJs2Zl1c5N2kxeFaWjBh2wF?=
 =?us-ascii?Q?UpGDDjHs2pFNi6gDVUakgrQUN8QA429hJrYFdpNWna4PAlidWvSaqNGDXuap?=
 =?us-ascii?Q?UMrQPzDJ5B3goqtCnqnM37mEioqbXPmaAhljK+S8ZeqadVRsD2j/KnCYbv5n?=
 =?us-ascii?Q?LfvWZMpbpnTHwUHbH7H/XfXmySyeMADVHKd5AhyZoRdJA8FnAF6LRSaizDGn?=
 =?us-ascii?Q?UZUGN+G3Q9MKPP75NXosI3G7UQOWZ76rQW+MkP8k14jm31dHQz7tZ2My+vRi?=
 =?us-ascii?Q?LrdQa5/6zTfe45Yh8boZ/n1PjllFb1FzD9brVk8i6aha5Aj7l9L9MNsXB2qi?=
 =?us-ascii?Q?84TWogi1XE12hwLVvtzMUti776sqwq0VybPdWQGry9XLl8Xa4HukXVkMvLDo?=
 =?us-ascii?Q?/dq6dV3sYKVq1+9WhjpBhniklJNPDK0slI2WkwfQPTC/JEtScgpWXYZNVBFJ?=
 =?us-ascii?Q?6DBs48lAgUYnEBbu8PQdk1wDbBd4hh8hbXp6+JCLE2LB5vsykInA9Kp+j0p0?=
 =?us-ascii?Q?RzZtmLsg7saMSn/AKk5xYaut9Sv/lGUG/zRs7PQO6oznlTJCP6vqfvx+f0tb?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58e74b3-436c-44db-af8b-08dbe74b31e5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:15.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKiT/7goPwwVdi1JWfXGwPYKUoq99NUizzXk4U3VLPz/Xh17u0TJ5Ok6pBVP0tuMTz9cEO8lqKUBcarfnZXloQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

This patch adds a new helper mptcp_lib_cleanup() in mptcp_lib.sh, it's
a public cleanup interface, being invoked in every cleanup() in all
scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 8 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..a678ee21973b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -31,6 +31,7 @@ cleanup()
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
 	ip netns del $ns
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..98f4e82789ba 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -143,6 +143,7 @@ cleanup()
 		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6fbc70332caa..7eb62553569e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -198,6 +198,7 @@ cleanup()
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
 	cleanup_partial
+	mptcp_lib_cleanup
 }
 
 print_title()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f8be9dd0e20..cbaa55ab89b1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -299,3 +299,8 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+mptcp_lib_cleanup()
+{
+	echo "cleanup"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c643872ddf47..75d8c648f9de 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -85,6 +85,7 @@ cleanup()
 	done
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..fd413b4c8123 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -34,6 +34,7 @@ cleanup()
 {
 	rm -f $err
 	ip netns del $ns1
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ae8ad5d6fb9d..436500c55e12 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -34,6 +34,7 @@ cleanup()
 	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns del $netns
 	done
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6167837f48e1..005251b61d7a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -129,6 +129,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
+	mptcp_lib_cleanup
 	_printf "Done\n"
 }
 
-- 
2.35.3

