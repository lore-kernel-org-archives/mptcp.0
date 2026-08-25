Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD89278161
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645696; cv=none; b=RvsPWjXvzKao5yFS31q5gjhOGXozp6NnTzqjR8bk/PL1gJu+dCtv7fc55eXVr1RyMuIzlLt6Q70qbDzfxapWr+DeoRNz0h6TtuptYimR1/zB28paqmgf9XLEweuIKxKGIzFK5/L+X+zd7bQCd163lqRoBln0c+Wp0t7+HQpZK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645696; c=relaxed/simple;
	bh=BGPHIQuFmdYOmQCCwwf6dbGSwkYf25fsOf7v2tHr8vA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z6dIoNuNac8D0dx9fu9I/XhDipzirRxrsT45NcWu946T/3olkk/lTIUYOA8+e06eN61KUY5Ow6caLmSqON9jevRNDnw8WbVnVk0o+oY2nXQBUkOiHT+uchRqx0qwk0IR3gtRoj/VYvoaHwKnZ1U8yRdAIxjMgOWy7bzVt/qHa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEinoapV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEinoapV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA301F000E9;
	Tue, 25 Aug 2026 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787645695;
	bh=ZOG50Gz7AJSGK0+cdRE+riQfAC5MiCwCJQ7q1z62hZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dEinoapV8h6MzVMisVHrLdbHKi23UZrAbwzV0Oa2bdyi8K2JwIaVRb+0xBbFqZmkI
	 DX9Ibzh2JC5exd0wBgK+hyp3Mm1FxijpbqQEXvuqdPlFfTm1Wz6j84JPCzm2Icf2jP
	 anVx1PvDYheICgeboOuEfs1mQuvw7zsBkre014w847BePrDfJjmbI+qXOBqQ7bJJoL
	 gLxEqSZ+M7yxcCT93JB+Afdg0YUWPjWOjFj6/94zJsTvDN0QFLht8UREVWU/1vtwI7
	 uzq5AFgwbrVx5TsJWCgKJ8hktj8zAEDTHpHqRuLjLJdEOuD4kooQdWxjiUkBEGY3rp
	 yo3V3QDcHbV2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 1/8] mptcp: use atomic64_t for
 msk->ack_seq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <1d4ae9189eece66deaf4e7c47ff2e705341e31ff.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
 <1d4ae9189eece66deaf4e7c47ff2e705341e31ff.1787644449.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:14:54 +0000
Message-Id: <20260825081455.1BA301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Torn reads on locklessly accessed `u64` variables (`bytes_received=
`, `bytes_consumed`, `write_seq`, `snd_nxt`) on 32-bit architectures.
--

--- Patch [1]: [PATCH mptcp-next v8 1/8] mptcp: use atomic64_t for msk->ack=
_seq ---
commit 6ecb7c718880f7f40ce17752ce61e7a9dfad9bea
Author: Geliang Tang <geliang@kernel.org>

mptcp: use atomic64_t for msk->ack_seq

This commit converts msk->ack_seq from u64 to atomic64_t to guarantee
tear-free accesses on all architectures. It also caches the atomic64_read()
value in local variables in __mptcp_move_skb() and __mptcp_ofo_queue()
to avoid inconsistent repeated reads.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f22d64ab1c53b..88bdb65a9e87e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -464,7 +466,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct =
sk_buff *skb)
>  		}
> =20
>  		msk->bytes_received +=3D copy_len;
> -		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> +		atomic64_add(copy_len, &msk->ack_seq);

[Severity: High]
This isn't a bug introduced by this patch, but since it explicitly sets out
to fix 32-bit torn reads for msk->ack_seq, should the other 64-bit socket
state variables also be converted?

For example, msk->bytes_received is updated here using a plain non-atomic +=
=3D
operation, and it is read locklessly in mptcp_data_avail():

net/mptcp/protocol.h:mptcp_data_avail() {
	...
	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
}

Similarly, write_seq and snd_nxt are read locklessly:

net/mptcp/protocol.h:mptcp_stream_memory_free() {
	...
	notsent_bytes =3D READ_ONCE(msk->write_seq) - READ_ONCE(msk->snd_nxt);
}

A torn read on these 64-bit variables can produce a massively incorrect
value. When a counter crosses a 4GB boundary (e.g., transitioning from
0x00000000FFFFFFFF to 0x0000000100000000), a concurrent 32-bit read might s=
ee
0x00000001FFFFFFFF. In mptcp_poll(), this could lead to incorrectly
calculated data_avail or notsent_bytes, causing spurious EPOLLIN/EPOLLOUT
events or missing events that permanently stall the connection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787644449.gi=
t.tanggeliang@kylinos.cn?part=3D1
