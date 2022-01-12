Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53185173
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641980062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21iFVFM1j7k1KNRe+IyIJkYZqOcqfBxG0Pmd0DyatNQ=;
	b=BJHgiYlW+cZYOzLXETu2ERvbQEfiRFDZRda9yzPYDYeruL3a1KMzXhSioesCGPXye7BYTw
	LlqgB4s9i9attlUEcwohTSHUICF5eClgmLvExr32AKpdfoJbX/68fVCpOFcatgvD5vFBa0
	obqr6yV9FJyLEOMvntgL+8DPAoLLhYY=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-bAkx5AwWMgGr-RVR2oSxOA-1; Wed, 12 Jan 2022 10:34:21 +0100
X-MC-Unique: bAkx5AwWMgGr-RVR2oSxOA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8gmDH1pSsLaiTWgKUPd4OCo6oMzeK3jKyA9Os0Ly789XlmlNa1PBzYppCqbKmKBSUIlA/Ia4qOTiZzMEYCWMtFh4lEm38OckKSeOVnsq/6dxfWARKhsIkK1JAjakzr+Z7BhpCBDF+SiDsIr5uTDZWzWyy/YCwvNxaiNjFv/UguNDboOcNIG5PyRqAGIlSh7JIOcHNDHTxzzny57vwve/NaLaPUoCcrQv30SkioAn13vPMBGr3NdpvIl7VjhGTN5MJ+4maEhOwnpTfSnR1i0W90QOorA4Hg6p5dcZu8sLpQHEmqibqZrxIQWtZnKWO3u0+ITTRU96/S+SiI2l/GbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0KUL35iMsz+zXxp5glPl+szQs8JW2VjbnKn9G7H/r4=;
 b=Jr4YhfqmRsPsHslmYc3b+CSxsMMRQ5yO7Wnngtq44bJWqgE31FgjOZPExYQAHnrnYPgavHOiposHmgGfDXoYl2UyH0Pk5X9xWl9e5nkT/TpbOnZyG7xHQ+uK3k3DsmTB/FkDajZXD1GkDrrF3+Uw++iPCtHQzd3rx9xciO6ss/puHaKE5HhQrwGmoN+qzQVyIVg5K1l4F+P2R0jNVDCyd/gfxCmsebkUD8Ln7FdjL9ZI+64gFYO/fhZX3nARSggRvZ4Vgq4pZteKkwKUh65xC0gkBk8xgcgc6JTAgJ6JjaNoP0Q4gZBprt/0wQvmGxKKTT4XSn3a9sR6w0b9sUVtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 09:34:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 09:34:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/4] selftests: mptcp: add fullmesh setting tests
