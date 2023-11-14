Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0F2F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FljSe1LZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixKm38+NrMBEVBK5Jxac8K2rGNaEFmqRql3cv2FhuKZBOHa6QQTPQGsI3gKhrtZVt8A6BAWaalPsDcm6eD2s+xzBh6V9ASnn14iOsCH+jKqDhVz8iFG/aBNYmM6Rr1HOESgEW3WxJnYoxcb1pCI6CaooClwznIaiEzu82g6IgteBOhoYjjtvK+3BRcZQaoFR0keZBCNY2QoiSgOGHoiQjobizQcILNjmttD5B903Y9Ucw1ad3dQen16iqmOj4XL9tc8pmlTTzrHSdqq+WJ5+pH+zaWQknte1oMSlA94YUCeFkVyY1LS7qUyLfmqSZv4EzvazhyLXPe3M1E/fP2tJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJn+ehcXzJm3YDiWrkeNlPMTyKXa3RMkAHKz6/o/qTc=;
 b=C6Ezw/sUpEmmbVdOsk39RnXteZ3JAEINv1SV8R0Y1uuwYXrKFrW851HtqbespjyixpxppE8e5O56OERcN60p50DJbJaY0SJDxuKiJ4C3tAeMknbpTv+lBy85B2TeGn7jGqJcZXw2UAxZsCM+0Xq5y4tlAyrOGh6vzRtqT4a8I2D0EdZsIJOExUmOnmaOzY10JxLGmuMCSQUg4/45S7fNiQpIitWAUTi/O60FWR7whPX6DYQSZ1NI7Iah3rbNkA/JL0CdHJAuoGPwcg9fM6zXHCiSTl/V2URijk+8OXuxiHVmuykXggxa+VA6TONRRM8dMo818sH/O+mK7zWE+Eb5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJn+ehcXzJm3YDiWrkeNlPMTyKXa3RMkAHKz6/o/qTc=;
 b=FljSe1LZ0c3QbZ+UQFSK61thUblxaVgfgKlY0ntWBjfOD7laBSFdUbsWgAwl9MN9+JAFjxRJRxYQJQBcghS/GNUqWgilFClFbM+j8ZZT1jpwpuD1Qp/w/tBMkldlKYYxjCc4uu11FqTajSQOZOpRQoO6ZQP2kakVUNMiMpj1OHWcH9gUZHQUzx4+4JtEXO+OI6rJ1JWqGFfwRnQfjiee2fK/o/ycLKRN3ZrqOWPtdSMX5vXX0chSWyypG2OXVBrR2y8FMp9yfv+sIvhZt2xeJwOpywPryjwPFDMHXeSZljKx3RscNA0rY2fVsYHS3zGVnWY5fsqljvLEmKwFUtzyUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:41:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:41:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 27/32] selftests: mptcp: change capture/checksum as bool
