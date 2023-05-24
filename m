Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31EFBE7A
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBp+6aRaay42+Ncz6+hHGONtqJEPNL47yH1rltEVxDEkPKZ3V72DP1qOlwA905f+2+wrQ0oeC79xzJFjFV0uFBIWl0EZzl9h1Xum9+SNMAxONTaS8/f4xWpZCM0/K6liOlloLEzxPyADgT0RWcSezC09n+p3AdvVsf+Y7+TPWk/6ypLgzxTf6YMCl6Oo0DsU4+d8/wTcFlsFH1pjIAN4Xdblegr9L+YLx/U/vSwc/Lp9A7+BLe2buNaQwoEXlUetWff7rkdJF8Bz1L/GN2eLiyLaoJCqdx1P6S4wXDxim7t4ewq8tFVVNTNF7I5Mujmsc/8F89AME1ABPq1JAYO7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naWb5yZU+WggAwRj1faTjPn75Tc79Vm7WklZ2xBjhs0=;
 b=YxMUUfCrmjNqCW8CMl3syMlV+6gzY/9sosHRcczFMTxa0PqSaKbxVzDoBvtrnWKLankPypUjwIdyK9ipymo5fo8JnicNvpViOVq2ioapv66/oINMxHZ/nKZjM9ORcpi6ckiLpBwIt9p0pON4FQAcuXSQ+WBkJHpG7CcrV+LVGH4NSXsABZgHMDpnlqHctCIAl2VfZRsdJm6bpjZnEaYRhKAmh5WcS19lCFpzCTVc9/LpvVtfoYNxKJNmfSUZ6SUZWAMKoQYZqTaye2q9P0bOGU4qdwYv0ULX4NORn3vUY6xinx3oLGdiD1737qQFdA2rLfOr19SDyAl9NdvH4B8EBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naWb5yZU+WggAwRj1faTjPn75Tc79Vm7WklZ2xBjhs0=;
 b=SbweHPx3tKqpBr3isL39Uj+VPiWJgQs3O2ijXmtyI8u7fMZs2LRWcZR9CDmp2HHbLxxY2W4j+yZvECMl5N+c5Q2FltYTFQ6BND70UG0QBKiFD6LQNNj6nWp0lUp0X/OQdiJwcolLNxfucMf/t2oOaDLWXRV7Rpq2x299qg+hRpBWJRXAyjn9QvvgwgZuyih0xw/aaFIFHu6vaUwcWcluPpMX2i2tqtqAK7ejJJuoyio6GklUKuZX3isW4+zdcT/D+iPBn5D3Z6fFNDfKGmWYRbH3oVpq8EO9EwtA461xd1dLll6BnMM4bnZgrI1NfD1vVPkh4XJFhlGi9jZobqms4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 08:03:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:03:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 4/5] selftests: mptcp: update userspace pm subflow tests
