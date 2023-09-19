Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322C31A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnk8BAHACqSXxF+FV0Cw6HppbJ2+atAv6vPS+ZusNyVMoMh+V+DNShbGJPheZgQmh2rw5RCI/WnIgPPFVT6tMO1/uXbP0Ri94MIihJf7SNYk/DhVpnqrWCdbyPyVdS43AbEKPnu96dMU3Zk/H/jFjbIfDnNNQ/yu6g5gsDphHrbBZwvhFqcB1dX0ri4RavSJJE5c7eUVmIf0hCW5WPMLsbLkWN1TRqkzZe/Se6T9WBjVxMZm8cau1ogccYEWzNxRuJ0+FdDd3x3c98L1PNnjP+3V3XomYAbq2w2yOm69ZEoxseJYhRcvI8KIWZAd/KCgtR1XOUz9/MKDG4iumtFblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NapUf4qgKI0NRdY//931ACRYU56EbV92THDEYGdGTH8=;
 b=b1/j1FpfchVs4hQNt4mMx2t/GRXoecR05iXRruPjoaML7vzJ53/Qw2Ua9g9zY2Po6ymDZcNbo5IlL7pdYCOpAbkc17F5WpAJpPW277qlOVEpvlW+XirjIh6uqu4I8XhX6ZG4u6qOJgfF55Khv8UKSxmJUkbh98WJJjRo7Uu7WjHfgDgnBVRrllXDQTt5SKe07fHC+kDcICSE0OkvvQXgxtlEGptR5+wRgBPivMuA6bjQJsqjMwXh6YJp02HEUesSUinl3Byjaw0OYJwSHChSY7ke5gHksc4Lb0pBVSTTIKMnxB8fz/NnIiLsT0wCBVJCGm5SrH4DLO4vufb8EFhs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NapUf4qgKI0NRdY//931ACRYU56EbV92THDEYGdGTH8=;
 b=YpA0KZ+kdYLkbs42No+Hkmye3M/Vwu8IWNY4COU5GIKkLiv0h6jUtGH7hhyqW+B69X/zM7+x1dypOiKdGHg6FSIcjgcYPvzPsBtIqhf1G+Nvh5pMs6ShivchZ69azFElmPeZDlErwVSrvSf/oQlvlql2GxOCuq2h0lIgbWbEnTTE8LNooRURGZ2zGXZVC67d8cSzDZLX958LtObkByZAlwK9k33Cr1CzBmyLxWO+Te5gl/jlYaPYXYa9OBOk4GwHB19HpFrB4qrqp3ZrAqXSxbeKfONy83qi8H5O35tH28f8GSHqMGkqeDNS/iuLOWe5+8AxWhuvOPBkm+PxN83OuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:04:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:04:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 21/30] selftests: mptcp: add userspace pm fullmesh tests
