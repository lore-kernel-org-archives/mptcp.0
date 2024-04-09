Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF813D886
	for <mptcp@lists.linux.dev>; Tue,  9 Apr 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679020; cv=none; b=u/lUmMLvsEFRrxaQ3QC/oNZlG64+5AVdajEw5PnamGNu61nnNDTflNKUx70V3x9XQzRpuADZAfxkkYI4hJvPw8QcvmwWVA4jMi4atAcXUPcgn5aAUc8jM2HXO77QoEuQVo+YgteZvxPhWnLdktPIrBr8ke/0xHzbczTYcvk2xwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679020; c=relaxed/simple;
	bh=MSoIQx62J43Bccp2Cn+Ph43OT2HPJUyspXTcIIpIE5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Be+2afMHs66ynw0Cu1EN3HVaf3FmE3P8v9Xhg2mcDXVJw04p+4i7mm8xzk8bb/ORWdVBKBAEeLjVeu0L8BKlC0ZKJ4llOqvwT21YIH0J5aiajudDgtPunng4kYe26gOnHZjHwdT+WDE3sjcE/FICVOMiSgWAkwiXty0A+BYRq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+26kGy7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+26kGy7"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e449187fcso3395467a12.3
        for <mptcp@lists.linux.dev>; Tue, 09 Apr 2024 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712679017; x=1713283817; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpd1DqvxQ9ZHc8MYTvcDLh00MD3SMaBbuoB61REVNfM=;
        b=Q+26kGy7UUQeudlGshrsinxh/S+VJ6ct7HoK8oQXDEK/vSMKS1MdWyYgUdNB4ZZrfx
         vOhobkrx5uRUix2+5vhJwCvUM+LvTHVbXRFNjsuc40ZyHi0dsGClN27YVboIOPZMrODc
         LPRXrhzfRpciseYI9hewEw5HLQz7vV4jDmGJfSIwEXbqFmbkpGaMWmHpUBd+7fE8FHrS
         4sh8clarmfuD13w3CxWrXvGaeaSilZv2pCW+u6PqQB7naXv70K7p0NM9InKfF7XMVvYT
         mps+uO1yCO104Aro4Ch+qBb3GPCr7pM7Z7c9WBQmQcyhvZt+wNv9wllfBc+v86QriuWx
         0Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679017; x=1713283817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpd1DqvxQ9ZHc8MYTvcDLh00MD3SMaBbuoB61REVNfM=;
        b=Eu4Oi0cVkhM+ymZgQFBVSjH4i4WZ1MNaQUT3VM83f2CES/F8l/KLZWIY0cGh9pmqeA
         8dDkNOeY4HhvFJcz80v2e1pQJnJuSJ/pN9uxUphYiW95beLm4IwvM8NEVnLIfmmhCGsx
         4XoKIAzFlzfEXOZH2A617pbw5bF3Hl23iUrPBxub0BZfL3lnmTAt/LewOjRYSvx56l3L
         Cf+14xUPyPifswW1B9E2Vz/t+xMyTHLqC3ZMg3yRYWHYIYXphomqNpWNATKRBWHHhzmo
         CPGmMnQyZ/gIuIsJC4vcVdFK2Otrau24w6Nv6nGQSnP6feN09w+y06FqAY2afwj0eF3v
         bMfA==
X-Forwarded-Encrypted: i=1; AJvYcCXRDrAEGIzOxajRxG0wgX4ayoaR5MnC/sEpbPJw8kOdltM/O9Wb2tAmEs0Bq/0+EA4UWEZ/dGNuC9+zYdE9/BJHNyQ9spk=
X-Gm-Message-State: AOJu0YxnA/AGHsA7Ag9mZb2ks6HbEiW+vPC7qPcmG6m7mdUJsE689HcI
	cxxPmaZrCib6FXI2lEs1S0wrNvruVV2lbqAHOwzhosgnVZKr+qLkzq0+MPM6mhLJly01aG88oKJ
	aJ2gTcvOEf7dzZahkuNdWzq0eD2g=
X-Google-Smtp-Source: AGHT+IHadltt04nVaT9cOqPal59ZeRU7cfNxHDh7aWUUUOtif7ZYwxhz05jkVV2jQHMF+AZUmQoCrK4WlcZ0313LLEE=
X-Received: by 2002:a17:906:46d5:b0:a4e:cd5c:da72 with SMTP id
 k21-20020a17090646d500b00a4ecd5cda72mr6812069ejs.63.1712679016863; Tue, 09
 Apr 2024 09:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
 <20240409100934.37725-7-kerneljasonxing@gmail.com> <20240409113846.5559359a@gandalf.local.home>
In-Reply-To: <20240409113846.5559359a@gandalf.local.home>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 10 Apr 2024 00:09:40 +0800
Message-ID: <CAL+tcoCkvNmC6iFjuG90--3jBp=VD6BfQC5LBEGr4M=SvT-aEA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] rstreason: make it work in trace world
To: Steven Rostedt <rostedt@goodmis.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, mptcp@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Tue, Apr 9, 2024 at 11:36=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue,  9 Apr 2024 18:09:34 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> >  /*
> >   * tcp event with arguments sk and skb
> > @@ -74,20 +75,38 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
> >       TP_ARGS(sk, skb)
> >  );
> >
> > +#undef FN1
> > +#define FN1(reason)  TRACE_DEFINE_ENUM(SK_RST_REASON_##reason);
> > +#undef FN2
> > +#define FN2(reason)  TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
> > +DEFINE_RST_REASON(FN1, FN1)
>
> Interesting. I've never seen the passing of the internal macros to the ma=
in
> macro before. I see that you are using it for handling both the
> SK_RST_REASON and the SK_DROP_REASON.

Yes, I want to cover two kinds of reasons and then strip them of
prefixes which can be reported to userspace.

>
> > +
> > +#undef FN1
> > +#undef FNe1
> > +#define FN1(reason)  { SK_RST_REASON_##reason, #reason },
> > +#define FNe1(reason) { SK_RST_REASON_##reason, #reason }
> > +
> > +#undef FN2
> > +#undef FNe2
> > +#define FN2(reason)  { SKB_DROP_REASON_##reason, #reason },
> > +#define FNe2(reason) { SKB_DROP_REASON_##reason, #reason }
>
> Anyway, from a tracing point of view, as it looks like it would work
> (I haven't tested it).

Sure, it works. One simple test if you're interested:
1) Apply this patchset locally
2) add 'trace_tcp_send_reset(sk, skb, [one reason])' in the receive
path, say, somewhere in the tcp_v4_rcv()

The possible result can be seen in the cover letter. I list here:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
        skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
        skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNO_SOCKET

>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

>
> -- Steve
