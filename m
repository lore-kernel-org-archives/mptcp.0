Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0A1952B
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686324708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIfUGhfH3RP7v2jKXebIcXdkcChw7mWGT3N4/Y7ycj4=;
	b=GrBQrZzGkJSH+X+HAemHYwxmYXFjDdBhks49xZtE2HKjMCTY81WbgihEXoOGsCyKQ53rCb
	5dzc735a2VAMCP53stqDyRuCr5X2C/7gWkE48WlzO+daM8K0zLXKvaZUO5T08eaRDRhg/d
	FE2MK5xC2UPfyFv8JFD1viyHdGlAUUs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-GIrXVJLxNzWBzj9ByNrzFg-1; Fri, 09 Jun 2023 11:31:46 -0400
X-MC-Unique: GIrXVJLxNzWBzj9ByNrzFg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7f3333b2bso2652755e9.0
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324705; x=1688916705;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/FV0Sf7E+2nSaBxxYLO4IK4xcdPtWz3TqOkEUj3jOGk=;
        b=YzakaJ7oIMhJZYquxGJDlou/GCefxuD74dghJxqUhdcbkcBCn+ShGg4OrAZrP0m1jZ
         A26EdkhIBheDLhSVoUl9y8cSH+9Rg0vzakoH3njLLPFqDihlmlTgYgMH7QoRjECCojpC
         M1ooRbk6MO1RraTg10IlwtzVYlkMSbzXAzD+WdnmM+HOvToZT7yWxvVpy+49heFtFib1
         w6QewvKn8KIgOLepmhiz4qmRfO/CIlHnQyiCAwdjVBH1wWbXbVF/+Vrfc8ZNSF3UWds7
         QAqIag+RJ/wiVIAd36f4+s9REkF6l/z7UnBANLUqude2o2QnTq+yVPHBwcg2zY87JbDy
         z/TQ==
X-Gm-Message-State: AC+VfDwNJJmvcY5wN4V2RzgDP6NPLSsgjF9PLbYe7V1qmky9S85Zk8Vv
	1dzBtBPObW43V8F5zEDi2NlxdkmXVfBxlPpaTFPpJeXslageR2OD9/Oj4tjFEU8uql3AZDItTky
	P+6qlpni9geG9IYIiZ9Q80QU=
X-Received: by 2002:adf:fd84:0:b0:2c7:1c72:699f with SMTP id d4-20020adffd84000000b002c71c72699fmr1232581wrr.4.1686324705445;
        Fri, 09 Jun 2023 08:31:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46R7ipZAtYmGlc1Hc2EnKD4YCFrmeZgg/dY8bZxp9bSOEJXP1zBgjiUXfTfaf8VXkuxPhpKA==
X-Received: by 2002:adf:fd84:0:b0:2c7:1c72:699f with SMTP id d4-20020adffd84000000b002c71c72699fmr1232567wrr.4.1686324705113;
        Fri, 09 Jun 2023 08:31:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d48c4000000b0030903d44dbcsm4743529wrs.33.2023.06.09.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:31:44 -0700 (PDT)
Message-ID: <bbb5825bc0b0d5fd9755de885ba28c900f78efac.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix potential msk leak
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 09 Jun 2023 17:31:43 +0200
In-Reply-To: <a0a3cc11-8ea1-f9ca-ebd9-0bc3d7a3bae9@tessares.net>
References: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
	 <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
	 <a0a3cc11-8ea1-f9ca-ebd9-0bc3d7a3bae9@tessares.net>
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

On Fri, 2023-06-09 at 16:52 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 07/06/2023 18:33, Paolo Abeni wrote:
> > An orphaned msk releases the used resources via the worker,
> > when the latter first see the msk in CLOSED status.
> >=20
> > If the msk status transitions to TCP_CLOSE in the release callback
> > invoked by the worker's final release_sock(), such instance of the
> > workqueue will not take any action.
> >=20
> > Additionally the MPTCP code prevents scheduling the worker once the
> > socket reaches the CLOSE status: such msk resources will be leaked.
> >=20
> > The only code path that can trigger the above scenario is the
> > __mptcp_check_send_data_fin() in fallback mode. Address the issue
> > simply removing the dangerous state change: the msk will be closed
> > soon by the worker itself, triggered by MPTCP_WORK_CLOSE_SUBFLOW.
> >=20
> > Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/mptcp/protocol.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 94229a318fc1..e93a678d057f 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2936,16 +2936,14 @@ static void __mptcp_check_send_data_fin(struct =
sock *sk)
> >  =09WRITE_ONCE(msk->snd_nxt, msk->write_seq);
> > =20
> >  =09/* fallback socket will not get data_fin/ack, can move to the next
> > -=09 * state now
> > +=09 * state now. But can't set TCP_CLOSE here, as this code path is
> > +=09 * reachable from the mptcp_release_cb(). Anyway the subflow will
> > +=09 * close soon and the msk state will follow via WORK_CLOSE_SUBFLOW.
> >  =09 */
> >  =09if (__mptcp_check_fallback(msk)) {
> >  =09=09WRITE_ONCE(msk->snd_una, msk->write_seq);
> > -=09=09if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
> > -=09=09=09inet_sk_state_store(sk, TCP_CLOSE);
> > -=09=09=09mptcp_close_wake_up(sk);
>=20
> Where are we going to wake up the userspace if we don't do it here for
> fallback connections?
>=20
> Via subflow_state_change() which will set MPTCP_WORK_EOF flag?

Uhm... that could be problematic, as subflow->rx_eof could be already
set and mptcp_subflow_eof() will not trigger. So this patch is not
correct.

Additionally that eof notification looks rendundant. I need to think a
bit more how to clean things up.

Thanks!

Paolo

