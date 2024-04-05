Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83B1C10
	for <mptcp@lists.linux.dev>; Fri,  5 Apr 2024 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276016; cv=none; b=IRSDjK0JR37vrl+QuV80H3ZD04wYCN2rBFoNA45sRf+KSvaP7TwjdiNXfGNkEuxsc13nx9ydfvUt5HjnngKe1uOeU/ywUwLNUkgXx/iu4LdfwjcmUFN39ZIfVFlOSoZs7wxpkSGxo2xUg6f9Sami6DSceoNYyuGg1L4EwyCe2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276016; c=relaxed/simple;
	bh=aYcNk1K/ICwidZexakaP0dA9+tVqluQB/biKSaxzonQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItzwG/5uKaJM3zSNW+KMtDZXVtPuaKHBQO171iUz5Bp0RY3BqoqF2zHAadX569RbZR+44OeNf6PJWQGnG5ziac62pnWqt60PExscFTegvwoXZcx8T6XvlLremJ5RQ+cDJl1IIliLK3vw0+56sWtmlBXBM+EY+cvPyPKY2ISuGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4rRzXBs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4rRzXBs"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso1821629a12.1
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712276013; x=1712880813; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDQ0AI+9sTgw7Asa/hXBXLhuxdgG1OjxAuphEolhA+Q=;
        b=P4rRzXBsWQsDDfD5NWiukpRv5xckuVaerfcXELi4z8bW3JTKvOJjefExpMFlR5knbX
         r3GCF3veP6qaT4pTb+zeHTRpRdUGckfvn4WigYj9idKs8od0vtHjKLnH6l3tsAbbpkU5
         0NAFb9tgk3WDF5Ol7ADWaubHrTFMzPcI7SuFcdOcE8TrgIUOKKJcptcGVNOCw/ubUk3e
         5IMy6dnJZBvmNrD58dsbqJLFRdIpqD1saXyGrBeQL8NlOnZZnUlXpT+4LcBE2WWG2okP
         8iqCq1sH9ef9JC3wOuRZT7vs1o5GtP52HsniFS2+BxVGKdPpauwuLZHbS37yxb2lqVWa
         +q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712276013; x=1712880813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDQ0AI+9sTgw7Asa/hXBXLhuxdgG1OjxAuphEolhA+Q=;
        b=kqbQBNB2mbmFwlSNmqutiXFyadXix4APHLRSTj4VHpa+u3DzL9nEepM1Js88iQydR3
         WaFNMJk5XZuDA10YdvL97xdudwtEwf/iaHjmmH19C59NRKy0dsZkVihVz7Ef/ND/5iP/
         qs5n+mB4TWI4m6yDijjvxd2lnVGvsCv9IGHCWsnJUMQz/9JL2xzMlegO1ODB6js3gAoe
         Sl1YJlda/gq9nJeuRhl05+0cNt7QXs96SXeRBMie1pkEUVCB1XGt+m6rgXRMtT6cf0YH
         BvdjDbhMiMY6KdJrM2Lcd/PlosUwmaCv4dmNEn0UH4GeOfOlXFIa5EyRWO7CMKZcCSak
         9hAw==
X-Forwarded-Encrypted: i=1; AJvYcCW/pPNjJ9pj5BWeGOVoOkgJ5PSwpXHx0KE9/TQmcf+H/8V3COsYNBRjCQuE73B0afZMmwfZ0FClKoY6Ur71vZp4E5hvjRM=
X-Gm-Message-State: AOJu0YyLLyespg1h6yoFLeaTK/lDs8MM0LF/NNSxr0MktP1pvsvw4tAK
	lp3YTD+3pUMtFUe7nuYM19jbZ067cMelJSTt5R4tBziRBroy+JwMdsKVd5QryJ0lD6rafck00/4
	MYN8INJ/zcLeleC+yjsf5D65MEaE=
X-Google-Smtp-Source: AGHT+IH6Q81Un2FH3uF8VE7T4Unxxqeh2qFkaxrnOGFKzV+Z878Eu+hE3fshL8FUJXx6nwSAhwbmRHlSvUGQ+Z7jBEc=
X-Received: by 2002:a17:907:6d0a:b0:a4e:676f:c34b with SMTP id
 sa10-20020a1709076d0a00b00a4e676fc34bmr929711ejc.61.1712276012643; Thu, 04
 Apr 2024 17:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
 <20240404072047.11490-6-kerneljasonxing@gmail.com> <d8fe5d37-e317-59a5-9a01-d7c6ae43be7b@kernel.org>
