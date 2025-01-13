Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC54F231A46
	for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758399; cv=none; b=KwduY/LJCbK+PNHJThGV48Ea1NH76Fc3G+L6U05Rp8tRVsZOq/+5wKAJaAER/wZsydMR4/Tn6+vmwRuPGi3hp+zbJ0V+fIcRPCiIEC32wZJzHLP+dhuAi1eS5coclOKKZMfgnDC/gn5+mXMK3+xlJt07Ih4mRNly59T3Vujpx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758399; c=relaxed/simple;
	bh=SY04kThu61ui/keTH3r+cx97vA8etjaV16X/D56CEww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkokAljWmt1dJ1+DIRGPQKZVUnuxnijGdHOlP9cqABjjz/sh/LEFduBZ8yhJ/k6Th48yEoIX8f4pusrXcBIbBsmjSnpp0mhLkTBWwoTwrCsKdze8jIls4JT0EtLkLJ80ViI9ZSeGTd3JT2J+RTqu5P5mj0b/5bfQAOYr7KGlosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c72ba0dcd18b11efa216b1d71e6e1362-20250113
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:38c9a0d8-55cf-4d05-8f86-175a4902945c,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:6
X-CID-INFO: VERSION:1.1.45,REQID:38c9a0d8-55cf-4d05-8f86-175a4902945c,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:6493067,CLOUDID:e65afa1dbd25e174982b20796cf13f7d,BulkI
	D:250113165257UAMC824I,BulkQuantity:0,Recheck:0,SF:17|19|24|38|45|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c72ba0dcd18b11efa216b1d71e6e1362-20250113
X-User: liucong2@kylinos.cn
Received: from liucong.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1571801971; Mon, 13 Jan 2025 16:52:54 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"'David S . Miller'" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Cong Liu <liucong2@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] selftests: mptcp: Fix various issues in main_loop
Date: Mon, 13 Jan 2025 16:52:25 +0800
Message-ID: <20250113085228.121778-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several issues in the mptcp connect test's main_loop function.

 - Fix a bug where the wrong file descriptor was being checked for errors
 - Fix the input file descriptor lifecycle in the reconnection loop to
   prevent use of invalid fd
 - Add proper resource cleanup in error paths

Cong Liu (3):
  selftests: mptcp: Fix incorrect file descriptor check in main_loop
  selftests: mptcp: Fix input fd lifecycle in reconnection loop
  selftests: mptcp: Clean up resources properly in main_loop

 .../selftests/net/mptcp/mptcp_connect.c        | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)


base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
-- 
2.43.0

