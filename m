Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFB28ED
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 15:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677164457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjQP9/5yfDM8UhAVxTQfFJIS0IKHRD0tDRPTou6rbnA=;
	b=dA0vg7lPe2OwWiydEBgT+0iqr/MqZ4C1rR0nr0y0dasTkALGLhh0WARVhNYsv/czjwredW
	8urgsoMwEiiGz3rO+2bbL49zKGvop92y88L48SM1TzuhDyvYUS/FlGXWPAiz/rbb1yFdey
	aiWXwRQNlRzoK2gfjmFJR0crJxSnc0M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-alBLogAINk2I0MGLmHPa9w-1; Thu, 23 Feb 2023 10:00:56 -0500
X-MC-Unique: alBLogAINk2I0MGLmHPa9w-1
Received: by mail-wm1-f72.google.com with SMTP id f14-20020a7bcc0e000000b003dd41ad974bso4392813wmh.3
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 07:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677164454;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6ghytxA+p35dKAcFlsfZIqAw8bpqW8LVdSk3soYKM8=;
        b=GLh3SItQsVxIFaWmLbOltP4Qi5WNvqgvdyne1spJu3M7C6SjDUFZdJ33172n29H7yF
         To9oqGzSuzddM0G05tWnmaQmzGc2rdKkppHp8NyEX8/PdoMhWHNlYboklWYvgn1W6Nm3
         FA2AnLk41c0GpwWoGP22YCAnvqAc2M1CEJ5gHtxYce1N9FEuexa2lB2jvtkRJdv/PLWp
         lbHtm9vj/R9pz9FPsu3bJikSuRueJR4pT+wPSCS5rSKFWLq+wWjfx4NTcMOLjh3DJLUY
         x+MYH8qx1wfkuDOl/p0B0QEY7h/eysoCgGgHo1k/fnPsXQW0uaG2UUQ0wBej0NJUqqZZ
         kC+g==
X-Gm-Message-State: AO0yUKVbzXaKCwDUvP0i2ca9GtSKyfXeNp+hGk8xS+PgBjCmfRkMUSjM
	lOuDM4qsbyxPuvvPp6MhFfdr/gfqjIyVJVnCLpkNQkw87ANwhSgJCikSsbvjnvNIbDMiTSLGpyL
	XfBON06vBEs0bPSClxvFi
X-Received: by 2002:a1c:7718:0:b0:3e2:17c2:fc8 with SMTP id t24-20020a1c7718000000b003e217c20fc8mr9568069wmi.2.1677164454537;
        Thu, 23 Feb 2023 07:00:54 -0800 (PST)
X-Google-Smtp-Source: AK7set9Jlcs/Q7mL8diPb8PVnT0aZzS1+ps7FZDqu4pSn3Tc98loBTnb+z9NwjStZ4uma0M9o/OfLQ==
X-Received: by 2002:a1c:7718:0:b0:3e2:17c2:fc8 with SMTP id t24-20020a1c7718000000b003e217c20fc8mr9568046wmi.2.1677164454169;
        Thu, 23 Feb 2023 07:00:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id z16-20020a1c4c10000000b003e2096da239sm11145357wmf.7.2023.02.23.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:00:53 -0800 (PST)
Message-ID: <b467799eb9dea501f326106615b5b34b5c917a93.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: avoid setting TCP_CLOSE state twice
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 23 Feb 2023 16:00:52 +0100
In-Reply-To: <2c17ceb5-09c8-18c2-24e4-cd094d5933bf@tessares.net>
References: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
	 <20230221-mptcp-warn-tcp-done-close-v1-1-d248242b29b6@tessares.net>
	 <5634a811ff8da65d6063ec03218a6462f5a189e7.camel@redhat.com>
	 <2c17ceb5-09c8-18c2-24e4-cd094d5933bf@tessares.net>
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

On Wed, 2023-02-22 at 16:25 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 22/02/2023 15:32, Paolo Abeni wrote:
> > On Tue, 2023-02-21 at 18:54 +0100, Matthieu Baerts wrote:
> > > tcp_set_state() is called from tcp_done() already.
> > >=20
> > > There is then no need to first set the state to TCP_CLOSE, then call
> > > tcp_done().
> > >=20
> > > Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/362
> > > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > ---
> > >  net/mptcp/subflow.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index 28c64811a8af..a36d1b1088d7 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -406,7 +406,6 @@ void mptcp_subflow_reset(struct sock *ssk)
> > >  =09/* must hold: tcp_done() could drop last reference on parent */
> > >  =09sock_hold(sk);
> > > =20
> > > -=09tcp_set_state(ssk, TCP_CLOSE);
> > >  =09tcp_send_active_reset(ssk, GFP_ATOMIC);
> > >  =09tcp_done(ssk);
> > >  =09if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->fl=
ags) &&
> > >=20
> >=20
> > I think this one could be squashed to:
> >=20
> > mptcp: fix possible deadlock in subflow_error_report
> >=20
> > WDYT?
>=20
> Thank you for your reply!
>=20
> I'm a bit confused: the commit you mention ("mptcp: fix possible
> deadlock in subflow_error_report"):
> - modifies subflow_error_report() function
> - fixes 15cc10453398 ("mptcp: deliver ssk errors to msk")
>=20
> While my patch here:
> - modifies mptcp_subflow_reset() function
> - fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>=20
> They seem to fix different issues: better to keep them separated, no?

I'm sorry I picked the wrong commit.

What I meant is that I thought the above change could stay together
with the commit introducing:

=09if (ssk->sk_state =3D=3D TCP_CLOSE)
=09=09return;

in mptcp_subflow_reset() - that is "mptcp: refactor passive socket
initialization" unless I'm wrong again.

Reading again the code and the git history, I now agree it's better
keep this change separate.

Cheers,

Paolo



