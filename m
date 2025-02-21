Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBE1F8901
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116080; cv=none; b=OFOXXVce37+JRMfTI45TEymj2pXXZx1Vjoz0qrMeoCwIIQipwZQV7Es+8zwPJo8H40MbgRkGasI15VSJgiwYPvz2QVS3o6kr0kOkAZI5Y/9nLRvKkr4iFL3kKiG8dD59F9AZMN7cU9TFiZRWPTmDlhvtwmCSqorZH7vcWhv6mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116080; c=relaxed/simple;
	bh=MkHSL6YG7JTUVdgUec7bcKm5UymV0j4jNYSQOvKpWp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y62mdbs0xVk4gb1XsyavRvOyyABAZy4cj7j71pjbGQHuLK9VAh3lqzKV8LbnyyifYEATtYkx/kmUvgN7CoWQ34RObue3YYh82vgTMcsQlrG9V7Mts+9jA3ByamI8q7aaPCgvCe5s+rxsRMeE130iUqtfLkw5U4gryCw0suGlFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 84b398b0f01511efa216b1d71e6e1362-20250221
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
X-CID-O-INFO: VERSION:1.1.45,REQID:979662d0-1744-4bd9-828c-c23c17ab4ddd,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:979662d0-1744-4bd9-828c-c23c17ab4ddd,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:eaa280f37ad05566a7a7586092d4cee5,BulkI
	D:2502211334306MT7U532,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,
	TF_CID_SPAM_SNR
X-UUID: 84b398b0f01511efa216b1d71e6e1362-20250221
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2004760912; Fri, 21 Feb 2025 13:34:28 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [mptcp-next v3 2/2] selftests: mptcp: add a test for mptcp_diag_dump_one
Date: Fri, 21 Feb 2025 13:34:19 +0800
Message-Id: <3bce55e361d2d7cc9706db2ec1803cd3ef55791f.1740115494.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1740115494.git.yangang@kylinos.cn>
References: <cover.1740115494.git.yangang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/diag.sh | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 2bd0c1eb70c5..5c10fe406d91 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -200,6 +200,32 @@ chk_msk_cestab()
 		 "${expected}" "${msg}" ""
 }
 
+chk_dump_one()
+{
+	local ss_token
+	local token
+	local msg
+
+	ss_token="$(ss -inmHMN $ns | grep 'token:' |\
+		    head -n 1 |\
+		    sed 's/.*token:\([0-9a-f]*\).*/\1/')"
+
+	token="$(ip netns exec $ns ./mptcp_diag -t $ss_token |\
+		 awk -F':[ \t]+' '/^token/ {print $2}')"
+
+	msg="....chk dump_one"
+
+	mptcp_lib_print_title "$msg"
+	if [ "$ss_token" != "$token" ]; then
+		mptcp_lib_pr_fail "expected $ss_token found $token"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	else
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	fi
+}
+
 msk_info_get_value()
 {
 	local port="${1}"
@@ -290,6 +316,7 @@ chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
 chk_msk_cestab 2
+chk_dump_one
 flush_pids
 
 chk_msk_inuse 0 "2->0"
-- 
2.25.1

