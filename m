Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA23FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlizqK2aZrak4VbQ7oy1D50PGiue/oD/TxLc8rDOLDcj2+A9zD0IGtXnntjJzEbNuD4Ypmip0GnbKoz/LmexeRLoVrWKTlRp1ZzT6r+auXHRC7pv7AkQV3k8wyZxHrdG5FbiOkvcCoZwrXq/84ks+XTV+20Qc1jux4HXSGHcaT8R1hQR3QmxE7cdFKybzwL0t/e6l4m3WQRsp0pyWyw71uPptYCOD4S1rH12aIx65ttxOXjUe7iblRtOP8AHsQ5RxO6+vuFIkZ37KUjP06wDKOjhe6ilFtO7vdOH6kuCeGxUIr+BfzO68y2PYbkCHO+R0xm/XkHZBrKZuAzsdn+h8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAmRX2YE443I2a484pGYv471GMVIA7d/Gu/AgfKiw+M=;
 b=f8e7Op7PZc2tzLc1b8gz7UC/4huifnC0Y/4iU2Ay7B9XlyhIYMDaQXsuLP27rvmracW8oPh0VJdBefefoagCWHuq20HvPsDX6nfO5dg74F1lLU07BcZSBhraPgEViGYUXnHhr3V/yYznmHlhZPbYxuBeNcmyEaAgbfV4x6mZJBVeauYY8zHTot8+la46oX1Qz6q+vcufBMBLfIzpgdxIDD8KeveRV0lFoRV+TbH+bVWngxymcP4d+sk5g5GV5Fp16Aacnh+PSF39NLmcV/EUkg0KOqaKZcxFd0A5mE6NNBjxiFrQcTRvonLexbfOSC6IhKwHzWxViCpYlhqp8KhkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAmRX2YE443I2a484pGYv471GMVIA7d/Gu/AgfKiw+M=;
 b=0jbN5H8QXVJnY9DMmA/vZojIGm5p+AsuwoaAOlmvSbGCu2fVkBeICicr59wMq0pB/8Tv2mpI5dCzFfax7QqOqhiV1Uc42fJZNSt0tWIVEM4n1SucvrGuPwqKgKjkYyCP++17FpzMsg3e8x8LqQrZiN3m+hbbMLNsL8S3DepW863Nf8LY64RoS6mdob9wlsiQ8HFNARakyU4rBWkgT+vJPtaT7CAG6H7gUX24PvlxasGOkxTePGjs4UUYT+/uEChtY/4vzVs0rO8qPbHhdmdNMXzEcKwkgpQABT8FpM3KK1FiFgiBitiM9sURPHEmhsOrZa17BZEHEtQuRD86medL7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 07:45:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:45:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 4/8] selftests: mptcp: userspace pm remove id 0 subflow
