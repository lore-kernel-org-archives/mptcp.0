Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DF2415C
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686648910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHn50geQKw97yLTkWfhfDBG0pu3squp4PTU8W9CG4yY=;
	b=EQ966+RhAR9XYGXWu2ZGSXjrdgR6heBBYlovrNeyCJrFoO3bwP61cha6NtsVg0pQrXuSC3
	jKI48kFirvQGqV9BXdV4MsNJPPlgW3xFbzHQcNjEYzhMPtR3TBoQ5mUvoKKFSQjjmgrxC0
	YS58mnkGwZyKo+eguIxGwvgkxu6bjwA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-YMvNh4MWPLuYKEl8g8lBjQ-1; Tue, 13 Jun 2023 05:35:09 -0400
X-MC-Unique: YMvNh4MWPLuYKEl8g8lBjQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7e6648625so7978205e9.1
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 02:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686648908; x=1689240908;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKKnR1nX3L8gE3Z0Yi9b/UcLXOIYKa2i9M/fhveI6rU=;
        b=KKEvffsGYhJb6bF12zc/jo2nuNyLYxojckKuiRLga7uNN3ASJZJVIiHyrq5VsfMyB9
         zKjKSOg+jQjKT+cAqDooOeu8xYuofD929OhRnfZr1p05HjCW6omz18rII0l6kLB+PW9o
         LIgZaK+mP7nT3jiJ4VB4JkpQyp6qIRQ2lvhDwjvVeTW819tPpUiFAdBznod4H3KfidGF
         7rQdQdgydJyAFvVYrKioPPdYIY/QrAuEA6Ic1WIxBqwc2laO/cbxw1jEWe4VKknvuRJR
         6HH60DiLFTrDFJoq52aqlnOwbOKrUdNsisy0H1y2q/AyldQ9gAc/nzs0WCqxpNXvDDXi
         WDbg==
X-Gm-Message-State: AC+VfDxSgsNW8oxXtZ9qFU+JhmvqZu2MV3ewjFbD92D86uIz+DGVQ1Ek
	QfGOvApxXNENevWsq1ra7FQOUUTEaQofMfCMtX+8glXdAM1czhYPbhkijDKa/3aaHCuPC3Fau+T
	LW2O0qhWT8RzTSd7hUEDq3WU=
X-Received: by 2002:a05:600c:1c81:b0:3f7:f477:7beb with SMTP id k1-20020a05600c1c8100b003f7f4777bebmr9831495wms.0.1686648907906;
        Tue, 13 Jun 2023 02:35:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wTBHdLWVj54jmQzooXuX5hLM16WczVNSHL4bpCT2GLvsGDjqhk9UFJqPnuqmWoxOFQNe3qA==
X-Received: by 2002:a05:600c:1c81:b0:3f7:f477:7beb with SMTP id k1-20020a05600c1c8100b003f7f4777bebmr9831480wms.0.1686648907567;
        Tue, 13 Jun 2023 02:35:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-147.dyn.eolo.it. [146.241.245.147])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003f7f4b7f286sm13867973wmi.12.2023.06.13.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:35:07 -0700 (PDT)
Message-ID: <e7ae47a07e95ec10325876221940b4c77fb5a80f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 13 Jun 2023 11:35:06 +0200
In-Reply-To: <20230613053600.GA1395@bogon>
References: <cover.1686202841.git.geliang.tang@suse.com>
	 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
	 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
	 <20230609133236.GA30403@localhost>
	 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
	 <20230610014514.GA2843@localhost>
	 <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
	 <20230612132934.GA9248@localhost>
	 <45ff221dfa3fce66e12bd76737c2dea8eeed7e00.camel@redhat.com>
	 <20230613053600.GA1395@bogon>
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

On Tue, 2023-06-13 at 13:36 +0800, Geliang Tang wrote:
> On Mon, Jun 12, 2023 at 04:22:31PM +0200, Paolo Abeni wrote:
> > On Mon, 2023-06-12 at 21:29 +0800, Geliang Tang wrote:
> > > On Mon, Jun 12, 2023 at 01:05:30PM +0200, Paolo Abeni wrote:
> > > > On Sat, 2023-06-10 at 09:45 +0800, Geliang Tang wrote:
> > > > > On Fri, Jun 09, 2023 at 04:40:01PM +0200, Paolo Abeni wrote:
> > > > > > On Fri, 2023-06-09 at 21:32 +0800, Geliang Tang wrote:
> > > > > > > On Fri, Jun 09, 2023 at 11:57:53AM +0200, Paolo Abeni wrote:
> > > > > > >=20
> > > > > > > > May I guess you get a similar error if you do:
> > > > > > > >=20
> > > > > > > > =09subflow =3D mptcp_subflow_ctx(ssk)
> > > > > > > >=20
> > > > > > > > ? (just out of sheer ignorance and curiosity)
> > > > > > >=20
> > > > > > > Yes. It seems that accessing 'send_info[SSK_MODE_ACTIVE].ssk'=
 is
