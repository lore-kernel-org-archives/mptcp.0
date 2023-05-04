Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664FA2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4DMsz+KrBSgHPkOMwr8FwHRoVXo7u1A94RcS7ZvtaA5x/tUcKYU9QmiYvwm/740Wo51Q3N6KfrbrstbXI0M/pz42lyMfDgwBl9Feftw0lomwhNw/2i48Qi8XS9dEkyPpKHlKjtY+UMsEMMgmmI9WvPoFlsFrcrnQH9DXjUsC01vH4mOHxCleodhOxAlUBdox181GRjpptMBti7S7TsBcjlEytgoDfLCuKmS4q1Wkvmo3LZtGjt6WQUa2zo7xiVBscug8XoR01A3JwjZ/DCK/4vxHwuHpwCDSnDFwqnneg/wsh0p8DWv5vkUjhoqws3M7v08gJTC7CBZOqZBQyJQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM6UhZuoHsPuehq/JCoLPwe7EP09ebMpHleV2j12r7s=;
 b=nRQRLwGrUtu03VfLfDD/DHDeavtN9fyxLP8/FPbhprOBxc22MAl4bdxvNJV4hqPz035tKxrfNxQLcAEnVGnUBAlENtQERJepS/eo8GD8yABuHNCfr7BjzSn/0wn37RnaWe0SsJczp9BeIjAGzQYTD6eCn+dKarUlgwY0jbGXuBLY5HcTGJKjaBp1+3lvamTcEoMOX0JU6rc3HlXh66hrVFXcLUZwVErEstjGkNM4N8z8lFUrkaMCn6qtDhKrN6QACJHeIf5lwipFF/bL6GbBSWrodES+bBn7W/QAlR8Pj39Q18JOGClGLJ0XkFwDqzT+9id/PmVWQl/UKGCZ2CB0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM6UhZuoHsPuehq/JCoLPwe7EP09ebMpHleV2j12r7s=;
 b=XKqsfJgloApLNaKkH9Zhc/ulzM9f8NRMw07Zqn0RtvZ6P7MG5SyagicWJ8oOd+qSkysY9LDX+Mv1oCBvlrADmB3ukZa4fnP0+FvQGkjwa3Mr3DZrrPdCg+ahyRnbkEYbN6e2YbaDHX8lb94VWR8Cg6CRf2YEFmstKNqQRXjPHk2LVyg3V+p4fT06Z6fQolt2sJDE17ujL4GfA8wS6yXcwD5XBYaR7NR3udqjYbOvqrcVaJHstx/KBHCDQY3gbj6Rcq1SorH+mqptV2olCfmivbpNV09ogPGgw9VyyfQGkumBAOSrryWETfkYEGjx07GbtZntdJP/aYPURVUygKcg6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8345.eurprd04.prod.outlook.com (2603:10a6:10:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:21:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:21:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 08/12] selftests: mptcp: check subflows infos
