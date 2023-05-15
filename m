Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2FD1381
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 02:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fkrik5Ihrz7v1fvR3Yu68yxGzspJV/6VBAACHD3T58i+Xd2l/jCxpgsobfl16+fV6cmpemtrFZNn6AGTifvZB9NbMY4hlekeYBk66uMpMNVwYMNv1WjhLU3eMlpf8aoe6296vbXXNyPeV3dqGYEVUWryuehZdk2ZmoEwTno2Y3cpjP1/U2g6eZbS/0JFEBPjrBNsyio2FIvuJLi+n5Pd/5YBiQDnqqyuspgEr5zIpRKDGxC8aGf+/uDJToXUI2JixtuVd5q86Pq/3B55+uZy8voPF3YaEiR8uXZfEoQj+Jdmn3Fue91GBQ1kj37c4kSouh29XkpCcEeDi4gc5TKvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkVLarjcUjeQ8W5f7yqf8nyUuTuh8M/bngw4jRiF+dA=;
 b=iArZKsynPtnATH1ysTY9n/rE6dC6g/Zs7QTFw83f11nb4DAZMMb0hCF8DCHGY4HpAYx2ndKDLxTx8AKzPa9ltzi3SPJu4+Vi2k8hURbVNvFyeU07Y23VYwPoae5lhU5KiG/9MTsm/qpwPrpIUkN7/lDLKprhONjPvsD3g3CjoT4N5ruA0Pf7F48AeYc7UWSfqZA4MY4pLs8lbanPN8/IJGNB/+WxcSIkJyvRFSrP1RpcylNLsF9QLtc3/lX4njDyIGs87cxbga8SI62zrmCSSuIK5Hq2dzsB9eRtqQqC6wievVWPVNKURA+XfwWwizU67H/gDipWgqw4NlVlad5P5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkVLarjcUjeQ8W5f7yqf8nyUuTuh8M/bngw4jRiF+dA=;
 b=S8xkfg7o1z2fCsxYNTkg8LdSlg4zKdBBx8pYY+ZeoTGdQ0dsp9BmNZ/YWvd7pnxiCRggM8IVQulRZ95vVlzcNxEiiHMQGc8z21UyZ2/jvFRDlzHgx79EU5bDzXFHF9mHvty7OJsVvQcM7eBfuvuwOQ+3pagW3y181AKBJ76GX6/NuwK+b1OwfHGxfwkIkLf2HH+zb4z4T5TpopLmKeNl/pPILDf7PWN7/eZ4vRldcuSPsM70ja6tB7dDJQXx7KGgoP5EYFLoRFzDao07IU1KVT4KhbaG0eFZCo5hM2JWV9S/LLUpSbeOuPWaSCWZpwEJOuDexaNIE5Cn3Y9hf8XOHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:11:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Mon, 15 May 2023
 02:11:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 3/7] selftests: mptcp: check subflows infos
