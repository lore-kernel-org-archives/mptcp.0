Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A1272E51
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764227070; cv=none; b=Da6+pEkQy5v+B9lQ6/Uzr6eyOE7tWkrLGIRE8gsWnMAD2gzEG7YDHb2crbyybgxkvQaPzUMOnI5z6w8ZQc5CWwTW0N61deDMNrHdo4lcUsMYQXtjnKx20hbo7Q/0r6GFdEv5H/VmXlv2frY1ylNOkBoC0H4zl68xWj4vIkoZW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764227070; c=relaxed/simple;
	bh=6v/AMVld9ywskk17Wx85gHsWM25Xe0TG/R8zkkL9Rr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/BY0xv2qcQgQrrbts7xYyUecVxvNzUX7BsTL8zFviE3/cpWpSuPJujgCap74czyUjYqnUJ+xiIx41DrHnvOXtrWuAVWTU6bIaMhBonNtD2q7ijbbzw2hpOUknRHYeRju9TLgybVaXydMewohWKN+hmhmT2Zyjq/xTHAQdu84MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RyfjZ2AZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RyfjZ2AZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764227063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oCGwGe5GVsriUZ+aQ0WB0mRyzvPtMuHdKyXnWiak9bg=;
	b=RyfjZ2AZOX5pZTvw8x7DVwzJbuN6IuywJuTrS29x3FNjhHJLFhrSXQ8MLvmRrJrvYh0Jhl
	vAsXV99+Birz8Kuy1rJjLtCH/Mhgg12dUA6YUaHVFb3xkazve0DyfMuo7ape27UzXNx90N
	jvbVq6nocGEOD7vNGjBaU3vjOgT8WSA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: sync the msk->sndbuf at accept() time
Date: Thu, 27 Nov 2025 15:04:17 +0800
Message-ID: <20251127070417.53513-1-gang.yan@linux.dev>
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
Notes:

Hi, Matt,

I'm not sure the commit in 'Fix' tag is correct.

The 3a236aef280e (mptcp: refactor passive socket initialization) removes the
'propagate_sndbuf' in '__mptcp_finish_join' and 'mptcp_stream_accept'.
And the 8005184fd1ca adds it in '__mptcp_finish_join' but not in accept
time. So I think there exists a miss in 8005184fd1ca.

Can you help me to check the 'Fix' tag?

Thanks,
Gang
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e484c6391b48..33610d638385 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4213,6 +4213,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
+		__mptcp_propagate_sndbuf(newsk, subflow->tcp_sock);
 
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
-- 
2.43.0

