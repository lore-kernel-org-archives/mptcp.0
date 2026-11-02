Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589236;
	b=31TNi8//qopzOp9XXzMm6rF+BoBgOxrNNFk+U01Qcy7TQg4tPzsOicJqKlIrAB5uN0Sl
	 XuZcYOhmT6hL4VQj62s4OxCsVF5KTjBRN0gt7/Vmmz2hUlvpO91UTkciG3lS1RZR0w1rh
	 nE/yraaECrLjgycwNMEvx3W12s0xqek+5yrMHuoF8UmRERBu53X0gS/422uOR3mb6elOR
	 IVJqugzFnGfqb2GWBb+tE9cqoKkzSoprT3uqm9KL4PxsZSFhAZW+/ZGZla11Me3l54YXx
	 AULYVWAuXNoIbGH3Gt9GyXWlPJozs+5SAyvUwkweHn3pT4zhqjqGC9kZM3CdNdEWReA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MXhv4ujDqkkEZ8MqeU8i7m39c7H42j582adfnpwJoCg=;
	b=42SZ8YLIbXzzkqs8LTz7Ocyi4DD9myvtDfYm/Zw2m2fCwvqNbyaf/oWsVwZmxpDEUoeN
	 b4zG7oDw1feqajOVPXzBnUGalKmczPKvPgZF0QxuRvwFZjrRK2ObHL1AD3c1S4nzsX6Qn
	 MNSdu7zCxZgkoynh3BlN/PgNvGLWZUJBtJyNQgWqOt5j5xdCubBTtB4totpdDXfUVd00c
	 /c9jElZpsxorctYqa/wpVLDFbBimai630qL2o0cm+Xpd3f6F8F0xJx/1bheyY8ibmbJct
	 VPmpGYrcw/kfCZT4PGjjkJXQkYh6KyGIwgltfTB5T8uB7dI/cF6g00knafGnCGmV7fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJJ11RSI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EAD606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJJ11RSI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D45B1F000C1;
	Mon,  2 Nov 2026 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793589235;
	bh=MXhv4ujDqkkEZ8MqeU8i7m39c7H42j582adfnpwJoCg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dJJ11RSI6urVTvhqLynYoWykUVdAMujXK5s78XdZgAQUVjs3cmNynG9BFPHofBwjD
	 vX+ixnqtuc9i7dZjNUbliAOiZWqIGZq4ka4Dogw2Xk1WUSCotkx4+Ycd7CUGI+07Hm
	 JbMQSXIb24MN7SLxcQ7Vyk0LmR9CKuIgmoAskiwooVGsKUw2WJ4KMXTm6gCP2tHsfg
	 Tp7qllWa4my/Gw/E0+koQVSNYo2ewCD0/LSt2Z8axxPklwp2kE0smaCvMwbv3XzFzH
	 X4blvBNeJ7SZsmMJ/0qFA3GhntU2XzKiOxzc2bORpf9b7VGXpHoXeRJTqttU10W7VU
	 MnwmtQ/j6VSfw==
Message-ID: <sashiko-outbox-192855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 4/5] mptcp: track app-limited state in
 mptcp_sendmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <b3d85544ac84b3c83617f72a5cfc893bac2a6304.1793588257.git.tanggeliang@kylinos.cn>
References: <cover.1793588257.git.tanggeliang@kylinos.cn>
 <b3d85544ac84b3c83617f72a5cfc893bac2a6304.1793588257.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 03:13:54 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mptcp: mptcp_rate_check_app_limited() bails out when data is in =
flight
- [Medium] mptcp: unlocked msk->snd_una read in mptcp_rate_check_app_limite=
d()
--

commit 6075a59b5fc2bd09596bbf554a3f811da115a224
Author: Geliang Tang <geliang@kernel.org>

mptcp: track app-limited state in mptcp_sendmsg

This commit adds mptcp_rate_check_app_limited() to run
tcp_rate_check_app_limited() across all subflows from mptcp_sendmsg_locked()
when no unsent data is queued at the MPTCP level.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7ccb1c7506a37..ab7de11a448ce 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2038,6 +2038,25 @@ static void mptcp_rps_record_subflows(const struct=
 mptcp_sock *msk)
>  	}
>  }
> =20
> +static void mptcp_rate_check_app_limited(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (msk->write_seq !=3D msk->snd_nxt ||
> +	    mptcp_send_head(sk) || mptcp_rtx_head(sk))
> +		return;

[Severity: Medium]
Does checking mptcp_rtx_head(sk) here prevent subflows from being marked
application-limited whenever any sent data is still in flight?

Every sent mptcp_data_frag stays on msk->rtx_queue until a DATA_ACK advances
msk->snd_una past it and __mptcp_clean_una() removes it, so mptcp_rtx_head()
returns non-NULL whenever msk->snd_una !=3D msk->snd_nxt:

net/mptcp/protocol.h:mptcp_rtx_head() {
	struct mptcp_sock *msk =3D mptcp_sk(sk);

	if (msk->snd_una =3D=3D msk->snd_nxt)
		return NULL;

	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, l=
ist);
}

In contrast, tcp_rate_check_app_limited() is designed to run while packets =
are
in flight below cwnd (tcp_packets_in_flight(tp) < tcp_snd_cwnd(tp)) and
already checks tp->lost_out <=3D tp->retrans_out on each subflow, while
MPTCP-level reinjection in __mptcp_retransmit_pending_data() resets
msk->first_pending (which is covered by mptcp_send_head(sk)). With the
mptcp_rtx_head(sk) check in place, won't mptcp_rate_check_app_limited() bail
out whenever any unacknowledged data is in flight on the connection?

[Severity: Medium]
Additionally, is it safe to call mptcp_rtx_head(sk) from
mptcp_sendmsg_locked() -> mptcp_rate_check_app_limited() without holding
mptcp_data_lock(sk)?

mptcp_rtx_head() performs a plain 64-bit read of msk->snd_una, whereas
incoming DATA_ACK processing in softirq context updates msk->snd_una under
mptcp_data_lock(sk) even while the user owns the msk socket lock:

mptcp_incoming_options()
  ack_update_msk()
    mptcp_data_lock(sk)
    __mptcp_snd_una_update()
      WRITE_ONCE(msk->snd_una, new_snd_una);

Other callers of mptcp_rtx_head() (__mptcp_clean_una(),
__mptcp_retransmit_pending_data(), and __mptcp_retrans()) hold
mptcp_data_lock(sk), and helpers that read msk->snd_una under only the msk
socket lock use READ_ONCE(msk->snd_una). Can this cause a data race or 64-b=
it
load tearing on 32-bit architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793588257.gi=
t.tanggeliang@kylinos.cn?part=3D4
