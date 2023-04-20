Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7E17ED
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgLFbFnOUPEcdX3bm/L3vQjNcV5pt4oL7yjXJ049DJJHe2WHdysUiazDXcmm9ciMVo8K+03de+gKvZLDzDmJmA2VDbhEY35qv5dTCiO1gYh93imrJ9cABNBwLHZUfSHA1Klt6kX/LujbS9MowUuKv6HvJ0DGdFVnt7E4Rdws1vT/sMdM1gUEmWR5FypHaz/gB7KYbWDCEIQW7HTSzCxvzW8rAFN+C3mw4YX4Y9lN5cTNAHMuWEccW0azpg5hAjAjGN5H92GoA1rY7hUtczZDTY5WAVyFTKmgzKmyIAnylkenKGugyNUJ0Rp+miywdYXqu8Gn/X2CYzoPLZypVtYYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwYkeFW0gFlNlno+KUMeZuytV9afTvMmrrmn5vS1sUs=;
 b=GvUejK/8mP+dOXwbfMiVdJ6UQtm7kkHhqRxBXEPWxE1B9vVeBCLwcJHQyzw0P20oJkyb7FpQkJutEfzYel634bHhhS+kf/1q0YH3segiu5cMpFiamOPBlNiyayOGS375tfFCwH7pU5ikqkYQE39ym55zu5PtxyPIYHx4e25dX9x3xkYVKejZRCDjLkkGewiz2W35FxiG9aQJsPg+6v6/b9ekKKTKD0JRN35k6W1oyE6Cqncee0EYRctSrhyz1Zm4r4O0RigtThKGEU0BVc1d130HSnsvuvA69n/tlr2HmEEGaLeDeb9K8ZPqKdmC4Nx53G1i0u2Fzr8fZu2LJ+RAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwYkeFW0gFlNlno+KUMeZuytV9afTvMmrrmn5vS1sUs=;
 b=oZyCqZiTxC1dd7+9nFgDMbg7aBMi6+U7AItLsZqS7Qz0CwWEmSGiAtcJTPKvgiApE4PzQzsXGJBZ8DkB9aPetLa/pFvD7oyWGrzPN2jxoY//EVQPe/Z2xwRgHpTvcRDbp/TfzW6JNJewTw6HNsV4rchOGbzwGC17EnJTzEHTQaWVdvXaNuqMddTLe50wmMELke4PlqVGOyeeP2qV9fl+P93k9pULdyHMkShb7jZ3QGi96a92guJl62hzUzGhxpEaQGxXL6QnQXsY3NDjgwAMwWerysbykOF2NrWxjFuIm08kdJ2uPm1TlpGjrzWYuawHklPaS/BtjWKpVF+Ld7Rcpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Thu, 20 Apr
 2023 03:12:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 03:12:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 5/5] selftests: mptcp: update userspace pm subflow tests
