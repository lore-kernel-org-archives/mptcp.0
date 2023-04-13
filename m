Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92A2FAF
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 09:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zcl9/1g9vV+TG8p58zMG+qsuPf/frqS2lB6j1MgvapT8zFgD4YpWXq38o1gtT6CRAhCork+M8A4M3QABUVznHR8o4Eig97oxB5UXZ5j/Wrz8gbxX6Rka8OQcKR8wJAjeq8jnKX/Sq/tnkK86bFl2horw31jJysWipRsGa6a9G5OeaRWWre7fiJe+r6ybg/xHhHqP+TCmN98u0/NhaFcjEbdxnB6QQDwQFccab5qHvTlBDKuSPxCPdj68N5mAeYgUw+OpoJXvwXpF9vS5D6QHEs34S9MoxfChGRcrMCoa+o/pQgFbWa/h13ILC6Ae2qvDXcCSUruL7ubvt22lCWT6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/tbAZGdMbQiUpSqZmNLapLDAcEBHf3PpcZ48ZqJqHg=;
 b=RzbPFuSpppiq4cD49zvamGvaYELwPvwHyTLNSbZrJ6SbVTFfEpdBRwQ7y9fO3XFjZOZ2pwrq6e9IsJaXLt3zZIfiLTXtxsWvIEbL3QezMQuQGmsGbCF9Na9Ol5qhwMg3PIDFW0TpdVCy8+ZiJpwD+OXCS82kd3/Me3ofmc/kJkZw/dzwbbFRklo+SYYDf3+i1slLj+4QCcECc1T5faRirj3dP7XaeZ2J48dsRpffoQBTZizvShG3Ixb+eJAaxicxSVeZRg7a1Z8c5dTGCMvQdy5/DFY6yfQfS9UeROO++DuBckMS6S2YmVwU7XG19/tOkPOiSduZgtHf8kjTSTBkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/tbAZGdMbQiUpSqZmNLapLDAcEBHf3PpcZ48ZqJqHg=;
 b=DeifU7ZPjZT5A8eH5GpdMyau1qlBxS7SJsavFA4KdcVhzK1lT2gy7U8LVkA+8OLpDvH2C7OyxKByc1FtlqZq3K4Ujsb+to8tPtiVWLqFGFFEDuelcLTyRZV5Lm/sYxi0vp5I03Lph0vCvslSRhXIUtv4O3zeRHKnYr9YPtpTAvOcNH0qWlHu0Dp0FkhXGiJQ+miH4Y8UojzHGrJmXbuJgbespP0MOB1dmQ28A/LoSyMWFu4W1b8IX5FrJ58Dl/cS/bylu3ZHvFlQLSfsUPsS7ItMebPnRJOROvTop1gc9I+Hc+d04TadV26YXkCzbxT3BU3nCm2JuuBh+SRBcadBQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:13:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:13:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 4/7] mptcp: close remote subflow when destroying it
