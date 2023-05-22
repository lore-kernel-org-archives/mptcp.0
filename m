Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961513ACE
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4V8Hr9F0jeGjp2wjD0LZlzUsei49Zos3sDyGa2ytXt6Xi6q+58To6vz0HeopeQ/0KnZX1dLhhsviaE210oRxS8JrpWgtXhGD6k8ye9/Xj/QMsjc3/MVx/4NSgKxTakzHOCA+c6peU4/AHYVyYhKIZnnYa9XXluvLtijXAw7pgSFtGPtcBwfIzJPUOveipilVR1qZZ1eVirL5d8cBLoUlcFexuw3Tb/HwHP0HJq8aewkMBcVM5xa2Uw9dQc76VAmZcLE3TYnDcgP3YPIk3E/Ab3rhGjbdAd+6z3/HYs3D892NibW1DEsLKfCwZcIN79JipcycZl19x2NCAzYGn57HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVhOtI8e4Qy2DgGPK5M7nq59HK5JWdxnqckIQHMQg1c=;
 b=jmUaTRpmr2kzDiOjp+SSKjJ2LrDJGL5IzUxMLC2mk1xM8nb9WeHLcy65IF+BVQPSFnBu8wCek6cKN2950HUAPOo3QNlz43RKWaNU9srg0J/WdPFuNQhsUjyiNKyJ6sSv4pdEsBJEkova6xJBhctMvSRwdgTMs+FBmw81VEKIz0cSgfBobowFiVSYTZ0YHm3eF7xE2ooRE0NOTSmAdxmgB9OHxy9tMbdGI4Ys2OjJu9/pt7ePPtprz6LeC8umPZsdVeVRdwnKOClnmPBqyUwRX122YIuFST1+uWnxxEvmJIb2EYcn3ozt5e4/KJXp4Gwu5yB1hkZ066JuJ0ds5lh5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVhOtI8e4Qy2DgGPK5M7nq59HK5JWdxnqckIQHMQg1c=;
 b=sctUn3AP/eKxsazs9bQMAaFEmm1sCSSPTFrhPSWAZjdpwMpqeZvh1UQsxS9//8zfoLwrG1AJxbBW9LR2c6fIA0uGJUWfR2sVxPeEXIuEJwRcesAvML1VWytcmYfP8ClPl5APfNPyJBSDYS5oOlIaKSSOtRKJmU4++jmVSmXzBUoOtNinNHKi+6RME5qDG3gJUnqXcR1jASi0i4QcTscPq8tf6C/yq4mUYapEq4kGBRIH6nk36d37amFkZhTbogef+/ovGnjqjdULmbjFF9vMSrXLCB4NK4OED0BqJiPLncTvMxs3K6inKUJWL8g6Ah2KJjAObszw4CL2u+l1NuU3GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:13:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6411.019; Mon, 22 May 2023
 13:13:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 5/5] selftests: mptcp: update userspace pm subflow tests
