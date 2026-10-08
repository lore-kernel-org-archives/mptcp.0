Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21173B9D98
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453802; cv=none; b=lA5psOH5QoMTYVB1hhEcl4xktN4ZQ8BsojLlacv1pXTIHck0VH7F+mkI1wUk86OdOYZfI7kIL6Hx8vwEjsCWWLZJ70olhQgfYCO7hkW2DNxW7INZF3NFfHyQKkBBSkcb4+fjQmy2MJSuuDjsCe7UWLVEqOxGHI3+MwJRMzBvnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453802; c=relaxed/simple;
	bh=We0DXqvDCFJDbCWBNfjEyaKK6x5qKBLYpwL5ir8O8RU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i2feTT2/Bi1b+5H6IyQVieNd+OUzNK1zYccvHzR3Mbc1D6OMOoXbR9d95AQsaAAKwUfM5pMcz71f87/i+uSSIHtWwMKmbSBG4IHUoZ2EVMjXLI0Bc37gJ2uVc2tLByoXcI6lqK5Dp3GX02aI1xYGs7r6DiLcDRXRqr33jlFK9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cepHuTrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cepHuTrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD71F000FF;
	Thu,  8 Oct 2026 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453801;
	bh=uHnjfN8LapBEShlPBhL2KFvHRWcdaeeVFii5NrtT8JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cepHuTrFA7d2i+QU7+cSuOboNV4CavMf6hyBm5iBMam8zy3/ylgDCj2fVggndpngg
	 URKsQNkS84v4k1CwVACR7yzx8NHwMSFvJ24wyAvH7iHSACzTICYmfrElkELc4iof5p
	 DI4T7ZWZIALJEVHxqx89N5wItIpmBX6+bN73hP7IvYHCeKXbcjLarfVA2zsp1/apuK
	 cFljYZKC0weJGS5wrOomEsiJOfPblkhekl5A6Erxe5gGSfL5YvuTZXeyLEMzPj1+NG
	 cM4Jq3M6iiLKZa2kLBsNxBtzYsN6JDRogJOzitlQnhVIUnect9Y7eanBh17d+EuKyQ
	 3vC4ilGJAkSMA==
Message-ID: <sashiko-outbox-163983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mptcp: push queued data on passive TFO subflows
 becoming established
Reply-To: sashiko-reviews@lists.linux.dev
To: "T S Rameshkumar" <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
References: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:03:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mptcp: data race on cb_flags due to mixed atomic and non-atomic bi=
tops
- [Medium] mptcp: unintended worker scheduling on all TCP state changes for=
 TFO subflows
--

commit ae556f46010534274aa7940f77f235a6807ae115
Author: T S Rameshkumar <rameshsv06@gmail.com>

mptcp: push queued data on passive TFO subflows becoming established

With TCP Fast Open on an MPTCP listener, if the server application writes
data while the passive subflow is still in SYN_RECV, the data is queued.
This patch attempts to push stranded data when the underlying subflow
transitions to established by modifying cb_flags and scheduling the MPTCP
worker.

Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=3DX3=
qf6QycjfKBw+8snPg@mail.gmail.com/

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..f499073a62d7c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
[ ... ]
> @@ -1894,6 +1894,11 @@ static void subflow_state_change(struct sock *sk)
>  	if (subflow->resetting)
>  		return;
> =20
> +	if (subflow->is_mptfo) {

[Severity: Medium]
Since subflow->is_mptfo is never cleared and there is no check for
sk->sk_state =3D=3D TCP_ESTABLISHED here, won't this trigger on every subse=
quent
TCP state change?

The commit message states this logic is intended specifically for when "the
underlying subflow transitions to TCP_ESTABLISHED", but without checking the
state, this could fire erroneously and schedule the worker when transitioni=
ng
into shutdown states like TCP_FIN_WAIT1, TCP_CLOSE_WAIT, or TCP_CLOSE.

> +		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(parent)->cb_flags);

[Severity: High]
Does mixing atomic and non-atomic bit operations on cb_flags cause data rac=
es
and lost updates?

subflow_state_change() uses the atomic set_bit() operation to modify
cb_flags without holding the parent MPTCP socket's mptcp_data_lock.

However, concurrently, other paths modify cb_flags using non-atomic operati=
ons
while holding mptcp_data_lock. For example:

net/mptcp/protocol.c:__mptcp_check_push() {
    ...
    } else {
        __set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
    }
}

If the atomic set_bit() occurs between the load and store of the non-atomic
operation, the newly set bit will be clobbered and permanently lost, which
could lead to stranded data or missing wakeups.

> +		mptcp_schedule_work(parent);
> +	}
> +
>  	/* as recvmsg() does not acquire the subflow socket for ssk selection

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008095231.1031=
86-1-rameshkumar.t@phytecembedded.in?part=3D1
