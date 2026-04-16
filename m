Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587063385BE
	for <mptcp@lists.linux.dev>; Thu, 16 Apr 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365337; cv=pass; b=XDromuVfS3WAMsxdgRWYEAxPAwj36EHqbrv0ZhuFUKUU4Ao51tGyELSj90ZdVQzOodZgfj7LW3IO7wIOfinpZIN82hjpyRzgLbywUhxTJt24aJavlwMlaJlhuOCUOM1HlStANAAcJaIE3BLFLgP2zUR45x8kI+2ARsZeSkSyxTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365337; c=relaxed/simple;
	bh=slMhkCQrt5HzGz0EHc6P3oJL3SVc9/71839jqDGNEq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDeBDfv1XjhSCiK1rQy9avuVV6N1bIcoZAVU1H6VxbF2KmChSGksSc0zKWPEDvhlC5gXKz4JR+UM+eDcZdNRO6P3nb3EVGQSoGUxipG1lEPidECQW6I2YKC+qUBJrMEjUnFIHSDjSl3DtRnRKGSMVRMdwpRLu4D+Xx4h+I5owyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgmwZCMc; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgmwZCMc"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-672bd7d00bdso91356a12.1
        for <mptcp@lists.linux.dev>; Thu, 16 Apr 2026 11:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365334; cv=none;
        d=google.com; s=arc-20240605;
        b=AiZzB1wodgNlMKtnYCDILRu7J+e6Bww3uoMW52Py5kuVVamvwFT08tyD5ckShxQGld
         eCP8yMz7pq77A8OASvPJVYZPw7GE/VfDqujDBec9vUy8pelDNKsoX/0WzIjVgyRLh+LT
         97Y2qYfOVl8pEj9+Zlk486qkjaKOP93H4bDkOXcV+EfJOThcmEZ429K5r/99h2LHTK9A
         BzorD5kIY1ZdNUJS5O7PteQoq46ypu893hsP/VXxPI8owVWgCFlo5tYqFCoob/FBLl3x
         ZzYSL6GEIFIUDv9vyhcxmFPCA+uIuA2xvZLehLIKdoILt5T+SJvp2Co3U9s+5k4BBXG/
         YfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ujvIjY3OXX0Ws7ESTLX2O+qxZerdHAD6BRWOwGQM5IM=;
        fh=gja6wc9GVk/knI9vDMIResnMDBNth2ma1bW8QY/5qb0=;
        b=ex9O5ZkVVa1IkXc3gEzkpwOhtOCuoZS+t2Bb6MRiPmUpt2+S0h2aeI6rH8UQAS7wTf
         S4TDqVG0JEjF8G7GH1Pg/O/njyCvgyWV8ikYk2yNETr0UC0bVnQEKMaK5Hr8nCdqwVbr
         PFjjdujyrSAAAS1QElbBFwm0UWvek+WZdgM2BthFjpC0WTgDsvJ4861vVvoY+AnWqEP4
         D1iCIqaPdeOp+c2k4tqZwY9KJEUSq18aeHrZgYMc27DkXQ8HG+VY/APE6jyonrZ7aH3g
         PZ9+tlSmha8zje5WfFs+jb4hBiUhEsY1ftJVqRzD4ymp71bosaa3jNmmFMA/oYhOb+oA
         3iwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776365334; x=1776970134; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujvIjY3OXX0Ws7ESTLX2O+qxZerdHAD6BRWOwGQM5IM=;
        b=rgmwZCMcx8T6mooAORg2KsoGgfSR0gAeZOe3sE6pglamgKNWvHYHQS2m5yTNomxOJb
         HfrirfX3AvgZy0C0dfLSzcvHWjRJjBpcLrat1ahSMWrz90G3S0WAO2+8CT4HOZx0lXUr
         uvzzBSVw2kl4kB/HZT8NSLLeGsegk5D/D7H2EbhHO4ze+zpb/pkXaXshuHuuiD81RkYg
         /vdu5x/Rv7nigRbqhjpYizFIk+Knhf1x83prH5Rl+q6PBBh9zzmRpoxryTThfnMoSrmo
         XGDx5x0iyKDZHkIR8/O03GC07w+m+dnKFcX/kPBOi12DLB0e2pMTgHEUL8nZXP/65uNY
         A6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365334; x=1776970134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujvIjY3OXX0Ws7ESTLX2O+qxZerdHAD6BRWOwGQM5IM=;
        b=FsCz/ji3CSb5l2/kfIr6eOBbt9nX3uepjz+GqXGi13sFYXoIMXlVnkY8ZfNlLHPXwr
         GIyMqS5IPR8v14Y4rDQTZ6W7wjug4eUw+Yo4z2roVPe0ZXiaHip+yy/EUYBZVlviXopl
         D57P7y1gI9NSzX055lEXAl4/yt9fBKp0eWO572iL213QqiIhtyrmRNIjSLxX6kXc1tsN
         rvkznM9M/OEQR8GFy6uLKISdUXcZdiHwegmBXnM+2UaDeU/QSx0k6005hei5ZgsqvU/x
         xN3rucoyjKtscKao633ebo371J5QfiZihyw5hun3IqWpz423aWIcTRF2w4uHNAl4FRyi
         WTuw==
X-Forwarded-Encrypted: i=1; AFNElJ9ikDDYo6+1+aHC1th7zaFCIiA+UPkAKRfKbvQZWC2vI5qm/lR18cAhe2KsL+kgENuuG/AXmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDw1FvvCSUxYMyYC32D+FKfd4EyPYxSGPEk1UCZiU8BMuq6HPr
	wgXBzQ+l6e+QjJLgCRs7S9NoIb3FJwtRAAc88UzRss6Aw7MHpEiH4J4Taoi3RJspzJYeL4MwAOg
	WxykiFAWEzyh2cBsdtEtDQgM0CCeXEFzOX/1vRFJ0
