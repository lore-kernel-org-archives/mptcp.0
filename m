Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE62C80
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 02:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641868991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FzgqWuOgujU7L/mMbuNeNUe7VSs3RTomwqI5vCc1AE=;
	b=VzcaV6xW3m+7cTBuvRzKyA5+8uwGb9AQ+IiXKoMAjfNeehx3R9McuHm21VbWk47ZT5jT4A
	XXfB1qei2oqUKwoA4xysbNzAgm58dsyxfrIa8Ls+f7Hs4XjB+HD9nQC2gytC1FUgUZGPBG
	uCGfgnJuX2tDHPHBTude36OzhSKSEcs=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-vAsUIYZiM4iquxyEadxt9g-1; Tue, 11 Jan 2022 03:43:10 +0100
X-MC-Unique: vAsUIYZiM4iquxyEadxt9g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbhYkdfFHxr3OFbdrWuLK1dbGG0lU1X3nJcWPMFlMsBSkAehxVmq+ji93Hfjhk+QM9LPPVLF3F1Y3Ig5HvkNp8V8AN3Od73NyyTJZUabOhnoegGPdpsVIY2Tgtfm9yUmdpryj3vt+1X/V4jnJaTLFQVoX0ldJUvaCIYl4ckJO7QBVcWKlB4vI10nVEXBaKXoZeFolU99Q8Fe+urO3Fh8a3SyotPKSIVj9xwIVKBIgfSv67zsyZrTpXEvAtP/TdA9m0wruNIfGBJ1Vc41eN2pLureQ18jff/9H5ttkrHBZ+yRc6ZK8zEFjXhSBSGCune+GnYkEcIvYuPfO7Vdk3b5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7zWy8YeVCdtS5+QwES3go8pRir2OVJ08EI5/VJpOtE=;
 b=nph1c1odnwwD17mFqcE4sD2WOryA/nqtu6L2iHadkjIxnaV6G5bEqo/jIVehgBUKyYTK23cw0q5d5423cB0WtoTm5D6pGg9H5cFiK4oO7Rfue5MVvGjyO+WlPt3VAfeZG9zfI8mCimuzQ5PgsFRdNwUHHLi4ognM8SentqSipCPIXEPchBj+Wtxg4dyBrz2i3E4idPbuTmkZ4AnZDlFCdNDjWrZQYDXuTmeOuQB0yobZyYskWzOK83BZAJ/38FVWj2PTsAhxVM1BsR4bDozqWc4MFgtIPF9t5YOWwqR6LKpZSuzT5elaizXHn5n9Q8XXl/xuYDnH7obGELCI8dXUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3435.eurprd04.prod.outlook.com (2603:10a6:7:8a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 02:43:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 02:43:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: add fullmesh setting tests
Date: Tue, 11 Jan 2022 10:42:47 +0800
Message-ID: <5f14e091bd93e2940754b100e76c6657f1343d35.1641868545.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641868545.git.geliang.tang@suse.com>
References: <cover.1641868545.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e693a31-2673-4621-206b-08d9d4ac1a77
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3435:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB34358D987429B3397265330CF8519@HE1PR0402MB3435.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OUdesGW4FRFOtvXrLs4GOdg75roY+vTGPCCGkW2Oo7TqJFZ12jBtjLWNxmgunutR7bEZ1EaAD2Fwfrg3+Llhyn0DJAzVTykbKqpBN9/FN8OGVu33pRzyVyrfkGjAaWmHINYyxLY6+7FQ/G6euQ9+x3wic/dQORaQMfptr9J/CRxPk10hWX7BfMduvZPQQ2hSuvtEYt4qWs7CMazH8+krF32UN7Z6CHQIg7N2OBEHqoQ0o5g1axfNF8gOy+TLGUhXIDQ3uZhvZR6++nkM0H1Z2yyYTr17kqjtWJi9fVlvNbMPP1O1hY80C17Px/puOs4xGj4lZOmvejVfLCvECbai+Nvov0lwfw1UR9a06bGHeVaogfuKoybios1NWUGd5YZrPFR9ZAGfI/ctPswdW0JW2RIZkpu6v/mNeebpVzRatjUuGkYfQE+F+sMY5+3hTboka/AHNEOjYHMIEJqnmnGYailFPnRw6mnaafcKceYWx3zAjFWpNMrS/LaW3iQFaZHVM1Zd+5f4Y6y2Cja4NSgFE9/yO9ZdbVI0OE/JBR/AxB96clPknMMda/F/HVX/3pEjhXkNlKLs7KXDxqE0t5Qo/ApGsSRihOVb00HPBWZrs4mujLHZPyt78LosPcgiybfa9OvKL3qHqtKu9GdVm/LolQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(2616005)(8936002)(6512007)(6506007)(508600001)(8676002)(86362001)(107886003)(38100700002)(2906002)(316002)(83380400001)(6916009)(44832011)(66556008)(66946007)(5660300002)(4326008)(66476007)(6486002)(6666004)(186003)(26005)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?feqHJZdQjh5Odaiipv1c2ey4CdsnU1pdXw5aqpmT/05zlte+asfjR/X6sucd?=
 =?us-ascii?Q?IjspAbzbW0x7Rvm+AxrhoBrh208GYfFbq8rNBwLfYkVRdw02mYEfpETwJcWi?=
 =?us-ascii?Q?BmjS9YCJ2xYxGp5JjyxXjrkeKw+n69pUELO+doxQ8b/hfojdElaNzuYk2cRc?=
 =?us-ascii?Q?wawOOh9ll0B8sCtMT+nFG8P6JJxvW5a7AWCyZoYzX11Rl2muvbyvTh7ODMIz?=
 =?us-ascii?Q?UbLAcI8uznEbkZaJ+2WS7fIvVOIxhHp49CHLCpXE9Ss2Q+iriWvuN8PL5Jdh?=
 =?us-ascii?Q?4SHR8+MjGjnHYCUV8m1ip7OLw8zGF0aw3E0e5gpA87l0aF8cdYte8Ge38XcB?=
 =?us-ascii?Q?u4FPuhKOhjyvr1WbLI269RJ6ytUqG/5bvHo8WcPRQKepy7P9k8nwIj9dD4Pj?=
 =?us-ascii?Q?HcJF7A60bje1v0bakJsEn7ZGJ3zXoryDeN0H9BL1AktMB4fKTrBQBxqunixE?=
 =?us-ascii?Q?PFUTd734LRDGan4CR4CoasN8YsGZEGrGuJdn4Wgi6WKsTMijavsH5KeHd4Pk?=
 =?us-ascii?Q?3VXqKn5s5m9gZdvQGInshJoVnwZKtYpv+8bIpZ7V8Bu4lduEVwSnkJD+NO4Y?=
 =?us-ascii?Q?6I8i1PHFYWUUmjnEZg64bzfcwJQ9uVN5R69RsKzm+Dcx4pftSpC0SsMMnLhJ?=
 =?us-ascii?Q?40SzszFEq+YM50RebdoEyvYhYyp3lTMH6Bjvbx/+b1rv4Hd2h+GBsztw3waA?=
 =?us-ascii?Q?YlfLjd3oyps4JoUaxQaUvYsE+agZ7TTaCnkWgmhwhqEXB4/EtR+SUu59bvSa?=
 =?us-ascii?Q?ZntyhdcW8I0Wt/XKn6NdDDoFevB7xUq8uUlPb6SA5AhhGctjdnI/rOl3rEt+?=
 =?us-ascii?Q?GvhCWCM8hTS5jj4wEXXiRzsA3fYgPMkRtUgu9sF589pLEPW0EVAhdpG2C3T3?=
 =?us-ascii?Q?kWXNZQRLjPnB8JqfGSCyP5SVw7mCmr4rFk5EY1vzLqmRq/DQANY8ZVnEzW/P?=
 =?us-ascii?Q?eUJzbD0J+soQyGnw27ttgu1X+n1xeg4WRn2IDBuwT553BtLA+nDvmqgBp1Sx?=
 =?us-ascii?Q?G6wItcaoEOfb8muasQE2A+gM1KDSqo2uz8qu0yVyQiJaMh1p21i2HvshGcTr?=
 =?us-ascii?Q?vNDHALJmXkAoMgVbecY/FncMkDVkGhAqyGelsSizTfS3kmwgTJQ+zR7SWAxW?=
 =?us-ascii?Q?W0j2Hzx5u0seVnrHr/HdYgFFQ2VpWbQppJMzNtKaCVzge9mwYopsx/7n9NtU?=
 =?us-ascii?Q?CNJb6MHIXx4WHCJ+2sAOMczB4rqKMbuIyiD8jfxvl1p7PhnFF5cryB2qoBND?=
 =?us-ascii?Q?AHF0M+3kv63QgWSLjiD7WXh4rIWFMco6JLzuGKa4Vtv6+L1I3LQWuZfII3Ga?=
 =?us-ascii?Q?kYuFZmXa7XvEapZgFsHCbKxmPlcRLEmv2EVsjXHntamMzTl2gxLWZL6SkxTC?=
 =?us-ascii?Q?4l6evw5M9dJmjL/ij6TF7utb3TXw88LZ77B+CaKiLuowCVMgeo/XsDVHN3vw?=
 =?us-ascii?Q?UlSIvepjvcKx/8KnUFjm6OxkyYITZulmNR2MGA7iOJWzx6F+lSILRRL4O/WF?=
 =?us-ascii?Q?XkC+CKTuUANalz4lSkDtfWTdB2mfuKCMhBYsJNIFY0rBqJp9pOqZxUEaaIE9?=
 =?us-ascii?Q?fOFKUQtxk+UE29rDTNB9Y+VvTVypvb0mRaiBBlJeZDma5tkXjJ81YTWbLkcr?=
 =?us-ascii?Q?RmUY8LbeXA+GfYUr95U6L0k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e693a31-2673-4621-206b-08d9d4ac1a77
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 02:43:09.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhLPbt3ucA2zseBwl2T2zuzD/2AaOvkKIUtH1L6qy+1EkijfxMdj344rWwdVPUlr//wZis0bvYwugLJEGIVzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3435

This patch added the fullmesh setting and clearing selftests in
mptcp_join.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..2868e2657ca1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -289,7 +289,7 @@ do_transfer()
 	addr_nr_ns1=3D"$7"
 	addr_nr_ns2=3D"$8"
 	speed=3D"$9"
-	bkup=3D"${10}"
+	sflags=3D"${10}"
=20
 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -461,13 +461,13 @@ do_transfer()
 		fi
 	fi
=20
-	if [ ! -z $bkup ]; then
+	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
 			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
 				addr=3D${dump[${#dump[@]} - 1]}
-				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup"
+				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags"
 				$backup
 			fi
 		done
@@ -545,7 +545,7 @@ run_tests()
 	addr_nr_ns1=3D"${5:-0}"
 	addr_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
-	bkup=3D"${8:-""}"
+	sflags=3D"${8:-""}"
 	lret=3D0
 	oldin=3D""
=20
@@ -574,7 +574,7 @@ run_tests()
 	fi
=20
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${bkup}
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
 	lret=3D$?
 }
=20
@@ -1921,6 +1921,24 @@ fullmesh_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
+
+	# set fullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+	chk_join_nr "set fullmesh flag test" 2 2 2
+	chk_rm_nr 1 1
+
+	# set nofullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+	chk_join_nr "set nofullmesh flag test" 2 2 2
+	chk_rm_nr 1 1
 }
=20
 userspace_tests()
--=20
2.31.1

