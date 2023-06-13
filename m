Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04D522B
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686663413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXeYk12sfTacaxZhvUbB+WJK4go5WqgMmk23xSK5g7k=;
	b=QOzVqrQC6w+b041iG82/7mYcHCL226qABKm8EgtCquOtgLej/jkgsf0fg3pzJCnAHsjcx5
	S/xEByVjSD9PudOV4QpZAYM134jQM0swocsicwfGJeAXZZ/H072IfGfBkcte9ZBASj10SY
	0vQuWgK4l0CtGX5rBNOiWjGcZy8Sk68=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-YxGbH82TNuGDBLquULrHIg-1; Tue, 13 Jun 2023 09:36:52 -0400
X-MC-Unique: YxGbH82TNuGDBLquULrHIg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75fd4851fb9so39915285a.0
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 06:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663396; x=1689255396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oju/+S7o5EAw1n2kp15/ilHcraeb2WvmltuSTzdWHTI=;
        b=GvQM+ZFGOYOG3jLGxbXIssJrLfZX+hcqmkqATDpZnN5S+WhBeRzkUkl1SY+2WJwWxd
         J2oMMW01K5smvj8ZzbzgzHBSaqjhr1ihTvfUt+dSsjWkHoXJXbegR8Di+fxGgbLlhXhc
         MqSTLc9n5KjH8u0yRB/fmKDtcCWhQq6DjcigV6ZYOVAVPlKXLZUpdoWzzHKMbbqnCGb9
         S76KBkZIkXMHm9nxXrQi4UVI0oa4XzKRIJdl8bQdqxyRcDSmzwouw2iEe3HjEHhVQpXt
         912HKgu4rVMIV3jP+5uVe0PB70tgJ2Mqj1Y0w6MDun218zVmT5vUHBjsZVpPL2u5Zk1r
         RQig==
X-Gm-Message-State: AC+VfDwIv3knkBkeb15rg55V7vuGBEHEv0i6fvykjVVMIPgB+oW4LkHs
	EsgNYTADNZTvMXv7CdcC/okbrbaygQk48jxqGWCKkfogOUiBaM7eHwZ4pSmfNVmq16NHijkV7j4
	XFrFtTXDezewWid0=
X-Received: by 2002:a05:620a:46a8:b0:75b:23a1:69f0 with SMTP id bq40-20020a05620a46a800b0075b23a169f0mr15729378qkb.7.1686663396139;
        Tue, 13 Jun 2023 06:36:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4q9HpJU+MrVaW44ShdgjiJTOEGdmeErD8qc7tHCT1ZAW0dkH+YVSB8sclNRSh7rFMoYXKvXA==
X-Received: by 2002:a05:620a:46a8:b0:75b:23a1:69f0 with SMTP id bq40-20020a05620a46a800b0075b23a169f0mr15729357qkb.7.1686663395868;
        Tue, 13 Jun 2023 06:36:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-147.dyn.eolo.it. [146.241.245.147])
        by smtp.gmail.com with ESMTPSA id y1-20020a37e301000000b00759495bb52fsm3596312qki.39.2023.06.13.06.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:36:35 -0700 (PDT)
Message-ID: <b8e34248d35aa358e60966c95d22453dd1b89ba9.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 13 Jun 2023 15:36:32 +0200
In-Reply-To: <20230613123235.GA16406@bogon>
References: <cover.1686202841.git.geliang.tang@suse.com>
	 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
	 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
	 <20230609133236.GA30403@localhost>
	 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
	 <20230610014514.GA2843@localhost>
	 <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
	 <20230612132934.GA9248@localhost>
	 <45ff221dfa3fce66e12bd76737c2dea8eeed7e00.camel@redhat.com>
	 <20230613123235.GA16406@bogon>
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

On Tue, 2023-06-13 at 20:32 +0800, Geliang Tang wrote:
> On Mon, Jun 12, 2023 at 04:22:31PM +0200, Paolo Abeni wrote:
> > """
> > Basically any access to:
> >=20
> > btf_type.array_field[valid_and_validated_variable_index]
> >=20
> > is not allowed.
> > """
> >=20
> > The above should be:
> >=20
> > =09for (int i=3D0; i < data->number_of_subflows; i++) {
> > =09=09context =3D mptcp_subflow_ctx_by_pos(i);
> > =09=09// ...
> > =09}
>=20
> "for (int i =3D 0; i < data->subflows; i++)" will get an error too:
>=20
>   The sequence of 8193 jumps is too complex.

Oops, the joy of loop unrolling! :( I almost forgot about that.

I guess/hope/think that changing this definition:

struct mptcp_sched_data {
 =09struct sock=09*last_snd;
 =09int=09=09snd_burst;
 =09bool=09=09reinject;
=09int=09=09subflows;
 =09struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };

to:

struct mptcp_sched_data {
 =09struct sock=09*last_snd;
 =09int=09=09snd_burst;
 =09bool=09=09reinject;
=09s8=09=09subflow;
 =09struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };

should "address" the issue (basically 'subflow' should have the minimum
size possible.

Or possibly even better, simply:

=09for (int i =3D 0; i < < MIN(data->subflows, MPTCP_SUBFLOWS_MAX); i++)


Or you could try using the bpf_loop() helper, even if that *looks*
slow.


Cheers,

Paolo

