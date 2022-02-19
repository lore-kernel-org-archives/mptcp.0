Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595757D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3RSYcUSOqx5ymmQlnQTdF/foPlHYSbrCFcZ/ZucgWg=;
	b=kuPWRdqfoyvj91vhNbTpRzew3l4kbFNNeEZi3a55O02BokdMkbNtQUjuVCbsKIxlhwg9Ro
	uOyuhoKmPw9t+hBOBB+1vCLXFvZrwbBWfCol1YbHBONUhD1WBOp2SrT+voaQdbHQ6t7maf
	i8XD1rWUruPdr15AbnLNBSu3Zvuh/AY=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2059.outbound.protection.outlook.com [104.47.10.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-XJQGgWW0Noicz0nnZdKN6w-1; Sun, 20 Feb 2022 00:18:09 +0100
X-MC-Unique: XJQGgWW0Noicz0nnZdKN6w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3rMIC1DF6XHN6Xk3H249EPT6zFuNz0v+JeMW+dDxnGIlDNhRzUlBlWOhOpFBcw06DcLK5YbOXRVoyWKXFFyYrSsw4UYmoTepXsZ/q1lrI2+EHDUFT73MRCdkU2CQuqAVgah5Jw7UwUWxMp7lVuHx6CuxLqx33hkdTwS8BHL4TAQTrq926JTnLqYfwSn8JIwliwS+7uFfgsJ0d0AaIbf3644jCr46cGhEQoaw0X1E98IPP7atiTVf/gFz9vCNCExbwr4YeUQRk8mwld3m9xsyusVBFQeD7JtLCDWC3vLQPRGXH/DnV7m8ERYNRyKvNrZ8vBcxwxqScvcOmydSwGKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiZAWUc3AmjtnrzEPxg0eAxXY4YV6iUlMroCXTEm4nQ=;
 b=M/nuDJyCUz5qs6ew/EUhylvZV46Y4zDdQ4vk4dorTZmG9K+iOuifpX52J28SVkFh4c34WCX2s2B5RkoHHS1QEQWNGN/D9Fk68DG612fjA2RKh5RYashoA6Gs/b3akwAudf0FWpbqssR+UrMV0FFRDGs5c3mZr58eY6/V2f1ZIY9vsq9LAO3NVzjPoDjVk/tsIx82q33ZpdadU9ZMjDixFZrO5rXOgfcMTFRvovELKwYYrvJ19h9WcxzXxM+NjXzCYFYIGkUpdmy0wDA9/f8jrgNfPHhu4AJ0g6Jyfl98ABNmBH98o6Gn1S8+crT6b/V9RZXS6LLCosN5hDny4eye3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:18:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:18:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 06/19] selftests: mptcp: adjust output alignment for more tests
