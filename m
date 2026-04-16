Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5E1A01BE
	for <mptcp@lists.linux.dev>; Thu, 16 Apr 2026 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342601; cv=none; b=FvqfoHAW3FO/l6jnNZ0wvl6Wq2V7uD2waNIHxP17xLM14vCeIEFVNvugWw+v5B1LlLibc9KUz3A20Sr4v/jJ2WKEnHhlHXMIt7pPBmFR3ktq+mfp06PGfnSVsBhloUhUczi4eXKyM934tqnniPj4Ajbx7yFgd4O/P1kHubPsjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342601; c=relaxed/simple;
	bh=+zlTdHKPR4zwmeO3zRr60i3n2Qdd7f51lJ5i17AyGfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JdZXRqqFO22DOgwc87guHiph3o5driEZ4/ve4DS7JWbRcK0xHCxqn0X0P1WE/O3ESqoT7FP0lMoRwvW9HvLCrkA3O/Qg5Qm+6uUgjn3cIffNrEWys/pXjTbUh8dOdvnasVnWLaQ2aj+hj6H4BYIPYYPLCW7QD8SmoIUVEy9AgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yexl6Cea; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yexl6Cea"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776342596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gBFMYzUnAlghwSVoKDrnLUvzM3pNpjw5oWiMd8HcvrY=;
	b=Yexl6CeaF8OVWYTCN0Hc4trVw9eHMUJJzlRJrsK7qwl1msJX3xbAgYZ0xcTOIQ0XqtmHNI
	QMVZ7N3TcvJUDHCKH4FzY3lUrt4VelG5qrDLDd5OmjsS0oJPBVwg5m/JJWRLga62GBnKa7
	gEUddGBWwtX9ijzpjQtjGGL8RI87cbM=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: update window_clamp on subflows when SO_RCVBUF is set
Date: Thu, 16 Apr 2026 20:29:43 +0800
Message-ID: <20260416122945.324166-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Add __mptcp_subflow_set_rcvbuf() helper that calls the subflow's
ops->set_rcvbuf to update window_clamp, in addition to writing
sk_rcvbuf. Use it in both mptcp_sol_socket_sync_intval() (setsockopt
path) and sync_socket_options() (new subflow creation path).

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