> > > > > > > considered unsafe in BPF context. So here we pass 'send_info[=
SSK_MODE_ACTIVE].ssk'
> > > > > > > into bpf_mptcp_subflow_ctx() to find the related subflow. The=
n we access this
> > > > > > > subflow instead of 'send_info[SSK_MODE_ACTIVE].ssk' below. Th=
is can make BPF happy.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > +=09 * then use mptcp_subflow_tcp_sock() to get the ssk.
> > > > > > > > > +=09 */
> > > > > > > > > +=09subflow =3D mptcp_subflow_tcp_sock(send_info[SSK_MODE=
_ACTIVE].ssk, data);
> > > > > > > > > +=09ssk =3D mptcp_subflow_tcp_sock(subflow);
> > > > > > > >=20
> > > > > > > > What if you store the 'subflow' pointer in 'send_info'? Wil=
l the
> > > > > > > > verifier splat with that? and what if we store the correspo=
nding
> > > > > > > > context index 'i' instead?
> > > > > > >=20
> > > > > > > Storing the 'subflow' or index 'i' don't work too.
> > > > > >=20
> > > > > > Uhmm... I'm very surprised about 'i'. Specifically what I mean =
is:
> > > > > >=20
> > > > > > struct subflow_send_info {
> > > > > > =09unsigned int subflow_id;
> > > > > > =09__u64 linger_time;
> > > > > > };
> > > > > >=20
> > > > > > // ...
> > > > > > =09for (i =3D 0; i < SSK_MODE_MAX; ++i) {
> > > > > > =09=09send_info[i].ssk =3D MPTCP_SUBFLOWS_MAX;
> > > > > > =09=09send_info[i].linger_time =3D -1;
> > > > > > =09}
> > > > > > // ...
> > > > > >=20
> > > > > > =09=09if (linger_time < send_info[subflow->backup].linger_time)=
 {
> > > > > > =09=09=09send_info[subflow->backup].subflow_id =3D i;
> > > > > > =09=09=09send_info[subflow->backup].linger_time =3D linger_time=
;
> > > > > > =09=09}
> > > > > >=20
> > > > > > // ...
> > > > > > =09if (send_info[SSK_MODE_ACTIVE].subflow_id =3D=3D MPTCP_SUBFL=
OWS_MAX)
> > > > > > =09=09send_info[SSK_MODE_ACTIVE].subflow_id =3D send_info[SSK_M=
ODE_BACKUP].subflow_id;
> > > > > >=20
> > > > > > =09if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_M=
AX)
> > > > > > =09=09subflow =3D data->context[send_info[SSK_MODE_ACTIVE].subf=
low_id];
> > > > > >=20
> > > > > > The last assignment should be equivalent to the already used 's=
ubflow =3D
> > > > > > data->contexts[i];'. What kind of errors do you see here?!? Cou=
ld you
> > > > > > please report them verbatim?
> > > > >=20
> > > > > This line "subflow =3D data->context[send_info[SSK_MODE_ACTIVE].s=
ubflow_id];" will get a error:
> > > > >=20
> > > > >   R2 is ptr_mptcp_sched_data invalid variable offset: off=3D16, v=
ar_off=3D(0x0; 0x38)
> > > >=20
> > > > I see. This looks like a verifier-imposed artificial constraint.
> > > >=20
> > > > Basically any access to:
> > > >=20
> > > > btf_type.array_field[valid_and_validated_variable_index]
> > > >=20
> > > > is not allowed.
> > > >=20
> > > > The main point of having sched_data.context exposed to the pluggabl=
e
> > > > scheduler via mptcp_sched_data is to avoid looping through the subf=
lows
> > > > to fetch a given one, I think. But the above verifier constraint
> > > > basically prevents such usage.
> > > >=20
> > > > I think we should add an helper into the core implementing the posi=
tion
> > > > (number) to subflow (context) mapping. e.g.:
> > > >=20
> > > > struct mptcp_subflow_context *mptcp_subflow_ctx_by_pos(struct mptcp=
_sk *msk,
> > > > =09=09=09=09=09=09=09unsigned int pos)
> > > > {
> > > > =09if (pos >=3D MPTCP_SUBFLOWS_MAX)
> > > > =09=09return NULL;
> > > >=20
> > > > =09return msk->sched_data.context[pos];
> > > > }
> > > >=20
> > > > And use such helper here instead of bpf_mptcp_subflow_ctx().=C2=A0
> > >=20
> > > "return msk->sched_data.contexts[pos];" will get the same error:
> > >=20
> > > R3 is ptr_mptcp_sock invalid variable offset: off=3D1880, var_off=3D(=
0x0; 0x38)
> >=20
> > I'm sorry, I was not clear enough. I mean that the
> > 'mptcp_subflow_ctx_by_pos()' helper must be implemented by the kernel
> > and exported/made visible to eBPF. The verifier must not see that code.
>=20
> Thanks Paolo, it works now. I updated the patch as a squash-to one and
> sent it to the ML as 'Squash to "BPF packet scheduler updates v8"':
>=20
> https://patchwork.kernel.org/project/mptcp/patch/8193bd590a4d811054a36f50=
a2aad79a02e8c137.1686620367.git.geliang.tang@suse.com/

Ok, LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