Date: Thu,  4 May 2023 18:20:13 +0800
Message-Id: <6d3c3fed201365d6ff5a31ad751032cc269857b0.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f64168d-6765-4e42-7b7c-08db4c89496e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lEIl/DTDzEV3qZGGd/37wN3tWz0YHYDA9OHwz4xK4Sg3wSzP9oVirfWVXQolxYL7Wni1VfqkHvJuu145RjQ6M4uAF5kCZpJxyRgBxigeTP2zOJgElYAMJUeMtlLpp6GtdEHFsJMXDWeYetRENBgptwIwlhsCO5Otv72UGyYHkupZzlQwfWqHF71esxX0W4BKMl4YHZQM71oj1JzljkhZl/t/jTBiC7lfi7268dDBTSGkQJdNLYbziAhmH6gJzppYh+9t4MzH/daa4ft4yjKokWKB+Q1nUZ3oZ5DoW+dagcM4h/ldC+TUUl7ziqq8Du+RpxtvMIkaYtEX2cxWEMVpymCAaKzuemJv6NIIWNowNibGYjJL4OE/Mz68Qms9IsMZq6kB1tEESEKWWPfcQ9yAWdQAf6f+lSliN65IKzMv4LmkxuOoXr7f4kdmSvQUCo4L6ufy2Ts6XXgL5+oQZAoNwG88d2uiaMGsvD9g7pwcD3Ijy3V7903Qaq2Pu2K2zncwEkT1qsEKAXnoT5n76UC9WK9AAE+t3aGRmQ7W4sIe50wG68jc1VIS5vkEHoakUvKw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(38100700002)(478600001)(86362001)(107886003)(26005)(186003)(6506007)(6512007)(2616005)(36756003)(6486002)(5660300002)(41300700001)(8936002)(8676002)(44832011)(2906002)(66556008)(316002)(66946007)(66476007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kYi/TBdCt+p7dnO0RQ9EkaW7dn/9ZLIK5dmJqPCaAXMhiX9wB/W8xgCYe0/9?=
 =?us-ascii?Q?jdhZEK6aFDxDu+/aNkXIJFpg0ZHG76+eegxeOlRjjP6Ox+DUbjQP9tkZ0Y3f?=
 =?us-ascii?Q?Fm9P1o8eOGVc1fAku1hpVAx9ItX7hl24pnw8mjIhjYOHnd/rZ6+1HMqNLh/C?=
 =?us-ascii?Q?77/djf48B14/LEx3wJrZJttWCRU0hxdtzyVPhKkPbYkvOkzoobIQYCdJ3qO9?=
 =?us-ascii?Q?BRr58yCBVQZuTrzU6lLAblb203acWHINrC64xSs4+0Xc/C1DypVcCTnFqTLY?=
 =?us-ascii?Q?Ppe3aX4eOHInSVexHORuI+rwEYXY2afspcwLEhb5KapQnesiW38ZLQulRLDc?=
 =?us-ascii?Q?0Dl93Yjjq7CHI5yuf0bsf4V7CAs/5njicRAOcK0smNKcvTBdoLU+uPDF/4sj?=
 =?us-ascii?Q?+8iW0HaMTxpBFpkf+14UBVdqgvz8I8Iyiw/Alm2mYPrL407xmVQLwqxUvlpi?=
 =?us-ascii?Q?G/cRQ52cLZeWFFGkhOwX1tmoxXG+vhjOszuWcCAQTfg8N9JG89NEx4EY9zge?=
 =?us-ascii?Q?fd80od+WO+Gab8pYTJSkkdlDhAp+3m2qXKrmbh4hWfhQE3M89wQ5Yz+Tgwpi?=
 =?us-ascii?Q?hhlJZRQmjq6jT40vK/LuEMu/9Om/2julj6nfneYqzoZJ/7wL5AEaftSBV4Sh?=
 =?us-ascii?Q?tKtYUlR2lswT0zXBEiQlaAKXpB+ej18/PG6css/wy8Ac0xbsX8ekxE3goseg?=
 =?us-ascii?Q?M84Bj1xYsWV+ixROpqLaeax5DcY2zadrkkdv88VnDmZF4G03UouyS5vBNz1+?=
 =?us-ascii?Q?OcdZgOVGax3zylXnKuAdoZBmN1MCiCc6QEW8/lo4bx61O0QUmOPPM96d65/B?=
 =?us-ascii?Q?C8/xIbY97KUO46wSsSDPB7KgtzmeIKPhXdR0Y56JMC5RgHZC946JX5jikPVE?=
 =?us-ascii?Q?HdSTOLZrnPzdwwXMpg4PefACgRPt2N0gPvEHOSyR5OeeIUtocznLruMJGb9J?=
 =?us-ascii?Q?NHAmnRSB/UOqmHppx+wAarYNZvQiflY9DYIVubMXTKNBwUjRXFQv9j7YpTqF?=
 =?us-ascii?Q?lCq5B4TrLFaGru9LBehURayIQHeOrP1SxJp13JQWzW3AJk0tOgPPIDJhXNhP?=
 =?us-ascii?Q?aP8/feXSOBw93zWtWid6Oz8fDjBtncA634YssIJxbNWXj/r/VcTvMRMTr8a0?=
 =?us-ascii?Q?qt38jHM9oaKafjzM+WKGHLo5nS//ysJpKRgdtCu+Lgeq5sOVVgKJVxMesuy/?=
 =?us-ascii?Q?GWciB/85wjI/etI6B36kbPMCAnJ3o0AviS/0MjSrV2n4hz2RD2a7R1L23Ext?=
 =?us-ascii?Q?1Y31uDokF+hGzSy52CCx9RnXa8V1mZl+wjhonW53J/lXCNQN56HXOfVs4w3X?=
 =?us-ascii?Q?svTZL02HEOgZC4pPw6cAi9v3vAVShvKMjM+h9bUgrJ9+FydinYgTz2HEntKe?=
 =?us-ascii?Q?9aylJWV2QXmndN2v0P1aIXK4twjdEvthOtxo4HlPim04LgDBq3u/sInVMuyP?=
 =?us-ascii?Q?v1G586ZsqvYcVOmIS8mdZrtvgPIPJTZNB2xBAvgt3bTQN88+ZVF9T+QPihbx?=
 =?us-ascii?Q?BnrVT0b3uQ7ZkG/uQ0ysQtnqxQnKo1Qr1yA2SFgNUzCDZ3bIuEQiQmOOEZga?=
 =?us-ascii?Q?zxIEOfuHRsoo4oQnUWnfGMxNNepLjnVeMVqNg+xl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f64168d-6765-4e42-7b7c-08db4c89496e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:21:13.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VC8P0khv4/RknprNEImvYpChr0FHvJyDDCy6bYWdY4i4a5YMXBFVW5NeN+c02Y0XaGid9XmsyVwETsATfgkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8345

This patch invokes chk_mptcp_info() to check subflows infos of userspace
PM tests and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 582b763f652b..700e525750d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3109,6 +3109,7 @@ userspace_tests()
 		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows_1
 		ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
 		sp=$(grep "type:10" "$evts_ns1" |
 		     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
@@ -3120,6 +3121,7 @@ userspace_tests()
 					lport $sp rip $da rport $dp token $tk
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		kill_tests_wait
 	fi
@@ -3140,6 +3142,7 @@ userspace_tests()
 					rip $da rport $dp token $tk
 		sleep 1
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows_1
 		sp=$(grep "type:10" "$evts_ns2" |
 		     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 		ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
@@ -3147,6 +3150,7 @@ userspace_tests()
 					rip $da rport $dp token $tk
 		wait_rm_addr $ns2 1
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		kill_tests_wait
 	fi
@@ -3164,14 +3168,21 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+		chk_mptcp_info subflows_1
+
+		pm_nl_del_endpoint $ns2 1 10.0.2.2
+		wait_rm_addr ${ns2} 1
+		chk_mptcp_info subflows_0
 		kill_tests_wait
 	fi
 
-- 
2.35.3

