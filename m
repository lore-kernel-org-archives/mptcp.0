Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6F233D7C
	for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758400; cv=none; b=LH1NAHWyNzz2e8EXs7yRYeGverp6d3QqQfxagKAwZZSwZfPsIJIc5EcVVWWDHDJNycIEb6RZ5cuXH9RWHJBhMCK+EQBLl0J3ZqbGV+Jn8/m3bwY2jUGsR2Ino+RNPOJhEe53SqsNPtBORozENrVbPNOjgynRxP9jnRZ4qSewbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758400; c=relaxed/simple;
	bh=RWEeHfG9BQkArbMKfBgICdcmFhIRztEGenKMQAmHmPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6EwlJ3QVvrq8n22WxWet+ezdjGnTIhIJk56GvUXyRM63rAIZlkMo1S55XPCbnnJJvNvTGPktIJcNf+UzMlpPbn9Bj9r2xbNa9eeD+XrDX29FKfBVWfs9dgWPanMtMKRctiZnhDlKRj/DK4YTSKcTqJJy41rHXu0ArTrhVsrf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c788b560d18b11efa216b1d71e6e1362-20250113
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:fc02180d-d521-490e-9457-56c73f22c610,IP:15,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-24
X-CID-INFO: VERSION:1.1.45,REQID:fc02180d-d521-490e-9457-56c73f22c610,IP:15,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-24
X-CID-META: VersionHash:6493067,CLOUDID:47ea4b778172c04fb58a60f0be9d93df,BulkI
	D:250113165257UAMC824I,BulkQuantity:1,Recheck:0,SF:17|19|24|38|45|66|78|81
	|82|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:43,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c788b560d18b11efa216b1d71e6e1362-20250113
X-User: liucong2@kylinos.cn
Received: from liucong.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1324680574; Mon, 13 Jan 2025 16:52:55 +0800
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
Subject: [PATCH 1/3] selftests: mptcp: Fix incorrect file descriptor check in main_loop
Date: Mon, 13 Jan 2025 16:52:26 +0800
Message-ID: <20250113085228.121778-2-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250113085228.121778-1-liucong2@kylinos.cn>
References: <20250113085228.121778-1-liucong2@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a bug where the code was checking the wrong file descriptor
when opening the input file. The code was checking 'fd' instead
of 'fd_in', which could lead to incorrect error handling.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4209b9569039..31f4c5618569 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1249,7 +1249,7 @@ int main_loop(void)
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
@@ -1272,7 +1272,7 @@ int main_loop(void)
 
 	if (cfg_input && !cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
-- 
2.43.0

