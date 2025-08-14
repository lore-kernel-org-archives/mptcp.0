Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197992FF65E
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141416; cv=none; b=iE6IT07TnhFabXrsYs29DdgSO6FCRSS0ImkhZZRAvsl0U2hnhSSHMsU1hqOMosLfukk7y+0eWTRD77rmD4Okf2PNZRXwSSX5R92Vv4DRn/vT+7EUOiFWTLOLVT6KuFXOZQF0bgrSihL4oY4Wsyhq/L6mlNFP+qHw0tapGLLmT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141416; c=relaxed/simple;
	bh=2u3i/JryHaDIkd6ynb6z+rgaOm7tCnVslgP70lORmdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ5lIrvaSUPxG+EAatePXxMIG+PjbwOYjYnswMyiua9XnMR/ILdrog9Adhfojolb/AuzhaSH0PUK+ZRo90ldZGkv0jDsQ8Qa2ueWVmdBn8bJ3z3XoFQ9LBgMJSqzNP7JuYB6GoNqiq4k7oRKsnYUaYLOEZrbqyD1BItO/FHCxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a53de4078bd11f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_TF, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c471e629-4c7d-4888-be3d-98933b5712cc,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:c471e629-4c7d-4888-be3d-98933b5712cc,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:1cfe883f56072733f569b2637ee2c79f,BulkI
	D:250814111648786PB1BI,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 1a53de4078bd11f0b29709d653e92f7d-20250814
X-User: yangang@kylinos.cn
Received: from yangang-thinkpad-t14-gen-1.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 786377932; Thu, 14 Aug 2025 11:16:43 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] selftests: net: mptcp: add checks for fallback counters
Date: Thu, 14 Aug 2025 11:16:23 +0800
Message-ID: <cda4fc3f4b901c1919adfc0ce4258be0b80e7ea9.1755139312.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755139312.git.yangang@kylinos.cn>
References: <cover.1755139312.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, some mib counters about fallback has been added, this patch
provides a helper to check the expected behavior of these mib counters
during the test execution.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/571
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3a..2c1f0704bc17 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -74,6 +74,15 @@ unset join_create_err
 unset join_bind_err
 unset join_connect_err
 
+unset infinite_map_tx_fb
+unset dss_corruption_fb
+unset simult_conn_fb
+unset mpc_passive_fb
+unset mpc_active_fb
+unset mpc_data_fb
+unset MD5_Sig_fb
+unset dss_fb
+
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
 CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
@@ -1399,6 +1408,95 @@ chk_join_tx_nr()
 	print_results "join Tx" ${rc}
 }
 
+chk_fallback_nr()
+{
+	local infinite_map_tx=${infinite_map_tx_fb:-0}
+	local dss_corruption=${dss_corruption_fb:-0}
+	local simult_conn=${simult_conn_fb:-0}
+	local mpc_passive=${mpc_passive_fb:-0}
+	local mpc_active=${mpc_active_fb:-0}
+	local mpc_data=${mpc_data_fb:-0}
+	local MD5_Sig=${MD5_Sig_fb:-0}
+	local dss=${dss_fb:-0}
+	local rc=${KSFT_PASS}
+	local ns=$1
+	local count
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCapableFallbackACK")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_passive" ]; then
+		rc=${KSFT_FAIL}
+		print_check "mpc passive fallback "
+		fail_test "got $count mpc passive fallback[s] expected $mpc_passive"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCapableFallbackSYNACK")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_active" ]; then
+		rc=${KSFT_FAIL}
+		print_check "mpc active fallback "
+		fail_test "got $count mpc active fallback[s] expected $mpc_active"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtDSSCorruptionFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$dss_corruption" ]; then
+		rc=${KSFT_FAIL}
+		print_check "dss corruption fallback "
+		fail_test "got $count dss corruption fallback[s] expected $dss_corruption"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtInfiniteMapTx")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$infinite_map_tx" ]; then
+		rc=${KSFT_FAIL}
+		print_check "infinite map tx fallback "
+		fail_test "got $count infinite map tx fallback[s] expected $infinite_map_tx"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCapableDataFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_data" ]; then
+		rc=${KSFT_FAIL}
+		print_check "mpc data fallback "
+		fail_test "got $count mpc data fallback[s] expected $mpc_data"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMD5SigFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$MD5_Sig" ]; then
+		rc=${KSFT_FAIL}
+		print_check "MD5 Sig fallback "
+		fail_test "got $count MD5 Sig fallback[s] expected $MD5_Sig"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtDssFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$dss" ]; then
+		rc=${KSFT_FAIL}
+		print_check "dss fallback "
+		fail_test "got $count dss fallback[s] expected $dss"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtSimultConnectFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$simult_conn" ]; then
+		rc=${KSFT_FAIL}
+		print_check "simult conn fallback "
+		fail_test "got $count simult conn fallback[s] expected $simult_conn"
+	fi
+
+	print_results "check fallback nr" ${rc}
+}
+
 chk_join_nr()
 {
 	local syn_nr=$1
-- 
2.43.0

