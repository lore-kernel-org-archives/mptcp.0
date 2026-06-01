Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933B1E885A
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298813; cv=pass; b=J/sR8vDzPFg9iF3wOPT1mVdpLYICabHWLc8syNBXZkd2URyGNyla6m12ERDU8Ghuz2auyV2x1wGhAcy8yAYJR07GQ23XjZLP0EzSIZdLEZwIh+6uoKliNolmaEMeVVfE3xDGUjWlUXkEk1Cgn4hiUyKlc+TtMcny4MVoGnW0jLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298813; c=relaxed/simple;
	bh=oZo0Gies88mOxdZUi76BlAfTbLB1IyaI+zeIseUnRZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjo1E12RfGNugNtkH+870nzMNKOMXKVOR5FTJF4BEo/IK8r7kMBlrZ1iTOQC1Pd6Bnm1sfpHPaqeEHE+2Axkraqz2FbG8NEA6JipONlWwj83NAwNFGdZRihKDhUuxfEPhBQB7zsdHCUHGyznqVvIkNyBtgsClZivKybLSLG5/f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lngVhFrP; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lngVhFrP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516d65a15f6so95663011cf.1
        for <mptcp@lists.linux.dev>; Mon, 01 Jun 2026 00:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780298811; cv=none;
        d=google.com; s=arc-20240605;
        b=T1bOpFlByg3/zEADiVxO+YiwZCwvwjWdaI77IEaqHu7HGTl7NoPLsFfHtaHlzkYAi4
         BWhcScM/GGaW40AlB9PkCZictHxs+k68JQJHNR280BeUMVt23ROm5jg36rlTdO0XXCGQ
         2b4tqBIQoAsJ5+ATxEL6NQk3QV2Rdt2pxvITxQwEhKYxVZr8/bEmsffYqrRkF3rUAIRM
         /ZhZBoORCTIHpMyRhMnXLid9N63hHKW7stMXKip2OQJzK9jyGzYPnsJRwnDQe1NIuD6s
         OeYtAoPqs0SPui8WCmZmNoDmuIjTejt2Ce7ixm1LYrgb0nBOC6CauZXkku2nPdT8TsLN
         iC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0j2fQXrURv2vHABUn/uvXXmbgLtu4ew+Ljyj3acdU54=;
        fh=YfFSn+XtDoxAo7rOtBUcjrEBN6wRD945fSxyic5eHhU=;
        b=gI9b3BEXkfbHhLJ7OOdbErvDjU/9qca4RG8OlXMAumf5mkJFq8iMc/3NmGpq4SVpsl
         c/Wext0jpbItWkLbaU8JMxt5GIozhdAPe/86xXi8B9aEYDzX+61GOD339Pb6+9hjOpCs
         /SHZX9yEdkv5mUu3oQMDV7Pg88z3S6NYftiPtz/aX5O72I64ed7ulJBMPD2cZ5qDUPbp
         7aYF3/MZZ4n2Wqq3AvoiQRiCnTL7ujrX879t8WR0VgqQw7k1oOJqjk4ori6TuV0jVZiE
         LAYA//5tbWMN6bJ/ks01cK5okcAijr2dGndHDSCJK4zH0gIk2A0KKNjkmyWRP4Zws0/R
         BPWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780298811; x=1780903611; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j2fQXrURv2vHABUn/uvXXmbgLtu4ew+Ljyj3acdU54=;
        b=lngVhFrPlX579/hAelR7+WSpxqkar8q13CHRRHgBHacAlnFiyiTI+eK4ukwWBHgnPx
         StoUTzh7F9VFNyTe9kuTuaEqDCdVRlDuOc5HYCwB8WmRw3ToHiTw+MkZf/vn7TsGsgHh
         qfDVI75ZLN5mQjrurwcJ7vyV5azZicd63gJT/hINFdLSY3v926W7fT8b6YIX9jsHzUeL
         gAj+wP9AhnvRo9uU8pHns26GLMhQld0cflLYVnF/NkL2/mkNvjeC2UCJ3cpdxBIiSJFp
         mJcP7dDPiMgtC48DWxFZrmItCdlfh5bbpSnjs20TMa36K9T0ae5dBZDaAvq0f/ngEwuJ
         LE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780298811; x=1780903611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0j2fQXrURv2vHABUn/uvXXmbgLtu4ew+Ljyj3acdU54=;
        b=etPwO3p+p8kA/vwMo8R5TvXZO1q24oW7dCEIJcMR+KZJG8JEm69gQvwAcCk6V8M1Y2
         1hbGWFaR1SJPjUW3gKoZHM0lG5y8zPGVuJaNegLtIRprQ2CM+vmF3zQAvJ/fFlfYaC0R
         I5LWI/WTpdx4VeO6RdfYge/tmdk5thlv8ak3A7uuHDU/Gr5a04Fd3GU2m8SFRNe+Sus9
         A7Vk2i3mCVkizsFZgg5ugiAEWGqvxnv3M5QbzefCHWMklzg1oyvN7X/ONIoP5weVdQFF
         MZk7Y+0X/zs2xJMV3J2J1zv4hAAL+TeCCf34fN2mzOss2WaSec44Kjl+feBkaI6AJw0X
         FoTA==
