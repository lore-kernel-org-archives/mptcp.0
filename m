Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C72C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrQSPz3zRN2b2H7A/MUUj/os+XGbVVO1bEx4irTaHwM=;
	b=hAl++MurihjNa9KD21pXQuKbsjwGZjpnPB3jmXos+jU/Whotzj0O42e4SaeuHflmxrPZO0
	pjk66fBKSYIEPxo5cyP7gaLUEVCAPBiRp45zhxJieMktOKn0jjmPvK5T/gYZ6MiKZBPyxe
	hAfr1qKhYOv16VIhgIdAGRAFC9TBluM=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-29i6__-JNwKPeB0ayOJOyw-1; Fri, 14 Jan 2022 11:27:09 +0100
X-MC-Unique: 29i6__-JNwKPeB0ayOJOyw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyOGpFYEbjQxiFy2QmTOjeLv4ocZF4yiwmDfDvLh7NovHT5n8Al7hViJT/EmSyg/AhCO4EfX207RRVEbXVe0RBtE8fYS9AwRbsLTpFfL6auOZ5BLzGRLrLOFlFgmAjYVeu6VcbJ0PswIQHYYS3avz1zHJxp5noff9PxDp0kOQMAssVGN9CRKSnIMJSqKrXBZbadVpZo2Ow+p3p8OHjdiKHIFQKG86LdAJbrpD3n484djtX3jZsctsUZjWm6bVT+fE9HbYbgGTY+g3oCdASM3k3RNgsDu4MqMHhyVHW5MFizzrgszopFcWK8spLAmJtVqsmYJvhitJwm1UvjVnSMqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96eBrbPswxSsJepKyE0ofVP8Ku9aw8pjkQAZLe0zlMc=;
 b=SI9x8lrBV235jEEWUlf80Dduo25DMi/98ljVT4hlKJfs9FnAr/X9pH8gjX8rRt+hPILN3qZ8a6iIU9Y6d31C2aFKx/ISsVH9yytjfzpL9xk2gHIo7Fv745hXDdnoZxvcGfaoEu4L1Ku5jDi14fNqIjehqntugT1XgxvXefVfxmzXpHzzepYDFxaaIQgzyhOaHVJSlEGqfe4bPZYEmIKfo3hsx1aMd7siP5SZavqdPAyo7/YthS9rOjPxtq1xhU2rW/oDAu1BKAdyBXhWX4pgoxtNHMGR6f4kYGuRwm0jC+YNF3XGhuw1IWUh+4Croscm6BwfB+sCg1mnm+khpbrLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4317.eurprd04.prod.outlook.com (2603:10a6:803:3f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:27:06 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:27:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 03/11] selftests: mptcp: add fullmesh setting tests
