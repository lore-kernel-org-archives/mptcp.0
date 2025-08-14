Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBB156CA
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141418; cv=none; b=KEnixxCWlbAakeAIGEAUYoRTyNFAKgLSQlCkB31d5GHJTVoRfoAOVZd0OPqwgH5kH2/nNT0AX6goBpaX+SOofsVrPcQufX3B1S9MYbfJcjACqwI2BuMpInpSWueVoat+97P9IYS07xmQLxU9Lo27Q1JxIM+aTGQEQi9GTT3eHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141418; c=relaxed/simple;
	bh=/HmptWy8FaUiEHPS+t2fPyVIbtJ/nhrAIsESOpsf0vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGvhwHE1dfys6tdrYgC1Rxk4QNitoivEGrvUpSeDGnn2qUbOiehlIuEQpWJTlfOacwu2oY2wj3+wOl2rNPCOquFeSif+lR0K3dY/4spMTv0B4adq56JX+5OBlRy84oG879mHkXpGiHTYKYwf8gFMPnVK6tAOoI7ACaRkn+/uDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1de494e678bd11f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4f45a389-24b9-4164-b9c8-92079c9a9ee9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:4f45a389-24b9-4164-b9c8-92079c9a9ee9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:4aab64a0399c95390b914f38b31ef0a6,BulkI
	D:2508141116512XGJVZZO,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1de494e678bd11f0b29709d653e92f7d-20250814
X-User: yangang@kylinos.cn
Received: from yangang-thinkpad-t14-gen-1.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2141648522; Thu, 14 Aug 2025 11:16:49 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] selftests: net: mptcp: add fallback checks in chk_join_nr
Date: Thu, 14 Aug 2025 11:16:24 +0800
Message-ID: <9140453b80a6c0f31118b733785b8d498c17836b.1755139312.git.yangang@kylinos.cn>
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

This patch can track these counters in each namespace and check if they
don't have unexpected values in tests.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2c1f0704bc17..ac9e9d4fed59 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -74,6 +74,8 @@ unset join_create_err
 unset join_bind_err
 unset join_connect_err
 
+unset ns1_fb
+unset ns2_fb
 unset infinite_map_tx_fb
 unset dss_corruption_fb
 unset simult_conn_fb
@@ -1582,6 +1584,20 @@ chk_join_nr()
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
 		chk_join_tx_nr
 
+	if [[ -n "$ns1_fb" ]]; then
+		eval "$ns1_fb" \
+			chk_fallback_nr ${ns1}
+	else
+		chk_fallback_nr ${ns1}
+	fi
+
+	if [[ -n "$ns2_fb" ]]; then
+		eval "$ns2_fb" \
+			chk_fallback_nr ${ns2}
+	else
+		chk_fallback_nr ${ns2}
+	fi
+
 	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
@@ -3435,6 +3451,7 @@ fail_tests()
 		join_csum_ns1=+1 join_csum_ns2=+0 \
 			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1 \
 			join_corrupted_pkts="$(pedit_action_pkts)" \
+			ns1_fb="dss_fb=1" ns2_fb="infinite_map_tx_fb=1" \
 			chk_join_nr 0 0 0
 		chk_fail_nr 1 -1 invert
 	fi
-- 
2.43.0

