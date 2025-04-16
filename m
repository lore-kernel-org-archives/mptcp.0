Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99413AF2
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788934; cv=none; b=ld32ILngsD7vouHTbbveANpUForiopEkgSJ+eP/PG0l7LMWNj2Zv1V8gcHqv/RXSnt7ZDCDhpQDdTUeMfnD97P51qYsSjnJI4XYR+R3ZzeXKq2bregs6s/9jsrhWVbL53qh6LpWeK44LP782oS4M4o6F90955nkephoq5i7WqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788934; c=relaxed/simple;
	bh=y25mIN42cxf2iz8vIUfuIIiD3UCSrJgmCW16h4TnS5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPYfe419Ve8EfNZrJYmZVCF1PFWqBqLvKRCQQ+Sd7YlwWQg5Y5ex38CeJsPx1NQ/qu/f+hj/DUproyY2e8Ib2Hv0npQ7E8cukAfY/9RWhXemEyT3DEUt0JQwNqpo7qPt3TpjZLg03Swuar2+/u4Z1od8jit9Mueu7rc+xDbVPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c27649e1a9511f0a216b1d71e6e1362-20250416
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bd45a7c8-31f5-4484-a5ea-d448beea4d2a,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:bd45a7c8-31f5-4484-a5ea-d448beea4d2a,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:66970f387c3205f98d033d6618f706ef,BulkI
	D:2504161535279QFJQ3KQ,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 5c27649e1a9511f0a216b1d71e6e1362-20250416
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 700928771; Wed, 16 Apr 2025 15:35:24 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [mptcp-next 7/7] selftests: mptcp: add chk_sublfow in diag.sh
Date: Wed, 16 Apr 2025 15:35:02 +0800
Message-Id: <8801f99ac66349d26d91cc396c447db2f37dde85.1744788247.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744788247.git.yangang@kylinos.cn>
References: <cover.1744788247.git.yangang@kylinos.cn>
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

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 55 +++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e7a75341f0f3..20de007e44cd 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -225,6 +225,60 @@ chk_dump_one()
 	fi
 }
 
+get_endpoint_addr()
+{
+	echo $1 | cut -d ":" -f 1
+}
+
+get_endpoint_port()
+{
+	echo $1 | cut -d ":" -f 2
+}
+
+chk_dump_subflow()
+{
+	local inet_diag_token
+	local subflow_line
+	local remote_addr
+	local remote_port
+	local local_addr
+	local local_port
+	local ss_token
+	local msg
+
+	subflow_line=$(ss -tnN $ns | \
+		       grep -m1 -Eo '[0-9.]+:[0-9].+ +[0-9.]+:[0-9.]+')
+
+	if [ -n "$subflow_line" ]; then
+		read -r local_endpoint remote_endpoint <<< $subflow_line
+
+		local_addr=$(get_endpoint_addr $local_endpoint)
+		local_port=$(get_endpoint_port $local_endpoint)
+
+		remote_addr=$(get_endpoint_addr $remote_endpoint)
+		remote_port=$(get_endpoint_port $remote_endpoint)
+	fi
+
+	ss_token=$(ss -tniN $ns | \
+		   grep -m1 -Eo 'token:[^ ]+')
+
+	inet_diag_token=$(ip netns exec $ns ./mptcp_diag -s \
+			  "$local_addr $local_port $remote_addr $remote_port" | \
+			  grep -Eo 'token:[^ ]+')
+
+	msg="....chk dump_subflow"
+
+	mptcp_lib_print_title "$msg"
+	if [[ $ss_token == $inet_diag_token ]]; then
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	else
+		mptcp_lib_pr_fail "expected $ss_token but $inet_diag_token"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	fi
+}
+
 msk_info_get_value()
 {
 	local port="${1}"
@@ -316,6 +370,7 @@ chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
 chk_msk_cestab 2
 chk_dump_one
+chk_dump_subflow
 flush_pids
 
 chk_msk_inuse 0 "2->0"
-- 
2.25.1