Date: Mon, 15 May 2023 10:10:54 +0800
Message-Id: <fd90bb1bdfa6d9b28bddbe4ec6cdbe78ec6b325a.1684116357.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684116357.git.geliang.tang@suse.com>
References: <cover.1684116357.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:404:15::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: fc482ea9-bca6-42c8-d7e5-08db54e9bdee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V3um0a3OoI41qfluapViq3qjPbY72a6nUZhIzUsoE7k3Tj2ZWmwIi7ZK9SeFMNDJOvIlXuzzjZSwmmFEHsi2noEHajnCc5UZSzBWxdNYRYsa/fsW6Qn7lBom5bH/u+c3cpjspsJSOE15sME9dPkWi3F49d2ZkbXGC75jpIX6NbMSlHmflfPQBMtxHMpjZ85LAEAbUB8NO0nAF4L5vkRW5z2o+ZuIsvWRiyvRfF5iT/PuNLugxs89e6Lv0w8mbyPHtoo4/16IIvvxyd7/9oF4xxUMaZLBdncO63ZdckzphFkVbzCf7je7TM9AvOFhY5fZtAE50mIwFFontjlwb/STTWU65S0st+KEZ8xNK2VUxjIKi+BXu8BDt5lAkXI4z+6mkOIVwgeen8y2EUTWj2CHXVLQuEuJ1fXTwWqNa0nAYeVTPxBFExJx9hkgskN0Ckbdw87FKz0Q0iUZFI3TXh45ofzNVMyM/7fWnacYnNgVWjI6b5GwQByk9lQER78NEUG5gFzTZbsopA+Dq7INKCR2tBiZ8sJeGfTWnvp6ifhoZeIP27goHj+x6SRX87ieZ+gt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(66476007)(66556008)(66946007)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(478600001)(6666004)(186003)(5660300002)(44832011)(86362001)(8676002)(8936002)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mf1K3ZgRNLkTzbI4cl2iFe+V9Iype5SsOzRCnoHbBZrKQA1Jl/GCE0JVvbz8?=
 =?us-ascii?Q?iT6Hi1pJb7wK1ZDX/2ObRCtYNv374ljvh/Q79zu01488tOBqSs5HYFgjW091?=
 =?us-ascii?Q?iYNfaHje3gkV7Dp4hPI3jkemnqThl0UeMIM40akTtncwgsVR5P3hVk1TndlK?=
 =?us-ascii?Q?KuWlUE5opAumkZWWN1/4JF79vzLy9BkWPtDd5PgIfWPryJDxwU/jkEDCUEKq?=
 =?us-ascii?Q?muwH3row2WfugXajO7fm5ttyPLbtR+QNS4md3HmASl7UMoWJpAv5g6b3F6rX?=
 =?us-ascii?Q?7beWzcuyVhRdisvvGFQr1LfaVoNVRK+nKezf7fQIUYZl0ZqaMYLcty1rt3r5?=
 =?us-ascii?Q?BPQ1mWKhlVxoJux16hY/obX2ciAoBtuhgnVU3wYYrbi8pHG6Msg0vHtBODYm?=
 =?us-ascii?Q?H4QdKMbIrx5xcvUknPxJgcbYnzcoYkkrEt+fxcjRsqRy8PxDKJkTpzNey1z+?=
 =?us-ascii?Q?pQfBnz9c59Q66WkFSNfcam9NvFsBGHfKa0gLquFAuz0zRshYb7V0GFL29bb1?=
 =?us-ascii?Q?cELEgUYxq7ql1KozRwhaRABocdKtXFeqR2P1auLHJ2EzqVWmN7KcQLd9pKoO?=
 =?us-ascii?Q?DkrzRupFzys6DvpCvk91R0BRnS1DN0rlZcj5zbnSrFnap3b7SfYd4bmmDuc5?=
 =?us-ascii?Q?+fsigPgL2Uyg7Y4NjIHCKyL0M0X2P9ZPv2O95n2jV/lbW3Ng+zuC3TKnKeTq?=
 =?us-ascii?Q?JG8jkO95dDdKooV6J81zAHAa+XsfE3MAWGs8ZLpYTMknRxuE2ge+y6iogRN7?=
 =?us-ascii?Q?MjNvOzCEOX2CXzhtgDxkEt6/owAdzVNloir5k9Db9LRG7RCQOrQHotl0RKiG?=
 =?us-ascii?Q?OUMeY154Rf3Q34wv9eK5iVPyk4mpGWGs6cKxboNhsl5hAcHzGEXQgMHzz1Fi?=
 =?us-ascii?Q?A6WKUYaNAIxs5ewP+fQ79oGABdlbhEInrC4RqudlcLOisrQ3aXAEa6ajgmuG?=
 =?us-ascii?Q?uC6DRe6VNcxA7rQWiPaoHc3DA72aoNiLgJNOf0wqo1xI71NoOkH+ZW4UZPnX?=
 =?us-ascii?Q?/2c2WfS5ZEGDmjOw2Ic763QxkvscloKXzhmkN7m0BuvRrmnArJgA+Xz1cfcZ?=
 =?us-ascii?Q?Q4LSJjR8lOjfjcuWczPDY33j33Ggxsq9e6K33z/oxSJ9kkNrSOeGrzJ+YdAI?=
 =?us-ascii?Q?b1MjX6E8DfcuAxR24hL6VJckLCj5XqAxVntai2xBNb00nANPDb/7uPx7X74f?=
 =?us-ascii?Q?uwvFD6HDmtRpDzSGKPRUfD4V/z1x1yYhnAKKp9536Z9EIkOW3+onf2L0wbgY?=
 =?us-ascii?Q?rXRe5+mXAspGLY2C1aLq59F8JsX1mO+gK3VloKlneXjq/pSPy59MUTKWArp+?=
 =?us-ascii?Q?/7S9aezS5iQlIY/XUadHetvUR0IjUCjVErm3kjXbEbWn/34dTWaadKTacam8?=
 =?us-ascii?Q?ouFs6HhSESDHyn6oA3HKJnUBXwhH+BEJ5j4LzD/RrlS/KDgBoG/UeKmnDfCV?=
 =?us-ascii?Q?A42ZccBbozflSp0duFaqX4X/h7ZM+l88uB2ObPOiuFUlgGlK1EZrRG3HkSV8?=
 =?us-ascii?Q?AJtCcy8fUUkmfoi/LWy4FPpS/8Zj7fyTeQiV4ipwNeTnSP0XkzIACVMPQGqZ?=
 =?us-ascii?Q?Njf0nAY0JQj+Pe9XOF+rE+Oxf/RjB0mysH2i4qot?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc482ea9-bca6-42c8-d7e5-08db54e9bdee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:11:49.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQpjq72hjDbiItRh+ZuXUXqQ9nlu0Q9Im/lR2YYDziSyz0/YX8XOr3wR6ZGbJxrKPl8vzLClkd2VpwmdP21gRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

This patch invokes chk_mptcp_info() to check subflows infos of userspace
PM tests and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ac3fa8f0df0f..0e8124290c7a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3164,9 +3164,11 @@ userspace_tests()
 		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows_1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3181,8 +3183,10 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		sleep 1
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows_1
 		userspace_pm_rm_sf 10.0.3.2 20
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3200,14 +3204,17 @@ endpoint_tests()
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
 		kill_tests_wait
 	fi
 
-- 
2.35.3

