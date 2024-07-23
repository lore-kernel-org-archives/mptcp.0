Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4D2561B
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772102; cv=none; b=Cc8F2+MyKLqjPEWMvOSbOV/TrcvTbOSyk8FEVgPKIR3bMXIVgl9CuG796kJTBX800bC5d28I7gw12YYK+XnH5lRVHgdxH1nq0as9jtxfQ37r21bND+0YMHVDEDgClP4iatS1WallUyI9VJ1T5bTGzOWKa3nX8Qn9G6NuRI0mcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772102; c=relaxed/simple;
	bh=5xVlqisSBJYMgU9MzkbYusXo6EHS+CLhw7wKUYkGMG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/8Qpnuegm3wFewLjWQYgKDhsJ/+MYq8b8m4u6VKsF6peHrmiaQmVVSXF7LOfd3Bg6sUA729OqHRmvoKA22lB2QcqNowLQx7deyGXlUVAeFhDB8Xo7Mc05FX7Y6KYz4XRw5EF3QtnRYABnFCMO601sYavERPufmxuJBGtZp6Rr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cYjfFFDg; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYjfFFDg"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d569902626so1946674eaf.2
        for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721772100; x=1722376900; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RbOzRw1HgFS5DEp3YsvL3ixVExK5DUcKmrah8c6zUo=;
        b=cYjfFFDgrVw5dMiL6CtaQUV47sCOQdYsYfb44Iuwlt5ngBj1zav6A3smLwR+zFYKE0
         2ZFMImOMLcDSYEj2NErwcEJnzUdB3QvdoD/GVtol4mywb89m3H/bYSILQzvpezbUnwOh
         p5cnKMtdhIZsVe/llroyRw+kLySOqfYvKf2PgnQNhRd/1A3E7blbbOUzmlQPR2cYkXf5
         AFViPdpIJxk4aJmSDGOQ6I2rbhWDItih0UM2nDRhgNBKKAFfZpMqaadgVntphECaWP5p
         fgb0ZRwSrBMDZRdu64llLbY30mXnA4bKyxol+Km3Il11gCtH9w+t+UU6EPbG/oKCQ7Jd
         VCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721772100; x=1722376900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RbOzRw1HgFS5DEp3YsvL3ixVExK5DUcKmrah8c6zUo=;
        b=JlSejFxY7qdCaXNU0cyqbR1TaDAcwe3ap8cHNAzePfu4+MTiiPTK9sxn+QSnx7gXz6
         hAluad4cFap5VJ+AiyGQYCx5sdBiSNLaAq9gq/sQX4LanKP3e1qljp5iwRVxNIGS4QPO
         kUZlBA+jKJ5BMQeHn46v357A1lA9AusV8Pyi5ZLffb9VHPgUV7T/gS+PrVLPEb3fTrsB
         PI+nIHsx/XZtHEWa678ZrEDMXV2gxCxjUShYmuXA3JUcL3SrY8/Oa+WVNyTQgY9VnJiG
         0DLS0yqLlN4SHgg63ypOTEX+/wAt/VjW9x4Aywc6XC9wD6XFKUorTfNjJNH0fSybvhZe
         DFUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUWuUK7BggXFRA8OdEsigcV8lDKEV6YekWiYVauwfW0xE4eub0HM54rxw/oE2HpCMPYoNS1AJ3CPANMr9nfnZTBpX48ks=
X-Gm-Message-State: AOJu0Yx9J03k4S4EnwZvKwyc6k/+HcJLRo5AbuGziE0Fnk12fm9TODFy
	W7DYvPZmPhnDLlQdfFyJO3ysq2qtw0f15lrTM6sltEIuyAp+UJ2QQgAQCpndT+DGscOOYVwt2md
	BhXL/U3G7Yr7pOqEM4LFOMJmi4Vm+VLwj+X3Q
X-Google-Smtp-Source: AGHT+IG52jqWawXgN2kcOVQKAVuGRKQsz6erICJGp/9Nf2OmyPDQUG4y71nh5l7MhmNmqRHohI8zQDyyM5Dy7lSVDY8=
X-Received: by 2002:a05:6358:297:b0:1aa:c73d:5a8a with SMTP id
 e5c5f4694b2df-1acc5b10dc0mr1273554155d.16.1721772099135; Tue, 23 Jul 2024
 15:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
 <CANn89iJNa+UqZrONT0tTgN+MjnFZJQQ8zuH=nG+3XRRMjK9TfA@mail.gmail.com>
 <2583642a-cc5f-4765-856d-4340adcecf33@kernel.org> <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
 <4558399b-002b-40ff-8d9b-ac7bf13b3d2e@kernel.org> <CANn89iLozLAj67ipRMAmepYG0eq82e+FcriPjXyzXn_np9xX2w@mail.gmail.com>
 <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
In-Reply-To: <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 23 Jul 2024 18:01:19 -0400
Message-ID: <CADVnQy=Aky08HJGnozv-Nd97kRHBnxhw+caks+42FUyn+9GbPQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:09=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 23/07/2024 18:42, Eric Dumazet wrote:
> > On Tue, Jul 23, 2024 at 6:08=E2=80=AFPM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>
> >> Hi Eric,
> >>
> >> On 23/07/2024 17:38, Eric Dumazet wrote:
> >>> On Tue, Jul 23, 2024 at 4:58=E2=80=AFPM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> >>>>
> >>>> Hi Eric,
> >>>>
> >>>> +cc Neal
> >>>> -cc Jerry (NoSuchUser)
> >>>>
> >>>> On 23/07/2024 16:37, Eric Dumazet wrote:
> >>>>> On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
> >>>>> <matttbe@kernel.org> wrote:
> >>>>>>
...
> >>> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> >>> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
> >>>    +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here
> >>
> >> I'm sorry, but is it normal to have 'ack 1' with 'sack 0:1' here?
> >
> > It is normal, because the SYN was already received/processed.
> >
> > sack 0:1 represents this SYN sequence.
>
> Thank you for your reply!
>
> Maybe it is just me, but does it not look strange to have the SACK
> covering a segment (0:1) that is before the ACK (1)?
>
> 'ack 1' and 'sack 0:1' seem to cover the same block, no?
> Before Kuniyuki's patch, this 'sack 0:1' was not present.

A SACK that covers a sequence range that was already cumulatively or
selectively acknowledged is legal and useful, and is called a
Duplicate Selective Acknowledgement (DSACK or D-SACK).

A DSACK indicates that a receiver received duplicate data. That can be
very useful in allowing a data sender to determine that a
retransmission was not needed (spurious). If a data sender receives
DSACKs for all retransmitted data in a loss detection episode then it
knows all retransmissions were spurious, and thus it can "undo" its
congestion control reaction to that estimated loss, since the
congestion control algorithm was responding to an incorrect loss
signal. This can be very helpful for performance in the presence of
varying delays or reordering, which can cause spurious loss detection
episodes..

See:

https://datatracker.ietf.org/doc/html/rfc2883
An Extension to the Selective Acknowledgement (SACK) Option for TCP

https://www.rfc-editor.org/rfc/rfc3708.html
"Using TCP Duplicate Selective Acknowledgement (DSACKs) and Stream
Control Transmission Protocol (SCTP) Duplicate  Transmission Sequence
Numbers (TSNs) to Detect Spurious Retransmissions"

neal
