Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6017736
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323077; cv=none; b=EL4Jd54L7WqzFx+qOOi+TW5O+yutInBdQFQJjeJAuEqjKiHpMqdUjksjs8fJYnthfcINc0P3qEqQK5UWBJSx7vIhghhZse4Tyhbmft88FRoEorR/KKN2iL0HlGkCjhQ9qQBngHBHI8OkNoYZbh+3YVA1eNTxGrAQ7Qnt1O87mTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323077; c=relaxed/simple;
	bh=mUiwlR1aFYd+K9jyLd0rAV6PVyNkru/2/pzOGIelgKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VATKYwtpbNFBUrKmaiVotm0ITwDz/CPQk5ur1lZrsqpPnROYHhXly5KC95OP1xxwSSju2unPQYEATEOwfxvvszyrsIc7rptq2dqSFFpBIgjW4+l7KH5Nf8iNDRZtqpBaQAaIG7UPCZbjXDsGh1ion0iZWSPLN/Hzguf4ppQA980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xE1XH0wM; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xE1XH0wM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764323072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i49uS/Y7u/q7ApZEs3CHRK1MTEgIKON6N15JMBmw/b8=;
	b=xE1XH0wMCdfGDZSq72zzQXYZgG2RFC3ZMHVWMJpBTM/J7bAjlFAPZs5y2b3kDPSKlYKFAY
	k3xeApr4+xa0i3+wZjIVXKqU6oYq6t224JmEnCouLELCwCw0iqMfr1xtFeQGa/2MolHnn5
	ch5qqoOwU10H24YTopGkpwwZslK6Rf8=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: sync the msk->sndbuf at accept() time
Date: Fri, 28 Nov 2025 17:44:17 +0800
Message-ID: <20251128094417.14463-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

After an MPTCP connection is established, the sk_sndbuf of client's msk
can be updated through 'subflow_finish_connect'. However, the newly
accepted msk on the server side has a small sk_sndbuf than
msk->first->sk_sndbuf:

'''
MPTCP: msk:00000000e55b09db, msk->sndbuf:20480, msk->first->sndbuf:2626560
'''

This means that when the server immediately sends MSG_DONTWAIT data to
the client after the connection is established, it is more likely to
encounter EAGAIN.

This patch synchronizes the sk_sndbuf by triggering its update during accept.

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e484c6391b48..72d263148b21 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4213,6 +4213,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
 
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
-- 
2.43.0