Date: Fri, 14 Jan 2022 18:26:22 +0800
Message-ID: <9faa0a7cc6df3469d98dc902bcfc472bd300cec3.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f3d844a-589e-42cb-a178-08d9d7486a00
X-MS-TrafficTypeDiagnostic: VI1PR04MB4317:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB43177A887F0539DB48518B71F8549@VI1PR04MB4317.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b1fkUsbaeiQh+4PO/qqb9I4oqNXE/1tNenhgwUj/RMaNa66HYu1lw39IulJhu9nrqnAGRodB0JXOIdVa17aawV9z72IPGEOtp1jMoHgPLP4RtvqpyAGZufT7wz7Pj7ZF2WJ/Rua6RcSnjPA7t8FSxRM8AmY8veib2m0BsmGR773x5ojK7GB7s9U3nbzSlf8t3EzcR29Q8xj1v30XqGMUEOfnDHvtv8tPhDSekJ7P9p0YMn/ZOA4vSVJPbyTbBiK7SAsqHN7PXhq1A/zLkB5HfLtDB7fNhkqauJqhgPl6Z2g322KzuyVqAQBN96xC+IjBdX9UTLSOnsKaSRcVTXBGYJ4CNm0e3D89eqiMcvl7brzYwvju6GosYkhSfBoYmIh/WYmkVYUYOROpYPdpXYHSWXKEHgtjW4J8OEZvWoA7aPNBZ/Lz81YgkzGBCJhRFYRwhMjAk42d7/eMapGr3MjgZDUxE3/hDrwo/4iFvcileAaF+A1Dr3sxj/LGW+Zbqd0FHRB9VAuRs8Rx9YPbQh5yQV4hbJd6hGyiM56EZn6i2G763fwehIra/RV9fI8NlBAuPqwhY79vBUkZFKOSenG4Fb3mBY8LR2TyZi1kDD2tXiaHdnR2nvOkzxi1kBUzoxZgQI9vxLtO3n5RlqNzQSF4eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(55236004)(66946007)(508600001)(8936002)(6512007)(6506007)(26005)(2906002)(107886003)(83380400001)(66476007)(5660300002)(36756003)(8676002)(186003)(38100700002)(6486002)(6916009)(2616005)(4326008)(66556008)(44832011)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w6rHqaIvyDmYd3lRF6Dwi8ZuTguvK9F9c6OZ+wvisnrvaSn0504CRzTzzUGH?=
 =?us-ascii?Q?HxupaP7T8oLquuEdtssFruk/3IC3LDYerrIvbNVPBAk+YMiXTifffH4JeC58?=
 =?us-ascii?Q?ZX+O/1PbR3x5k7e3LZvBbpnctm2TUmHjBmDwkQDwERaFrkWdHspSjh4tyL/6?=
 =?us-ascii?Q?c4fKygpj4KtrSYuPCZMhUt2EyU6ajbRrm6DRsHhwxHQrvRWLv3NDWfYXb3E+?=
 =?us-ascii?Q?owZX1H3XxWVoDDUTf7j3u8QCPLgzZwa2E5tAqjG6zXuUxCWNcuTdQb5ZFCIS?=
 =?us-ascii?Q?Q6kjPvINSzvgNbkyHfNhTNK7wnkLegR5BptYbL/HNvKE8hehWIADuzkJTHEj?=
 =?us-ascii?Q?rruS6Y7qsGGz1S5g8imSftvqlqfWl8PSobZR8mCCvCHwp8dvMH2o7yI1wuBX?=
 =?us-ascii?Q?feLzwwoUCAtRHDTxbDIWnadNbRdc/OMKpZhVLZkfGoK0YpXqN4DoHC9mWoyO?=
 =?us-ascii?Q?h6ahVLQqHICSYVbuI60n+sJSG1tHSNGnaQS+8QjEzxiSdeARZQ763lxOJBAL?=
 =?us-ascii?Q?3PKCZsRE2PDvCrAeAW+a/5W/Ron0MlKmfl4LMDf5Pvw05qoxR8VXK01x77Gb?=
 =?us-ascii?Q?P59SrN/L/B1F+SbLZw2OXw2pO2q1wHWB9CvCm+63b5dcmSILzx4CeARt8EWC?=
 =?us-ascii?Q?7u31Nh0gzROYTtnbMw/sKmPfxGzEegOwWs39zvh3IYW/AZD0+NVhGTDlSk5l?=
 =?us-ascii?Q?MffUq1qMYCPtDCZ9I+NaNIYHxUHxdVTBC4wG8sRn+wxT3P/zlFDkUyyWCRVp?=
 =?us-ascii?Q?k64hZ4wWL7jE5dYNtHaSfTezncD49JPGGZ6CozSczJaeO8noJD5vSAcJiq+H?=
 =?us-ascii?Q?ODleMcdll3AUk9QuLzgDuUAyzXLJqwaUgQNOxdN493pcqRZUqdYsjn+n8W3P?=
 =?us-ascii?Q?Q2PidiNHYkj9W/Ikwc+YFlcJVzoaElqaDDYloHAXNDJ5XYw/JMD+YjkGv+yf?=
 =?us-ascii?Q?WYlwidM/2sX73uFwRJ2F6uWjYNuL/oPJur5td8LFYm/7fEhzgYx6Rhb0nBi2?=
 =?us-ascii?Q?bkBsDQUcWP2BT85ZUR0cJYBMau+DH6LjOtwvTEUtUuEgbnkjEtHWWq6XskFT?=
 =?us-ascii?Q?e6CtzNryMSMM2hcamTNlT6s77j7AfuXXrVDX5j0eaQzncGoV9NHf1ah1yu2z?=
 =?us-ascii?Q?RahSyZFzfeE2AVEyIHG1NbaZcsIcspzkLwcvoS2YQuCxsvTUjDyjGUFOJrik?=
 =?us-ascii?Q?C+9BmZL1KBKtOid0laEbO22OCJdPnWeuCufxRQtTG6aF/mBANEhTVkHNmzgT?=
 =?us-ascii?Q?/3Ls1qcf8vZyf/CdixlNQbK9fyELWREHhcPhMOZPXGzch/XVBxnvnwlwRNV7?=
 =?us-ascii?Q?+sJaBdc9+ATs567vv8CPxCH7P2UpAt94avOcRN17/3obaamZOJUvSBgGDfhw?=
 =?us-ascii?Q?0th2btsQmSdOF//W5/utn7RjIJz0lEImhhReocULAZq5kRB/X51vOymXQ5FB?=
 =?us-ascii?Q?D+/WvFTm2s/hRr0ra0x3ztX5TP6SK8olVjhiuADizDZeKALmj7ddIPL99xEH?=
 =?us-ascii?Q?7z+lNQQ2WIY8b34BCMFmrhejaae9ZUU9wPtnUa495zbZDmy65C2tfBSElYTW?=
 =?us-ascii?Q?cgfq8v/i+wZCGwr9WtCU0BwtbqVP4FEhXCgXHDsVOJTGQHe/Y4ACHR4sSNDa?=
 =?us-ascii?Q?GIdzxNQw3TJANyiJg2nqLOM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3d844a-589e-42cb-a178-08d9d7486a00
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:27:06.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMA+6Qu0Nc3/J/NV7crLLe34T4dnVMrbP0X1hr9Ha/gdveNcz7jdjX+leOCRn+si6ToESpT2EBwAQfkoo/oo2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317

