Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470933DC
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 13:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdTxJCX5tLO2+VMj3kb4c9IjqvSpXj9LI7TZgVAFHkVbVnQdoVzcJflpRIxWUw+8JzMnOCcgsJITKTal2utfUM2AvjLOdf7/2QvenBu/kz3TkNWw7/bN8XQ/TGTSq/YVnSrcgxonIj+p+QFebYHdXQH0b+XsPGBDu+u/veoDLVCxMYClrqKVFPtzSIB5SpoR1RG+tFxyIgHe/ts63mPIaUjIRvHnlVIAoNi9N9dSKV4ecUdh2XOMsPxdLl4NqPAr6KRKhm0Ek5ULR31Uk2sfzryzAfDQtliuCHrHd7oAoJGFJjgXY1VTzGcGsLf99ujrcFrxsE3u3ThsrV4ii0efjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBLyMu/c7Sp1bcBRjuTB2jdFKaviwk58/F/YWfXCQsg=;
 b=Fhs1GeaSoPNCvROF+agF1PxDNTgNQkFMkxcEUMExoG6Ou0CKG/gdWXIGlUuZYF5/AeJle8tL1WUxEXd0VnEizXLv9s+JZ6l3ZqOi4EkOkZCBCBmNP1Mz/0FbzF4JHQZWVMnrrRaFt6RXt0ZOU7m08OnMVgcFy7uPiDU4k+RVbBvcoIrj3ieHewTcBjTgqeMVJ4Et76fxEQEd2XUlSONy5u0Y0NtDjNvNU33EJeNml2WhuGy9QpXYIdjRm/P/zxvOk7zWVc+mk5xQogox3T1ZiW2LeEaqCzE0tTat1CmFBJDfnJw9V3i0Zjko1YkdHZKjwQaGEtIZK5dAv/wa+lBYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBLyMu/c7Sp1bcBRjuTB2jdFKaviwk58/F/YWfXCQsg=;
 b=l+Sjh6vu0eOy8+dJUessVQBCi64J3gxMkUUQzNU/qP0K4NIYJT6fpyy13wTjd/c2KmVrFo3RPY/+1vAYB+WboGKfkJeKR0EYCBfJSJv9y1KUEvROMXrAx42pR0qXQGmHwOYSy6e2sAGE328dSX4h+EAjxMS/ZP8hZoQm4O1oQLW8lKKwtkrYogQxyHwZl/6dPPGur/6aFl34ysbhvxfH2rMwgNk5auuXORKAh/n/5kVJ4iOheqNt0ny6OIwP0HOaIePX26y8lA5O60fdZshiq5VevSdONy/cMKrZKIFXLM0XapFHCoq0X0pJBlAximooAc7ocW3zrD8hJOiSv3s8dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Fri, 25 Nov
 2022 13:40:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 13:40:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/4] Squash to "selftests: mptcp: listener test for userspace PM"
