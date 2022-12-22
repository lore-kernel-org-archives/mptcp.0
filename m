Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8015A9
	for <mptcp@lists.linux.dev>; Thu, 22 Dec 2022 01:21:53 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso4550768pjb.1
        for <mptcp@lists.linux.dev>; Wed, 21 Dec 2022 17:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BsGteZHXfk/hlEOFVKOGXrUJJ1NMn/MU3BMrE2tpg98=;
        b=Jy7UxPV0MrOaAPJrOcljGWHWSi/zxdurx+cJSaKxaC/dl/CMIGx3mFjuUt5oKwKkUB
         qPIYyWhm1yRJGbngOJTwRTXT4BDqL/ater5fbeE700ZNxb7aQv5ueN5Lr2W9KJfXX1vD
         l81Isux/DOqLncZsZ0LjO0rB2MRrW3x+TJOchFaDbFOWbi+dbWpXGfJ3QmYmzyoeZnBT
         es7xaN6+5xwJS/9rMR83Iiy+W+XMKffeWw29cWhdcNH8u9TOOvvifLl+d0EFyP2ioKUy
         roJTMB19ON6AfhLIrYETIRjmSgAVL6SMa1ARn+AqC8TJf91Zcl0P+kuv1hvYfePsypij
         drkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsGteZHXfk/hlEOFVKOGXrUJJ1NMn/MU3BMrE2tpg98=;
        b=qkdWeD59L30Si/BTxnJdtyeO49LB6klecWLlZ1EYm8a5K34jfFVFF1rRzjwkKBYPu4
         bf6nVNBptKIB5bQzE0mP5DO7qOapRhec/tFF5U9sLlIeravRXn/qnFlz3DePG5SZmPC3
         5T3X67JeUDpV29FKlPtlZDXehcIbObHHkcurwxF1AJ38FpkTs8dvPpkMKxKea5cvy1j3
         gtIHK+G0oPEBUYi0KzFJaT/5plhLxJ2N+vH4bujLlnycLCZ9Vx16C2LFbJrwBQ45GuCe
         ei5yJU726MRiz87sTEe3HpgBuV2OvezVXEJq0DOTpqgS4n/J9sKSNaX4L/u4H0O4sv9X
         7XDw==
X-Gm-Message-State: AFqh2kpNB05sOKjMCAE1iqV7SXR2FzxfQhALMIfHtATvfbDuJWmWM3T1
	6w/NTQCdDtTOu2n242FnoQf5ilGqZN1OMiq3Sagj
X-Google-Smtp-Source: AMrXdXsXLNE5OwDnszGWJOUAwwbbdXlYhbtEfIpbTEfNdeC3G5kYgjtn/s2awg9R3cNFNZ0QfPoCp4S+Z4SGNpc6WdM=
X-Received: by 2002:a17:90b:87:b0:219:8ee5:8dc0 with SMTP id
 bb7-20020a17090b008700b002198ee58dc0mr339933pjb.72.1671672112623; Wed, 21 Dec
 2022 17:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1671469167.git.pabeni@redhat.com> <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
 <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com> <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
In-Reply-To: <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Dec 2022 20:21:41 -0500
Message-ID: <CAHC9VhTZ-boJeMs3ir-6=rCxyfY3ROjZ4qeXyuoo5DRPBw6gew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 21, 2022 at 2:24 PM Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2022-12-20 at 17:07 -0500, Paul Moore wrote:
> > On Mon, Dec 19, 2022 at 12:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > >
> > > Newly added subflows should inherit the associated label
> > > from the current process context, regarless of the sk_kern_sock
> > > flag value.
> > >
> > > This patch implements the above resetting the subflow sid, deleting
> > > the existing subflow label, if any, and then re-creating a new one.
> > >
> > > The new helper reuses the selinux_netlbl_sk_security_free() function,
> > > and it can end-up being called multiple times with the same argument;
> > > we additionally need to make it idempotent.
> > >
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v1 -> v2:
> > >  - fix build issue with !CONFIG_NETLABEL
> > > ---
> > >  security/selinux/hooks.c    | 27 +++++++++++++++++++++++++++
> > >  security/selinux/netlabel.c |  4 +++-
> > >  2 files changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 3c5be76a9199..f785600b666a 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -5476,6 +5476,32 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
> > >         selinux_netlbl_sctp_sk_clone(sk, newsk);
> > >  }
> > >
> > > +static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> > > +{
> > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > +       struct sk_security_struct *ssksec = ssk->sk_security;
> > > +       u16 sclass;
> > > +       u32 sid;
> > > +       int err;
> > > +
> > > +       /* create the sid using the current cred, regardless of the ssk kern
> > > +        * flag
> > > +        */
> > > +       sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
> > > +                                              ssk->sk_protocol);
> > > +       err = socket_sockcreate_sid(tsec, sclass, &sid);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       ssksec->sid = sid;
> > > +
> > > +       /* replace the existing subflow label deleting the existing one
> > > +        * and re-recrating a new label using the current context
> > > +        */
> > > +       selinux_netlbl_sk_security_free(ssksec);
> > > +       return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
> > > +}
> >
> > I thought the idea was to ensure that new subflows of an existing
> > MPTCP connection would be created with the same label as the main
> > MPTCP connection socket?  The code above labels the new subflow based
> > on the current process, not the main MPTCP connection; it matches the
> > commit description, but not what we had previously discussed - or I am
> > horribly mis-remembering something? :)
>
> You are right, I picked a wrong turn.
>
> I just tested the other option and there is another problem :(

It's never easy, is it? ;)

> The first subflow creations happens inside af_inet->create, via the sk-
> >sk_prot->init() hook. The security_socket_post_create() call on the
> owning MPTCP sockets happens after that point. So we copy data from a
> not yet initialized security context (and the test fail badly).

Hmmm.  Let's come back to this later on down this email.

> There are a few options to cope with that:
> - [ugly hack] call  security_socket_post_create() on the mptcp code
> before creating the subflow. I experimented this just to double the
> problem and a possible solution.

I'm guessing "[ugly hack]" is probably a bit of an understatement.
Let's see if we can do better before we explore this option too much
further.

> - refactor the mptcp code to create the first subflow on later
> syscalls, as needed. This will require quite a bit of refactoring in
> the MPTCP protocol as we will need also to update the
> shutdown/disconnect accordingly (currently we keep the first subflow
> around, instead we will need to close it).

Let's see if we can avoid having to do this too.

> - use the code proposed in these patches as-is ;)

That's a non-starter from a SELinux perspective as the label is
incorrect.  It would be similar to saying that for each fork() call
the resulting child process would always run as root since we couldn't
figure out how to assign the credentials properly :)

> WDYT?

Let's go back to the the inet_create() case for a little bit.  I'm
thinking we might be able to do something by leveraging the
sk_alloc()->sk_prot_alloc()->security_sk_alloc() code path.  As
inet_create() is going to be called from task context here, it seems
like we could do the sock's sid/sclass determination here, cached in
separate fields in the sk_security_struct if necessary, and use those
in a new MPTCP subflow hook.  We could also update
selinux_socket_post_create() to take advantage of this as well.  We
could also possibly pass the proto struct into security_sk_alloc() if
we needed to identify IPPROTO_MPTCP there as well.

I'll admit to not chasing down all the details, but I suspect this may
be the cleanest option - thoughts?

--
paul-moore.com
