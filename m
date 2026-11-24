Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560356;
	b=u9oVXBngcZEYcZF5fh2BjFcKVyiuOmbjxwHnC5A8E05RJ4ujMo67f5tcWigJHIsn9YaX
	 7IgCki2Wc64mP798AukMJkcJ9jYoug3trjPKZ644BikFFUlhHqg6w0jtIqb+snpqww8Nf
	 Us1CbBVER0/fBLFPdE+MjIQ7d09hL9b7yEwy5lgdwgB+oJv7cVNS/6aXxRAhFzQrkF3u6
	 AZHjO0Bc+RbSkav0h5e1CBazAqwjoNNm8L5GCX3QUbsqtJpXle+z94fnJJdns/dpcSGwL
	 kiks3+WOW7vkkkSbQLvYEGqUWJzQ4FzQYK0hhMkHZIzML9SXkYiVVmVxgGgzBuPkQsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560356;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CDdqShsWjfxXOeiqeSeVyjCHGnQL4GwD2gOTYO9A1pI=;
	b=fMxTo9gHW3aNZBoWWqEMvIk+3M3C4MsE1XAvBltoZItJUOosxGGOFbF7qaib6cMZ2wU8
	 fsoRbi3r7JaYVRvBP5N51a4JjVDAlrswcoCP8cd5qIfwxktC6rhm2xdYmkC30S+cehc65
	 nLsUne2kL/qYA+w/Xig4zx2kAUC5zd/AvxsqX8FczLaQgBJphDc3qKW0vTFm47QN4Jogl
	 b/FLiv+0YFbGaCE9Iu5kbYuekDrk3SmC7np/GjlaJnLwG4iurEJqF25DNejlxtAM2uM4S
	 DDCNnTylvMSfS1BlM54kKX1BPdAKHXxT9bZl1YS0jQqJsJMLD6VbE2bolYXCBmQjE6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8NKXWN8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E32606A332
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8NKXWN8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E5E1F000CF;
	Tue, 24 Nov 2026 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560355;
	bh=CDdqShsWjfxXOeiqeSeVyjCHGnQL4GwD2gOTYO9A1pI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=T8NKXWN8eQK/FOglfyCnYcGcRUk8zvuo8sy4u45ooHxnsfKX3EJoyXslbv8wez5wG
	 mjNIb6LV684PXMPK+hG38t5EV4zMpZSh1SXMwgFgFhU3R03bYhSyWEXyUzY8AKr7jo
	 OvP54L8nhLeVx40J3ASLa8uxJ4XlXhm6MK19c+FFtIODkdfkvBHg0vdZJ0Q9mDcptf
	 AJ9sDOgo7IgqQteiCmHY8w1kJFx8fk6OxZtZT2dXCj0T0S/Nk+T2p7kEGATef7Fa4B
	 sE6txUTJkmBcJIEAxMiCx2bMYMmMBSR9OVPI8vCkEq9vCHqG733g/4hXDERKvaAnUU
	 nlkxVhx5FmexQ==
Message-ID: <sashiko-outbox-232155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v3 37/50] mptcp: keep the first byte after a
 simult connect
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-37-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-37-416c0920c73f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:45:55 +0000
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
- [Medium] mptcp: mptcp_syn_options() sets ssn_offset on MP_JOIN simult
  connect
--

commit dbb5c11e7bc9fc6242718c808b25e1938f5448b0
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: keep the first byte after a simult connect

This commit initializes subflow->ssn_offset when sending a SYN-ACK in
TCP_SYN_RECV after a simultaneous connect and only updates it in
subflow_finish_connect() when the incoming packet carries TCPHDR_SYN.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 05b9c66aaed63..41eb39968a9a6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -474,6 +474,11 @@ bool mptcp_syn_options(struct sock *sk, const struct=
 sk_buff *skb,
>  	 * in mptcp_established_options_mp()
>  	 */
>  	subflow->snd_isn =3D TCP_SKB_CB(skb)->end_seq;
> +
> +	/* simult connect: the peer's SYN-ACK will not set ssn_offset */
> +	if (unlikely(sk->sk_state =3D=3D TCP_SYN_RECV))
> +		subflow->ssn_offset =3D tcp_sk(sk)->rcv_nxt - 1;
> +
>  	if (subflow->request_mptcp) {
>  		if (unlikely(subflow_simultaneous_connect(sk))) {
>  			WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));

[Severity: Medium]
Can setting subflow->ssn_offset before checking subflow->request_mptcp
leave an active MP_JOIN subflow with a valid ssn_offset after a crossed
SYN?

An active MP_JOIN subflow enters TCP_SYN_SENT with request_join =3D 1,
remote_key_valid =3D 1, and mp_join =3D 0.  If a crossed bare SYN moves it =
to
TCP_SYN_RECV, mptcp_syn_options() now sets subflow->ssn_offset to the
peer's ISN without falling back or resetting the subflow.  When a 3rd ACK
with seq =3D=3D ssn_offset + 1 arrives in TCP_SYN_RECV,
tcp_rcv_state_process() transitions to TCP_ESTABLISHED without calling
subflow_finish_connect() and enters check_fully_established():

net/mptcp/options.c:check_fully_established() {
    ...
	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1) {
		if (subflow->mp_join)
			goto reset;
		if (subflow->is_mptfo && mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
			goto set_fully_established;
		return subflow->mp_capable;
	}

	if (subflow->remote_key_valid &&
	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
	      (!mp_opt->echo || subflow->mp_join)))) {
		goto set_fully_established;
	}
    ...
}

Because seq =3D=3D subflow->ssn_offset + 1 now matches while mp_join is sti=
ll
0 and remote_key_valid is 1, an ACK carrying a DSS ACK marks the subflow
fully established without MP_JOIN HMAC validation and triggers
WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
!subflow->mp_join && !(state & TCPF_CLOSE)) in subflow_data_ready() if
data arrives, while a bare ACK attempts TCP fallback on the parent msk
instead of resetting the MP_JOIN subflow.

Moving the subflow->ssn_offset assignment inside the
subflow_simultaneous_connect(sk) block under if (subflow->request_mptcp)
would avoid initializing it on MP_JOIN subflows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-mptcp-cmas=
on-fixes-v3-0-416c0920c73f@kernel.org?part=3D37
