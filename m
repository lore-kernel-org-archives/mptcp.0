Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061EAD3C
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686567934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwA7mXMAZLqn/tlO5iIPtUQQSKGMzCZNAoxbC3JnlzA=;
	b=AGdwMxKpTE0bjwJ+FzgB9RbFPF+n8lVNVmn7esXLRSJYaWcxqWlo0N6ax+wW1fmAG0mTl0
	OCpCn1WIJhuPsejcVzT8duWYVktRYI5D+iUM2zofIWxRZ+lT+9bl1e24D4qMQvPNmK8guC
	oEOyDVPFMIvjnyZJtrkQhGQ/vRLx7TI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-zMclwmGpNkSpdEVwKJCuZw-1; Mon, 12 Jun 2023 07:05:33 -0400
X-MC-Unique: zMclwmGpNkSpdEVwKJCuZw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f86a3ce946so9768691cf.1
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 04:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686567933; x=1689159933;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUE1AwArVPpJijC06JUEMFLcBdwo3NcED4CJkEppGfk=;
        b=iWbqoeH+ETNwJ0L33jzNCRSVA4C0PaWhLE6COrDKWN9hvosNUKViVFtBKLEXEIpf8r
         t+yzXMfUAtBfsumvd8M78+seDdP0by8K2DvfVWYnm3Z6u6cQ5z5TYVz1R/qlAG9hi7co
         18bA1tw470fWrq5ARvXj/nG76BoKC5my1GrTh5ZoYPSDfw4PA5djvAxvfuAIFO/Gssbk
         LMauW4LPpW+KI2+vnl4kYHuGuw/smnhgfEfrmh4WqgZQyJx/Pi/Wp4WojRT6cnVX70Mr
         AWXfbQMhFZeRgBmTbSBUSEFghHF2cg8OVjdfB6XqRmod05pxC7jSivKayri5JhfYOjH7
         Vlbw==
X-Gm-Message-State: AC+VfDxz3xFGbfz/4uA6RbFzDQ+uDnOKm0dnXwLKNp23fpKGWO9T4iMH
	3jNNIaUyM7cuYN+I0Y/ftjPAaOvSwps7mEv/gMTukM73fWT1WdoUyl+f7O46EGSEp3PTQAVHWPw
	x1WJh3DzCpvEYEjw=
X-Received: by 2002:a05:622a:134a:b0:3f7:f680:c922 with SMTP id w10-20020a05622a134a00b003f7f680c922mr12240819qtk.6.1686567933288;
        Mon, 12 Jun 2023 04:05:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49t8fH4MSeI6mE0O6djBrRozSGhysyzeBmvQz6tuniCs3ErBob3RdvY8tR1LaCbto4mEoA1Q==
X-Received: by 2002:a05:622a:134a:b0:3f7:f680:c922 with SMTP id w10-20020a05622a134a00b003f7f680c922mr12240791qtk.6.1686567932866;
        Mon, 12 Jun 2023 04:05:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id a22-20020ac844b6000000b003f6c9f8f0a8sm3290580qto.68.2023.06.12.04.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:05:32 -0700 (PDT)
Message-ID: <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 12 Jun 2023 13:05:30 +0200
In-Reply-To: <20230610014514.GA2843@localhost>
References: <cover.1686202841.git.geliang.tang@suse.com>
	 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
	 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
	 <20230609133236.GA30403@localhost>
	 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
	 <20230610014514.GA2843@localhost>
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

