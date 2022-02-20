Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1699A57E7
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 03:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645326026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+mKypv2K6hnmEfB53pj1Es2i9gn/XdUuU6nuupdDK8=;
	b=XqpanPPL+7DU6G1prp/pTvwTqtaKRYevpPpN2QGx2yeX1jIBc+SUTFxZ28CvXGPdVux/GR
	AtGJCn+L4NPZ0k64fMSsVOC/M75X+v9PZqzHsEfBqopg6Ys6DpUIEVf6h1oKP5F3CmVO9T
	fgMZ/guftxzDxtyJWMQm/6s3LkIFD8U=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-mQqEYbTXPmy06WMwRJZlmg-1; Sun, 20 Feb 2022 04:00:25 +0100
X-MC-Unique: mQqEYbTXPmy06WMwRJZlmg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mud7L0sClviFg7PjLJP92CgPKisuhRWEU21AsVGHSe0lp6KJlR8fxInpbsAECsT3e4N/ZRYkK9uNptk+SFHDldV9wIKPgijttm8KSDwgheJG5g6yYONbqqxeUa5jM61obanLthsCTPxRTC5hfAozEDvGE/UHJ2AApzh0YUCziZaJR+93xuPDmJR94sRfuqb1YdsoEJNdfk8hhLyhLF/cxBi7DJVhAN2OlJVC+jdbGHn02m6B9UbNyeiC1yINzb5jDX0RLnHN+hSnkWh/nFsHE6dOXVoClqn8T0mEDxL6xT6uTFNrR6MPaOqw1B2XmUYwTmdXhaRVwgpxInvDBqM2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP6mW3Vh9wAMmbIMST1CvctuhqyOO7SdyrWhBR15Lu4=;
 b=Eqc9QnmuDXGq/mRWkxFjhTMJ5kbEv9e5r+JcIFFGfUn4rDGCzpAo05w/DSbrhYpPzV45fAQm8fwtR6Xk5uLUJyRm74iNpRaooGh4R+gpR10/gbVevx7C09oNZLQ7Bv8RzovR1l7AMBe8l0ojy/FKoGwbLuiaDXNY4tjhT3tD5HENmo8N7LjvtSJN2tOXhmYWJrv/N8R87XPKUJfWt0qtDFPemorZgdh0dEjs6WiZzcZwCL4iiynxgvpe9FR1KE5HUaBLvpYIByFFFt4KtodR2+fWRfsXjpYXTv5WlP9gZ3reYeWFyYSqjg4fKZdhN3WtPMtoItThi9U+/CT8WwWDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 03:00:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 03:00:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 10/12] selftests: mptcp: add more arguments for chk_join_nr
