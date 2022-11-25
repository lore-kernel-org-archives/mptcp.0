Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D333DC
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 13:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYBlu22uvFb2WwDM4/B9QUCIK09wqjYlMRseFzdcujG4Ciwr/lhBDu0T3J34ogYmfKEMdvq69IsAiBzWKrlagV61h6mLh9p8eDoKnlsXiKnpEF31nkZcSlxTUrusALma64TvN6CJWDJG2ozxhHxLgwsQD4OrhM+Y7SPEaXBnolxxVZp9+QqPK1qd6oLSVCd+P3HfqKk1tCLsqTkB2D0IL+5eOVv5H3TPk1qpdZr1KqcKpJ28kjeQh13mmdUOUf4aMKJGyPWxEwBUHl9tCpLvlE7ZGtafCSKLuHJ3jK+1sB3+YsEYwRs7duOV/Xu+U26Id7jIroPXDwt/x1j3sHpzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/IncbtFLQu7vLDdzRAa6Y/GtCGqGshgGMergICxoS0=;
 b=YjCq5eKJ5GkxGZJjYBiKjqaUHFCgV2gLoawQQwMfiCUIJ1ifFkcU4tOfyFXo7tc0v7a8Ls6AkRi0rao8zxDdgRswR05Rm/SQ+d6vr5HgUqSR5E57bIpKCZ2mqkEZFxRP8f2sGU/HG57Tf0s/EdhbXCnoP6VJsexsYuw5/TXeQaTv/i9wPuF8snNP0qzapWBV5moab0ZA8NC9m3V4mh4HgIGbvges7O7pWCQTbnd7mWPxsOQzOA+ZOf1DZIAKXkZc9oUWReecaRr46fwjXfE0DbLeg9AausVWQAok2h8IRf7BAFNNelRlRx8vagANy/MVdUVUNtXmTGnK+FrC1KLO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/IncbtFLQu7vLDdzRAa6Y/GtCGqGshgGMergICxoS0=;
 b=NzulIPcdXzLU3JaKav9sQ36QfGA7NEJnjAO1g9ML1xvLbfwddhjwYQRKcVz+iyPrYJoWHIXgaQziDc0a/iX3dAGbbFgMEi1OdXNlOXMr7esVMojGrhgunuAq/0B2s83KixQLcTU3AL6ynAXlpi9CSz6mrx+6wdWjwwaF0a8FsUe36c7hIb/H/aF6KqxKUz3iAAnez33R5KgWC9Sawerhptq1DeA57Y3B6Q8d2WK6jCnUEFmorr4Lf2UR9wz4JyvSRqG/dXSL9koxnkTsbZJIKPhC63S3ckY3EmGIXUxWcQIHU74+7uSQrzh6ydOWsIt19sOCKqi1WCR/MxmJSg9Ozg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Fri, 25 Nov
 2022 13:40:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 13:40:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/4] Squash to "selftests: mptcp: listener test for in-kernel PM"