Date: Fri, 25 Nov 2022 21:40:47 +0800
Message-Id: <ce69e69bdfe5436e0a868a7f973baa9e424cca4e.1669383374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669383374.git.geliang.tang@suse.com>
References: <cover.1669383374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1563eb-43db-4e05-0786-08daceea9f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yEXvjEiWJ4wXXaeP/juWP/DAGHnq19RCndK2aiv0f8iJcKCJzNc29kuEFRIMP5cvsOkOv28r/xtCfGFbyigI3nSg2wuDVh1z2f8j/q935qzocSdCiUemu4XKBAASnLU3XLsqjGnWfI2hB7YFBtVOzrULGTUsUknr9hUFrAkWAE6c0T5ZeAffazORlhb0oXJ0b+AaXY5XK7yIDVD+pywrduG+e7rmqEmIGUG9DMxFSkvbGidTx1UxQORR8G4Br3wkKGgPpKZ8K7jKaebntiFWctDYS3OoOl8Pdzxw9VM9buj6iJIDze/FUZgIZS2U7XSHZrOvzcxCrQoTBfJyjZY1vHsFPkoBSkDZBVXWD5wHTDb+521OQpEtv45YTrRPrBajWImuGKEMIP28RzapB68Hgaz+RdRXifhlWVDqpypWrhYGFitk5ddbb2ZAN0hW9ojfS/YCEDd8j9BkFC3MqbZsSxGPV1nrIt/CLXNIxV3v5kxsRvZdJ6Ktm/OJ3f94qe+s7JTFmMJr6dhx4RqnAI4cxnweKXWEjCddZx2rXbJFkJkD1ICi3w5nLVJRHWHtZeG5OfK6ESU4yxwHTQCosBTbiJ8+z3XB6Dyel8u590z19SskO6rpcSN6cqMPrv47Bd7s5SARuRYAIK3b10tOUct1cw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(66946007)(66556008)(186003)(38100700002)(41300700001)(2616005)(66476007)(86362001)(44832011)(5660300002)(4326008)(6666004)(8676002)(6486002)(6512007)(316002)(26005)(478600001)(6916009)(6506007)(36756003)(8936002)(107886003)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8y3CAo3/E0Mp3Cc+mgVh2Uo3KQwJB5WTlcw7n26Zrq8UMFNSxm5VyssJcQpE?=
 =?us-ascii?Q?saylcXTg0QRiMtrvnmCnSNoVSoWYVsQkKnufSGMSXpzjQLilLjp3gePFv+xC?=
 =?us-ascii?Q?I9IY5+4jp6zAxr0hSnrgWOlG8PG1vmMTHFtzZ93UNILgEBVLI9nckWAsFHsu?=
 =?us-ascii?Q?sgUgOXfoe5yW80qsPUeijRFkd/BdEIf7rGBKLlujWrOzzByyedbTOZiZ9wx9?=
 =?us-ascii?Q?/VxJOHRvM39sNaQDUcUCl0f1M4H59xcBjgrPHGJOf7WNcjWNcKePq0vUERvJ?=
 =?us-ascii?Q?//eWTR8w8S1t7WTPa+eEkDU4KIP2jq/w7Ky5Xdjf3s5h5niFDQJxWnpTwY2X?=
 =?us-ascii?Q?ASCE9mh/mKm3iwFX/uw7tWp4uwi9T7YjSUBH7ZZtNqddIAyhxaaCeJNqBFRu?=
 =?us-ascii?Q?hI0ovM5NdTunYZ3xAGo78xHHt27uXSUYunpqamhOAvTeTeepxw1qZzX9qzcK?=
 =?us-ascii?Q?l2zjXpuRh3y1LxtdDo/rSK+HVqnC4kVk2DvUvF7T9q/9uxjAe6t4Lqj0WNli?=
 =?us-ascii?Q?Qy+Ycj+MkCA2Rn7GYt9rnr0/DBhWcrXclbD3oFWxK0D41ucttOruSBafcu1k?=
 =?us-ascii?Q?lMrHDB8Ewj80pM5McHzL5eGR+vtk4ieYRZdqDvm9ZKtcfh/kDlCOI5SnLI6t?=
 =?us-ascii?Q?4Id0vD7JpMGJctDcmtbIKi5gIjL83TbG1JMUJ1LzRebAvm//MHShc2I6FoRg?=
 =?us-ascii?Q?IFiI1myLkXmaZePJLTw9xKibtkX0S+50gb1uSZRbX41XWEENPggxEIRZ+Duy?=
 =?us-ascii?Q?fUQ58kbb/PB8rNiadsc53uavkiMUlnxEtkaGYjJONiavR1M1/MJfgLvPokBo?=
 =?us-ascii?Q?lVF9hBmbutBl8aNJWE3xOFiK3eS0YVg/CwFU3bRucKm17S/FepxkeKll1WUL?=
 =?us-ascii?Q?D7OWqoZXJ/lFn10iE3Y7wm9GK2FppnQzyv+z6B8i1c9SP/0S/u9YptaGwRV9?=
 =?us-ascii?Q?JKADd4KQZOF8hyno9xD5CNgNNDmMme+qeDZ2a0ax/bKtaQwZI/ExPhzARFpI?=
 =?us-ascii?Q?UzfEboM76nTeNo0rZjpmGR54Nn6TnI1TYKFqfpvq5TtUxylMHqtImJUQHU3V?=
 =?us-ascii?Q?pNKRKYuXf6nqnoEUqsUZUV5AuBfKxTj96iWOAv3sZx16i94c+fIH9wqE0EBf?=
 =?us-ascii?Q?S7P5kprFv3QvihZ7R61XMf6l4abH75cn0Hhp5H1RQsKDoGgaxKE9nBq5t15I?=
 =?us-ascii?Q?ozDu4980cZr5tdRCzwDiFng/91moJ6asQKeptGqMKKVq8+LUN/jIEWReET6R?=
 =?us-ascii?Q?rL1Grg/EN8KxXCDKZoiT0sm54m3FF+pZkrpWzdLLEXV7ZmnIheQpJvNXMike?=
 =?us-ascii?Q?nTUpiK3mB+xKddvzrPk2+0kvj87kvlbYJIDM6y2ujpRbEHdzyeZ/69O/ujoY?=
 =?us-ascii?Q?DYWsoohBleHLxIB1AVL83rOemycofCXaBhwEXruChAJT8220+Fvoi0h+Kdai?=
 =?us-ascii?Q?SEWd7nmWrPUmyBX3Guh5rhwvltnGrjAdPCVaSGOsUljtH9BoiOZeUWDfnYlp?=
 =?us-ascii?Q?/OB9JN0M8Y81ezMp3AYtxaMikI5mJ6DQXxp1hc9iH97C8PTB0bKfVECWOHcY?=
 =?us-ascii?Q?b209DDVYibvGzacdGA54YzaZRVNuHQv6VjZI+a62BwL4A/3igP7qpSyBiz+L?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1563eb-43db-4e05-0786-08daceea9f6c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 13:40:32.1328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp8YPpZXeglbUorrtr4bHjjrolRwVL6IvbgI37nb9w/xWGYnP4IPjJ+ik+AALrDiQO3xanl/5Jpmcmed5MiW7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

