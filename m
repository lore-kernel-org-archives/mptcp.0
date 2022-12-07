Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29631FA4
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 13:10:11 +0000 (UTC)
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-381662c78a9so185511417b3.7
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 05:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HAryRwo7K7vJVRkZK/VOPSFDpqEVTuoOLER3Q64DLic=;
        b=YiK++ia2om6r1rW4XeOilWxNmyUsScD2wOS+K6IY7I63i4BNPm/rdEoJy7s7IXFlSV
         kjFJJ8a30/D4v8CG9qIT7/7285gOlC9c9BJEQOwQ3GLr2bP/P+HRVOiae6CTuu+/dER9
         +Y85DdZCSTaYYMgVGumVUQF6VmS31qSYQUkWOnkda27x0C2Ltpae5PEHko632YCfeN8t
         iw9PIpDIKAckcmBuTXpRZcTDEgZ9AOLPMlNvCDEoeH2n6t/MFpUCTs8CRot/NNJL5q7C
         eAlcJjV/h1qb4lZe9beQl7+93k7vK7v2rahdZUryIVm9mhcy9ZPy+p1h/qQxeW/fnoHJ
         SHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAryRwo7K7vJVRkZK/VOPSFDpqEVTuoOLER3Q64DLic=;
        b=b72lOqk3ILh+2fl3uy/tGs0nqM9GUrSIa1TGFUaeXlaXqdudkOPMPRxRXVu5pwVjiv
         VaoNBhCeJwMt3pog1rkykrurwfRZtOILLZJOQlw46IFhIVJ58cLzLlvecfEGgrDURkYT
         0cmJSTLf1/LQqAlc5IBv7dPbq3/3TH46ZMN2a2ag8cZxJVGVMBBZsVBYKWz3LtCJoRC7
         Dzu7TaWNt0Nr9CNLliq3ReXZlzJgco0mjpeghpz7sxO9TqDYCfXLcsLCihriSPfwf8lo
         osVlnACcNVzq6ht3TpcXuE+HyEb8Ngo1ptpimtJPn/5RLxpT/1y4r3rLLDAOwQ+GHSPC
         mk8A==
X-Gm-Message-State: ANoB5pm/0wAfWqzJzW6rkqxaMJKOTptnX8Bx3XQVJbrioQYFgfmiYdfz
	sLicb0tq03L4kUCDKi2kwYpFVG9ACoIQbPo3+Ow=
X-Google-Smtp-Source: AA0mqf53j1qWwfkWIUySF2uMrcimLxBnF2nzA/fEZWes9kCS2zu8Kh3O5diiT3kYUvOqLCXcWQacFlPaVs6ZgXA+7lI=
X-Received: by 2002:a0d:d5ca:0:b0:3cd:e85b:c797 with SMTP id
 x193-20020a0dd5ca000000b003cde85bc797mr37780598ywd.175.1670418610713; Wed, 07
 Dec 2022 05:10:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221122034923.804955-1-imagedong@tencent.com>
 <20221122034923.804955-3-imagedong@tencent.com> <80c80e5c1813e7df9d15f89d13453f0dce4b8f2c.camel@redhat.com>
In-Reply-To: <80c80e5c1813e7df9d15f89d13453f0dce4b8f2c.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 7 Dec 2022 21:09:59 +0800
Message-ID: <CADxym3ZSoZq-B5-+PJ_vMMSDi=yb8KA5EaBsg2q7tXT8FqS1iw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 2/4] mptcp: add statistics for mptcp socket
 in use
To: Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Fri, Dec 2, 2022 at 8:37 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hello,
>
> I'm sorry for the long delay with my reply.
>
> On Tue, 2022-11-22 at 11:49 +0800, menglong8.dong@gmail.com wrote:
> > @@ -382,6 +383,18 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
> >       return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
> >  }
> >
> > +static inline void mptcp_inuse_inc(const struct sock *sk)
> > +{
> > +     if (!test_and_set_bit(MPTCP_INUSE, &mptcp_sk(sk)->flags))
> > +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> > +}
> > +
> > +static inline void mptcp_inuse_dec(const struct sock *sk)
> > +{
> > +     if (test_and_clear_bit(MPTCP_INUSE, &mptcp_sk(sk)->flags))
> > +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> > +}
>
> What concern me most with this patch, is the need for an additional
> msk flag and the related atomic operations.
>
> If tracking non fallback sockets is good enough for you - that would
> probably make sense - you could place the sock_prot_inuse_add() in the
> successful path of mptcp_token_new_connect(), mptcp_token_accept() and
> mptcp_token_destroy() - the in use decrement.
>
> As the token is unique, it's creation/destruction correspond to the
> creation/destruction of a non fallback mptcp socket. Additionally that
> somewhat correspond to TCP hash/unhash operation, so it will match more
> closely the existing accounting in TCP code.
>

I think it's a perfect idea. I considered to use mptcp_token_new_connect,
mptcp_token_accept and mptcp_token_destroy before, but I found it's hard to
trace the fallback case, as I thought the fallback in the active connection case
is not hashed. However, the token of the 'msk' in that case is not destroyed.
Therefore, we can now do the statistics according to the token create
and destroy for connection case, as all 'msk' has the token except the
listening msk.

For listening msk, we use the method we used before.

BTW, is it ok to keep the fallback msk in the hash table? Which I think
may have a little impact on the performance.

Thanks!
Menglong Dong

> WDYT?
>
> Thanks!
>
> Paolo
>
