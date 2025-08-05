Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A721CC62
	for <mptcp@lists.linux.dev>; Tue,  5 Aug 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385816; cv=none; b=KiEUUhzJoSKDbTJU6u4b0VB1Il2akAzGr+dHzBrMIMYgjSTEDt4EjPGCC450EYwpDT135OEopt9jtDVIg+5zZeJ8Yg+3fApJm6tNiF6qT42FUs0aTgGmHb77bIqitAI031TsSxeQE+0P9A3C4UhtbSDmYC+K7PAmz6///tXdAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385816; c=relaxed/simple;
	bh=wFTVLOP1f5YeZHxg11wfU5MXME7Bddu9Mvayd2ZX5y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBv5Eb7NvOir2GCfFlUqmHTASvhWGxqnu20svxxETA0h9syoj+cZVghXkwU+tjioJb6FBIAKtT0BjLQky4FzEUAOMb3FRMqGjq/6pJ50p3KBbbe+mp1AHXnaZOYO895DMlrU1ks+DJRlPpBc3AjCoOWaRvLXahkNOrXuIpK2jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d575a5dc71dd11f0b29709d653e92f7d-20250805
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b4b47148-22bd-43a5-b33e-15d1ebbd15ba,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:b4b47148-22bd-43a5-b33e-15d1ebbd15ba,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:7d816046bbbf0272cdc71af5cf159f15,BulkI
	D:250805172325RQLYHKYH,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: d575a5dc71dd11f0b29709d653e92f7d-20250805
X-User: yangang@kylinos.cn
Received: from yangang-thinkpad-t14-gen-1.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2070812367; Tue, 05 Aug 2025 17:23:23 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests: net: mptcp: add a check for dss fallback
Date: Tue,  5 Aug 2025 17:23:17 +0800
Message-ID: <20250805092317.103514-1-yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'Infinite Map' test triggers increments of the counter named
'MPTcpExtDssFallback'. This patch adds a verification step to
check the expected behavior of this MIB counter during the test
execution.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/571
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---

Notes:
    Also, 'dss_drop_after_data_fallback.pkt' can check it too, so I
    create a PR to the packetdrill repo:
    https://github.com/multipath-tcp/packetdrill/pull/164

 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3a..1872d646215f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -889,6 +889,23 @@ check_cestab()
 	fi
 }
 
+chk_dssfb_nr()
+{
+	local ns=$1
+	local expected=$2
+	local count
+
+	print_check "check dss fallback:"
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtDssFallback")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$expected" ]; then
+		fail_test "got $count dss fallback expected $expected"
+	else
+		print_ok
+	fi
+}
+
 cond_start_capture()
 {
 	local ns="$1"
@@ -3338,6 +3355,7 @@ fail_tests()
 			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1 \
 			join_corrupted_pkts="$(pedit_action_pkts)" \
 			chk_join_nr 0 0 0
+		chk_dssfb_nr $ns1 1
 		chk_fail_nr 1 -1 invert
 	fi
 
-- 
2.43.0

