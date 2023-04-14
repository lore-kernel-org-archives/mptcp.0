Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A855818
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOFBf4YLlqO7hW/2zdyS/pLIpg2kgwaeIdNJ6DLYx7KlzwQNIwYmbOs2fqwSfuKkuW4Ruazsc24E/3XidpDD9RYuOx4xBkmag+waZe2AYs9P/9dnXIBjrkZNJR2OsbkSfhzSfFWS5E273GIlTPdq8sNh2XA5C2x2WNDIEAWaGKsoKp+UvnfH4MaQ1EyGY/zxSTqvoZtpAB0/wsiJPPEbu8vVkRBj1XX9+IvbLOtgON/8Vs8GOyUMHpJI0Uq5RlmXPZ0IXcBMhqVRi7nUr6d60Wf9hH8GLyzwAc22GH91v4Fuy0xFvt7iZuKVmOkNdm9ZV+/LADQUxY2QHSXoCmdeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4SJ00ZZTM1ldwM1Wj0Az7bgj+IGTUWcCsZq5BsediA=;
 b=eb6/0+5Gdo1LT0fjKiiObpmDICvhG0yZfW5UQKCmzrgRxD7b+CuCkzZ/6R7cSVNMwJYGayhGF9yvwHsROYm9FIiv0a01hu9+sYrEamtZ8PdpbpIqRVAUW8v2ct4ZPUaEd0d6mHpdhJCLUTkM+KpLRKtx8E5ugik0Wb0HdYLNXcnKyawH1AM3nRMTV5gLiQnNqGLcYnOmlObyZ53I0eao7HAgPFSOMECNNgyy7QgXr0EfE8e3QnDl4wgQlktNrJovR9/m+U34ERrRoivYc06Ay8eZqWDXJ3A/j8ddyVj7pvoQtRRjCgSHrPSjVMPY41z5kh5tVn930WMcB5wWmn2KUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4SJ00ZZTM1ldwM1Wj0Az7bgj+IGTUWcCsZq5BsediA=;
 b=k+GNPceKoAtvbUs/44V3PyeeSRMrCp/97xkTXU/MjXQKwj3EwfT30m5PZk9qy5HC9yMw99q3Hoo8zXnR60Pvuetarw1WDRP/W3tW6FH53XrfF4mLcpVWMWCYBi1+zidqEDCyHKl6aUK2IU/3U8Y93SFS8aFBOUtEvVTdrIJwJdD6aCkCWXcy0xCvp8Oa9CP+uGK34B8oaRUJiSgHdd451EAzA5bnLmK+OBSGJC1IiXo6QbYFsOWZgjijxUisBcGLMLDFdj6YmeJUARxwRdFK3HFDdMh1NOF0ZK6m57h1HHaW/0rKW8YM7gIt+uZHNINqfqKHCW5ZoFjSVtEgSJ2cIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 09:12:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:12:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 7/7] selftests: mptcp: check userspace mptcp_info