Date: Thu, 20 Apr 2023 11:11:39 +0800
Message-Id: <177f9ca7d30f810324bf46705ac7d977461ffc2d.1681960259.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681960259.git.geliang.tang@suse.com>
References: <cover.1681960259.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: a21976d5-da34-4cf8-efa8-08db414d067f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QWnPe5ZU9JRKZtUNbTP8SLi0v/apJEJBQH8/Df4vbynZhymYrihAtdKR+O6DutpYagc//pO4BJ2+vlMl/Oc8ilXRwGJPZxTygsa7GZwxwGIn+y1XTaeUZJe323oeHidA8ixvwtJgPuXLINY5HIvt9vDwxpMRrs5Z85Eww3OhzzleNIJ1wxhgABFWhzsUr/hBvD/ZA/oBYlU3UsDqqMKdvzSY5SQInsQhPOEoohwQ8//E7t8G1aw/liuLgmuGUs7FT6BOXLLyLo84EqwQtUZDePOtXcVWqiPMh19wc0kDQjvzpy0kx3Fe/XKYYXZzU8/yHyFS+f+UhuEXbxNpSbKQWHSvI7N5JIqBj9Es5/edzYH+soyT1NswBsNsX04df1WybonFeVQb/WCMsElXHmNqAXxf10IHNwrB5sLb3wvm8sm/vkW1eAfEkzHdmxMAhnCYOxSri/Yt+Y7+QQgaNYrij5n7qNhkZ2ohYjNDCysisNtVf1CVEJ9866vXBAc3ejlxHdoYrU1PtnnDl2UdSrojBESqamxaeqvBr4ROCcFyuHYbu5mUkHAaKyCh+uKhUu0G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(4326008)(6916009)(316002)(66556008)(66476007)(66946007)(6506007)(186003)(6512007)(107886003)(26005)(38100700002)(2616005)(83380400001)(8676002)(8936002)(5660300002)(41300700001)(478600001)(6666004)(6486002)(86362001)(36756003)(15650500001)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j3WpPpPqly15jIfLekrF7JitMTlzV1+NgJgSs7DwaanuUmrZ8IZFyyCgoCBi?=
 =?us-ascii?Q?hHSFkq5Y2iTP5Jf8wu23RNi2OzDSz0iRmaAazLgaPV8Apao0dnHeuq1H8ANo?=
 =?us-ascii?Q?JMCRtn4JypT0GHmUejEINFlqpkz1dw95aOwIrRAIjGnrEczAVg0qra7y8My7?=
 =?us-ascii?Q?8wJ7ZmhZhnLByvGrBkTVZbPTZdcYO1jXWEIwTOZczIdTEIQpionVyjV3D/3I?=
 =?us-ascii?Q?Xbf1tJHvtlghWoJ0eCsvh2f9v7R+IN9Kkmot8piAIdsodLpKYXakrkZnRP9b?=
 =?us-ascii?Q?5P39maQJekNNUTTkPnKSaIA+G6cqdHu5VUEN3R1jpIr5tzcyPBvAIXqgNnpV?=
 =?us-ascii?Q?56/ht1ils8VegiEpv25n4JptjrPDRJ71EhPzEw3MSFunmc0ETtVn44k7Zhsv?=
 =?us-ascii?Q?laDh3zRYuVrDzm9tcQkEaW6WLwDW1LIkoUbnLPYzUY5yGCwTO92xka9hReuQ?=
 =?us-ascii?Q?OiXZ24h9WvuXZbPh/7woNGMFPMn8o4/fZ5k8HgFoINL4yBxYnnY7GbHtlmnp?=
 =?us-ascii?Q?bpNRaZzg/1eLz8P5OVoaM8xlXrfvADlWqTmBiKzys0gf5ySK/5GnfzWsMD7W?=
 =?us-ascii?Q?VA+cztaeMOu9yakkXs/Cp1f+Raah79x/OzANij8WJL0U9SQKufBpOW8m7z3g?=
 =?us-ascii?Q?oyGZ53z4VGXV+Iyl16Ra9AdJE2gqbqUflF76/KKpDarYLYfvvgFPqeiOchGu?=
 =?us-ascii?Q?47JbrYWACFoH3NbLlXhlbWgb7B3SOvFtR6/mKOaywYM+/gU/b1iQynkN7fH0?=
 =?us-ascii?Q?jUkMp4kfCXHVvJvzCEJv7ze7X8UicH7AAUPivUBqG+LiweXIz1Xv1dONQ9Jl?=
 =?us-ascii?Q?X5825K3XV3OM6XkIJrQCRQXjSIvQ1CTdKsN6+7CzU3aAvKiHywwVZPpC2lXe?=
 =?us-ascii?Q?ZGr9l/HpiSShtG3/TH/JIrLWcWPV8mbjWBiPu4LhAEjHRD+1fAeTU/RezVpq?=
 =?us-ascii?Q?XEVWh7vqbtToWriSccwQ0/Ay+RwxRssKNFKlWNdvN+/SnxxVkihoTCCuuxUo?=
 =?us-ascii?Q?C7BeuGTH7XdEj6wYG3gGwPlDeYht+2/+B+kIm8gMIVEfsu+Hmfn/h7dX7NjO?=
 =?us-ascii?Q?Q58HSxeU9gLLaiKT0ppyK1HfWJhid01jEDv7RXmF2Dr3y/0eHibz9WJposdS?=
 =?us-ascii?Q?2wlGKYKi853BEAVOLXvUtydeL6Wuzc9yoxQAGYgGfA1q1mhYVzDH8jjku7rZ?=
 =?us-ascii?Q?i1ggsxhN30E1k2a+V6f40aC72KQDEtR1B+e7Lx4i788SMrKi4JsSW1fPZEe0?=
 =?us-ascii?Q?ZY0wEEkga17QmcxOKZQ2K0ryDFtDkcNYS0KJhH0Q2EFA6xWcZ57BT3bVVhV4?=
 =?us-ascii?Q?Wty9DQJwj9cmLXgvNPzlpajqbBC6kU9tzOC0OO3cuZ1FfAYXLatQYcjPmwe9?=
 =?us-ascii?Q?cCt7a9nTFZyPgK+NgLeo0aRrU7A9the9rMR5qWiE+q5vO+0U8o/E7ZjyZAow?=
 =?us-ascii?Q?jJddi+TbMBVGqTfJ1wNoiyvRpTnvUoBNoHjGkbb4+bcYaATbM9dKWuSb4BE8?=
 =?us-ascii?Q?Ej2WLd8aen3IMI4/M2XgzjQY55iiRtMd63kpCZl1j6YuAdaXv9dkxR8ISW5P?=
 =?us-ascii?Q?IzqBYMyAHGmeTzuPsFGX/qVf4udLiOCGbULGUteW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21976d5-da34-4cf8-efa8-08db414d067f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 03:12:08.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trFnOtwSFPr+1ThGq5LO4ul/Wugu/Zz+B60pL6qAlDKyDqarduMeHLYhfC/DQIryQfIZkkMpWQpSTWVzvqakBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Update userspace pm subflow selftests, by sending the a remove_addrs
command together before the remove_subflows command. This will get a
RM_ADDR in chk_rm_nr().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9a9b6e9b28ab..795c141a11f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -923,6 +923,7 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -3137,7 +3138,7 @@ userspace_tests()
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

