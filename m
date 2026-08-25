Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51C233149
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676559; cv=none; b=qyy8VAW1ywbOcFE4avgOswi6/gfQOUfnX9mP5buYNZx0JNSgFiSMfiuMa8Se0mq3m+A+6jfj8uYkvYfqrIvGj4QWOY4MshLC5xFBO3F6/Q5sYrdzuBkAphuOEWo67f0AQARUT8nUTf3o/ki147RVdD+r5m3v1iHf4ZaJuJJ/M5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676559; c=relaxed/simple;
	bh=Va3e+fJdkTDqgFoFG8UTmCcsZw/QWymyNXzG4sapSaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sJZzPGBReuGZzMFS1kkW+wxCPRDg7I7CtM3aiYHVdy4h/J3gX4GMRz5YWkJjOSrqgkcreQYDaAngqj9YQXXBW6LPAMrKMBMlNUmOD6sNsQsA9U8ICRMIK55PZspZdg968YERG8xNYojM6cqumx9mrOzF60J6i3zSitBT5BcOCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL6Z0Wq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL6Z0Wq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5621F000E9;
	Tue, 25 Aug 2026 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787676558;
	bh=6MNq42QPWoExX5BKUcdGPDuEqu279O8ZgZah928MVCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CL6Z0Wq4rIszUimTJ5TVORkXAKfF5gTOp1S/Ji+39FJmXK8AIDhC1hsrqTOHOF4L9
	 GOapkkQTC86B27Qjg5EranB3EBIGS2cKtv0tY9ufpYi1c/RmfIwP/BlbFDCyxwiNns
	 g86PztNaXG37y1/g0MjabluOiA8geOp/5ElgkUeIx0gte8n+TDjgSJP6v2ghCm3RNl
	 CNGvfnqGA/+9gEVbf44JZJi3OksViRs5QXpBpn/dX2NjWmGUL02PJT/aXoN93HYOym
	 o3/SiSxrh+VEnEhsAy3Uaol2SGre9gz1ydAIChA/mIy4EP2Xhq5vci/LyrsqXdfW45
	 OQuxrNwXTCyNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 01/14] mptcp: do not reschedule the RTX timer for
 fallback sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-1-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
 <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-1-a92309d121ca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 16:49:17 +0000
Message-Id: <20260825164917.EA5621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] MPTCP_RTX_DISABLED is set on TCP_CLOSE but never cleared if a conn=
ection fails synchronously, permanently disabling retransmissions if the so=
cket is retried.
--

--- Patch [1]: [PATCH net 01/14] mptcp: do not reschedule the RTX timer for=
 fallback sockets ---
commit e15c87662e83ee7836d581b8ebc2d5e99a964d98
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: do not reschedule the RTX timer for fallback sockets

This commit stops the MPTCP core from rescheduling the retransmission timer
for fallback sockets. It uses a new flag bit MPTCP_RTX_DISABLED to prevent
rescheduling during fallback and when transitioning to TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b474d03620a75..23dde0b7144bb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -3324,6 +3326,9 @@ void mptcp_set_state(struct sock *sk, int state)
>  		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
>  		 */
>  		break;
> +	case TCP_CLOSE:
> +		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
> +		fallthrough;

[Severity: High]
Does this permanently disable retransmissions if a socket is reused after a
failed connect?

If an application calls connect() and it fails synchronously (for example,
connection refused), mptcp_connect() handles the error by calling
mptcp_set_state(sk, TCP_CLOSE). This sets the MPTCP_RTX_DISABLED flag.

If the application then retries connect() on the same socket, mptcp_connect=
()
transitions the socket to TCP_SYN_SENT but never clears the sticky
MPTCP_RTX_DISABLED flag.

Because the flag remains set, mptcp_reset_rtx_timer() will permanently abort
arming the retransmission timer for this socket, which could cause the
reused connection to hang indefinitely upon packet loss.

>  	default:
>  		if (oldstate =3D=3D TCP_ESTABLISHED || oldstate =3D=3D TCP_CLOSE_WAIT)
>  			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-net-mptcp-=
misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org?part=3D1
