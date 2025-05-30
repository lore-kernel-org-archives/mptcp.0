Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9D1A2396
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628641; cv=none; b=hxVoD0cIifRcFLg1uc78ICIKVTZ2phTM4u1m/xVFE0pB5+vwNsrMP+jX9kxZwGfBVJ1OHannDVIEyNthOKzK03DljxMopRTgaynEPrCgtXRQisWix0e2tgBS57W/LzGeoV64VIzWISSdp66mGyWFr9lbBlUXNG2rwjsIvw9Gyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628641; c=relaxed/simple;
	bh=9Zfdj00/kJOzSoNoPj/y7wPpoio7zTQ83fIGe4o8PMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YzBJ//wJH3VSLglydvdQH+XizayIyehFuQedB7U6OgIw3Wx/tKy0NmdoLjlqVoutUXfTzDKEGymZvsjLVKK5cFYzE3CX/KCwwnXjVX+v0xj9qpkQ+kzco7qItG3LiRMfJuUVrjoM26xmkrwdzRmGSfBbRBKDznuN7B+TX9NYamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T2v5w5zE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T2v5w5zE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Zz
	yJ/Kz22cI9tO/krLLF+mHfoWTVlQI+u3K2yCHH1Hg=; b=T2v5w5zEpe9RZdi9y1
	/gsQMChnPYZkUSdzCWMKFYSozpBOM2y7ihqlB5G21kSbRRC0Mxj5cKozwjUzrIh/
	CfunqXwT8XsrGTAeivr49R6qP4CIorMDkj1CQU6zuPXReDsuGKmF0AUJZoq4L5cg
	VDbxlIcdjDLLr/GZt/3zWj/kE=
Received: from gnu.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3Gt2A9DloRW+rFA--.14715S2;
	Sat, 31 May 2025 02:10:09 +0800 (CST)
From: moyuanhao3676@163.com
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	moyuanhao <moyuanhao3676@163.com>
Subject: [PATCH] mptcp: fix typos in comments
Date: Sat, 31 May 2025 02:10:04 +0800
Message-Id: <20250530181004.261417-1-moyuanhao3676@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3Gt2A9DloRW+rFA--.14715S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFykCw13uw15ZF1Dtw4Utwb_yoWftFb_u3
	WrtFZrKF4qgF1UCa18AwsxArn3trWDury8GF4ftF9rG34DJ3ZYvr1rGry5Zr48uw17Jay5
	Ww1Yk345twsI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRta0PUUUUUU==
X-CM-SenderInfo: 5pr13t5qkd0jqwxwqiywtou0bp/xtbBhQ1dfmg5ZDxR5AACsV

From: moyuanhao <moyuanhao3676@163.com>

This patch fixes the spelling mistakes in comments.
greter -> greater

Signed-off-by: moyuanhao <moyuanhao3676@163.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0749733ea897..18058688e483 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1376,7 +1376,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * - estimate the faster flow linger time
 	 * - use the above to estimate the amount of byte transferred
 	 *   by the faster flow
-	 * - check that the amount of queued data is greter than the above,
+	 * - check that the amount of queued data is greater than the above,
 	 *   otherwise do not use the picked, slower, subflow
 	 * We select the subflow with the shorter estimated time to flush
 	 * the queued mem, which basically ensure the above. We just need
-- 
2.34.1

