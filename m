Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F32C9C
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642066168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ToJrZJTrgjSf+ni5qiFHsf2/XjPxWG6WsBWyQ40Dmis=;
	b=f4jZpF3BZ/6Re2DWWzaxYie3aT5ja5kn450bZsnReRLnqkiT+cj8ZRqlxbkHD+OQnOG1w8
	0XPmKeA664trRgdr3wiE2/rttL3LiDNOp9LmIIXz0XSfKINOR7mBGjq3HOl+rjooAvTRPD
	mIvIUY817Yu4SXYj7GOu2uEQ3oWBKrw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-tYzGbFFkNUSOsRzybaV8jA-1; Thu, 13 Jan 2022 10:29:27 +0100
X-MC-Unique: tYzGbFFkNUSOsRzybaV8jA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag7fGWxvNdpEgVIPOFvta3U2k2w8BHTT8CehCkrIanCQJ8LyRUkh857M/UgGVLMQNUSb573hirkJcv2sMiaLMLf70OsEZDhf+VBpnN7cvlPOrb/ztAS2XMTBRnl0An9qfzx7KxtEc8/qOEtsmHDAZvvkAwOM4ia4fEhvElPt4KPBs/SI9t6qtDXeBDRBBuSFboHrDQdZgKshXxQS+oFSrbSkVEmle4acOBdSc62ijDjDYa+qrSgUNEK4MBSLFyhiI7VE8DKqSEH15gQt7P89+oSJfldswM1UK1t7LKLw3B/j4PW7sdTjW8Y+P1zIwa5NlScJtY/dPfI7an7IX/5f5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4BdXkBc//yzDLdSZJbatpJi67oMv0lJidcqnmcLz0Q=;
 b=bVfsWZZ2uXiYzPJfXJ7BvdZ0P69ApNpmcINpsCaijwpSlkJDnTWqDrchTuDynTbgepKWT3v03pGQEs4JGJgoUcgiv35vctlnLg96oC0dUgU7e8QGq60356AcUH8jB+A+Axk1bP2s3ePMkcKM33l0fUlemd63eFzIVZjolp3JuV/CKp6MCsXP8GW14ZQAPV8o5/loBrcX2tTLh8a3DPXyVe4hiKbNhwnottAa4LWS6dlTnAoOS9eWbD/e3q1LisYIpCN0Bp6oD24+A08efoSQEZTF1g/e2GsVZ/Zv/Bp657rSYIH4JcVylIOh2RapOtTzLDeO+9fh8nF/OtjZph2dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB3199.eurprd04.prod.outlook.com (2603:10a6:802:3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 09:29:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:29:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/5] selftests: mptcp: add ip mptcp wrappers
