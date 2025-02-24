Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27FEEB5
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387783; cv=none; b=aPepGtVgsInQa6puJA4C5fFwm8DGLjizRsWuqU5Y7FA07vREmkkYQZuKmiDWnjI9iivD1jhs95U4i9hqeGwAUhmnkg6EsT9XJKywg94dx4AsqJg8CAO1TYZb9xcnJWfwRxMH4QyJb5dhvm1sOopWN+/P31kbjF3E1ZvdEwQXmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387783; c=relaxed/simple;
	bh=1V+YvU9LKWPu6gtIIRrix2+bfYt8H3jk93eivspOYN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD+uq/IilTk6H9vlA2TeBftQgWyHcQ/Ve1qB++2G112gRKVvLjZi9qHE9qfVcap3RrGQyv7Lp5uu9HXmVbLw5S5UwMf5XEmiz+pqQpbZhDJUPaOJPSEBEjSh2sewvBjsJCxtCws+oNdoffizl6vjBhA21qrzQDs6W+GLojxTJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d914d64f28e11efa216b1d71e6e1362-20250224
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IC
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: EDM_GN8D19FE
X-CID-O-INFO: VERSION:1.1.45,REQID:61d41c7f-66d3-4251-95b6-475934287a28,IP:10,
	URL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,
	ACTION:release,TS:-60
X-CID-INFO: VERSION:1.1.45,REQID:61d41c7f-66d3-4251-95b6-475934287a28,IP:10,UR
	L:0,TC:0,Content:-25,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,A
	CTION:release,TS:-60
X-CID-META: VersionHash:6493067,CLOUDID:00aac75e0924b768dd21a591297d4acb,BulkI
	D:250224170249PVY4ZXEC,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 1d914d64f28e11efa216b1d71e6e1362-20250224
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1197798771; Mon, 24 Feb 2025 17:02:46 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [mptcp-next v4 2/2] selftests: mptcp: add a test for mptcp_diag_dump_one
Date: Mon, 24 Feb 2025 17:02:35 +0800
Message-Id: <2a1f8438f2ac18d885e067bc13dcc3ba0ff70d0b.1740385876.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1740385876.git.yangang@kylinos.cn>
References: <cover.1740385876.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch introduces a new 'chk_diag' test in diag.sh. It retrieves
the token for a specified MPTCP socket (msk) using the 'ss' command and
then accesses the 'mptcp_diag_dump_one' in kernel via ./mptcp_diag
to verify if the correct token is returned.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/524
Signed-off-by: Gang Yan <yangang@kylinos.cn>

---
Notes:
 - v4:
  - Optimized the check logic for 'ss_token' and 'token′, and before
    that,first check if 'ss_token' is empty.
---
 tools/testing/selftests/net/mptcp/diag.sh | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 2bd0c1eb70c5..4f55477ffe08 100755
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
+	if [ -n "$ss_token" ] && [ "$ss_token" = "$token" ]; then
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	else
+		mptcp_lib_pr_fail "expected $ss_token found $token"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
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
2.43.0

