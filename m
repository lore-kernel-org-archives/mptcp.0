Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5A3E95B6
	for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128475; cv=pass; b=jv1lB7sb26rPu8qlkIr2jFc95rFygw++dj/YPoLT2YQqdLS8wPX0yn7IZVoohHzuXaQi9XPGKnpgTj+CxkzzLNM1KwDVgIrxWcqu+J67Dw1VjqES/t60plcSf3OvXHLc5pFZCsSTe37QLomvannfG4QKu3tdS1C92KvQowsHJ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128475; c=relaxed/simple;
	bh=7cTgaURun945ZBxkV8bmKWLaXe5u+DBTf6pF7YLrF4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NL7lCthdJW0J9Yj0mqYIvV6svnds3Leb8gdCKHafYqlY1bqRI0rvpiYoFNnbVWKLmULoEuSe0zg/27HCdKY/HJIS+FsnbQmSrU1QStk8AvZh5SEccCN4coi4Hv1XUgcgfSiBAJdVWfU+0PJxoC/biuzNwmu+O7Sqz1A5m3tTNrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bm7SSANV; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bm7SSANV"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5090c27d3f6so26608841cf.0
        for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 00:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773128469; cv=none;
        d=google.com; s=arc-20240605;
        b=F27WQKg+pduN7fNwxxoqYDMV5jL/DgADTiFi7PwYyfNC1OkALzIGtpNXbeHMTZZfTM
         LgvsN9Xz26Rjz84aWjHYF68MBrscMYtm4BDpwDXVsBlg+YZiMuVRAVJNUDMIu4QQPonu
         QMzhIe24hfNkLXp2xPs1dLkDQC5ZQGn/R1MWso5x9cUEhImV0yvym9gEgmE8HpEGrXju
         vKLmWvNXV/YQX0w3a5VB7/WKIlnZlTwvzZHACF5ELkYxc0yCI9KbSa+g1b1QK4lGeE1N
         D27JUrfucya4J8Jhcb+6hoZIrjKKNixTEQBwWM5gDl83VTm3ODpduicZXllMG5o0rYnw
         9buQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rcMzOrru+dNP0H3b9Nuh0ONkl84RLF9HUfefvP22L6g=;
        fh=Oq0+SHfsdroZwfQ8qyHKJL1Z685puZraVF/JcdXlHiQ=;
        b=gpEPVXz5NSGbmYm8MB4pfOALixI3zw3Cuwntd1pluHRKc1Sc0pFFxuTGeIIjPNIYlQ
         SLo1uqbSQ3x4KftRwQXj7MpFp0cnyIGpz/zzxtuXNasNgIwz1Ny8N7xeCG2bstXh6iZW
         SSerkMjcRzjjiy1fbAh8F9gM0pHqjzXx+uRs3GIXrCLlXoAbuyIQ+wUFCXvejr/VqxFN
         sR33lB0pe86NLGNq8UZkIQfWn70MecKG2lCNfm2ONQyZjMBOEaW6mHfd18LALhzBY3cd
         Wikk4hlyTDXxpFrXNowks+AOzZ7elK6MC0OY3j7kmRQeB6qUY8n4hYIIMvsv0e88TLKV
         zDaA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773128469; x=1773733269; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcMzOrru+dNP0H3b9Nuh0ONkl84RLF9HUfefvP22L6g=;
        b=Bm7SSANVkj8er+V9T2PkWHtXEK5zW/JHeQr5CvUk8LdgT+rGih1e0BlswIeUvv5QL6
         KmewgyJ+gTr7X90StcZWbgKWyP2kLN+0m7+yL6jVW/g30B9n2ZO+qLjOj4aJtVZunbbQ
         ywYTZSz/w14La5utZ0+yLCA/nhwvIqJj6JVD2NAGCEbqHD8MzpehrhzWzU1scrTg1Taa
         efQIl7UU6ez4cThFRS47FvNly5DLoYRGyit6rk3B66R7qjNJJ5Kml5VaAJInrahWKtB5
         rU2sJo+6pzKvKL0A+YqeAXg0iSqWba74Ga2UjBFCbeUoaq0K3BqydH5b40X4Cnv8lbKd
         1HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128469; x=1773733269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcMzOrru+dNP0H3b9Nuh0ONkl84RLF9HUfefvP22L6g=;
        b=oMFSQjpB353n5HUYw6/jcHEH9bQvuUHM0V3YvV60k6jS3zyN1S3sMLs/cWRCMSN7OC
         HCl779ZWFEvEGcm7VNjGCer9J4lgsAxJtZPTO6vm0nwyRZ0zX94BtWGCWIrH9GOhXKDi
         5KqVloibT84zOQV4RjEQ7FXLRlgiAw26dtu+vxdT8sL9TnY3fILzOBtVa684GX91czhv
         m48pq66TbOJ7nth3fjTL6/hXgpr3N+YwoXHk7mxchz2MCZiuFc+6xWH19INSlkxBwD1E
         nGpND9Wxpsja5GNeANrv0YUybMplhRmKnj7ja5sYk7Ok553K0ZqbuyVRSXO/IWAM9Y1R
         OYIg==
X-Forwarded-Encrypted: i=1; AJvYcCWTwWxMZ3ZEfey8mspAnjJCbvfBBiRHwTgqd0OV8r1qdnUjY34OoKEsiAu6WrCOHvn9BtzB6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeENp75nU70VLWp5SKIeuSBz5PgvEgqAiSpOhKoHUqsPNvgTs1
	60Yyz8TOdcLF3PpAaaHy7XooHxI7xU9cCrjQMYSz6oCn6UhTmR9+ChYJHiMr0xw5bB0WP4JTZ4o
	R5NT+bGZXKU7tKvIIyxAkXnlvfbPBDbzWfSzNndaU
