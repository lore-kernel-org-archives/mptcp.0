Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162973;
	b=5f18B5yKGTL+i8dBuMvF+KzrzUNTKoTo7Ze/cOL1znQ2oZwd3RQ8taGp2na0HgLw4enR
	 nRQHurtEnDGCwWOs7IXs62g7KyZBq8tWMOpwKPH1VFMSo8XhG7mzwRK3mhyJx1iz9fDcc
	 0LVYhJhI5MR1OtgYYpFrMh8DvJSWuhbmjd3/JoeZKg7of5yNvImK3Mvq/CFAesiG1zYyA
	 nOQt4Y0vqg+++KW04GTNKXM+TQQOrX0GD3h+d0a5ifW4AiO4ybfAmUuck9f7gV2ayAVAy
	 OgljEmGsCeJl82dIEv8hYa4mWnr8L0Z5NAft7A2j6dQx5a7VBx2jA4sHbK2kMV96Pnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162973;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3vWMBt0s/L/45awvvzkr2FzxSFl2LojKDoemfm2EGkY=;
	b=3sw0k2nVLeBrNtTgDV62AptE5WdXQEixKLILQXUe8BF9CttuXaZ4TYEYSAdifcOoR2N+
	 SxUw4+uXIB4bNR7rX5JqnbrNKg85VnA2yaDUmu3q9otWsFvL6D70jhs/B4EeN95vD0Ca9
	 mS9+6iwi4GbxRRodPFwIq66wRBi962ywsV/zOITcvirJHcI6uyH6LfwgGeGvkOjiM0Frc
	 Ph00RK064GyC93oJgiN1ln7Fe9CVkIPxebBnWW2/zx1yxE3W/+8A1mkOcn4uqRKv4I9X4
	 3Jce5XNG3dKTMX6MOfbjtJrtiJ+MVlnDUuwwiJHHUmu6dkgd76nNqoh9ILZaQbAwnDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxZ0cHOR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F0606A325;
	Fri, 20 Nov 2026 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxZ0cHOR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A211F000C4;
	Fri, 20 Nov 2026 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162973;
	bh=3vWMBt0s/L/45awvvzkr2FzxSFl2LojKDoemfm2EGkY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lxZ0cHOR8stjKP+qY7bf5HLLBB87DkJUoGITtpsHZLcoA1an6lssiwvt9sJFRa1oA
	 eaEaACc0NOTh6FRUcpFo7fj30gqeyx246AapVEDcBkRUSyRRuwCPjUtpdU+lVIwWgF
	 ZbenfpMyAnoONYY/WNISsMehroEet3P0wnkgnGr0Y3OWaskJtH3JWScW/niaFFDN9B
	 F/mFh6vEtSKMb/AXUeS8m7Lk6qo7p8PjVhNifLXTlj20qWfsAfedl8dbNetEdG/fSn
	 hn0JT/QZoDCn1X9lLY609Y2bBxdJbkyjnRwo/rsR8okLqCfURoPt3BNnuxpVVXhGde
	 gHISol2R1S4Wg==
Subject:
 Re: [PATCH net 1/3] tcp: saturate window-to-memory conversions at INT_MAX
From: netdev-bot+sashiko@kernel.org
To: llleigoing@outlook.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, edumazet@kernel.org,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org
Date: Fri, 20 Nov 2026 08:22:52 +0000
Message-ID: <179516297210.3136.8495911905614638988@kernel.org>
In-Reply-To: <20261117052200.1507847-2-llleigoing@outlook.com>
References: <20261117052200.1507847-2-llleigoing@outlook.com>
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

- [Low] The author and DCO sign-off names do not match.
- [Low] (Baseline decision: not a valid regression; kept only because
  requires_validation=true.) The concern: when scaling_ratio < 128 and…

--

tcp: saturate window-to-memory conversions at INT_MAX

This commit caps the u64 result of __tcp_space_from_win() at INT_MAX
before it is returned as an int. Without the cap, large results can wrap
when narrowed. That lets the TCP and MPTCP SO_RCVLOWAT handlers accept a
large low watermark without raising sk_rcvbuf.

> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: lllei <llleigoing@outlook.com>

[Severity: Low]
This isn't a bug, but the Signed-off-by name does not match the From
name. The author is "lei lei <llleigoing@outlook.com>" and the sign-off
is "lllei <llleigoing@outlook.com>". The email is the same but the names
differ, and checkpatch.pl reports this as FROM_SIGN_OFF_MISMATCH.

The other two patches in the series have the same mismatch:

  net: bound receive window predictions before narrowing
  mptcp: exclude MSG_PEEK from receive buffer autotuning

Could the series be resent with one consistent identity?

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5c9203aae8341..09827f1ae0a72 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1799,7 +1799,7 @@ static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
>  	u64 val = (u64)win << TCP_RMEM_TO_WIN_SCALE;
>  
>  	do_div(val, scaling_ratio);
> -	return val;
> +	return min_t(u64, val, INT_MAX);
>  }

[Severity: Low]
This probably isn't a regression, but one side effect of the saturation
is worth checking.

When scaling_ratio is below 128 and val is around tcp_rmem[2] >> 1, the
result saturates to INT_MAX. Then __tcp_win_from_space(ratio, INT_MAX)
is smaller than val, so sk_rcvbuf no longer covers sk_rcvlowat.

__tcp_set_rcvlowat() in net/ipv4/tcp.c still stores the full watermark
and raises window_clamp to val:

	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
	...
	space = tcp_space_from_win(sk, val);
	if (space > sk->sk_rcvbuf) {
		WRITE_ONCE(sk->sk_rcvbuf, space);

		if (tp->window_clamp && tp->window_clamp < val)
			WRITE_ONCE(tp->window_clamp, val);
	}

mptcp_set_rcvlowat() in net/mptcp/sockopt.c does the same for the msk
and each subflow.

This seems harmless:

  - __tcp_select_window() takes min_t(int, tp->window_clamp,
    allowed_space), so the larger clamp is never advertised.

  - For TCP, tcp_epollin_ready() falls back to tcp_rmem_pressure(), so a
    watermark the buffer cannot reach does not stall the reader.

  - The SOCK_RCVBUF_LOCK branch already accepts a watermark that the
    buffer cannot back.

  - Before this patch the budget was not raised at all.

mptcp_epollin_ready() has no rmem-pressure fallback. That limitation
predates this patch and can also be reached through the SOCK_RCVBUF_LOCK
path.

Should the commit message say that sk_rcvbuf can still be too small for
the requested SO_RCVLOWAT once it saturates?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117052200.1507847-1-llleigoing%40outlook.com
