Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3ED7B
	for <mptcp@lists.linux.dev>; Sat, 12 Nov 2022 09:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqwZo5mLt3dveY9CmyOZwN5Rf+4uFGaeCUDJGy6hR98C5O/DVYpdbPS3ybBXsSuu5buK03cri7Kw6J09bSjilbZdR/2araKasDZ3EIm8gLP2a+WShTImEtKB8r1Flwj5F5hodp06CpXfS+T0s5pJ+IPzAdskEY4sDoBqC13/7hRE9t9sL3NMj14EcPtj+YXmBoWIIEGx2c5OXrYn42qd6UB/nmD+TYOl710a6FxjEFNDfxGkQJJTs2lFOSLw4nEHcUE1QSDItPlhdeI3/Cr9vUPC2I03dV09v+p1FVc28FN/7AxvSI3Qs38yugmaUw7yH57fblYXaxP3OL4xyeN9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF8ttSRAoDQvzRahf8gtyI/IcjgylmXPSk5Tm/vST5o=;
 b=CzxfNYlnbLB6ZxE9j0gFbM/8yn1fIEjEP0UWu0xOssNKGdhrQVN+1n+avACSGrUYrW5bNXE7BiM1bNM+l+BjPTnJGUOjg7nHFZ+2BmUu6PYN+yvdduYL8Hsi1SgTyEULbzi+G75+QI63M1H8U+PhzZQ/3Fa0VfPIS2CwGx1Rg+Oyf2M95JfGqs3BsHLHAeTA9oqAaBYQbQ9nhCdxxdMC8ejtdQuv9DJEyqgWmBlkscD5FVEoXEMC9hszEt1uRu8yqks2I0k6qnNOf7jGq3ynt5cfZ14r9M1N9LfLFs4lxEgzuLKGYkTLumrOy5W6Z84HUiujQhPKSFTSSj5wLiFVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF8ttSRAoDQvzRahf8gtyI/IcjgylmXPSk5Tm/vST5o=;
 b=e8Z3hPaxLkqqYdLpbFWZxVgX5iZN1rabA2AmAKYg0KaA6eu0an3JZ7ESgWSQbdwbkcCmfYANQcYmRs8MUGqYSXIIJFikQEd+Nl4CqQ1IjqTotyPeb5+wUGOvgbMOto9+RHR6b3UJb8xjPI8BaQqIlXaJOyeEk69QwLNMX3TEdiHwkMSjRA+u66seSi/kqyEjUfu0KPttJBfk0djOAsJVg6YRQWNQ/0z99jj0n+ESc8BeY7LTuloTVaeQmU0lywLXSXpeKIu8eiCL5IyFcJWZ8SRHoUCJagkZmioSW48wCnToQFUEDZ4HImpRuCxHzTmiTZs1KB4I9RnZjzMgCNrEaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 09:28:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Sat, 12 Nov 2022
 09:28:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/3] selftests: mptcp: update userspace pm tests
