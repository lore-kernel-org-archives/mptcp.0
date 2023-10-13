Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3719BB2
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFbJWMXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697211352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tvbwksz4EBeoB4aGkmbIGxCCqkO/f1ieJPGgEqMZKxs=;
	b=OFbJWMXD6NMRxR5A44kHUqedHgQxniWl31RT6vTaeHd6bA0zQ/sqjtmXErin0N+spLW0ib
	+AC6MVsKxhzy1Q3JeXMhM1ZDNpiueRGYhP8lPQ2hqb/ggm+YjZ4ibTGajKNrenkVGFQ+hr
	L8XJ7nMVqKR6jqrLxzCWChK/ajypMVo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-Ts_AXrtfOf2cxJSijIz11w-1; Fri, 13 Oct 2023 11:35:51 -0400
X-MC-Unique: Ts_AXrtfOf2cxJSijIz11w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae56805c41so43608866b.0
        for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 08:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211350; x=1697816150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IVkj2w8mS5zDrl+pZ4OSlSF/cObh++l9YjFWtejje/o=;
        b=W21FuMWoVVa1VbUgyIt53UaZHTaBxWYhUMS7lMKjNPXOJIxtCDS2KRbNAh1XW1D6Jb
         VD7YCQyN7lVoJoCm5AI6zYRABk/93v2qvKWfEjjTlNf+XsxddHERHLzMItwHZznbMS0y
         UNhPGXZmtbpag3VVQdsziePTcqFiyoaPeoBtMrif88L0RHUjktDUQFGRReosv8K/Xv1R
         0xmNacts8ckdFJk00ZxNhriD1MZ7xxb3JJX84/6hLMWHYJnTA31EXyoP4Y3nzBjuXX+R
         Y91NVLxOapfG72sqzRh/BHyf1ERTF7RfgKNDwin4wKp40cuaQJzXqCC6HY55wpGxkmE2
         0X0w==
X-Gm-Message-State: AOJu0YycH9829ZpYhyTQi9weppKj+ksZ6qi51ihvrZp8mXRo+xl40Xin
	SrUB+GaG2DtO+9lLdqsb8OF9H3yOePctvTOi7gZEOJUXFSYVpG/0Dhbk83k1vbKsdJKFt7nHZDc
	QRGPLDXVUPo4AlHU+l8NbMCM=
X-Received: by 2002:a17:907:763b:b0:9be:3483:94da with SMTP id jy27-20020a170907763b00b009be348394damr110478ejc.1.1697211349702;
        Fri, 13 Oct 2023 08:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ65sgxc7uDic7Ohon97gIL8K3DwoAxksKpQPX8wOFVulxmnYsakKwW8dDWuhe0Nse4AX7hA==
X-Received: by 2002:a17:907:763b:b0:9be:3483:94da with SMTP id jy27-20020a170907763b00b009be348394damr110461ejc.1.1697211349284;
        Fri, 13 Oct 2023 08:35:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-54.dyn.eolo.it. [146.241.235.54])
        by smtp.gmail.com with ESMTPSA id lz6-20020a170906fb0600b0099cf9bf4c98sm12484797ejb.8.2023.10.13.08.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:35:48 -0700 (PDT)
Message-ID: <5f72f297be7687b86eec5ac19ef51c8a3df98048.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v16 3/8] Squash to "mptcp: add
 mptcpi_subflows_total counter"
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang
 <geliang.tang@suse.com>,  mptcp@lists.linux.dev
Date: Fri, 13 Oct 2023 17:35:47 +0200
In-Reply-To: <b7f0d827-ff8f-4348-be2b-c33e56b736ff@kernel.org>
References: <cover.1697175899.git.geliang.tang@suse.com>
	 <4f136ef2b23fb55e2e42397f1e07e74b355d5f61.1697175899.git.geliang.tang@suse.com>
	 <e3769002c1ff6139f9359413cd1ad415e593a3f2.camel@redhat.com>
	 <b7f0d827-ff8f-4348-be2b-c33e56b736ff@kernel.org>
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

