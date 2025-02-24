Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5A1C8614
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387783; cv=none; b=TKQI2VdoNQ5DXZF2yAineMvw8INbpc9fknyNuzF3X9tsVDLtVb8GfeIjCeSbr2LeZUW7BDepCSHj+mg01bcTq8kPJZUA4IwtnfwruivuFBnsRElZPZ3+e+V05wW8M7lHwyb1o1qHJqgiWTapmrt/ODtrUBCX9DJlrZecmjOUfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387783; c=relaxed/simple;
	bh=i5atWi8nLP+bdruv9+CH/3x2exHmnABwYfySFGRFqH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N2ru1KSxdmxUxpxj8X0Uae4ZhHRpOP1e3SKwnvs+Un522xvvuJewWDM3tao0UPnLLfCiL2t8xKAaSN4zrUDfXJi88CJSSaW2MiwcTewc4iJQJ1ebyidcIzHOKoroRz0vhRW03Dkg6VUIKPpvvN4DQKq1Ucgai0hdgOspBL1jdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1bdedcc0f28e11efa216b1d71e6e1362-20250224
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:289e130f-8960-4430-982e-4df0d27f1b39,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:289e130f-8960-4430-982e-4df0d27f1b39,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:86973af162b7dcd4c43dd60a6160750d,BulkI
	D:250224170246ISMTNAU9,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN
X-UUID: 1bdedcc0f28e11efa216b1d71e6e1362-20250224
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 659795290; Mon, 24 Feb 2025 17:02:43 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [mptcp-next v4 0/2] selftests: mptcp: add tests for increasing
Date: Mon, 24 Feb 2025 17:02:33 +0800
Message-Id: <cover.1740385876.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These patches provide a method to verify the 'mptcp_diag_dump_one'
function, and the new tool 'mptcp_diag' can get the specific mptcp_info
through multi msks.

Hi Matt:

Thank you for your suggestions regarding these patches, they have been
very useful to me. Sorry for the misunderstanding caused by my misuse of
the 'CLOSE' keyword. Currently, I have used the 'Link' instead. These 
patches are designed for 'mptcp_dump_one'.

There may need another test case for 'subflow_get_info_size'. I will 
continue to work on resolving this issue.

Best wishes!

Gang Yan (2):
  selftests: mptcp: Add a tool to get specific msk_info
  selftests: mptcp: add a test for mptcp_diag_dump_one

 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh     |  27 ++
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 271 ++++++++++++++++++
 3 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_diag.c

-- 
2.43.0