Date: Mon, 22 May 2023 21:12:02 +0800
Message-Id: <844d9f8c87bc733488eba77a4a77e7040e87d8ed.1684760588.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684760588.git.geliang.tang@suse.com>
References: <cover.1684760588.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: cde4f1ba-a352-4c6f-3d17-08db5ac64676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6LZU4XtJ0ka2zUR6FdUQGrp0mbnNcutas37715JhgfzWE0S7X71FahAdi5gY/THNlDD+dUwf35rsjxWuHDjqZqL4L9vij8S+dfCWX8RxE4tcSnHp9LxjmoRZhFfbidLuhyT3YQ6OjHU2gBaSXwgSnEk3Hm+UdNkZ3DGpD8wZSMPpH1NC9t15xEJWvy36R6WaBrjgZa/BooOL8+IJxoJfGONe14+M4vcWLqKw7pcVjxXtPh0r8o18aB08RT/S0+hJQOB5qfjmmpKwbvJIcCY/QJLDm01HOMegO6d2vYD9/ASOmKMRPIeG1K5ANbSg277SWZkLOYwbNSd75aS+MvDHTfIDn4lVQvXcFVR8Mwl+4ny8Vz7vqKf9AqJ+Vto/BkmQ8LdNoPUQrko89oufdTSxbAD1gwAFJ3H5RvMdvWMj+7BZaandgc0B3R3Ql64KukvlZuiSXTQsQF5WOl9yzE2juTgMt8nOnZY2yp648v1vij6dbdzR5R2E4DkZDMLK/6v51VgC4+b6Ldi8AGMpAWEdUGzxt3e+z6SvMd8TYuj21ko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(2906002)(15650500001)(5660300002)(83380400001)(44832011)(8676002)(8936002)(41300700001)(66946007)(66476007)(4326008)(66556008)(6916009)(316002)(36756003)(6486002)(478600001)(966005)(2616005)(6512007)(6506007)(26005)(86362001)(186003)(107886003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQb17MTlDTjs6YGfBG1EYTJtyj+co89X2nZKXYItRNJ6PkXOiNssXD/evRy8?=
 =?us-ascii?Q?LpC570FYIAva7intlN6XpJSgjThdt+4DQwLVE96m/RD1vS2t88Gp/xPrK75b?=
 =?us-ascii?Q?L7iHqzhofdkP9pzH+wSe4wIh8/0EjmZ/TpdCEWLvl2XqIjeMEkgJvzaHn197?=
 =?us-ascii?Q?H5VGTXdmrQGfTTxqWSNHGzwh5dW6y9HD3wOE+GgSDVsnkL9l6AjQYrDRq72N?=
 =?us-ascii?Q?U1vDRL5NlIBrA+bcBwWWmYFLqM97owG9FS2W7yfER7ym8zRUxgzFfAUG9Ivs?=
 =?us-ascii?Q?ZtVp9Lhh98tBEDxMmBJn83OKk0Kc3qVlYalLLkA+5DfwPKSG6W5Ckf7Vu/Uw?=
 =?us-ascii?Q?w+VgzDWtrw/b/uoH/d+zgfsMG28eu5wKP94o+tnYcQPbXi4MjCcUyFqVNiPA?=
 =?us-ascii?Q?KdxZMn9LK3Q96+c/kLklLoq75/DJgmWVm9owxTWLQgvucHHddrM1gFc9ihV/?=
 =?us-ascii?Q?cWVnG4izYyVleYbYSZgG8w/zaNtKqQ1grnZYceTLaPlI20uztpzVYR4CUoiK?=
 =?us-ascii?Q?JHw4lPPmqe7qC51AExOIUBEAUc1Rdsr0ctUATKYmJB90CYDuDx3j/Qm432IW?=
 =?us-ascii?Q?Ya/Q0/f2FvDA7+pWbaZVQC6Zs+1zaAk7Wwtlda7tjfM+ZjHp+KgxyjvUh3to?=
 =?us-ascii?Q?F1JoCm6czAaSAzK8GCQEHJJDLpx99pDIUnRFoaRv1afbVjUCOgN8ni9G//tj?=
 =?us-ascii?Q?xyPmN83t21jAc959lSy14z0AOuOktLVuN1qqp64qFnu9KA52GU6jpa5rTfyY?=
 =?us-ascii?Q?6OX9681/glcG+ze2O8o/8wNdRvBhxzt93Ct9/w4xewCrq864jucgloSD6sJF?=
 =?us-ascii?Q?yA24S9mn74mkTyI7kRQDg85Pk7Ox1Zaks7+vRr6aWR21WR3x9ooeyOK10lC9?=
 =?us-ascii?Q?95RO70BfhGgGT+1N6yj+9KHGIdgTduor4Iv3xD75NANCpOfbr/WU/4MaLLUw?=
 =?us-ascii?Q?AGWrcaKFHslz9v49lld9ydMXA1vUx0x0l7C8mxL+NPjDQizFVY3yNvz7AKA5?=
 =?us-ascii?Q?mAbnyFH9OeTYcy3Na1O84Udy9IEKOji2nBDEFH2vEiXHYOrpx3x1ruPS1oSy?=
 =?us-ascii?Q?xYOnbIKDVileheV9nZw4ETTWpeUtj8i5Qtlm7vQUaoD6DOyziS1VL4H+4+Vc?=
 =?us-ascii?Q?GtTjZd+9aJpHXZ+k8UthfTcZPJxmZHK4kKBQQOOvOIeoFSakHBUxFASjB8zP?=
 =?us-ascii?Q?cBhaObC686CZyTjOOQbWVao1o49h5ffTgm3IImMNpCyIj8d6e1cwJ6wB2iGf?=
 =?us-ascii?Q?ZC3lz5oz7g3RZGJzsGZnZ5JBD+S8MNeIW+NKYehs6c2QZKaoilOobLXnzCrT?=
 =?us-ascii?Q?NqbdePabJ2aARgJJg0yFmJjq8e7VeSWEBU8/EShAhwXQcPkrCeQrcS+N68ME?=
 =?us-ascii?Q?hATDqgY6uPSmQxxyVBMzq7+Pq02gboPvGs1fzshIoqnEacmllpfQtBhVOoVs?=
 =?us-ascii?Q?LzR/7jRKuYuDs5CeT/l61mYjUgG/bU3zkQWvTiVBNYVzrsttR7hX+Z6jNUOP?=
 =?us-ascii?Q?082L7IuqN0KTj1zO1RgVN0UWUyDfAWU3Sj+TRcDOsBqlkMayfJZOeBC+mJce?=
 =?us-ascii?Q?/MDiR5FvTrihueJ5Iqj7Fk9FPT6m1DeT4wNXqkT3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde4f1ba-a352-4c6f-3d17-08db5ac64676
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:13:03.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy5hMZkvKRof2CH0g5hHUeJIOxd0QcOCqtaovTl0Xn12MTkOZeVGj35RkY+FM1FLCO8KKaQBjDaRM7FHiE6Ogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845

To align with what is done by the in-kernel PM, update userspace pm
subflow selftests in mptcp_join.sh and userspace_pm.sh, by sending
the a remove_addrs command together after the remove_subflows command.
This will get a RM_ADDR in chk_rm_nr().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 3 ++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a42745e60976..46c2095d6e3a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -939,6 +939,7 @@ do_transfer()
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
@@ -3210,7 +3211,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b1eb7bce599d..02465ffa075f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -621,6 +621,7 @@ test_subflows()
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server6_token" > /dev/null 2>&1
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
@@ -660,6 +661,7 @@ test_subflows()
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token" > /dev/null 2>&1
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token" > /dev/null 2>&1
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
@@ -737,6 +739,7 @@ test_subflows()
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token" > /dev/null 2>&1
 	sleep 0.5
 	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
-- 
2.35.3

