Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147F57D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5c734vH9cTHk/JRE42w4TCTJ4dFK0O5pcmBB8qcmzjQ=;
	b=iiU+HDTWl0U9CnACBXPdrQ9ophsHld2Q93keIEc9HtQ3+EHQvnz2YgzFNT0xPIXfFdnYde
	RzZ0CF5yw0LAv+EhsqKr/sFYRFZa4L/i8qxEFivgVmvN7iek8dveGIvM5YJCsupw5lbJzi
	7+0pB3bhR2wzR5aB86bZBM1qSC0TihU=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-qdOY8A43M_eF2ISJqFS5Fg-1; Sun, 20 Feb 2022 00:17:35 +0100
X-MC-Unique: qdOY8A43M_eF2ISJqFS5Fg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdYKZk6tMRHLFbs7c1gClI49WrMjDSgUeKXAGF+X/EtN5oofEbVRHvTuH3AnQnETedbmw6AaAlsqW/PkKmqsGSlr3xhXuUPaWCyKCx7FP9p21JaN71yH+5IGNpHlVNDCMvHJa6/fG2owxYA0DULFWgiCh5eU4g896SuZ+VpaYCbaumpQ5BB8t51spg3iTP7wRIZjBT4CIse/ni+EYyicgKmHJ0fhMEdHI4+7t+VH3TKK1IoTBjTIEdOwbHMcIL9JGEF/O5LdCk4FRSrweW58lObEKPpXQMVAD0qWFEgHNVe/EIcZTZ6EMltRrdCZlDCzH1YpFzXOA1qMsLbjrqL8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfjcDiFf3ECRZiA9YAq4q5YuiKoHSMxyafqk7EmEy/c=;
 b=j9m3Jwt5OaMYSJ9ClbhYrqZeEJowsnUrjJbh2giTseV2VSQOHjidWp39/gUERJWntpM5jguvDok29jnJC134MbyqW8ZvNtZISV3w69h3yOEcnUwcxGAUqtHQrqPeHkJZoyMKrQzRNprjHF6S7GMYFue4KFngPFE7MgMOs73NDoFYe8sKtTsqKy6+N997e8ZebvtNowgcrAjW4dV+W0SJbaIQzBSYrqIkoDZ3HjwcsyKoRf+UQ3vp02HY9XfxOxDzCxj8dKWUM0LH3e0THwscivLiqPICC56zygHun7Rp/TF+4Gw3DX00ikMDLmfKn/E9uOdBExqhOFizp5sE2UPddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:17:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:17:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next 01/19] Revert "selftests: mptcp: adjust output alignment for more tests"
