Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC892FF65E
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141411; cv=none; b=FgBC6WMLybxBU+UlygzwQsxkVSwxQQf+oLhoT/6t61SBSvHMXG+/limXGt6AeJB4UuGpcSji/Efc0aRpynqeNZIKa+mSWcPvb9U20HipMo1x7zaB32E6ljPu7g4x6jSvH7YsPAAa9JEQ+wTuogN7MBCSSH1NMplw4hLb+tyYmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141411; c=relaxed/simple;
	bh=dNi3wkL1Uy1LIbgT/X03+hnOA8OX7ScUoasl7qvDt/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGROmg6qeSFtwFbMv+licoOaSVWj5ADv6iLtYTPOass8hSTfGNttviV2vpPfYNT8jb5yUw8mFu6FeFalTScSxLgrceXUkHirmkw9T08pjOvOXBYY7wedGu6ETIWAAOfuH0gDa0IiC9I4kmlWed9socIPkVGxFwcyboul15uHApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 18664b2278bd11f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_TF, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2ffe7ca2-9576-4252-a38c-461707b1a788,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:2ffe7ca2-9576-4252-a38c-461707b1a788,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:66ccb5ff5e8987fca94b3a779d7e9de3,BulkI
	D:250814111642ZW1GSDM0,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 18664b2278bd11f0b29709d653e92f7d-20250814
X-User: yangang@kylinos.cn
Received: from yangang-thinkpad-t14-gen-1.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 928982074; Thu, 14 Aug 2025 11:16:40 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] selftests: check fallback mib counter
Date: Thu, 14 Aug 2025 11:16:22 +0800
Message-ID: <cover.1755139312.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches can add a verification step to check the expected behavior
of these MIB counters during the test execution.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/571

------
Changelog
  v2:
    - add a helper which can check all the fallback mib counters.
    - put the 'chk_fallback_nr' in 'chk_join_nr' like chk_join_tx_nr.

Gang Yan (2):
  selftests: net: mptcp: add checks for fallback counters
  selftests: net: mptcp: add fallback checks in chk_join_nr

 .../testing/selftests/net/mptcp/mptcp_join.sh | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

-- 
2.43.0