Date: Fri, 25 Nov 2022 21:40:49 +0800
Message-Id: <ce000e27b0b132ca060b08db392c0ed5ddc39139.1669383374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669383374.git.geliang.tang@suse.com>
References: <cover.1669383374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 10130a84-9cf6-4853-65ee-08daceeaa8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	14s2QPz5khkwtbkkoEEdWKrGaJp9EnnRwypuBWH7Hanfjn4XY6y83why/Z5RrT0UTgIZp5iH+Ts+jA2VFqVZhzXyWQeklrpEDJOgo/f2vbsh4Cr624RaGkbO7H9PJLL0OVGffmxQ8LJGqbydTxdcQ2d1wq/ikv1+fAxcOllrE5k8dbnjGl1a6tUsvQtmvFTesQKu5tWtNBk+UEVAlJAPnNbNBCaXj69laVq5Ny16w+FFvpbmlchj1iZUvKNVZ9myYMFHVEL1kfXF+rA/qylxGyBh1FlCbYbNutqXXL3d8Ysx4BsXGUlCzhzXuGy/qUZRqoE6zTkfVPID6yGzNTtttOlmAKrq5JgANFwnI0sCL2toOAH0xvYh4HP16HuYL0Caw29aorrDxeeBr149WPIGNCDt6r4lzpE38q3sO5xq17WIQ89A/HagndoHY7MRhLta6K/nOuNv1FSJ2UEWhdupkUiF29ww903P3Q0bl9PfvH4HrPnqyIVftjfiKuU57Bm5AA1EWcbR7VeNswLly/34qMPFx234lzT3HLbCA5lf0kymRZBn0lro0TpDVEPNKwsn4M5I3N4GEIVZ+IvoFwX/1ozbk92HBfEJb/WZXVNNqhRbGgrlAQyBkYFNhM4Edwu7/dr4VqNtxxH0KD1Gv68paw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(66946007)(66556008)(186003)(38100700002)(41300700001)(2616005)(66476007)(86362001)(44832011)(5660300002)(4326008)(8676002)(6486002)(6512007)(316002)(26005)(478600001)(6916009)(6506007)(36756003)(8936002)(107886003)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGnH8qlueT10wOArNy2Xxe4Au7lXPk/RNuO21mHHyXrRIWBcVzckz8lDPTYA?=
 =?us-ascii?Q?DYAXO0uBHG54yaETYkx62E2ObbE+NmV+qZSPLI0lJ+R/4iEa7cnT5t6Zb7TL?=
 =?us-ascii?Q?TYa4fXb3qyBNvcmx8oA3l8z9id6tqZG9qTlTbGdvWmUxd1LFD6afo3SfbQBW?=
 =?us-ascii?Q?7ohW98A6zJkD0PYvkJUMKORfFDMvXJguUcvuM9geJY1cpS8ujUYS8Fh0R1GP?=
 =?us-ascii?Q?yCie/QMWSSTive1CIs1ZLzerN+DSetQ2J5PfZ6crieM1dlJcXrTWT3zPzgx5?=
 =?us-ascii?Q?8WKdkKbfatUpAg1oWaxsdvA/jSvMasq2BX9HJLLe1Nk3xa4F7mfSbJCU+79h?=
 =?us-ascii?Q?c8ciuPep9jC46V5FipR3YKJdvRF/d27AEeGUdq+hJmvJNy+853bHSA77hq93?=
 =?us-ascii?Q?b8miUKbeTSgZ4IURoVzm+ywbgWHjjNkWGJJlzaK3uvhPyQdeXgA8cu5B2/S+?=
 =?us-ascii?Q?96MjJ4Bc1MFQP4S8Fj4DQjtia1ejuBElUMrZjmQBbrV7VdOL557iSqqmQMb+?=
 =?us-ascii?Q?uPNk8yapZPzFZmy112LuhFrvLRUd26q5LujgHde6r32bAMNPqI0QjW786FI8?=
 =?us-ascii?Q?CPcrLveWoP45y0oXQS0nawL9nFjbXfPWud3MJRl8pGYfnzQQAySkqSauE3VM?=
 =?us-ascii?Q?B5kKPx0koyY19/wNuLmUqchWwyX8coJF5U68zySExDay74yZC2596Ki/4cSC?=
 =?us-ascii?Q?ymQdSHfQwagRWj6/GNfJPAf+Emhn9jwKiwDvr7c7dd0zpDfpvClj9lK2+ZyS?=
 =?us-ascii?Q?ThRAY9WJznOn/EAl1kgNQQvcmfIsNytLzK1r1FiF4aRmpneDTF4Rm1nPf/BS?=
 =?us-ascii?Q?Hdizn8UksLqZl6Fgq1mK5Q1pwNPKBdXL1S7eDoW2LbAQ4nwMepmX5Zf7is8J?=
 =?us-ascii?Q?S/WkYMLakjhDTGhEBCvmEENdzIwFvgjOVruNcYcwzegOwTMd67g6g2JXQxN2?=
 =?us-ascii?Q?nmwoS1eEx9sTOpa0BOsR1tyTOfaDO/bmw39XCzx/afdnNz0JDkaoem2V8SIk?=
 =?us-ascii?Q?aZp0ABcVvVgQLkLd+V3gN76m8gmESV2EoxJNIsj1GyuOwfuesk9ldH3nNgjF?=
 =?us-ascii?Q?3MWm5WWA5gorfHe4VRaQTZvrvBRMeFnvjC8HpLNDO7A+as3O7wb9AUieA7gv?=
 =?us-ascii?Q?yhr2Wq4l+SeS+iRDsjWn6OfWRtjOWs0pDJ4fztyvv2eapzsNCWLfSi450RsY?=
 =?us-ascii?Q?OIGstpWw0bZJUFiXhyuRa7pu9zl5P8Txbz7o0sZQWC21032pqTzXkw/a9tcj?=
 =?us-ascii?Q?LD9oz/2yNw/BdfVMLSLG98PkGWpb+9PadseCToPM4+0xsj0LLmWS3MUPnP7k?=
 =?us-ascii?Q?UUZrbusfZrNL6Gt2KJvtQs3HiTMfKjYjYpnmXuhK5xfnnltld4vUWLBctrNL?=
 =?us-ascii?Q?5F5DOAvd9Aq5iG47+TOfSWJQaBa5Y7bSVhzSPMu43PQlpBn+1vbHfOA3R5+9?=
 =?us-ascii?Q?YHrmqRzDKkFhSJTpTzQAY35E77w+dIByfcoGY58uIIzWi0qcEzzQKezqlDzS?=
 =?us-ascii?Q?hcyRkGcZ/sx5XZmxist57rFIa1ik2QJFmoK/JmkJme8suDlcPv2xHr9PhYMi?=
 =?us-ascii?Q?3R7slNzsybkIFSsBUnBItfgW1qKnbpeQPEa3ypir7FObJ2XRLg1qa5MYN1fR?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10130a84-9cf6-4853-65ee-08daceeaa8fc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 13:40:48.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtKUOcJmCoqOHtegHArYK1voaUBE8utdc699uRaybtTms9nJNUeHELvk5QbPdwy22gDsZ1+dDxrjsfUPf59VmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

