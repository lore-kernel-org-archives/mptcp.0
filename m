Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030F1C8621
	for <mptcp@lists.linux.dev>; Fri, 25 Apr 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561940; cv=none; b=c9UCAPHcHj9sppSBAx3J0fhTf22sD1vM+LCL64gCT5+EUG/FgY0BRLHk7mOAeDlfGUBFdS7r58+1f/OdaK5HzxzPTuIQ7NrkvW7BBD9/kj4VEngrRKB6fCzHaCli8MYiKzbuPAAdYbvIy8D5LqgW93etaCKTb9tB3sXt0COFGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561940; c=relaxed/simple;
	bh=YNSODEBwJkYulk4YJfFMIscKMRsrLTZ3Fwd/9xU61VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CpFk5H29tk9hRwcq3NExPQlj4GQgJz04sxQRBVE9mBtzZ7o0J35TdgBhBbdUMh3YyZ/b41jZy5GpkyReIxsQjHMXiUxPN86iUUL6Z4b/Dan8NhdNjMFFT0Z4VA7N8EQrWYdQAygvo2gFYgKgzPeUCQtyuFNqxI+++Gw75Oh+1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 26773b26219d11f0a216b1d71e6e1362-20250425
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
X-CID-O-INFO: VERSION:1.1.45,REQID:c2095a8e-4f90-4031-a791-04ac2617f67c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:c2095a8e-4f90-4031-a791-04ac2617f67c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:34d0cea812df8467db54cc0f804f0410,BulkI
	D:250425141850553PQO15,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI
X-UUID: 26773b26219d11f0a216b1d71e6e1362-20250425
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1287295675; Fri, 25 Apr 2025 14:18:48 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/5] Add 'dump_subflow' test in selftests
Date: Fri, 25 Apr 2025 14:18:38 +0800
Message-Id: <cover.1745395366.git.yangang@kylinos.cn>
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
  v3:
    - Set idaig_ext when 'r' is declared.
    - Declare iovlen to 0, and adjust the increment logic.
    - Squash patch 3 into patch 4.
    - Rename 'subflow_addr' to 'subflow_addrs'
    - Remove the comment and declare [ad]ddr on the same line.
    - Set id.idiag_cookie[0/1] when r is declared.
    - Remove the 'id.idiag_if = 0' because the default value is 0.
    - Squash patch 6 into patch 5.
    - Add the example of output in commit message.
    - Adjust the input of 'mptcp_diag -s' to "saddr:sport daddr:dport"
      to save a few lines in diag.sh
    - In diag.sh, use "mptcp_diag -s '$subflow_line'" instead of
      the old version, and call 'ss' only once to ensure the safety.
    - Fix some error/check/warning problems in CI.
    - Put the link of issue into the commit message of patch 5.

Gang Yan (5):
  selftests: mptcp: add struct params in mptcp_diag
  selftests: mptcp: refactor send_query parameters for code clarity
  selftests: mptcp: refactor NLMSG handling with 'proto'
  selftests: mptcp: add helpers to get subflow_info
  selftests: mptcp: add chk_sublfow in diag.sh

 tools/testing/selftests/net/mptcp/diag.sh     |  33 +++
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 228 +++++++++++++++---
 2 files changed, 229 insertions(+), 32 deletions(-)

-- 
2.43.0

