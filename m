Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE119E79
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686579757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZapQN0ewghnQweNS5wPutS47V5vnvYjt23eqbfH1Ft0=;
	b=fc4j66BIPIy12u4c0p4Pk6kTaWN/HyICCJ0cHc+MiZCZTBH2teYw8xXRWjL1BGWmpTdnzo
	awiC1Y/QmrFS4TBqgXokh76/hjNV7p1Wtipg84dT1mAPdLSLqKhyO80y1UlkXHb7wAM3mM
	KQUTh5bOomUiJv7zUm0fLD5S+PZl1W0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-iPVTxSAUOhKaoUgyJBL3yA-1; Mon, 12 Jun 2023 10:22:35 -0400
X-MC-Unique: iPVTxSAUOhKaoUgyJBL3yA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76077669a5aso31029485a.0
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579754; x=1689171754;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUkdp9DHjXRf3ykSsUCht7pGv2YDfc+9gReJ71VO/Us=;
        b=eKEKV6Ntd6k6E3iXQR3xc+jilVk+L4k3lV67KS8v46k3qFdhpb7JpkS7/7S9791F46
         tIb80ocColUcScqUO+KYzsUkhmLvyOVQkMrJPtlj3Rek8A1nW4WYbPskm0QLAEhZPNF4
         dF/A9RUsNdrfMIjJDUJ+JB0EUfe7sjV8J5GzISK1KorFhtRgGoqEpDEr2usIXf1ESDWm
         XRZJlqZ27P90TCKJwztuwcMBGya0EPE4LFMoNA/+qrtykM6ccD+KNCMPcbtgCMXZ4Ti3
         yeUTeOEFdTRGZAQFhRCavJ6jlCBV+0kSpgwyYYeLh6MeBMpLbTanYDxv/KyU1UzS599g
         iksQ==
X-Gm-Message-State: AC+VfDw+FSUZ57SYlutMrtLDshkAUH3cqAZr+09U2+5UyEWn6hGsxp4T
	DM2XCKOABPapKj/OYlNncN/5K+X0n0sfjutiBqakb4DAINN2OtrV0dO87uEk7pzj9F5KEJdz8y3
	3GI/6Xg5QXIw3UwaWp7b+c/s=
X-Received: by 2002:a37:694:0:b0:760:6bcb:5448 with SMTP id 142-20020a370694000000b007606bcb5448mr5215858qkg.0.1686579754715;
        Mon, 12 Jun 2023 07:22:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PtR5WYLSVxE6Vl6gbuHOPVNnT5KCZiAAB3q2oqP6HDFg6usSd/N2C4aWua7Osq/cK3fc/wQ==
X-Received: by 2002:a37:694:0:b0:760:6bcb:5448 with SMTP id 142-20020a370694000000b007606bcb5448mr5215836qkg.0.1686579754387;
        Mon, 12 Jun 2023 07:22:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id f6-20020a05620a12e600b0075785052e97sm2879089qkl.95.2023.06.12.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:22:34 -0700 (PDT)
Message-ID: <45ff221dfa3fce66e12bd76737c2dea8eeed7e00.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 12 Jun 2023 16:22:31 +0200
In-Reply-To: <20230612132934.GA9248@localhost>
References: <cover.1686202841.git.geliang.tang@suse.com>
	 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
	 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
	 <20230609133236.GA30403@localhost>
	 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
	 <20230610014514.GA2843@localhost>
	 <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
	 <20230612132934.GA9248@localhost>
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

On Mon, 2023-06-12 at 21:29 +0800, Geliang Tang wrote:
> On Mon, Jun 12, 2023 at 01:05:30PM +0200, Paolo Abeni wrote:
> > On Sat, 2023-06-10 at 09:45 +0800, Geliang Tang wrote:
> > > On Fri, Jun 09, 2023 at 04:40:01PM +0200, Paolo Abeni wrote:
> > > > On Fri, 2023-06-09 at 21:32 +0800, Geliang Tang wrote:
> > > > > On Fri, Jun 09, 2023 at 11:57:53AM +0200, Paolo Abeni wrote:
> > > > >=20
> > > > > > May I guess you get a similar error if you do:
> > > > > >=20
> > > > > > =09subflow =3D mptcp_subflow_ctx(ssk)
> > > > > >=20
> > > > > > ? (just out of sheer ignorance and curiosity)
> > > > >=20
> > > > > Yes. It seems that accessing 'send_info[SSK_MODE_ACTIVE].ssk' is
> > > > > considered unsafe in BPF context. So here we pass 'send_info[SSK_=
MODE_ACTIVE].ssk'
> > > > > into bpf_mptcp_subflow_ctx() to find the related subflow. Then we=
 access this
