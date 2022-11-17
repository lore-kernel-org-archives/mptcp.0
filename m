Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20040.outbound.protection.outlook.com [40.107.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EEF17E0
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 05:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXDovzlHIYcETvIhOGUYSDn1279UR595nuFKxK+nfbvicT5rVGbYjQosTHaebEG6gLasSVXHO1x+P1qOcYsqNKI0UGXNJJBrrDMTk0B7YbQS4H+nvzYARmeAfd4NGSaRSS7ufGZbnQjpjWSvgglOxoWEieTKM0v8oiYtC7P98viSW8c6EXx7KcqaGWWUyWuG93+MjE43CreXehgGFOGwmdcnxhqU38WREcjly74onkYVG2n1gt468sYZU7EkqfH20nqdGJbVd29i2u6n8+lnF3tcCF/DbFYx8hUqH/E2UytWpX+JBvaHckJU/BZwH2MSMRlmO3dCfneB513yp+/7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGI1QJaWHr/T2l7HEd7AsrnUteKbg0LbEmKBfODc6tA=;
 b=j/CHjf2S3uiUx+qqEsbpUm2YuYjQY4G69l88VcUIRdSdvGzvibquAFx4jqUjNnLbnm7MC+jovpfsFpM/o2PK24B3mxCuIRkdg946YReFUctccbvvkgjxfmI3rPUG97D01k9HscicwbG6Ccpa+sHG+7fBlcgyzAPPud4JrwEf8A8HWCkjL3bQgsb8718a5DEacocETASuQ6+UGrCYBk/xkL89ceEgMc345ig6bKLQ+3faVEfneaz/MzOzbMhPS7voKjrU5n15Xv+G0XUYam7S1VvHEtAS1M/avPi9tlfoC2mt2o1HtfuT+xHZe/ekcSznt4UsXZyK99/frcMlf4hdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGI1QJaWHr/T2l7HEd7AsrnUteKbg0LbEmKBfODc6tA=;
 b=zJuLW2eDWQjEkUEaaoCnbNBm60YCjp716P6aeVy+y1MBsblmea9AflOjU7QMvueZqPoM5q2D4p05Zu2k0jfgeHBem9+If01mx1sAKxLobM+WPWVWlx5d26I/C7KmDJeLeFxhKR1E53e1mUIaI7gGcwTVDmbgxOvuctKhWUOH9wBBk7jrSZeocX0QCznicCCR8Sw4i/oCJiiA/rUo1ruExYf6IuRwmaetfFpNVYmEhvikz/Raafqp3yqxImIvX/CoJ/nxtP/T/WWb5v40ip9WZak4ratjhvDdm2KkGqGR6jIgKrVeoMPjbcwxlm1FuTg5TTXodNVY+uG1Z5FZJxH/Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 05:31:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 05:31:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 4/4] selftests: mptcp: listener test for in-kernel PM
