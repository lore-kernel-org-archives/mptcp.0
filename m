Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256448;
	b=Lv916Y/UniX5SZ572oSv897RkYm9DPIjGgLuzHWU2aQdJe4ZYVj2/8VwtLHm1dGilQqJ
	 w5B/ejNMtOY2IzL9cRqh0T/SZJKbsGsytw1Zb9UaoEGg0jzE1O++keOoM6Ali0tSfbk9J
	 TtK0+4mBfRiImoZyvbQTnqc+kl4baDcU9sVN6pei3X2XDUKcNvhsMBtgYrWfNNiYeQvLO
	 69KdfmTVopAPk0BSSI+/fl5GJFKqW6ekZsYIiOK36DmD9Iv2sXr243hwMpcb7Tcophd1B
	 aorOFas3BS1kpbiREhOaGJu7xleYzcwwAg8395cZrfaNNOuUaNpqnvd8MAff44J5DmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2GlGXK8Jx09r5DlDh1fvRSeVM6bM5SwhRHhB20F+iJo=;
	b=bu7ANuJ3Ii1I03/ngXGH564cVX+AoL1CesyzaYnl6EIEI3/9VqL+YMA/FcgauBQae7BH
	 RewGaGrrqRcS8GY4G/P3Uu7akyvnkfuD+MqVCAgOwnPQVY4SYSjB2uSD5cHrjTIg0MQTi
	 EBKuk78Nn0JSjS2MHG/ySknDpukC/20HFgKJMNNBFIspYkRq8ZkNqTLlOFewQwv/ID3YB
	 kABtYx0ZEv8odoZLBZR9ZQOn7qwwwOlwoYYeN32Aqsce/Xby3nZaHQtB0aIt96ixJCQan
	 yAHzqvL5VkdX0f2xJrpOqD7YjOhYOWXB1BWVZHMBT/wWJphqsvrvHiN2F9W83EfgL6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmhGSkcl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABE2606A32A
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmhGSkcl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1D21F000C6;
	Sat, 21 Nov 2026 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256448;
	bh=2GlGXK8Jx09r5DlDh1fvRSeVM6bM5SwhRHhB20F+iJo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gmhGSkcljDf3sa4rsoMjy+ra1By8Fi6aAZjRKJVlrk++GYb+ZBXUpOaqA8xhmrSir
	 T5v756BD1JVhURsTKt3KcxUEs6w/jPgG8U6wraV7PP9WJ2Ex2sMlgFc0QIRn5J1JHN
	 t5AvQ9j/J3B5iUxVtH2TNc3AqsVLVwAJY8yPAA6X9ootC+Te1CVHu1VTV2UvVlaC1l
	 Fd2+MD203Zjhzf0TQGdOtKd5IyobhH07DrF/6wB2MldaD1PAeRwF01sGhwvgB8K85M
	 TnfM5JvnMaXNSi7J6dHs2SvkWHmy2m3HZg3U9AFq/2oIoEwu6lxUWRYq9SW/h+wOBQ
	 Fe6fei2nqm0Yg==
Message-ID: <sashiko-outbox-226935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 20/62] mptcp: start close timeout on
 initial sf shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-20-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-20-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:20:47 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: incomplete state handling on initial sf shutdown in
  __mptcp_close_ssk()
--

commit 3ae1ff0e0bee2b5a84597ed1abd7a652f3bfc9b1
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: start close timeout on initial sf shutdown

This commit starts the MPTCP close timeout in __mptcp_close_ssk() when
only the shut-down initial subflow remains in the connection list and is
not yet in TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 835796fd4f771..d3a793e96c9cc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2823,6 +2823,14 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>  		} else {
>  			mptcp_start_tout_timer(sk);
>  		}
> +	} else if (list_is_singular(&msk->conn_list) && msk->first &&
> +		   mptcp_subflow_ctx(msk->first)->closing &&
> +		   !inet_csk(sk)->icsk_mtup.probe_timestamp &&
> +		   sk->sk_state !=3D TCP_CLOSE) {
> +		/* The initial subflow has only been shut down, and its later
> +		 * close will be ignored: start the close timeout now.
> +		 */
> +		mptcp_start_tout_timer(sk);
>  	}
>  }

[Severity: Medium]
Should this branch fold `mptcp_subflow_ctx(msk->first)->closing` into the
`inet_sk_state_load(msk->first) =3D=3D TCP_CLOSE` condition above so that
`SOCK_DEAD`, `sk->sk_state !=3D TCP_ESTABLISHED`, and `msk->in_accept_queue`
are handled the same way?

Because `mptcp_close_ssk()` already set `subflow->close_event_done =3D true`
when shutting down `msk->first`, the later transition of `msk->first` to
`TCP_CLOSE` will return early in `mptcp_close_ssk()` and never run the
`TCP_CLOSE` branch:

- If `sk->sk_state !=3D TCP_ESTABLISHED` (for instance `TCP_CLOSE_WAIT` or
  `TCP_FIN_WAIT1`), no new subflows can join, yet `sk` waits for the full
  close timeout instead of moving to `TCP_CLOSE` immediately.
- If `msk->in_accept_queue` is set when the peer sends a TCP FIN without
  `DATA_FIN`, starting the timer instead of closing `sk` leaves the
  unaccepted socket in `TCP_ESTABLISHED`; if the peer ACKs our FIN before
  `accept()`, `mptcp_stream_accept()` later sees `msk->first` in
  `TCP_CLOSE`, sets `newsk` to `TCP_CLOSE`, and calls `mptcp_close_ssk()`,
  which returns early without setting `SEND_SHUTDOWN`.
- If `sock_flag(sk, SOCK_DEAD)` is set, `__mptcp_close()` already set
  `icsk_mtup.probe_timestamp`, so `!inet_csk(sk)->icsk_mtup.probe_timestamp`
  is false and the orphan waits for the full close timeout instead of
  expiring immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D20