Date: Sun, 20 Feb 2022 07:17:45 +0800
Message-ID: <9ef5272ae6cd3b5e14a104f9bda4f1b8820a17f2.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0079.apcprd04.prod.outlook.com
 (2603:1096:202:15::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0147e7-5e18-4f32-1ee8-08d9f3fe028c
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8812C1EF65CC9E38AE5E4D1DF8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KMD0+lkG1JisQwgeFGek46IF8TVAQegt7Ms1DDL9FaufbTTJpQN7jm243svO/eZXFlgCOr/PuFqzlFe4sRSf40FtvJOgyCm9HAwOCxfzvcYs6Fq1cSOW9MFGc/Cx2nVIOSyaHACo+Do5bSpQKxeqb+AlEo1LGRgMWIuCsH+nQ9dJFwd9Arl+rqnWouAGLRtFcB9n2U7lEvlgv99kwcTNoiJWqd+Zn+RZJkWQhJvkbnMyv70iqj7KIzo+fbCTLL8vGosrdVkTE/rStAGJts/VzaOlkZ3ilOg/rm6TsXt+MY2Ob2fJ34qP2M1Esrr2h/qaReJneGPC5JLwqXrlFdwBiGafyXSwXSWSPoHadin1XaMqE+4zQXEH9oCxdqkxMkWGwgu+n7Hufc/s0EKFXtazgRb2qfnRJ0Lyn8o4xZd/uJE5vluOTVakJw5FK2aEQ+p0qPK1pGfll5g6oULsrcppWQwU7ei5p6awAdlu9+bGQiYDbi3rORqhHfWA2M5l41oNdLFM/QD6WwVAfPVvdBHooXewM+VPdCW5HgxP93uR8grPy8UAufQVpwxsjbQNLGCyVidjUuorkHHrPY3g9e69b2V8Koi8019je+jZSTgcXyCI8gy+TYimzIxcxzu3IMAnMkzsgZ/1/meSCyx3Z2RaHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(186003)(8936002)(508600001)(6666004)(107886003)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OOVzVkDJU78A/fpmbIkI2hhp7Dp0ESvS4xAdW8upj5YCSX84DuDTvEq+dz/R?=
 =?us-ascii?Q?3U17l19ZFQuUC/SghFV11hEQ8nDmrbj397kc7AuwzcKFQ3wed6LVaZ81bjHg?=
 =?us-ascii?Q?LUhO2nk7p6hgBd1jUusZxvLhLNy4EcvhYB1BkplMYPzuVDrbpqKFWCPY7ByV?=
 =?us-ascii?Q?0k8BepSVHOBrcjTuJqfCsyDurMltRfOb6MNlWxkwnXSLnTSPsVlFCgfPO2s3?=
 =?us-ascii?Q?ak2kVGqjOy0QGvaJCgo+yngpwHCTxtJU82YlLnqf6sCbp7cM9+DKcenIGO4J?=
 =?us-ascii?Q?sQKuJc7qdjI8IEoLGUqGSXZdtqA9qvL1amTQv1ZIUDdUKJ/0eGBNty/aHMtI?=
 =?us-ascii?Q?ycCopdp3V57cuyWDajVes5I/MDed5t4OPnvufj/DbNJ/4qfB3FujLgtdGVHv?=
 =?us-ascii?Q?n89DNGrioLWYyHIZuY1xxSfcZu5gcvfguXu+5WIo1dIsCObM3QPSMiM3XXXc?=
 =?us-ascii?Q?K+vXZiK2zjiNgXDWqRfrBxUfOeeL4jz1Rw5Y1tX7VtNLmuHhDFvDkdNt9owx?=
 =?us-ascii?Q?b1+ZL63qPb+lFUpKqerp7VtvqzmSSixRgU4gIpyFOnRXLkdBHZZu2sL2XodZ?=
 =?us-ascii?Q?v+5ECGCMFcLA8s3ya/3rhLH+k7lIEDnRZGNQfByq9CuaXuw/t4xJgLUu2l4h?=
 =?us-ascii?Q?dXveOzCNo00Zzc7vqTCxFKvZbs82nBn6FF3dmry+Vy+pfCKQF0AfVKT+3Mwj?=
 =?us-ascii?Q?QfnKFJ7yBqq7LuA1D0lPeNgLeRRda3rkzatr8fkj4fv/XsrUJWuZfYrGEWMv?=
 =?us-ascii?Q?ogTGcVOC8ViWmloJu3NqB4WFRVpw7/a9Tu59dNobVuOJ9XZPUmk3j1D7xZGL?=
 =?us-ascii?Q?31DS2kN+7vInO7d1OTvik/0qpdccd5+Kn0INrtS/FPRta3raoQrK5dd72NJp?=
 =?us-ascii?Q?X8TN8VLiM7VKyRR2lISkUhs21sntqE5Txb3FQRsX5lqhnXbC+JvHF5X2Tx5p?=
 =?us-ascii?Q?Q8+OMPZVIP2v5WuJqZheF8jLANSOigLTUqagQvNKAstCixTs/nnYDz2N/UbQ?=
 =?us-ascii?Q?DfjejPkX8RsAcshg8yV7QxKlP0XPeDSNCSRLODF44QKF2URUZw6p9VurtCAg?=
 =?us-ascii?Q?xwG3I9jAZ+1th5UOjQWktOL2mea/nUh1xH7uLk2rXwJLL4Y39KqoLGLI+Khf?=
 =?us-ascii?Q?bUwLV2o8hh2v8p9g2tqjDrNp4649D1tGqwgtJy7oS07Eb8K8BNRnn+SP5SD6?=
 =?us-ascii?Q?PSaJf7BXHbCRhznXdX85eFt7u3djglqoMiuFGyW5eWYzlZHWtCs0WWPSiAH8?=
 =?us-ascii?Q?5VoJTj8YNcZjINu82VkVP+e4jMU/w6SuZ1IHa7EZBDbAiU9peDHC3aj/oj7q?=
 =?us-ascii?Q?7JUyZeRaDoQOBrDZbZM70ShJ9JVqm0/9VZkjlQIkaBwOvpPQBaVPXbPxpILq?=
 =?us-ascii?Q?2WgM/ZmJX8NgQUbid80gVs0hfW1N12Vt1yIXLU83vWORnhAODtfvu6GZAjAE?=
 =?us-ascii?Q?IPUmr76qr/CJ4Gjc2zcXLNX1+YcoQlSP0jQv4BQqaeeg5iNy9dsH8wP24wjA?=
 =?us-ascii?Q?O0YQp1JHHr4LAM/NsrKdaz1y1q7UI3DpZdBZJpmfJq5pFyzioOjoHmauCjRc?=
 =?us-ascii?Q?pS3m4rIlzsSRD5RQMxO/hwSgnj5pfgKJ/5fQ2Fetfk24FACcNwDpyYIUDND8?=
 =?us-ascii?Q?dI2nUPpbKUJ/VLmowgzIByiAguIubVQKbMUnIgN5UVSnIb1SeiVveNOtIc+O?=
 =?us-ascii?Q?d+CBTRdMQXnXEMmFzpeXQa5jU3g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0147e7-5e18-4f32-1ee8-08d9f3fe028c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:17:34.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zsERRaieOLXOnwMjAr0cCl81DPQnOY1LDZfb3iV6FHVGgYxNKjWvU0zDoOmIa7ShRJ0RtRCb1rDuMWN98/pqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

This reverts commit 4921e10f98e3e09f7fab58aaa0faf8d8aacbe612.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8e6a5292175a..baed1e0aaa0e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,7 +21,6 @@ do_all_tests=3D1
 init=3D0
=20
 TEST_COUNT=3D0
-nr_blank=3D40
=20
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) =3D=3D 0x30)'"
@@ -813,9 +812,9 @@ chk_csum_nr()
 	local dump_stats