Date: Sun, 20 Feb 2022 10:59:36 +0800
Message-ID: <5e63cedcf653457eadbc52f86c53edca10e49c90.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff1babf6-672b-4b17-58bc-08d9f41d23be
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB34149CB1EE657A7EB21670ACF8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aLoZ+wEz1BGgZ9FjxP2gSM+zxIR4c6V3a4/XMg0dF5+aS3FJ+An/mzwRB5Has1NL51y3IVVexdC3w6zcR/0hqiVv0/QvB75+Gmdk9O9HDjFVrGVAqbqIQutGHFUd0Fo02WFuVRVso47ALkoZDik4l2GMPiSoMEPvKl6XrHYIz61vNF7q8g95n0zAhG16J6Q7+L9du0CeJoiOfw3Lle4AjeHOFtmaUX8O9SGdi7YsC/QNy0/pxFZENESj5U6hXwFRprMAalHDgnhzFcr0WruDRrAjeMV8Xmeau0pmQYicjOkA7ZVs9yIBybPTncm1PJyiipU/EuqSTU5H8PU+8XdLrp4h/JKN/ylllL8cm4aJr0Xatxk+ICDM+l4xrrXjs0TmODu66g6cuwH4GuEvU38unLQksGKLsfh/NqAA61Xn5yU0oVDGxwHVAiQEuB0kumSXx1N5wIp5Vjnpb8xQCGSdcAJwEcW9ItBei2CxlzOkbGclnfpB1knXLQToqK8Jl8oi5RuXY9m69Th7x3wkt2pXCvfS1SGyyKc+J1XAIkXsyu1JZEf5Y5ZroVaLfcyZUC6Sink8rtzNBdVr97v6pMWk3WgDrOk/CWr5aReUOMjgW7wJBdQ4AKetpBlv7A2keJZmNddSYUc+QmPIYXtJ7Gm7cA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qspizFUu7/uUi1/UJbV/wXM8Ufnv8EDIRMlRLfT3rSE2OXSjp+4lgav6UpW8?=
 =?us-ascii?Q?4c+eurj/Yj8E7FL1S54AGpZCp8VkQ1pteDck97JFSKRlG22ftdUMO8Kcw2zq?=
 =?us-ascii?Q?ywaxBJ1UJ4BHaQ754z3dMs8GkQHR8H8JFHwaS1Ibb6nV8sLc5m2BJ9ZgFd+j?=
 =?us-ascii?Q?xIyBcxafx9Js25EwegmfY++mrHqfVucmcl2TCJaxhslzB0ZIwJ76ZHFNw9dQ?=
 =?us-ascii?Q?EBRuDpgvpo5DjZ6pLA4tiZsCfyQCChS6h5v/kUnuhjcsEU5jYfSNpjwgo/7N?=
 =?us-ascii?Q?Re28SmTHGPTvbguMgli2VQCHoEGLWo+RU+vo4j2VN4Im/e87Aq/PP0q2TOxO?=
 =?us-ascii?Q?6lLlTqH8FjcsOYpNa3GksALPgWDLMz4k003NqCkUqLdq//a6F2mVrjuJX9UT?=
 =?us-ascii?Q?R8cPbJsgRTipHxq38pfsVEayV1PQfchmbDbpyzp4TJDSiYOHJySCjQGcVSEm?=
 =?us-ascii?Q?SDe719QCwqVTepay3HB4MVsrbR1YHAV+QW7K03e6um9f9ES6l0LuL/KNqcF4?=
 =?us-ascii?Q?wS6oc8XPBK//xxbADDm+LpcGS+UTEZHeExs1gBTggsABE4gzbU833KAMDha5?=
 =?us-ascii?Q?pk6BgGUC0S1Q0bt1c0SEizn+/VWMoN952AN9vyfv2tgZvJG4BAc4y1ggNahP?=
 =?us-ascii?Q?T5is7XV6pJFJXHtJ4C9goaO9dvf5Zx5IS4yWrjGfxJ4gMeKmBMZLgUh+jdFY?=
 =?us-ascii?Q?LDBFJqj8dd37Xmyg51zl7c17mgN7YFiXNfDlz9iMmObklPYB0YiP6I6XK9kJ?=
 =?us-ascii?Q?oIjLnLHe3AaO+Rv5PVIRiu0TCwPX0FQ1b3+mxNVb6UVVDQBkt90HTR+EBDDv?=
 =?us-ascii?Q?o8vDiVNBXtTiDMvG/5dy2sMMUA/LtU96Sy+afi9hru2rErYGoJgxLeY/hG/4?=
 =?us-ascii?Q?c5bjM+b0LKgsYy3AyMScJ645w0bqp96OtOynWXCeaGrJSeaHt2tDHjwTJomj?=
 =?us-ascii?Q?sj5rFqoniCAT5bYNHgnN4GOZRXLZLFYFMlbce8/xBH6Om23BHVzmW3hRUYZE?=
 =?us-ascii?Q?Xsz39ZklA/tQRaGrY5UbkSQPRgstXCJGenleOZPARW55XVh/son+LKepRJzL?=
 =?us-ascii?Q?IDkmdnntvWMI+N5nkZuLrYFNeHKr1Rz9HQ8TUiSGQCNkwrEzE6WG0JcCvV8w?=
 =?us-ascii?Q?L1MjAb8X14H5WwYOwbUBuQL7RPJz2ln3PZoqy7REXs7pILm8PGHL+UMF38Gn?=
 =?us-ascii?Q?f+NG8DOtFJP0mN+/pmeHhtkcUefhRjJFiz7Z9ajc5MGL5a543gsPRHghvFWu?=
 =?us-ascii?Q?5QOMDIRW6AtUTiVnOmy7dPoV1I/3jY7JVxVLKeCpoYyW1TgN23GkXIELrBqJ?=
 =?us-ascii?Q?jfPSxaRgLFsdHWo00Ax3L5Jenhu0XBN1pJendpc4cN1jA+QYNU9TY88pUU3F?=
 =?us-ascii?Q?IaXCdUl3JluvDmGqPRequSr7bZDOroULIKn2JuJy9TFhlvgbDHSIZw9M7/ub?=
 =?us-ascii?Q?EUrT9IzkkAi63ExZZZwd/X2NnFe57alg6hJQ50TgbZCRjxcEqw/RqFysDi3l?=
 =?us-ascii?Q?Qaovh/F19WDgaw1yRVCNqEAA76QWlYuxteFI4qMRX+RDL8HNmJJ/qnE3jVSb?=
 =?us-ascii?Q?Zl+79HwePhTAipqygBeiAcr3gLVSJpSHqcFAtm4F0QBM/Xg2E+WhXc0isdY8?=
 =?us-ascii?Q?pxFGjuzl7kn4GCDvdsweiQ5/241P+DcEp25iIe4AjgA6HZX3VAQEmVlWru24?=
 =?us-ascii?Q?kPyIOXlXOD3AtorUqeOBZByyY3k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1babf6-672b-4b17-58bc-08d9f41d23be
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 03:00:24.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzxXpliEMTySlukwygfKS9Cz0zAPg4Wj6sDLAXg8XkTvA/uRfnAgmZkujvJBhdfT1WjuRJQg5858eDiLLx0ivQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