Date: Wed, 12 Jan 2022 17:33:51 +0800
Message-ID: <6881741312c5e16161a575dbcea19efe2def6e03.1641978967.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641978967.git.geliang.tang@suse.com>
References: <cover.1641978967.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5fb91d6-61f1-44c2-2e39-08d9d5aeb5cc
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4290BEA6BFAEB617F05EE278F8529@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zvCnr/WY6HKrmTpbJatQICFr+fRMkyQmQYwrJITp4G5w6g4JBM2Fb7U8oWBfqqpMdE3IyQuPl3X7E3Sv8HLVbysyVxfRXqyLpSnYH83NkqwmLoBRBn9VcarCFfT6Gl7lUa6Uqwj660Hpoatqmh+0jnc05MlDz24McOzuZLC3N9356AZFVvKy9PPReSkuHXj6PJ8suPYB6ZcYY2c47RbQc3DG2QA2HXuP5cvKek0N9yO6+dg8Iiqct2aeqPmlGRSqnsK/w6kaGReS2jHk4ar2emJzWjv9ultPR4UKI4twLVaknW2TEb4ywUzeJkhcuZ3sf8BlXMmpEc5lnJ7CheUVAwR5dpSzBuW+3DRIzCcW0HZl/XUlr9YrJdzac9kTEGLOs395YVksOwUQKZbyRYHIX+YSmHmp1Oj50R4PBziTsXAx2gJQZwpwWxeTHV+JkV2yISAt00UjeDS/PxQpZJPS/xe89uUPeXxN72skekZIO9EvrEiu+A3SaX7IwVJneH386NfOmOO5sSVymCu+/xE501TkZ55fTA4znmbtJHq6Qqxa8RI1ETP8HRhHzojNJEk19tgipdIbAuLUPzSWaKiu47VJ1E5+TAJRHrg0eag0My3T5Ptr3igJM29jwaOeWME5m0Pnc0VQi+7puhy9xapvAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(6506007)(6916009)(6486002)(26005)(4326008)(83380400001)(186003)(316002)(8676002)(38100700002)(66946007)(86362001)(5660300002)(508600001)(6512007)(8936002)(6666004)(2906002)(44832011)(66556008)(66476007)(2616005)(107886003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNwd6oLH0u8EJiTYTrh3BI0piGLX7UqRGEtrtGP3GxbcCZnBUOXe3UnW/C8U?=
 =?us-ascii?Q?7QmExuNGBtyKB0SgwEQbopm9K4UtAYRd4KLD8zluBQriiGzUBnvqAWynjaCb?=
 =?us-ascii?Q?KeTRhZUNzEUrNej+tkaOqRqa6TxCPe8UM1AquWaA2hVhBiA/gE36vAvjcxsO?=
 =?us-ascii?Q?RxMiRpiD6Y+WDoT+xWmmlp+D85tdS/gOkAhtbhkhn4GOg/SwxnR6rs1M4PGQ?=
 =?us-ascii?Q?ssLhdM5ATjmPMPM+TkcpBUeBRrCFSw6G45k+KOYMv0IJD+E6RIbjITB8FMZE?=
 =?us-ascii?Q?A4LL6qzGKNEJ2OPuv0oYVnXJBnlkRwI6gu1sGN4ulkVp18s/Wgvyc/yER/sk?=
 =?us-ascii?Q?ddqGGiJa+qvxK5dAL3coQ2PqJKGB6z2QalWfWj72P7GbpKi6sGYiGsxFptlG?=
 =?us-ascii?Q?tC4T05iBtXyU6vCPmvHSuQEQ53Fq/isUQmMwljoxEPnFsAFMtLMQSssptEyL?=
 =?us-ascii?Q?CXOnT/nw8JlsfEjnxIkZsM6qrC+jwRXCA7/FxB5wIeMcSQ8o8goSqj09Nn0W?=
 =?us-ascii?Q?hDo2YD0Ad9cSoc7FbZ/vMYv4NO5eCjTj93KmZ7fRCY/q9qDqKNuSLLBqI1rg?=
 =?us-ascii?Q?H6rMaz8e6E+AQ+G4A7LL3g1Ywxh+ww5YfPM/V0iH54CDOeiTtZOrBwdMOcDC?=
 =?us-ascii?Q?WDHTMBXPVCy5rGvePL4Kpu5uPQrd4VMHUbgBcHSjbukxHVLQg2/s3ZFyRX0J?=
 =?us-ascii?Q?dtIFiL64ns7Hh/Ktyca6JLtvAaxd4UvyrCvklie3K618cy9FNiLO8l2MJBXN?=
 =?us-ascii?Q?1o+v7YA5vRrCv2WdvVaV4aKUAD70972HhgE/2GVGPtvhAvnp9yYILhEjCXEz?=
 =?us-ascii?Q?kSNTinkssI+iquEiio/0sWel+/iX2qruJHKLsghYx1E9gkGN74g4mEtjSD4d?=
 =?us-ascii?Q?1YYn94QU9gmlSN8uEB4ovJeGIs3b/fsgR/fOuWdLbB9f3s02tWeZIXEvlZ7p?=
 =?us-ascii?Q?tNH9a9/6Ifb1+hg3fb42qNf5AIa/oX2dgJRiKzmozt1Vy837y071fOVCTs+3?=
 =?us-ascii?Q?x1rB1SIxUSPfDTSMRMnUdphFBY2IvNGo+LE7JWRypn/n6UbTGBBqF1IKUKNE?=
 =?us-ascii?Q?TQdBYN0YvxZVpA+VlweZ5I8odF0Du7xN0W85Cayu2D2JwY6EdarjqGpS4XXZ?=
 =?us-ascii?Q?cfDnA8IuH3SZsnmh+djR0l1ONK04NfxPAmg1tMOBxnHrw3D0svOA0dxhJWpH?=
 =?us-ascii?Q?SbowXp1EV7gpaDTZi0UlzCCmrqLDTr1cfpsNqeojdYF/BlANIDls92eoI5C1?=
 =?us-ascii?Q?vfSvCNYZZl1a7yxRxKbmmTNCbNfJRQbxlVxNSN3GdueAVKf8ErB5R3jtmjIp?=
 =?us-ascii?Q?007XbwP6tdZoMyfXlaI6mDX6KyWSibPhg+FMMa5xqHFx3gAB5yPTy9adhwrd?=
 =?us-ascii?Q?oECjdY+JcWlOZ+4yXTRKhfemebHeg1qEewnU11icE227yR+/r9Hqhcg192EB?=
 =?us-ascii?Q?bS7suhFhrmEH1RlPaAQ9eKQSQlSSL9Xi1jURcs71U8PYm9Bjg0rLtalW5uQ7?=
 =?us-ascii?Q?EsUjcBgrWiFqblsY5p89vpARQj1OzSx56q9ukQHRvUUrKCti1o2QNYMTRDTo?=
 =?us-ascii?Q?IzU+3+LhNG5BGtKvxFqodiUxl951fAddneNwTf/yDz85kquIHwJ3r2CdojNj?=
 =?us-ascii?Q?Y1cV0YEFTeLSA3danPJvXtM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fb91d6-61f1-44c2-2e39-08d9d5aeb5cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 09:34:20.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seDOwSDrDaapZ6sM9O5Lb75hPjirTIUzz98OV4FrDLaWetXy0HAIL+9pYd5507TbuBcTZTq97UC5VWRon8CjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290

This patch added the fullmesh setting and clearing selftests in
mptcp_join.sh.

Now we can set both backup and fullmesh flags, so avoid using the
words 'backup' and 'bkup'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..25725be98342 100755
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
@@ -461,14 +461,13 @@ do_transfer()
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
-				$backup
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
 			fi
 		done
 	fi
@@ -545,7 +544,7 @@ run_tests()
 	addr_nr_ns1=3D"${5:-0}"
 	addr_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
-	bkup=3D"${8:-""}"
+	sflags=3D"${8:-""}"
 	lret=3D0
 	oldin=3D""
=20
@@ -574,7 +573,7 @@ run_tests()
 	fi
=20
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${bkup}
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
 	lret=3D$?
 }
=20
@@ -1640,6 +1639,7 @@ backup_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
 	chk_prio_nr 0 1
+	chk_rm_nr 0 1
=20
 	# single address, backup
 	reset
@@ -1650,6 +1650,7 @@ backup_tests()
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
 	chk_prio_nr 1 0
+	chk_rm_nr 0 0
 }
=20
 add_addr_ports_tests()
@@ -1921,6 +1922,26 @@ fullmesh_tests()
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
+	chk_prio_nr 0 1
+	chk_rm_nr 0 1
+
+	# set nofullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+	chk_join_nr "set nofullmesh flag test" 2 2 2
+	chk_prio_nr 0 1
+	chk_rm_nr 0 1
 }
=20
 userspace_tests()
--=20
2.31.1

