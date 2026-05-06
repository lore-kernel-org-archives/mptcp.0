Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D93EBF36
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060613; cv=none; b=Pf9DhH37WbmE/9Qqi4OXtwYNtk4xvKx5IjGQF8TOB2FYbovTBaK3P06WnuPLuWdB3nhZA7VSOWvRYGFCTveCd+E0qzbuttpub6jggbhAk8GlQrhXJ1pdYKibhJJ55tqLhgVvRvikTxSzv9AaNs12eXN5dFWc/vTxdPbCSeQ4n2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060613; c=relaxed/simple;
	bh=JFmPt6gxAeFfyCVE/OjfuXZzCM0gGTT87J0l139SDmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O3TAMbI7bAcRUImNsSsjYwMTxzZ+XB0172DX0YJRT+wQi7mFkSYKPJsWdEZingmmxpVx/k4DReOxYPq39g0jMeV8okD/RbU2LcLgGSCQ8mr76tnLRahMARFGjl1h9WW6O5qcFERNqELZfrCxdL7UrMAnJXNpoDJL/K4Vhs0n8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oxoDbEJt; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oxoDbEJt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778060609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FN23yyCWNheCgqbUAJFZhYIRPNzsokrX9kl+ShPDAZ8=;
	b=oxoDbEJtjjYMwcnqQX7jgFfFZplJ2cc4KPqP3T3p2M+xHl9If8ILORK0grXeAxpsi2cTMW
	n1JJ2xQrJqH1UFJUGXUMj64traDWkR20szj5jwb2XG6C0FpPxCF4D4nLR0hRO651mWNBkM
	Upsj9I2JZer7hv1wMylXA8JJ3hwaiWA=
From: Gang Yan <gang.yan@linux.dev>
Date: Wed, 06 May 2026 17:43:04 +0800
Subject: [PATCH mptcp-net v3] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-window_clamp-v3-1-ade82fbbebb2@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIACcN+2kC/x3MQQqAIBBA0avErBPESKyrRITpWANpolFBdPek5
 Vv8/0DGRJihrx5IeFKmPRQ0dQVm1WFBRrYYBBeSt1yyi4Ldr8ls2kemtLLCza5R2EFJYkJH978
 bwMfDRBbwgPF9PyoudXJpAAAA
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
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
Changelog:
v3:
  - Remove the special symbols.
v2:
  - Optimize the commit msg.
  Link: https://patchwork.kernel.org/project/mptcp/patch/20260416122945.324166-1-gang.yan@linux.dev/
v1:
  Link: https://patchwork.kernel.org/project/mptcp/patch/20260416122945.324166-1-gang.yan@linux.dev/
---
 net/mptcp/sockopt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1cf608e7357b..1544e3563852 100644
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
@@ -1560,7 +1566,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
 		}
 		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 	}
 
 	if (sock_flag(sk, SOCK_LINGER)) {

---
base-commit: aa15c271d79edde595fb6f4eedb52fbc16325a83
change-id: 20260506-window_clamp-8a8d2fbf38e9

Best regards,
-- 
Gang Yan <yangang@kylinos.cn>

