Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4D21CC68
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788931; cv=none; b=KLZUgvqswjZu2BGRvVGteaFCHcUJuq36zyxSOu6d3gDw2jUERxXaowBf/0aRr78k9eVFiH3It2IDS+pPxMdHepeHJuksGUBBE8/wsqeIfJHzog/2z64VMGP9IOngA7oHk8IFRjBn21Fv30s869jHVYaRz3AXI43mx2asSMZ2eMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788931; c=relaxed/simple;
	bh=BW6NpZnCo+0deIKmd/Q2TPg/qSM7niTHSnwsq72ec+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhaO7F/UFxUgilLBEZjMIB3CwcDYOPha8yqiJTUR6ic9gCVs2RlR9hwNj1Aj77QJiSMRD+teFzHNxjBUGsbBzEQR6v9XaSjCreZWrFHgj9pez4T84O67A3b7FT7smgp0QGYvedd88k8ehTfdV6Kxqs10DgJqL7pxm4i2+IFk79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5a9dd3061a9511f0a216b1d71e6e1362-20250416
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
X-CID-O-INFO: VERSION:1.1.45,REQID:97b30044-44f5-4e93-9f24-40b917075acc,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.45,REQID:97b30044-44f5-4e93-9f24-40b917075acc,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:6493067,CLOUDID:c33e7508e7e02f4f54bee89bbe387bd8,BulkI
	D:250416153523YMAXUWZ0,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5a9dd3061a9511f0a216b1d71e6e1362-20250416
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1276996382; Wed, 16 Apr 2025 15:35:22 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [mptcp-next 3/7] selftests: mptcp: refine the 'iovlen' handling logic
Date: Wed, 16 Apr 2025 15:34:58 +0800
Message-Id: <dee8dc73f766bc52c79d32a2dd22e9bc6ae436f0.1744788247.git.yangang@kylinos.cn>
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

In the original version, the handling logic for the 'iovlen' appeared
somewhat redundant. Therefore, 'iovlen++' is used to simpify this
portion of the code and improve its readaility.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 8a5b7745c58c..2bf13bce59a5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -91,10 +91,9 @@ static void send_query(int fd, struct inet_diag_req_v2 *r)
 		.iov_base = &req,
 		.iov_len = sizeof(req)
 	};
-	iov[iovlen] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
-	iov[iovlen + 1] = (struct iovec){ &proto, sizeof(proto)};
+	iov[iovlen++] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
+	iov[iovlen++] = (struct iovec){ &proto, sizeof(proto)};
 	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
-	iovlen += 2;
 	struct msghdr msg = {
 		.msg_name = &nladdr,
 		.msg_namelen = sizeof(nladdr),
-- 
2.25.1

