Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C34522B
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686665919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9htTUUxxtmIQ4saLEjjrwiMYAUuY4/h4p4LuU1iumdk=;
	b=PfgGFYyuyVKOESJhoMHsxciOma7u1OOwjZT0xCQ3aGtcnNuR+5HRojpuxpZDzUntYAO6OW
	OPXIY14jnxRFhQ9TYIJKyGp91Hq7LO+vCZiQT3tD5gISXlgdirQCqtzPDxIT00iiyWJ+8m
	Miv4/BHWPOqXFxcHgzxZYky3q6l9TQs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-saW9gZ3XOImtZDKizJV_Fw-1; Tue, 13 Jun 2023 10:18:37 -0400
X-MC-Unique: saW9gZ3XOImtZDKizJV_Fw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7606a134623so36607685a.1
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 07:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665910; x=1689257910;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UlBwu4EdZri+BcCbJOf5ABtfdHEvP+m8N68SUe1IDo=;
        b=Z8iM5VQMUz/Cqt1KowHSZ1+vIKAvflHkDBtPfWUnra8eta1inmEkm9m8JkLXY0ATSq
         msnsAF+S/lwj4o3eFeiRxbQZEw/fCA0jlUJVZ2Ftd4q854g/4ngKsEkAxsdgFCXxpJCn
         W0r4Lkok5vNUFvI9Pqw7KWMsa2vyIMmPe7qsuREhcNTqtk+OxNS4OzTmfQZCPyyn995z
         JdHYae05ACKkpFJ3Tr+xngXmnd3PdbIZBtRaRV642BCXsuUquhKoZcP3O79cDrS05gze
         9mGZgceEK2a4nqriZ6L7Sk2qhqnw+G1anRtFnRh5ImDo42z6zG+hcyXypSZyngCYC416
         FODg==
X-Gm-Message-State: AC+VfDz2OXCsF8WNKHDIyAH58BsqPili6XBhFu6n6JDTz7NsMnFgIVC/
	kLRaJ5hQTlE4HzR82CvC2dreer6hN89wd1lGY7kNMiAS153j92U4Esu3XNEbsLaO+Ank9s8GYL1
	3ruIvCuQOPMDXvUW79G8iieo=
X-Received: by 2002:a05:6214:5297:b0:62d:fb02:e4ef with SMTP id kj23-20020a056214529700b0062dfb02e4efmr1084344qvb.2.1686665910289;
        Tue, 13 Jun 2023 07:18:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Tr4OUHoXUOz0M1tlM3KSQfpOQmoD8CUN1xuKMWXzW7KJ0xpxcRR7GCb7O9GilhqhXc4coeQ==
X-Received: by 2002:a05:6214:5297:b0:62d:fb02:e4ef with SMTP id kj23-20020a056214529700b0062dfb02e4efmr1084306qvb.2.1686665909821;
        Tue, 13 Jun 2023 07:18:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-147.dyn.eolo.it. [146.241.245.147])
        by smtp.gmail.com with ESMTPSA id a22-20020ac844b6000000b003f6c9f8f0a8sm4196627qto.68.2023.06.13.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:18:29 -0700 (PDT)
Message-ID: <bbf9a4b5d58ae77150d34cb6f3c3ada6940e82c5.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 13 Jun 2023 16:18:27 +0200
In-Reply-To: <20230613140338.GA22458@bogon>
References: <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
	 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
	 <20230609133236.GA30403@localhost>
	 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
	 <20230610014514.GA2843@localhost>
	 <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
	 <20230612132934.GA9248@localhost>
	 <45ff221dfa3fce66e12bd76737c2dea8eeed7e00.camel@redhat.com>
	 <20230613123235.GA16406@bogon>
	 <b8e34248d35aa358e60966c95d22453dd1b89ba9.camel@redhat.com>
	 <20230613140338.GA22458@bogon>
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

On Tue, 2023-06-13 at 22:03 +0800, Geliang Tang wrote:
> On Tue, Jun 13, 2023 at 03:36:32PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-06-13 at 20:32 +0800, Geliang Tang wrote:
> > > On Mon, Jun 12, 2023 at 04:22:31PM +0200, Paolo Abeni wrote:
> > > > """
> > > > Basically any access to:
> > > >=20
> > > > btf_type.array_field[valid_and_validated_variable_index]
> > > >=20
> > > > is not allowed.
> > > > """
> > > >=20
> > > > The above should be:
> > > >=20
> > > > =09for (int i=3D0; i < data->number_of_subflows; i++) {
> > > > =09=09context =3D mptcp_subflow_ctx_by_pos(i);
> > > > =09=09// ...
> > > > =09}
> > >=20
> > > "for (int i =3D 0; i < data->subflows; i++)" will get an error too:
> > >=20
> > >   The sequence of 8193 jumps is too complex.
> >=20
> > Oops, the joy of loop unrolling! :( I almost forgot about that.
> >=20
> > I guess/hope/think that changing this definition:
> >=20
> > struct mptcp_sched_data {
> >  =09struct sock=09*last_snd;
> >  =09int=09=09snd_burst;
> >  =09bool=09=09reinject;
> > =09int=09=09subflows;
> >  =09struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
> >  };
> >=20
> > to:
> >=20
> > struct mptcp_sched_data {
> >  =09struct sock=09*last_snd;
> >  =09int=09=09snd_burst;
> >  =09bool=09=09reinject;
> > =09s8=09=09subflow;
> >  =09struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
> >  };
> >=20
> > should "address" the issue (basically 'subflow' should have the minimum
> > size possible.
> >=20
> > Or possibly even better, simply:
> >=20
> > =09for (int i =3D 0; i < < MIN(data->subflows, MPTCP_SUBFLOWS_MAX); i++=
)
> >=20
> >=20
> > Or you could try using the bpf_loop() helper, even if that *looks*
> > slow.
>=20
> "for (int i =3D 0; i < min(data->subflows, MPTCP_SUBFLOWS_MAX); i++)"
> doesn't work but this works:
>=20
>   for (int i =3D 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++)

Oh wow! the above looks like a verifier bug to me ?!? perhaps it should
be reported to the ebpf ML ?!?

> So I just updated the patch and sent it to ML, named "mptcp: make the
> contexts array of sched_data invisible in BPF". Please give me some
> suggestions about it.

I'll have a look.

Thanks!

Paolo