On Sat, 2023-06-10 at 09:45 +0800, Geliang Tang wrote:
> On Fri, Jun 09, 2023 at 04:40:01PM +0200, Paolo Abeni wrote:
> > On Fri, 2023-06-09 at 21:32 +0800, Geliang Tang wrote:
> > > On Fri, Jun 09, 2023 at 11:57:53AM +0200, Paolo Abeni wrote:
> > >=20
> > > > May I guess you get a similar error if you do:
> > > >=20
> > > > =09subflow =3D mptcp_subflow_ctx(ssk)
> > > >=20
> > > > ? (just out of sheer ignorance and curiosity)
> > >=20
> > > Yes. It seems that accessing 'send_info[SSK_MODE_ACTIVE].ssk' is
> > > considered unsafe in BPF context. So here we pass 'send_info[SSK_MODE=
_ACTIVE].ssk'
> > > into bpf_mptcp_subflow_ctx() to find the related subflow. Then we acc=
ess this
> > > subflow instead of 'send_info[SSK_MODE_ACTIVE].ssk' below. This can m=
ake BPF happy.
> > >=20
> > > >=20
> > > > > +=09 * then use mptcp_subflow_tcp_sock() to get the ssk.
> > > > > +=09 */
> > > > > +=09subflow =3D mptcp_subflow_tcp_sock(send_info[SSK_MODE_ACTIVE]=
.ssk, data);
> > > > > +=09ssk =3D mptcp_subflow_tcp_sock(subflow);
> > > >=20
> > > > What if you store the 'subflow' pointer in 'send_info'? Will the
> > > > verifier splat with that? and what if we store the corresponding
> > > > context index 'i' instead?
> > >=20
> > > Storing the 'subflow' or index 'i' don't work too.
> >=20
> > Uhmm... I'm very surprised about 'i'. Specifically what I mean is:
> >=20
> > struct subflow_send_info {
> > =09unsigned int subflow_id;
> > =09__u64 linger_time;
> > };
> >=20
> > // ...
> > =09for (i =3D 0; i < SSK_MODE_MAX; ++i) {
> > =09=09send_info[i].ssk =3D MPTCP_SUBFLOWS_MAX;
> > =09=09send_info[i].linger_time =3D -1;
> > =09}
> > // ...
> >=20
> > =09=09if (linger_time < send_info[subflow->backup].linger_time) {
> > =09=09=09send_info[subflow->backup].subflow_id =3D i;
> > =09=09=09send_info[subflow->backup].linger_time =3D linger_time;
> > =09=09}
> >=20
> > // ...
> > =09if (send_info[SSK_MODE_ACTIVE].subflow_id =3D=3D MPTCP_SUBFLOWS_MAX)
> > =09=09send_info[SSK_MODE_ACTIVE].subflow_id =3D send_info[SSK_MODE_BACK=
UP].subflow_id;
> >=20
> > =09if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
> > =09=09subflow =3D data->context[send_info[SSK_MODE_ACTIVE].subflow_id];
> >=20
> > The last assignment should be equivalent to the already used 'subflow =
=3D
> > data->contexts[i];'. What kind of errors do you see here?!? Could you
> > please report them verbatim?
>=20
> This line "subflow =3D data->context[send_info[SSK_MODE_ACTIVE].subflow_i=
d];" will get a error:
>=20
>   R2 is ptr_mptcp_sched_data invalid variable offset: off=3D16, var_off=
=3D(0x0; 0x38)

I see. This looks like a verifier-imposed artificial constraint.

Basically any access to:

btf_type.array_field[valid_and_validated_variable_index]

is not allowed.

The main point of having sched_data.context exposed to the pluggable
scheduler via mptcp_sched_data is to avoid looping through the subflows
to fetch a given one, I think. But the above verifier constraint
basically prevents such usage.

I think we should add an helper into the core implementing the position
(number) to subflow (context) mapping. e.g.:

struct mptcp_subflow_context *mptcp_subflow_ctx_by_pos(struct mptcp_sk *msk=
,
=09=09=09=09=09=09=09unsigned int pos)
{
=09if (pos >=3D MPTCP_SUBFLOWS_MAX)
=09=09return NULL;

=09return msk->sched_data.context[pos];
}

And use such helper here instead of bpf_mptcp_subflow_ctx().=C2=A0

There are a number of possible follow-ups to the above, not strictly
related to this series, but IMHO needed before upstreaming this code:

-we could remove the 'context' array from the data directly visible to
the ebpf code.=C2=A0
- Instead we could export to the scheduler the number of subflows
currently present into the msk socket, so the scheduler itself will not
have to always ask for all the MPTCP_SUBFLOWS_MAX possible subflows.=C2=A0
- we could drop entirely the data_init() scheduler operation: all the
data should be make available/prepared by the core itself, no need to
add an indirect call to always do the same operation.

/P