In-Reply-To: <d8fe5d37-e317-59a5-9a01-d7c6ae43be7b@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 08:12:55 +0800
Message-ID: <CAL+tcoCDTEov0YkeZD7B0v=TQEsfs9LtGiOge71UxUaPzWA9kQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] mptcp: support rstreason for passive reset
To: Mat Martineau <martineau@kernel.org>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	matttbe@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Mat,

On Fri, Apr 5, 2024 at 4:33=E2=80=AFAM Mat Martineau <martineau@kernel.org>=
 wrote:
>
> On Thu, 4 Apr 2024, Jason Xing wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > It relys on what reset options in MPTCP does as rfc8684 says. Reusing
> > this logic can save us much energy. This patch replaces all the prior
> > NOT_SPECIFIED reasons.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > net/mptcp/subflow.c | 26 ++++++++++++++++++++------
> > 1 file changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index a68d5d0f3e2a..24668d3020aa 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -304,7 +304,10 @@ static struct dst_entry *subflow_v4_route_req(cons=
t struct sock *sk,
> >
> >       dst_release(dst);
> >       if (!req->syncookie)
> > -             tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NO=
T_SPECIFIED);
> > +             /* According to RFC 8684, 3.2. Starting a New Subflow,
> > +              * we should use an "MPTCP specific error" reason code.
> > +              */
> > +             tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_MP=
TCP_RST_EMPTCP);
>
> Hi Jason -
>
> In this case, the MPTCP reset reason is set in subflow_check_req(). Looks
> like it uses EMPTCP but that isn't guaranteed to stay the same. I think i=
t
> would be better to extract the reset reason from the skb extension or the
> subflow context "reset_reason" field.

Good suggestions :)

>
>
> >       return NULL;
> > }
> >
> > @@ -371,7 +374,10 @@ static struct dst_entry *subflow_v6_route_req(cons=
t struct sock *sk,
> >
> >       dst_release(dst);
> >       if (!req->syncookie)
> > -             tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_N=
OT_SPECIFIED);
> > +             /* According to RFC 8684, 3.2. Starting a New Subflow,
> > +              * we should use an "MPTCP specific error" reason code.
> > +              */
> > +             tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_M=
PTCP_RST_EMPTCP);
>
> Same issue here.

Got it.

>
> >       return NULL;
> > }
> > #endif
> > @@ -778,6 +784,7 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >       bool fallback, fallback_is_fatal;
> >       struct mptcp_sock *owner;
> >       struct sock *child;
> > +     int reason;
> >
> >       pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, lis=
tener->conn);
> >
> > @@ -833,7 +840,8 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >                */
> >               if (!ctx || fallback) {
> >                       if (fallback_is_fatal) {
> > -                             subflow_add_reset_reason(skb, MPTCP_RST_E=
MPTCP);
> > +                             reason =3D MPTCP_RST_EMPTCP;
> > +                             subflow_add_reset_reason(skb, reason);
> >                               goto dispose_child;
> >                       }
> >                       goto fallback;
> > @@ -861,7 +869,8 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >               } else if (ctx->mp_join) {
> >                       owner =3D subflow_req->msk;
> >                       if (!owner) {
> > -                             subflow_add_reset_reason(skb, MPTCP_RST_E=
PROHIBIT);
> > +                             reason =3D MPTCP_RST_EPROHIBIT;
> > +                             subflow_add_reset_reason(skb, reason);
> >                               goto dispose_child;
> >                       }
> >
> > @@ -875,13 +884,18 @@ static struct sock *subflow_syn_recv_sock(const s=
truct sock *sk,
> >                                        ntohs(inet_sk((struct sock *)own=
er)->inet_sport));
> >                               if (!mptcp_pm_sport_in_anno_list(owner, s=
k)) {
> >                                       SUBFLOW_REQ_INC_STATS(req, MPTCP_=
MIB_MISMATCHPORTACKRX);
> > +                                     reason =3D MPTCP_RST_EUNSPEC;
>
> I think the MPTCP code here should have been using MPTCP_RST_EPROHIBIT.

I'll update in the V2 of the patch.

Thanks,
Jason
