Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957220;
	b=mwAiZMIx23tEZzPshhsJq6d47M56xAnepu/6fw9ezcJWdfNkoL4E/qTw55b6JSWC16V1
	 61m5LWSXv+Xj+96jxYqC9AMl8MVMwBd9Z//n+26Rw5mGMLsvR4r/jY40L9SUTsXiL/j2b
	 su0ex2GHqmqprLQiTYuiozbpC0GmmImCiwidYDOrkdG5+uOK4m3d1ED+p7fAw+qjyho51
	 OoemwxeI1Wpa9jWMY1K+lycBideLzlZ2tfoMZXzc+z2ftstjsMhvNJOrE0nyNr+XclOfV
	 V7YPplTKIrdS3lnqfLwAq6aUjxMQIZ9PX7ZvJCAMvsDnHoNrXnFXn7oEUo4bh0VVD5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957220;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pBjRRd4rZRfs86HYcxJrhsM6qV0fJXwEq+1E1vlj4w8=;
	b=QyFskRt16SQayRwWKX6u0ta6JakiZ5TcHGL/iI2G2ybG/78GV00fDO5J0SAAEkCE+/TZ
	 kzGkCspgOcCCT+CtlIHaFiMbA5o2XfYnhHayoHG/gn+Mg+M0kmfhTTvZNqHBVSKmuWoLR
	 j97KSfza8p9WtpJx4OMYAiJRfTTokjOi4vdyq70xiPkKDdpOMxLTAaJFs9M8aZCc7YWaa
	 Me4MnH4auSHPc2BE8VMVJhXEyt4ajP3VkxrLnlpwGjikXL9sC1t4P/o9bTn1+gfh/KdEJ
	 n0x0O8hmokkqx4TsbdjtogAsEs9SquphVJXjqKuk+utPEpeUqYqz3IYVncfO5oht+Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvtTxcID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391A606A31C;
	Tue, 17 Nov 2026 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvtTxcID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D4A1F000C4;
	Tue, 17 Nov 2026 23:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957219;
	bh=pBjRRd4rZRfs86HYcxJrhsM6qV0fJXwEq+1E1vlj4w8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BvtTxcIDgqbM+e+wTLbqmfx/0br6280fGM7+aBqHdsh2jjqvufgGMT2/gXulaInNz
	 7K5TlHa9bhth/pKRsz17PAT/gvvydzuUGRqDMT5NXDuSK6BjlfZnqrEpoqrjXa8RJg
	 JsQbqtYBDMrwqnmmtsp72LCTQjamujlrZfwcqAOSxk7nv7Xn14DMwimSAAxhRGbNU+
	 Sf6IxTKrfq5QwjzlQUGBpc+R2hPsKFUYaytPl8K608KpW3lygMB4WurMabntn5wUpE
	 rRXejQEdKLx5l/WA3oGnhqN7SuDOxLXLTCz9jkH+I4fy4Kh8KSCJoq3NPRNKdjJrsW
	 d0KKi4rVuSsIg==
Subject: Re: [PATCH v2 net-next 2/7] tcp: Don't collapse high density skb.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Tue, 17 Nov 2026 23:13:38 +0000
Message-ID: <179495721836.3136.13013697525497561871@kernel.org>
In-Reply-To: <20261116230555.2305867-3-kuniyu@google.com>
References: <20261116230555.2305867-3-kuniyu@google.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message describes a real regression, but the patch has
  no Fixes: tag.

--

tcp: Don't collapse high density skb.

This patch caps the scaling_ratio that tcp_collapse() uses at the highest
ratio a collapsed skb can reach (222 with 4K pages). It also changes the
bloat check so it only looks at the bytes left unread after start. With
this, tcp_collapse() no longer collapses an skb it just produced, and it
no longer collapses a dense GRO skb just because a few bytes of it were
read.

> If 4K-MSS GRO skb updates tp->scaling_ratio, it can be larger
> than 222.
>
> Then, even the newly collapsed skb could be detected as bloated
> by the next tcp_collapse().

[Severity: Low]

This describes a regression in tcp_collapse(). Should the patch carry a
Fixes: tag?

The re-collapse seems to have become possible with commit dfa2f0483360
("tcp: get rid of sysctl_tcp_adv_win_scale"). That commit made
tcp_win_from_space() use the per-socket scaling_ratio. For dense skbs,
tcp_measure_rcv_mss() can raise that ratio as high as 255:

net/ipv4/tcp_input.c:tcp_measure_rcv_mss() {
    ...
			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
    ...
			do_div(val, skb->truesize);
			tcp_sk(sk)->scaling_ratio = val ? val : 1;
    ...
}

Take a full collapsed skb (len 3776, truesize 4352) and a ratio of 230.
The old check in tcp_collapse() gives 4352 * 230 >> 8 = 3910, which is
greater than 3776. So the skb counts as bloated and is copied again on
every prune.

Before dfa2f0483360, the default adv_win_scale=1 reduced the check to
truesize / 2 > len. That gives 2176 > 3776, which is false, so collapsed
skbs never matched.

Documentation/process/maintainer-netdev.rst says the Fixes: tag is
required for fixes, regardless of the tree. Would adding the following
help with tracking?

  Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")

If the patch is meant only as a heuristic improvement for net-next, could
the commit message say that?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116230555.2305867-1-kuniyu%40google.com
