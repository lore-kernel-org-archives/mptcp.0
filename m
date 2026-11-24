Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559777;
	b=z0WMvySdj6IntUjr9ermyk6CXi92l68ckFVxZP36ZsIEHOqrA9tLNK9CoyjsYDqJWopC
	 JikCuul/PvzorsixO6ChBAfRKmE8qea759PjVa2xwOjkRvL4OPw0ubyWIxu0XzViylM2N
	 opYoHk0o5T+sp4hyC2q/hv/nxlDagmnubczZ9MiTxyTGCo+V1+CjMD590sA4G1RvEws12
	 kn/XdB4rb3o5Gqn4TNIPP/gzJNQ3nlGuPIHW/7sZYV0Dw1mai1QH/pwv/xcvWLwn053jU
	 wDPglTi6Zmr+YOuunhu9vWg9ln2RIXvaUhW5FU/du1xTMvB2z+N4lThdmvU0wr2SvTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DL8eFcxU72ohnWw98p+FRKkJ0djeVprsGV6XQCBQhH8=;
	b=25SVzQ2i+kZKij+ksM7vUHzcQgvhFNYk/2xELQVtX3vZWeS43O1Z9oeHeNq7HOEEEh5W
	 /4YzawUjWx6CsCDNnDvpHzHpeIAdB1Keii61Z9ra7whUm5DltqgSIPvXGiyP7wXDe9n8t
	 Cmj9qa8gGXSoiNlvxMbiaF5W71AAMheUWbCW2WEIrwmTCapLN8LGZWnWTREG9eHC8yi20
	 g563oc9kYXGEX6iTnhzsfULh5G/2SlyCFAWdsr3PZPs2oybp7k91V67kdLveSxBjBMf5h
	 o17dot8EWOmCQgIlhxucARplx+chP2/25QuXY5bsfvyaYe5QyBcPfgnLII9K/7ZiVlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odAdbQ5Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F02606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odAdbQ5Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6D41F000C0;
	Tue, 24 Nov 2026 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559777;
	bh=DL8eFcxU72ohnWw98p+FRKkJ0djeVprsGV6XQCBQhH8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=odAdbQ5QQwouT+A9VEyeOrevWx4wNI98v3va55L23PZVBF2xDAXhvj1Y7rMBkoaMV
	 h72O95Wm1RLMN03Pqb6g++63mqswZNgNKoKhueKtbh1rQtN0Ly1+P0K3TvqS+Rqkrg
	 wDCPh8aJqYqYZZ71hdWGnPRXMM2wJ4CCk36uE2JGmq8lMCFwZzYAYUxwpQsTTA0DMy
	 PFCJ1fadHXL+Xljqr0ajusSwy9/ImBDAwzaL/2dRr/00HWHV1jbhn2LtOIJ5HmmCLn
	 pEcusbhjG0ZSsDmuyX2cctb0RoTISSOQ2r51tr0lHZb0giJR+9TtpQMAljZV2BL7GC
	 QkG8zCL2N2Cow==
Message-ID: <sashiko-outbox-232141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v3 29/50] mptcp: don't resend data acked
 without MPTCP opts
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-29-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-29-416c0920c73f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:36:16 +0000
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
- [Medium] mptcp: false reset in check_fully_established() due to stale
  opt_ack_seq
--

commit d927d8fcbe3e60d7a3edc0251d874227df06db6e
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: don't resend data acked without MPTCP opts

This commit tracks the highest TCP ack_seq received with MPTCP options in
subflow->opt_ack_seq and resets the subflow instead of resending data if
snd_una has advanced past opt_ack_seq before any MP_JOIN subflow is
established.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f9b65d0c6290a..05b9c66aaed63 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

[ ... ]

> @@ -1287,11 +1291,16 @@ bool mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
>  	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
>  		return sk->sk_state !=3D TCP_CLOSE;
> =20
> -	/* MPTCP opt acking the old data, not an infinite map: no fallback */
> -	if (unlikely(subflow->old_data_pending) && mp_opt.suboptions &&
> -	    !(mp_opt.use_map && !mp_opt.data_len) &&
> -	    !before(TCP_SKB_CB(skb)->ack_seq, subflow->old_data_end))
> -		subflow->old_data_pending =3D 0;
> +	/* MPTCP opts, not an infinite map: the peer did not fall back */
> +	if (mp_opt.suboptions && !(mp_opt.use_map && !mp_opt.data_len)) {
> +		u32 ack_seq =3D TCP_SKB_CB(skb)->ack_seq;
> +
> +		if (after(ack_seq, subflow->opt_ack_seq))
> +			subflow->opt_ack_seq =3D ack_seq;
> +		if (unlikely(subflow->old_data_pending) &&
> +		    !before(ack_seq, subflow->old_data_end))
> +			subflow->old_data_pending =3D 0;
> +	}

[Severity: Medium]
Can calling check_fully_established() before updating subflow->opt_ack_seq
falsely reset a passive TFO subflow?

On a passive TFO child (tcp_sk(ssk)->syn_fastopen_child), if an out-of-order
packet transitions ssk to TCP_ESTABLISHED before subflow->fully_established
is set, the server can already send data on ssk.  When the peer's packet wi=
th
valid MPTCP options (such as OPTION_MPTCP_MPC_ACK) arrives and acknowledges
that data, tcp_ack() advances tcp_sk(ssk)->snd_una before
mptcp_incoming_options() runs.

Because check_fully_established() runs before subflow->opt_ack_seq is
updated:

net/mptcp/options.c:check_fully_established() {
    ...
	mptcp_data_lock(sk);
	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
	if (tcp_sk(ssk)->syn_fastopen_child)
		__mptcp_check_push(sk, ssk);
	mptcp_data_unlock(sk);
    ...
}

__mptcp_check_push() -> mptcp_sendmsg_frag() sees after(tcp_sk(ssk)->snd_un=
a,
subflow->opt_ack_seq) as true.  If mptcp_sendmsg_frag() sends a zero-window
probe or old data (before64(data_seq, msk->snd_nxt)), it resets the subflow
with MPTCP_RST_EMIDDLEBOX even though the incoming packet carried valid MPT=
CP
options.

In addition, if __mptcp_check_push() inside check_fully_established() resets
ssk on a packet without OPTION_MPTCP_DSS, check_fully_established() still
returns true and mptcp_incoming_options() returns true before checking
sk->sk_state =3D=3D TCP_CLOSE, leaving tcp_data_queue() to process the skb =
on a
closed subflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-mptcp-cmas=
on-fixes-v3-0-416c0920c73f@kernel.org?part=3D29