Date: Thu, 13 Apr 2023 17:12:39 +0800
Message-Id: <149863aa23cb737836bc119b2165ca7baf4f52a5.1681376983.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681376983.git.geliang.tang@suse.com>
References: <cover.1681376983.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 3960c3f5-086e-482b-f3a9-08db3bff50b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	39o0oyuvGqLnQhIidbmynihvRLbpNcCmtxPPSXk2EujaXhIe9piy7T+Mv/eXFNFFN1fTdTzyYew/N0LWVdpJ+5rVBxEaTRLGKvGNdy6qYjSFGDLoJ8svc8fKYmlR5/vnH9owmBYv1sotM7IVSqC2VKmx0t88PUlcGQHKC0HOWqwwV1vojsX2yHufXGDSfFQFH5cZ7Pcqz0c/nUMA65aP8mcX6BfrQ7oYFFP/nIsjXz16sjw/BSzSe/cTYMFKXA1MWlAjmT3dM2ZupdpxMjAKIIKQo0MpA2sBu+hyf/lp2ZYn4emRWvxqs/PmQTtatDmHGIOzy6jchSsl3qR3F5bYKW2iANoSZTWPAXXiYuR++AUWkGNJ+Ve9tG/PvGqax8WOQ922QrpxPyy6vKNO6/M9wCjxMCTmp/Ogeamdgh4TLZaSvIC+rqkqEj3gU5qTL4tEIAXwr4ZX8eMGGXOPdfNAz974hzR/ftkHUQPSRU+vj5oN9N96J1SF+tCTXTy/fMxzt+uqeerMPCppuQhTy2ZzPfoG3anyuI1Df+oZ6kroprTXqn1hy+v7vHUzmGp29B81
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(86362001)(478600001)(6486002)(36756003)(2616005)(83380400001)(26005)(107886003)(186003)(6512007)(6506007)(38100700002)(6666004)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(2906002)(8676002)(8936002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bg69PdKMRloxIMAAerxTmwNXDh9yFstKEGg07qLWmeN+sf2eI+FEjbUO2Pyf?=
 =?us-ascii?Q?7OY4GWINx3W+IfElfKEsfC5T2a3LPfCptYvq1Uys7RUgaChU5yyQ390fx4dy?=
 =?us-ascii?Q?KOjrD1UBj5mF32WaY/quz8JGng0hsMhKi+pft8uybsIsaVkW1zknViBjHcGy?=
 =?us-ascii?Q?eCnboelMnqMq1WyrccYOcS86LL9NgpZ++LDjuG5vqBMxNtFoWZ+Qs6u6X6OW?=
 =?us-ascii?Q?AVssXEDBOtbrZCuNqnALtJ31MEfKH4c7ebT+hvFudmKv9bXVZgrNCgSwBePb?=
 =?us-ascii?Q?K4gD9plunxuJwVd2FRe89lUSrsHn9pVdHoipdSeVydi0Iur2fBcPQ13d5rKA?=
 =?us-ascii?Q?VLF3jnR2wbXTtnmGXKc9DAzTy5/50dXNyqCc/Ps3SJvnhs2v/eJX2++DVEYt?=
 =?us-ascii?Q?CrHRONHFgFeTs2zi31gxBHEXrJiRg4Rjpaj1BjgEg+jA1Vu/wUAqF5a5uIRH?=
 =?us-ascii?Q?V4V6tqN3gyBtBUOGEdbC/1mm7xRD7IIL2PfU5Voki1l0q8iwTz8P+De83/qS?=
 =?us-ascii?Q?fEQpB4uzFchpBLReNbKymwlcXedDffvRvp63J83442SdaxhQSjkAkWU4GbpG?=
 =?us-ascii?Q?A+JiswhwBC46qA0HifYhKJx3R6dh6BwFaCNY03u3LSUzcU0+YFbhODh6GMRb?=
 =?us-ascii?Q?eLYylbm3D4i+tXNbO54hpbR1BIjE0U2n9Fk/6JGZxsMud1Dc4F4PeXfOaNvf?=
 =?us-ascii?Q?sNQaIlF0GniGK4ASpihEwVY6UWOdCBvuZSn9OW5vegaJ0M2xUEhMniIiY7X8?=
 =?us-ascii?Q?VMT3itOIW5nUnORcD5Z7afSrwJPNVl/vlNrr9wEbMVQ0kYxErAZNQTbfM0Df?=
 =?us-ascii?Q?N3yoVO/k6H35v8+4UVbyaAFDyY2XjEhE9dJsD82CHtRtvVOeXkX6eTdVVPXh?=
 =?us-ascii?Q?1PG/InkHNKZOkhzs9LcEMWRZxl4ANntiFjvD1DdT2EKVmtPApHTXaTh4reuB?=
 =?us-ascii?Q?usIQovqGCycCyEnimKQf8ICj3o0gsOu2eSEwVeXwAws3MCSz/MOKyCFKTvX0?=
 =?us-ascii?Q?6+DPKfBALBNaUhifk9k/129XrqbE9OFCx58ukwiX1THwjYBYsWCeI3uxbu9V?=
 =?us-ascii?Q?ZPC07JH38eNLepJXc3ny7fCAJMgmoF5ltGaJuVVebh2ZfYqojt4EQEOaaK/8?=
 =?us-ascii?Q?T5nM4+q9D/OzC5a6pLA777F3zjaRGsUTuEi8ZLjRh/8mjKc1Q3p8sZmruvvg?=
 =?us-ascii?Q?+rmZduvC3FRfjijXUo8Bd1RGzuOMpI060KJi5a+I0NYRDntCk9bg1x+YSUel?=
 =?us-ascii?Q?x0GpKf2LU6SRt5SefE1HvPFqA2L60MOpiF8isahP7DMxWd4ooRvszXGNVdJJ?=
 =?us-ascii?Q?PysDMQq24Eyc/fJ394dCUlxVpv3Cq8KTv7vDlyqc4/CousPb3WFmjZ7NWTCv?=
 =?us-ascii?Q?br1osAx75W3kWqrVCgzM5IuKoPwWFclyepVkHL5CRHPMMjKJKbG/OFO1sgFI?=
 =?us-ascii?Q?mCjLYU031U24uxmndrHa87lywXm2xXQPJcH38uB+21QnJn0wzO0sRnnx8xdI?=
 =?us-ascii?Q?OR3NTHjxjxgP5tiXy/zDrP4Dcp+TX4dkp6eth2191sfNRdGrmmmkNe3dSsQZ?=
 =?us-ascii?Q?2KV8/sKSkzPPpJ9zUXBefItA8FLOxgQ8p01Y+R1c?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3960c3f5-086e-482b-f3a9-08db3bff50b3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:13:16.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+6qvuvbCi7wkhxI6iKwGa7ocxp2JPd3lt8wf7xUtwlEM7vK0LXwEScToQRQ0/mdtcj0DFOHJwddcxnggmVR7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339

Not only close the local subflow but also send RM_ADDR by invoking
mptcp_pm_remove_addr() to close the remote subflow when a subflow is
destroyed by userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c                        | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 176c77a2a79d..7d676daa89ba 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -308,6 +308,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_alloc_anno_list(msk, &addr_l);
 	msk->pm.local_addr_used++;
 	spin_unlock_bh(&msk->pm.lock);
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..072f77b6b206 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -911,6 +911,7 @@ do_transfer()
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
@@ -3123,7 +3124,7 @@ userspace_tests()
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

