Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35512455188
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776118; cv=none; b=ZfZ274QXkIeeMpjDjNpsrlMMA8sRRd1viKTkKXrmRUJz4zZVyBUuoc9v0r0S+g9kXnXUjDL6XXkAgeNjNjwQLHH47zpcvwu3fCGnsJywFZIUY9soHhQGIEyx+LwhqKl5Rtkm4X0Eb+9Dp9p14vqwzJnoDeSy5f7PIl1CvWopjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776118; c=relaxed/simple;
	bh=h6pongUbIpTfrxXwE3R6vyc4Q44phF/KtzAI9WjkQYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQE23kq74PKC8uv/GlVg4uTjLALjfjhuJo4seiepvFW30i7PykuIWEPxcqR46afafunoIaprCDg8HQFePL/Rfh0qFBhXNOnj5jGUeQue2UzcuYTbaypDE/CmRK6VX4u904ETpPjy+W7jbu6PRkpmYH7Q4EWXxMtOGPVEvXbg7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUhpPB1g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUhpPB1g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0970CC2BD01;
	Mon,  7 Sep 2026 10:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788776118;
	bh=h6pongUbIpTfrxXwE3R6vyc4Q44phF/KtzAI9WjkQYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qUhpPB1gi3udccbtCY7s+PfJd+mdqo7GnxzBmqHu99UZxUVdBpTT/ZKSZJGUNPEth
	 1IyRIAghevMSIpSa2lqvyCuLHpWgFfskxebefW92UcrP9Ucc8QEni3aLGy3p6o48uR
	 6IcCDwJ+tv/r6wyjjCV36FKB6Luezb938PoUeQ6PIb/VN5eYRaTYchkmVbQFZaN1Rq
	 4O3SkslqWMz/CxhxTDSiqA9Y+aulHB/+HNoPuV1uahC3KUFsn/YoniEqJqLOGWiBOD
	 5TWeZ2B2/aSG6EuaCFoLDwGelr3fNOWdTGJL+9Z3yxFvr3IPGCMPD+zLdVXaIbLpEI
	 uiFqzrWZokDXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EE3C79F99;
	Mon,  7 Sep 2026 10:15:17 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Mon, 07 Sep 2026 18:15:15 +0800
Subject: [PATCH mptcp-net v3 3/3] tcp: fix data-race in do_recvmmsg /
 mptcp_recvmsg
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mptcp-snd-una-race-v3-3-65ba0d5f0221@proton.me>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
In-Reply-To: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: geliang@kernel.org, matttbe@kernel.org, pabeni@redhat.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788776116; l=1223;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=EKQf0Zl10HLtBgRCYjNvbKPZJ84GNyeJhkTcDAK+6rU=;
 b=mJ4UAOOfb2uA4PanElByGKLauCM0iVqFPUpIm9ALSITQ1HJwjfS4+Omxa5AXkxyFkjanKilkj
 3PgA/YP/ms5CnZ01oM2E6B288JSPn5vLgv8pYeek8gfaruSpgwB93gc
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

KCSAN reported a data race between do_recvmmsg() and
mptcp_recvmsg() on sk->sk_err.

do_recvmmsg() calls sock_error() without holding the socket lock.
sock_error() atomically clears sk_err using xchg(), which can race
with the plain read in tcp_recv_should_stop(), even when its caller
holds the socket lock.

Use READ_ONCE() for the lockless read. No additional ordering is
required because the value is only used to decide whether receiving
should stop.

Fixes: 7a6a6cbc3e59 ("mptcp: recvmsg() can drain data from multiple subflows")
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 include/net/tcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 436495ff2271..c61d8678eafd 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3082,7 +3082,8 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 
 static inline int tcp_recv_should_stop(struct sock *sk)
 {
-	return sk->sk_err ||
+	/* sk_err can be cleared locklessly by sock_error(). */
+	return READ_ONCE(sk->sk_err) ||
 	       sk->sk_state == TCP_CLOSE ||
 	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
 	       signal_pending(current);

-- 
2.55.0


