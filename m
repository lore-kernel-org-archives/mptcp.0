Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5213515F3
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716215; cv=none; b=OGWHzb2zEm54Gr4GwFZHJib4l6KmAOmh9PFlF3tHAYgO598NQ7+8S6SAEt8SjjFuQAUT1gwI9KRURpg38lJ7aKdLlshy69HV7yoqdbHa4pXceoZSAIcekBIDmyota1WsPLmGAQUqYs/4U2/Tyvy3fHEO/cbjT+gqFjx7IGNZvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716215; c=relaxed/simple;
	bh=wRXWgozgde8byaYSoG4O3yP6pVS/DCE/yXoQy2e//dQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SbYYXJeDZvfGru9FSQkX9F8JM3lBQFFz2EEU/IQ2GGCTM/s+np8A2bFtioOGQk8B3sOwzgW5GmhRlSeNjQ+/iU5LeMnvUK3o1I3BWvYbGfBvYz8jT6PXUFCBaNvxXV9ebXPgHsAVk44Qqr6BSMBOKjxgsUz1Qp8DUZHrDykUsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8+O0tir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8+O0tir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D5B1F000E9;
	Fri, 14 Aug 2026 14:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716214;
	bh=CAFlysk0Wmp9jGD+0bYiTp7xxwr4Pb9Br8Yg3rZnj7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8+O0tirFSi8eDtZNtQTNbg2efiWVin28oPXOCRU6y+N4nEutIebnV709i+YD71Au
	 z3m43V5xAQ8eMVtemVtFq4uVhBAm25mrySujW+5dxVvZhKKLPa8SiGoQjYPr7iBgE9
	 VpWAW/WHvlFZQYz4s6TAtJSCW6UZgS3B+/tp7sKOyEXPKcR0tYO0G34G9YN7kxeWmx
	 gtcwD/64GgWsZDgqRnMYVE+t2w6S6dULLUtyv/rgh+ksMTMff/9qqkl9YuaPBP26ht
	 UQ/iDQW7PcwerW14eesXoblUsfaRP7GF8CQXiPNXpHQOdCDNKaxQr+96MVWZ7Q6a8g
	 VP9Oq0YH7wlMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH resend mptcp-net 4/4] mptcp: do not reschedule the RTX
 timer for fallback sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <59c6c4dd41bb72b7aef984b14a0c6ad0881f6a4c.1786713351.git.pabeni@redhat.com>
References: <cover.1786713351.git.pabeni@redhat.com>
 <59c6c4dd41bb72b7aef984b14a0c6ad0881f6a4c.1786713351.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:03:33 +0000
Message-Id: <20260814140334.39D5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The MPTCP_RTX_DISABLED flag makes the TCP_CLOSE state sticky for t=
he RTX timer, permanently disabling retransmissions on reused connections a=
nd their accepted children.
--

--- Patch [4]: [PATCH resend mptcp-net 4/4] mptcp: do not reschedule the RT=
X timer for fallback sockets ---
commit 227375cb381dd3864273cd7170dd28e0f079ff8b
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: do not reschedule the RTX timer for fallback sockets
   =20
This patch introduces the MPTCP_RTX_DISABLED flag to prevent the RTX timer
from being rescheduled on fallback sockets and when the socket state is
TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b311fe30c7855..f22d64ab1c53b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -1121,13 +1122,14 @@ static bool mptcp_rtx_timer_pending(struct sock *=
sk)
> =20
>  static void mptcp_reset_rtx_timer(struct sock *sk)
>  {
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	unsigned long tout;
> =20
> -	/* prevent rescheduling on close */
> -	if (unlikely(inet_sk_state_load(sk) =3D=3D TCP_CLOSE))
> +	/* Prevent rescheduling on close and in case of fallback. */
> +	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
>  		return;

[Severity: High]
Since this flag is checked here to prevent rescheduling, will the timer be
permanently disabled if the flag is never cleared?

[ ... ]
> @@ -3360,6 +3362,9 @@ void mptcp_set_state(struct sock *sk, int state)
>  		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
>  		 */
>  		break;
> +	case TCP_CLOSE:
> +		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
> +		fallthrough;
>  	default:

[Severity: High]
Does setting MPTCP_RTX_DISABLED here without a corresponding clear logic ma=
ke
the TCP_CLOSE state sticky for the RTX timer?=20

If an MPTCP socket transitions to TCP_CLOSE (like a failed connect() attempt
or an explicit disconnect()), and the application then reuses the socket to=
=20
connect() again, it appears the flag will remain set.

Furthermore, if listen() is called on such a reused socket, would
sk_clone_lock() copy the flags to all child sockets? This could cause every
accepted connection to inherit the MPTCP_RTX_DISABLED flag, permanently
breaking MPTCP-level retransmissions for all clients.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786713351.gi=
t.pabeni@redhat.com?part=3D4
