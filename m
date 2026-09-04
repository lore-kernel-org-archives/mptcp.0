Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F437A829
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514370; cv=pass; b=lLHEOx9/WX7kEOlkM0Uzz7CbSX2XL3huzB/UkarthyRqdxyNFvwMgD5AhH75aGnMuviRGoR1vonXY18MnKJlpIksekORCMUwEjaWQcKiJoBR5lHURMGPxw5qOhVktonBDS/DuPm/J1tjOVa4ZfPyP+iiWmB4uTrwKjuptkFkd2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514370; c=relaxed/simple;
	bh=DUvKeV2pYYS98XZI/yTtVHhkMvupMqQvMCeD1x4mefk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Arl55ygp/9zoDBUzjImvVNovwgCJVSxqD3xg9zEGEKnZund9bNA5u7YsBlSJyvhhtjVATie90fT/bKZokAiV5OqR3AmZFQTixGdgzG2qA4i22l9E0yvnM7BT3SxbphozLzpRo47qPhJWp0lBokcbEf90igWe+eFKa+HCxcTrFjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3AHWw5w; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3AHWw5w"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52d8679c149so8806921cf.2
        for <mptcp@lists.linux.dev>; Fri, 04 Sep 2026 02:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514368; cv=none;
        d=google.com; s=arc-20260327;
        b=OdPE7ZBOUTevS5GULkRjTkwBkS1YYTU6ohM2mpNCcoz6x37C50yO9kyAFnjQwP5U6u
         s78yqvlfXr+m26AcTkowW0wyL/IeSZh0IOM9cFgsE2EpvOrn6U4uBgCMnLtm9KNcxya0
         z6KbGsm4x0xAbvr1FuZ1Pl8A8PTGsNoLOJ5ySVAmPug4Pw5u+zX0KIGdjVDV026Kv3gY
         xyQjTEkkhhUyC3vwilFcqsG2ZY7X4ngRbK7KD+DaKWQYuDs2V18MExibG5HDY2UrHFc5
         zJZUoiDajzfMZFKyFK71bGEwzl7fpL3t44traUEHEjLUeg5Ko9tckU77psTH0oj2WkXf
         ybIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4kpXCOkiIJd2qFDqOWzg8CKGG2LbCdOC7gWq0if0NCg=;
        fh=ZC5q51vrctRUqq41hcareuuKR6xz7uKrnZmUR56S+U0=;
        b=QQiXJapBr/OOcbieYs+nhoCTZMoPq8AReyt3ZNW5ByzhAnxAETvu9BMdD47sWIlGfB
         8g4RgvchuJmo/UK/x/lpfEh1AlH8zGRSa4SZrbaa4Ffe23Ujya9ruSPdI5yzvRbmEZqf
         bLno1XRzy2T5xfEKqcoXNhkKs/BxL1Bm1GHFWPqNCxtqrO3XfXe4esEV4U2yY/dDTy4q
         aYRzvBImDBG3b+/EL9ZPSZafxLY/tmzddnRXd3an7tYjHALfMfJgcvZo7UZyL84UwIT2
         ez1SaU9yyUL1ctWt2JHtJDQoj6KTboL9xIAWRTjWh+2MHaagwxcbDVj1tYf/YJWU/3mH
         6AFw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788514368; x=1789119168; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kpXCOkiIJd2qFDqOWzg8CKGG2LbCdOC7gWq0if0NCg=;
        b=D3AHWw5wSLRBIco540lex6lVBELBTcbYVD6ZUN8raV2ASFZBAnkc0o/86nAbhvLcZu
         JwaeCG2WLQCIcEAAkTqIyZrKCllT7CGb2B6f6CdfzHO9ib4tsOeXIjgxYvJRIE4sHjhV
         lQhdCsG5/8eiR5WbyCXOH30XxULWBgxeQYaO7c73kbqDEaZN8SaYSzEzFU78nIvscaV2
         iPb9kKtbbwSDnhzAnukpF1Txpr0pnRc6quuc9s105wuV++MpB8wDOqKWZjPi+w7HEIvm
         drkhEXwnL1yrp30U9zCylv+y3Gla9wAtmyCtfl2mKiYbT4df2AY14nAYMcnyLQ8svlcQ
         +kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514368; x=1789119168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kpXCOkiIJd2qFDqOWzg8CKGG2LbCdOC7gWq0if0NCg=;
        b=X/VyB0vwy0bC+jrcXPTEwlgrnS/fE/bt3Twleq0dIGULCwX+Y5ITdslVWFZ8c6tjAz
         XZHstgrSJk17YnYSibmI/gQWjP4xV9w9Tz17qVmt5JE8l0GzL2gSndmZTEYccbXaczDN
         wwaKXKFKOrVB6xDrIwsnINxWCejIjnXY4/2vJoJeoPsH0UQsJVr556NrjbbyPPUv7Jvh
         PBs67/leMGt8+2SZNo15HDeI+0/NWF2Y/JhBE8m5MNLrLL9pndBbyIJnYeqdpLv9bkPH
         V9i1bJSRYAPE31/3d3402jYtyxxCjk8umESKn0Xi3bBV//OP6la9pi3ynJj1Q3ozRbp9
         tu+Q==
