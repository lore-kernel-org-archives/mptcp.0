Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5F3A1B6
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411043; cv=none; b=KyRHpxm9jsWQT8H3a2XB0fFkZ0KgNS9dKcccpDklRPU/TeAy/oTZVAdPzGTgglweujkR2ZgDr8csEvlC38HW80CK8AGqdnCpxrVMGjrydODQn8sJ5PwMmiAXljWR6ieGMEYWL0GKdsxS1ick0k93gLl2m5Ja55ZCYOpTm+w+GzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411043; c=relaxed/simple;
	bh=DCA4ZXGfA6CF2fRmBG48aqBKpyuyrXsqeWgyw2L4DBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic7HC2jyN1360pwgO5aaJ2E8/CAwrffXszR+QOrrcEnRFcDXrcdj3j9nBBeMG+QesRZdgsuLxOSkPzEatopU5FV7ZLryNFaKriJhunBIkc/Negpifaq6MMgX228lOORXXkCrqrGezAr3PcbwfO1xeLEo90Xm0mLcBFLEk+/DWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ7JqB8k; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ7JqB8k"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5568bef315so87434966b.1
        for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713411040; x=1714015840; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxhTyKTIE0qzJxTrsheENDHgXb5i9dLfwKH5M/LulNs=;
        b=YJ7JqB8kw/FpncrO1GQpurT4+cXSa3CuyQT47nICcmjI6QnMypN2I7H1LD+G53xKN0
         Urb6xGt3xC1qxpwa1oD5+FQ0CLfz3ZYaPwSw9Hh31tQhi0txXF965tHHlT1S8+g4D6b2
         iHabwm6IjfVMQ0l/pfiFnezfjxOqqYc5ky4T3s0tmwLIX2VVGeAkKi0MnRd5D4WQxsyS
         tD8qp5UxtnFUX/Ba05DRFKqNDDOHTv8uHOmtNoyoDvxRJHRvUs2DfiAXqjbxGVOZ5Eqm
         RlSCRoaOaXyzFvZeXuUo/obogUjIcN0yGXheqL0e390P1nsQtksZwjaMZCFTsDFHvqgn
         TaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713411040; x=1714015840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxhTyKTIE0qzJxTrsheENDHgXb5i9dLfwKH5M/LulNs=;
        b=nAElUxJJQwKo0JhM9l2dR2I5njddlokRGlmbJI1LZgbbkJF/CycuHMarnjK8qFy03S
         WQdaBhys2cuj4obBb4cOZbr2KM3qaE/KLwBviCOpbcp3KBI9DDuX3Pl5JhwtCO7Gb/bF
         FfadLnLigMxRO9UIKwkRLOI3/CPyp+0GAHHtIK0Yjop2epzTqYlscSVyUEBHkcvSFobe
         eOAjPTujsy1R5jGCUtY6R/MLb76PbP0CyinCcKAteFyYIAacyRwWhNq4pdVEvdQzxyql
         LjlvG0HwyAZOQUYjoBrphflUuMOo2YbAnXRxFCVt1IpBR+dYIk3EmV8D3/ZenLQIOSQq
         Dlzg==
X-Gm-Message-State: AOJu0Yw7Ir5LHgCN/mIa87HHdoALy7BxPMw61prVKNEQLyPQ7vhyBfK7
	+bLrDH624VB2ny8f+0esa/xxuMcRoa71ApNpD6ORkz+YnI06Oz99AIMvxtePBhOQ7rPmsRAGp1b
	yDFrmRSt9htNvnkbw/0RLJ/1C38A=
X-Google-Smtp-Source: AGHT+IHIXEmxxBrJTy9464N8x83VfqQQwELj66FQKhLRL51cqDV42VJTFPlEdcZJ6x4RQa4TVQPrGaadlUpan2ko3zc=
X-Received: by 2002:a17:906:161a:b0:a52:3984:148f with SMTP id
 m26-20020a170906161a00b00a523984148fmr686853ejd.36.1713411040348; Wed, 17 Apr
 2024 20:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 18 Apr 2024 11:30:02 +0800
Message-ID: <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:51=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In production, there are so many cases about why the RST skb is sent but
> we don't have a very convenient/fast method to detect the exact underlyin=
g
> reasons.
>
> RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
> and active kind (like tcp_send_active_reset()). The former can be traced
> carefully 1) in TCP, with the help of drop reasons, which is based on
> Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
> RFC 8684. The latter is relatively independent, which should be
> implemented on our own.
>
> In this series, I focus on the fundamental implement mostly about how
> the rstreason mechnism works and give the detailed passive part as an
> example, not including the active reset part. In future, we can go
> further and refine those NOT_SPECIFIED reasons.
>
> Here are some examples when tracing:
> <idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
>         skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNOT_SPECIFIED
> <idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
>         skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNO_SOCKET
>
> [1]
> Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10Q=
N2WBdr+X4k=3Dw@mail.gmail.com/
>
> v6
> 1. add back casts, or else they are treated as error.
>
> v5
> Link: https://lore.kernel.org/all/20240411115630.38420-1-kerneljasonxing@=
gmail.com/
> 1. address format issue (like reverse xmas tree) (Eric, Paolo)
> 2. remove unnecessary casts. (Eric)
> 3. introduce a helper used in mptcp active reset. See patch 6. (Paolo)
>
> v4
> Link: https://lore.kernel.org/all/20240409100934.37725-1-kerneljasonxing@=
gmail.com/
> 1. passing 'enum sk_rst_reason' for readability when tracing (Antoine)
>
> v3
> Link: https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@=
gmail.com/
> 1. rebase (mptcp part) and address what Mat suggested.
>
> v2
> Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
> 1. rebase against the latest net-next tree
>
>
>
> Jason Xing (7):
>   net: introduce rstreason to detect why the RST is sent
>   rstreason: prepare for passive reset
>   rstreason: prepare for active reset
>   tcp: support rstreason for passive reset
>   mptcp: support rstreason for passive reset
>   mptcp: introducing a helper into active reset logic
>   rstreason: make it work in trace world
>
>  include/net/request_sock.h |  4 +-
>  include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
>  include/net/tcp.h          |  3 +-
>  include/trace/events/tcp.h | 37 +++++++++++++--
>  net/dccp/ipv4.c            | 10 ++--
>  net/dccp/ipv6.c            | 10 ++--
>  net/dccp/minisocks.c       |  3 +-
>  net/ipv4/tcp.c             | 15 ++++--
>  net/ipv4/tcp_ipv4.c        | 14 +++---
>  net/ipv4/tcp_minisocks.c   |  3 +-
>  net/ipv4/tcp_output.c      |  5 +-
>  net/ipv4/tcp_timer.c       |  9 ++--
>  net/ipv6/tcp_ipv6.c        | 17 ++++---
>  net/mptcp/protocol.c       |  2 +-
>  net/mptcp/protocol.h       | 11 +++++
>  net/mptcp/subflow.c        | 27 ++++++++---
>  16 files changed, 216 insertions(+), 47 deletions(-)
>  create mode 100644 include/net/rstreason.h
>
> --
> 2.37.3
>

Hello maintainers,

I'm not sure why the patch series has been changed to 'Changes
Requested', until now I don't think I need to change something.

Should I repost this series (keeping the v6 tag) and then wait for
more comments?

Thanks,
Jason