This patch added the fullmesh setting and clearing selftests in
mptcp_join.sh.

Now we can set both backup and fullmesh flags, so avoid using the
words 'backup' and 'bkup'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 53 ++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2be3cad4b52b..8286ef2f76d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -290,7 +290,7 @@ do_transfer()
 	addr_nr_ns1=3D"$7"
 	addr_nr_ns2=3D"$8"
 	speed=3D"$9"
-	bkup=3D"${10}"
+	sflags=3D"${10}"
=20
 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -462,14 +462,13 @@ do_transfer()
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
@@ -546,7 +545,7 @@ run_tests()
 	addr_nr_ns1=3D"${5:-0}"
 	addr_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
-	bkup=3D"${8:-""}"
+	sflags=3D"${8:-""}"
 	lret=3D0
 	oldin=3D""
=20
@@ -575,7 +574,7 @@ run_tests()
 	fi
=20
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${bkup}
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
 	lret=3D$?
 }
=20
@@ -1641,6 +1640,7 @@ backup_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
 	chk_prio_nr 0 1
+	chk_rm_nr 0 1
=20
 	# single address, backup
 	reset
@@ -1651,6 +1651,7 @@ backup_tests()
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
 	chk_prio_nr 1 0
+	chk_rm_nr 0 0
 }
=20
 add_addr_ports_tests()
@@ -1922,6 +1923,46 @@ fullmesh_tests()
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
+	chk_prio_nr 0 0
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
+
+	# set nobackup,nofullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow,backup,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nobackup,nofullmesh
+	chk_join_nr "set nobackup,nofullmesh flag test" 2 2 2
+	chk_prio_nr 0 1
+	chk_rm_nr 0 1
+
+	# set backup,fullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+	chk_join_nr "set backup,fullmesh flag test" 2 2 2
+	chk_prio_nr 0 1
+	chk_rm_nr 0 1
 }
=20
 userspace_tests()
--=20
2.31.1

