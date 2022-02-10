Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AB29CA
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644472850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waeVsRE+1w1DUZvRLvBXEPZlRbREcoydERpgQr0yRdc=;
	b=A3qkAqoNihitwRBdexOoE/gpNBeZGPpZ4A6RjEciQ+u1ZqV6AMq7lYNTQlMgqFYaRmxeq1
	rxEL7RAPnkupBky8HLdAGRGKgV1xkyC134cl6lmy1ukWQJkF90aES8eEzULjQLbWSZqpVu
	gwhLKuai+1CeTtFZbu8rHKP1xFfBD5c=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2055.outbound.protection.outlook.com [104.47.4.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-UCLHACIRNby6ZZ6-3VCtVg-1; Thu, 10 Feb 2022 07:00:49 +0100
X-MC-Unique: UCLHACIRNby6ZZ6-3VCtVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT77bcacjLxt9A7eiFjwy84+pdIFsd14iqVMThQa2aRXoCuhdis2vxHYfHpFBpDNPSf/tpIK9C6Um7IST8dr50LybziMcvdoNxZPO+sTm6tn5CPLguB4LvbXN7t1AuX8AJhwCsrKrqmrRNCCp7L07PgEBxqKgmtN4Jjc+HiK6xLxsMGSYQe2QVg9vCcOdEIr6TIe7OkLIRsJCLojISBUc5/z5Ck5pjxt7PB7XZkB9bo/6Z1GIKyb+Pnv+pKUMwheq5fr9CTH7zyrFkgngl7OCCKPNBC7Dgnf/bOi0y9D9MKuqoUej6zfmJczNN+lE0sFL3T6amgHOWH35l8j6NaIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mbX+EUgrAp7GFBPVgK7J5Qth9Y+6iV8uJlYTL5eh4I=;
 b=ftww12GHi7NU4TC6fA7zidl1powS4UeArL3Iw+iG9pf43zkZbnsK7aJe2Z0a96wbn5v2dzDkJoXyGLrSG5BvcsR3ILp+VqlvwwqOiRIz6mKapfUfFl45mlP5/qkQxpRRfy1Yn0yJoVEOf3zgHmFntgPZk3He27PoIQ9bByvmMdGiQxj52kMaaKGForYjrBqqT9sD0FTMuPoeSzLD/xrQ7481ZSPZ3ZAsO3LlL3vzyEiqU6pdKJiKtHIuCIiRMx5CevaaUrc5geZRDAxuTEfDMuFEX5zAORpKbadkGzp+27R405AEw0F5TJAxPDt18Z9ZDP5s/3mZmxeGsWtBigzZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5761.eurprd04.prod.outlook.com (2603:10a6:208:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 06:00:48 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:00:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 6/7] selftests: mptcp: reuse linkfail to make given size files
Date: Thu, 10 Feb 2022 14:00:30 +0800
Message-ID: <5c1d0827afbc4cc4c8335b447ad9d661b585b620.1644466571.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
References: <cover.1644466570.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:203:b0::30) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19cf9ee2-f6cf-4fb6-1610-08d9ec5aaf85
X-MS-TrafficTypeDiagnostic: AM0PR04MB5761:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5761508C64238D2F004C91A6F82F9@AM0PR04MB5761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dVW4PZQO9foYcDvIH4nTlN/XtNJB3w9meTaEi9gqAv7prFNG19V6bQ6hDA9jrsdxluxDulT5yJFsvB6FtShFHOFvef5UZskJPZbIuwaLavtooU5/FFfHRPCB8ob5gpHuxYyj63ng2sbhjc9G/jHO0Nr2Glvcfl/ll1Hkp8VivYljMDY6qu7qaCFkvyRQWHq/qO1DAYrIL7WDqnqplFn6GUWwCrB74wSW0GgM1rD1lmpaUPuAFXNdG8JWr9wo4vWLFSXUYAbIzDLfhiNKkVQWfAIL/71vZqI+f6QbYkVLSBEOMmHTxaS0N/R5QiV5Z8NaOUApT+qXXpkT0N9xaX7ecsO8g/3tEP9t0ckuG7cdPr0w37W1diQzhsJ2PpdqWLpfwaJPYWSicgfUuIU33ZqHS5uS0/Q2ehPt2vWrWrLlNcb8B/vFKr4/aIHh/uNvR8he350YVSsB5bl8Rlk8k5JP41VuJenC/ves1GoMbtE7c7Rd+bBDLdUWK0loRVjDs8OOtuZaaeqLusg63eLqPFOvOc/88UoFhUwF9AUX4MJYp1JENi9Xu22EC7RfdtkM/CzHB2hSKXYa0V2u+biV1+thP+oWsLv/fKOXly+AzNdIjFp1FdnzR55vCgHlEaNbn5VFP7XVgUTPPj8XRlGBRa0qpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(36756003)(86362001)(55236004)(66946007)(6512007)(6916009)(66476007)(66556008)(6506007)(8936002)(6666004)(8676002)(44832011)(4326008)(2906002)(508600001)(2616005)(26005)(5660300002)(38100700002)(6486002)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1fU1//SP1EAT/x02WaqqX5uckCHB3hG8vxuL6lnIw6EL9zAbyxVet57/MPa?=
 =?us-ascii?Q?8LOdIEwUyDHn/SA4Tsc3LC/BUIQX/SeVi6T1aSfUE/lB1V9SuoNFXeJ4qztv?=
 =?us-ascii?Q?n3k5Jw7UqAduXjUvMjPEQEFyBXfeSfRkBl7IyJa/o+f4cgegAUMyxdZ1JPD1?=
 =?us-ascii?Q?MoYOPgtvQx6onU+znAbLovqUJTKDQCG5+eUN4NnLswTLIm1qjFjgA7cH+FDF?=
 =?us-ascii?Q?zYV2VZH1m497i1Jnsynor5eTdIfEo6njN7QndIEocuKGweuaiYU0GoPvETrb?=
 =?us-ascii?Q?fh5RHpG3f9xKqPfqoldYarluPq8GiMstOeNlneNIj3z9WPYrYRIwu6inn/Mi?=
 =?us-ascii?Q?q9O4PZpC5pvZWA5KyllIg94hzUeDqjr7RmmNKD6H/f1Eiy6ZljfZJwbV3Z+d?=
 =?us-ascii?Q?zRV1TT6R/UTkZ6syJQ/vSqleND4UAv3+qPhUUYsIMrT/V77IQI1ebikceFwO?=
 =?us-ascii?Q?TdigL9ksABmCHFDt8zhmkZFmqpmnhHiBsD6Px2KScdtdF7K8h8Ju8M7q1tD9?=
 =?us-ascii?Q?O0qd37X+p1Cd5lm1tmeNU6Au3oARu3k9XNpT9eFCeeaoYAe4zyytB85JMH3L?=
 =?us-ascii?Q?nmvO9vkeHr+K/5kLA9kPj/vMCL3ndVd2lXkJyvwlb/bnC6/JfE8/W6IKGOsR?=
 =?us-ascii?Q?LTk3I4YVl+RWBvWueTi3xO8DkoHREQglboVexz6QdI65NndK6N0UvC963c9/?=
 =?us-ascii?Q?MimnUEsH+WunyAvugJ3MTRPfAHe3BwXynvOFyfq7SRmDdQhURrWiWTbiz3UF?=
 =?us-ascii?Q?qY7Nn0TklVAgHTBrlOAJu6kRHX6YM/4mZeShr0/hSocM1sfUxq3mWxc1uxYK?=
 =?us-ascii?Q?NWfC5shYFuyd/KH4KWQcFPj91eoayiSkSGnJbUd92RkTSNW2iT+NkA7Er2kv?=
 =?us-ascii?Q?OARIQHFbQuDQ23jLfr4QAq9gyXLeoxdI0qJeoAtYBabdl05Q7o6SeUtPJ80Q?=
 =?us-ascii?Q?5Gla6CGEPWHLeZq4rOfLAbXUQZEBkUYWqgXxqXooRidlDz4l2nF3ZHDBWpkA?=
 =?us-ascii?Q?vSdfiBvDvX4KRs+FhjWftWmf5/545esft/1ovyjxV1h/rgrO0FLovMy2Jz23?=
 =?us-ascii?Q?dTyycllqnpBNg7BoEUzGk8hVSKm0o10ZY2o4uXBBDUqwtI5CAHC2q8OD3QjJ?=
 =?us-ascii?Q?XJ54usWA3AcPGQgZeE/uPYpegpzLId/BqonLY8WP05gJoVv+4GHPnMI8e5/X?=
 =?us-ascii?Q?g7WjRKh3dxnsUX4dqkKynpi37AOGFrHi0HkVkFRTZ+R4SyZE9yQLWNKJOYwd?=
 =?us-ascii?Q?aoFk8kCggvx6DToJVFqU1t74EB9vJNk4BUb/aS5qnuInhLl8di6eH0ZedezR?=
 =?us-ascii?Q?v0oBDJ6q4tnUvItj3+cK2ka6x9jHMYMXl5ZN4YUPb0u/DVX135SbXdFahVaw?=
 =?us-ascii?Q?IlNRqnwwIdpXAmu7t+yLBH1BLDpLkXyYiRhtf7EtoMH8XAwodQTSqQy81LNz?=
 =?us-ascii?Q?86fD1U71bnxH6sQzftaVO+ibYHgIjVS11QNlkvGvXvIKHgPsLvKC/LWuJU6H?=
 =?us-ascii?Q?Jw9UElTWPPQ26hCd9m/aWVHs8inKbJsWHJVUeKra/pvGjwESSurvxLsS4/G2?=
 =?us-ascii?Q?OEN959v0rplWdsygwKPeZrjofcERC9sznoY1c06VK3k07cStbz/tJA/2KJhF?=
 =?us-ascii?Q?n6D30yCoL9IG17pfuoUIRlQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cf9ee2-f6cf-4fb6-1610-08d9ec5aaf85
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:00:48.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2E+UaOPHiUtECTIn/CBIWuZ2KTjB0FYPJ3yzI+eO7OlwSfVn+DJCfe3zdHHNIrCX3FVshNlb7x73P8Dl3x0pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5761

This patch reused the test_linkfail values above 2 to make test files with
the given sizes (KB) for both the client side and the server side. It will
be used by the MP_FAIL testcases.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index c595b4613ddd..50a7f9a9b364 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -446,7 +446,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -466,13 +466,19 @@ do_transfer()
 			ip netns exec ${connector_ns} \
 				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$connect_addr < "$cin" > "$cout" &
-	else
+	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$connect_addr > "$cout" &
+	else
+		cat "$cinfail" | tee "$cinsent" | \
+		timeout ${timeout_test} \
+			ip netns exec ${connector_ns} \
+				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
@@ -632,7 +638,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -681,7 +687,12 @@ run_tests()
=20
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	if [ "$test_linkfail" -gt 2 ]; then
+		if [ -z "$cinfail" ]; then
+			cinfail=3D$(mktemp)
+		fi
+		make_file "$cinfail" "client" $test_linkfail
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -694,7 +705,12 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
=20
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -gt 2 ]; then
+		if [ -z "$sinfail" ]; then
+			sinfail=3D$(mktemp)
+		fi
+		make_file "$sinfail" "server" $test_linkfail
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
 		size=3D$((size*2048))
--=20
2.34.1

