Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00083.outbound.protection.outlook.com [40.107.0.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26137C
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 03:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc+cR4zrfkFpVVfLMHnzeKcNYgGlNoHR6V5pOLpwvNBndP+j5UsnggSxapqnpkQUmG41rzaYW+uSofajtOszVmoGWAJOdPaai/MVFj/WoTCQYK+6HBUvyxhcP1rPLvtdme6c3j7kOf5GZtyitjIHjERkdXO6dbonbs2prJcpRmBstw7enWYQaGAZkvkbJZjtCrb1oQKxs6Cql5zLf7ZLXrf8JeUZlyR61i4Cqj4EzhQVtFt+scHYcp6fPmluyy8xUCnr+Xs8k7kHwTyqBVD7aDp8g7ORGDrY6tFi33N4qwArxpPubt1nlQvQcIGCkKYBOTnGpGjMy5fmUQcY4nutOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqGkXqkJCyhgHp3PZMh4yJqOb8MiP37oeGJ/j9usxmU=;
 b=Gs/HtF3KI1M7CPzYYhX2uTzAqNhFrsko/5Dp0GaohJ2tC/BLAWUMWg9MkQTxxfzlrQ0nUGQB1iSeKfi3kc0BihVnZyDweIruOFbnDr8cvEsmOFB9vk2nea9fhXaU5npiAnpi5MO5QhQTmB9V5Ug1bd01tVpCshDnmyLJETQvOIT4i26XiRrU11ptcL1Cfl6N6eo2kzEuuu5l9feyG2hwq4JN95IEUBUFPuR570VCMNpP/793J43AAAZai9/1LbRKKIPZcFjw7QWYujC9Cz/NXdgb0B5CTMwsoNRGXGCleWKCUrqwTbe4I0PG1IEUwIT3qY7ZLw3HapjpYBaZIKTTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqGkXqkJCyhgHp3PZMh4yJqOb8MiP37oeGJ/j9usxmU=;
 b=Ug0d2Hokkzj12+jEla6rucatoDdKlodo2We3vK5X0FZtLuX0lAlHCGZTCaZ6L/MuxHjuP8X+qhPLFEUZ2UuYzQjEP7QLQw/kuy6zHO5evGAcslOqDEkh9jtpSOSvLJ3YQuXaueya98ay0Jb/VWNGpDd1E71OUHHH8S3XV7kNiXom4BihRMDgj/KLwjYQqsTd0pPBv9wIOV+tppPESU1VQUB0Bu76dV8KOtKTXn6nfooX7Xc5TZjV/fh95Jpuy9ATt+zOdW0jOJhp/FnmMLthOQlTViIBmexDynB4pvDLf+nwoNzIIZolpvcNpZOLFL+1/6G6/Xpd4xqlAtrkn6/3fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2534.eurprd04.prod.outlook.com (2603:10a6:4:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 03:00:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 03:00:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: avoid Terminated messages in userspace_pm
Date: Fri, 10 Jun 2022 11:00:03 +0800
Message-Id: <829ce50fa6d830c6c5ed371e7741b6d30792d905.1654829977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36358d36-b5b7-4b9f-acc9-08da4a8d5673
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2534:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB25349F62B60331314A1556B9F8A69@DB6PR0401MB2534.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	az+Ejxvl2xu8jXVNNO1U4CqgkEIqq1PEWu7hAbKxQDj94eccLwj/YbJxg3pTuSCoVnbow/CAVrQieP9DRPjd7XTgaxleu5enKTgHvAXTcCRGG5ItaK400ja6iqpXNzYDq8Oo7EnpRsb227NPngMqvMmcQfn5C4hNJAHWkagG12ZOZ7mEevnjunM6K5Psh38c6fFLSKoSpXT0sSEZf82teDwcMKI5Kq+TDbk9trHjUBbFgUiOZF9IFODjh36qCF894QFC/DArI+HD1+aCP3KES7MT5GEh0dVFwt0hOlKr/UfVQFKZ3jxJjdP+ntxDOWmAs3Yme1njyO0GhkdInrbb90iEELEcgTsmAF/P1YpKsFTJpMWXuC3PlvmzYtuz3Ft2L9NIVNbe9dS40j0gs0Mz6lG4UsnRp6RG5dsBXfOCW7yCGA8yo2NvX44fuUC1Yq1ZWOWaGMd0URYXxhViDQfBb/sJsXbmgu2PnENrdA/diXHYvn9OJjQ256aD+fqGzoyrh5M0316wc6bWHikoXOzrCAsNwm9JMuU+U7zAhuNogbtj2728ipt/rYZzj/PrFzbQW7T0p4AwsQL4YiI81yj2td8VO9781tC3jULmblCMNcAvNNMZk4gEYNGzMu+769T4/W07d2YttZ6rCHAwQSYNY0yuet30jyszeC2gOw+8x+LAl1uB5uCYf7FLrOUfXeSO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8936002)(2616005)(186003)(6486002)(83380400001)(66556008)(36756003)(316002)(107886003)(6916009)(66946007)(26005)(6512007)(5660300002)(2906002)(8676002)(4326008)(6506007)(86362001)(15650500001)(38100700002)(44832011)(508600001)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aCo1CqHcGk+0/SXH5KixUeWYaEeVFXkwuORtFeCW4cPXunqhWmL1phd2jZLw?=
 =?us-ascii?Q?6NZ4IMtYtFM82VxTqBHE2cperQGT7YroA1Ae3H33R6Kv+XAK4F0W0gbpRtiH?=
 =?us-ascii?Q?CzCLT/jTpK4iMiOSo0XT8SojaZXPhH0YD8Dle2Yk4dTYy6tE3J7sYC3sczb7?=
 =?us-ascii?Q?g8jSUESWcYBSSaaLdrNECgb8ue7mPS/jbhvDm/KdM4Kf36sQmpkDxw5I76Gu?=
 =?us-ascii?Q?Nhi1m/IaWLhxOk4D6/6QJd1jquRq5FKR9mYD7whGzzY+xve+xSlzrdwd48uu?=
 =?us-ascii?Q?k56VlUBT2p1/YrPd/JDI7Su+366FuxCf5iABVniWsNMie/9v0rnVSZxXqbTG?=
 =?us-ascii?Q?QTpvRRkixp4496IQIBYELW+/lPJGAF+ufvU8n7V8uKpG/U46t0LCQFQF09K+?=
 =?us-ascii?Q?01462sNxMrkEtLdtilgHw66Q4732GS+BMrevqBsO1sr5bOm7+Sjdqr6l7OKo?=
 =?us-ascii?Q?7TdAmHDaBmBS7/sL9LH7PAEh0r63Cs8zzQ+Z+YXiP7oStsw1dMQYQJzVNUZA?=
 =?us-ascii?Q?PhA+P9c3uufk0pyKHqSE+pSho2AuK+AJAQPA8l5GDUlz8brTFU1qMLMZTJbQ?=
 =?us-ascii?Q?FRONec8JPLBERqiTUZWAfhz4K1AwisadKN8TV8dMzZJzuXsjnufIToYFet0V?=
 =?us-ascii?Q?MpCP/5CrW9pXb0ti47mjN4HaT+NxoMMWDWgGAOs+fflljTR2cPwUEu8FWJQ9?=
 =?us-ascii?Q?vXaKW2Oe2urdCfRqRYOBaqNeYa0/WOJSJ0V8vWFR6f/75dGR6WsXck9GYI3Z?=
 =?us-ascii?Q?2uHVD7psg7V/ihxVnn98TVYXc2+Ez19exSEk7cbR0L8VtlkjMG57qxXmHObN?=
 =?us-ascii?Q?+XKL1vb8IDLDXOhRZaLFPd+fLW136iWHGlRXQnyTyUfwRqGET7VaoCWncoEV?=
 =?us-ascii?Q?ekLNhAeb+tdJOGzs92ZCbxhg7aonhuyn1WMj76ZAH67nvk5MSxmk9wJe5LD3?=
 =?us-ascii?Q?AiqYBPVTF5EStdY24WT2gWSqjmwuvcT9g22ot6jCpq2KYwcnGbTexh8mahd/?=
 =?us-ascii?Q?VHx6FzZEfWEe/5+ejpgaG71xGGE3nvwMHVNVvITsvQ5G//Onbg/2DZB95g4H?=
 =?us-ascii?Q?PGSZEClN2m+NGETtsi34DPQKqN+SsEBaBx9oTGXUMhIyWrkekDA7vTlHmPvY?=
 =?us-ascii?Q?fgI6PCMVEBPirXqJ0Ct51pYhszyUNM80qTzMtWL8l7AS3vSxUOgjDa7O5abk?=
 =?us-ascii?Q?uc3DmNas+O5W2l9GB6zcH1x7dhUPvQtqEgKQUaAeAZXknfxP36YEPcJflrlV?=
 =?us-ascii?Q?rgWe5sw9V8qBzJP5aLhlczXuRi+CoVVv6qRJsVipjdZL3T3IwVCY8hDAIPse?=
 =?us-ascii?Q?AXTITa4LRSKbLr0ovCRMFmKDlV2LiGJlIu0/XMfb5eKTrCvaechmkICosq/6?=
 =?us-ascii?Q?DvzKvMB6DMuobEr3RKzJ3z2+BaWNI17MSkIKWPaexAooc3mdFL8mB5TOOg8N?=
 =?us-ascii?Q?DD037w3adwJdyeYpbaGCWG9hzOsn1n81jU3vjB1qYA0Hcfpjmies2CnvDOSS?=
 =?us-ascii?Q?GlqlXX+d5LUTeE9rsBvuaqM3i/N5N1ar1zH3fW/btx0462tndl4LmhrFlg/I?=
 =?us-ascii?Q?aJJromEN8Y/DLAZ0x2W6SgLQcg4+QbBohDmGicTjrVVokcvLH0ej+dFM3UPz?=
 =?us-ascii?Q?Lr6mD52LRD+nZjsTqapA6ak7kbOVHgfwcUYOJE8caQGKNfNF102C/J9H+/m9?=
 =?us-ascii?Q?7OebV0p7xdt5yxOwPo1RQCCVoXMWkchuON+UM8awAf3f/+9HHHme5mFERmsQ?=
 =?us-ascii?Q?aclJUDYWehlOOMRDvTfioRWfBitxoe0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36358d36-b5b7-4b9f-acc9-08da4a8d5673
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 03:00:12.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7cwyZB46Af5HvB8VoNNovfp5zH5HhJJMOwl9aNL8y5yWuwKqwscjRDpO+mgC+PBl09832vTdPzkPTiOAmDgDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2534

There're some 'Terminated' messages in the output of userspace pm tests
script after killing './pm_nl_ctl events' processes:

Created network namespaces ns1, ns2         			[OK]
./userspace_pm.sh: line 166: 13735 Terminated              ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1
./userspace_pm.sh: line 172: 13737 Terminated              ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1
Established IPv4 MPTCP Connection ns2 => ns1    		[OK]
./userspace_pm.sh: line 166: 13753 Terminated              ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1
./userspace_pm.sh: line 172: 13755 Terminated              ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1
Established IPv6 MPTCP Connection ns2 => ns1    		[OK]
ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    		[OK]

This patch adds 'wait $pid 2>/dev/null' commands after 'kill $pid'
to avoid printing out these Terminated messages.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/userspace_pm.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 78d0bb640b11..eaa54c3f75fb 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -49,15 +49,18 @@ cleanup()
 	fi
 	if [ $server4_pid -ne 0 ]; then
 		kill $server4_pid > /dev/null 2>&1
+		wait $server4_pid 2>/dev/null
 	fi
 	if [ $client6_pid -ne 0 ]; then
 		kill -SIGUSR1 $client6_pid > /dev/null 2>&1
 	fi
 	if [ $server6_pid -ne 0 ]; then
 		kill $server6_pid > /dev/null 2>&1
+		wait $server6_pid 2>/dev/null
 	fi
 	if [ $evts_pid -ne 0 ]; then
 		kill $evts_pid > /dev/null 2>&1
+		wait $evts_pid 2>/dev/null
 	fi
 	local netns
 	for netns in "$ns1" "$ns2" ;do
@@ -154,6 +157,7 @@ make_connection()
 
 	# Capture client/server attributes from MPTCP connection netlink events
 	kill $client_evts_pid
+	wait $client_evts_pid 2>/dev/null
 
 	local client_token
 	local client_port
@@ -166,6 +170,7 @@ make_connection()
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
 	kill $server_evts_pid
+	wait $server_evts_pid 2>/dev/null
 	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$server_evts")
@@ -287,6 +292,7 @@ test_announce()
 			      "$client_addr_id" "$new4_port"
 
 	kill $evts_pid
+	wait $evts_pid 2>/dev/null
 
 	# Capture events on the network namespace running the client
 	:>"$evts"
@@ -322,6 +328,7 @@ test_announce()
 			      "$server_addr_id" "$new4_port"
 
 	kill $evts_pid
+	wait $evts_pid 2>/dev/null
 	rm -f "$evts"
 }
 