Date: Sun, 20 Feb 2022 07:17:50 +0800
Message-ID: <c96b7bbf66a192be31220123dcd663b159520b33.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345a67c5-1655-497b-a590-08d9f3fe172c
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB881257A5D999496F558A99BEF8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bmi7g7IdUGnIdI762i00JAZdL61RIiFwSa/iOsIawl+Unixq+G259phdGyKpCXVSoT1Ky+RH5d+mJuBqWaHDgLmn4Qucb/oWIy/P9zCGzYbFEaQLdLEQU7/AyE+uahl1pZmKay6pK+uzKZqvPuxRj0tnwBcIKwXQzN5ihL/uLlIiICZD+CubinVKrElOnncz4YLI7jXN3mKh1xWjgvCrb6dEqhbCV/SgdTmOlCbAjztsnC91iid+xqbqtSLQ4FdjC5/Jz1LD9kc88axRYgj4RQBiinp9JsymEeQ33hBh+mw5WJ+/SFiyCH9lZg8aHoxA73DyNEKaNFQVTmf/ddwraXXOjhXY+Opywg7ZIM3ssyoDvVENu3fg+4YiviNrZoN1dsRAe4VydJ7JauEUPas3iGe8wRFSZny2wPTJV2EaEzdPSvv0jhzKQ4tK1GBkbjl781Vq6JsODP7QtwgzkdgnE08L1O04zdlnp68gNAn6BoaqOg/aJ3kcVWtdvI2GeJuTqFzoOg/Qiw2RK2LPgFPo9ur1a7F5uIIIwye2VgTRjxN8l28z78i5vkSq01TMRIvAu0NOgeaWxY4UE/hhCNJpgki7e1LQnM3AnAmdjuIoGOrhEQAnAAjKNPNMTfK544W6f6B93xTgc3W21GOD5KOXPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(54906003)(186003)(8936002)(508600001)(6666004)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9LmCt5carVKou8EAhAPA2/0/Uxe4I6kuz/RBVFroeCB9gT84SiginfxXiFa?=
 =?us-ascii?Q?GEXyy+RThzZWH/D7ZCG3YH6cZC9WDZyY9d36hZk3YGvFtKQIbLzRKtHm1631?=
 =?us-ascii?Q?VoszZ03jGhh6dibW+0UG4eV4S7qsrlTDYT1gcitmfstIQCIGPjgk/BCjtNTi?=
 =?us-ascii?Q?9t8dUt2yLFiC8w4iJAr4x6VEW5b0WrIIh2zIiKXUJe2G8Gl9hInOBF/Fkl3z?=
 =?us-ascii?Q?xlfO2Cwm6krEPT6zJ2caPg2CKSgNzIwTXA2aKH+glwMuqZqSsEWBFbup6ew1?=
 =?us-ascii?Q?Z8IpF689GmJaV9bhIFkW2eHwckR7v2SmFys4O4ggx7fApxwxOCvRd81d0qid?=
 =?us-ascii?Q?0L12fM+VO2561WZGKDj0sRD5xQlYZtTGCW8YqkhZWGX4AwgjwyOszTcvtqPM?=
 =?us-ascii?Q?DFPopTIAPhAz1QGIRMt2nxbpaOfx9/P67gkfKLaanCagxGYq2U4LK9CkMYdg?=
 =?us-ascii?Q?VFrbHTrwWYcxy1NG2Zm/TC142cwKdT0IH1PO0hjNHZl7UdkYUL509qd8OQJe?=
 =?us-ascii?Q?+D2EmwoZHVT/eieTsV/TNrGZkDN10Aor1XdMrATRp0SVnpWkA5ft87tZ+aSE?=
 =?us-ascii?Q?rlLfWhGhU9vCpek+epQm2mhsm06D6jJuh28QEsoMoTQwYj1APMGCZMOfYc81?=
 =?us-ascii?Q?MC0vXELBENsDkSThAz3ZTR+A9KVY5TTXApkVuQ4Q1Tvyos/kP+OsuEWgPW/Y?=
 =?us-ascii?Q?6aBxFUPBBF585yhVk+4k5b+gmjGK/lz5crx9Ewjf2PaIv44DlOx7AxLIupe2?=
 =?us-ascii?Q?M7LUbetD/rz5gZgasS0fFv0Ur507h/KQ7s5zxeMllex2+mchJNi4dlxCzsFH?=
 =?us-ascii?Q?Xh+2jzPa96ftgmGCXMs9bImlU9EXKy3Fte4HVTtZfy6JUu3sIwt4rwJQS1VJ?=
 =?us-ascii?Q?guXa/XdRZtbibAkbmZ7ZYRfIYBiufTayfwmSrFn5sbGAE2Wx0LVJBjVmHyc1?=
 =?us-ascii?Q?vCYZJTx86wAIPqqmXAJy15jsnjCZPZx/B+ch6MYxQgwTEIM2+WFoUmfAe+ki?=
 =?us-ascii?Q?O+6KdZ7Azo9SGGZDVPCNKi4tPKX9vfzuL6eSvKHVU0P89B1ih+iXNGd5joGE?=
 =?us-ascii?Q?onGG8UkqmZ7dxVFOqspS01NuwkHzedMhhBvbIyMSJWvwst6Sg3gSZSmfjdT6?=
 =?us-ascii?Q?sXQ/LH1iI59OS6CuKS2mbEg7XDOZwGON0Ur17xoRH/eA0K20jcW4oxugKvdu?=
 =?us-ascii?Q?/zdTvZTCj3Sg94upRXE5fncbyQrf4RJc3K/Xm4aYi1wk3k+XN7djnvQHgIDW?=
 =?us-ascii?Q?Pp2aL6Twab3ShTj0naJMh+IitXNvErsb5lSgG1ukWtn6Mma452zNSkIyNuo3?=
 =?us-ascii?Q?YezMOhU1Ok85hI5SouS9M08nZcR5TbTkil/+rQwUEyu61WhohHuObmQkXtPf?=
 =?us-ascii?Q?BGHoNcwG6Xln/B5cdD/8fjxm2CyEffaWnKrgXzT6JfCl835Bq2UxVEHnCBM9?=
 =?us-ascii?Q?jJ4KVtqZBwGfaUonbcqAsqhFM17yd+HyJUr5nyviHIIxtkj0arK8fz826BlH?=
 =?us-ascii?Q?7EifOxpy++pUaSWny5QE5nhYLKx+pXU2EbeN125rgLPtxP8hb8tkIB++bsOr?=
 =?us-ascii?Q?QL/pYed1ceYTJnvuLM6F1UH+ZaY3+zCnraNDSoz11h9aCIMbKT/TxzF8wAqO?=
 =?us-ascii?Q?BKnE6xnuzj2CSOhZYBRqQn6xYWJypZGTcrj8+ovXqpVwIhwI9EmU/PTw9lmy?=
 =?us-ascii?Q?IGIn34ACSAwjj6Ce/I0SxjuzjEg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345a67c5-1655-497b-a590-08d9f3fe172c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:18:08.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ge8eUhbLCzSpmEvu3Sswe8eY7w1MbItkCKHUObErslKEQRf6u9kexj9zIg5rIBPNyB0ST9gtViojBH+ub59eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

