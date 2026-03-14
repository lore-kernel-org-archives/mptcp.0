Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63631F9B3
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773460724; cv=pass; b=ihzxabZSsSC79ef5hQQas9cG8lA0Y29auh87SMcQd2ftSFeDIpqdCNE9WLPJMm4vEFMcpWSrE0C1qvenUJL0VPE/sXxuQ+dRCFfdTkIWdFPJMENPjpKRVuwvWlUxS+p3NBkUu9K2i2k5pVOqwlQEVRQBpbZ1q3WD4t4Mzga5pyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773460724; c=relaxed/simple;
	bh=GcSrDIphKrI2//HgDsteTWBHlxHzmnPMjkm0w3xQYSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgzE5A2BXFp6A1K3/KqC5K5TCoOj6y/O45M9T5R3PpdOXR7G/ONXsDyIyMw+APiSfqSB0BQg530ZX30S5LNnwFI4D4cTsDasa9vyh6iCFiIruq/PAS44DP4zao6FHzaNX5SG3gJ7Ho7ejzLPuGlSfHxwhB+wZ8yjVIg9uEzf7gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXBi+ERM; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXBi+ERM"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a747448dso24934421cf.0
        for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 20:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773460720; cv=none;
        d=google.com; s=arc-20240605;
        b=VHUr5Dmdnw41nCTW0WujUOOA6M1KcSVTAyANEHoXJMC+7qFXdlZUvLGMqz83vck5mQ
         7SL4B0y6QaYg06GXVvc5OAs6sWtDLB+08y4ohXu8fbgKEaL0/0ICi3/J3bAbpuNq+GyC
         zi0UHNcjXov0oCaRsaUzbCreeeFhhsmJ1I/2FIqwTke0fcdwGEnw4XEHIRE9wJWjq3rg
         qIBxwUHwv/HBalIurqZLFloIthZmUMwBAMVJqoGHYLf7esBV/8/Izk39cjlkJ6ilb80D
         wJIp9l2kasibRtdSySGSZR/NjUfyerdNIDiX45LVPdwfBhOTOEU5CvGzB638XvANGvlS
         SC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OUQRi5vl7ger1FCyv6fx+Ok5M5QQpxd6KNaAJfpodDo=;
        fh=7jBmzNoYsiWJ2nP8sInvUo5GWFKLec28miQi020iJas=;
        b=bPY93WQpvw2VMMVj2qfaxBJeo8VSUVZJKKLNcYyU0ZdK/PuK2ZwugEshgwbfwp13yb
         X1Yb0X2kFU3yRLFFNdYubjCh0dPOLLAIeXYi5+g7hjlqoHivjtqpDj9J8o6HWqmwlimw
         oIYQZIGwdN9fgSDluReYG0X/6BR8cL9xUz1SrH0pVPm0gcVXSLdheEO42w4QQyC57IgA
         s51SuqQWcZ909o/9yeUr6ZpCcABP2pW6PmPeWziYT31OztZPkyRzk6M71DVMw6jqvO9C
         bdztnaP6MW/Yr1EG9Nc7KQ1iBTUyG1iB9tXH4czW37G44cNpjYD0NOfImQEs0XEpIez2
         EmCw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773460720; x=1774065520; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUQRi5vl7ger1FCyv6fx+Ok5M5QQpxd6KNaAJfpodDo=;
        b=YXBi+ERMqFdONJAq/mY+MrpxkT6ri7iMJ5zojxFB3We/cxxGCnZEOC6JS9yyev1I9I
         zyqC0Z5SC8F6G0T5iHdzlFO7hHwZ2fWpEwxEFnfloERMPS2h8s4T245iq176LlSGjvgj
         6DGIhmteLouKDQuSq9Kg8Wfc7rC4iTISMgOf3yjh9WmzyVJWMUdGeWx/ZinsRM+/5JYE
         FTaA6tQaQrxkpB/t7a/2TSojf5lRESQtMolmYbjrMhH1WIfanNZgLf+L1Tk9RqbacEHD
         8pYbwFxDvcu+gwn3BVQLKtgvaxTWYuA4j9CiQT3PYfQd1U6Ntq7i0/qLWlvdI7ICYYuC
         pBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773460720; x=1774065520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUQRi5vl7ger1FCyv6fx+Ok5M5QQpxd6KNaAJfpodDo=;
        b=aDg5AiA1fYvdn2voJIt/5zGMNo7PVbCTUfkUFpacWMNWt3Pb61L8OcB2ua2qZXw88y
         Sl43iE9y2IPuIOfaIjv/i5c2AGXOzosMHXllGrS1+dJsIuCrCPMm9f74B9ITJAUjXF8h
         CwGBsSF2C5weOM1iAwycY2WW3a4bGEu7hehqh8zNatSuXDsKlZAeDGyreRjLshB1jsov
         7SCDh60+uUcSvWbQ7a3AdUoH9sBY70OHM23BVzR47+y4Lp/AftC+Umtz4QdN3wouzTzY
         Ai/c0Ueh7uTvigcmXkXdTxUQGa7YmXP3zVbPBEcMPB0kx+HMlcKruZbS7aNIAUuBDEo6
         i7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCzFEXzb92kjKXpk0pTjVl7SnMQDvRKaKZo95AwjB2YtTheWsc3diYLN0uEWCc3X70B4hLZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTiZYv2mZtsRoBrcHM4LthA69y2GgtmkOZdAgZtWpVGVhGIskl
	d75T333RoahO/MmqaBKOVJ0JKaq722xdwDu97kTnak1D7/hWdR13GMq4jWfEqqmQmW2cI+XwOdj
	cgkvAn5xBGkoDDm6AKgPlqHPgEUR6oO54CJeOIE7d