X-Gm-Gg: ATEYQzwZlcDy1z3+cmA00mvPNDhGvjBBMTvZ91eHKEKYL0psXi5WwiSEzqU6k14yzrV
	O3wE4MruK7UP3hENQi/gZlodEAfRGZ3BCJ04M+UH/AV9wpz/KxLMKoOftR7NNyZrRHFCnpW9nlQ
	WV8P06uVwi6uNRTDt0t9R20ctbHfCnAfxWLJHTZvAozgpBACp+JLPWPPRFinNCH82egxVCNXYwh
	s8ogUD6yXZy+mYywS6p82GlPLI6gXFvHIK3aGunTXMfl5JjOpn8MnBJMVqFzS+C9BoMEOK7kElM
	mS2iPiQ=
X-Received: by 2002:a05:622a:144c:b0:509:1d55:6368 with SMTP id
 d75a77b69052e-5091d556a83mr65534491cf.39.1773128468646; Tue, 10 Mar 2026
 00:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
 <CANn89i+38t+PpB5duS_-FX_=PwyCQaN2HYohocJBAvZ7Cd8-KQ@mail.gmail.com> <aa8S5pEbxXIG5oZQ@gandalf.schnuecks.de>
In-Reply-To: <aa8S5pEbxXIG5oZQ@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 08:40:57 +0100
X-Gm-Features: AaiRm51UmLT8Xio3yOAS3_qG-3b3ZlXXtISzZ5JqQOuDaTGLlV85GE2K7N5HJFc
Message-ID: <CANn89iJeVSfU3_Ub023j5mo5g=bTxTw_A+5-dPw59DaXFrLmDA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window retraction
 receiver requirements
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 7:35=E2=80=AFPM Simon Baatz <gmbnomis@gmail.com> wro=
te:
>
> Hi Eric,
>
> thank you for the quick review.
>
> On Mon, Mar 09, 2026 at 10:22:39AM +0100, Eric Dumazet wrote:
> > On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > >
> > > From: Simon Baatz <gmbnomis@gmail.com>
> > >
> > > By default, the Linux TCP implementation does not shrink the
> > > advertised window (RFC 7323 calls this "window retraction") with the
> > > following exceptions:
> > >
> > > - When an incoming segment cannot be added due to the receive buffer
> > >   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
> > >   handling of extreme memory squeeze") a zero window will be
> > >   advertised in this case. It turns out that reaching the required
> > >   memory pressure is easy when window scaling is in use. In the
> > >   simplest case, sending a sufficient number of segments smaller than
> > >   the scale factor to a receiver that does not read data is enough.
> > >
> > > - Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
> > >   allowing the tcp window to shrink") addressed the "eating memory"
> > >   problem by introducing a sysctl knob that allows shrinking the
> > >   window before running out of memory.
> > >
> > > However, RFC 7323 does not only state that shrinking the window is
> > > necessary in some cases, it also formulates requirements for TCP
> > > implementations when doing so (Section 2.4).
> > >
> > > This commit addresses the receiver-side requirements: After retractin=
g
> > > the window, the peer may have a snd_nxt that lies within a previously
> > > advertised window but is now beyond the retracted window. This means
> > > that all incoming segments (including pure ACKs) will be rejected
> > > until the application happens to read enough data to let the peer's
> > > snd_nxt be in window again (which may be never).
> > >
> > > To comply with RFC 7323, the receiver MUST honor any segment that
> > > would have been in window for any ACK sent by the receiver and, when
> > > window scaling is in effect, SHOULD track the maximum window sequence
> > > number it has advertised. This patch tracks that maximum window
> > > sequence number rcv_mwnd_seq throughout the connection and uses it in
> > > tcp_sequence() when deciding whether a segment is acceptable.
> > >
> > > rcv_mwnd_seq is updated together with rcv_wup and rcv_wnd in
> > > tcp_select_window(). If we count tcp_sequence() as fast path, it is
> > > read in the fast path. Therefore, rcv_mwnd_seq is put into rcv_wnd's
> > > cacheline group.
> > >
> > > The logic for handling received data in tcp_data_queue() is already
> > > sufficient and does not need to be updated.
> > >
> > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> >
> > ...
> >
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index f0ebcc7e287173be6198fd100130e7ba1a1dbf03..c86910d147f2394bf414d=
7691d8f90ed41c1b0e3 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -293,6 +293,7 @@ static u16 tcp_select_window(struct sock *sk)
> > >                 tp->pred_flags =3D 0;
> > >                 tp->rcv_wnd =3D 0;
> > >                 tp->rcv_wup =3D tp->rcv_nxt;
> > > +               tcp_update_max_rcv_wnd_seq(tp);
> >
> > Presumably we do not need  tcp_update_max_rcv_wnd_seq() here ?
>
> When we don't update here and are forced to accept a beyond-window
> packet because the receive queue is empty, we can reach a state where
>
>  rcv_mwnd_seq < rcv_wup + rcv_wnd =3D=3D rcv_nxt
>
> I noticed this case when instrumenting the kernel and got violations
> of the invariant rcv_wup + rcv_wnd <=3D rcv_mwnd_seq.
>
> So, while not strictly needed (tcp_max_receive_window() would still
> be 0 as rcv_nxt > rcv_mwnd_seq), I opted to include the call here to
> keep rcv_mwnd_seq the actual maximum sequence number at all times.

Fair enough, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>
