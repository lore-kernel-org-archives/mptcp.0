Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6F2CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHcDEPxnyMnKV3a2BtZEZGz+vRw7U3fSeeWs0CJJg4c=;
	b=CQ22grnSKw/9XDa47B4PDSz8FtntuihGjsaie6bzkxG5mtidLVslFRQB+t1uF0sNH0jBzq
	dRU2gzN3ZniibyIk/Xc7IbN5wgC/6iUQ0yfl8jDly2qNEWqcI1LTnrofrOyyn/inYcjS2L
	sF6tsPk9ptsWRSeXdR1/c00ISZj0Aa4=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-3z3phdYlPmSOjsPZCzIzYA-1; Sun, 16 Jan 2022 09:18:49 +0100
X-MC-Unique: 3z3phdYlPmSOjsPZCzIzYA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ/YHw2DrXqhZNH4OzorDpMptSnTTmOMfyWSQZF/XX+x9iltUqq9ljtzD5l9uxo+a/akVdf87gvip+mgLK1rp0ugYwOxRVjgEUJt1AjUb3rOCJZsO5sNpfknD6Y/goGEwBs3QffiP3YJCKuZKteIANJg1OnqCdlyt2XA4175VGVe3fJ/RcCW+fzYdltCNGi5xt7s/wAieUSeHJy9E4xinIfGj3B9MiSqZ5f/h8ltrztnq03414eFwvQOBjjfJihGFgWwoAaUmNzed9ZWJNryd4ArnpO/fwAlPn4kVFrI81Nb15j8VKfB9aIQIRkJr2w7E5yfW7SSYgBV0iZoYSIcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpEVVoQar9bpbrhxJy6bKqqlBRlQR9Fo95MEDyi9Q0s=;
 b=IhZtU98mV2EnQABaT+9V2lqHyVGTGvVeQhsk5KeMK7RKDDJTZiuJ09QHzFkS+9B5vIE26Fa6d5av2FEz08XbX4KT9nbVry4JeJoa13WOpgE3Of3u46lf1k3K9eZ3XERh2OVB9Brjd610wUZuN3EqLYNZFuyl8Cdg08KWwZhIz02Mp1hqSZKe/SMmYJ0DrGzJDpDvdDc+HTFXTK3VRlFy6QhBhX6DMEzBe1gKzZ1QXWRY1WNUbo0FK2Ep6qwrVGVaKjmof5P7hE7X/CRhW94LYnI7VqQ4mmpH6slDsHz4ZV33bCu53HOiZ1aaJE2TBuT0xHjHVfP/I9K5e8KQoZnwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR04MB3047.eurprd04.prod.outlook.com (2603:10a6:6:a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Sun, 16 Jan 2022 08:18:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 07/10] selftests: mptcp: add ip mptcp wrappers
