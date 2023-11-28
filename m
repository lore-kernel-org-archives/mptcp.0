Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8335888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Udh04Nt4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjipHOnLBDDZXNID2Pm0QeTalL4nPlw2p9pJW/j/OKepIv82esW8LYYJU7TzHFVTR5LX54jGbWdnpJ6vd0emZXJa8/yg7k2Bv6fWxvxOTNu92VXdFD0gRHC9Vs+4tG+KtRkI8nPcNGmqkVnSbOMGRhjsh/B+XovVEWkHmJOYZc2X3dbfdDgu0lSZKxtvYQQbeHYXfmLM3J33oiAWtSzsU2S20qzaUs0zraURVao3vevQELdFk7XRM3AbezAOAQRAYAyzg3n35cTDpffXMeqqTWf/XdCZ7kaDDvjwXTPiSnhadCsvWFK61dQZAQROrmugKreF3drXRqPHVh4l/59ZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlNnov++/Uif4KTLmCrP/QePTgePVW+bErHxdmuIRFI=;
 b=N/O9GBTOsqdOdTVvIEpFyU4wxFjORYmoZ0FaepJAXZEm02WGy/2aGJReyCqkVecxjxFnibd2XAR0otlk7H0K2DkcvTUvomPDlYO7HbmX9zmkIZA0+3abK6mZIcGifmyHrBbWbCdU/wmhtOxw438px1lbDIffqsCsbHN9RnK60O+r0GFgtUBgu5H7PsMTUB2o3Bdrv2RLMQaybeu/xmuktFtz98qe5WIEdHeDs265QVXJZ6VZQE5dvr7P2QGrbc4ShjpeocN/J+4t+f8lchUTHLCgnJsZWR4gU0wo/g6vj1xNexofCltya0s64TE0NSUUhJwIa6YFva/h45a0+U1eHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlNnov++/Uif4KTLmCrP/QePTgePVW+bErHxdmuIRFI=;
 b=Udh04Nt4y8+K5TdenFISozD7Pqgu9IyfUbN0BdwAbgXSD+oxWppvjcadBF+ElipReGr6NxsWL1VRj5k1iB+7dggxAQANG/3rA31tamdGqH8do2Z3fNPm/l7bd30cnINQjJzj4llWVC2J84z+87MBOeuBacQ5pc6WHtGWHTBf+Ui591cKTLqh0OSqqPx1cLzQSHca0oeps1L6MNY+IteoTGs0j0dn6GUbQ6WlUlEurJ9k2CCcWPfFStFJOFEbEscJmvXsL88TySmYAAM+PiHhKMl1JVz/roAYTxyD8CKgi7AomGobAtPUDO7eWcqIETLGnwDhKMQ0B2C/D85AFVZQlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 12/32] selftests: mptcp: add mptcp_lib_check_output