X-Forwarded-Encrypted: i=1; AKwUvBysjiUnG1g2bL/JVfbl6E43vKqd2+hznol+Np4NbZOMeQp5wrSzsHaLaiJliX9kVeKn/5U06A==@lists.linux.dev
X-Gm-Message-State: AFuF++lGJ+PCCPoVZcM5FQYwoWFi+n09jAFAhz9mxpKiqvgebE1i/YBv
	U5PAA8dnX2XNH+1aprHYxTdQX+JtU2IVhEtwxTeH9TRVzXNzYJIB7zo5rxqwoSiNzNOiaj76tUp
	rI0s5GhaUV1XWteNXkfaJqX+k4T3HGlY=
X-Gm-Gg: AYBFou0vMyEJxMjtcujXGWOwPgCOqjQcZ0j8djy1qGkqHoWgAzmlhysH2zn5VzQgekf
	jMH1R8AFuWe158Oa8/N77E+HC1rKXU2XxcI0eEPDEssSaM99cKCB7iUJ5ERuZP3/0v0/Ud40LRH
	uY/+s0v4YGU0Puh5g42fGv4Ht20FFz3N0HvtEMhBtgt5tvgQWG5VKZBikJL4hpFz3eG9tNlZuYM
	8KH6zT36naSKG86lzErxdKYRZr+r3GWHfXZ8fLBsAbtLocABWEGtc+B0bO/EUx+BgRbuN8UGDCn
	2n707ahfN/p0zxGB8uu9qjmYe4L5XTj8ikLghSsiguW6qQ==
X-Received: by 2002:ac8:59d5:0:b0:530:430b:cce5 with SMTP id
 d75a77b69052e-53054a3a641mr46885291cf.47.1788514367989; Fri, 04 Sep 2026
 02:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1788202924.git.caoruide123@gmail.com> <12d0c7f938729d16fcdd5b46a6a0e912fb1cd2f8.1788202924.git.caoruide123@gmail.com>
 <99e76bbc2679c6c288f5ddf63d25dda03ce97379.camel@kernel.org>
In-Reply-To: <99e76bbc2679c6c288f5ddf63d25dda03ce97379.camel@kernel.org>
From: Ruide Cao <caoruide123@gmail.com>
Date: Fri, 4 Sep 2026 17:32:36 +0800
X-Gm-Features: AcwNN1XNq_rDKvHSYk92RP2jEOs6D5JwaMlKaPT2137-ERyf_Q7wwA86AzJZ3t0
Message-ID: <CACveakTqvGjdkJ60po91jzUf5QTTPvQqtATtXrQNuqn+5Htszw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
To: Geliang Tang <geliang@kernel.org>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, 
	kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

Thanks for catching, agreed.

Since no functional change, would it be OK to fix it up while
applying? Otherwise, I can respin.

Best,
Ruide

