Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA91B394F
	for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350808; cv=none; b=li/KG9tNyRhsHCoMPBO3VayLSA5106Qf80Zee5EUybCD+PswAML6zFWhb1DxavdYrXjxD5iwzik4HWTc9F+hjSLgtGJkOopxCc/oCCNxWfGxddHPvvIz6e6w+GlWZXzy8OkEq6pWCOzieSGKrUNBpjSsQQ3rcw3yWDXR+juWcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350808; c=relaxed/simple;
	bh=KeK/kMSDQOIFkL7JydJre3gm05Y8NxwdyRVXl+OQhSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAmf3D4dW3aaLNJLggudm+sIplhNfEM0IQRPkVUQf9o0aIDVZ6EuJrfxTeh2pJiivgb6wJmBkEn9SNWhv1pFSwl5mmFIzDQf/RQSVx/CGCE9N7Dn7WOtVCB8hZX8ZgAiHfoP8lGybK8NLG9Mre515t48eReAyR25pNI3CxufFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2ab5198aa81e11f0a38c85956e01ac42-20251013
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:16385dab-e7da-45dd-814e-b93684432bb4,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-INFO: VERSION:1.3.6,REQID:16385dab-e7da-45dd-814e-b93684432bb4,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:d0adb16c9a0bc91fc5e6e0b667c673c1,BulkI
	D:2510131819583XEOOXWS,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ab5198aa81e11f0a38c85956e01ac42-20251013
X-User: yangang@kylinos.cn
Received: from yangang-thinkpad-t14-gen-1.. [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1076775273; Mon, 13 Oct 2025 18:19:56 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH] gen_initramfs.sh: use 'date -u' to get Timestamp
Date: Mon, 13 Oct 2025 18:19:45 +0800
Message-ID: <20251013101946.248420-1-yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There exists a compilation error in the latest version of
mptcp-upstream-virtme-docker:latest:
'''
	ERROR: Timestamp out of range for cpio format
	make[4]: *** [<KERNEL_SRC>/usr/Makefile:76:
'''

The reason is the output of 'date -d0' is 'Sat Jan 1 00:00:00 UTC 0000'.
After using 'date -u', the output is correct.

Reported-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 usr/gen_initramfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 7eba2fddf0ef..8eb43f76d521 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -222,7 +222,7 @@ while [ $# -gt 0 ]; do
 			shift
 			;;
 		"-d")	# date for file mtimes
-			timestamp="$(date -d"$1" +%s || :)"
+			timestamp="$(date -u +%s || :)"
 			if test -n "$timestamp"; then
 				timestamp="-t $timestamp"
 			fi
-- 
2.43.0

