Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256520;
	b=3c2PY9LkdRM05clK3FT1TNzCa+CZW4zQthU4Uw8jdqhLnEpn6wUa1SlmfAx8QSFhEFFU
	 dgBGylFsRJAjz2sz5wLiag2BP0AXukWJb3bVxDmEWjeQRQVieQtOzJvZ1LvAftfZ2ZQfa
	 pFOPOUlRZ4JjTUmWHVlcTEhuRCPtGoP5oPWmZ1I73T0JZjM8Gub6DHpr+mvQlU3WfBgMB
	 U2/AEJUn2uLSFSslwyxu5KeOnejt5VN6UmoDm/0kd1xahjFyeh/r/lpl2knToeX8XIXBc
	 6VfQP6+xyHWs0ITjccB3G5mJU6WY0CZ+7vYCXs4kyPZlM9y/wKK4rFyWM1KnfVaLqwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256520;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DegIV/8hteCpQ4FUm7Or6Y5vwlyTUxm91+1kUR4MKEw=;
	b=TaX9H1FYS8xAYlco9U00GtU49otbQUtB6HJmkeLgrVzch2mQ0EI4lw967hu8F1e9JRu8
	 0oGJ1mPk7ww+JZLfx8/ACAy3TiztRNO+zPcREY+tpI7ICRKbabFWCFcQQ1X0KnPpolW9K
	 vuf2LLgkT4bpHGpM/BSV8l7iMCMdlumJsCLksHnVGRG2b5GCg2OKLPj1Ffdulaeg3keGE
	 dQ9dM6W9TDAjcMzOqJJdVcTD06PU2FO2uDRL9Sg1k+109cyYnn3dp2jWO2N6MS3oeXFRM
	 Ba1PD7Hct2PsRsWmkbxNRG+CZiAHcncNuog/vjBIHXUdv6c3XJLhWF1uiLx7jbRS+rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxpE7EpW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAB606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxpE7EpW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549061F000CA;
	Sat, 21 Nov 2026 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256520;
	bh=DegIV/8hteCpQ4FUm7Or6Y5vwlyTUxm91+1kUR4MKEw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IxpE7EpWh878ubCtaOW177+JuVPrO6jNjm2AvyFFIb5TCmmHJjIbjAp0/IwwVFKkx
	 Rdesxuh5wJw54vLA67BvrQ+y76bmcAdMYEfj0zJ8HYDkaqDyIXOc717m91pgZVVjGh
	 Eni/ABKEn3gp6SjAhgl24MU2lr2wzwaYbvXYB2VrFUe8oYnLpksCilodb16/sPbhom
	 F8ZWgbOy3iKJ62b0x8M3sAXtIHtkZeGVompOITG0d0/mYlNwdhE1twS9eGxGdLkrSR
	 jhOtLJLuxSDRckK6yMY9XD56fknI9zmlnZvAIw0e8oqTZCutTkZ9mHG64GncF1ZrlZ
	 MBPBfnnHfnGPw==
Message-ID: <sashiko-outbox-226938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 59/62] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-59-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-59-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:21:59 +0000
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
- [Medium] mptcp: mptcp_sched_get_send() skips mptcp_set_timeout() if
  already scheduled
--

commit be05849933557cf4aa59c7bd40312183567d8767
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Squash to "bpf: Export mptcp packet scheduler helpers"

This commit calls mptcp_set_timeout() in mptcp_sched_get_send() before
invoking a custom packet scheduler so that msk->timer_ival is initialized.

> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 1e59072d478c9..2f685986698b7 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -189,6 +189,9 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
> =20
>  	if (msk->sched =3D=3D &mptcp_sched_default || !msk->sched)
>  		return mptcp_sched_default_get_send(msk);
> +
> +	/* as the default scheduler: the rtx timer needs an interval */
> +	mptcp_set_timeout((struct sock *)msk);
>  	return msk->sched->get_send(msk);
>  }

[Severity: Medium]
Can mptcp_sched_get_send() still leave msk->timer_ival at 0 when a subflow
already has subflow->scheduled set?

Right above this hunk, mptcp_sched_get_send() returns 0 early if any
subflow has subflow->scheduled set:

net/mptcp/sched.c:mptcp_sched_get_send() {
	...
	mptcp_for_each_subflow(msk, subflow) {
		if (READ_ONCE(subflow->scheduled))
			return 0;
	}
	...
}

When a BPF scheduler marks multiple subflows as scheduled (such as
bpf_red), the active subflow can drain mptcp_send_head(sk) and delegate
the remaining scheduled subflow.  Because mptcp_send_head(sk) is now NULL,
__mptcp_subflow_push_pending() does not enter its send loop on the
delegated subflow and leaves subflow->scheduled set to true.

Once all in-flight data is acknowledged, mptcp_stop_rtx_timer() resets
msk->timer_ival to 0.  On the next send, mptcp_sched_get_send() takes the
early return above without calling mptcp_set_timeout().  If
__subflow_push_pending() then stops after the first fragment because
msk->snd_burst <=3D 0 (or fails under memory pressure), it exits before its
own mptcp_set_timeout() call, and mptcp_reset_rtx_timer() arms the
retransmit timer with a 0 interval, firing every jiffy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D59