Date: Sun, 16 Jan 2022 16:17:37 +0800
Message-ID: <34b264a811f34963d8bdf7377860cac8376d9267.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5e35426-6cbd-4ef1-dd3b-08d9d8c8d030
X-MS-TrafficTypeDiagnostic: DB6PR04MB3047:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR04MB304781A68169CDE779AB4A05F8569@DB6PR04MB3047.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0uZbzWH4alQlSdPty7Z9ax+HWPUDhDAukhDBKWcbao8QI+XClr7aJWuQVRqSG2d2MNPsV2T7ieGwP4j9f0awLYpOCGth1Q5NbPnABh2GojlMdvRM83N1RWoblmHtXnON0AV0IBDssu025J9eVjhuApcqoKL14EeaJF4Xhrsns5gObJhts5KGde9nImb4mOZWaC4IhGFmnt+2bKsal+0C9mvz4XaklF/ymSTmBEdsUmS+GJro5vl5lE61lp0aG+xnfAvXpeJqjPG3cALIZm9zLEw4E/LqUyPuIpAdOYZjyw3sF+U+kyEeNiRnj8Vd+qQWnvOJN5DTf4Yn0Qwi5yds+i3UoeUj+/xIbgz6Fx1V7C6ZbLM8MgiuncS03hyz85+tKVs+7tkz4plXxPa4derCeXu9p0ZQaTiaZfQHosZ+qGF8t0SB5/q0Jg3IGavEn6b2x4gcrGpGKWUNT7dWk7WxhG9iv13PEYuCFfV4MkG81TKA3TZ/A+N2dMI3m1B5BaDt6cY7gMdz9Sw+Z5M+CKIsSuGEfTaUL8rt/Yls1sgbCwuFZnIvTFp8c0oltqHZtjIGJHBCYGNOKgzxxgWlCzfJrLE+zE9ovaZKVqd/60jzy7V0DpWAvlEkccwiWrjavYR3Nu+jSCtGDRJS9m4HE8/xfVe1Ln3B82J8Blz5UKj/Yx0fIcQ5BYHAx+BcIRuqkxha
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(4326008)(8936002)(6512007)(5660300002)(6506007)(83380400001)(86362001)(508600001)(6666004)(6916009)(44832011)(36756003)(30864003)(8676002)(66556008)(186003)(66476007)(66946007)(6486002)(2906002)(38100700002)(316002)(2616005)(13296009)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCdIhcFjhdO4xuCzxRbVei5G4anaL0qfRRl5+QFo5a4tmt2dgCG17RpuD3YK?=
 =?us-ascii?Q?I3XcBhgs9GGSR9jOO03KlTZnro7TbgcfJjGFkDbb5QZKihWMWGaG/SSwxsA4?=
 =?us-ascii?Q?wl9aiP2MGr9jMNhzJwd5pSEosmyKjexr+a5ynjioOioK6ONoC+9Cj2bmGxlq?=
 =?us-ascii?Q?5lIYBNQCTESkJ0WuwxyIEh2n5AcG6GwKSnaNvYZopLb6D/lCdxe63JJzYBsM?=
 =?us-ascii?Q?9K6y59LSQFOvmO34XuVb+Umoc78JwUb6WCfBbW9wySLf8jbEvCWfQXGvsYTY?=
 =?us-ascii?Q?JUuRptiFbJg5hw1zDxQ/+C16QFzcVyoGQDOUIiNFbATBFI2iWC7Sm4XhiXWc?=
 =?us-ascii?Q?QO8feriF+649v1banEDstepQcyJj7JS8PirqSeZJUl3jnRWonr51fEbSvpsz?=
 =?us-ascii?Q?zNQFpyrOCZNTt1ohIbqe6tBhNfQ9I55a/4Qe3uY5VxbX4OQO01fEvAISCpc4?=
 =?us-ascii?Q?uWMfRYLG8CLSg7rmZo/tPJrL2aHtu5vPzJB2zz2UF81GmTd4afiovEA8QmBd?=
 =?us-ascii?Q?JKsFtwz0TJFDxb2zu+BYKN+5qaoyu7bMmWtMlBJxY7OuZ1NnbM6viNWcN00B?=
 =?us-ascii?Q?a/1H/8qeUk4JC4kfv6ZvwlfdCtEp8X2z3BPolQLbl3QnFzIIXrkx7p+hO7CA?=
 =?us-ascii?Q?6Qbw5ol9i0ngsHfa1XeizEE+lApPFHWFGss0CC6SXdCG6mnR6aHpSOeZTJSB?=
 =?us-ascii?Q?J3sgkZf3KZbe58Wj7PX4eU0qs7jc8WbMpxAQUo62cTZgQexEhsiWyvOD7cvH?=
 =?us-ascii?Q?4W7G9cEePoTNgdXtBL3U9yunQffh6gxlVM/cep4/9aYLuelDk76zrC3yO5/K?=
 =?us-ascii?Q?3CcPhA5Nz1R71Nd+bZ8b8IdGgvaFiLyJHne80DETQBXu9ZHMLnhjb0gZBtZT?=
 =?us-ascii?Q?dsGbFjEw76n2Q2NBZQ+vjGW7mnoce2HC9EtYFrmPpRDKRqcFas70NU806A0T?=
 =?us-ascii?Q?LCddVrdzB+5wVOUkHHHa7m04DjB+g3hMb9+MtRiB0fx1hf3G0sQ5PZEa+q1Y?=
 =?us-ascii?Q?I/gwo8Tcyt4GTg1HizH3JzXkYKqXI5wY9lA17b19BQERXKWrnZnHTUtH6W7G?=
 =?us-ascii?Q?3Mk5A8vNHC7vSJLjcNM1ANDXDD+Gbe2uV6sHJA89WHF/kqixMIJaXkwEFqlK?=
 =?us-ascii?Q?PgOM73NCYAhzSv1niTBSAFsBdRHz0VZw59kHvnqB3hR9bPiBx7NGhIIZYZXT?=
 =?us-ascii?Q?ZLVWRtm1fhatsloIGEgoRvqm9mcw+EOgwN2NyUNo5VzURIiv0w8M5TIllWaY?=
 =?us-ascii?Q?DN45d1MYWPLMOAw4ZHXrc2YnvRejEKK/KkJ6H7vCoRo9hRGwTU25cJRrDMYJ?=
 =?us-ascii?Q?pH/MPIAfiw18mn2rgs8fC9Xqt21yWGCoC0ke8X8+j9HA1by2yZyXctlpK0Vg?=
 =?us-ascii?Q?Ox+ZjamlffFCvG8IFWfxHIgT9PfdN7pRAg+FFDxg6haI2V7mDxCRJxoLwtVJ?=
 =?us-ascii?Q?0n57ESGmruar6DVZgEXx3/Q0BW9TpA3WPfAjSAe9o73YS/evFUcM0r3lmis0?=
 =?us-ascii?Q?OaaZ721lOK3BIe5NBlUE534ttfjyZ+j4fnuQnyEqDkI9oRvv5Umiupy8nkGo?=
 =?us-ascii?Q?BOL2Mnm1waS6h1z3jIXlLEJ8zIFB0PNs62HLl+3laFEhFkGBRerr68Fv9GE5?=
 =?us-ascii?Q?XEwAgIYThnTR2nHtWJa8AIs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e35426-6cbd-4ef1-dd3b-08d9d8c8d030
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:45.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPlYHVlgdvegJ8hhsna4R5dBRs50FnahCpiEHYhKbxKAZ4+L9VCWjfbiDFbiCp2u2OIeAYwzUapTWOHoLPNCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3047

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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 773 ++++++++++--------
 1 file changed, 425 insertions(+), 348 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index bb5fa814c05a..143cf1ced488 100755
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
@@ -296,6 +297,82 @@ wait_rm_addr()
 	done
 }
