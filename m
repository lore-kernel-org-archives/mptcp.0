Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2071.outbound.protection.outlook.com [40.107.15.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333EA2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr+2ebS0VjLBBPItO7vIWLbGW1R5z92hrOT441Ay6S/C1rYsXX5TS3+ZnRkduD7k0OTR0BSnQqvDK/RU2j13E1dxhqXrUMGvY6nIOlW3WVRXBI3p0JDEZAAGHUE//OzkAi6Z6fDu4Y5QKMnUawGg3QctVGr2dbIFtsYCivGrKT9WE0Itim8ycFugnZ9oUTKRWtBdqfOtqoTCMPFQg8uYf4/ZLfAP7mNdkibwlcQnlTrsmu2lqVQ+XezSCdbMAhptIhBvXGnLi3s6MhUDvmtQJevjWMPEvDupn4i6nfKfjYEnn2nnE9F3ScLWQyKXZCVYTv0DkVNZoMhW3xACeMMRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT/iMLipWbgQr9CGm/imxYsBNYzaFDSCA+OqrssD6FI=;
 b=na+Y1kzfgEAJvP2S45sawA6bMWEIQa051lYDcxgVvtAlrUhRqx0tk1TypKqnx6cP/Qf9V+djymXdJ3VnFdBYRokUdSHeAOm19VGuFWQhqfyJ3+hWv7Xa6K7b1QJ4GZUw7d2asWNo8Q0PT27ZtTdIGW7Odx+0yYJ0TuErHFYoqqaYXd0OFcbLqGIPl4pvL3I9gDhpwFn69dNRcMmcA/BjsjyGoR1X/z1l/8FrjFAVMSsHhz1+mIRQ3/9CxC5AnPMZUb92dmdvxvuFE+pV2YbrWOTsTZuEU+fYPDDQho5f8v6BppSpZy3xIYD+o51wSfYjbTdJLfkuG9zLOEm1nIKNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT/iMLipWbgQr9CGm/imxYsBNYzaFDSCA+OqrssD6FI=;
 b=CoUKAKqvrEn/VXxLPAyqUsamvyOmsPfiaCJbw+ybM9MQY9fZIccrMVp92r8RTbeGEjJ7Cbz05z0W5T+w1H2aOA30GWYbKLA6925bOomzjx+lKnlEGh15ztw32neSCLw4u7J0NSoqCsWixmxZB2B7gSV0FlegHFMtOcaz0sUODCtUc3SXaDVT+7qnBV+Ftht3+LLl3Ln2wQN0CPu4ujaW9CrJu+dfkrr0LS6J13BWLUmj5sAsBeIsnRPvSBQt3/xXSqxXKhHejPGDVyRWYGk2lyZnziOHyxwvm5KkgOvbyu4cjigxXBjBopjPVWvqu93XTcSFCQXmswTHe9DVGcE5qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8298.eurprd04.prod.outlook.com (2603:10a6:10:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:21:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:21:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 07/12] selftests: mptcp: do userspace tests out of transfer
Date: Thu,  4 May 2023 18:20:12 +0800
Message-Id: <0492e4dbfdd72aa01714749270961bcfb99bb0ab.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd7e01e-4e60-430d-0b8b-08db4c89459d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wvCvNDPYdx19VjgUlsJlt/rUQUQ26/6xb7IsuUUb0od5KYFgbtcJmXYybFOI4UZyNfWhP/TQz74wpsZWgVzuHNj2qfCQ9ZOmYZq+xn+6L8hEz1Ey0ryn3sL0Id+CrgsS2+ySC7G7xNdgqrpxDlc4Kzx+nUhPf3eB7g3p4V4ClCJLD8kb6K8abnYIKMpC2EVQnPxBA8SrccSYf+27NLJWzuMut7PZj5gR3Npa9REPqiUT+gQNhJAaozzCi7DUtPAhmsOQ/BwEPiUrAGCLKbR44M17qK66WgDGL7HttpmR7pPEQcITd/7WKr8zE+vEVIPCzheRAvvmkhVxKNPeaC4mZAUeoTtCei1LElKuZjZWpD5lJTmRnVyz5ISkEd/HYPfgj0OvJ/VbOiqORvns0zj8GqoZ1nTcI5n3n84LpwtILmjkSwgU6ecUKqPmc6giwp4blok3IpLmsF5656Syu6ZACl66u4VH0l3O/e5ZLjIhpr0fPTRyGG/Be04tJnSiOL2xuiOpEIb498bXDIfxhv37Ewylggz83izbhoHeCvHPcCdaWKkWKRBOrKagSSQ+/rz5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(44832011)(38100700002)(478600001)(8936002)(5660300002)(8676002)(2616005)(26005)(86362001)(6512007)(6666004)(66946007)(66556008)(107886003)(6486002)(6916009)(4326008)(83380400001)(6506007)(66476007)(316002)(186003)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPNSSjRKtk6DkJlVnTi6GtG1tWQ/UFmt2vCA4lT4QIc2gNLLpqBpLt8eB2YH?=
 =?us-ascii?Q?Lp+vPwZ6MMwjNIP4EVNnmcKfsI8bt1UwzGmf6q/Xnv+sSmCB0JJw50cysVCF?=
 =?us-ascii?Q?ri7tp91QqUspMYHamSGcjoVZaLVdqygu9+QbZFtvEutuYmW3EGQe8br8LAjf?=
 =?us-ascii?Q?8SfY/Zv/4PB9DEoKR2qS0O9deSaVsmbohDW89TEXaWxcGg8bxI5enj5vNBZc?=
 =?us-ascii?Q?jJY3jZrJtOLGoAlQDK/UIHeS3KBPzr/la5BE7NBY3P3k4dw1Od1E2YMeK6mR?=
 =?us-ascii?Q?Oy+7CxV1yakjVMFIGfyka+ruYoTqmN4TquFV1Awr1VsecNMCXPcjgaNfG5YH?=
 =?us-ascii?Q?9uBakxGwz6/Lz4I/XqClm/3/MdZAX6jEfHyMyOXfdTqcpOC9iWCfy6ELWS7d?=
 =?us-ascii?Q?ne6vx99ICq8iu7PONJLReJZCSC746t2rGlg6C4AptwFSZMHdBk93yHzK/SYR?=
 =?us-ascii?Q?GE9ELI6+KD5SgBrcRviv2omID3rFiWhm1qYk9x3mEQB2edmClQnqAY+8gMT0?=
 =?us-ascii?Q?RCAD1/qvA9MmB7JQ82VbzScz1LmJyIZgivlZZxoGIWrCeJ/PKvoTj0lidTiw?=
 =?us-ascii?Q?traVYeJIEQirKgxYlGeV5qBW/yZm4GybeVrNGXKbUqNRRNGvmc6yEZ1OxVYX?=
 =?us-ascii?Q?VraNqvkt+F1azUMZRFkz6AKJaPrS7HWGwyesmftkQ1x/6vBMymw1fmBYcySC?=
 =?us-ascii?Q?dQoSouw7yfpPDvcj2CkRF0OxHeyjSg8+uFeu/5K8kvTogcY5rNIKDJ0KFSha?=
 =?us-ascii?Q?RDUMPsHam6MNFwxnjxKMezNuKxB0X299LJHq78KRbEbYgXJUPWosAjVHsYmS?=
 =?us-ascii?Q?k5fZbhZXweo63uXcTXxKflQp2nQ7tpIiy329r2Zr52/Vf9ZUHBMZmogVmJ4g?=
 =?us-ascii?Q?YLl8yu6kix1r55yGlMmhzbVSeOGUCaMKGUz4H0gUNqjUl6uXVV4L6h6hyr7+?=
 =?us-ascii?Q?Vud7YHVkWDqyIzn1tChPGvEuffLBDyjkEdZhrdzXG/d+8ivL9VWOG+tSJMwX?=
 =?us-ascii?Q?XmdlL49ju0P/oxgnFV9ExDPYwVvNyMntuSlGIzyLAvJ0YcyXj/ky7iWAylsR?=
 =?us-ascii?Q?fZ/3UbhRxwDvD5zSu7Z/rRRcKGgA4VNHXYecTjKzQaUinFG/cs0uFD0DIek1?=
 =?us-ascii?Q?EniVupz1FLCLqVfgBjZrxXGvqLXWtOcnEMgjolMv/pymBv9euvaM0PUmfvdw?=
 =?us-ascii?Q?PGwfNNaYOsk+62pz+2akaoqYwTrb3iyTTzdWqSzV0cr2u55T3Cn9Ylls/FQh?=
 =?us-ascii?Q?0v64gLpTQV8YmTP7ouNmK7PMRVCBe3KGUq4RQWWlpWOpRHeIbui98WJl6Mw8?=
 =?us-ascii?Q?HRDbvlqG0xwvdaDPSIoAoCPmiUM3A0QDwtzALlehc+c8ubNMofVZTwp7u627?=
 =?us-ascii?Q?BLyQR+phyfNpSDjoc3avawWecWzDfwtB+sCySKq5Tw+cBmRwv5sIn3lcWZVY?=
 =?us-ascii?Q?JSkW97o1z5Sq9uImtQ88oKiDvBPAyywTtVkop7Ml4AmuIhsAJMyUT2q2fOGY?=
 =?us-ascii?Q?xb5rLaPBPexOK+/hdBvn9QOn4ifljeF1wCaqrmq0V5di9L1Qij75cf/DNMt7?=
 =?us-ascii?Q?mMEWyM6vAr8kGyLElLjVq7NifabMZAjv4llVN70r?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd7e01e-4e60-430d-0b8b-08db4c89459d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:21:06.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqGZ5qCzaI9kcTiHcI82NoFJnExmRWnPOlx6u2T0RVaCPWusFQzqI/CwEvJm7YSsPm/rh/KDVzuFq+BEF2Eeng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8298

This patch moves userspace tests out of do_transfer() into
userspace_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 86 +++++++++----------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2dee1c6ea932..582b763f652b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -723,7 +723,6 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
-	local userspace_pm=0
 
 	:> "$cout"
 	:> "$sout"
@@ -760,11 +759,6 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns1=${addr_nr_ns1:10}
-	fi
-
 	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
@@ -792,9 +786,6 @@ do_transfer()
 			return 1
 		fi
 		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns2=${addr_nr_ns2:10}
 	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -848,7 +839,6 @@ do_transfer()
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
 		local id=10
-		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -856,24 +846,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns1 $addr flags signal
-			else
-				tk=$(grep "type:1," "$evts_ns1" |
-				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
-				sleep 1
-				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				sp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				da=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-				dp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
-							lport $sp rip $da rport $dp token $tk
-			fi
-
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
 			id=$((id + 1))
@@ -918,7 +891,6 @@ do_transfer()
 		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
 		local id=20
-		local tk da dp sp
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -926,21 +898,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns2 $addr flags $flags
-			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
-									rip $da rport $dp token $tk
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns2" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
-									rip $da rport $dp token $tk
-			fi
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
 			id=$((id + 1))
@@ -3138,23 +3096,59 @@ userspace_tests()
 
 	# userspace pm add & remove address
 	if reset_with_events "userspace pm add & remove address"; then
+		local addr="10.0.2.1"
+		local id=10
+		local tk sp da dp
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		wait_mpj $ns1
+		tk=$(grep "type:1," "$evts_ns1" |
+		     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+		ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
+		sp=$(grep "type:10" "$evts_ns1" |
+		     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+		da=$(grep "type:10" "$evts_ns1" |
+		     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		dp=$(grep "type:10" "$evts_ns1" |
+		     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+		ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
+					lport $sp rip $da rport $dp token $tk
+		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
 		kill_events_pids
+		kill_tests_wait
 	fi
 
 	# userspace pm create destroy subflow
 	if reset_with_events "userspace pm create destroy subflow"; then
+		local addr="10.0.3.2"
+		local id=20
+		local tk da dp sp
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		wait_mpj $ns2
+		tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+		da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+		dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+		ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+					rip $da rport $dp token $tk
+		sleep 1
 		chk_join_nr 1 1 1
+		sp=$(grep "type:10" "$evts_ns2" |
+		     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+		ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
+		ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+					rip $da rport $dp token $tk
+		wait_rm_addr $ns2 1
 		chk_rm_nr 1 1
 		kill_events_pids
+		kill_tests_wait
 	fi
 }
 
-- 
2.35.3

