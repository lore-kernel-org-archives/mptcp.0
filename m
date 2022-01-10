Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F983173
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641785444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdUxTxTriFY0q9foxoKdNLMxFVzuwMMxraHJPFPVAl4=;
	b=CBHOrT3SuWlafkbSYO7+YeAL83KDvKYZgjXwbEGQ8mx+UZWH/9ehJy0ZiRIcLchBLS8NYu
	OJyOkMcp+6Kqnr4a9N0pkfaQwIZnB5mDwqvxAa3274XPMhGcxHpYp/syRXHHd2Rb/pDook
	9424+9cMKYl6XAB/ilpDXR0UNfocj3A=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-VBKabdjzO4WGkxW_x_yUeQ-1; Mon, 10 Jan 2022 04:30:43 +0100
X-MC-Unique: VBKabdjzO4WGkxW_x_yUeQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT+r2EcK3sI44Jeb1DKcxc0WCqisNknUCSPU9fl5r65Y7YVA4NKVyrHDp83AlP1IGwcdTQiZLxalajfedIDU1R9kIy2kSZaHMHeVCmyCK1gEOBQGoVL4guCNVKlBS4QGQacKmNtqHDCYGkn7cvkcwcgl+EQW2B/RxrYXeaxV6iVDp87O93tOk/Tf7yjcw4GzV0QqB7wcjli+ThXqYKqycMd0lvUOGzA1dR97TgxkrBQwb+0lhWJ+qm1cpg20mKecDb+Z/Mxn55AtPwFWuly0pGCn//ew58OXdRT9vL1uSIvcXduI7Vxa8SvAnlwJd2X6qdncD9PLIel/giJbaJqDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyQ6WyScsbCpxUtMvIl3UMi7fwCGOX+QsfqVwdJAeLI=;
 b=fWX9SlgGtxXgADYtVjD8keecusO7c4Jhp4z0hHB9Uudt1+OiMNDbn6yE/YwJwOzJRDQIfgqqW8ppVrGwghnrfl0a6v80gwo454PUkY8tmg5/wX95zOdG/DfvFInDcXGuTzOGf/J+Yu6SaPuvw7Hc88J+N4vtoqeJFOSh3FyNGno6mFk3Mpy2OxhPBHqOJckSKTDWyEreBm7I1d4VnHCOSwKFbr9CGuYj2zWUCRVaC6ynbXaZnefs8qq2x3+BiuWyVcuZCKm1zh44EoiTOPRSHtNZK4V5NzLPr+ntkeuMua2gjSEu+osWiy46rNSPUaiLiUjl9jQ01H2B8qiv6eiyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2569.eurprd04.prod.outlook.com (2603:10a6:3:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:30:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:30:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/7] selftests: mptcp: add clear_flags in mptcp_join.sh
