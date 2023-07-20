Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EF19BD0
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 19:15:00 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2758a12.0
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689880498; x=1690485298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAy1IEMzEKnBqRGLhWLekSm4eET+PZas5kwMX/alrsM=;
        b=w32q6DB+CVWrHhcm6JkTEoQAAVTVDyS/PnK86FjgSSB/Lr3/lB3ACqhaNaaUrNDK0w
         icepJnmeU5mGKl9Kw6h5BsdGKexycm4ybvnnbOF/p6TWatoZvr8yucvBaP9vfrUrri2E
         xJG35S8oppQqnj/p37imqF+tIcjHj2PGMkdrLR8++vIRXEMCWc39qJh2XxGuyz9l7TWh
         EunZd/KPmhsKGyBoN9w9OmvVnkgfq1XwtW7CblUxKSkMHmanbUoqIB1Uw5FemMm47yCx
         NMMGIZNfrHfTf90+CRzJf3kys3TAM6pfhLwX/Gdp0GR32iXuviO4kB5zW0aDk6i3otiZ
         W21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880498; x=1690485298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAy1IEMzEKnBqRGLhWLekSm4eET+PZas5kwMX/alrsM=;
        b=Fh8csyHRYVcFMAJpTTg4+6u4djnNqvW6ZZqDc/nWESHV5V9ID3xUurIv9+RduCo7+5
         kmyvMNr7qOYQEZFV+miaj225ujeHg2xID7uYd0Ayt/6jh/qjc6B9+5dElTqmCLisHDQR
         +/ZXBiqeM2fzquQfqQ2O5oF+8lT5ku/OYDNLju2MvAAo6MYDZ4Wj40Q8GbH9ZO7P27O9
         7Mro052ETJuRbW8UmBEowIHiotPvi+TCOBepg7Q6/RaUiZarWXXpRRUp8CkOpf6FnrVw
         YVmcTgOy3FoxZ8K3xwkgoKc1JQyHK4B0Fs7aVX8R1d6wC3EAGxbasXkuSOUP7jWuWxY1
         M9hg==
X-Gm-Message-State: ABy/qLYH2EVFxD+URfwo5ew+uWVacUNMGy0D/T1cEFATFhEN/EoxPoez
	RdaHjM7ycQ3sEwlajrys46Zi8nA38zusOjnEDIOMhQ==
X-Google-Smtp-Source: APBJJlHQg9NmnVAiEnIEfExWOiEKsBneck65xNomT9GlPUYaiO3MdCoUT1IayLIR4gMV5Eqe7ILOteX01vOKqXcPros=
X-Received: by 2002:a50:d50b:0:b0:51a:1ffd:10e with SMTP id
 u11-20020a50d50b000000b0051a1ffd010emr19916edi.3.1689880498256; Thu, 20 Jul
 2023 12:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
 <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
In-Reply-To: <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Thu, 20 Jul 2023 15:14:20 -0400
Message-ID: <CACSApvaBBmQsEJBZcht0--zqyWcoJm0vfiCw4RiA0AyyaJQsMw@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 3:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 20, 2023 at 8:48=E2=80=AFPM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
> >
> > From: Paolo Abeni <pabeni@redhat.com>
> >
> > The MPTCP code uses the assumption that the tcp_win_from_space() helper
> > does not use any TCP-specific field, and thus works correctly operating
> > on an MPTCP socket.
> >
> > The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > broke such assumption, and as a consequence most MPTCP connections stal=
l
> > on zero-window event due to auto-tuning changing the rcv buffer size
> > quite randomly.
> >
> > Address the issue syncing again the MPTCP auto-tuning code with the TCP
> > one. To achieve that, factor out the windows size logic in socket
> > independent helpers, and reuse them in mptcp_rcv_space_adjust(). The
> > MPTCP level scaling_ratio is selected as the minimum one from the all
> > the subflows, as a worst-case estimate.
> >
> > Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> >  include/net/tcp.h    | 20 +++++++++++++++-----
> >  net/mptcp/protocol.c | 15 +++++++--------
> >  net/mptcp/protocol.h |  8 +++++++-
> >  net/mptcp/subflow.c  |  2 +-
> >  4 files changed, 30 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index c5fb90079920..794642fbd724 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1430,22 +1430,32 @@ void tcp_select_initial_window(const struct soc=
k *sk, int __space,
> >                                __u32 *window_clamp, int wscale_ok,
> >                                __u8 *rcv_wscale, __u32 init_rcv_wnd);
> >
> > -static inline int tcp_win_from_space(const struct sock *sk, int space)
> > +static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
> >  {
> > -       s64 scaled_space =3D (s64)space * tcp_sk(sk)->scaling_ratio;
> > +       s64 scaled_space =3D (s64)space * scaling_ratio;
> >
> >         return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
> >  }
> >
> > -/* inverse of tcp_win_from_space() */
> > -static inline int tcp_space_from_win(const struct sock *sk, int win)
> > +static inline int tcp_win_from_space(const struct sock *sk, int space)
>
> Maybe in a follow up patch we could change the prototype of this helper
> to avoid future mis use :)
>
> static inline int tcp_win_from_space(const struct tcp_sock *tp, int space=
)
> {
> }
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Thank you for the fix!

> > +{
> > +       return __tcp_win_from_space(tcp_sk(sk)->scaling_ratio, space);
> > +}
> > +
> > +/* inverse of __tcp_win_from_space() */
> > +static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
> >  {
> >         u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
> >
> > -       do_div(val, tcp_sk(sk)->scaling_ratio);
> > +       do_div(val, scaling_ratio);
> >         return val;
> >  }
> >
> > +static inline int tcp_space_from_win(const struct sock *sk, int win
>
> Same remark here.
>
> Thanks for the fix !