Do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index a1b7592621b7..2cebb20552b8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -807,7 +807,7 @@ verify_listener_events()
 		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
 	sport=$(grep "type:$e_type," $evt |
 		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	if [ $family = $AF_INET6 ]; then
+	if [ $family ] && [ $family = $AF_INET6 ]; then
 		saddr=$(grep "type:$e_type," $evt |
 			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
@@ -815,8 +815,10 @@ verify_listener_events()
 			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
-	if [ $type = $e_type ] && [ $family = $e_family ] &&
-	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+	if [ $type ] && [ $type = $e_type ] &&
+	   [ $family ] && [ $family = $e_family ] &&
+	   [ $saddr ] && [ $saddr = $e_saddr ] &&
+	   [ $sport ] && [ $sport = $e_sport ]; then
 		stdbuf -o0 -e0 printf "[OK]\n"
 		return 0
 	fi
@@ -826,20 +828,15 @@ verify_listener_events()
 
 test_listener()
 {
-	local evts
-	evts=$(mktemp)
-	# Capture events on the network namespace running the server
-	:>$evts
-	ip netns exec $ns2 ./pm_nl_ctl events >> $evts 2>&1 &
-	evts_pid=$!
-	sleep 0.5
+	# Capture events on the network namespace running the client
+	:>$client_evts
 
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port > /dev/null 2>&1 &
 	local listener_pid=$!
 
-	verify_listener_events $evts 15 $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -854,10 +851,7 @@ test_listener()
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	verify_listener_events $evts 16 $AF_INET 10.0.2.2 $client4_port
-
-	kill_wait $evts_pid
-	rm -f $evts
+	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
 make_connection
-- 
2.35.3

