Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FAB65F
	for <mptcp@lists.linux.dev>; Mon,  3 Jun 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427134; cv=none; b=uT11/e1kHtgbi5wHsqXdiES8+elVP60lqKS2zAB/I2OVSwUJKeheaphD/nYoTxQv+8L/8gFCVohQP1EuZJFiamBwVmEmvVmSnKjgWIM+UNx87Ok2nQvO2eOor/tPo5H/Szp9aeUU2cAZvaELWbGVmo8GUI68KLmaIz2dJVEOuYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427134; c=relaxed/simple;
	bh=FxMQkPWYiU3Qctd0yp52JxmWJ77zyZmAQd/lA5vIazg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LT5Cjt5X9O1d2HJbN/FR9Iq+IAhSmq8tnobP+y4+J3iDPo3UcvNrLcBz9LoTwHU1tYMIQ0ujl0YK2iJil0e5BNQgTKyN8W7dRKB75MIYfvAZU8+hAG5Jhtz/u5I5JRp3e3aYKyHYX9Ty8NQDt49/ud3qdl15NZBIKVu6RRWJauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrZISuQi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrZISuQi"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68c2915d99so3199066b.2
        for <mptcp@lists.linux.dev>; Mon, 03 Jun 2024 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717427131; x=1718031931; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KarSyaGJNitul7/bvq/KlC0uYBjYgORXo+gGjOouVw=;
        b=mrZISuQiJ/iQmuL9NUQeP+cP6vFa8YqHO+QaKCrboIHdLXh0BZYsJV8Rwkpv6uDxI0
         pMj6iAheu5n6VmbI2TufRAYid5mcaGE97QrPPW7Dm29ZHO5dgTjvvI+JuWtFxw2lOZvo
         IDdfLvH8D+eMuhJHw//7O2tk1nMuwTAfS3TcxyXt3PHRM1a7heQrWNpI4qGUDgtEqigb
         Hb2ksoTpsJZvATMJALYAVmniOkOEJ7wQacSq72EtwOEPouIEZsMfPZSdk7GKEVnXNRIl
         18VhQqGXViBfXzfsIU6FRqOWSxlsZ5clKsK5xwn4t8iB2RCtpq1xZiYtluyhkbpJZPTs
         HjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717427131; x=1718031931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KarSyaGJNitul7/bvq/KlC0uYBjYgORXo+gGjOouVw=;
        b=U6CzVtr8msWH3QAktf4MNvWvZpjn8EuLGTYBOYrYzrHiRQm+3s5EUx1PzwXVmtAK0o
         H+VsbdqPthpsalyvjaGAFub8u/Dp0PY84+P3TZL5s6aH41C6j2f7FRntU2nULJd/TFw3
         Xc2oD4KRZ5fXCtOhO5RmDioeHqxOE7AgVsEhQDKONo/V45I6M7+ulXm9cQk170+yQGCT
         pRofNhwSXEgkLmmkRtN+YTA2TdCTcQ1dG5mADsk0FYNuZ2ljE/o7FcNvO6Rjkl8Osnfj
         lZy0QQ+SRgwequjtOt3o5YxOz256P+6J78DDt+Q5BhLE3hlkBJAGUCVr4gxcmceUa6j/
         jNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVOB6Kk7SbmEndMcVMbxvw0wR3t+I1n98XXH83horQMpVEKEbMUgBRiFQvmZTUU42hgVSzzwOz8tKu5Z9DWQSc2t7O68s=
X-Gm-Message-State: AOJu0YzWS9daI1h1jEXDR5NRInoDiV9nP4LPN+vwuvmEAU7QwgdjAxdd
	VFxubISrMtQjHrGPPDxXxarDbcIPZPVJFXuurad3WNxKsrUB3Mv/ssDNzn9xOi4W7O71j0m1K65
	0fhwRDP8NRc/cLmEngxbAf41L07Jdsg==