Date: Thu, 13 Jan 2022 17:29:02 +0800
Message-ID: <0e2f2b0ff5aaa523d4cdc532196a19f08633e5f2.1642065488.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642065488.git.geliang.tang@suse.com>
References: <cover.1642065488.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:202:2e::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d877407a-8692-4291-34f1-08d9d6772ea6
X-MS-TrafficTypeDiagnostic: VI1PR04MB3199:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB3199239C4AF28AA0DF999A05F8539@VI1PR04MB3199.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FqzS7efJsxN5EKP5jPn5ewT6LiQ0R9WJ2sur3V0WH1rjfTumkibRyaRnz/zXrjqQGnsZccBXNsSz7rCGHVpKEAh4KxnFNkYBHBtx/nbmXZ+X03Hob6g7EDOil9difZVWHl8QiQ/KHnjM/yA2Gj8qBhGgmHgdLOHz+m2dvA54tSUTlRIwMCpUldcQnbrdrYmQxmZqajA3zCye/bUf1/OWj4oSAXA0VwKWadDLeiVN5nMXxuZ4zLawaAaDKcZ8tF4wANdq/WKOZKYKKc/AIj556gx9hiGI0pu38EDEOemaNzvYYHcP05mf+E6s6FQK/Lj59iTfy6YOIsr062hLbPbfkCWHUeMhb+S5DY3Dbn32jNkEvuHOuzxoemtOYTIFPLHqTLNqtp7aLXuGnbZ2EzZmpP+glh0bwceqD7tqK9tSUORezxn6Kfvzz3DoWV09XWloDW/0i2Shaju2tGpvj5ylSiVzvUt6kea7jw5HPcR7Kks39hThZdbOwFSy3XHPJnue2gLOG1aGL9Xm5B9Rmr2xCH7i5lUE02Czf8iqNFyrlYpew/JhMXtCY68DCj70I57RnaXDT1i8ZH/jp0juIc40b2j0eFq4Ed4+0Q3cLrVtcPY3a49Hl/Ehwu5oLIBMmLSqSlIl6gOceOmIrCJb73pgOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(508600001)(2906002)(5660300002)(8936002)(6506007)(8676002)(86362001)(38100700002)(66946007)(6512007)(66476007)(107886003)(316002)(4326008)(55236004)(83380400001)(44832011)(6486002)(2616005)(26005)(6916009)(30864003)(186003)(66556008)(36756003)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EQwiGIdHrCIXruw8ylMQyYzompbicnJ449J5oIcaJuyDtdHmSgzYa4zq7nBX?=
 =?us-ascii?Q?UT/K2XEEgpOWcjjfszYcodoFt6xx2AwtI3PERLFG2aTAHisqXU2/Bl3etHX/?=
 =?us-ascii?Q?LCJAh869r+tvrIk6t4qty0z0cUkntt3ymN9X/9zgqf4ozXgM+JcWclbc8shk?=
 =?us-ascii?Q?Fm80E803AUh60ffOOk2sbN/TzawYGrIMJ7nNVwJjENaR6dxc+VAyB+9kpnPC?=
 =?us-ascii?Q?3CrrrXD64C1ls3Ai6KMJZMpcoS96AAYOpp6+M7+NygrSn5Vsz+/zLr4AB8tK?=
 =?us-ascii?Q?zWTzi2sPzYbUOjCQtajtZR0z61FXcaMh7O5Z7ke/QU8e406RsPxc3JEJ8tAj?=
 =?us-ascii?Q?jt2zIRe4BOFwBlcvTNC//p1qWUnsOJS3ALkEtyV8CFOYHrp4+KkwY6S5jDeO?=
 =?us-ascii?Q?Td7O++BCCy4Schr7+xp8MUwNd3cL8yR/0ze9F0QYdftMvHqnXkMAUH5I/rVv?=
 =?us-ascii?Q?qb8cwjwnraVyQcOkQSnaM7hs/Pglpw4bCJcyOoISK31kqDwnlUFyPEerxMLm?=
 =?us-ascii?Q?cjH3qcqxNv9ic/TwNdtjVE6HixAaSdTrl8O3WfUGKd5T5D+AAvvBrjpvg5OU?=
 =?us-ascii?Q?xy9OHuqXqJ8bCLUGAPhRF3BffC1makA7Odj4TwT9BP6YCzma5JNQ7LcyDedR?=
 =?us-ascii?Q?lm1ccuL9C1gp16G+vQVvXVfngZw/KmcFGkyru3dkLVQedj1dnT07rgb/xVq3?=
 =?us-ascii?Q?cjrPQudx3iVxXQjgJRYbhvjOxFHpAWLZJbJtmqD7II8HXnnhnCkiK9cWmErd?=
 =?us-ascii?Q?KWzyhoRbWCvZMofIdFqRh17qqXRStazRnJN5rklm+0yDnnP5OMzcwXd0cgF6?=
 =?us-ascii?Q?QqK+Xd/0wPAhVGU7OSQ/Tb1AMGqHFAZjPr4UWmLkDywYXJ67LYcGIPej2lQt?=
 =?us-ascii?Q?glcROKTlEovfntnlFfnrrlk+TBgBxf5tkiO96bWKY2ONr6wy6X1Ew5uhGDWl?=
 =?us-ascii?Q?s7/t6iOyBBvKCMKcPK6xk7U7RWZEbbEBu+jhS3yJMw1dBGtevh9OkoSKv4Ej?=
 =?us-ascii?Q?1kw6XJUdIVLM1KtRm6AEOyghHJxRaK2XaScsBx7ekCtdpg2/Oj43z+QqqajK?=
 =?us-ascii?Q?5+5AupYJIV5RcN0R+4e1SBzDHPCsix8jOM/2MnKObH1C+04DAUwjfoXp2uzZ?=
 =?us-ascii?Q?XQiId1bJQbx7Dw4pgIxZCle71tLZL55wsxcYqqnWclU2Bq0CgVkfbzOdnwI9?=
 =?us-ascii?Q?/8yXfZWZdoYS32eTaSGdJVsJHBR7IJrNp4w6sSxRYKA6P31WfG1PnKtBiqlv?=
 =?us-ascii?Q?2Q0j3z1fne2yeUimqISWVuIeAP51kcFeGFFM+aDOXSeLNB4ClmJaBuNo3Uvb?=
 =?us-ascii?Q?jJej6fGW2JZwH1qHM2c9mJBe5fGX05ibDH71ysmr44Z4X9sGfhJQpkFx2drz?=
 =?us-ascii?Q?xxfzCr4+pyPTak8+BrGHow9yjDV53UpyqXAoYo9O++rcaASWXE+aFZ3QNr9X?=
 =?us-ascii?Q?jNR4eJY19F432T1nhIzXIf7jipNoyQz8/S32GneNloBvKlmjnZ8dRIJ2YHI2?=
 =?us-ascii?Q?lYr4umr46V+rmetNat5miHbSV+HltXD7fzdiqDpQjiA1C/WYOU7s0mH0Xjwc?=
 =?us-ascii?Q?lJpAIHsxuXcV9ac34remonbNULFYa91CZZ9UTyyh2ROF9MH6Db/X1NRVjlfs?=
 =?us-ascii?Q?ldaNOSgKYWqpim039JPl408=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d877407a-8692-4291-34f1-08d9d6772ea6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:29:22.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9GCZ6LWiQ2QzSi+jRAeT5FUkpbsuVz3lLgpOk+55b6hExQbz6fxSUQVUxAKv/KnskQs8zoACyM48G5K46/b/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3199

