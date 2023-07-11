Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB3174FE
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689079807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/hfye54NC9Y8rvgbRJKKHNuMdiJjifgG0AWCaWp4QM=;
	b=P1fMbGvQF1kPkAVpB30QVxwVntQQen6JyTTf8vsJAYZ4M5AVnbl+8d15lebhLmjZ0GlqFF
	WWrmkVmZ1Lqqo33ZmUnQD7098yj9EcE8Tan+m8UV3if3CVM0fMQayR+XVDc2GJ7ZjJ4hhN
	zG9hQJ3XDMURtyFNnh4vGdY0HgmV7UQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-U9ElMxGCN62NRMxMMwdpTA-1; Tue, 11 Jul 2023 08:50:06 -0400
X-MC-Unique: U9ElMxGCN62NRMxMMwdpTA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40234d83032so11743801cf.1
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 05:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689079806; x=1689684606;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/hfye54NC9Y8rvgbRJKKHNuMdiJjifgG0AWCaWp4QM=;
        b=g7O8/QuQgOCR9EBOhKLgVXqYwJJHP9u5Go9qa0ITc9Mh662jE2xK0G2b2EBfsNxmnZ
         xsqjmhm/cB5JbqCRG/hDMqTwMx38BGFyz81W55oykxdD74baIjbwKNTJ3v0vDSvRVbZq
         QV0vN1RtITyYhJnbh/eRHBJR9Vqlilnsbt3FFj0DZg0yMkWw2KqULH5qwZMg0sSHGMDr
         2t+WVoE/oGxtXNrrxZ70ZKSgGs5Ey2AnfLUMQ1oiVYoN0lF0XOyh6lYRvurFlqa487HA
         t8euKfqWgSoWRPqTBmqQe8tB6KvJDDN14d5uUmcWxD2fqLgLRv1453zs9XCPIX3I439S
         T+Aw==
X-Gm-Message-State: ABy/qLaOVy+fsbt/HCUbGVumjO0y08vhvL+fGaQdF+AX0S2JffE1RMl/
	ZKZueFuPFnlWNlXtHvU79+8XdO/iGTILOGinSVefSDbAhfBpKxTtRjrPwjPahK93LdUlTHXdBBC
	bHuwltlDygpFzMKzE1N0vTw4=
X-Received: by 2002:a05:622a:11c3:b0:403:b11f:2cf6 with SMTP id n3-20020a05622a11c300b00403b11f2cf6mr5570778qtk.2.1689079805948;
        Tue, 11 Jul 2023 05:50:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFp+KUv9sT1h12jCtfXyYZTdDTUHeQW+Epp2buF/BnUBcMwkM2HgiReIy8FPnwL0D5SpB7lqQ==
X-Received: by 2002:a05:622a:11c3:b0:403:b11f:2cf6 with SMTP id n3-20020a05622a11c300b00403b11f2cf6mr5570758qtk.2.1689079805586;
        Tue, 11 Jul 2023 05:50:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id t4-20020ac86a04000000b00403b3156f18sm1073073qtr.8.2023.07.11.05.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:50:05 -0700 (PDT)
Message-ID: <ec5fbde82d1da490192bf44682a562ee7cfa5400.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/6] mptcp: sockopt: uniform code to get/set
 values
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 11 Jul 2023 14:50:03 +0200
In-Reply-To: <bc861997-4f71-c254-6e49-f92ba86dce67@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
	 <9de27c12da208e32efc43e2b36840d941cd1575f.camel@redhat.com>
	 <bc861997-4f71-c254-6e49-f92ba86dce67@tessares.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-07-11 at 12:22 +0200, Matthieu Baerts wrote:
> On 10/07/2023 18:51, Paolo Abeni wrote:
> > On Fri, 2023-07-07 at 18:00 +0200, Matthieu Baerts wrote:
> > > Here is the implementation of an idea I suggested a few months ago: i=
t
> > > is a factoring of the sockopt code trying to uniform it, mainly to re=
ly
> > > on {ip,ipv6,tcp}_[gs]etsockopt() instead of copying what is done ther=
e
> > > to get and set values.
> > >=20
> > > That's a first step. More might come if we are OK with the approach,
> > > e.g.
> > >=20
> > > - For SOL_TCP socket options we cannot store info in the MPTCP socket=
 so
> > >   we still need to "manually" store it somewhere in the msk. Maybe we
> > >   could store info in the different subflows (and create a first one =
if
> > >   there is no subflow) and retrieve info from there?
> > >=20
> > > - For SOL_SOCKET socket options, it looks like it should be feasible =
to
> > >   do something similar to what I did here but I'm probably missing
> > >   something. This could clean quite a lot of code, e.g. the last comm=
it
> > >   from:
> > >=20
> > >     https://github.com/matttbe/mptcp_net-next/commits/b4/mptcp-unify-=
sockopt-issue-353
> > >=20
> > > - To sync the socket options when a new subflow has been created, for
> > >   the moment, we copy info from the msk to the subflow but maybe it
> > >    would be fine to call some getsockopt() / setsockopt() to do the
> > >   sync? If we take this approach, we might want to save a list of
> > >   setsockopt() that have been done in the past on this socket and onl=
y
> > >   re-do these ones? That should help with the maintenance of these
> > >   socket options and ease the support of new ones.
> >=20
> > I would highly discourage this latest approach.
>=20
> Before going further, I want to insist on the fact that it is just an
> idea, I didn't look at the implementation (and to be honest, I was not
> looking at doing that now :) )
>=20
> > We will have to limit
> > the list length, breaking the sync at some point.
>=20
> Why would we have to limit the list length and break the sync?
>=20
> I understand having a list might not feel good but I'm not sure what
> else we can have.

Because otherwise syzkaller (or evil unprivileged user-space program)
can easily exhaust the kernel memory doing a lot of setsockopt: we need
to allocate the list entry, and we can't never flush the list.

> > And there are few
> > quite gray area, e.g. how errors should be handled?
>=20
> Same as what we have now I guess: errors are ignored :)
> But I don't see what else we can and it doesn't feel worst than before
> (regarding how we handle errors during the sync)

Note the with the current schema sync can fail only while setting the
CA, and even that requires a quite non trivial setup. If we start
replying arbitrary complex sockopt sequence, I fear the we can hit
failures much more frequently.

>=20
> > I also fear the
> > "final" state of the subflow could be different from the
> > expected/correct one for non trivial socktopt.
>=20
> I would expect it to be better because we would follow the "normal" flow
> to set values. What bother me is the fact we bypass checks and directly
> set values.=C2=A0

Actually we don't! Such checks are performed once for the sockopt on
the main/initial subflow (or by the mptcp impl).

IMHO it's safer then the list alternative. For passive socket the
latter will do the full sockopt checking using a different initial sock
internal state: the sockopt will be applied after cloning and the
related initialization.

For plain TCP sockopt value are inherited from the parent via the clone
itself, which is quite near to what the current sync implementation is
doing.

> If the code change on the different IP/TCP/SOCKET socket
> options side, we might (very likely) miss the fact we also need to
> update what we are doing on the MPTCP side, e.g. if new checks or extra
> actions (BPF/Netfilter hooks) are added later, etc. So the idea of this
> approach is to ease the maintenance (but maybe that's not needed and/or
> not worth it) :)

The eBPF maintainer mentioned that new hooks are discouraged, IIRC ;)


Cheers,

Paolo