This patch added five more arguments for chk_join_nr(). The default
values of them are all zero.

The first two, csum_ns1 and csum_ns1, are passed to chk_csum_nr(), to
check the mib counters of the checksum errors in ns1 and ns2. A '+'
can be added into this two arguments to represent that multiple
checksum errors are allowed when doing this check. For example,

        chk_csum_nr "" +2 +2

indicates that two or more checksum errors are allowed in both ns1 and
ns2.

The remaining three, fail_nr, rst_nr and infi_nr, are passed to
chk_fail_nr(), chk_rst_nr() and chk_infi_nr() respectively, to check
the sending and receiving mib counters of MP_FAIL, MP_RST and the
infinite map.

Also did some cleanups in chk_fail_nr(), renamed two local variables
and updated the output message.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index dfb87794056f..f33822b28058 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -837,8 +837,21 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
+	local allow_multi_errors_ns1=3D0
+	local allow_multi_errors_ns2=3D0
+
+	if [[ "${csum_ns1}" =3D "+"* ]]; then
+		allow_multi_errors_ns1=3D1
+		csum_ns1=3D${csum_ns1:1}
+	fi
+	if [[ "${csum_ns2}" =3D "+"* ]]; then
+		allow_multi_errors_ns2=3D1
+		csum_ns2=3D${csum_ns2:1}
+	fi
=20
 	if [ ! -z "$msg" ]; then
 		printf "%03u" "$TEST_COUNT"
@@ -848,8 +861,9 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
+	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -858,8 +872,9 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
+	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -870,27 +885,27 @@ chk_csum_nr()
=20
 chk_fail_nr()
 {
-	local mp_fail_nr_tx=3D$1
-	local mp_fail_nr_rx=3D$2
+	local fail_tx=3D$1
+	local fail_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "ftx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_tx" ]; then
-		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
+	if [ "$count" !=3D "$fail_tx" ]; then
+		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - frx   "
+	echo -n " - failrx"
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_rx" ]; then
-		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
+	if [ "$count" !=3D "$fail_rx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -1014,6 +1029,11 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local csum_ns1=3D${5:-0}
+	local csum_ns2=3D${6:-0}
+	local fail_nr=3D${7:-0}
+	local rst_nr=3D${8:-0}
+	local infi_nr=3D${9:-0}
 	local count
 	local dump_stats
 	local with_cookie
@@ -1060,10 +1080,10 @@ chk_join_nr()
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_rst_nr 0 0
-		chk_infi_nr 0 0
+		chk_csum_nr "" $csum_ns1 $csum_ns2
+		chk_fail_nr $fail_nr $fail_nr
+		chk_rst_nr $rst_nr $rst_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
=20
--=20
2.34.1