Date: Sat, 12 Nov 2022 17:28:54 +0800
Message-Id: <420a0f5c5fef3436ef13fbb2c565bd6018ac47e4.1668245254.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668245254.git.geliang.tang@suse.com>
References: <cover.1668245254.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5e954f-ab7c-48d8-676b-08dac49050e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4HR8FQAJGe0ZnOCA+T/7fvc8MDWEM4+AE9HGrvfdn7Ae67wCtU9lEh7ZbYg/CpcNxPNlrsi9mcFUmZAzJGJApxpCSzx/soEqIKoa+vEmgo4BT6zXt8lU2BwUF2rbW+W6mGTMIhv69b+2bLZjn/zTcQtC6Q1Fr4veRkfYU1NAk7B1g81EydZBsMRwM8duPRmOb23ZplEWeFVj7S085g/siHE28dajbESfOvMar5tZL0G8nqkXnISU18rpKFBSz3SjJhRpcdScFdKkZPO869uIO0BbcQj8W2TD5c9kZkRdCcX//N8s/xnO372yXNXVI7KhatLGRu7MdHsVt2BCsGZGmHgRdxGKVQ7TCvVtgfdvmsoMBRbnQ31pfzdVVHp0KaK1IXIRZNF56fAeif5FGcncIJn2HDHYgVdzG/I42RlqP3KmBJ7JU9U6QRtTFJyjmre62ti43VvBT+gAlnhC5IqQvLO5353ML9ggR7ynBe0RFioEAZEfM12kf29+ZO7k9qIjwIN0ZNx0NBuZdP5cgRSyDPMkVG9R4vJIkhdJCdWNaymqnlET/eln8Vsj0gkHIk1gtx2xJHFfycIgjoYhe6BLGcuK9QVLgGlXH7fHuA2KdamH1s9ILBvTXZWnB7H3l2Zd8MG8TbmXkKR7uucX/zXymODtMih2TKP7K+V39KiplraR3hII1E3pT4uAnYhWXNH8HjzvNGRWy1cVq/hsd80UUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(36756003)(26005)(6512007)(38100700002)(83380400001)(186003)(44832011)(6506007)(2616005)(2906002)(66946007)(41300700001)(5660300002)(8676002)(86362001)(66556008)(6486002)(4326008)(478600001)(66476007)(8936002)(316002)(107886003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cag2fnmpLy3SaR3S/I1sFpMD8J5vqMWXBpTxiRohApYwtfdyK9KikN4ORZ8c?=
 =?us-ascii?Q?SatYbu9W9LU487tIyXlGSJwpf7MMSaqZux4P+VNSeO5tonKqq2/4I+qdyqwb?=
 =?us-ascii?Q?k2AxY8J8K9qpWQwk4gdutYG4Kp3wRbn2/ch2M0ZS3nkTBtUBPafa4ZJCjTEF?=
 =?us-ascii?Q?Y1Bmj2NmX/7S4CS3wlmMdC6RNwBAUQ8awIXMFPqUjiLzy0ViRfVWe0FoqfxY?=
 =?us-ascii?Q?Pe09/v3QsqaCXPMZbsx1tto01pCbgIMwwNwbkuLGhS39ZQ3NnRFCgqaRB+wZ?=
 =?us-ascii?Q?99QWMg0IXqacNc+N29vapXqwVsRe+WAOVTHGTUM+PDgaeKiwzlpgyMpvriTN?=
 =?us-ascii?Q?bQluk/P4F/2b3ngoVHj1Cna0DVlHJMEh0oxifDjNBvEuaC1eKHhBkERqPYyv?=
 =?us-ascii?Q?fz1nbjgAuePHLEHTJNBtsLJ9ByEtdJ/2P+tCfpxn/arsQrzu98vCc2cdThyy?=
 =?us-ascii?Q?dh4wN+3sTV06rxE2xk/i7MhFGBhUUDTKngCt4m90929DGGP9e5TraNpNv/t5?=
 =?us-ascii?Q?K/CJlOtsL6hYNZhNCz720nU5JoEAVIC+OyUSo7bFrOgs1xAjSCAfZt6c9y61?=
 =?us-ascii?Q?rM6iisPEgvtnkot/krvOecsMg8SJ9m7YvTMRH8KSj/kwGd7cGX4ngj7LF5cv?=
 =?us-ascii?Q?NdaaEOiD+YoX2zaNY46UAVz9z7rJedfd5ZOxTkYViJhYE9NsPgJf+cNnPMQU?=
 =?us-ascii?Q?LIgat3WSzW2oviVciJ2qMrhhcR1HQFYcRferjx6kYaWNJANEA6EwjaxzfZG1?=
 =?us-ascii?Q?ltFdq5Py5TPeN3JE6CCJMRG+Y8R+p73xhZyLD21KE+TFe0NQMUWNPv6jUCGd?=
 =?us-ascii?Q?R3Dy03Qw+FlMj7U+nLGl9AiLQfmyKBHWRzajyZdRBSbM8mjco/XPyw9AZPX0?=
 =?us-ascii?Q?+0Fu041UsRh8NCHU/yMB/RaW93v/hbf85z3Rhr3N0srNOG+IFzdYf4iGaKgs?=
 =?us-ascii?Q?PvvwO4AzPI//Uy0QxHXlLtHvGs4tKDgmqq8BlZ75Tul9RMaAXG3RQXrVHy3C?=
 =?us-ascii?Q?UGgNxUiboT1/8eSXWhRkc4MwZGRz+uJ5aRZhipTxP72U0PvyiTsMAq2Kpyjz?=
 =?us-ascii?Q?Qv2TDlxqZfjs4oAzOY4jYt1BQfKB0SXJfE6NSNp+xuQ3F3fDlD2j9LpZ7J3x?=
 =?us-ascii?Q?gjjnZkKBTgdPbk/jx89yph7pSa8rbWZ7kmHVPDafH/Cv/G+w+lNSwMQELXKQ?=
 =?us-ascii?Q?cyObK7/7GtbPLVYZXcSoB0aiRw7xAOv/hS2DEtSzPmdRIXSt+RUtGn0HMBL4?=
 =?us-ascii?Q?VSTrKgs6N9qsnwqrvzD+LygjmvP9NYZjsX/cWDv3FuMkA7trKXtSfdrLwXUG?=
 =?us-ascii?Q?euYN3eePE578U7yDzqR3mgoOkO7TqEuFpCtWuT606jccN1ojitorhcw9HwXG?=
 =?us-ascii?Q?cPBtemqWkUNhkubAqhsdznmMhu92aaUeGu3xUYX6fZ7PRa1AJ5DxIiH+W3mc?=
 =?us-ascii?Q?qxEOKNRSbapwvW3c4mviZGxh6vZFJuB/wv+yQZ/EjdWuAirRZzhVpOcSDw0s?=
 =?us-ascii?Q?tLFDfha7v7Jnb1XtITju/xQ0fchuI9g44wqz0n/C8Pd2iWnUi5pbQxXrIawt?=
 =?us-ascii?Q?f8phyKmK8w6s6dWjjwGiHWgYzlzDkOf0ysA1WO1bGZJ6T6ETuD1cJFkhAKV3?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5e954f-ab7c-48d8-676b-08dac49050e6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 09:28:54.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Pq8dfmI5tAY3vCJffN8Ob+hKSfvqrqVQl6jh1Em30z/XeX4oG00rR8lAITreOpKQKb74h5TcrGyif8T/P9I9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985

Some userspace pm tests failed since pm listener events have been added.
Fix them.

patch 3 in "add pm listener events" series.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 3 ++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2a402b3b771f..f10ef65a7009 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -830,7 +830,8 @@ do_transfer()
 			if [ $userspace_pm -eq 0 ]; then
 				pm_nl_add_endpoint $ns1 $addr flags signal
 			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
+				tk=$(grep "type:1," "$evts_ns1" |
+				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 5dfc3ee74b98..08a88ea47a29 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -172,9 +172,10 @@ make_connection()
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
 	kill_wait $server_evts_pid
-	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
-	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
-				      "$server_evts")
+	server_token=$(grep "type:1," "$server_evts" |
+		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	server_serverside=$(grep "type:1," "$server_evts" |
+			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
 	rm -f "$client_evts" "$server_evts" "$file"
 
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-- 
2.35.3