X-Forwarded-Encrypted: i=1; AFNElJ8nfUwR46x1huJ85Wcaxo8d3vyhxqfSIFxGUcpkOOG2VOCIfhH+eUrxv4h9KLi2XnpbT8xUyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyae+Eovsyo/2/9S9fxqGEYA8OMqJLf790gNFPykwz/+40Nc/uP
	Tn+PFta4nVw3cMNYPLqUzuzuBeEcqMpcrbOctwTRoatNL0kvmeh6PA39lw/py6kZq+nXQbfDV/J
	kbC5/ZLjQlI/YDU3SFsdipNVzPEd777/uz3zK9jI3
X-Gm-Gg: Acq92OHUKBSytXQcBoBe3wUpiTDiXDXViwaXJPkgfaRI+XqXSqqR2Ruvl2TZW87cX+e
	7KvW6s3WHQcYV5/ICvAFRljcFMSk6ASRsUS2Oc8IRQ+LJAVyMJDJpWZ0PO82HEaWZhja8LOEhK9
	OXmSr57oSORl6iLIorzZKifbr9PqIM4zcqvYUKhV8byzIMjHvdUsJcTBJuS32Y/YJ9epTtaywk7
	XAkbuczRGfEDNLB1QKysdbB+mWzSZzOjDJwvXYFdR3i6EveMTff4iVLZ3ZunELDlCPasfCQLssd
	IxWD0LjX6F5DHUUikl/CIFoea9NFCc7SFqGOMRs8jMJBTQ/932IuGJnqJWf9Pp/C5nUA+a1YCQ8
	coAjl3P8QJgw6b9gyIhZcLvGL1iGFlw==
X-Received: by 2002:ac8:6f08:0:b0:516:cd8d:c7fa with SMTP id
 d75a77b69052e-5172dd0622dmr162730461cf.39.1780298810418; Mon, 01 Jun 2026
 00:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
 <20260601-net-next-mptcp-add-addr6-port-ts-v1-5-4fc25dfef62e@kernel.org>
 <CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com> <1f3aea3b-1bb0-4584-8f6d-af14d73df81d@kernel.org>
