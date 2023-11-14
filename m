Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A115AF6
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SH0VpZ7J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxJmrBZ/gogt4ugaRsQrsiIhSpNT4KxMTYoxlYhybHtSWSxJZ+SKtgqoHtTx5pAaTghmjf27sv6eoU3Dfcy8hNtRv+YnwWHBrc4tVC4ogpl0r/Xdmq01WIJczMBgwMgtWNvMfUOXW2KlYVL4bgNhoKHIw2QRxF+5N2SiwNDfe3NM3ufCVDMJoFcm5YOAXMm8HAlGcTXCwXe+8uq5BiMPB8/NnQoFElsjYY9fngs+RSPp/XlbQi0yLNlVs+RyYHtYK2gfuhZEx0uuzkWiMBmQvPOToE2Vp7cGjYM8E5YlDmjfU57i60pqAWBW4tj2CStFFGSkaJGI9Fo2vY1F62vkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJn+ehcXzJm3YDiWrkeNlPMTyKXa3RMkAHKz6/o/qTc=;
 b=ZL7zM1aumFEAD+Uk5nrtXOQC5O+aIPQj5J1OsvY1xmAR2COWS0tEV1bYN0Qwxf1SWuuwDyXUihN9ZoBQvs0BdymLWXooRxjBaSkryzPPfOPYuYZt35/M0GcXb7gdFYhknbKJ/1kotnpaFY+RyOwcjckdMAelfwtGUhbqoThWbhFDw/QxqmJEFsibn82Fhb/i8QO31A9X2CK4IgbZAgu0Cq8ZKuP7zeUJ4WVSHFARg0tEWgzMOhr1DCLfFbP2WKXFm5vkcEAU6HhHRXdquzR6/TUAyS+NIawD9RVPODzuSrbQ6wVadeDuXb+i9KV6erXAxi8VfXxuVf/9bJybYCCvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJn+ehcXzJm3YDiWrkeNlPMTyKXa3RMkAHKz6/o/qTc=;
 b=SH0VpZ7JPAvEF60wPFv85X6ahI2QxFrVH9WBOSFx1XTeBsGhLzHaOYEI5llwTizN9Q/r6uRTGttkD5UfWSLSirE5z7Xxh0llsyZRO2VdPkn6D5JtKuvE1GA7dWJHfNM+QqtPUdwa58eGmLvcGjWti+b4WQ4R9A3i11DZeJWx3wYlQ832Owrz5+CLndS9pNenPgQ3rMJTrFuYNfoU3xiZSiC7+YSmFIneldRF6VbiYUOmnBLFOLMs2nyIp7rUwG5lQiDfRElCeBdS5oRzVhyrn6IOf2sYqW8zXYpYGHzUNfDp+L7pD8agAzPwmAT2GFaBlwrYidDf05tgWG7AfQJSHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:24:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:24:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 28/33] selftests: mptcp: join: change capture/checksum as bool
