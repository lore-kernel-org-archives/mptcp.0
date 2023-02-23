Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B52C9E
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677170323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2JeZy0+RXlwXFIjgeuKXms5zvirKeDj4kjCKyZHW9Q=;
	b=bb6yeS2yYAc4mNXwbuaEHlRDF75UMcIH2VErHLxskVV5skzpsLFQmPjNzoi6dRWxGewX9r
	oVVWWAmS083UcfgnDxMzzmHpfVe6CQ/lLeARH0cwScQIHovMOZ6RjuCIq1K0csMAlX5Xt0
	/Wy98j5dKDQ8n016tgXqbdlwzO5P+2M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-442-HHlRUmRnOT63yejjhLF70w-1; Thu, 23 Feb 2023 11:38:41 -0500
X-MC-Unique: HHlRUmRnOT63yejjhLF70w-1
Received: by mail-qt1-f199.google.com with SMTP id 18-20020ac85652000000b003ba266c0c2bso5298302qtt.5
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 08:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677170314;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P//jP3bjQ3S2RkoC9jkWy6pYePPppsF/e5v/Xv8wi0I=;
        b=35dHTM44+PcGmWtfXOAJ6GykIk1TaLKakakhInochc3znt0UI0L5aQ1xoS+K1vkl96
         4aJsMdB6lojWcezasTmBT8bAuM7+Hk3AZGtyNPwz8ZsxOnWMSHp2xhlXcMdxafPLuj5R
         pWKyeo/gA+q/m12V+dDYAM2yaBh8b41ZvZI5hjLOb9pILrrTP20RYLPIXjfU5HK1n9ug
         AGJvt4czTtbC8idMfwYJCEQAoRSeC825a8vhEh3DJZ/gNQyguLORDlfObQtEV1TmI18E
         qtYzGgC+kTe4UyZ1cybq0O68iuO9386Nvh5Tlod8KMaaA/AiHx5ggCUyhKWRDtaXV72Y
         zR4Q==
X-Gm-Message-State: AO0yUKUp/lSQQ5CAh/wHKVYpdDeghX5A61Ni46YmZARuCphQwObALaYP
	XP9zGOdAWE9gqd/J6dXHYYfG2+tixz4IbTB/OhMOh3Hgwb0d0WPUSNxpbWwDK2V3W910QDcD1bn
	l4Abw5oeczbq9ixYIg//a
X-Received: by 2002:a05:622a:2c2:b0:3b8:5dfe:c3dc with SMTP id a2-20020a05622a02c200b003b85dfec3dcmr25333299qtx.3.1677170314665;
        Thu, 23 Feb 2023 08:38:34 -0800 (PST)
X-Google-Smtp-Source: AK7set9R9VCGsXE5MenLMV5Lzz8hnKXdxTdVg0YJbGmUe0W7xTMmh7VdKlZ2ZJm7yXGltpfWmXP51Q==
X-Received: by 2002:a05:622a:2c2:b0:3b8:5dfe:c3dc with SMTP id a2-20020a05622a02c200b003b85dfec3dcmr25333259qtx.3.1677170314358;
        Thu, 23 Feb 2023 08:38:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id 193-20020a370aca000000b00741b312c899sm5372406qkk.6.2023.02.23.08.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 08:38:33 -0800 (PST)
Message-ID: <c3f15ab329f7e21fe15dbbd52387ccc8dddd7751.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: avoid setting TCP_CLOSE state twice
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 23 Feb 2023 17:38:31 +0100
In-Reply-To: <6be644a3-e0d5-8da0-4b93-8c12ae961a04@tessares.net>
References: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
	 <20230221-mptcp-warn-tcp-done-close-v1-1-d248242b29b6@tessares.net>
	 <5634a811ff8da65d6063ec03218a6462f5a189e7.camel@redhat.com>
	 <2c17ceb5-09c8-18c2-24e4-cd094d5933bf@tessares.net>
	 <b467799eb9dea501f326106615b5b34b5c917a93.camel@redhat.com>
	 <6be644a3-e0d5-8da0-4b93-8c12ae961a04@tessares.net>
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

On Thu, 2023-02-23 at 16:40 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 23/02/2023 16:00, Paolo Abeni wrote:
> > On Wed, 2023-02-22 at 16:25 +0100, Matthieu Baerts wrote:
> > > Hi Paolo,
> > >=20
> > > On 22/02/2023 15:32, Paolo Abeni wrote:
> > > > On Tue, 2023-02-21 at 18:54 +0100, Matthieu Baerts wrote:
> > > > > tcp_set_state() is called from tcp_done() already.
> > > > >=20
> > > > > There is then no need to first set the state to TCP_CLOSE, then c=
all
> > > > > tcp_done().
> > > > >=20
> > > > > Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> > > > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/36=
2
> > > > > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > > > ---
> > > > >  net/mptcp/subflow.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >=20
> > > > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > > > index 28c64811a8af..a36d1b1088d7 100644
> > > > > --- a/net/mptcp/subflow.c
> > > > > +++ b/net/mptcp/subflow.c
> > > > > @@ -406,7 +406,6 @@ void mptcp_subflow_reset(struct sock *ssk)
> > > > >  =09/* must hold: tcp_done() could drop last reference on parent =
*/
> > > > >  =09sock_hold(sk);
> > > > > =20
> > > > > -=09tcp_set_state(ssk, TCP_CLOSE);
> > > > >  =09tcp_send_active_reset(ssk, GFP_ATOMIC);
> > > > >  =09tcp_done(ssk);
> > > > >  =09if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)=
->flags) &&
> > > > >=20
> > > >=20
> > > > I think this one could be squashed to:
> > > >=20
> > > > mptcp: fix possible deadlock in subflow_error_report
> > > >=20
> > > > WDYT?
> > >=20
> > > Thank you for your reply!
> > >=20
> > > I'm a bit confused: the commit you mention ("mptcp: fix possible
> > > deadlock in subflow_error_report"):
> > > - modifies subflow_error_report() function
> > > - fixes 15cc10453398 ("mptcp: deliver ssk errors to msk")
> > >=20
> > > While my patch here:
> > > - modifies mptcp_subflow_reset() function
> > > - fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> > >=20
> > > They seem to fix different issues: better to keep them separated, no?
> >=20
> > I'm sorry I picked the wrong commit.
> >=20
> > What I meant is that I thought the above change could stay together
> > with the commit introducing:
> >=20
> > =09if (ssk->sk_state =3D=3D TCP_CLOSE)
> > =09=09return;
> >=20
> > in mptcp_subflow_reset() - that is "mptcp: refactor passive socket
> > initialization" unless I'm wrong again.
>=20
> All good, thank you for the explanations, now I see the link!
>=20
> > Reading again the code and the git history, I now agree it's better
> > keep this change separate.
>=20
> Great!
>=20
> Can I interpret that as a "Acked-by" for the small series? :-)

Sure! Just to be redundant:=20

Acked-by: Paolo Abeni <pabeni@redhat.com>

/P=20

