Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968717757
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686324842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRjVQ6ZVsSaCBUgsgSBwJpuTnXkte2nq+4pjPk5OA6k=;
	b=WZ6qDytE/9my0D1kzdIvFtxlH055pKLwakbQuoqrU2wWRI87dVlYsvogHgoFbvE+rc/nDx
	lFtltsJqVzRsIydZszpNQONcUMEGQ7KMxP9sZkTFd1d7hDbRlEL0r+ghKvL/5ApwVXrav3
	t+dGFpZXd93vcm2Q4NCWehEbdv34dmk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-xixZiiVZMOiPe9HElO9g8Q-1; Fri, 09 Jun 2023 11:34:00 -0400
X-MC-Unique: xixZiiVZMOiPe9HElO9g8Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7e6648625so2649865e9.1
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324839; x=1688916839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pL55jfI39Ai2e0dGWrigGwhT+7fDMtvpVlf58gSJYXA=;
        b=JzX1cwgC9pAAMU0x37kiuKS2pvrfV2kB3rCL7YCHhtsLJo4axhSgpXonLXGcivLxCy
         nkrwWOXNPX2x4wEDyjnn28tepJbuyjWm9KWQuX6I06sxRVyPixCrw9qr+os8KhmXJVhH
         G1gA/69k5hk8A5pUmcuYltlZzVbTuJYGDAALJzj1AHWWNkQcY0yb7LMqwp6om8DMTJjC
         /GJTeE+rWe+WQsYjonXU6iGX9pAEVxLhaIH2eFzr5kmDdeEuB5Nf5lVWeSRb9059uVmc
         gNyhv5Sq8M/yt0r4Nztbmk3vdKgeffgxnhGPYiUubr9Vu2fw9E1p5YzTNrIXIy6kOeNV
         XX8w==
X-Gm-Message-State: AC+VfDyxy+aXFT40ugJFDb75TzloEVBBVppXYbhH67GP5Ofz+Fqyckql
	UzScIUxUBpkGLElq57+dTh1eEdC6kwhZlN53iGc2V7OKOQ6dR+RNTHocnTo+eaXxVapoWrybgPF
	zbbUYP2x39zOK/IZjdwvfk3Q=
X-Received: by 2002:a05:600c:5191:b0:3f6:487:f058 with SMTP id fa17-20020a05600c519100b003f60487f058mr1674146wmb.1.1686324839462;
        Fri, 09 Jun 2023 08:33:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6AR58rtYlHYjoOkkY2T5p4LEbf6F28FWq4bNyEkLSBEfqGH3quUDZ0RJzCsHuTbN/oegZYqQ==
X-Received: by 2002:a05:600c:5191:b0:3f6:487:f058 with SMTP id fa17-20020a05600c519100b003f60487f058mr1674130wmb.1.1686324839092;
        Fri, 09 Jun 2023 08:33:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm4749918wro.98.2023.06.09.08.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:33:58 -0700 (PDT)
Message-ID: <05dcfd0a58fc3effd7ab27c8866dc45636d1624f.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix potential msk leak
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 09 Jun 2023 17:33:57 +0200
In-Reply-To: <0097924b-3275-6b09-51ad-69e1bdce1199@tessares.net>
References: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
	 <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
	 <a0a3cc11-8ea1-f9ca-ebd9-0bc3d7a3bae9@tessares.net>
	 <bbb5825bc0b0d5fd9755de885ba28c900f78efac.camel@redhat.com>
	 <0097924b-3275-6b09-51ad-69e1bdce1199@tessares.net>
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

On Fri, 2023-06-09 at 17:32 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 09/06/2023 17:31, Paolo Abeni wrote:
> > On Fri, 2023-06-09 at 16:52 +0200, Matthieu Baerts wrote:
> > > Hi Paolo,
> > >=20
> > > On 07/06/2023 18:33, Paolo Abeni wrote:
> > > > An orphaned msk releases the used resources via the worker,
> > > > when the latter first see the msk in CLOSED status.
> > > >=20
> > > > If the msk status transitions to TCP_CLOSE in the release callback
> > > > invoked by the worker's final release_sock(), such instance of the
> > > > workqueue will not take any action.
> > > >=20
> > > > Additionally the MPTCP code prevents scheduling the worker once the
> > > > socket reaches the CLOSE status: such msk resources will be leaked.
> > > >=20
> > > > The only code path that can trigger the above scenario is the
> > > > __mptcp_check_send_data_fin() in fallback mode. Address the issue
> > > > simply removing the dangerous state change: the msk will be closed
> > > > soon by the worker itself, triggered by MPTCP_WORK_CLOSE_SUBFLOW.
> > > >=20
> > > > Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks=
")
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > >  net/mptcp/protocol.c | 10 ++++------
> > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index 94229a318fc1..e93a678d057f 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -2936,16 +2936,14 @@ static void __mptcp_check_send_data_fin(str=
uct sock *sk)
> > > >  =09WRITE_ONCE(msk->snd_nxt, msk->write_seq);
> > > > =20
> > > >  =09/* fallback socket will not get data_fin/ack, can move to the n=
ext
> > > > -=09 * state now
> > > > +=09 * state now. But can't set TCP_CLOSE here, as this code path i=
s
> > > > +=09 * reachable from the mptcp_release_cb(). Anyway the subflow wi=
ll
> > > > +=09 * close soon and the msk state will follow via WORK_CLOSE_SUBF=
LOW.
> > > >  =09 */
> > > >  =09if (__mptcp_check_fallback(msk)) {
> > > >  =09=09WRITE_ONCE(msk->snd_una, msk->write_seq);
> > > > -=09=09if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
> > > > -=09=09=09inet_sk_state_store(sk, TCP_CLOSE);
> > > > -=09=09=09mptcp_close_wake_up(sk);
> > >=20
> > > Where are we going to wake up the userspace if we don't do it here fo=
r
> > > fallback connections?
> > >=20
> > > Via subflow_state_change() which will set MPTCP_WORK_EOF flag?
> >=20
> > Uhm... that could be problematic, as subflow->rx_eof could be already
> > set and mptcp_subflow_eof() will not trigger. So this patch is not
> > correct.
> >=20
> > Additionally that eof notification looks rendundant. I need to think a
> > bit more how to clean things up.
>=20
> Thank you for having looked at that!
>=20
> Do you want me to already applied the first patch?
=20
Thank, it would be better. The next version here could take a lot, I
fear :(

/P