The number of self tests in mptcp_join.sh will soon be more than 100, the
output alignment is no longer OK. This patch adjusted it.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 46fe7d135e30..f0f4ff897e60 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -20,6 +20,7 @@ do_all_tests=3D1
 init=3D0
=20
 TEST_COUNT=3D0
+nr_blank=3D40
=20
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) =3D=3D 0x30)'"
@@ -803,9 +804,9 @@ chk_csum_nr()
 	local dump_stats
=20
 	if [ ! -z "$msg" ]; then
-		printf "%02u" "$TEST_COUNT"
+		printf "%03u" "$TEST_COUNT"
 	else
-		echo -n "  "
+		echo -n "   "
 	fi
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
@@ -837,7 +838,7 @@ chk_fail_nr()
 	local count
 	local dump_stats
=20
-	printf "%-39s %s" " " "ftx"
+	printf "%-${nr_blank}s %s" " " "ftx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$mp_fail_nr_tx" ]; then
@@ -872,7 +873,7 @@ chk_join_nr()
 	local dump_stats
 	local with_cookie
=20
-	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
+	printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$syn_nr" ]; then
@@ -934,7 +935,7 @@ chk_stale_nr()
 	local stale_nr
 	local recover_nr
=20
-	printf "%-39s %-18s" " " "stale"
+	printf "%-${nr_blank}s %-18s" " " "stale"
 	stale_nr=3D`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk=
 '{print $2}'`
 	[ -z "$stale_nr" ] && stale_nr=3D0
 	recover_nr=3D`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover |=
 awk '{print $2}'`
@@ -975,7 +976,7 @@ chk_add_nr()
=20
 	timeout=3D`ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout`
=20
-	printf "%-39s %s" " " "add"
+	printf "%-${nr_blank}s %s" " " "add"
 	count=3D`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddA=
ddr | awk '{print $2}'`
 	[ -z "$count" ] && count=3D0
=20
@@ -1012,7 +1013,7 @@ chk_add_nr()
 			echo "[ ok ]"
 		fi
=20
-		printf "%-39s %s" " " "syn"
+		printf "%-${nr_blank}s %s" " " "syn"
 		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=3D0
@@ -1051,7 +1052,7 @@ chk_add_nr()
 			echo "[ ok ]"
 		fi
=20
-		printf "%-39s %s" " " "syn"
+		printf "%-${nr_blank}s %s" " " "syn"
 		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=3D0
@@ -1101,7 +1102,7 @@ chk_rm_nr()
 		subflow_ns=3D$ns1
 	fi
=20
-	printf "%-39s %s" " " "rm "
+	printf "%-${nr_blank}s %s" " " "rm "
 	count=3D`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{p=
rint $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_addr_nr" ]; then
@@ -1133,7 +1134,7 @@ chk_prio_nr()
 	local count
 	local dump_stats
=20
-	printf "%-39s %s" " " "ptx"
+	printf "%-${nr_blank}s %s" " " "ptx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$mp_prio_nr_tx" ]; then
@@ -1169,7 +1170,7 @@ chk_link_usage()
 	local tx_rate=3D$((tx_link * 100 / $tx_total))
 	local tolerance=3D5
=20
-	printf "%-39s %-18s" " " "link usage"
+	printf "%-${nr_blank}s %-18s" " " "link usage"
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
--=20
2.34.1