Date: Fri, 15 Sep 2023 15:45:14 +0800
Message-Id: <3b0584bc00e11164fa28aba7af517f280d1290f9.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5f4d86-4d71-400b-cefd-08dbb5bfaea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nmyrCu5Nw+BIMu2g3+nZTpFoPKn0AtsqVbEMwmHCgylQf6JyB9FQIvVsCtRLhdLEbha0M/gDnPdKeuI26tTi9VrT+Q3DVNOGj3emcLo7Ne010wIeJiMZEFSLjsLCq3xHqZuI3yjMDOGrJby+cn3+gh4PuAfcQOX+A+hVIZMuNVdySO3zk7sLxmqKU1tbOImggYorNNuQBtJIlpe18muipoP4qvNanBkkcwKGm/fRdwDTwj+wyeXarIZwouxP5HZ85wU+MwD7nVlICmep27bnGsfM0/XR32SwTF0QUy+H1I/ZmmAPN10qDqY8h3NMfi7vY3wmyfz5FaCLyAf3P6OTjdeuiqJ4XnE+jqgq/J6NFcrrbpru7EBBhOWdhVtm9tuCaMNa7LYtmDxXVBVfGVcqv69w2O6Pi2D9X329cYa6UPVtdEAMKyXsvjVE1a9fEZh0MYCM6Odejhk6eAjgLo0SKd7okuMHMrR50c4gieeUMBoPUu+hC8YLxYNLkIDZLPzjQcw3y73H3BUXyEtqzwUVqFstVgm+Ucm33y7wm1nNxIWyguoltmOAqjOQ8S9U7rKFjfV9vPpD1tLgWAPJ0EvE3+5YzCs1MCNwwy+jVkoYFZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6666004)(2616005)(26005)(6506007)(38100700002)(86362001)(478600001)(107886003)(8676002)(66946007)(5660300002)(8936002)(66476007)(44832011)(4326008)(316002)(66556008)(2906002)(6916009)(36756003)(41300700001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5JmCZ+l8x9BcECecYWGtnZj9IcNUTWgKuz+uCJEbgdnllqzIoEtrl+V9BxcJ?=
 =?us-ascii?Q?JaPDzv8joJ+oY3cn1PmbqojDPG17sr5uVoB7XQrm+J+rPOvhtd/a0KoCYI2U?=
 =?us-ascii?Q?5JK7nw9DYpPLsFmS3UHtbr/x2gAzPyX0pZSF51emzW34d6NhN5757TFvP7Gp?=
 =?us-ascii?Q?bJATxfToxMJiP1Bn2MOROWBbofx9YMwWzYpXe70VC+RhQcIMDBvKgqf41Lyn?=
 =?us-ascii?Q?1p9/nJJP5QuCsJ2FzmxtMIHAJrygm9N6IOKgjX9mjx4c8M9k4uljXqatR5mD?=
 =?us-ascii?Q?9SqGy8zWbOCurPbL/LDnObKxKKsLCoWXUWgUsCDnr68egJP+1iQOFBaaCec6?=
 =?us-ascii?Q?eJaFMOp/mXbYnTmsSNqgsBRle8UwNvZB2jomZFX9Bu3C3vGi4xwNRdoI8i9R?=
 =?us-ascii?Q?iV1Thk9kbLgh26LE+2q1Rj35iRnJJyd/hx9VwhFfc4UJElSbJVLHQVYA7ucp?=
 =?us-ascii?Q?qAmkMLI4FHrC6pZCtN/nMDeyTjFwOyjhwUoLj+bUEK1bNeNvXS7mawsz/YzC?=
 =?us-ascii?Q?syxDF3/C1sdPfwRyLO12mLX/S9fX/nKTNgtuolgoAGzuE3c9NFFkvqrFb4Wa?=
 =?us-ascii?Q?ZK4+zJLYWhIL3gLJJ03wVZJ0JWMBL6c3UxA7fRYWYONzfQXFH9DBhL0J0cc6?=
 =?us-ascii?Q?+sEVEuxNokHo9vMwRzKCZzwEl2NP9D/jUBH3oGRJ9GWpuQ+o4IlAMegCDV7Y?=
 =?us-ascii?Q?EcTRSVXrcxKegqWdyzRP7JG0EAh2ZpzRRF1bfpb9phERwqPqj4XKMFUIL6d8?=
 =?us-ascii?Q?ivxx2nC4iL3CwIVLr5R+p0MU0kjhS2fmQtVK9eCclFH9g6DFKBiw9TwaHqqs?=
 =?us-ascii?Q?hIQf5ySnxigQtvv9Sivs2VdEIjsnBhbA3M/x6KF+WDF5ND/NOSrCx72pwDpl?=
 =?us-ascii?Q?u7AMzNIqu20ocJyX87iXVM1dviOasHAMK+j6JMx0OM1YvzdaKTJBe7+7dIRx?=
 =?us-ascii?Q?BKd1NsVWGuPNSTD0t5dlX/B7M9k5Bf/XAlAQKWdnpgzU+kRKGUHQiOyYkAig?=
 =?us-ascii?Q?cQ7FADbYB7IRBCWsW9zVcmjgVjJQov2OzgfjV7Z08dSLFMDOU8onYBoakG9Q?=
 =?us-ascii?Q?V04EJEmeGO2cKj+HyFVGI9zN78PonmFLLqJ5XUqqRKfmDkky7TXpbki8dq38?=
 =?us-ascii?Q?qNw4KoPJy2sofViUQud3LCpcXWfl3W/ifgtxZGcl3r6pgyP24x++XFXPaAls?=
 =?us-ascii?Q?xJSY/CsnNM+fDJ189Mcc28w3phXMV0p+r0lX82ZjRdl1GDS3frDk9h0r06ZW?=
 =?us-ascii?Q?ya5F8I4t9HJiiKVEShWcZIY4i2qmCEsGt6/JU7LGopfcxZPGXDruUcdebVua?=
 =?us-ascii?Q?4Gtl8XtSDQwdAgH2E4iOEUxdDSuFX8rqxENQ5rXS0zh75pXHiJ2KwqWcWyfO?=
 =?us-ascii?Q?0e+Lg1YfTTiQ4ff8jvXPQK29W81TyyvBMaGmSydRBRXfmbcM60ZbulZ9oUJd?=
 =?us-ascii?Q?L9BK+q4BYIweeAwPHNyZq94RdSZ9q2Mr58JfHpj+aoaz/QOgzHi50B85KBWZ?=
 =?us-ascii?Q?6v14+KrBmg0Kb34Tx/O6AWh02VE85ZxD9RUG5/nHxNgZFOVEv88K5LFoeXPY?=
 =?us-ascii?Q?3pDxjOK7lDvYMj7EAShOWYyQAoKLIHDpNLPi5gXgV6ywSmkJtZH9MewKc/a9?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5f4d86-4d71-400b-cefd-08dbb5bfaea5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:45:08.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CBSpLruRFYpTm7zGkeAQmRun3jcGUYsf2PtWAeos2Zhd2ypyTF/b1JB1SKEwqjEv8ZYVnn01GgEgDVaCkSJ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

Add a new helper chk_subflows_total(), in it use the newly added counter
mptcpi_subflows_total to get the "correct" amount of subflows, including
the initial one. To be compatible with old 'ss' version without this
counter, get the total subflows using this 'ss' command:

        ss -ti | grep -c tcp-ulp-mptcp.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2ebe1692edeb..662800437a38 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1860,7 +1860,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:14}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
@@ -1881,6 +1881,37 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_subflows_total()
+{
+	local cnt1
+	local cnt2
+	local info="subflows_total"
+
+	if [ $(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info) ]; then
+		chk_mptcp_info $info $1 $info $2
+		return
+	fi
+
+	print_check "$info $1:$2"
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
 chk_link_usage()
 {
 	local ns=$1
@@ -3430,6 +3461,28 @@ userspace_tests()
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