=20
+pm_nl_set_limits()
+{
+	local ns=3D$1
+	local addrs=3D$2
+	local subflows=3D$3
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp limits set add_addr_accepted $addrs subflows $subflows
+	else
+		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
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
+		ip -n $ns mptcp endpoint add $addr ${_flags//","/" "} $dev $id $port
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
@@ -396,7 +473,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.1"
 			fi
-			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			let counter+=3D1
 			let add_nr_ns1-=3D1
 		done
@@ -411,16 +488,16 @@ do_transfer()
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
@@ -444,7 +521,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			let counter+=3D1
 			let add_nr_ns2-=3D1
 		done
@@ -460,14 +537,14 @@ do_transfer()
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
@@ -475,7 +552,7 @@ do_transfer()
 			else
 				addr=3D"10.0.1.2"
 			fi
-			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
+			pm_nl_del_endpoint ${connector_ns} 0 $addr
 		fi
 	fi
=20
@@ -1042,51 +1119,51 @@ subflows_tests()
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
@@ -1096,28 +1173,28 @@ subflows_error_tests()
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
@@ -1126,9 +1203,9 @@ subflows_error_tests()
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
@@ -1138,7 +1215,7 @@ subflows_error_tests()
=20
 	# mpj subflow will be in TW after the reset
 	wait_for_tw $ns2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	wait
=20
 	# additional subflow could be created only if the PM select
@@ -1150,16 +1227,16 @@ signal_address_tests()
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
@@ -1169,59 +1246,59 @@ signal_address_tests()
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
@@ -1241,11 +1318,11 @@ link_failure_tests()
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
@@ -1255,11 +1332,11 @@ link_failure_tests()
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
@@ -1269,11 +1346,11 @@ link_failure_tests()
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
@@ -1283,10 +1360,10 @@ link_failure_tests()
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
@@ -1298,10 +1375,10 @@ link_failure_tests()
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
@@ -1313,38 +1390,38 @@ add_addr_timeout_tests()
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
@@ -1354,28 +1431,28 @@ remove_tests()
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
@@ -1383,10 +1460,10 @@ remove_tests()
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
@@ -1394,11 +1471,11 @@ remove_tests()
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
@@ -1406,11 +1483,11 @@ remove_tests()
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
@@ -1418,11 +1495,11 @@ remove_tests()
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
@@ -1430,11 +1507,11 @@ remove_tests()
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
@@ -1442,22 +1519,22 @@ remove_tests()
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
@@ -1465,11 +1542,11 @@ remove_tests()
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
@@ -1477,18 +1554,18 @@ remove_tests()
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
@@ -1499,37 +1576,37 @@ add_tests()
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
@@ -1539,33 +1616,33 @@ ipv6_tests()
 {
 	# subflow IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subfl=
ow
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
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
@@ -1573,10 +1650,10 @@ ipv6_tests()
=20
 	# subflow and signal IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subfl=
ow
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+	pm_nl_set_limits $ns2 1 2
+	pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
 	chk_add_nr 1 1
@@ -1587,76 +1664,76 @@ v4mapped_tests()
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
@@ -1665,18 +1742,18 @@ backup_tests()
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
@@ -1684,9 +1761,9 @@ backup_tests()
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
@@ -1697,28 +1774,28 @@ add_addr_ports_tests()
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
@@ -1726,10 +1803,10 @@ add_addr_ports_tests()
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
@@ -1737,11 +1814,11 @@ add_addr_ports_tests()
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
@@ -1749,20 +1826,20 @@ add_addr_ports_tests()
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
@@ -1772,56 +1849,56 @@ syncookies_tests()
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
@@ -1831,29 +1908,29 @@ checksum_tests()
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
@@ -1862,26 +1939,26 @@ deny_join_id0_tests()
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
@@ -1889,28 +1966,28 @@ deny_join_id0_tests()
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
@@ -1921,10 +1998,10 @@ fullmesh_tests()
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
@@ -1933,9 +2010,9 @@ fullmesh_tests()
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
@@ -1944,9 +2021,9 @@ fullmesh_tests()
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
@@ -1956,36 +2033,36 @@ fullmesh_tests()
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
 	chk_rm_nr 0 1
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
 	chk_rm_nr 0 1
=20
 	# set backup,fullmesh flags
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	pm_nl_set_limits $ns1 4 4
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
+	pm_nl_set_limits $ns2 4 4
 	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
 	chk_join_nr "set backup,fullmesh flags test" 2 2 2
 	chk_prio_nr 0 1
@@ -1993,9 +2070,9 @@ fullmesh_tests()
=20
 	# set nobackup,nofullmesh flags
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,backup,fullmesh
+	pm_nl_set_limits $ns1 4 4
+	pm_nl_set_limits $ns2 4 4
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
 	chk_join_nr "set nobackup,nofullmesh flags test" 2 2 2
 	chk_prio_nr 0 1
@@ -2007,9 +2084,9 @@ userspace_tests()
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
@@ -2017,9 +2094,9 @@ userspace_tests()
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
@@ -2027,27 +2104,27 @@ userspace_tests()
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
@@ -2056,9 +2133,9 @@ userspace_tests()
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

