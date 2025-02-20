Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BA1E5721
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035539; cv=none; b=h3vfRYDBLSFfOz6N7fJLfM1KWzKUaakJ7YEJrsqKHYqeo6dK1P3rXGHAxOQhQeXMdYRteDFLtjU/sWxStQakhBv96yXEb+8cTRF+2mtK+cZFDEOy5sByObK+4T++z+Xc9k7v+1IefTOovh67yjZPIpdOed6ub4QtrTClHLI/kOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035539; c=relaxed/simple;
	bh=c5BP7/UCxDxufaYcGvmLAThLMx2r1i61lsdELrkB/H8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KS7b5nzeWAyVH/Jw/T5tbrFNBF+EWQP+kiFxUtS946QOuIIS3/pkYhRVzhgTi7JzZ4CfdjJIdAy0aA8FtCDtJvSuAeRkxxwdTfZW+KtyjyLYeBvDxH7MU6SrouK1fZK4CVyaULfITKy/V33NMqN9w11YsabEkdP0RCZ15mKchMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fc45100aef5911efa216b1d71e6e1362-20250220
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:64c6affc-615f-417d-8be7-2372bd4944b3,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:64c6affc-615f-417d-8be7-2372bd4944b3,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:d11a9645302bc667ff35191069c747d1,BulkI
	D:250220151203MJ9WQOA8,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: fc45100aef5911efa216b1d71e6e1362-20250220
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1669898305; Thu, 20 Feb 2025 15:12:03 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [mptcp-next v2 2/2] selftests: mptcp: add a test for mptcp_diag_dump_one
Date: Thu, 20 Feb 2025 15:11:25 +0800
Message-Id: <bf32d17ddef19059b2806a041a9ea322ecd1977a.1740035000.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1740035000.git.yangang@kylinos.cn>
References: <cover.1740035000.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new 'chk_diag' test in diag.sh. It retrieves
the token for a specified MPTCP socket (msk) using the 'ss' command and
then accesses the 'mptcp_diag_dump_one' in kernel via ./mptcp_diag
to verify if the correct token is returned.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/524
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 2bd0c1eb70c5..9a57c27b14b9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -200,6 +200,28 @@ chk_msk_cestab()
 		 "${expected}" "${msg}" ""
 }
 
+chk_dumpone()
+{
+	local ss_token="$(ss -inmHMN $ns | grep 'token:' |\
+			  head -n 1 |\
+			  sed 's/.*token:\([0-9a-f]*\).*/\1/')"
+	local token="$(ip netns exec $ns ./mptcp_diag -t $ss_token |\
+		       grep 'token:' |\
+		       sed 's/.*token:\([0-9a-f]*\).*/\1/')"
+	local msg="...chk dumpone"
+
+	mptcp_lib_print_title "$msg"
+        if [ "$ss_token" != "$token" ]; then
+		mptcp_lib_pr_fail "expected $ss_token found $token"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	else
+                mptcp_lib_pr_ok
+                mptcp_lib_result_pass "${msg}"
+	fi
+
+}
+
 msk_info_get_value()
 {
 	local port="${1}"
@@ -290,6 +312,7 @@ chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
 chk_msk_cestab 2
+chk_dumpone
 flush_pids
 
 chk_msk_inuse 0 "2->0"
-- 
2.43.0