Date: Mon, 10 Jan 2022 11:30:02 +0800
Message-ID: <c159f7112bab81994a38c673ca3ff91ce724a7d5.1641785106.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:3:1::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d3b99ef-f008-47f5-53e2-08d9d3e99481
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2569:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25694E22D9CE7A7FD952A23EF8509@HE1PR0401MB2569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bYtZd2ix90O6t5y0Qha0l2BLv2q9LqT/8JTZy+iAA+IOg/fjZG/vVmfDMC0dJkt79wHvgttLezBJEfKBgwjElk3JlyecgvTITfRpI9BEwHjZbOi3DOujk7p6xOaOZ++KK5Kp7kgUhgrO1n49R6Eww6FQFPX+l2TeZrWO4TMOReBshiKQ0epshLTalyr09XU3PrCutO1W4fx/H0TmFFSVgpQ5ni4Jh+MKOgucuPOzzbGXI50ffRzJLpWo9GTrOfn64U5h3HgEw9gbC//TJAOKgujziVTRZ7PTm8WEe6+F0pqvp+kG/ay3YdZSND+7lxLGV+xbvskuGdc9BN+cMTaIxuYFFr+HGoR6uQZre682Q/Mpe2TDz4oqYaQDcWXS+QWkTAAkJEuHwO5bNgIyN10/XrNafwStsjuf83297lZmNAXYceZEVyMKOjJL0AebsVD2xLwPlH6oQusB0IMtxZ7REmprfjaWqWeABJ9h6IQI1O0B0Ua5OGJ9IRcq8jVYxjsNdspZsB6akJbk8a7U9jqskkrYFhi0wZfoQQJtDSrpVJntGyoBecdLmOOJeSJx7y0qtOrtlfEd01yRhATa88ik8/ilyOml/X2nxMd7EWCr1ZY0qdG03x16GX0ioppm33rg75o/Yp/3kbvHmU0g1qjQIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(66476007)(83380400001)(66556008)(6486002)(66946007)(8676002)(107886003)(44832011)(38100700002)(6512007)(2616005)(2906002)(508600001)(8936002)(316002)(26005)(55236004)(86362001)(186003)(6666004)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gOihoShVg330NtHkHxds67NKSwiOErcqTB6SMdzLiNicoJsqKbPT8nOlEX25?=
 =?us-ascii?Q?3i9oUu48Iyr1tzWUoiSzXv6dhzANLHSIVerGFIM8fjAEBJZI4Y/I4tZvhJ/s?=
 =?us-ascii?Q?/tsoofJ0S1jsNc1oyxJ+I8XO3exhN83oGzLTWbLZcvybuTQ1i/T16JdD9wiV?=
 =?us-ascii?Q?0d7ijrGexlxZ8mjq/AA7UarVS7p8uJIiyQbfp0sALYwhAewzuo0BhOhFRZya?=
 =?us-ascii?Q?iHZM9lgDscnG/eT4Cl5hx8ErLoMel65+DCezu/9AiFYHLkjXLcXNv8WhKyl4?=
 =?us-ascii?Q?ODS8B3j9waytX61EbhRWQCDm7pc8+3ILOsGHOnhi/0UbIf6y1EW2U9IhX0kD?=
 =?us-ascii?Q?y2xFm8QR7VT2GwfhFWPddP5MIEiEfEmhtGRs8aFWfEAEK5/36YIJJLzCWqQt?=
 =?us-ascii?Q?6xF/vzaHxvwB/kLgW8KnJdjnf3jrZHVZAEw3AItq3pOsV6ydIavISoJ2ALvW?=
 =?us-ascii?Q?LgiBH/+v73F3aJ6h3DtIeyAqvCb32NW6tMLcakGlj9mgeWgXancaMsuG4IG7?=
 =?us-ascii?Q?NecbFa3437I/4MtQ0nWS8sRbKpynxuIk4MaoLw2QvdbuHZSx+ixpYuMwYfRu?=
 =?us-ascii?Q?aT7NNgXOzWATBLbEq/LQTS2sj/INsX4fu6AXxyZjqLFU9OMRN317BNEq219f?=
 =?us-ascii?Q?H+tsNF+AMpODR2wgKNs6bmz1W2v2B6jLapLYnsY2aalbcGA0NJTSPfOXyemf?=
 =?us-ascii?Q?eQa5qhHRtxxcdbbRonZNW6aUNLmcE2dEaoIP3vKl2soPVZBqRi0kQOHnqjj9?=
 =?us-ascii?Q?am4HcOTDb5105XI1hI3JjseWzWrJMTypgJ87jdYEvhD7fCF2j9fb9QzbIxS8?=
 =?us-ascii?Q?/GcNFQtW/3OWolMTKHsti55m7ZAgxjem3q3iIi+8WuviAFq6L8j729kYS1sc?=
 =?us-ascii?Q?ec0345TFp7SJL4KOLCjCTMto76XO2VZQzK4JdRwsHO7O1I/gyij5HEytCvs9?=
 =?us-ascii?Q?UA3YErM59mT1XOqR3bczCDnliHNn7n9C+rdZmirHbk9dIV7mEpvWnFg47zj1?=
 =?us-ascii?Q?AfgKjrm4YExeo6zPzs49a6PPT+snZ/wUcvM0jBqstcthFS1frV5Wd9jU1o2j?=
 =?us-ascii?Q?Jfo/L9u6KYTbmILSsoqc/K4hJvhTYFOphj1ZGNNVXU1Xq+WHT6irSMyGJIc+?=
 =?us-ascii?Q?D/J9UkmDo/dB+ptvghxwLwHuBPo+DslClG0ao/eHjvnJoV4wPTiHPjxOWeTQ?=
 =?us-ascii?Q?moYgb4+lTEh7Xi1XsWBFffTdVVW3797j2nIBcN6Zu4ERS64WgAGltVu2f1N6?=
 =?us-ascii?Q?T2IHEM94KF6PVr5fqeAuZQQemVjPlvDw2esIRVQpWudvnu+sPaWLVZOTrNZY?=
 =?us-ascii?Q?8OB4NG5g4lYRVR4zGxA/VzNDZTOjVHx0NRhFZxGAEv6Xn9YUiH9Yz5SfovY9?=
 =?us-ascii?Q?gM+MPsD9bF6piH5QJ6001/KQWyVZ6c5LeZ8WMTpwj961apeI3lf0Iq5q07Lh?=
 =?us-ascii?Q?+0ERk2jBKWet4efG+bLpjIp4chR3UOnWWMJKd8gGy7oKfdHgLpSpLnmApv8e?=
 =?us-ascii?Q?fCB/5PbLDbvp0DDu+7mTPPxB+97FxEc1Hw2SFNEURKBUd5tAtfsOYsRB6TYs?=
 =?us-ascii?Q?h1eMjUnT2m66LtpoGfIvD1E+N0b8EsysdKqu4yH7tAatQuPKXnJpTAxsmcsk?=
 =?us-ascii?Q?sL+0kPBTGlI3RTH9sH8Rj4Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3b99ef-f008-47f5-53e2-08d9d3e99481
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 03:30:42.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhSdGLbkdmwIoi2dLFlMhJrWG5OO8zWBk6ffPDAOyrBjlheJrpysEJKYJx9oMKrvCd5uwDb9802CnpCWep/yTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2569