Geliang Tang <geliang@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=9B=9B 10:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ren,
>
> On Tue, 2026-09-01 at 18:33 +0800, Ren Wei wrote:
> > From: Ruide Cao <caoruide123@gmail.com>
> >
> > TCP request migration clones pending request sockets with
> > inet_reqsk_clone().  For MPTCP MP_JOIN requests this byte-copies
> > subflow_req->msk, but the clone does not own a reference.
> >
> > The original and cloned requests can consequently drop the same msk
> > reference, leaving one request with a dangling pointer.  This
> > manifests
> > as a KASAN slab-use-after-free in subflow_req_destructor().
> >
> > A non-NULL subflow_req->msk means that the request owns one
> > reference.
> > The third ACK can concurrently transfer the original request
> > reference
> > to the child and release it, so taking an unconditional hold on the
> > copied pointer is unsafe.
> >
> > MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all current
> > inet_reqsk_clone() callers run in an RCU read-side critical section.
> > Read the pointer from the original request, acquire a reference only
> > if
> > it is still live, then re-read the original request to verify that it
> > still owns the same msk.  If either check fails, clear the clone
> > pointer;
> > otherwise its normal destructor balances the new reference.  Mark the
> > ownership-transfer store with WRITE_ONCE() to match the lockless
> > reads.
> >
> > Patch 2/2 completes the clone fixup for MP_CAPABLE token ownership.
> > Both
> > patches carry the same Fixes tag and are required for stable
> > backports.
> >
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at
> > retransmitting SYN+ACKs.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Kyle Zeng <kylebot@openai.com>
> > Reported-by: David Lee <david.lee@trailofbits.com>
> > Closes:
> > https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbi=
ts.com/
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> > Signed-off-by: Ren Wei <weir@nebusec.ai>
> > ---
> >  include/net/mptcp.h             |  7 +++++++
> >  net/ipv4/inet_connection_sock.c |  4 ++++
> >  net/mptcp/subflow.c             | 33
> > ++++++++++++++++++++++++++++++++-
> >  3 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 71b9fc5a5796..0a02ac1ed22d 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -223,6 +223,8 @@ int mptcp_subflow_init_cookie_req(struct
> > request_sock *req,
> >  struct request_sock *mptcp_subflow_reqsk_alloc(const struct
> > request_sock_ops *ops,
> >                                              struct sock
> > *sk_listener,
> >                                              bool
> > attach_listener);
> > +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> > +                            struct request_sock *new_req);
> >
> >  __be32 mptcp_get_reset_option(const struct sk_buff *skb);
> >
> > @@ -309,6 +311,11 @@ static inline struct request_sock
> > *mptcp_subflow_reqsk_alloc(const struct reques
> >       return NULL;
> >  }
> >
> > +static inline void mptcp_subflow_reqsk_clone(struct request_sock
> > *req,
> > +                                          struct request_sock
> > *new_req)
> > +{
> > +}
> > +
> >  static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
> > { return htonl(0u); }
> >
> >  static inline void mptcp_active_detect_blackhole(struct sock *sk,
> > bool expired) { }
> > diff --git a/net/ipv4/inet_connection_sock.c
> > b/net/ipv4/inet_connection_sock.c
> > index 6257459bcee2..896f472dcba2 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -21,6 +21,7 @@
> >  #include <net/xfrm.h>
> >  #include <net/tcp.h>
> >  #include <net/tcp_ecn.h>
> > +#include <net/mptcp.h>
> >  #include <net/sock_reuseport.h>
> >  #include <net/addrconf.h>
> >
> > @@ -961,6 +962,9 @@ static struct request_sock
> > *inet_reqsk_clone(struct request_sock *req,
> >               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk,
> > nreq);
> >       }
> >
> > +     if (rsk_is_mptcp(req))
> > +             mptcp_subflow_reqsk_clone(req, nreq);
> > +
> >       return nreq;
> >  }
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 8e386899ceb9..e08d1036ad78 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -47,6 +47,37 @@ static void subflow_req_destructor(struct
> > request_sock *req)
> >       mptcp_token_destroy_request(req);
> >  }
> >
> > +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> > +                            struct request_sock *new_req)
> > +{
> > +     struct mptcp_subflow_request_sock *subflow_req =3D
> > mptcp_subflow_rsk(req);
> > +     struct mptcp_subflow_request_sock *new_subflow_req;
> > +     struct mptcp_sock *msk;
> > +
> > +     new_subflow_req =3D mptcp_subflow_rsk(new_req);
> > +
> > +     /* A non-NULL ->msk means the request owns one reference.
> > The clone
> > +      * copied only the pointer, while the original request can
> > concurrently
> > +      * transfer its reference to the child.  Acquire a reference
> > for the
> > +      * clone, then verify that the original request still owns
> > the same msk.
> > +      * MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all clone
> > callers run in
> > +      * an RCU read-side critical section, keeping the memory
> > stable here.
> > +      */
> > +     msk =3D READ_ONCE(subflow_req->msk);
> > +     if (msk) {
> > +             struct sock *msk_sk =3D (struct sock *)msk;
>
> Here we usually name this variable "sk", and correspondingly, the
> socket for the subflow is generally named "ssk".
>
> Thanks,
> -Geliang
>
> > +
> > +             if (!refcount_inc_not_zero(&msk_sk->sk_refcnt)) {
> > +                     msk =3D NULL;
> > +             } else if (READ_ONCE(subflow_req->msk) !=3D msk) {
> > +                     sock_put(msk_sk);
> > +                     msk =3D NULL;
> > +             }
> > +     }
> > +
> > +     new_subflow_req->msk =3D msk;
> > +}
> > +
> >  static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1,
> > u32 nonce2,
> >                                 void *hmac)
> >  {
> > @@ -919,7 +950,7 @@ static struct sock *subflow_syn_recv_sock(const
> > struct sock *sk,
> >                       }
> >
> >                       /* move the msk reference ownership to the
> > subflow */
> > -                     subflow_req->msk =3D NULL;
> > +                     WRITE_ONCE(subflow_req->msk, NULL);
> >                       ctx->conn =3D (struct sock *)owner;
> >
> >                       if (subflow_use_different_sport(owner, sk))
> > {