Date: Tue, 14 Nov 2023 18:21:58 +0800
Message-Id: <4429dc6be768171a5c85f5c7c3c3f472d2b105b6.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0167.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b76ad90-664c-4037-25a7-08dbe4fbf188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IhQYAmX0ho1SkLTzTjBE0vHlcIdg3u2+63CN94Fl5txv+MZyc80GbteJLctGINLhliBuW32Gk1ghbUX5kmpXLVrRh54fKUpR+IczW97YOT/T/bjgIBFIPKb0PBRNyxgHlagUFIeN6gWXrGl5CtdonA6rpz+GDVTyogoY/uRW4wBpZ05C4zPEry7thCHLTeH2ChCJRO6UvHReKkUl9sI31LdmJqHFclGlPgbNCfoWG/L1Foin2EtFX9aO+HdJLS/30tLjDbz5O4JQCjhW4y2mRuEYdSUCOy8cso8DbGnlE1uxNdOUC7plkOAKZSVvJWN4C/BYhsIcWmWoQnFxX+wnHhRUA35g3rveuJuCY6PIjJnTLOrrsVK5BHSnvmDSx9WzYgGnFp7MJoNP1HiM3RQ/dZg0P1PX2INSBJBD98tt/9QxR9xZbsBfMlZGHa4O9hSKahADZEMN4Lfe0vLR8Wf1F7jNGIFXsW5kM6W0rJIyaXPfuFomvQXkyKxMfSBjiTU1tJkHH6fMdqJizEaB5nzyWDeRDFSjg/1JmhKqKj2022OMU9v8FYjjS/1wvcj9zBfO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6506007)(4326008)(8676002)(8936002)(26005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N7+bxSVn3yiTcs7jI40hu2xP/hDir4uRkYxT3fMiwChCHng6INU1RZmfiqsa?=
 =?us-ascii?Q?kDdLy5i+FE7rt9SSM+AGDBIvy8qEGeV2Ikfn5Xt7ivQP02vSIONr4fxwRwth?=
 =?us-ascii?Q?dUMKQhwsf/8qyilxNPiTZ9A0odY4nN3S+1VTfKc92gJ21oCpxVX4oGH+d5we?=
 =?us-ascii?Q?aEGt2eLA7ynZNdgx92H7Ht6jgvWrzWiZqZgZEe3T4zBwXYHan8G7JF6LsQD+?=
 =?us-ascii?Q?uwejE4KppUU9HRs1fcCmf0K+0UN/VYSxam8H272cMIc+LFsVkEEOuza3aVde?=
 =?us-ascii?Q?K6fvAD3ljA625Y3Nrjyz2jeb898mLgixWoBLyiZwwsubRGWnCzoyNuHIulVR?=
 =?us-ascii?Q?KfvnbAqBR7PFIgVznSe/aOqk4m6KcOwTEGslwSZyW30C/HCF2LGAuwd5RLZW?=
 =?us-ascii?Q?90AG/8o//kl1YCfSJrwdolPlvnvp9XX2IbIhMIfYrjReCOhgAMZZc2UW7Fsl?=
 =?us-ascii?Q?p47MySNCGtU2bUiwQyTeY5+quJS8+tJ+YFZj8Z0/l7GFrkbEfvT8qlyMn1qe?=
 =?us-ascii?Q?L1FmTiNSUf6KfWuC0w0GDLvpK8HQDOr7mOt3Kcv5NhVEMLRf1RLBAuqjZcqt?=
 =?us-ascii?Q?j9ILQOw5krtwjh67qh6D1GO00bMPZYQh5o3MFw2ZImUoP+XqdLjkfb05/tyG?=
 =?us-ascii?Q?4g6ObhCG5Ahusyj4GN+gmoHvVVmq8TjsyjC48XVXnnElHg2++AgYRI3fH6Qj?=
 =?us-ascii?Q?4Fb4HlrPytCls47GXzReBh5JKMdCl+cQ/n6yKec9UW9rI4ZTbZSJGCDFR3sa?=
 =?us-ascii?Q?UWH7pEnGkTcKRrpkLBtG2khuD94P+jHDy45eq564z1YTK09v4jagXXpLNeaa?=
 =?us-ascii?Q?Nea/jEe1YhXcZWtNyU/JiEKGOFKZXy+8bbRD14ufXK2TWffMRa3nyaIPAsuM?=
 =?us-ascii?Q?1fReeEV9RTMF8eEzjW9x7aoDAlooZeLLUeycvpKaBSIgaDnS/k56inM4NCxV?=
 =?us-ascii?Q?YaOwQP1CyE1PA7PUJpjdzn4LL1eT7FgU+SkKhh820pDwjk77rRr5cQlt7snr?=
 =?us-ascii?Q?Yl1caCqZwfM3bBNNsAHPD9kQ4faqmHIcVGUdOCX6XwbVmtfIWg6lyxXSen7c?=
 =?us-ascii?Q?4P685ahWgjI2/8vgLsz2UxbXKmyyZY3Q9w23X5gugkh1p0/0v8Ei6g3pkY6V?=
 =?us-ascii?Q?QEcED27pFPAYVCPMH0CiIiVsHyHeVk+paIYx4Tzyd7Fg4bcbnF7oDIY7rSyL?=
 =?us-ascii?Q?9jk8sRAdmP6yYDbZov2NLoSjd3dafLFMCrWD9Qkanc6A90NEkkvmIROAswWw?=
 =?us-ascii?Q?L1kc1PhvUuf0+poNuZEVKBw26lPx85Yco7kwg8GORLOUohZyDGsxJR62mgWl?=
 =?us-ascii?Q?1M6o5gfjN9r7aof115nBGl2tI3PaYE1ntVnn0ErsN5n+w8zL9aoALzW/cTyx?=
 =?us-ascii?Q?C88FYKbdn1+t6lN1mjOruB168EQB8qeSskE1jJNwDH0gf2HbQ7vVNrgTXX3f?=
 =?us-ascii?Q?9sxT0gdiZI3lErTy+jAcJvOgs/LGr0gQcH1tuCNxQDG+ePdIQBKEHVsGiFEb?=
 =?us-ascii?Q?a7bHom73F5nMlF0j9j+Ch1VUX2KZ399oGhNPzpUUTA2sViDw4ub5sN3bw0Xx?=
 =?us-ascii?Q?4meOY4DMtvNAbA0C15uEPo21QIuyBIXZa0Pazj30?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b76ad90-664c-4037-25a7-08dbe4fbf188
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:24:54.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trU5d7/5ymNdJBRQuFMvLYQsaax2rR4noF/lK+ZIY/1bsMEqpOKDe5zCzybhKmhpUn3s+TRHd29bhRds3rEy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

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

