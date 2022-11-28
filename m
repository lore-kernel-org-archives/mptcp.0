Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7A2104
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 09:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4jc/Y1CwZM5bOYcjXLDTG+b70AXKnzzIDe4E1gMBgCmbBXgogWZvXApCBu3SoEDPkrDYqsdfbDnNSBJ8M+i49L3l6dfq+bRRkt43gEky7A9h8GGvGNP9WldcMeN5RTyW+sTysxNjUilpyxytIzbeziV6SX4G5Cj2CuHPzl2xlCr+P+lhOZiaaRcaXHEiOc596k1bzQdFPT/u4R8JRcrpFNC4pxDhhIfpN95c3t7UOQJf189Mqkx+C56eLIJN9cqiKqIDGaw4vlpLcu4j86IJkjcp7y7mmimAYpzVyMeg+hvApFTM3LitytEcnUrq4ssvDKvJ2/Cf5gih2scLab5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2j+6c9eI8DTWWq7BDPuH+SI2nXR8UNxmpEcMmkFCA0=;
 b=DjGGAIdqGZY/gNWHLH5Ty7hIIpZljHyJiRrR7bqQiJcU6iZhsRWjFQx2xIgm4hCHde7k1adtTnD5xPNGFQurfE6sAtHjmV/WOX1T3PO1U+4ZsxYpUw62B0MasF7O2NHfFqI72E5gXOu5RxpYnUdn/MfuDlZCFAZfidlcoFWvufAFZkYAP4dFQOpAn/F8US5xcOg3d7tw3kvSmUlRlK+pTE0f07oPF1v+WLscz8N3UtfybkOQ2hYxY8JJbxucIKxLVCiZB8ZDLtEbWvZJcX9Rb0H8ttqWp+1ECfKeGFOskYlZQ01w7f/iFuEGA6r+e6sqI5rVCiLx9xTVr/uL4sVtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2j+6c9eI8DTWWq7BDPuH+SI2nXR8UNxmpEcMmkFCA0=;
 b=knJ75AClfY9Az57bvPQJwyuboJDK9zFrpB+YXigL/WiIiOi9UkOdStKD7cPay0R7d6/xYAkX08mmBoASh7b64UQ92kDIyV4jqmmlF0tN6MlxozAcW6HUQSeAN0LZW4h4aK0xAG2bRMqejOy8SliNNVmCoH/hkGcwKANB4wqxt7sIH8BWJbelgyrml9dRlL2J6MpPDQr/dseS2qxK60LiYLLgXL6TUaXQwuFb9VBd59DY0RVvDV/49IXlDwqJIFPYRcGKUTTu4k7457g5cL2YgGsN0LTq+bagdprtBQFBvMp1ePteU5wVn4FoTXCO5K5jVkqZ1tsVIjYx73odhNINCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8636.eurprd04.prod.outlook.com (2603:10a6:20b:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 09:00:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 09:00:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: make evts global in userspace_pm, v3"
Date: Mon, 28 Nov 2022 17:00:48 +0800
Message-Id: <20221128090048.15799-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: ee625c1e-319c-42cf-fea1-08dad11ef8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c/NBiloE+GXG81n8+YlV6Sc7iwaqbHhFOroNFMtSyPFLrA6/Z/IXR9o8vUkHk9ufIcjhKfbZ4OI8keFvz52zU30H470tmcGF8q0BMrcsMGqAjYL186TF49Gaa41zlKmZdKEslrJkcvVRyYeimWF8pMG1SUGjC7u5smacP40975vYC6BEmypYIVCMM6p1plqBg4serqnCEvU8PIOsHEj/o9vC/mfquPp8Q8wUYqPAmfO64nQr76Q6pq+lmvh89jDaI1UIOvCxURqwykuAPCG7BEJ77wtamEeKMUNuSa1Ut68a9ImSCjci67+tnqAju4SwWn9+Pxmf9b2Y1rjA3rkWn2gpWDO5Bsjn8IctNZGVtYweXipJOPXj0RZtjBRI7rhj9T9RhwvdQNOI3pMVp+P7fzHohNiTBe/uvjopPrMUSAeNqWVJSI/LJCEAxk2HPR6TYy/Yvi0XXmq++NwOf3Z//fWrLjWXCLXlZaF6etof+Ti5zPMYXq80Zp2lil00EBBWbVD870B/B6fqdqJ/1BUUDx6Z4axJEWQ2Dv3pr1ZWNt7Q3HFuPSaJOVoP66u+9ApJwdj7qna58CyU2T2ex3KM4gaagApZdFPTtWV3he2J9kmeLFa7wtGpzsQxnWvcQpAuRNTIN32VOep6YLo0pKfNlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(54906003)(6916009)(83380400001)(1076003)(316002)(8676002)(4326008)(86362001)(44832011)(2906002)(8936002)(66476007)(5660300002)(41300700001)(66556008)(66946007)(2616005)(186003)(38100700002)(6486002)(6666004)(36756003)(478600001)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e4Hl4Xkb6MhGowPPknLxtwMmZonLQRAD3hJ9b3pFdRc2zBCblvO3l+/pmduh?=
 =?us-ascii?Q?QJQwTZ4la+T+CIpkj6tf22MNfAPT7E+rCOYxyj5DZSHyvktH+lq7fxXXtf6S?=
 =?us-ascii?Q?Pj6HLMeofH1+W0zeRb+R/nZ72KqKiHpZnLno+W9mD+3xk5RPcdu/oaKefuRB?=
 =?us-ascii?Q?4QyA/QbfRvIZru72/xeRs0R7bduQSknzc9kCY5JN8Pfl3Cffq1ZDJEVDKZy8?=
 =?us-ascii?Q?E0MGdpEIQRdxFC6OnRocp7AWJFvseyLZGhFZnE/8Shxf7TGSdkgNdLxMxxX1?=
 =?us-ascii?Q?CRiecu0slvpNdCxRmpdWtu0KskQ3ArW+UZNZwWcUCpR1c0DlwRYa2pK4lRav?=
 =?us-ascii?Q?yCiHgRmpSqLO6k5c8NYr1kiZX60pMEH5Y2eeAttH7TpBMVNPqhvBqlOJompJ?=
 =?us-ascii?Q?+M/tdjFSdzcRYbtMxQaa/T7fBhbNUaxH4FDJOrWA6HO2LhDszjCSe1tqG5yq?=
 =?us-ascii?Q?/1GG2cUrLEN3y0ZluL6gzAgbWeEGVGUVrEJvQd71RXNMMY7e1NC3kGGqcBAi?=
 =?us-ascii?Q?Lm0CXT8baIxnEhvNQ7tl6LN++XLcKxANta4b8UZcOcn+HtcvuxeW0bhAaiD2?=
 =?us-ascii?Q?gikzgSFgkU5grHEFdqc5C2260g0zatq2Oq5cvbxyLDalYNyenNuMkPordQHW?=
 =?us-ascii?Q?/+tw6mJzQEYQfaNEipd8Xp368JYLrKwKPtgp35Gy+P84I4ctOTCdKOCBtbRr?=
 =?us-ascii?Q?Y4GqE717jhw6l0QfQJ3he4SREIKdz6hmF/CTFheaVUmANtOIIhRXkhWkZOlR?=
 =?us-ascii?Q?xh/VdQ/rIYochoKqRWw1NqtgYWX0iH5DmMkYFlA5bbfODNVE9EVuadv8NtA3?=
 =?us-ascii?Q?+SqBPSoLzBR3xCjtxKD9WkjkwP5FRnjkQPyRGbAnJWYkBLcF8vYfuBkxwhGa?=
 =?us-ascii?Q?g9OroqGHfurGB+gFAkDpomYRy3RRHbNocB3t6r9Db4MbbfqxgMWSzOlGxgm5?=
 =?us-ascii?Q?Z1g4uaDIhnGZkLQNHFKU1UHHVSv0sfg6zMX0Z3iHJ/vbjsbj6QXerFhw+Bn2?=
 =?us-ascii?Q?vgQM9lXmQN1NtiOnXY5zrokvWejV4U8ISap7G6CZ7LVsAxo4kRr60B12XeZX?=
 =?us-ascii?Q?owpZHLbbNTfKOHalBmtgpxhUeKG+idtJLmgXMj5YdTht16bYMIhaEJsKQNHO?=
 =?us-ascii?Q?zNulzn2s9ceT5ZM3v6nbhweGHUuc34ZQu99nKqvXb2DdoxmHrpPrUHcRhu+m?=
 =?us-ascii?Q?TOi5x/+u/JflXDyCCF12/M9sCij6rXvXnA2QGcGgRWJvIgBCbe2A9XlkWXDI?=
 =?us-ascii?Q?qsGUh2OOcA9MNK65hA/6qRHZn/k5CC8xtW+AZXTgoKLztzRyp00lA5m5Zlh9?=
 =?us-ascii?Q?uepjK6Pdn+FsM17FZ3yiG0jRpcE22BmKQV1G9iEKy0nxv+mCLsRM2qrQe9OU?=
 =?us-ascii?Q?5WOWSNuJMXG337i/NlTJ4piVsc/dle+gYIyoJrWDE2/cjoaoihg1KaxCgYrs?=
 =?us-ascii?Q?7jbF8+NCUUaiKI6UnhdURhHp2QVKGS/KOeHc2uQL8mi+YzaboyVtoJ2BOfh2?=
 =?us-ascii?Q?eHD+Z7y4mwIyMtZ/PkDZ5oyrdaTGo1E+0kUzrPhcsUR7undFAjuJoj/wz1Fy?=
 =?us-ascii?Q?JhdmI2jKRL3N2FIH8EBYd36/Au0AgTp/qm5qk6b8ipmt/YoNdHU2qUGWIsEC?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee625c1e-319c-42cf-fea1-08dad11ef8b6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 09:00:17.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ksualkvn5fv0fq5X/HHbscb4o+pec64YFShmi5+SUN/Gy4Lw8HPT7HVNULHeFnx9VRZUblUWcpq6cL0kG+of1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8636

Please update the commit log:

'''

This patch makes server_evts and client_evts global in userspace_pm.sh,
then these two variables could be used in test_announce(), test_remove()
and test_subflows(). The local variable 'evts' in these three functions
then could be dropped.

Also move local variable 'file' as a global one.

'''

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f21da6119ad8..009b9d466e4b 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -17,6 +17,7 @@ LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 AF_INET=2
 AF_INET6=10
 
+file=""
 server_evts=""
 client_evts=""
 server_evts_pid=0
@@ -52,7 +53,7 @@ cleanup()
 {
 	echo "cleanup"
 
-	rm -f "$client_evts" "$server_evts" "$file"
+	rm -rf $file $client_evts $server_evts
 
 	# Terminate the MPTCP connection and related processes
 	if [ $client4_pid -ne 0 ]; then
@@ -121,8 +122,9 @@ make_file()
 
 make_connection()
 {
-	local file
-	file=$(mktemp)
+	if [ -z "$file" ]; then
+		file=$(mktemp)
+	fi
 	make_file "$file" "client"
 
 	local is_v6=$1
@@ -190,7 +192,6 @@ make_connection()
 		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 	server_serverside=$(grep "type:1," "$server_evts" |
 			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
-	rm -f "$file"
 
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
 		   [ "$server_serverside" = 1 ]
-- 
2.35.3