Date: Fri, 14 Apr 2023 17:11:10 +0800
Message-Id: <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681463340.git.geliang.tang@suse.com>
References: <cover.1681463340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fb2d9f-144f-4bd6-8fa7-08db3cc8555d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JKVenQ1rp3hxvIclmB5NFth/jThnLmu61TshupNlimKg07+nqc0H+D7nIxGtnk09Rj5mbYUBRLN44f1AGZFsc3s4jsy1H+G0ImFsEzFi+CPCKH2JVAzhwsYLPnD8ij7hiIdDEFMjLlZYBkDhQt4Te0P1+rojCBrObQPZ77fEL0WGgnUoUb9fHcA7u6GFC74CnIMISd2SOLB3NaEX4sQosnZG9yXiCC5S8H+QMR0Ej7iijZpGYTT3wchSd3oLtJvuRVrx+xVo5q0li4Y7ekcaqGn6QQxTUA3Wt1GiH+f81i3k4VXUUVESZG1lqqDzxUse3s7kChmrgUlKlS3KnS7wStjyGh0rOgG1Y5dwLzKVVBAPD3rHS/wdPJFPTfB7PCrVB6W3Toq0vTdxiIL3s59xAQND0ivtpgxMN8G0Hwnik20tkWy2zwNnwwZT3nwfgdYwYIls4UK3q+OtfAoYD5keCWLUs2mLCZgjR7FQ4qlcwQ61skb0SEDtTJXgL48lLpKv+3pMXdfi20hO6RiDqed2fwQyEGzbPusMo6s/UPf3eGAy1496EP6ayOI+jc7EUit5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(478600001)(6512007)(83380400001)(36756003)(2616005)(86362001)(38100700002)(2906002)(316002)(5660300002)(44832011)(26005)(186003)(6506007)(66476007)(6916009)(66946007)(4326008)(6486002)(66556008)(8936002)(41300700001)(8676002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BAmr+/6yzdCDtRHUkKcVqLysWeDVQ0nOUT1KFbp1cZx17XVKjCSIAmVe83Yk?=
 =?us-ascii?Q?F9mRlQRhjlDjJEO6D0y9FoAae+Nsqaz9Nia8K3P+qPHwzAyhF9WxP0bHJIvh?=
 =?us-ascii?Q?IoepFzyCZbTZeu526I25HsheeYKIlqVqUb2tAvcbeULvsEQ6g6f6cKcDE4ti?=
 =?us-ascii?Q?WIs+QX7yGYSo5Ve1qNIfb8p2hWCIgzEgBN+z+SRz6bFv4uySwkGNVQM3UFNZ?=
 =?us-ascii?Q?k301B2aoc2ttyqvsWEQlL7twNNkhqQOeB05FX6IGKypbuoWGSEDC57SYD821?=
 =?us-ascii?Q?nyJxeEgxSG4+u/Ey7nW7efw2LnjqRxj9cHseWux3x5+0FiDofKgr02dUCc16?=
 =?us-ascii?Q?Krm5tyujy0t81JSRSBZP3GGI6FdwW3Ow/br0kddX2Oy3M84U4BkUH9GfDf9L?=
 =?us-ascii?Q?6sdTd6axYm2zfDeKb6ElQ0UksWAL8Jgm+v+/c7AIbwtLv1o3/mcEbLEqI/pU?=
 =?us-ascii?Q?kp+7hZpSecd75Mglz5tftN2pCw0N7MRalUl8xyxXTWOXoeoGQykowxOM54g0?=
 =?us-ascii?Q?eGrnTfxFfzGf9B/gC5tESliLqh2NszRhsmWa/AgnsHsf4UErtgruC3jRH3+e?=
 =?us-ascii?Q?LLp1aiGx1n24QQe2kDa/mai7vTIFxoD+8g+K/cvJRsrvIZT0Lsdig9de1Kln?=
 =?us-ascii?Q?NeOYNFvwmOQO3L5a9UyKooqiY5QzCGeBjwYVHyeSG1DlUIxLOIPmHDYDWCQ5?=
 =?us-ascii?Q?+0h4SuI8QThbG2sP85SE4ZjpqX80eo8DpzWZKOKt7UFFjkIHZrRckXPacwEI?=
 =?us-ascii?Q?xNTEFYJgcNUFUBFV66agngfcksoKRzv1SzTBq81AGYZqNiDg8cHPF1efv+ip?=
 =?us-ascii?Q?K93ZAWvoYlgGhdU4U86rZICgF1+N+egq1wCmnOrmHwIRM6t4wg34blKxHH8i?=
 =?us-ascii?Q?NnXwISJKoNqurvhk0K31VDbIz5fHnpnNrXgfNR1USMMpk07G1pAoxBNo3dwo?=
 =?us-ascii?Q?D8L4dRVUfvl+PRGLOqzO24KWFKtfkvcHpW3Aj7pERqSK3KMxov4q4BNcfJWv?=
 =?us-ascii?Q?K7vV3mUW6zatjEkwgW+eEp949+wHJKSTLhvLy6QGpek9JRpT0fi2J1GYzn89?=
 =?us-ascii?Q?sattWyozoRawO7AAPhIq7/G/uj8wOQwolZNeSJIwOe+hP3r4pUmA6k8tyEOB?=
 =?us-ascii?Q?cqjuUrl/ajgtv+WVUqt/kK+BXBh9/eoirFo0T5+EJ7Dz3WoQ6vqLDns7RcyD?=
 =?us-ascii?Q?ZytZ6w/QisHKyp4eW3vEnkM9Px3M6xMAML1v9z5VhQJnpwkcdvjrWwb1t1ne?=
 =?us-ascii?Q?QCGhrn3aXKOIOxd2NlRkbQ9SxXFgNMDnneoA3OJw6Vzf4H8LkXoL7FNBd3ow?=
 =?us-ascii?Q?A2G/im19H9YOXdtlxbEEGl+62SwX54cpiDu8295zBGJXaGPWrgst0T05imPi?=
 =?us-ascii?Q?ADoyqSvYnbbHthwW8qGK95vgRXwqPedmFMonu3qidAURi11fQYtWO05abLGV?=
 =?us-ascii?Q?by566Tw4KlDKMAKVWcL7NprfwDBrNv0l61Rwn8Hg4/pBkmQUiTfqPAV1/o5p?=
 =?us-ascii?Q?FPYn4m83ad4aOYR7RUhkgPxskzmO8Qsf5abgUSUjTlCEMnDkEQRdBqTW/t8Q?=
 =?us-ascii?Q?VzyDaKCziaX6mfdtwYmrnQVthmHR0X0zUXg6Hp/x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fb2d9f-144f-4bd6-8fa7-08db3cc8555d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:12:13.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz94S5HVaq7k6MxODbK4mbjm+v4eb2g8jYcFtuD1ZAlZ50sqjNXFUEH+GBUJ+Dc9u4RvhBjUTFcOdxT/rs43Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

This patch invokes chk_mptcp_info() to check mptcp_info of userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..bc47b99f47e5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -842,8 +842,20 @@ do_transfer()
 				tk=$(grep "type:1," "$evts_ns1" |
 				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
+				chk_mptcp_info subflows_1
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				addr="::ffff:$addr"
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
+									rip $da rport $dp token $tk
+				sleep 1
+				chk_mptcp_info subflows_0
 			fi
 
 			counter=$((counter + 1))
@@ -906,11 +918,15 @@ do_transfer()
 				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
 									rip $da rport $dp token $tk
+				chk_mptcp_info subflows_1
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
+				sleep 1
+				chk_mptcp_info subflows_0
 			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
@@ -3123,7 +3139,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
@@ -3148,6 +3164,10 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+
+		chk_mptcp_info subflows_1
+		pm_nl_del_endpoint $ns2 1 10.0.2.2
+		chk_mptcp_info subflows_0
 		kill_tests_wait
 	fi
 
-- 
2.35.3

