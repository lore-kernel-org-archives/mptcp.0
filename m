Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D042222A7F9
	for <mptcp@lists.linux.dev>; Fri, 25 Apr 2025 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561939; cv=none; b=VbjQ0CbhT5iGvl0ZvufqcbY61zgBsubP8RPo3sW0uTDXV+NjipDGceRYRFc0OlqQn94M5F3SoI7apAo4PhSq1W3BiyL31I3miscFf0dxL8/HsQSPi01OTA2aaxsIRBm4pFbXs6/WvxA8vrZQaIIYZCLrZdeFQY42LZZEP5afQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561939; c=relaxed/simple;
	bh=FuLQNZCtJwwjtoD9J9otd/7SH62eyYtrmeqf5KWxvu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiDYS5t4mGpEvxq1mrA+5k+0KJOIcubNCAO+h/JefhY4SrksbgMATx7zthPHXDEw02uJY6D59pelOq3xtIR3vW8kY8SJ4kSXDG0ze5fih7lienMDxV+qNoFrC5KoFw/1gP4lp87EHBSmNkcqraX/DopkRPFpYHXsditfVij0Xko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 291f5070219d11f0a216b1d71e6e1362-20250425
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3e9939d5-0e32-4aca-9119-0cd662683f42,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:3e9939d5-0e32-4aca-9119-0cd662683f42,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:22302a3d343ce994fe7d728d2067f094,BulkI
	D:2504251418535UW0GMAT,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,
	TF_CID_SPAM_SNR
X-UUID: 291f5070219d11f0a216b1d71e6e1362-20250425
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 784904938; Fri, 25 Apr 2025 14:18:53 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 5/5] selftests: mptcp: add chk_sublfow in diag.sh
Date: Fri, 25 Apr 2025 14:18:43 +0800
Message-Id: <64427b00a88e0ae3f46ee40386069b2dd9abb994.1745395366.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745395366.git.yangang@kylinos.cn>
References: <cover.1745395366.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch aims to add chk_dump_subflow in diag.sh. The subflow's
info can be obtained through "ss -tin", then use the 'mptcp_diag'
to verify the token in subflow_info.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/524

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e7a75341f0f3..621b405e519f 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -225,6 +225,38 @@ chk_dump_one()
 	fi
 }
 
+chk_dump_subflow()
+{
+	local inet_diag_token
+	local subflow_line
+	local ss_output
+	local ss_token
+	local msg
+
+	ss_output=$(ss -tniN $ns)
+
+	subflow_line=$(echo "$ss_output" | \
+		       grep -m1 -Eo '[0-9.]+:[0-9].+ +[0-9.]+:[0-9.]+')
+
+	ss_token=$(echo "$ss_output" | \
+		   grep -m1 -Eo 'token:[^ ]+')
+
+	inet_diag_token=$(ip netns exec $ns ./mptcp_diag -s "$subflow_line" | \
+			  grep -Eo 'token:[^ ]+')
+
+	msg="....chk dump_subflow"
+
+	mptcp_lib_print_title "$msg"
+	if [ -n "$ss_token" ] && [ "$ss_token" == "$inet_diag_token" ]; then
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	else
+		mptcp_lib_pr_fail "expected $ss_token found $inet_diag_token"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	fi
+}
+
 msk_info_get_value()
 {
 	local port="${1}"
@@ -316,6 +348,7 @@ chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
 chk_msk_cestab 2
 chk_dump_one
+chk_dump_subflow
 flush_pids
 
 chk_msk_inuse 0 "2->0"
-- 
2.43.0

