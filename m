Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A43D61
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684487307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gR0TPmIjvmKRrffHR4hF9qlxgpnlLfm/2IyD9Hb7ZU=;
	b=Kg2DN8/He80J7Rjw6GCO+XxSv9FVx92NoW4or2EAFcVRqHpyzj1cJQY9ejUeVKQV77iLtv
	Xm4/3zkpSsc4viGcrDKbe4y+xthoEkHPz2RDnuAeIgy+kX7s7m9c5x/jQ6GOVcTS9gi3+9
	Ej8qCp39GbBA4ks5esTc6jcJmSetwNw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-83WcFadPNgu7GnKgGvI3qA-1; Fri, 19 May 2023 05:08:26 -0400
X-MC-Unique: 83WcFadPNgu7GnKgGvI3qA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f39195e7e5so6455911cf.0
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 02:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684487305; x=1687079305;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gR0TPmIjvmKRrffHR4hF9qlxgpnlLfm/2IyD9Hb7ZU=;
        b=NtKSvIJ4h2zoSNVghRL9wI0rbZm12v6ksG/aT0ikId76SZkNr8HOp1DO290XPmWChq
         B7RooyU5SgywSWvZHcPDuJE0Q6rmt7camkOJ9iIDL+J1Op8/WhcBmm3zAWY+0t+qSXma
         IIDBXddKMyulhvwCamPyqggwgpKKhwXZiG9RerbnMEJZnrMJM0tc8rTz98Bsp6X8qdVg
         Lnzo3N5dA7988WsaocT4hEp0/rHJHe/8EmBR4Ar13PYVNo31rORQA+vhdnfddMEFVSG+
         Z/acRcO91VOtXF2JplEaRhGmqv0AoPl94YjL9Xt4VhLIZuyV5wcATmd6Tn4nwAC7eob6
         8SQg==
X-Gm-Message-State: AC+VfDwouM6r6jq6wmxfiPJHKyZTTJD9yHpr10ZoRfonVRKtD+xp3t69
	I3TA7ODPi4SeaM16qgw/Hcz+Lw5DbiQkOIQpynXrWBfiPdSqoLH+eD4b8AwDBfUO4gftj7xoTYq
	M/VfZLkqjT+9yhf/2PJKJhSM=
X-Received: by 2002:a05:6214:4111:b0:623:67ac:5dee with SMTP id kc17-20020a056214411100b0062367ac5deemr2796630qvb.4.1684487305637;
        Fri, 19 May 2023 02:08:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50QBBrRH1pRVjQJ8elfMhnUQe08JcSlaVb5YTCM5SPZTqusscH6KIcC1Oe411y5+f90MW5/g==
X-Received: by 2002:a05:6214:4111:b0:623:67ac:5dee with SMTP id kc17-20020a056214411100b0062367ac5deemr2796614qvb.4.1684487305327;
        Fri, 19 May 2023 02:08:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-104.dyn.eolo.it. [146.241.235.104])
        by smtp.gmail.com with ESMTPSA id fc15-20020ad44f2f000000b006238ba3010asm1164291qvb.29.2023.05.19.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 02:08:24 -0700 (PDT)
Message-ID: <bee815a5ba93471af6d37afc6c345070a6523496.camel@redhat.com>
Subject: Re: mptcp: fix active subflow finalization.: Build Failure
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 19 May 2023 11:08:22 +0200
In-Reply-To: <8c2e1871-8343-6276-6276-de5df7f4656f@tessares.net>
References: <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
	 <9cdc6ccf-3529-8fad-5a49-4c1fd8d6feeb@gmail.com>
	 <d01c8817dd76a6d427a72a752eafb2027969fd38.camel@redhat.com>
	 <8c2e1871-8343-6276-6276-de5df7f4656f@tessares.net>
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

On Fri, 2023-05-19 at 10:03 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 19/05/2023 09:03, Paolo Abeni wrote:
> > On Thu, 2023-05-18 at 17:31 +0000, MPTCP CI wrote:
> > > Hi Paolo,
> > >=20
> > > Thank you for your modifications, that's great!
> > >=20
> > > But sadly, our CI spotted some issues with it when trying to build it=
.
> > >=20
> > > You can find more details there:
> > >=20
> > >   https://patchwork.kernel.org/project/mptcp/patch/41d7df9d8669b5fbfe=
70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com/
> > >   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/501648=
3061
> >=20
> > The failures are caused by the pre-existing sparse warning around
> > mptcp_sk_clone(), that this series rename as mptcp_sk_clone_init(). I
> > guess there is some CI rule to waive the error for the old/previous
> > function name?!? Any idea to make it generic?
>=20
> Thank you for having checked!
>=20
> I just modified the script to whitelist the new warning:
>=20
> https://github.com/multipath-tcp/mptcp-upstream-validate-export-action/co=
mmit/a9d24567
>=20
> All green now:
>=20
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5016483061/j=
obs/9005030178

Many thanks!

> I don't think we need to make it generic. I guess we will rarely rename
> the function name and/or move it elsewhere, no?

Hopefully I hope and think you are right!

/P

