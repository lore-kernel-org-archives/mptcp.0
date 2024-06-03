Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C112D210
	for <mptcp@lists.linux.dev>; Mon,  3 Jun 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421213; cv=none; b=SOttNnKX43nSh0NF+/8pwzXXtAB2YdM6ablkl0/dDPJ7ZIVYLXOATMsprv+huZBOca8Mj0XKOrXRbOZlzrv5xC39Kn5YJJ9sHmYi7JFbpBacw1I9YW1EuxjqcF293STphmtBvtVpGgLvjBMEMji68+DZzLyTTxjFd7K2TKFWHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421213; c=relaxed/simple;
	bh=ZM00yZhdUZbQwgMyHZIZJ1UP3o1I/SZy0IsztqNd6L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXim30cTN0c06tQukM/FHiQhpiWfJ+bR1dWhu5L+rCnmkomgKwOvp3yK8FK8b6MPlGm+1MJXV9j8gYWaKJRQQlg5AOGwMhb2ITCQjr1DJZrA8EN9k/8qvm7IJyt+cpCOY9CV+eNDY0x6rR8RVtmHSLjSIe4Z7YGZpDVc5RU/PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0MB6wxh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0MB6wxh"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a691bbb7031so100873166b.1
        for <mptcp@lists.linux.dev>; Mon, 03 Jun 2024 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717421211; x=1718026011; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUsHEgYLwi9mPIr/q9q9dBz6ihvAh5JXN+fvicM3xcM=;
        b=a0MB6wxhAcVC2/fkG1sZ34tMNzY5ndgCmjr5y0xOL/kc/9A1GvBSCSGgfIBqP4LSpD
         X42pISbMpGorTqQCJhlVqv1JEWPJS5r0Pf0YUzwSLA+qQxNu8zh+3wkUxWki/uxm8Q+b
         YSvoLKFVM/5QtrSH8775RDN9G410DNg7FoVGyhyvmOVtPuMM1bsdMcPuD1qQ2f+K6UMS
         2R2BKlocvnnyWDElYCPlIL/GMW9FQZw2MXZKidXy8lqfV2Bbd9Y17Z4ij9KvDMb6ccRO
         t6+8a9z+Xsd7ao60PiDy4iM8dGpToLhg/KoWk0TW46exHjsjqJXd22XuczMQGaPQqVlF
         uWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421211; x=1718026011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUsHEgYLwi9mPIr/q9q9dBz6ihvAh5JXN+fvicM3xcM=;
        b=r2EYd6U9F8k0EWagg053kgR65SdvbtoiSFY89ueNSERYyL0mGznlwPL4fA6FqkAqSU
         6NsT2VV0TCnc2McfONRU1vHTH5qUcfvupmj6eGhf3QTDpjUwS0x0KxZDVtpHb1LjSpFI
         5+Rtx/Ni88bary9ojxp8R+vRcp+gKz3K7sw5RI/y+5oCYgYU+rolEhvq7+pfophruDaz
         MBrtuSTHF9I28t9ZDWLdrPMaXcOD5IS+JRnIPZ+AOFl59uQp1gNHVDmMPTeOATUgLLci
         edVtMS6DNzjoJngjMACHS+kEdR4VKRVp9hjMLYRQ6ZplQ/6rp3ZHAKfJToDq1YXw02sW
         oMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDzz5hWIjFUnTaiuRiyhIZqq3/gpt/klMk9cbyqHJxIjD5xebNEf5n0iweKmAwJ1efMeqhT66wVukBl4V48IY9664bFFU=
X-Gm-Message-State: AOJu0YyY0jCUuv2UiLhQgCSvcv0H9+RxZ1bLukgTwFtDdQMtKU5pEWu/
	FzKYJrdbvSHcgLIE2cqXP0ka6i/vuHHVoYssHXJZ39ZIzRc1MBXZ3cZDHwz1urEG9LEr7rqOJRr
	/bz31OWC/U+u7i8XJAICznQIOeC4=
X-Google-Smtp-Source: AGHT+IHW9AA3rKOnHVlHU09vyfnmpr6TqZfW9sJiedTI2sYHJwKyb9Dva58QsQmxE8IhX2epqvK/kz5ShXge0HfZXJ0=
X-Received: by 2002:a17:906:154e:b0:a5a:51dc:d12 with SMTP id
 a640c23a62f3a-a681fc5d769mr770199666b.2.1717421210368; Mon, 03 Jun 2024
 06:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
 <20240531091753.75930-3-kerneljasonxing@gmail.com> <df99fb97-74ca-4b5c-9d5f-86466025a531@kernel.org>
In-Reply-To: <df99fb97-74ca-4b5c-9d5f-86466025a531@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Jun 2024 21:26:12 +0800
Message-ID: <CAL+tcoAa+8pEcW5C3jjU4cieHBm8PUWMKUR=hP8sqQbh1gmVug@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Matthieu,

On Mon, Jun 3, 2024 at 8:47=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Jason,
>
> On 31/05/2024 11:17, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like previous patch does in TCP, we need to adhere to RFC 1213:
> >
> >   "tcpCurrEstab OBJECT-TYPE
> >    ...
> >    The number of TCP connections for which the current state
> >    is either ESTABLISHED or CLOSE- WAIT."
> >
> > So let's consider CLOSE-WAIT sockets.
> >
> > The logic of counting
> > When we increment the counter?
> > a) Only if we change the state to ESTABLISHED.
> >
> > When we decrement the counter?
> > a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
> > say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> > b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> > from CLOSE-WAIT to LAST-ACK.
>
> Thank you for this modification, and for having updated the Fixes tag.
>
> > Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/mptcp/protocol.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 7d44196ec5b6..6d59c1c4baba 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2916,9 +2916,10 @@ void mptcp_set_state(struct sock *sk, int state)
> >               if (oldstate !=3D TCP_ESTABLISHED)
> >                       MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB=
);
> >               break;
> > -
> > +     case TCP_CLOSE_WAIT:
> > +             break;
>
> The modification is correct: currently, and compared to TCP, the MPTCP
> "accepted" socket will not go through the TCP_SYN_RECV state because it
> will be created later on.
>
> Still, I wonder if it would not be clearer to explicitly mention this
> here, and (or) in the commit message, to be able to understand why the
> logic is different here, compared to TCP. I don't think the SYN_RECV
> state will be used in the future with MPTCP sockets, but just in case,
> it might help to mention TCP_SYN_RECV state here. Could add a small
> comment here above please?

Sure, but what comments do you suggest?
For example, the comment above the case statement is:
"Unlike TCP, MPTCP would not have TCP_SYN_RECV state, so we can skip
it directly"
?

Thanks,
Jason

>
> >       default:
> > -             if (oldstate =3D=3D TCP_ESTABLISHED)
> > +             if (oldstate =3D=3D TCP_ESTABLISHED || oldstate =3D=3D TC=
P_CLOSE_WAIT)
> >                       MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB=
);
> >       }
> >
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
