Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128723890F6
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675388; cv=none; b=LmdfzXIPXMyCoVg37dQC38D6yjtq6dge9Y2/lhv00iz3uq6I2erUtB7G1e9cPjvQdG/4PeYHRomSNhYK8IfO9O56Vua8VfRsU4MnaLdWeXZHfjdlFR5FIlhKOhY1knZD1UHQdLdatIM4SBT20JeaOZusCacF43TB3fxdDIlzHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675388; c=relaxed/simple;
	bh=J8/Xu8VZCw30i5Hl7tr7sddsI2g3o2U2v5Y0o1JQ024=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y+0HJIFSpZZusdKWKMMS+lgKSUBunYZLPf/nxmmXp7r926PNNHF5Pbt7UZ/PXbl2lXYOcFjo0S7ZDeKNqBDfaEWhTw23ZR83r9pwi0czsmS0JSbOJ715LMlYd3GSUWo4ubpdydtMA7r2KozWOt85qtmEHZVZUDrIWzD08r3T80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hlIDRjzU; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hlIDRjzU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776675384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u0ezpVQ6vq1iA5Jf9/VSckwvb/RZvW8/eFNGdiuA0b8=;
	b=hlIDRjzUAN6WH/euv62lc44XYtRY7FRlFfaIQ/Wr82Rtnp9gZuQ5/1RGxyQLXXZTTaL5kc
	EzI7ZCYE4KcFXiGSvztr7LvRqWifSjX7z+J5w0wrcZ5aQ8bbD78RBQntXk0zg4MkJV28fW
	SCSlmtGIcSXxPlnFA+E5wk7wO1ogr8Y=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [RESEDN PATCH mptcp-net] mptcp: update window_clamp on subflows when SO_RCVBUF is set
Date: Mon, 20 Apr 2026 16:56:11 +0800
Message-ID: <20260420085613.4650-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Add __mptcp_subflow_set_rcvbuf() helper that calls the tcp_set_rcvbuf
to update window_clamp, in addition to writing sk_rcvbuf. Use it in
both mptcp_sol_socket_sync_intval() (setsockopt path) and
sync_socket_options() (new subflow creation path).

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/619
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Notes:

Hi Matt:

Note that I do not implement set_rcvbuf in mptcp_stream_ops for the                                                                                                                                                                                  
following reasons:

  - The callback receives the MPTCP meta socket as 'sk', but
    tcp_set_rcvbuf() must be called on each TCP subflow to update
    window_clamp. A callback implementation would need to iterate all
    subflows, duplicating the work already done by
    mptcp_sol_socket_sync_intval().

  - Subflows are grafted to the MPTCP socket via mptcp_sock_graft(),
    so ssk->sk_socket->ops points to mptcp_stream_ops, not
    inet_stream_ops. This means the TCP set_rcvbuf callback is not
    reachable through the subflow's ops either.

  - The existing subflow sync functions cover both the setsockopt path
    (mptcp_sol_socket_sync_intval) and new subflow creation path
    (sync_socket_options), making the proto_ops callback unnecessary.

WDYT？

The packetdrill tests is also implemented:
  -Link: https://github.com/multipath-tcp/packetdrill/pull/194

Thanks
Gang

---
 net/mptcp/sockopt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..abe63392826b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -67,6 +67,12 @@ static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval,
 	return 0;
 }
 
+static inline void __mptcp_subflow_set_rcvbuf(struct sock *ssk, int val)
+{
+	WRITE_ONCE(ssk->sk_rcvbuf, val);
+	tcp_set_rcvbuf(ssk, val);
+}
+
 static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -100,7 +106,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		case SO_RCVBUF:
 		case SO_RCVBUFFORCE:
 			ssk->sk_userlocks |= SOCK_RCVBUF_LOCK;
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 			break;
 		case SO_MARK:
 			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
@@ -1556,7 +1562,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
 		}
 		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 	}
 
 	if (sock_flag(sk, SOCK_LINGER)) {
-- 
2.43.0