Date: Tue, 14 Nov 2023 14:35:46 +0800
Message-Id: <f6aa093b3cd192b0b0d8937a5d8ae403370fc2a9.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: b883114a-22dc-41db-6ed5-08dbe4dcb609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0RWZZcOC4DEUxn+vK3t3o0HOdE0y298lXkL0cVfcibMUOpUpp+FtIuZiY+sR96vpRZ1ce7CQvauhvpwCdCpKo2vM9juYORkXNBwUdAhZSfEAoUofI8DaciSL5vhBF8xhEEUAlGySSTRhExUdCQKdhVOV1ZcYT+FU9Y5OcotQuSU8+bvFNRrnwYdYnri06XdsNSss3CUb/nOLeyEHBfeZB/peEQmjQQcoMRcMHnfRCaPP+fpD11LJgvg7633lG04hoWuz61oAM0I66b3YAqw2pOQJnhaVtMdL2I23qYYOplLS6TDWhqKhNiEFJt94DBwC0/O+fKiHPV5xhdyKwz7t7d3uwuW4BcM6hvV6lFm3fODOsQIt4c8f8yYroqEM1jsND33UlRN+bHxO6Jfyb3GeGpY4CFjBSMMCECZKi7OZOhfRCVFqS1xGdWoLF9t4SiYfxDTKUx4GboIFxeYwH8XYm7P6cB7kwbwfauGq4zlPBYNDc9WLB4rpKzY4JGq1B4JUyPaFA/g4JcRJ8iL3R1eoTQ8/dsq1KXhQBip0c+0fQj3POzf47erG1Cc6f9fQu+a5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AsklqSV4cL9YVn0+hqDj7M+Ojz18LM6gUSJYGCIDDqN+E1YDpeHAFl1yxunl?=
 =?us-ascii?Q?57FYCheN0CMw9MGihqSJypk/zMLJBcg7w+8FhDCGuxdqAKOIBxWny3MJG8ZD?=
 =?us-ascii?Q?WKVJk7ajMWyAnlBby7PdMrpyemS1gKqL1LgX0giRV5twJ4zOoTZZz6pw0LHe?=
 =?us-ascii?Q?EM+mGssGh4+L15FJWDelsULKiNI/g0CGuIc69JvBPXC783KA6Bb5D8dsZkxS?=
 =?us-ascii?Q?6yO0GRsDwG1klReHvsSoUEgV0X3smAtqrUiosL7f9375IF/rilMQDFniagns?=
 =?us-ascii?Q?LqCyuHcgh4aRQVpQ1ZW5auqyYmJzbtqr4mg+6ck8z73GeuwVRaPx57VA4Rtq?=
 =?us-ascii?Q?v/ymHaBje9gyXbjEKzyqzzq8xjqWieuwU/Q9A/g/xGvuvuW81/fZvz9+CuLz?=
 =?us-ascii?Q?Azu8mH0hLoK/DH7SW3KEGapDFzCKeDNECXPdOzndBOPF299H4DSq3jTaNaWF?=
 =?us-ascii?Q?CBScNS+NRowvmRvqE/6WhrS18RHkF6tvCFK0YhgYZ4GkbTwsWPNjRMiHC9/y?=
 =?us-ascii?Q?5shweeqnXj6j3jyGO42YjggjtS6Sh7SwpWBVGA7W1by68AirJScYVUhdm8fI?=
 =?us-ascii?Q?gtj8JK+4pdvTISZVows80ieVNljEaDkKuUgAqgVcIGnnDhNuxORzI/BRSDCj?=
 =?us-ascii?Q?GX7faXknJ/vTASFAO2oe3S2+/Yssic1kJ72a0b3eGsBVah71Rz+BJHj2CcLL?=
 =?us-ascii?Q?tnbAfE98G6KiAYL9A0uram+O8RaIABnZl5zw5mknEHtj+sxbzUEq5YmIB81j?=
 =?us-ascii?Q?Z/O3LHvRxFCqqC9+ob6PnlHuH4Je3jloyKtyM8UQu2Jx7xT9lwDQUPCp1kw/?=
 =?us-ascii?Q?4/DP0suR2Do26ZDf9dvwfI/j5UQSzpF6ygnCu5WcCvBhErjNb7ZF0JzMGBvH?=
 =?us-ascii?Q?AISY0KIZd5mkAFaSFxKAbHA48q9bRLmURdHFA7KqYNUyeV8qwzFPJWbG9GVz?=
 =?us-ascii?Q?LKqMsokybibFX8K2yWnADkcQpaRK5SjdOg52iR+KGcC13iknMm9V0eqtDZ3Q?=
 =?us-ascii?Q?GdZYp/Y3OVNZnAOWEa24n+7TzCQHrD/y1MPvM4jGRF+vlXBuvfCfTpiXgT0X?=
 =?us-ascii?Q?sfKgoiTIIDbKnhrpL51mSaodIVmmpq5uwrUh0l0Txq0CpkzPw0NBw43w5UZE?=
 =?us-ascii?Q?lt2E31Fu12XQG8cp8Pcc3Ox5iuLPpmv2/KFc6lMzGXC+3Cz/MHBiZNlZEDPf?=
 =?us-ascii?Q?dwf2pF9o7GFiAij8nTlwIgJrPSiNPVWoV1JoZzWo1Gw/A9yvX29igGCtIlwa?=
 =?us-ascii?Q?o0zNQMlTk/Ct9jO/ZGKnXjelATT9S6bA5h7SC2Qx7Hnq2kAFtXjoRutMrFxj?=
 =?us-ascii?Q?71YQj9GXgXO/ZmgjVY0kxSnWCpGEmjj54ys0z3CzVmFXs5e1z3m7XU/lBimi?=
 =?us-ascii?Q?LHUvDD+uB1DA7iQuV06Q4+zMTUf0Yot5/PAozFX0IjSGFZchnJcw0kOo9YTG?=
 =?us-ascii?Q?jRWv/0whtKSMiDF9epZYMqxM8RrKxMLgV1itr73/CWkhEq+u2Zt5OoRJWWZk?=
 =?us-ascii?Q?gc1iJg0zo8ISfxlfnatmcoM87d/5D8wja0dGFNO0c0J4wv2GK79hry2cXqrO?=
 =?us-ascii?Q?0ESXhkwpBPpybmZSsYEqHyYwWAXg8W/yIODGcixY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b883114a-22dc-41db-6ed5-08dbe4dcb609
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:41:20.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p46SSXoxs07MPl//UK1dApi+PptolzeEzjG8KTzaF6JRPlgSqt7Kj2vQETbRL0vORCOmsDgTr3qsvrUQggpoGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

To maintain consistency with other scripts, this patch changes vars
'capture' and 'checksum' as bool vars in mptcp_join.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c2f78c849da8..63f89bc9b7aa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,11 +22,11 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=0
-checksum=0
+capture=false
+checksum=false
 ip_mptcp=0
 check_invert=0
-validate_checksum=0
+validate_checksum=false
 init=0
 last_test_failed=0
 last_test_skipped=0
@@ -76,7 +76,7 @@ init_partial()
 	for netns in "$ns1" "$ns2"; do
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
-		if [ $checksum -eq 1 ]; then
+		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
 	done
@@ -348,7 +348,7 @@ reset_with_checksum()
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 
-	validate_checksum=1
+	validate_checksum=true
 }
 
 reset_with_allow_join_id0()
@@ -381,7 +381,7 @@ reset_with_allow_join_id0()
 setup_fail_rules()
 {
 	check_invert=1
-	validate_checksum=1
+	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
 	local tables
@@ -953,7 +953,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
@@ -1054,7 +1054,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -1442,7 +1442,7 @@ chk_join_nr()
 	else
 		print_ok
 	fi
-	if [ $validate_checksum -eq 1 ]; then
+	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -3579,10 +3579,10 @@ while getopts "${all_tests_args}cCih" opt; do
 			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
-			capture=1
+			capture=true
 			;;
 		C)
-			checksum=1
+			checksum=true
 			;;
 		i)
 			ip_mptcp=1
-- 
2.35.3