In-Reply-To: <1f3aea3b-1bb0-4584-8f6d-af14d73df81d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 00:26:38 -0700
X-Gm-Features: AVHnY4KvZ2b3I2Huj1-TUxuXz92NDdjpsYdkctVUOdNphLvQcjd7YsWKT5SPwr0
Message-ID: <CANn89iLBh-tSEzDuZce5G2dmC6An1agoJ9UNq2qwAAC0+oTuPg@mail.gmail.com>
Subject: Re: [PATCH net-next 05/11] tcp: allow mptcp to drop TS for some packets
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 11:52=E2=80=AFPM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Eric,
>
> Thank you for the review!
>
> On 01/06/2026 16:04, Eric Dumazet wrote:
> > On Sun, May 31, 2026 at 10:25=E2=80=AFPM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> >> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> >> this case, it is then not possible to send the address signal.
> >>
> >> The idea is to let MPTCP dropping the TCP-timestamps option for some
> >> specific packets, to be able to send some specific pure ACK carrying >=
28
> >> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> >> parameter is passed from tcp_established_options to the MPTCP side to
> >> indicate if the TCP TS option is used, and if it should be dropped. Th=
e
> >> next commit implements the part on MPTCP side, but split into two
> >> patches to help TCP maintainers to identify the modifications on TCP
> >> side. This feature will be controlled by a new add_addr_v6_port_drop_t=
s
> >> MPTCP sysctl knob.
> >>
> >> It is important to keep in mind that dropping the TCP timestamps optio=
n
> >> for one packet of the connection could eventually disrupt some
> >> middleboxes: even if it should be unlikely, they could drop the packet
> >> or even block the connection. That's why this new feature will be
> >> controlled by a sysctl knob.
> >>
> >> Note that it would be technically possible to squeeze both options int=
o
> >> the header if the ADD_ADDR is first written, and then the TCP timestam=
ps
> >> without the NOPs preceding it. But this means more modifications on TC=
P
> >> side, plus some middleboxes could still be disrupted by that.
> >>
> >> About the implementation, instead of passing a new boolean (drop_ts),
> >> another option would be to pass the whole option structure (opts),
> >> but 'struct tcp_out_options' is currently defined in tcp_output.c, and
> >> would need to be exported. Plus that means the removal of the TCP TS
> >> option would be done on the MPTCP side, and not here on the TCP side.
> >> It feels clearer to remove other TCP options from the TCP side, than
> >> hiding that from the MPTCP side.
> >>
> >> Yet an other alternative would be to pass the size already taken by th=
e
> >> other TCP options, and have a way to drop them all when needed. But th=
is
> >> feels better to target only the timestamps option where dropping it
> >> should be safe, even if it is currently the only option that would be
> >> set before MPTCP, when MPTCP is used.
> >>
> >> Reviewed-by: Mat Martineau <martineau@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >> To: Neal Cardwell <ncardwell@google.com>
> >> To: Kuniyuki Iwashima <kuniyu@google.com>
> >> ---
> >>  include/net/mptcp.h   | 3 ++-
> >>  net/ipv4/tcp_output.c | 6 +++++-
> >>  net/mptcp/options.c   | 3 ++-
> >>  3 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> >> index f7263fe2a2e4..000b6593bfa4 100644
> >> --- a/include/net/mptcp.h
> >> +++ b/include/net/mptcp.h
> >> @@ -151,7 +151,7 @@ bool mptcp_synack_options(const struct request_soc=
k *req, unsigned int *size,
> >>                           struct mptcp_out_options *opts);
> >>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> >>                                unsigned int *size, unsigned int remain=
ing,
> >> -                              struct mptcp_out_options *opts);
> >> +                              bool *drop_ts, struct mptcp_out_options=
 *opts);
