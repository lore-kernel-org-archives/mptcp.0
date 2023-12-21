Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9754E1AA
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBGjyYIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703152806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpLV9NZc8ihT0TX03X9+dZdRPxgqbvk3uwY5xHi5EDI=;
	b=gBGjyYIZ2Dm8cQQnBzCRxRdErd//HYHMQkYTFR706BNBYMn/N9ynbhweXThX4wFdvhEZtc
	hJz2ZWj+r4geUXZm3uPsCunUWEmYfxoWbKR0/mZsmqFXTJ+Si7eIhPYZQLT3xgZpA+Qham
	ZWCupVJcnIsKRGpWbn3GaSsifknuiDQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-ekKQ4vzxOZOKeC4A-A81fg-1; Thu, 21 Dec 2023 05:00:04 -0500
X-MC-Unique: ekKQ4vzxOZOKeC4A-A81fg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2cc7c930c09so756041fa.0
        for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 02:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152803; x=1703757603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3KF8ZC+h2qw6DPbkYxE73zWQ53xEy/yOggb895PjXk=;
        b=ECYOfPEEGmdEXRsHZG3BYmpZw1ZqHQK0jIoi5mKognrq5NRUG1UFoaQ589SCL+5hxp
         blFN6M6N8nAFBiPRbLvrtEBsIf+D36tKYKcDb93Q2hb+tEKjPK3h8+2phecJJQYm77Es
         /Jbe1UsF/EtYytLIFCf6hGosX5/Ch+uNX/KdLt/OeFfhJfbuOivOiuZFEs2m0otfI1o/
         Rw0fq9pkx9cYpokQyJiaIBSQ1aP6kqT7f7wLWeyVKcpVMyrJI8BDMxtccL+QMaOaOnZc
         lfzAmiOa+hvkHRWZBpNrDAPE+6lskPGy1SgaEtC0mqGbfLcNkoMBsygkUNiThkSQIonz
         n7Hw==
X-Gm-Message-State: AOJu0YwsdJlWBJ1CqHS2saNLjoJiWiqf8Y5kH6u84e2fAH9qh6oheOry
	9VCitzT7p/sxsvKVNyJMrIXWBydLRn5DV+PLCdk3h9IsCvAODdId7HXinwcUGry8x1YIAQVFJJA
	qiGjbrHhXYWSaxEY=
X-Received: by 2002:a2e:8889:0:b0:2cc:916c:e328 with SMTP id k9-20020a2e8889000000b002cc916ce328mr2403766lji.4.1703152802850;
        Thu, 21 Dec 2023 02:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt97jItd1iP832OuJVQhNN/nvGGt9xqvDzoNlszeFMmzxDJ2Sws2y3m4H8GbGd0HrYFoideQ==
X-Received: by 2002:a2e:8889:0:b0:2cc:916c:e328 with SMTP id k9-20020a2e8889000000b002cc916ce328mr2403738lji.4.1703152802396;
        Thu, 21 Dec 2023 02:00:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-124.dyn.eolo.it. [146.241.246.124])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7dc04000000b0055282cb1033sm954247edu.3.2023.12.21.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:00:01 -0800 (PST)
Message-ID: <fcbef549bf392f4da466e1c8d56399d1e8fdf6c2.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: prevent tcp diag from closing listener
 subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Thu, 21 Dec 2023 11:00:00 +0100
In-Reply-To: <f8f6d53f-4fcb-2531-4fa6-b0afbeb0eabc@kernel.org>
References: <f6371f65b1ebabc0f308528494ec39c9bdf786fd.1702631517.git.pabeni@redhat.com>
	 <f8f6d53f-4fcb-2531-4fa6-b0afbeb0eabc@kernel.org>
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

On Fri, 2023-12-15 at 16:47 -0800, Mat Martineau wrote:
> On Fri, 15 Dec 2023, Paolo Abeni wrote:
>=20
> > The MPTCP protocol does not expect that any other entity could change
> > the first subflow status when such socket is listening.
> > Unfortunately the TCP diag interface allows aborting any TCP socket,
> > including MPTCP listeners subflows. As reported by syzbot, that trigger
> > a WARN() and could lead to later bigger trouble.
> >=20
> > The MPTCP protocol needs to do some MPTCP-level cleanup actions to
> > properly shutdown the listener. To keep the fix simple, prevent
> > entirely the diag interface from stopping such listeners.
> >=20
> > We could refine the diag callback in a later, larger patch targeting
> > net-next.
> >=20
> > Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updatin=
g the sk status")
> > Closes: https://lore.kernel.org/netdev/0000000000004f4579060c68431b@goo=
gle.com/
> > Reported-by: syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/subflow.c | 13 +++++++++++++
> > 1 file changed, 13 insertions(+)
> >=20
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 64302a1ac306..1f98bec264a6 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1981,6 +1981,17 @@ static void tcp_release_cb_override(struct sock =
*ssk)
> > =09tcp_release_cb(ssk);
> > }
> >=20
> > +static int tcp_abort_override(struct sock *ssk, int err)
> > +{
> > +=09/* closing a listener subflow requires a great deal of care.
> > +=09 * keep it simple and just prevent such operation
> > +=09 */
> > +=09if (inet_sk_state_load(ssk) =3D=3D TCP_LISTEN)
> > +=09=09return -EINVAL;
> > +
> > +=09return tcp_abort(ssk, err);
>=20
> Hi Paolo -
>=20
> I looked around the code to see if there might be issues with an=20
> unexpected tcp_abort on non-listening subflow sockets. Closest code I=20
> found was mptcp_subflow_reset(), and the main difference seems to be=20
> giving the msk a chance to clean up:
>=20
>  =09if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags)=
)
>  =09=09mptcp_schedule_work(sk);
>=20
> Worthwhile to add that in this override function?

Reporting there the discussion from the last mtg for completeness.
Async closing of mptcp listener via the worker has proven to be quite
complex and bug prone. In this case it would probably be safe, but
given the troubled git history of mptcp_check_listen_stop(), I would
keep this version for net, and do the complete thing for net-next, with
no rush.

Cheers,

Paolo