X-Gm-Gg: ATEYQzzp9CPMtVizjQlcbHJaSwnH/AXDuamKz4X9J1c4Kf5mBFpTzHsUuk9AOpur35A
	2ljOxtF1v2A1ZGrJZrIHc0mVDG6fkfPvWBA/sD5Qo/Rr/s0niplU4OBdIP0mOhOxxf9WnSpR65u
	wHHwHr9zNGcoH5l3Fuq4y/ENyBvTJ4AvFQ51oOlWkTc+w/ZidnGcTlFcmkWxKE2MQQgHjOaDz3U
	aaDWDM92Oi0grmFY227P9dddNEaMTmNHL/whU+iPLFy18Av2RuQ2+ZsmV926vLc+OuWlErREXS0
	gLaTtg==
X-Received: by 2002:a05:622a:190c:b0:509:1a72:e332 with SMTP id
 d75a77b69052e-50957cb6dffmr75230961cf.16.1773460719740; Fri, 13 Mar 2026
 20:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com> <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
In-Reply-To: <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 04:58:28 +0100
X-Gm-Features: AaiRm523CLjVQFOb0ZjB_qB2iBvlpRhw-o_SCZwCK7X6f1nBivXOPbA_-nmtd5w
Message-ID: <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add tcp_rcv_neg_window.pkt
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

On Wed, Mar 11, 2026 at 12:09=E2=80=AFAM Simon Baatz <gmbnomis@gmail.com> w=
rote:
>
> Hi Eric,
>
> On Tue, Mar 10, 2026 at 09:54:58AM +0100, Eric Dumazet wrote:
> > On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > >
> > > From: Simon Baatz <gmbnomis@gmail.com>
> > >
> > > The test ensures we correctly apply the maximum advertised window lim=
it
> > > when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> > > is properly clamped to zero rather than becoming negative.
> > >
> > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > ---
> > >  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++=
++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_wind=
ow.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f=
3fd192ed2b59b0a4399
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > @@ -0,0 +1,26 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +--mss=3D1000
> > > +
> > > +`./defaults.sh`
> > > +
> > > +// Establish a connection.
> > > +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > > +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) =3D 0
> > > +   +0 bind(3, ..., ...) =3D 0
> > > +   +0 listen(3, 1) =3D 0
> > > +
> > > +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> > > +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> > > +  +.1 < . 1:1(0) ack 1 win 257
> > > +
> > > +   +0 accept(3, ..., ...) =3D 4
> > > +
> > > +// A too big packet is accepted if the receive queue is empty
> > > +   +0 < P. 1:20001(20000) ack 1 win 257
> >
> > We do not see the answer, it seems this test is not complete ?
>
> Actually we do not want to see an answer.  The packet won't trigger
> an immediate ACK (it is larger than the advertised window, but does
> not cause immediate memory pressure).
>
> When we then send a RST before the delayed ACK would be generated:
>
> > > +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq u=
pdate yet
> > > +   +0 < R. 20001:20001(0) ack 1 win 257
>
> We are in a state where rcv_wup, rcv_wnd, and rcv_mwnd_seq have not
> been updated yet, but we must still accept the RST
> (rcv_nxt =3D=3D 20001 > rcv_mwnd_seq, tcp_max_receive_window() =3D=3D 0)
>
> > > +
> > > +  +.1 %{ assert tcpi_state =3D=3D TCP_CLOSE, tcpi_state }%
>
> And we verify that we accepted the RST here.
>
> Given how subtle this sequence is, and considering the limited value
> of this test, I am also fine with dropping it if it is too fragile or
> confusing.

Sorry I missed your answer.

Ok then please use :

// A too big packet is accepted if the receive queue is empty
   +0 < P. 1:20001(20000) ack 1 win 257
   +0 %{ assert tcpi_bytes_received =3D=3D 20000, tcpi_bytes_received;
assert tcpi_bytes_acked =3D=3D 0, tcpi_bytes_acked }%

// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update y=
et
   +0 < R. 20001:20001(0) ack 1 win 257

  +.1 %{ assert tcpi_state =3D=3D TCP_CLOSE, tcpi_state }%



Then add my
Reviewed-by: Eric Dumazet <edumazet@google.com>