Date: Thu, 17 Nov 2022 13:31:34 +0800
Message-Id: <60b6d97a1087057ed07ec1c0c7068e22cede2ad9.1668662624.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668662624.git.geliang.tang@suse.com>
References: <cover.1668662624.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: c85039f9-948f-4a9a-b3a0-08dac85cfd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eZ8uzaHJcSw4sN1Wnjvby8bUOmFCX5FSpX+dbM8oUJSHKePQVCe6wnzqkx3jf9Bvu3h7T1F36hDC24kkMuxYrnGkgJjGfI7wtZ9zBiEgI7gxn5Kg5rZgIIWlEVSU/9x/Jd8Pq/W813e2c878YoPj4e2EIpd5rNETF1gDJlFK6XDCH2IHavSNx5MRQV2moq0zk7dMlrE7zgMEojkmuAeRbkYLpGcx9QHtPWlHcHu6o4RLA8yQBHSoAbo1Yn526J4zgFpLcwHJ0QFIuMbPxFEK1xpoj/ecZpi00EUwWbhRK5y0+Ek0QNTCBwWVk5EAQQqRassSu8AQq5wW++eklY3Iy975iZ+x5yRdxd2iStkw5RH/x5zmRpnUrqXWeN+h1IT1P40gVFI00gPVEfXNam/3y88YL0CaksErH6TIHGQlAUi6VvVcskLP4KyQ4EeZCZo/Pj+MXZocFzinJSyYSdwnmiJAYmnd4qMaMmgVJw9Kn9xqiu6LVb53AtRWJojpT3KJlSmzDGhHE/x2icjtlKKAlkyTwzip83mgaviNloSP+Ohcdf5O2Iu9SUkSrhMIJyjdQ8lbyLz2OrZEAVdlgE3tSQ7Yia/nDF6kLreRIHe2DEpKpH7rHNTEszw8Ej2/1NZs8ZxFX9/d8nuKL4HGa54X1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(6486002)(478600001)(107886003)(6916009)(6506007)(316002)(86362001)(6512007)(26005)(38100700002)(66476007)(66556008)(8936002)(4326008)(8676002)(5660300002)(66946007)(36756003)(2616005)(186003)(83380400001)(44832011)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ti0t58OciM7y1mnc/TidtaJbeX2kP3W/pu+ppn0jUreHDASX/hTzs0VErDaC?=
 =?us-ascii?Q?45aJjy4AE+jVYnPsqcBZomHeYearIT+unRUDBkAvy7Nlss+lUUWXbrig4lZL?=
 =?us-ascii?Q?USVpEIjBhgHDxdrUviA0a5CJJjB62N7E1BrTGJE4MZnr7AqIfl/wEO3AdpHU?=
 =?us-ascii?Q?+GIdfessuaO7I5U1Z6S6ndxC3rPlkUkA0vwW4ynXXfhLCwAZE2utkePO9URn?=
 =?us-ascii?Q?7H2ZjFiLRdvK5Gsq8NvJFntj2QUopSil8D2AFUjy/+W6BA4afoeq5TkJK5tJ?=
 =?us-ascii?Q?t48ESGHvDT3dcfeKgphiR2HGDiXi1bR7dfNZ27imku0Gb9BxkESM20JnlX0W?=
 =?us-ascii?Q?Ucql+r8/5KNk7yMK+6QpyBCir8Fx3d5vSI0bzepzmpIa2170ZPly9R0yH8Pa?=
 =?us-ascii?Q?vaxNzAlXPoQ/OkWY8GUomE3AbGerWd5ZVhuv3tD9r3dZOcUqWaI0SayuS/t1?=
 =?us-ascii?Q?FClh5vQWncVMzB9Q5uTRLDnGvZWD06xfhJ40z1wmXd6ovCjkOhN1R9wrMlN4?=
 =?us-ascii?Q?r6va5jgST3GRM21ysrmcbFXH0LROBv1EHtk7tpHVONFftXHg1GbjF9j3DbKV?=
 =?us-ascii?Q?55Ankfv3gmzPjJgN0d0PCCWnr+YgLh4ftMiqBUNEEPKwj41PduRz6nRTWneo?=
 =?us-ascii?Q?BJmzqFr83a1AdlHhdEHaSsouUtg4nQeneevSHBSQDViIUsrBJ8poysSe3WbK?=
 =?us-ascii?Q?7yrUVB6/QzP25N3/OUNGZZqC4jtv8JfRo+TAKdxnDZNZuHR5u/H0tWiU97fd?=
 =?us-ascii?Q?8uwSfyeRm6eB7XL/qNr0RiWL6gjXi19UTmDqN5Xlcd9ComtXLiNJ0qPxrLKV?=
 =?us-ascii?Q?QgjRViJrYv8mOT5JridMCVNzd0T1Y2DExQ6Bk5rA2MmY0FexMwYb5iJx8Vk3?=
 =?us-ascii?Q?irbbwP+IQ/k4kCNT2fxBNWrznL+AzH0VKu+SDkXgwkSAG3HzzB5yYSBNzGKT?=
 =?us-ascii?Q?X2PSt3cuI3RnnsVE0T1ufY69adg1qIBorM9SajFcUoLzda9JRjmaJv6qSurF?=
 =?us-ascii?Q?gW3OdoOo+mvwshZk05/OyErjN22vLW+AmYe+mCqsiYboeMLAqGukRw/k+2u3?=
 =?us-ascii?Q?JjD0FAQirFezwjEcapIgx+1dKfS7eYEX6T3Vi7ZFK4EN0m+2vf3T+x7uEBFl?=
 =?us-ascii?Q?C9Fk1IcsxUcYa2kUIhgX131LMxVuIytGpNig2GnkHmTjLskcyDH+LRP1s+Lc?=
 =?us-ascii?Q?oFa+HxcrNPYmMH2rjaYAg+RLF08WlRFUqpqR/VoFOyOrq76YuF2yKsTq9NYQ?=
 =?us-ascii?Q?VjYWVJIsvz9VmhCITXY8cP3pJfLrmUgf/p6LXu8HyYlyveaYIyCM5QfYWRgl?=
 =?us-ascii?Q?l+G+PvgNTje15HEgubNOkzDdLkLUgA/DrnWszzwpkKOwnHzmiYexPFwqYKb2?=
 =?us-ascii?Q?XBMEC29xPJZFuGIvNqCMSeo628RVrWeRBaGuJj2LjORKfTfUcV4zNeqjn6lu?=
 =?us-ascii?Q?TVKJfYPLJZh+zSTZCJLPSMvw8kHMKeZstMS3KzCleBaYxFTR9A41eBckdXEH?=
 =?us-ascii?Q?ZGF/Vu69rICUvbdHnsM8HAf8Xu1x6Y6OT6d51+45GHbNDYK67CWZv3QpyDgy?=
 =?us-ascii?Q?BrfaLcnU12iG/+9JwAjsY6LVPBEq/Jx0gqXN3eqaewPLeGIqqsCIm+rfNYft?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85039f9-948f-4a9a-b3a0-08dac85cfd7d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:31:34.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsOwAQDdxfWB7bgFDx9n5edpY9eEH2Cfs4ndXLTeUXQwdpT2hLXUgFdWHKAQ34xTJZlLc8WSdyTbVWg7gY62JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