> >>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
> >>
> >>  void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_s=
ock *tp,
> >> @@ -270,6 +270,7 @@ static inline bool mptcp_established_options(struc=
t sock *sk,
> >>                                              struct sk_buff *skb,
> >>                                              unsigned int *size,
> >>                                              unsigned int remaining,
> >> +                                            bool *drop_ts,
> >>                                              struct mptcp_out_options =
*opts)
> >>  {
> >>         return false;
> >> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> >> index ef0c10cd31c7..53ee4c8f5f8c 100644
> >> --- a/net/ipv4/tcp_output.c
> >> +++ b/net/ipv4/tcp_output.c
> >> @@ -1181,12 +1181,16 @@ static unsigned int tcp_established_options(st=
ruct sock *sk, struct sk_buff *skb
> >>          */
> >>         if (sk_is_mptcp(sk)) {
> >>                 unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size=
;
> >> +               bool drop_ts =3D opts->options & OPTION_TS;
> >>                 unsigned int opt_size =3D 0;
> >>
> >>                 if (mptcp_established_options(sk, skb, &opt_size, rema=
ining,
> >> -                                             &opts->mptcp)) {
> >> +                                             &drop_ts, &opts->mptcp))=
 {
> >>                         opts->options |=3D OPTION_MPTCP;
> >>                         size +=3D opt_size;
> >> +
> >> +                       if (drop_ts)
> >> +                               opts->options &=3D ~OPTION_TS;
> >>                 }
> >>         }
> >
> > Passing local variables' addresses forces the compiler to use a stack
> > canary in this hot function, even for non-MPTCP flows.
> >
> > I was about to test the following patch, which removes the current
> > stack canary caused by MPTCP :/
>
> Sorry, I didn't know you were planning to do that.
>
> Would that be OK for you if I use an unused bit in opts->mptcp? It's a
> bit "hackish", but it avoids adding a new local variable address. Or do
> you have another idea?
>
> The modifications in net/ipv4/tcp_output.c would then be limited to:
>
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index ef0c10cd31c7..f4edc9c4f3fc 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1181,12 +1181,18 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
>          */
>         if (sk_is_mptcp(sk)) {
>                 unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> +               bool has_ts =3D opts->options & OPTION_TS;
>                 unsigned int opt_size =3D 0;
>
>                 if (mptcp_established_options(sk, skb, &opt_size, remaini=
ng,
> -                                             &opts->mptcp)) {
> +                                             has_ts, &opts->mptcp)) {
>                         opts->options |=3D OPTION_MPTCP;
>                         size +=3D opt_size;
> +
> +#if IS_ENABLED(CONFIG_MPTCP)
> +                       if (opts->mptcp.drop_ts)
> +                               opts->options &=3D ~OPTION_TS;
> +#endif

SGTM, but maybe the IS_ENABLED() is not needed in this block,
guarded by  if (sk_is_mptcp(sk))  ?

Also I am unsure opts->mptcp.drop_ts is cleared already before
reaching  tcp_established_options()?

>                 }
>         }
>
>
> I can also avoid adding a new parameter in mptcp_established_options
> (bool has_ts) by setting opts->mptcp.drop_ts before calling it, but
> that's clearer with this new parameter I think.
>
> > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-92 (-92)
> > Function                                     old     new   delta
> > tcp_options_write.isra                      1423    1407     -16
> > mptcp_established_options                   2746    2720     -26
> > tcp_established_options                      553     503     -50
> > Total: Before=3D22110750, After=3D22110658, chg -0.00%
> >
>
> Good reduction!
>
> (...)
>
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index ef0c10cd31c71ff585a937fde37f2b08b1214b5a..594ec6ba02d5413d43842f7=
9aefbf4d8355c4f3f
> > 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -1183,10 +1183,11 @@ static unsigned int
> > tcp_established_options(struct sock *sk, struct sk_buff *skb
> >                 unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> >                 unsigned int opt_size =3D 0;
> >
> > -               if (mptcp_established_options(sk, skb, &opt_size, remai=
ning,
> > -                                             &opts->mptcp)) {
> > +               opt_size =3D mptcp_established_options(sk, skb, remaini=
ng,
> > +                                                    &opts->mptcp);
> > +               if (opt_size) {
> >                         opts->options |=3D OPTION_MPTCP;
> > -                       size +=3D opt_size;
> > +                       size +=3D (opt_size & 63);
>
> Nice trick! What about returning a negative number when the MPTCP option
> is not needed? Just to avoid playing with masks in the code?

Yes, that would work, thanks.

I can provide a patch in a couple of hours.
