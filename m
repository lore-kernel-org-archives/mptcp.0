Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D291FBA
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiTniojwvhrhBBXnH+kt5FHZoCRc66mbRSWCkTynQiIymIPbVUh5LpFfxRqcT9MuXsLrTHRTC7siuAQHfCHLVnToUyPWf4hjY34rbKceY6hJiIZDmUh10gFls4U0CW3tZMbWhJHRTXARsGuG2kwxUlBQNR2UwpdbNmOHQ20bi2OCB/5YOoRt5lLD/nN2iB6xnJi/3mhUngHNyAtFdQkNmYiFA9Ft/dx8l1WrAMweMyDl+AY40uG9f9Pfv0xdE5s8pwKZL656GQNjqRUH/L1RIEaFSsAj9qD84OD17p/1EiTsk6q77OIhJB/g+PrvxjBXQtNaicybVQfSFjKubZHePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJJ/4yR8RJ0esNj479hHrCkEpVfezBSWk5xUe1z6Kfo=;
 b=gmbZ6UjH7n939KkNCsz7eX3WSsToGRzL5YZmIdHyKZUySrufuf5q+91LbE0qvH4Q/vDLVXEbZ0Ya/E/qPhHZJZ30aAxiXLypBcwmEyQ7XNaMvU01PqOGm3iatzDrkAlRO26PIx/4SqMMcuL7IHDXw6bLjAIuDyG6wG6kRze8T+4uU8TzH0gNF9S+OizQM3LJcC11lNSrLYb0ZM8T2fj9KrFwM5olTLt4CZpJIVZFzn+SneznSBpfFnlL/DUoPFGdM18TzmeJ5MiHXpmM3TxVLjc23pGGXOam1UlG+NvnEpV1dPfoIWXCw/LJXWyzsvsq0vYsttrdTn2tnuaO+oSBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJJ/4yR8RJ0esNj479hHrCkEpVfezBSWk5xUe1z6Kfo=;
 b=AebiK0C5hnOlACZyokXa5GynObDbZPqS/1eS7jfBb0uH88DvYjqZNH6eYblGgr8U/89XpE19D06VG4JgY8AYsepeWLnb9WHRqTa9x4TONNOfdbLkep8PNuKvvPcufjAIUFoD+a2TJdqUtPVifqdPMaWE6wSXRiW+albP+6pS/DMw4CCw/183czkK5QZVXWWZf9WmX5HwFt8mjDs1wLzuo0GXEOHJT5SwXVpLq19MtKBjDRCIhkvkMmiT2/6jeaniyohX/X3wvdGS6KsPzYfsdgY5R8qykNPOz/IRzNvgpIIWvBt9aIpDGjYg/YvMu3UFygGrXznFbNrKJySnvhM8eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:59:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 08:59:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 5/7] selftests: mptcp: check add_addr infos