This patch added four basic 'ip mptcp' wrappers:

pm_nl_set_limits()
pm_nl_add_endpoint()
pm_nl_del_endpoint()
pm_nl_flush_endpoint().

Wraped the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in them, and
used a new argument 'ip_mptcp' to choose which one to use for setting the
PM limits, adding or deleting the PM endpoint.

Used the wrappers in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 761 ++++++++++--------
 1 file changed, 419 insertions(+), 342 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 1a751c86d956..e6492347d75d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -15,6 +15,7 @@ timeout_test=3D$((timeout_poll * 2 + 1))
 mptcp_connect=3D""
 capture=3D0
 checksum=3D0
+ip_mptcp=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
@@ -288,6 +289,82 @@ wait_rm_addr()
 	done
 }
=20
+pm_nl_set_limits()
+{
+	local ns=3D$1
+	local nr_addrs=3D$2
+	local nr_subflows=3D$3
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp limits set add_addr_accepted $nr_addrs subflows $nr_subf=
lows
+	else
+		ip netns exec $ns ./pm_nl_ctl limits $nr_addrs $nr_subflows
+	fi
+}
+
+pm_nl_add_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local flags
+	local port
+	local dev
+	local id
+	local nr=3D2
+
+	for p in $@
+	do
+		if [ $p =3D "flags" ]; then
+			eval _flags=3D\$"$nr"
+			[ ! -z $_flags ]; flags=3D"flags $_flags"
+		fi
+		if [ $p =3D "dev" ]; then
+			eval _dev=3D\$"$nr"
+			[ ! -z $_dev ]; dev=3D"dev $_dev"
+		fi
+		if [ $p =3D "id" ]; then
+			eval _id=3D\$"$nr"
+			[ ! -z $_id ]; id=3D"id $_id"
+		fi
+		if [ $p =3D "port" ]; then
+			eval _port=3D\$"$nr"
+			[ ! -z $_port ]; port=3D"port $_port"
+		fi
+
+		let nr+=3D1
+	done
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint add $addr ${_flags/,/ } $dev $id $port
+	else
+		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
+	fi
+}
+
+pm_nl_del_endpoint()
+{
+	local ns=3D$1
+	local id=3D$2
+	local addr=3D$3
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint delete id $id $addr
+	else
+		ip netns exec $ns ./pm_nl_ctl del $id $addr
+	fi
+}
+
+pm_nl_flush_endpoint()
+{
+	local ns=3D$1
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint flush
+	else
+		ip netns exec $ns ./pm_nl_ctl flush
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -388,7 +465,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.1"
 			fi
-			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			let counter+=3D1
 			let add_nr_ns1-=3D1
 		done
@@ -403,16 +480,16 @@ do_transfer()
 				do
 					id=3D${dump[$pos]}
 					rm_addr=3D$(rm_addr_count ${connector_ns})
-					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
+					pm_nl_del_endpoint ${listener_ns} $id
 					wait_rm_addr ${connector_ns} ${rm_addr}
 					let counter+=3D1
 					let pos+=3D5
 				done
 			fi
 		elif [ $rm_nr_ns1 -eq 8 ]; then
-			ip netns exec ${listener_ns} ./pm_nl_ctl flush
+			pm_nl_flush_endpoint ${listener_ns}
 		elif [ $rm_nr_ns1 -eq 9 ]; then
-			ip netns exec ${listener_ns} ./pm_nl_ctl del 0 ${connect_addr}
+			pm_nl_del_endpoint ${listener_ns} 0 ${connect_addr}
 		fi
 	fi
=20
@@ -436,7 +513,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			let counter+=3D1
 			let add_nr_ns2-=3D1
 		done
@@ -452,14 +529,14 @@ do_transfer()
 					# rm_addr are serialized, allow the previous one to complete
 					id=3D${dump[$pos]}
 					rm_addr=3D$(rm_addr_count ${listener_ns})
-					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
+					pm_nl_del_endpoint ${connector_ns} $id
 					wait_rm_addr ${listener_ns} ${rm_addr}
 					let counter+=3D1
 					let pos+=3D5
 				done
 			fi
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-			ip netns exec ${connector_ns} ./pm_nl_ctl flush
+			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -467,7 +544,7 @@ do_transfer()
 			else
 				addr=3D"10.0.1.2"
 			fi
-			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
+			pm_nl_del_endpoint ${connector_ns} 0 $addr
 		fi
 	fi
=20
@@ -1035,51 +1112,51 @@ subflows_tests()
=20
 	# subflow limited by client
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 0
+	pm_nl_set_limits $ns2 0 0
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by client" 0 0 0
=20
 	# subflow limited by server
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 0
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by server" 1 1 0
=20
 	# subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow" 1 1 1
=20
 	# multiple subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows" 2 2 2
=20
 	# multiple subflows limited by server
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows, limited by server" 2 2 1
=20
 	# single subflow, dev
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow dev ns2eth3
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow dev ns2eth3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, dev" 1 1 1
 }
