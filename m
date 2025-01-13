Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F3199384
	for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758408; cv=none; b=G2SkUtAnGN+OjKGUOIYybT/7CclGu5qCGuheDNQLNgK3NEXEno782vKfQ6HMOv6UMiCCwRCqZihQGU2qTynbUxJ2QcTx7r/Gjpo+XaV16/Z+NnuQUrzHQrE36kljmEDBN20rY3Gy/Siji0sr9t6rjcIlXWbR/7LuS8mLeFzdOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758408; c=relaxed/simple;
	bh=SK4jnUxCfO5MkjZkyyhmQQ3cVcdvn0wTiQADlt7lpJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LU78vYHoFX920bRin0phCYzZWykGiNcJSX2fmfJesWIuVVDkQIAIO9MQhwRwYcSYA/tfuOtxhaoXiL62Z8lSRG5aqMb6x0FFg/vt+b/TW9amSB+TfZzsNFP0ODMtLzVFZD8mxVlbToew5CPAzqybYvZlBOtCxmlYXiytSc4tcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ccb78a16d18b11efa216b1d71e6e1362-20250113
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:97cfeb80-4387-4d39-8760-5ae6d7a00303,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:6
X-CID-INFO: VERSION:1.1.45,REQID:97cfeb80-4387-4d39-8760-5ae6d7a00303,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:6493067,CLOUDID:fd31e4db36654752146d2299e5270fdb,BulkI
	D:25011316530690BTK29T,BulkQuantity:0,Recheck:0,SF:17|19|24|38|45|66|78|81
	|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: ccb78a16d18b11efa216b1d71e6e1362-20250113
X-User: liucong2@kylinos.cn
Received: from liucong.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1690955869; Mon, 13 Jan 2025 16:53:03 +0800
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
Subject: [PATCH 3/3] selftests: mptcp: Clean up resources properly in main_loop
Date: Mon, 13 Jan 2025 16:52:28 +0800
Message-ID: <20250113085228.121778-4-liucong2@kylinos.cn>
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

Add proper cleanup of resources (file descriptors and address info)
in error paths to prevent resource leaks.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4d4ea4627daa..e82fde0411b2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1271,8 +1271,13 @@ int main_loop(void)
 	}
 
 	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
-	if (ret)
+	if (ret) {
+		close(fd);
+		if (cfg_input)
+			close(fd_in);
+		freeaddrinfo(peer);
 		return ret;
+	}
 
 	if (cfg_truncate > 0) {
 		xdisconnect(fd, peer->ai_addrlen);
@@ -1291,6 +1296,7 @@ int main_loop(void)
 		goto again;
 	} else {
 		close(fd);
+		freeaddrinfo(peer);
 	}
 
 	return 0;
-- 
2.43.0