@@ -417,6 +424,7 @@ test_remove()
 	verify_remove_event "$evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
 	kill $evts_pid
+	wait $evts_pid 2>/dev/null
 
 	# Capture events on the network namespace running the client
 	:>"$evts"
@@ -450,6 +458,7 @@ test_remove()
 	verify_remove_event "$evts" "$REMOVED" "$client6_token" "$server_addr_id"
 
 	kill $evts_pid
+	wait $evts_pid 2>/dev/null
 	rm -f "$evts"
 }
 
@@ -554,6 +563,7 @@ test_subflows()
 
 	# Delete the listener from the client ns, if one was created
 	kill $listener_pid > /dev/null 2>&1
+	wait $listener_pid 2>/dev/null
 
 	local sport
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
@@ -593,6 +603,7 @@ test_subflows()
 
 	# Delete the listener from the client ns, if one was created
 	kill $listener_pid > /dev/null 2>&1
+	wait $listener_pid 2>/dev/null
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -632,6 +643,7 @@ test_subflows()
 
 	# Delete the listener from the client ns, if one was created
 	kill $listener_pid > /dev/null 2>&1
+	wait $listener_pid 2>/dev/null
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -648,6 +660,7 @@ test_subflows()
 	   "$client4_token" > /dev/null 2>&1
 
 	kill $evts_pid
+	wait $evts_pid 2>/dev/null
 
 	# Capture events on the network namespace running the client
 	:>"$evts"
@@ -675,6 +688,7 @@ test_subflows()
 
 	# Delete the listener from the server ns, if one was created
 	kill $listener_pid> /dev/null 2>&1
+	wait $listener_pid 2>/dev/null
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -714,6 +728,7 @@ test_subflows()
 
 	# Delete the listener from the server ns, if one was created
 	kill $listener_pid > /dev/null 2>&1
+	wait $listener_pid 2>/dev/null
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -751,6 +766,7 @@ test_subflows()
 
 	# Delete the listener from the server ns, if one was created
 	kill $listener_pid > /dev/null 2>&1
+	wait $listener_pid 2>/dev/null
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -767,6 +783,7 @@ test_subflows()
 	   "$server4_token" > /dev/null 2>&1
 
 	kill $evts_pid
+	wait $evts_pid 2>/dev/null
 	rm -f "$evts"
 }
 
-- 
2.35.3

