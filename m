Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533997;
	b=hOzxRT7x+ExIGiLue9MgVnn0mEnP7V9wjkLGKDrnQfmYdOx+pZy0sna9Miu3/CKLOEXW
	 qvXkxj+/fAwwju677kCkAJY5sZuF2fdj71XdYqtlbdx5a868UY+t0os5wm+Y3lBKfjRvz
	 nl3iVPAvuv1mp031i5C024e34CwZmTFF7zgyBwhb8xVSk+a9EL/5G8tIpgn6GdYMz3p+C
	 2Z5pTADuZEvfnfyvyak8yIhNUUsUvY9SZscNvKcpfQk8hFLUQzF1fTw6to9E1CmlQSApY
	 pI8Uw64OdT7vTQN7xUIdgfTN+A7E81rWrTCzJ//Snxt0myrXVCxNFeiyG8HaUErY6ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533997;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JIt/okRqpopLzlEs/I2qtC6yb4cOIpN3Wy0aj1R3W/s=;
	b=aVLW3LdmqRAbUIEfNElarV/Wdwt3gQF0eH2dvw+JDkp06Ffd7E/4zi8ZFdklnoxlMJEn
	 8r7TwwEs1Zo8EeqbfJXX98jpPXPUW6J3Ip+sXT9g9jK/nW0und0ATrDFUXXsY/KlZ+nUN
	 lRi/TQclonbchkMDHjEDYmTfehGAKe3u+87ye8wUEQC/Z2sSe+KAyI+ULaDzm1jkB/IlZ
	 2HTKu6Xk3jE1GXBvzlM7nWCyXiSkAdSb1FvFaoFgTtQjtqYDxttNFP06tGUEp/Wg8qYmO
	 mHf0xKdQJGaQmXsUr8+TigmBbSqBA4KmUTSLpGf3BKqwD5QlOlvHbbOwpyOk2gQXtHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGzCkHPj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C0606A337
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGzCkHPj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92C31F000E0;
	Tue, 24 Nov 2026 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533997;
	bh=JIt/okRqpopLzlEs/I2qtC6yb4cOIpN3Wy0aj1R3W/s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jGzCkHPjzZWApHcwY15MSvVbUxxpR6HweClAYU2mbFE8HVnBC2U8gHVjpIkhlMroc
	 txTMnhRnQEGjODvm5sW7QFw4dZ9H8M8rO4uhXdYaDi2aV/oKxnjl7Jx6lLaQpnz4Ix
	 H7rgYlmERgL23z0YZM582lSz7tVLK1rr+Br0RdZMilLCkLAs5Rzrv8JFkNxyBMxNoi
	 KkoRL9Drc+9oMjRhEwnj/l8SCq5bGeI8rO+pf8VNHx1RoBAoyXYmRdgjartgztTaca
	 Hu5iGRJo9YnTqMrTG8uMHhAumv/1GLQ5NUlh3SBUkrpjJY07z/mlNmfGnPzqHankUK
	 qPLyO2jh/I4sg==
Subject: Re: [PATCH mptcp-net v3 4/4] mptcp: add mptcp_inq() for SIOCINQ
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 15:26:36 +0000
Message-ID: <179553399645.3133.8807553916762589643@kernel.org>
In-Reply-To: <bb8866b3e5b103dab9102d27d13cf1c91556f707.1795396910.git.tanggeliang@kylinos.cn>
References: <bb8866b3e5b103dab9102d27d13cf1c91556f707.1795396910.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes one user-visible change to
  SIOCINQ/FIONREAD: N is reported instead of N+1 when N bytes are unread…

--

mptcp: add mptcp_inq() for SIOCINQ

This adds mptcp_inq(), which computes the readable bytes at the MPTCP level
using mptcp_data_avail(). SIOCINQ switches from mptcp_inq_hint() to
mptcp_inq(), so FIONREAD no longer includes the FIN byte.

> Unlike mptcp_inq_hint(), mptcp_inq() does not include the FIN byte. Switch
> SIOCINQ from mptcp_inq_hint() to mptcp_inq() so that FIONREAD reports N
> (not N+1) when N bytes are unread with DATA_FIN pending, matching TCP's
> tcp_ioctl() which subtracts the FIN byte.

[Severity: Medium]
Is this description complete? Switching mptcp_ioctl(SIOCINQ) to mptcp_inq()
in net/mptcp/protocol.c changes FIONREAD in more cases than the pending
DATA_FIN case described here.

Before this series, an empty receive queue in TCP_CLOSE or with RCV_SHUTDOWN
set hit this exit in mptcp_inq_hint():

	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
		return 1;

So FIONREAD returned 1, and mptcp_inq() now returns 0. The cases affected
are:

  - EOF after a processed DATA_FIN (mptcp_check_data_fin() sets
    RCV_SHUTDOWN)
  - a never connected socket (mptcp_ioctl() only rejects TCP_LISTEN)
  - a socket that moved to TCP_CLOSE after a reset
  - a local shutdown(SHUT_RD)

After the previous patch in this series ("mptcp: fix TFO SIOCINQ overflow
in mptcp_inq_hint"), mptcp_inq_hint() adds the extra byte based on socket
state, whether or not a FIN was received:

	if (((sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)) &&
	     !READ_ONCE(msk->rcv_fastclose)) ||
	    (READ_ONCE(msk->rcv_data_fin) && mptcp_data_fin(msk, NULL)))
		hint_val += 1;

With N bytes queued after a local shutdown(SHUT_RD), or in a TCP_CLOSE
state that is not a fastclose with no FIN received, SIOCINQ reported N+1
after that patch. This patch brings it back to N. TCP_CM_INQ still uses
mptcp_inq_hint() and keeps the +1.

Since that +1 is not limited to a received DATA_FIN, is "mptcp_inq_hint()
... include the FIN byte" accurate?

The new values match what tcp_inq() returns, so the code change itself looks
fine. This patch carries a Fixes: tag, so it is likely to be backported to
stable. Could the commit message say that FIONREAD now returns 0 instead of
1 at EOF and on unconnected sockets? Could it also say that this patch needs
to go with its parent to undo the N+1 that the parent introduced for
SIOCINQ?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795396910.git.tanggeliang%40kylinos.cn