@@ -1089,28 +1166,28 @@ subflows_error_tests()
 	# If a single subflow is configured, and matches the MPC src
 	# address, no additional subflow should be created
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
=20
 	# multiple subflows, with subflow creation error
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "multi subflows, with failing subflow" 1 1 1
=20
 	# multiple subflows, with subflow timeout on MPJ
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
@@ -1119,9 +1196,9 @@ subflows_error_tests()
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
=20
@@ -1131,7 +1208,7 @@ subflows_error_tests()
=20
 	# mpj subflow will be in TW after the reset
 	wait_for_tw $ns2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	wait
=20
 	# additional subflow could be created only if the PM select
@@ -1143,16 +1220,16 @@ signal_address_tests()
 {
 	# add_address, unused
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "unused signal address" 0 0 0
 	chk_add_nr 1 1
=20
 	# accept and use add_addr
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address" 1 1 1
 	chk_add_nr 1 1
@@ -1162,59 +1239,59 @@ signal_address_tests()
 	# belong to different subnets or one of the listed local address could be
 	# used for 'add_addr' subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal" 2 2 2
 	chk_add_nr 1 1
=20
 	# accept and use add_addr with additional subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_set_limits $ns1 0 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows and signal" 3 3 3
 	chk_add_nr 1 1
=20
 	# signal addresses
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal addresses" 3 3 3
 	chk_add_nr 3 3
=20
 	# signal invalid addresses
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
 	chk_add_nr 3 3
=20
 	# signal addresses race test
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
+	pm_nl_set_limits $ns1 4 4
+	pm_nl_set_limits $ns2 4 4
+	pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.1.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
=20
 	# the server will not signal the address terminating
@@ -1234,11 +1311,11 @@ link_failure_tests()
 	# active backup and link switch-over.
 	# Let's set some arbitrary (low) virtual link limits.
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	pm_nl_set_limits $ns1 0 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "multiple flows, signal, link failure" 3 3 3
 	chk_add_nr 1 1
@@ -1248,11 +1325,11 @@ link_failure_tests()
 	# for bidirectional transfer
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	pm_nl_set_limits $ns1 0 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
 	chk_add_nr 1 1
@@ -1262,11 +1339,11 @@ link_failure_tests()
 	# will never be used
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_set_limits $ns2 1 2
 	export FAILING_LINKS=3D"1"
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
 	chk_add_nr 1 1
@@ -1276,10 +1353,10 @@ link_failure_tests()
 	# the traffic
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_set_limits $ns2 1 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	export FAILING_LINKS=3D"1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup flow used, multi links fail" 2 2 2
@@ -1291,10 +1368,10 @@ link_failure_tests()
 	# for bidirectional transfer
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
@@ -1306,38 +1383,38 @@ add_addr_timeout_tests()
 {
 	# add_addr timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 4 0
=20
 	# add_addr timeout IPv6
 	reset_with_add_addr_timeout 6
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
 	chk_add_nr 4 0
=20
 	# signal addresses timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
=20
 	# signal invalid addresses timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 8 0
@@ -1347,28 +1424,28 @@ remove_tests()
 {
 	# single subflow, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "remove single subflow" 1 1 1
 	chk_rm_nr 1 1
=20
 	# multiple subflows, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 	chk_join_nr "remove multiple subflows" 2 2 2
 	chk_rm_nr 2 2
=20
 	# single address, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
 	chk_add_nr 1 1
@@ -1376,10 +1453,10 @@ remove_tests()
=20
 	# subflow and signal, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns2 1 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1387,11 +1464,11 @@ remove_tests()
=20
 	# subflows and signal, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_set_limits $ns1 0 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
 	chk_join_nr "remove subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1399,11 +1476,11 @@ remove_tests()
=20
 	# addresses remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1411,11 +1488,11 @@ remove_tests()
=20
 	# invalid addresses remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1423,11 +1500,11 @@ remove_tests()
=20
 	# subflows and signal, flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_set_limits $ns1 0 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1435,22 +1512,22 @@ remove_tests()
=20
 	# subflows flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_set_limits $ns2 3 3
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
 	chk_rm_nr 3 3
=20
 	# addresses flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1458,11 +1535,11 @@ remove_tests()
=20
 	# invalid addresses flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1470,18 +1547,18 @@ remove_tests()
=20
 	# remove id 0 subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
 	chk_join_nr "remove id 0 subflow" 1 1 1
 	chk_rm_nr 1 1
=20
 	# remove id 0 address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
 	chk_join_nr "remove id 0 address" 1 1 1
 	chk_add_nr 1 1
@@ -1492,37 +1569,37 @@ add_tests()
 {
 	# add single subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
 	chk_join_nr "add single subflow" 1 1 1
=20
 	# add signal address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "add signal address" 1 1 1
 	chk_add_nr 1 1
=20
 	# add multiple subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
 	chk_join_nr "add multiple subflows" 2 2 2
=20
 	# add multiple subflows IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
 	chk_join_nr "add multiple subflows IPv6" 2 2 2
=20
 	# add multiple addresses IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
 	chk_join_nr "add multiple addresses IPv6" 2 2 2
 	chk_add_nr 2 2
@@ -1532,33 +1609,33 @@ ipv6_tests()
 {
 	# subflow IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single subflow IPv6" 1 1 1
=20
 	# add_address, unused IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "unused signal address IPv6" 0 0 0
 	chk_add_nr 1 1
=20
 	# signal address IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single address IPv6" 1 1 1
 	chk_add_nr 1 1
=20
 	# single address IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
 	chk_join_nr "remove single address IPv6" 1 1 1
 	chk_add_nr 1 1
@@ -1566,10 +1643,10 @@ ipv6_tests()
=20
 	# subflow and signal IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+	pm_nl_set_limits $ns2 1 2
+	pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
 	chk_add_nr 1 1
@@ -1580,76 +1657,76 @@ v4mapped_tests()
 {
 	# subflow IPv4-mapped to IPv4-mapped
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow IPv4-mapped" 1 1 1
=20
 	# signal address IPv4-mapped with IPv4-mapped sk
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address IPv4-mapped" 1 1 1
 	chk_add_nr 1 1
=20
 	# subflow v4-map-v6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow v4-map-v6" 1 1 1
=20
 	# signal address v4-map-v6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address v4-map-v6" 1 1 1
 	chk_add_nr 1 1
=20
 	# subflow v6-map-v4
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow v6-map-v4" 1 1 1
=20
 	# signal address v6-map-v4
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address v6-map-v4" 1 1 1
 	chk_add_nr 1 1
=20
 	# no subflow IPv6 to v4 address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
=20
 	# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
=20
 	# no subflow IPv4 to v6 address, no need to slow down too then
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1
 	chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
 }
@@ -1658,9 +1735,9 @@ backup_tests()
 {
 	# single subflow, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
 	chk_prio_nr 0 1
@@ -1668,9 +1745,9 @@ backup_tests()
=20
 	# single address, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
@@ -1679,9 +1756,9 @@ backup_tests()
=20
 	# single address with port, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address with port, backup" 1 1 1
 	chk_add_nr 1 1
@@ -1692,28 +1769,28 @@ add_addr_ports_tests()
 {
 	# signal address with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with port" 1 1 1
 	chk_add_nr 1 1 1
=20
 	# subflow and signal with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
=20
 	# single address with port, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address with port" 1 1 1
 	chk_add_nr 1 1 1
@@ -1721,10 +1798,10 @@ add_addr_ports_tests()
=20
 	# subflow and signal with port, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_set_limits $ns2 1 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
@@ -1732,11 +1809,11 @@ add_addr_ports_tests()
=20
 	# subflows and signal with port, flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_set_limits $ns1 0 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
@@ -1744,20 +1821,20 @@ add_addr_ports_tests()
=20
 	# multiple addresses with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10100
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with port" 2 2 2
 	chk_add_nr 2 2 2
=20
 	# multiple addresses with ports
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10101
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with ports" 2 2 2
 	chk_add_nr 2 2 2
@@ -1767,56 +1844,56 @@ syncookies_tests()
 {
 	# single subflow, syncookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow with syn cookies" 1 1 1
=20
 	# multiple subflows with syn cookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows with syn cookies" 2 2 2
=20
 	# multiple subflows limited by server
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflows limited by server w cookies" 2 1 1
=20
 	# test signal address with cookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with syn cookies" 1 1 1
 	chk_add_nr 1 1
=20
 	# test cookie with subflow and signal
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal w cookies" 2 2 2
 	chk_add_nr 1 1
=20
 	# accept and use add_addr with additional subflows
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_set_limits $ns1 0 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflows and signal w. cookies" 3 3 3
 	chk_add_nr 1 1
@@ -1826,29 +1903,29 @@ checksum_tests()
 {
 	# checksum test 0 0
 	reset_with_checksum 0 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 0 0"
=20
 	# checksum test 1 1
 	reset_with_checksum 1 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 1 1"
=20
 	# checksum test 0 1
 	reset_with_checksum 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 0 1"
=20
 	# checksum test 1 0
 	reset_with_checksum 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 1 0"
 }
@@ -1857,26 +1934,26 @@ deny_join_id0_tests()
 {
 	# subflow allow join id0 ns1
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
=20
 	# subflow allow join id0 ns2
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
=20
 	# signal address allow join id0 ns1
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns1" 1 1 1
 	chk_add_nr 1 1
@@ -1884,28 +1961,28 @@ deny_join_id0_tests()
 	# signal address allow join id0 ns2
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns2" 1 1 1
 	chk_add_nr 1 1
=20
 	# subflow and address allow join id0 ns1
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_set_limits $ns2 2 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 1" 2 2 2
=20
 	# subflow and address allow join id0 ns2
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_set_limits $ns2 2 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
@@ -1916,10 +1993,10 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added before the connection,
 	# 1 non-fullmesh addr in ns1, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	pm_nl_set_limits $ns1 0 4
+	pm_nl_set_limits $ns2 1 4
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "fullmesh test 2x1" 4 4 4
 	chk_add_nr 1 1
@@ -1928,9 +2005,9 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 1 fullmesh addr in ns2, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 1 3
+	pm_nl_set_limits $ns2 1 3
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 	chk_join_nr "fullmesh test 1x1" 3 3 3
 	chk_add_nr 1 1
@@ -1939,9 +2016,9 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 2 fullmesh addrs in ns2, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 2 5
+	pm_nl_set_limits $ns2 1 5
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2" 5 5 5
 	chk_add_nr 1 1
@@ -1951,18 +2028,18 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added during the connection,
 	# limit max_subflows to 4.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 2 4
+	pm_nl_set_limits $ns2 1 4
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
=20
 	# set fullmesh flag
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	pm_nl_set_limits $ns1 4 4
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
+	pm_nl_set_limits $ns2 4 4
 	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
 	chk_join_nr "set fullmesh flag test" 2 2 2
 	chk_prio_nr 0 1
@@ -1970,9 +2047,9 @@ fullmesh_tests()
=20
 	# set nofullmesh flag
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow,fullmesh
-	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	pm_nl_set_limits $ns1 4 4
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
+	pm_nl_set_limits $ns2 4 4
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
 	chk_join_nr "set nofullmesh flag test" 2 2 2
 	chk_prio_nr 0 1
@@ -1984,9 +2061,9 @@ userspace_tests()
 	# userspace pm type prevents add_addr
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
 	chk_add_nr 0 0
@@ -1994,9 +2071,9 @@ userspace_tests()
 	# userspace pm type echoes add_addr
 	reset
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
 	chk_add_nr 1 1
@@ -2004,27 +2081,27 @@ userspace_tests()
 	# userspace pm type rejects join
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type rejects join" 1 1 0
=20
 	# userspace pm type does not send join
 	reset
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type does not send join" 0 0 0
=20
 	# userspace pm type prevents mp_prio
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
 	chk_prio_nr 0 0
@@ -2033,9 +2110,9 @@ userspace_tests()
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
 	chk_rm_nr 0 0
--=20
2.31.1