Date: Tue, 28 Nov 2023 22:22:05 +0800
Message-Id: <f9bc50a1077b2d0cc29d5a3b9c50744528d87b7a.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 7899cbaa-3d60-4d58-8327-08dbf01d917c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u0SBNOUUqs9wyP+F114jNDL9r+MwDY9Twxb88GFLxT/mjbgIR9ibVi6rh97jfrPygzMZ3LGg8JW1JKMtQrOUjC34Tga0QX5cZR5a0HLJKxK8pour+7XDhOH/eCQTH6wDarocugzQK0jXIrsKY+9S8TmJlW9UTSYCRvAQOf8jAvxIwdbnAc3U0gt5ksosIeUHmUTWTp5XDPNp3QyNG4M3EXMdWaIgljuN/qkcaH72XhKXAaduG8vybukxjI+SZzid0JtaBKZ22uWc3X14W2n+P9pdYC7geA+pYGUoXdWJCvOGGkaPAjmrBz/c/h7iPQxpnZ0r8/Zy9gkm4QU8PNeiBJNthrdYExlu63zXHkdMkW5V7OsPrVNR4TEZLHoq36NBCPjv37kb7amQmw3fILc34J4NNC5VaxisqP+5jQPPLWZgliohCNrJb4+4UIXOjq9YXl1FgWLeDLwwvNczkoJQIrzvT86yiovzRsdsSws036Rdf974uN362eoC5GHkrGdCWu7vL62QTFT47LMFeVt1xYFWI9IFC+Heh8t970OMwTEtT25n73U4VLfQFPSzD7ax
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lmci1Wo7AdH1P32P32R45SlPC70dQbkj/sKejr0CcTu7HsAMTpkGQRamA0mK?=
 =?us-ascii?Q?qcW7F0WB+BBwe6Im/bHR5jRlCmKN+9x2oo6bmUHwNwu6R2pC0mdsLmfdAs5G?=
 =?us-ascii?Q?wVfT810vo9EigUaYeBw/o8AngwEZFtgkgtrLfAWIhGjd/+jk1QB2Ue9gHCcw?=
 =?us-ascii?Q?T3wdm+zZorsaaOwupxWb7AxZrfmbBb2VxtGiri/JjSJmvKGoRyfuP3JUg3rP?=
 =?us-ascii?Q?n93iwuqnlLSP+bYFijJBeYNCiuBO8NmE49OIuhGNUkhC8X8p6+3kM8u/ITH2?=
 =?us-ascii?Q?J6HTGtijKC0ZYT6vg3c/U6b6Kvbvw0FISMiZGxDN/mAPU3nDSVRZZq+MXQHB?=
 =?us-ascii?Q?LYAsxjRSneetijVp7k/k0+ev/PhBLGWg6fNg54FEo2iPZq2IBJDHCUx3VZw8?=
 =?us-ascii?Q?jS1LdmKRfmDQfvJcEoQLJm7eUrqwUX602xVoUayOJnyoKtBdZp8lBjmDbPZA?=
 =?us-ascii?Q?ihU6zzCDvDyXhqSmLoXSYbB2gcF7YQolUMQBQDlfYxTrh0c0IIZsVo95RI2V?=
 =?us-ascii?Q?02Ehisi8LBk26eZsOaJy1Oiu+3uxc1jTDIffg4H/IL0qRrf7v4Id6cWOZXf4?=
 =?us-ascii?Q?/nIIUcDFCjp9RV0O1OLQYA6uu2zVIWFPSsRmqoTz4zWt+gQzrwkrvq0CMgqn?=
 =?us-ascii?Q?3Avl2uWNyqMVDzSUDBMR+TON2CVl6G57+jSWDHjqBpCpKOV2c4VH7Y5Q3VBo?=
 =?us-ascii?Q?HfisJpppZ0z9JXvfgBO4D0oyA6pCNWXQMDG9BhdVGidJd0ZafRbYuOR9+9Uf?=
 =?us-ascii?Q?gajc82ck+FwFoaxEH/VQukdT7TdXsENarYluD4zt8L12cRCaGFJD8D/sENrj?=
 =?us-ascii?Q?DhOJEOVgxwnJHPPhaEJGr/NfGITs24Ovma+emFuPgYU17HQeFWyC26XzRVVL?=
 =?us-ascii?Q?uKl3MPxKHvFmaF4Br2YgtqoOZWEHkOdp6vNeSnDLjW6LwaUvdFZhvdq+KqrK?=
 =?us-ascii?Q?t2e5xKEEju58UOwlI6dJpbnSB/r1uKSBj50XKmiUT2baNLYzb4hzszlL+uqx?=
 =?us-ascii?Q?SzqlMbv/+pvU/Mc3lioQY49gaq5ztakznGMU2q0IlSKfvy6E4Tra1G3zqm8C?=
 =?us-ascii?Q?gwdpT6zFj1bYZ1dR+YtXJe+ZoFS5sASHFcOp4yHWl24IPkKXDk89xG+0qE7K?=
 =?us-ascii?Q?HGZQFIpncNl+DIWbhD6I5Nxvj3AHy4XkNd1Rjx5iLoI0GWKBMRpaRJR0kLY1?=
 =?us-ascii?Q?NgE0Sj5hdD3dPnPF1DKyW75kcw2kr+E7XecnKnyfQdQF3tAKuqEIY2hhiF4Z?=
 =?us-ascii?Q?3QXJ216vIcyrylAMREhVdgBqsizfjsJuXtUv6ItA3RK7j3vvSEgpJtwq2ZPw?=
 =?us-ascii?Q?/P+wMsLQE6hnTCDBqyLTObuxEL9UWGuFHgQKkoX9e9t0ggKajV//eESYOSf9?=
 =?us-ascii?Q?aZRKUizJN/Vq+qic4qEFKSI3EMbl9YWru1XH3pvaG+gVultwk53MqviS+EAM?=
 =?us-ascii?Q?nZkO7KqvE/U1J6j1U0aG33MCMqx5mJu52iVrHjMARIGt04EwS4nY2xsaOmPz?=
 =?us-ascii?Q?oClB4oc2aajqALgG+Z6HsG9eUVE+cKNcT14gw3LG23d/2c2hANpsCSSosMyd?=
 =?us-ascii?Q?6s0FYEc09rYtdUZaV/jpDVT9QdZwQggYBmUoTLPO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7899cbaa-3d60-4d58-8327-08dbf01d917c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:19.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duKgDCij7PMtX3ipW+wHDzMJnhO45ZXzZ3+Xw56AhwvVu78I7oCrjonay8inrTrw+/dW+sjYLCzETKzjPHCLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

Extract the main part of check() in pm_netlink.sh to a new function
mptcp_lib_check_output() in mptcp_lib.sh. And use mptcp_lib_print_ok()
and _err() in it to print test results with colors.

This helper will be used in mptcp_john.sh later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 31 +++++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 29 +++++------------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 2a9aaffabbcb..a28b480e164b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -301,8 +301,39 @@ mptcp_lib_wait_local_port_listen() {
 	done
 }
 
+check_output_err=$(mktemp)
+
+mptcp_lib_check_output() {
+	: "${check_output_err:?}"
+	: "${ret:?}"
+
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local out=`$cmd 2>$check_output_err`
+	local cmd_ret=$?
+
+	printf "%-42s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[ FAIL ] command execution '$cmd' stderr "
+		cat $check_output_err
+		ret=${KSFT_FAIL}
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[ FAIL ] expected '$expected' got '$out'"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
+}
+
 mptcp_lib_cleanup() {
+	: "${check_output_err:?}"
+
 	echo "cleanup"
+	rm -f $check_output_err
 }
 
 echo -e "\n${KSFT_TEST}\n"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 10df0475ac30..c0fc6f82a8c7 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -26,11 +26,9 @@ done
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
-err=$(mktemp)
 
 cleanup()
 {
-	rm -f $err
 	ip netns del $ns1
 	mptcp_lib_cleanup
 }
@@ -51,26 +49,15 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
-	local cmd="$1"
-	local expected="$2"
-	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
-
-	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
-		ret=1
-	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
-		mptcp_lib_result_pass "${msg}"
+	# ${*} doesn't work here since there're spaces in some arguments.
+	mptcp_lib_check_output "${1}" "${2}" "${3}"
+	local rc=$?
+	if [ ${rc} -eq 0 ]; then
+		mptcp_lib_result_pass "${3}"
+	elif [ ${rc} -eq 1 ]; then
+		mptcp_lib_result_fail "${3} # different output"
 	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
-		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+		mptcp_lib_result_fail "${3} # error ${rc}"
 	fi
 }
 
-- 
2.35.3