Date: Wed, 31 May 2023 16:58:54 +0800
Message-Id: <84841f847f4568ba725f38b3a0ea40d5c0bf4d36.1685523463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685523463.git.geliang.tang@suse.com>
References: <cover.1685523463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 5099658d-b7d9-4218-eed2-08db61b55f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/uixKs4XF3ZjIM7NoHDB3usLV8mxMxb4J9yU5AIdYgKWbCYJD1rClFQPgLjEZ5lcGWQfVNunqzBdpriU1pn9h7rMHwo5cN3iVJBbK4dMR+70aN/KQmW5aP3Meqd+cPFIPEr5TKepSsqCovLRBkUg0a9RJwOqj2c2t5bZyOeFG+kXl/2qCJM3fhagUZxjFm+uXiH58SGG1WWeAG3Vf7mRM4LY6k0h/2X9Oq1Aa+iOeeA6W+GAHLr3D+EqPgYlnokXTlfZ4nhWRo2xwROpcJpkWHuVsDLtURs17ZFQ3sXstCXH5Zw3Yq2Yzw08roaXHEjy6htmPsT+Y3tPL7Ncyr8m5RjJQGehLkAT5NyiaKc8HePUipVKkjft0SRiNvWkShBZ+c2owvadHolxiGjCRaH6UFQiRy3kkSNV1ldLkpbJnQFV6A6g7NEfugrjSIFIdOEgDheEIL27zVgNr+fUI++5jk7IOaBhNrdW6T5S9i7WTOjN9pqCne7pnIwQKqFYwxM054WdbEgk/Gs4qGmi9hySxqJmZArcfDJl8chqvXPoFjuNCYSc19FQmNW5KZDQTsDD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(107886003)(2616005)(38100700002)(186003)(41300700001)(83380400001)(26005)(6506007)(6486002)(6512007)(6666004)(478600001)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(66556008)(8676002)(8936002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KunDQkXPD8OWBDDdktucj7/Q0Cp7TXF8Wh67LHxKtRitOc5LfwipPJnqi904?=
 =?us-ascii?Q?sgl1DkhHD/ohWYE5tUtPvg5V+zWyC7lJ6wiWfz+ieP9jmTMpimCTH+GHjKeR?=
 =?us-ascii?Q?+T3pvLykur0LY5TcAbqp+v4k0gElTiBvL8zv0nQCfOcwL3jVfKbBUcKLE3CS?=
 =?us-ascii?Q?r5rCBn1T6LPAaSuNHh1vvb8T6HX0Zc32Y8YZPIgSVp5igGiMMtUIfEyvKEHY?=
 =?us-ascii?Q?eR2kodHVKbeBbvGKFFuNTZexfPwVzQnOhz8mMT7mWTsc9c/0/HBHdnPl14Tf?=
 =?us-ascii?Q?zgEzGy0uKE7rOt6YTbcemDbiWrZnzXtLr0uwlMkcqMXsrcKmVSpTxWMyh5Au?=
 =?us-ascii?Q?4cHQ+OMoctiC0xlu2EPlQSasqs8Y9GpgwZzz6BkZwdZ2KJ8POWmIyPCpIuki?=
 =?us-ascii?Q?0pEzXakk366+9Yy9Fb8le1UoUj2dZvmljWikgSIS3Z++EwWBTPyaNmgd0muD?=
 =?us-ascii?Q?mgZzjv05PIx5LrWv9yl2helg4Jd3YVMWR6ocY27GaBuus+3SMCVYB3oJ9QdS?=
 =?us-ascii?Q?VI/L94z6lCjZQXRJG3N39VutRleUivpq0/0T5W1GumDyZQm6B182J7B9K4Cw?=
 =?us-ascii?Q?a+uIKI7LtJ6Sl6Frfat6FfrEfbeIKeP5sVag8M3c4UqDh3tou33a5kWf/Fef?=
 =?us-ascii?Q?u33W+wNq3Lqj3VMJZHY4hg7EkYWI5K44w/ikFA+Ubq/hLpid1Htftz26I0Hd?=
 =?us-ascii?Q?Ww/HAoJ+ZDcKQLK5vRNvy9t1jU/RllBLqBslJu3PPYS6SRBWdD9oF9mnLrxE?=
 =?us-ascii?Q?lRVYRUXsGqrn4JLpflHL6qDZQuhpIwYLXEzZmD/5qoWq8BvLPmu+ahxtYDhz?=
 =?us-ascii?Q?BFS9BowFfhgTtIlgJGUVQO3fHjvI/4vKXGVPVmHpeGoAV5PM0QgSa1PhP5+T?=
 =?us-ascii?Q?xOBJGFucoaE18hUV6o3kQ/Y5mhTyLsFKBzlxt6Qh1ol1PIQ1pkDYZNm+gmS4?=
 =?us-ascii?Q?L+sue4lQOZlvp5rL3AsrvmXoKuTI4zpIRwum7UKGteZ2kRwzRuRWiG4B3W1Z?=
 =?us-ascii?Q?a1B4VZAvM/Z6neHEDIdswE+7SK4/V+jpTL2Lyw0udzGYZfC3W8RfnMyVMRlr?=
 =?us-ascii?Q?FFaZSatcVAJWVF2p8szufjyToz2c0vES2IaVZC/whBfYBl0wauzYJwyAdxW1?=
 =?us-ascii?Q?1fU78a4cK6JaifSbk3WHdK88eV5MIm0DCVrXiuXXP6c32A0AGfpJgiFxqvx1?=
 =?us-ascii?Q?YkVA63qVLo5IgGat26iZQVsgBW1wrgRp+JutRBsyD8DPM0VqVTmC+mdfGm+P?=
 =?us-ascii?Q?1hDUBEEeMZeS2gVp57nNQjmWHt7sPtr7IKgbaCaFpCWigMrUXmb6T0JgVLgV?=
 =?us-ascii?Q?QmODnq0ujYWY3zDbPRSBS5JWqw4km0/P+TWXhl20Y28xcs7s8ONA7Yeyn9uG?=
 =?us-ascii?Q?PCX6WMf5ONPNiHb5XQEVnRhHsmIBoRFfRWsnIPmOYVU5StA8aizsCqCOoBdE?=
 =?us-ascii?Q?0xymNB89ldsMUUdmakBWAZ8TwSwLy27J8XXvpfWhowGirvy+nfvD0IomWtda?=
 =?us-ascii?Q?H4EgLiNGlbCARYtGMfIRNA0XlD6l0NbY3F4HDqHJqy+/VMzqB7N+vGfgdAah?=
 =?us-ascii?Q?a4k8vE5ubPKQLVJwwP3YFTrx916KC99SItquEeB1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5099658d-b7d9-4218-eed2-08db61b55f5d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:59:42.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VlZxpyHhiVaQiHw4brOuOd5k0jYXKNVcFejI+8prTsYc5Q8n2fSf0Rq5NQ+mixnRak7mMFmtaqAdCT/Lb+pKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902

This patch checks add_addr_signal and add_addr_accepted in
chk_mptcp_info(), and do this checks in userspace_tests()
and endpoint_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 75f1c69ae78b..60cdc36d280f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1816,13 +1816,17 @@ chk_subflow_nr()
 chk_mptcp_info()
 {
 	local nr_info=$1
-	local info
-	local cnt1
-	local cnt2
+	local info1 info2
+	local cnt1 cnt2
 	local dump_stats
 
 	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
+		info1="subflows"
+		info2="subflows"
+		nr_info=${nr_info:9}
+	elif [[ $nr_info = "add_addr_"* ]]; then
+		info1="add_addr_signal"
+		info2="add_addr_accepted"
 		nr_info=${nr_info:9}
 	else
 		echo "[fail] unsupported argument: $nr_info"
@@ -1830,16 +1834,16 @@ chk_mptcp_info()
 		return 1
 	fi
 
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr_info"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
+		sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
+		sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt2" ] && cnt2=0
 	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr_info"
 		fail_test
 		dump_stats=1
 	else
@@ -3313,6 +3317,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
@@ -3356,6 +3361,7 @@ endpoint_tests()
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
-- 
2.35.3