On Fri, 2023-10-13 at 12:46 +0200, Matthieu Baerts wrote:
> On 13/10/2023 12:32, Paolo Abeni wrote:
> > Hi,
> >=20
> > On Fri, 2023-10-13 at 13:46 +0800, Geliang Tang wrote:
> > > Update __mptcp_has_initial_subflow().
> > >=20
> > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > ---
> > >  net/mptcp/protocol.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > index 6508179e94a6..1fb4ac3727c4 100644
> > > --- a/net/mptcp/protocol.h
> > > +++ b/net/mptcp/protocol.h
> > > @@ -1081,7 +1081,7 @@ static inline bool __mptcp_has_initial_subflow(=
const struct mptcp_sock *msk)
> > >  {
> > >  =09struct sock *ssk =3D READ_ONCE(msk->first);
> > > =20
> > > -=09return ssk && inet_sk_state_load(ssk) !=3D TCP_CLOSE;
> > > +=09return ssk && inet_sk_state_load(ssk) =3D=3D TCP_ESTABLISHED;
> >=20
> > I think the above is not correct, __mptcp_has_initial_subflow() will
> > return false before connect completes and/or for listener sockets.
>=20
> Please note that __mptcp_has_initial_subflow() is there just to count
> the number of subflows. It is being used with 'msk->pm.subflows' and it
> is supposed to have the same "behaviour". Then I don't think we should
> increment the subflow counter for listener sockets, no?

If the goal is giving an accurate count of the total number of
subflows, I think we should: the msk listener has 1 subflow: the tcp
listener.

> > You can list explicitly add the valid states with something alike:
> >=20
> > =09(1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED |
> > TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_LISTEN | TCPF_CLOSE_WAIT)
> >=20
> > I'm unsure if we should include CLOSE_WAIT here: the remote has shut
> > down, but this end can still send data...
>=20
> Maybe better, no? As long as the behaviour is similar to the one with
> 'msk->pm.subflows'.

If we keep the way we account for MPJ subflows as a reference
CLOSE_WAIT status must be excluded. I agree/now see it's the better
option.

> > Side important note: you are too fast :) There are a lot of in-flight
> > patches, and it's difficult to follow each series consistently. I
> > suggest to focus on a small subset - possibly on a single series at the
> > time.
> >=20
> > e.g. The first 2 patches in this series are IMHO ready to be merged
> > [*]. If Mat could apply them, you could follow-up with the remaining
> > bits of this series.
>=20
> Sure, I can do that.
>=20
> Regarding patch 1/8, do you think we should send that to "-net"? The
> patch looks OK to me but on the other hand, it is not a big issue to
> reset the initial subflow (but not ideal) if we fear regressions due to
> this patch. WDYT?

I think both patch 1 & 2 should go via -net, but I'm not 110% sure
there will be not regressions free. Perhaps we can let stage a bit in
our tree?

> > [*] modulo some expansion to the changelog of patch 1, but that could
> > happen even after merging IMHO.
>=20
> Indeed. But we might forget :)
> So if you have any suggestions, do not hesitate to share them :-)

I would re-phrase the commit message roughly as follow:

"""
When closing the first subflow, the MPTCP protocol unconditionally
calls tcp_disconnect(), which in turn generates a reset if the subflow
is established.=20

That is unexpected and different from what MPTCP does with MPJ
subflows, where resets are generated only on FASTCLOSE and other edge
scenarios.

We can't reuse for the first subflow the same code in place for MPJ
subflows, as MPTCP clean them up completely via a tcp_close() call,
while must keep the first subflow socket alive for later re-usage, due
to implementation constraints.

This patch adds a new helper __mptcp_subflow_disconnect() that
encapsulates, a logic similar to tcp_close, issuing a reset only when
the MPTCP_CF_FASTCLOSE flag is set, and performing a clean shutdown
otherwise.
"""

Cheers,

Paolo