X-Gm-Gg: AeBDieugaIL12UDz8xjmBGrPxzNswDVQA5XbaX/2wa3ukhSA95yLazJuGQS6yvN+8vv
	rVpziHKQ06i1H4bgVY0KaCGOeaLJnTG+1ajlWgSgo04vBtlii5cECRFaF0VBAXrDcbHk6kW7m/B
	fNq9DXMl5eCvfn7VXEwpi87HkmTLv+eq7Cllord4fono1Oeg9cIQIQy0tI4bZ+l8kYUewW6RiUN
	yxvsfnhr0QFiEAo02aYoogmSRjSnGYP/Ak1uwe4R3Ls0qPUE7uHAVOlR3Cg9RQ8qcxRfjo6R194
	n1q7ePA+YadREzStnshce8vTFTWekNpxNQNyXLmnDjPSW3gCjMmjKo+aJAkFq4vA6fPAb4KQKhi
	SQcnsY/h4QugpuSznWqqfkn4wODqLv0/Sm2P1iMhoWUut48pTpMg4riTHxsb89TI6ELrl26+W
X-Received: by 2002:a05:6402:5418:b0:670:b68f:bf28 with SMTP id
 4fb4d7f45d1cf-672bd71082bmr158046a12.16.1776365333161; Thu, 16 Apr 2026
 11:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1776149210.git.caoruide123@gmail.com> <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org>
In-Reply-To: <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 16 Apr 2026 11:48:39 -0700
X-Gm-Features: AQROBzBUGmEnoNBMsrCHFiceUIWDnxmZZMexJRFYr3C0RNOXre_AKHla49_AvxA
Message-ID: <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning reqsk
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ncardwell@google.com, dsahern@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, daniel@iogearbox.net, kafai@fb.com, 
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 10:45=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Ren,
>
> On 15/04/2026 11:31, Ren Wei wrote:
> > From: Ruide Cao <caoruide123@gmail.com>
> >
> > TCP request migration clones pending request sockets with
> > inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
> > subflow_req->msk, but the cloned request does not take a new reference.
> >
> > Both the original and the cloned request can later drop the same msk in
> > subflow_req_destructor(), and a migrated request may keep a dangling ms=
k
> > pointer after the original owner has already been released.
> >
> > Add a request_sock clone callback and let MPTCP grab a reference for cl=
oned
> > subflow requests that carry an msk. This keeps ownership balanced acros=
s
> > both successful migrations and failed clone/insert paths without changi=
ng
> > other protocols.
>
> Thank you for this patch!
>
> Indeed, it looks like this path has not been covered by the MPTCP test
> suite so far.
>
> By chance, do you have any simpler reproducer using packetdrill? (the
> MPTCP fork)
>
>   https://github.com/multipath-tcp/packetdrill
>
> Also, I see Sashiko is pointing to a potential issue with MP_CAPABLE and
> the token, also only visible with net.ipv4.tcp_migrate_req=3D1:
>
> https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1=
776149210.git.caoruide123%40gmail.com
>
> Are you also looking at that?
>
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
> > Cc: stable@kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> > Tested-by: Ren Wei <enjou1224z@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  include/net/request_sock.h      |  2 ++
> >  net/ipv4/inet_connection_sock.c |  3 +++
> >  net/mptcp/subflow.c             | 13 +++++++++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> > index 5a9c826a7092..560e464c400f 100644
> > --- a/include/net/request_sock.h
> > +++ b/include/net/request_sock.h
> > @@ -36,6 +36,8 @@ struct request_sock_ops {
> >                                     struct sk_buff *skb,
> >                                     enum sk_rst_reason reason);
> >       void            (*destructor)(struct request_sock *req);
> > +     void            (*init_clone)(const struct request_sock *req,
> > +                                   struct request_sock *new_req);
>
> @TCP/INET maintainers: are you OK with this new function pointer?
>
> Currently, MPTCP is the only user, and "req" is not used, see below.
>
> >  };
> >
> >  struct saved_syn {
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index e961936b6be7..140a9e96ad58 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(struct=
 request_sock *req,
> >       if (sk->sk_protocol =3D=3D IPPROTO_TCP && tcp_rsk(nreq)->tfo_list=
ener)
> >               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
>
> (Maybe TCP with fastopen could be this other user to call
> rcu_assign_pointer()? (net-next material))
>
> > +     if (req->rsk_ops->init_clone)
> > +             req->rsk_ops->init_clone(req, nreq);

I think a simple direct call is better.

#ifdef CONFIG_MPTCP
    if (tcp_rsk(req)->is_mptcp)
        mptcp_reqsk_clone(nreq);
#endif


> > +
> >       return nreq;
> >  }
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 4ff5863aa9fd..5f4069647822 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_so=
ck *req)
> >       mptcp_token_destroy_request(req);
> >  }
> >
> > +static void subflow_req_clone(const struct request_sock *req,
> > +                           struct request_sock *new_req)
> > +{
> > +     struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_=
rsk(new_req);
> > +
> > +     (void)req;
>
>
> Note: if 'req' is not used, and MPTCP is currently the only user of this
> new init_clone() callback, perhaps enough to pass only 'new_req' for the
> moment? 'req' can be added later if other users need it, no?
>
> With only init_close(nreq) in a v2, or if TCP maintainers prefer to keep
> it, feel free to add:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
