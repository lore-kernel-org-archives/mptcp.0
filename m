Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BC2036ED
	for <mptcp@lists.linux.dev>; Sat, 16 Aug 2025 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328713; cv=none; b=itusjS6A0z6/QHkty3PP2w9r2nBWsp66+w5t+2Cmh8/gZiaVKR+2DG+Y0NEQrWEg+NHvWBL/aXaIUorvRfHpNi863vecuMFmww6gMrXMV0Sb/cTSGphMihmM7Sk3MuSN6GGxsQQs51W9iov28aHB7cCUzr3whjPTsaSbJohloc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328713; c=relaxed/simple;
	bh=ZtM+RgvmOz3fjnPragzA5b/5R/bSm08j0B1LEAQUFm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wtaz3xdUSDLhFV+hz8KWsFJs2kTzUFrMwUOl+2ok1pdOJuugdAurvvAvgNkGBcHNcfKCLY1ddjwaOALCTZNW4Mc9fIS6vE+iLM1PF6eKpbPnkR131s6Js6ByOfoHzp9l+YtYcqsvC3PN4KS2rm0CY0OwvIhLw8UjVtN9yw3ABmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2f9c7bf87a7111f0b29709d653e92f7d-20250816
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED, CIE_BAD
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:512866ae-fa17-43e6-95a0-ce31f71c8fef,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:512866ae-fa17-43e6-95a0-ce31f71c8fef,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:18a8dfe451f4bd380fd7bd9e362ec60f,BulkI
	D:2508161518223X6QBYT9,BulkQuantity:0,Recheck:0,SF:17|19|23|43|66|74|78|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 2f9c7bf87a7111f0b29709d653e92f7d-20250816
X-User: yangang@kylinos.cn
Received: from yangang-thinkpad-t14-gen-1.. [(221.221.50.113)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1774144175; Sat, 16 Aug 2025 15:18:19 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v4] selftests: net: mptcp: add checks for fallback counters
Date: Sat, 16 Aug 2025 15:18:14 +0800
Message-ID: <20250816071814.10087-1-yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, some mib counters about fallback has been added, this patch
provides a method to check the expected behavior of these mib counters
during the test execution.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/571
Signed-off-by: Gang Yan <yangang@kylinos.cn>
------
Changelog:
  v4:
    - Modify the 'MD5_SIG' to 'md5_sig'.
    - Fix the warnings of shellcheck caused by 'rc={?}', it should be
      'rc=$?'
  v3:
    - Squash into a single patch.
    - Using 'fb_' as a prefix instead of the suffix for variables.
    - Adjust the order of mib counters to check, ensuring it matches the
      variable declaration.
    - The namespace('ns1'/'ns2') is included in the output of
      'chk_fallback_nr', like:
      "ns2 infinite map tx fallback        [IGNO] (flaky) got 1 infinite map tx fallback[s] in ns2 expected 0"
    - Add a new helper named 'chk_fallback_nr_all', which prints only
      when an error occurs.
    - Fix some code style issues.

  v2:
    - add a helper which can check all the fallback mib counters.
    - put the 'chk_fallback_nr' in 'chk_join_nr' like chk_join_tx_nr.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3a..12b27c6e6566 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -74,6 +74,17 @@ unset join_create_err
 unset join_bind_err
 unset join_connect_err
 
+unset fb_ns1
+unset fb_ns2
+unset fb_infinite_map_tx
+unset fb_dss_corruption
+unset fb_simult_conn
+unset fb_mpc_passive
+unset fb_mpc_active
+unset fb_mpc_data
+unset fb_md5_sig
+unset fb_dss
+
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
 CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
@@ -1399,6 +1410,115 @@ chk_join_tx_nr()
 	print_results "join Tx" ${rc}
 }
 
+chk_fallback_nr()
+{
+	local infinite_map_tx=${fb_infinite_map_tx:-0}
+	local dss_corruption=${fb_dss_corruption:-0}
+	local simult_conn=${fb_simult_conn:-0}
+	local mpc_passive=${fb_mpc_passive:-0}
+	local mpc_active=${fb_mpc_active:-0}
+	local mpc_data=${fb_mpc_data:-0}
+	local md5_sig=${fb_md5_sig:-0}
+	local dss=${fb_dss:-0}
+	local rc=${KSFT_PASS}
+	local ns=$1
+	local count
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtInfiniteMapTx")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$infinite_map_tx" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns infinite map tx fallback"
+		fail_test "got $count infinite map tx fallback[s] in $ns expected $infinite_map_tx"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDSSCorruptionFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$dss_corruption" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns dss corruption fallback"
+		fail_test "got $count dss corruption fallback[s] in $ns expected $dss_corruption"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtSimultConnectFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$simult_conn" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns simult conn fallback"
+		fail_test "got $count simult conn fallback[s] in $ns expected $simult_conn"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFallbackACK")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_passive" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns mpc passive fallback"
+		fail_test "got $count mpc passive fallback[s] in $ns expected $mpc_passive"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFallbackSYNACK")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_active" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns mpc active fallback"
+		fail_test "got $count mpc active fallback[s] in $ns expected $mpc_active"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableDataFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_data" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns mpc data fallback"
+		fail_test "got $count mpc data fallback[s] in $ns expected $mpc_data"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMD5SigFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$md5_sig" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns MD5 Sig fallback"
+		fail_test "got $count MD5 Sig fallback[s] in $ns expected $md5_sig"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDssFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$dss" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns dss fallback"
+		fail_test "got $count dss fallback[s] in $ns expected $dss"
+	fi
+
+	return $rc
+}
+
+chk_fallback_nr_all()
+{
+	local netns=("ns1" "ns2")
+	local fb_ns=("fb_ns1" "fb_ns2")
+	local rc=${KSFT_PASS}
+
+	for i in 0 1; do
+		if [ -n "${!fb_ns[i]}" ]; then
+			eval "${!fb_ns[i]}" \
+				chk_fallback_nr ${netns[i]} || rc=$?
+		else
+			chk_fallback_nr ${netns[i]} || rc=$?
+		fi
+	done
+
+	if [ "$rc" != "${KSFT_PASS}" ]; then
+		print_results "fallback" $rc
+	fi
+}
+
 chk_join_nr()
 {
 	local syn_nr=$1
@@ -1484,6 +1604,8 @@ chk_join_nr()
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
 		chk_join_tx_nr
 
+	chk_fallback_nr_all
+
 	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
@@ -3337,6 +3459,7 @@ fail_tests()
 		join_csum_ns1=+1 join_csum_ns2=+0 \
 			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1 \
 			join_corrupted_pkts="$(pedit_action_pkts)" \
+			fb_ns1="fb_dss=1" fb_ns2="fb_infinite_map_tx=1" \
 			chk_join_nr 0 0 0
 		chk_fail_nr 1 -1 invert
 	fi
-- 
2.43.0