Do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f568c71884c7..168426798971 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2553,7 +2553,7 @@ verify_listener_events()
 		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
 	sport=$(grep "type:$e_type," $evt |
 		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	if [ $family = $AF_INET6 ]; then
+	if [ $family ] && [ $family = $AF_INET6 ]; then
 		saddr=$(grep "type:$e_type," $evt |
 			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
@@ -2561,11 +2561,14 @@ verify_listener_events()
 			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
-	if [ $type = $e_type ] && [ $family = $e_family ] &&
-	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+	if [ $type ] && [ $type = $e_type ] &&
+	   [ $family ] && [ $family = $e_family ] &&
+	   [ $saddr ] && [ $saddr = $e_saddr ] &&
+	   [ $sport ] && [ $sport = $e_sport ]; then
 		stdbuf -o0 -e0 printf "[ ok ]\n"
 		return 0
 	fi
+	fail_test
 	stdbuf -o0 -e0 printf "[fail]\n"
 }
 
@@ -2594,15 +2597,7 @@ add_addr_ports_tests()
 
 	# single address with port, remove
 	# pm listener events
-	if reset "remove single address with port"; then
-		local evts
-		local pid
-
-		evts=$(mktemp)
-		:> $evts
-		ip netns exec $ns1 ./pm_nl_ctl events >> $evts 2>&1 &
-		pid=$!
-
+	if reset_with_events "remove single address with port"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
@@ -2611,10 +2606,8 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
-		kill_wait $pid
-		rm -rf $evts
+		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
 	fi
 
 	# subflow and signal with port, remove
-- 
2.35.3