Date: Wed, 24 May 2023 16:02:47 +0800
Message-Id: <5fc534f21c576df3a1e71efa1902a3e29f21f3a3.1684915182.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684915182.git.geliang.tang@suse.com>
References: <cover.1684915182.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:405::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 70059285-f0eb-472e-4722-08db5c2d62a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HvN5HR9mGcbOAAHuUCjke0sqQLzqz/Jpicic+amtriKMsMaHCT+uHPLuIfDmg4ABa3kTLQ/qNHK/MsW+1yLARpsuC+eFTGkrvQHZME7bsSQ/WmtNY0RcKuEbe5oSyb+V2tw/YLrmSfcvJJeuiIWvwj1GPiyI5QiZNOpND/huoNPKoX3RPRQPxWrSRWhxu/Lm4omtXDMSsQEoTDKNPsl+2d+viHhmmjrnfHIBGy9YtJfX8PguPCb0haLrnwSB3Rzo+osbqSN9FxYNg+keO1DNJigVKwdAUDoSxn5k6ofL/mkKNS5XENtP2kKPr6+w6CAQrhC0RgWARAcCAmtZdhky/0IahHXUnvkk4wCta4bTewkqWSeEx2ws2OEO7J8o2P98iFjp0kDBIQ+dbIVzaVizNQfaQUEj7PzYSzf7pV909zcUVNgsTDgFy0BhEc7pkAtvJVkw205kS6/hfkonsHLVbIV8G4dSVDIMXflB36U8jpaI6Geb0/NIGFijDVtxmKxeckWvET/D4MNWqORcsI4mgpSU37MrRU7vkO+OWs8zQhQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(2906002)(15650500001)(44832011)(5660300002)(8676002)(8936002)(83380400001)(66556008)(66476007)(66946007)(41300700001)(4326008)(6916009)(36756003)(316002)(966005)(478600001)(6486002)(26005)(2616005)(86362001)(107886003)(186003)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fyqI3XWj75jcz/WFuJErws90d1MzVLzmj+lZMrqvd+kAJb8Afulu1rt0GvDZ?=
 =?us-ascii?Q?5qEZVEOoOlS9EOEnEq6GIxnPndFfgwt3moikvmHNU04yVQJXf6O+yl2ejubm?=
 =?us-ascii?Q?Cw+tRMPmlhZRqcIaPJZy4MwDKmlG1+F4zUFxby/Zj5lo7dIfbDK+VKr0G206?=
 =?us-ascii?Q?uq9TO0kKG3k56Cs6Ek2321q1HYOIE7z3FxKL1qsT5bkxxD/QdGi9tSFEPI2c?=
 =?us-ascii?Q?scjyzJXhdmHAB93qXkmDZisnMO88I2SHs+y7Nn0FN0f28ldjFA12xGz0TYix?=
 =?us-ascii?Q?cpTyJltzlHRXd38OH1UmmnxPT++9CDvx5d9B8nNRQcgjFoa45DFL4ghh5Neq?=
 =?us-ascii?Q?o7kG0whFeoltCOkIzUEUVSj7hA+nK85cf9AOqDZmmWiVZb7/W1colqhOcgzG?=
 =?us-ascii?Q?3Px2X2ucv+5VwByMAMcuniqpfeSGDDyrt/ZIWWhxkHn+PHxSnlWcSXidq/k0?=
 =?us-ascii?Q?OFY924BX3Yh1FBjdM3OUIpUSFJ4+o1skuCsw2lW5iEYio+bYSf2Lqpkh8iZm?=
 =?us-ascii?Q?/aUDzhRb2StDb0Mf12UXvsZBh8PtzOemmKdjMxvOcuuDABFTWjpfWdfIjqk2?=
 =?us-ascii?Q?JXTPqan5HOoBmGKLMaB3oL3XF4oMquwe9dcTkLIco1WQFWVstfya6PmNsq1t?=
 =?us-ascii?Q?f2Tfskt7R2JoE7Heuxmj5vgro6it8H6S+MhHQ78vBcAwkjI8WkWLW+urizdK?=
 =?us-ascii?Q?thStiD8RpqUrfCOueCOeYqudss7WPhBRk/517v0z0YIz5ZTV4N3RMkcJxFC8?=
 =?us-ascii?Q?oAWcDcFbYU2gqwcWHBjxQvOH57oWE8gFtfXh5hwd87MA7EdnpAL1xbIzyjWt?=
 =?us-ascii?Q?10ruzOUO8eE6/5qgBe0lkoQeFrbujASQXwGRfq6aLTtwHZ1c6vCwPoHPJ9T1?=
 =?us-ascii?Q?/tWcXkRzNMXfDBxBWXUCWY/q37BiACVR+EFvDdZR0JLo3nTV1ugsWrTeO2xB?=
 =?us-ascii?Q?1NGZT5VJLh10nwGU6dLpT5RdLGNUwVuDFUqXiyvozuKNj4KDkbC1qY/vVJSQ?=
 =?us-ascii?Q?lEApfrQk365H8tC6nJ4sr3ibvWZQXufnULd8titv/4/fm/bWZHM/XNR4ghCC?=
 =?us-ascii?Q?UY7bR1n/OmsdC1mGbDptb2j3SxajQrag+CPfTEl2J3uTGkZXd85V8sRCFbov?=
 =?us-ascii?Q?FePnI6KiREbXu0e4zBJ8NV5cAS/sUu1XaCApjzHyvTceL9wxJwZt8PZ+PvWw?=
 =?us-ascii?Q?nhyiosZUNfTCYvy0rFdVzDxbciLWPMSs8Jb5qN68QzaZteQ66Eycq0iz7DAY?=
 =?us-ascii?Q?mdg+n9KRWoOuqSBpJREzE+N7BD3/rA+yRR4pUnVEnxv7CLaIl7Z9Nt+LZ33U?=
 =?us-ascii?Q?tDtxpclksqkJgo+YzRaJ/X57iHEkpXuwIhl7i4Vi7+GNSMNfA+JpD9PvpfJ+?=
 =?us-ascii?Q?UpgALoe+4Bj+9Uy3jnIuBPhIGi1NyJq4daGqU371UQgD+R4nMiaKzMfY6nTa?=
 =?us-ascii?Q?BlR/7xT3DVxkyj5GrdA5kA4GQFn9tAWXZW1hxiA0tgHeDGmzbAiCkq847K+o?=
 =?us-ascii?Q?aGm5F8cGVIgRpylj844f8xG5DSUuGzFBuQIhgsrbqi8i3tipu0oJdN4+b7PY?=
 =?us-ascii?Q?Xu4JRO1tfokQs5LWqDQHTXo5htatL5MjPuAXBhxk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70059285-f0eb-472e-4722-08db5c2d62a0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:03:40.2290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60amkpqAOefpiZt+D0pfpl/YHPnHfBj/nxcjEDxNEk64JtSoT8j9Z+VdkkjB5nL+yN1PFkTqC5V5//re+L6tXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

To align with what is done by the in-kernel PM, update userspace pm
subflow selftests, by sending the a remove_addrs command together
before the remove_subflows command. This will get a RM_ADDR in
chk_rm_nr().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a42745e60976..a0c502d617e5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -937,6 +937,7 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -3210,7 +3211,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
-- 
2.35.3