This patch changed the command 'pm_nl_ctl set $addr flags nobackup' to
'pm_nl_ctl clear $addr flags backup', and renamed bkup to setflags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..7dbd36c558cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -289,7 +289,7 @@ do_transfer()
 	addr_nr_ns1=3D"$7"
 	addr_nr_ns2=3D"$8"
 	speed=3D"$9"
-	bkup=3D"${10}"
+	setflags=3D"${10}"
=20
 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -461,14 +461,20 @@ do_transfer()
 		fi
 	fi
=20
-	if [ ! -z $bkup ]; then
+	if [ ! -z $setflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
 			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
 				addr=3D${dump[${#dump[@]} - 1]}
-				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup"
-				$backup
+				if [ $setflags =3D "backup" ]; then
+					cmd=3Dset
+					flags=3Dbackup
+				elif [ $setflags =3D "nobackup" ]; then
+					cmd=3Dclear
+					flags=3Dbackup
+				fi
+				ip netns exec $netns ./pm_nl_ctl $cmd $addr flags $flags
 			fi
 		done
 	fi
@@ -545,7 +551,7 @@ run_tests()
 	addr_nr_ns1=3D"${5:-0}"
 	addr_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
-	bkup=3D"${8:-""}"
+	setflags=3D"${8:-""}"
 	lret=3D0
 	oldin=3D""
=20
@@ -574,7 +580,7 @@ run_tests()
 	fi
=20
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${bkup}
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${setflags}
 	lret=3D$?
 }
=20
--=20
2.31.1