=20
 	if [ ! -z "$msg" ]; then
-		printf "%03u" "$TEST_COUNT"
+		printf "%02u" "$TEST_COUNT"
 	else
-		echo -n "   "
+		echo -n "  "
 	fi
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
@@ -847,7 +846,7 @@ chk_fail_nr()
 	local count
 	local dump_stats
=20
-	printf "%-${nr_blank}s %s" " " "ftx"
+	printf "%-39s %s" " " "ftx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$mp_fail_nr_tx" ]; then
@@ -879,7 +878,7 @@ chk_infi_nr()
 	local count
 	local dump_stats
=20
-	printf "%-${nr_blank}s %s" " " "itx"
+	printf "%-39s %s" " " "itx"
 	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
@@ -914,7 +913,7 @@ chk_join_nr()
 	local dump_stats
 	local with_cookie
=20
-	printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
+	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$syn_nr" ]; then
@@ -977,7 +976,7 @@ chk_stale_nr()
 	local stale_nr
 	local recover_nr
=20
-	printf "%-${nr_blank}s %-18s" " " "stale"
+	printf "%-39s %-18s" " " "stale"
 	stale_nr=3D`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk=
 '{print $2}'`
 	[ -z "$stale_nr" ] && stale_nr=3D0
 	recover_nr=3D`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover |=
 awk '{print $2}'`
@@ -1018,7 +1017,7 @@ chk_add_nr()
=20
 	timeout=3D`ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout`
=20
-	printf "%-${nr_blank}s %s" " " "add"
+	printf "%-39s %s" " " "add"
 	count=3D`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddA=
ddr | awk '{print $2}'`
 	[ -z "$count" ] && count=3D0
=20
@@ -1055,7 +1054,7 @@ chk_add_nr()
 			echo "[ ok ]"
 		fi
=20
-		printf "%-${nr_blank}s %s" " " "syn"
+		printf "%-39s %s" " " "syn"
 		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=3D0
@@ -1094,7 +1093,7 @@ chk_add_nr()
 			echo "[ ok ]"
 		fi
=20
-		printf "%-${nr_blank}s %s" " " "syn"
+		printf "%-39s %s" " " "syn"
 		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=3D0
@@ -1144,7 +1143,7 @@ chk_rm_nr()
 		subflow_ns=3D$ns1
 	fi
=20
-	printf "%-${nr_blank}s %s" " " "rm "
+	printf "%-39s %s" " " "rm "
 	count=3D`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{p=
rint $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_addr_nr" ]; then
@@ -1176,7 +1175,7 @@ chk_prio_nr()
 	local count
 	local dump_stats
=20
-	printf "%-${nr_blank}s %s" " " "ptx"
+	printf "%-39s %s" " " "ptx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$mp_prio_nr_tx" ]; then
@@ -1212,7 +1211,7 @@ chk_link_usage()
 	local tx_rate=3D$((tx_link * 100 / $tx_total))
 	local tolerance=3D5
=20
-	printf "%-${nr_blank}s %-18s" " " "link usage"
+	printf "%-39s %-18s" " " "link usage"
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
--=20
2.34.1