This patch adds test coverage for listening sockets created by the
in-kernel path manager in mptcp_join.sh.

It adds the listener event checking in the existing "remove single
address with port" test. The output looks like this:

 003 remove single address with port syn[ ok ] - synack[ ok ] - ack[ ok ]
                                     add[ ok ] - echo  [ ok ] - pt [ ok ]
                                     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                     syn[ ok ] - ack   [ ok ]
                                     rm [ ok ] - rmsf  [ ok ]   invert
                                     CREATE_LISTENER 10.0.2.1:10100[ ok ]
                                     CLOSE_LISTENER 10.0.2.1:10100 [ ok ]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f10ef65a7009..89a30225bbd7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2509,6 +2509,54 @@ backup_tests()
 	fi
 }
 
+LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+AF_INET=2
+AF_INET6=10
+
+verify_listener_events()
+{
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	if [ $e_type = $LISTENER_CREATED ]; then
+		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
+			$e_saddr $e_sport
+	elif [ $e_type = $LISTENER_CLOSED ]; then
+		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
+			$e_saddr $e_sport
+	fi
+
+	type=$(grep "type:$e_type," $evt |
+	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," $evt |
+		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," $evt |
+		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ $family = $AF_INET6 ]; then
+		saddr=$(grep "type:$e_type," $evt |
+			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	else
+		saddr=$(grep "type:$e_type," $evt |
+			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+	fi
+
+	if [ $type = $e_type ] && [ $family = $e_family ] &&
+	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+		stdbuf -o0 -e0 printf "[ ok ]\n"
+		return 0
+	fi
+	stdbuf -o0 -e0 printf "[fail]\n"
+}
+
 add_addr_ports_tests()
 {
 	# signal address with port
@@ -2533,7 +2581,16 @@ add_addr_ports_tests()
 	fi
 
 	# single address with port, remove
+	# pm listener events
 	if reset "remove single address with port"; then
+		local evts
+		local pid
+
+		evts=$(mktemp)
+		:> $evts
+		ip netns exec $ns1 ./pm_nl_ctl events >> $evts 2>&1 &
+		pid=$!
+
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
@@ -2541,6 +2598,11 @@ add_addr_ports_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
+
+		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
+		kill_wait $pid
+		rm -rf $evts
 	fi
 
 	# subflow and signal with port, remove
-- 
2.35.3

