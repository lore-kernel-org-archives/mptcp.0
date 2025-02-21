Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39394207F
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116076; cv=none; b=T57ooo0UjlZnV8lMCbSZfFo7qi91F5/l++nAsJ8pkXDx7AmIWY56AWwtpZf+9o0ZpF6Xmsz5aQnDymDKEW+BANCHWLfujMV4Hp/CusGViXrpjYjtuxXZmSlEfAEsKxS5M3SVjagO6aO3VYlAn6Yz13flkqhb//WfH3JU/5jkYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116076; c=relaxed/simple;
	bh=rWV+kCs/Kx+gylAzlFBVvdgm4WET27tzpjquhKKzRt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJzbUwdneH+AtIs6fCvMeGentLa2nkQLIXrprkuyB3eQ0wdlRJCXKVPdbTpe3biQakb296uy96SLZRXafpPJaKKe9miQ8QjjBwcX5GHAS0lZCRjFNffb2WSwTNOreOr9odB/7I9KnLr3zpMCvGd0XVqpUAR8QurhYMEQnJx32Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 831aaa48f01511efa216b1d71e6e1362-20250221
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bcbbbb28-12df-47c9-b88d-3ecbdb0b50e9,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:bcbbbb28-12df-47c9-b88d-3ecbdb0b50e9,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:43af2a15fadb8be0e607520059410848,BulkI
	D:250221133427RSGZM2V4,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 831aaa48f01511efa216b1d71e6e1362-20250221
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 743705212; Fri, 21 Feb 2025 13:34:25 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [mptcp-next v3 0/2] selftests: mptcp: add tests for increasing
Date: Fri, 21 Feb 2025 13:34:17 +0800
Message-Id: <cover.1740115494.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches provide a method to verify the 'mptcp_diag_dump_one'
function, and the new tool 'mptcp_diag' can get the specific mptcp_info
through multi msks.

Gang Yan (2):
  selftests: mptcp: Add a tool to get specific msk_info
  selftests: mptcp: add a test for mptcp_diag_dump_one

 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh     |  27 ++
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 258 ++++++++++++++++++
 3 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_diag.c

-- 
2.25.1

