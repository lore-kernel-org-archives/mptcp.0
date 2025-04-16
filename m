Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37757233151
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794006; cv=none; b=W19RtpRnhls7Dp2IDRjcfEJN6GdVIB45XVjU/0uyD5+607bdY+eIhomxZL9MnzuRUjIB6+cV8UUv2xVKMfxaiF7sK7hfcRrC8337cMzOHTQBD9VT2BQGEfMbTdGgqIUJRKpE6tGVKvpKvV8N5ia/9MU2lNDQRECFqkVBy6ZsE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794006; c=relaxed/simple;
	bh=4pvzy4UAQEEpD1mWH/652MMY3+vIL+eZpTQcstbEoKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qlFMTBKgKS1bTBZ1R/Wc/WgCUI97WvmT5UcBl0wzPBxaw6MnIFU0Vz2Ois2tSD+PNMbpUuUZrGkZh80zHCMQj5M4Ntm8ZOkUQfZ/RavEXqqg4Y6EIO88H7LyZlQzrAR3zKc+vWT0hk91UPqhXJcePWjtatH8SfyQFbFi6mq8xv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 29dd6f2c1aa111f0a216b1d71e6e1362-20250416
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b1cdf874-7c0e-4c07-907a-e47d693c32a0,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:b1cdf874-7c0e-4c07-907a-e47d693c32a0,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:dc41d595bb1b1587bde087583e9e5c3a,BulkI
	D:250416165955LBS6I3PW,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI
X-UUID: 29dd6f2c1aa111f0a216b1d71e6e1362-20250416
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1591045042; Wed, 16 Apr 2025 16:59:54 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [mptcp-next v2 0/7] Add 'dump_subflow' test in selftests
Date: Wed, 16 Apr 2025 16:59:42 +0800
Message-Id: <cover.1744793332.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'subflow_get_info_size' is called only in 'inet_sk_attr_size', and
the only calltrace is that 'tcp_diag_dump_one'->'inet_diag_dump_one_icsk'
->'inet_sk_attr_size'.

So It's necessary to add 'get_subflow_info' in mptcp_diag.c to cover this
function. Given a specific TCP connection, it is possible to judge if
it is a MPTCP subflow by 'INET_ULP_INFO_MPTCP' and print 'subflow_info'.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/524

------
Changelog
  v2:
    - Fix the CI compiling error.


Gang Yan (7):
  selftests: mptcp: add struct params in mptcp_diag
  selftests: mptcp: refactor send_query parameters for code clarity
  selftests: mptcp: refine the 'iovlen' handling logic
  selftests: mptcp: refactor NLMSG handling with 'proto'
  selftests: mptcp: add a helper to get subflow_info
  selftests: mptcp: add a helper to print subflow_info
  selftests: mptcp: add chk_sublfow in diag.sh

 tools/testing/selftests/net/mptcp/diag.sh     |  55 +++++
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 223 +++++++++++++++---
 2 files changed, 248 insertions(+), 30 deletions(-)

-- 
2.25.1

