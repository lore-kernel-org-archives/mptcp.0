Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616B1158538
	for <mptcp@lists.linux.dev>; Mon,  7 Apr 2025 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743993464; cv=none; b=DXfolZyxcUsh4D97l67D/RooOrE7kuEXCWzjK6T5C+EWAPc6/AbwgT7IHzAYSk3F+s7QZ6jm6/LIcZJ44FTj2DzvNCFDqNAtAejGGoMu29jwjjdEQdoJ3/AivhhSjpFQdo5lEjPDpVaDlg1M69nL4oQ89R3h2Tp84Bguk9CQwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743993464; c=relaxed/simple;
	bh=wJKa/9BzLLeHujR6gJG9XZNa7/BGqitdbK4mbvswrCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nUaPVOlpXtx/LdssfiSptDDBk3TMN9qd/WErZs+lskdMrWoeWWGfKww2dbTQ9imxo1lHy6ITrHnUkRXhn1uxKX1WiTg/WRekGjINoSsn6gJr9YCmqjLhbmBc0H7CYKnCaxEPTpbuLCqs+DFPL4qcQutct1GDAr7PDXBM2mMSOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 417e4c90135911f0a216b1d71e6e1362-20250407
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2a147f09-2b54-4bca-bed3-41ce0176657f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:2a147f09-2b54-4bca-bed3-41ce0176657f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:90c14860b61fc1a441669c8000d1ac10,BulkI
	D:2504051730119Z4D7OL6,BulkQuantity:6,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 417e4c90135911f0a216b1d71e6e1362-20250407
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 683428084; Mon, 07 Apr 2025 10:37:32 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 0/2] BCC: python: support fmod_ret
Date: Mon,  7 Apr 2025 10:37:20 +0800
Message-Id: <cover.1743988616.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support fmod_ret, and add a useful tool for mptcp, also
the interface can be verified with this function.

Gang Yan (2):
  BCC: Python: Support 'fmod_ret' method for eBPF
  BCC: python: add a useful tool for mptcp

 src/python/bcc/__init__.py | 43 ++++++++++++++++++++
 tools/mptcpboost.py        | 82 ++++++++++++++++++++++++++++++++++++++
 tools/mptcpboost.txt       | 22 ++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 tools/mptcpboost.py
 create mode 100644 tools/mptcpboost.txt

-- 
2.25.1