Date: Tue, 19 Sep 2023 12:02:22 +0800
Message-Id: <8629c1ee889d633407e81ae826794c21d76fcac4.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 1215f7d9-9275-4d01-296f-08dbb8c59708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	05i9E647cuO/4R4txvDCe+ieHw5ioysm2kp6mfmzL46A8gn7+SE8ieMjj2gp2z3josw16josRopy2+zezYZX2m2uLXOPEaMHJlB5rhbEdhJARxjF/f8ox2R9htlPTsC9Gi1/tWlfLtj8pJK/ZLh6cLxQw7WcDwoVzoXq1w5R7khCdgL2SYulvbyYoM0ybkZfz7FHjgx0ezbrvgEpneXczYvMs1Dhh1QeRktM1QuKxSJTLCmYrO1XOrJJ4VuFeZexlIxUyNbDKxL7Hdv9h+z05ItboANi5qa3OKpLycdrEahXfPjBExYC8AkN5HHAuBncUhdFO9jk90YzLAdZyk6k98BbTe+yyN0Aj4oYngbezZw5P8xd+kE78P4jVF0bV7M8qqU13ytU04IQTTa49cWy1desSyV0kttJEW3V9H1Kg9fXBq5tUNbNDWj0pzh6EjZ2rwRy6TRN9GT65TDErMt3/2H/MH2BM8vSuH6VuwAHDE7z0uLYpVzlG3M01oaho4M8IecHvv+veG5mUpRaTDz9Hcu/Jk9YYiF+CzGFbm/at9gPTbMLWpeAQOIaZt5QSI21oW/I/ejDcphBRdeATXlLCQb4gLePICYGRBgFMLl3Y6s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t98qaLlNUuQHKRyNsdHOs+1BnLDi+znOPO6Td53TNBAV/rzXifgx1xp9SVH2?=
 =?us-ascii?Q?bnMdgdIame5lX+DjrkuFRrTerj+asd5uGue28QlfiBkmnKVrxD3lbi5Qr4+1?=
 =?us-ascii?Q?JEchtJFR+OWAb22Ke2wXLSg/U0wjly19n9mxLVZOelYX0oe/btoAKVEcAtX+?=
 =?us-ascii?Q?YwfDq0IHIDz4RNXgePhQhmZv2ioIaoT7zJCBb3WaOR/kA7ZvXQraADFN8zf0?=
 =?us-ascii?Q?vLaf5ocfq6Hpn8GHV5k7irN09AseGZ3df1acW7iDh20k05/9Aunm+X03MzLV?=
 =?us-ascii?Q?6rlOeQ+FGFiM65Unj+9KizfnQNMGtu4RioZ9e75urkthl7d69JMAGddo5fMY?=
 =?us-ascii?Q?qQ9G1w8sksRdd6cETc6c4g6KfDoysSNNUiZ53zfWyaqQADW/UPNKsVlOjpDa?=
 =?us-ascii?Q?jGlXGGALlh0HkGQcMJ/tFs8r9rFZiwLyaEo8SE9q2ZxE81TcRXw0ufZt1Xuy?=
 =?us-ascii?Q?Wu9NFu7bqd0soeVhw+DNHBcI+Kce75wlL5UV29E/jSpikV/VJ5kwxHypcryx?=
 =?us-ascii?Q?91iXklECmDTBiP8Tl2sRnGNR25k5qQk22XOsWggjNOqENsHydwWz6d9U4+Cs?=
 =?us-ascii?Q?8dlblHk2cWlpBoPMA5jjMhG1bq4Ts9y7O7MvyCyg7eYkusyCDt02IQMgNeES?=
 =?us-ascii?Q?ERnQt2H2hfdwXggkZfCSNVQHKlRj1rlgVYONa7eAxGk54YZ1whEpnvHJ9UbC?=
 =?us-ascii?Q?9WvODB5WltFiHxt4sBAETJYbdB3ii2xUwnOMFF/6ngK2vQlQYhXG17JNdlNV?=
 =?us-ascii?Q?Yiv1UMVrm7/9IHZGPDahHtwQAtgHIEbg7rdcECJOIad9CGCymYwh3vDCEfuF?=
 =?us-ascii?Q?yLqZaIIfJK1M2F5OxFUvzj/hCbS4xdaGW8H/6ncEDxrGuBvX9bFBx8AokrEa?=
 =?us-ascii?Q?6k64LmP89qaSPn9f8jW2lhrCFRnh5yjk5OXJGb3Wy5sF4LkXsEszhPrrsTtG?=
 =?us-ascii?Q?RSksM8X//lnxfZmHpZDkfKem/dXCaWaKh87lT9WVkiIHCEWOT9pnDxtGorQM?=
 =?us-ascii?Q?HRbxpFBfQ5UYc7obUkUfh9+BkgoBksvCaKUnPlASG2YjZr3/Gdky5+JUuBlU?=
 =?us-ascii?Q?Yjs1w+gOlxXuICO9i2SY24p34PIpU/n4RuHCgqmsOHthFCbq8DDCuRkEb39x?=
 =?us-ascii?Q?eVMxTA6oB5NlOWypDeNWk21Kh3Jk9iqijaYChECu6iD2PZZJwY/96WrlPqS6?=
 =?us-ascii?Q?hUgN7KzANzMh03ukwnT59DMsNVlc5XCOzFJuvcKoH3zFjkOaq6VoXNtYeV54?=
 =?us-ascii?Q?J3T2ULDhp33OjPH+gjCAS4OyqUsbN6Tv5iu+uYEN3f1AuZEaCMzHYCvWyakL?=
 =?us-ascii?Q?HKb08YX9APXw/7y+IhgpzktJyMGffHz8dAw9dLTfQSlA6pwHLmATTqsO0vIk?=
 =?us-ascii?Q?UtVp9Qw+9j4H956EXuhR6okpB+lFfJoAWCWVL2+ejnVil7Y4uL/LeMRUurdC?=
 =?us-ascii?Q?uAevYn59+zUGKij5GU5V7ixPcFDqiu26i+pTeMlDgHVTismcJqgF9oYbaaHG?=
 =?us-ascii?Q?esoD5mLcnR/qZ+SSIaVkdwVHZ30pzNP0NXoSsbc1EXuHPFxsxKbRG/KCazZz?=
 =?us-ascii?Q?BD4NCftsN6gDWWbbI5cPoQ9spo9eBjwCZuYENkGc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1215f7d9-9275-4d01-296f-08dbb8c59708
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:04:58.8474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+ccABg0qIhxNe3hadxJGF7aZEfHwTQy1d6lo/Ad4+W+JmEHvh7ZGgVQtoQDmCax+g8Na5LxlCEZEgspSGr8cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

This patch adds fullmesh selftests for userspace pm both on server side
and on client side. For the server side test, add two endpoints with
fullmesh flag on ns2, then signal an address on ns1 by userspace PM to
trigger the fullmesh connections. For the client side test, just use
userspace PM to create multiple subflows to do the fullmesh connections.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aac50ef86785..d883c6c2426b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3532,6 +3532,46 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm server fullmesh
+	if reset_with_events "userspace pm server fullmesh" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 5 5
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 4 4 4
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 4 subflows 4
+		chk_subflows_total 5 5
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		mptcp_lib_evts_kill
+		wait $tests_pid
+	fi
+
+	# userspace pm client fullmesh
+	if reset_with_events "userspace pm client fullmesh" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		pm_nl_set_limits $ns1 5 5
+		set_userspace_pm $ns2
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_sf $ns2 10.0.2.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 30
+		userspace_pm_add_sf $ns2 10.0.4.2 40
+		chk_join_nr 3 3 3
+		chk_mptcp_info subflows 3 subflows 3
+		chk_subflows_total 4 4
+		mptcp_lib_evts_kill
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