X-Google-Smtp-Source: AGHT+IFnTF0oAFItA5uz6g29Qz/dhqqwFCBQ5Sr13fTuSVNvSnSXA1b/ADsy9a1dv2fanzo4+lDDBBRX8I/kFZBPgcQ=
X-Received: by 2002:a17:906:36cc:b0:a68:b557:76f5 with SMTP id
 a640c23a62f3a-a68b55779c1mr366928266b.69.1717427130508; Mon, 03 Jun 2024
 08:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
 <20240531091753.75930-3-kerneljasonxing@gmail.com> <df99fb97-74ca-4b5c-9d5f-86466025a531@kernel.org>
 <CAL+tcoAa+8pEcW5C3jjU4cieHBm8PUWMKUR=hP8sqQbh1gmVug@mail.gmail.com> <80acd903-3cde-4232-8a78-ce20a3e746fa@kernel.org>
In-Reply-To: <80acd903-3cde-4232-8a78-ce20a3e746fa@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Jun 2024 23:04:53 +0800
Message-ID: <CAL+tcoD_JfOMvwGCN=6pNMyBGfUJiVio1RDEuoSQhSjLnPeJxQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Mon, Jun 3, 2024 at 9:57=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Jason,
>
> On 03/06/2024 15:26, Jason Xing wrote:
> > Hello Matthieu,
> >
> > On Mon, Jun 3, 2024 at 8:47=E2=80=AFPM Matthieu Baerts <matttbe@kernel.=
org> wrote:
> >>
> >> Hi Jason,
> >>
> >> On 31/05/2024 11:17, Jason Xing wrote:
> >>> From: Jason Xing <kernelxing@tencent.com>
> >>>
> >>> Like previous patch does in TCP, we need to adhere to RFC 1213:
> >>>
> >>>   "tcpCurrEstab OBJECT-TYPE
> >>>    ...
> >>>    The number of TCP connections for which the current state
> >>>    is either ESTABLISHED or CLOSE- WAIT."
> >>>
> >>> So let's consider CLOSE-WAIT sockets.
> >>>
> >>> The logic of counting
> >>> When we increment the counter?
> >>> a) Only if we change the state to ESTABLISHED.
> >>>
> >>> When we decrement the counter?
> >>> a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT=
,
> >>> say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> >>> b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> >>> from CLOSE-WAIT to LAST-ACK.
> >>
> >> Thank you for this modification, and for having updated the Fixes tag.
> >>
> >>> Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")
> >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>> ---
> >>>  net/mptcp/protocol.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >>> index 7d44196ec5b6..6d59c1c4baba 100644
> >>> --- a/net/mptcp/protocol.c
> >>> +++ b/net/mptcp/protocol.c
> >>> @@ -2916,9 +2916,10 @@ void mptcp_set_state(struct sock *sk, int stat=
e)
> >>>               if (oldstate !=3D TCP_ESTABLISHED)
> >>>                       MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURREST=
AB);
> >>>               break;
> >>> -
> >>> +     case TCP_CLOSE_WAIT:
> >>> +             break;
> >>
> >> The modification is correct: currently, and compared to TCP, the MPTCP
> >> "accepted" socket will not go through the TCP_SYN_RECV state because i=
t
> >> will be created later on.
> >>
> >> Still, I wonder if it would not be clearer to explicitly mention this
> >> here, and (or) in the commit message, to be able to understand why the
> >> logic is different here, compared to TCP. I don't think the SYN_RECV
> >> state will be used in the future with MPTCP sockets, but just in case,
> >> it might help to mention TCP_SYN_RECV state here. Could add a small
> >> comment here above please?
> >
> > Sure, but what comments do you suggest?
> > For example, the comment above the case statement is:
> > "Unlike TCP, MPTCP would not have TCP_SYN_RECV state, so we can skip
> > it directly"
> > ?
> Yes, thank you, it looks good to me. But while at it, you can also add
> the reason:
>
>   case TCP_CLOSE_WAIT:
>           /* Unlike TCP, MPTCP sk would not have the TCP_SYN_RECV state:
>            * MPTCP "accepted" sockets will be created later on. So no
>            * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
>            */
>
> WDYT?

So great. Thank you. I will update it soon.

Thanks,
Jason

>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