> > > > > subflow instead of 'send_info[SSK_MODE_ACTIVE].ssk' below. This c=
an make BPF happy.
> > > > >=20
> > > > > >=20
> > > > > > > +=09 * then use mptcp_subflow_tcp_sock() to get the ssk.
> > > > > > > +=09 */
> > > > > > > +=09subflow =3D mptcp_subflow_tcp_sock(send_info[SSK_MODE_ACT=
IVE].ssk, data);
> > > > > > > +=09ssk =3D mptcp_subflow_tcp_sock(subflow);
> > > > > >=20
> > > > > > What if you store the 'subflow' pointer in 'send_info'? Will th=
e
> > > > > > verifier splat with that? and what if we store the correspondin=
g
> > > > > > context index 'i' instead?
> > > > >=20
> > > > > Storing the 'subflow' or index 'i' don't work too.
> > > >=20
> > > > Uhmm... I'm very surprised about 'i'. Specifically what I mean is:
> > > >=20
> > > > struct subflow_send_info {
> > > > =09unsigned int subflow_id;
> > > > =09__u64 linger_time;
> > > > };
> > > >=20
> > > > // ...
> > > > =09for (i =3D 0; i < SSK_MODE_MAX; ++i) {
> > > > =09=09send_info[i].ssk =3D MPTCP_SUBFLOWS_MAX;
> > > > =09=09send_info[i].linger_time =3D -1;
> > > > =09}
> > > > // ...
> > > >=20
> > > > =09=09if (linger_time < send_info[subflow->backup].linger_time) {
> > > > =09=09=09send_info[subflow->backup].subflow_id =3D i;
> > > > =09=09=09send_info[subflow->backup].linger_time =3D linger_time;
> > > > =09=09}
> > > >=20
> > > > // ...
> > > > =09if (send_info[SSK_MODE_ACTIVE].subflow_id =3D=3D MPTCP_SUBFLOWS_=
MAX)
> > > > =09=09send_info[SSK_MODE_ACTIVE].subflow_id =3D send_info[SSK_MODE_=
BACKUP].subflow_id;
> > > >=20
> > > > =09if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
> > > > =09=09subflow =3D data->context[send_info[SSK_MODE_ACTIVE].subflow_=
id];
> > > >=20
> > > > The last assignment should be equivalent to the already used 'subfl=
ow =3D
> > > > data->contexts[i];'. What kind of errors do you see here?!? Could y=
ou
> > > > please report them verbatim?
> > >=20
> > > This line "subflow =3D data->context[send_info[SSK_MODE_ACTIVE].subfl=
ow_id];" will get a error:
> > >=20
> > >   R2 is ptr_mptcp_sched_data invalid variable offset: off=3D16, var_o=
ff=3D(0x0; 0x38)
> >=20
> > I see. This looks like a verifier-imposed artificial constraint.
> >=20
> > Basically any access to:
> >=20
> > btf_type.array_field[valid_and_validated_variable_index]
> >=20
> > is not allowed.
> >=20
> > The main point of having sched_data.context exposed to the pluggable
> > scheduler via mptcp_sched_data is to avoid looping through the subflows
> > to fetch a given one, I think. But the above verifier constraint
> > basically prevents such usage.
> >=20
> > I think we should add an helper into the core implementing the position
> > (number) to subflow (context) mapping. e.g.:
> >=20
> > struct mptcp_subflow_context *mptcp_subflow_ctx_by_pos(struct mptcp_sk =
*msk,
> > =09=09=09=09=09=09=09unsigned int pos)
> > {
> > =09if (pos >=3D MPTCP_SUBFLOWS_MAX)
> > =09=09return NULL;
> >=20
> > =09return msk->sched_data.context[pos];
> > }
> >=20
> > And use such helper here instead of bpf_mptcp_subflow_ctx().=C2=A0
>=20
> "return msk->sched_data.contexts[pos];" will get the same error:
>=20
> R3 is ptr_mptcp_sock invalid variable offset: off=3D1880, var_off=3D(0x0;=
 0x38)

I'm sorry, I was not clear enough. I mean that the
'mptcp_subflow_ctx_by_pos()' helper must be implemented by the kernel
and exported/made visible to eBPF. The verifier must not see that code.
> >=20
> > There are a number of possible follow-ups to the above, not strictly
> > related to this series, but IMHO needed before upstreaming this code:
> >=20
> > -we could remove the 'context' array from the data directly visible to
> > the ebpf code.=C2=A0
> > - Instead we could export to the scheduler the number of subflows
> > currently present into the msk socket, so the scheduler itself will not
> > have to always ask for all the MPTCP_SUBFLOWS_MAX possible subflows.=C2=
=A0
>=20
> This for loop in BPF will get the "invalid variable offset" error too:
>=20
> for (int i =3D 0; i < number_of_subflows; i++)
> =09contexts[i];
>=20
> So we have to loop from 0 to MAX like this:
>=20
> for (i =3D 0; i < SSK_MODE_MAX; i++)
> =09contexts[i];

Yep, the error you reported in the previous email hinted that. As I
wrote

"""
Basically any access to:

btf_type.array_field[valid_and_validated_variable_index]

is not allowed.
"""

The above should be:

=09for (int i=3D0; i < data->number_of_subflows; i++) {
=09=09context =3D mptcp_subflow_ctx_by_pos(i);
=09=09// ...
=09}


Cheers,

Paolo

