Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F563101C2
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689691580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOZj+WsDvPSgLL0GiBCF5oA8sTHLuXAX5oG+Odz1Xno=;
	b=QDP5x9lQ5527u2Nw75GbAb1WO652mkwYc3UHAVM0X5i2Xht6qC65bafjX8r+rv7Jqv1LKm
	Or/g8ZjzU+sJTkb9qkfvlL6x3W6KSSkXXXdJnT0V6Rix/lvpMujzGkmPHcvRiSnm44rgwm
	zIqQeoym8ZnCzqYx9N1oGU1Q3+UEJX8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-x8Q0a0_LOESx1LNxm96Wfg-1; Tue, 18 Jul 2023 10:46:19 -0400
X-MC-Unique: x8Q0a0_LOESx1LNxm96Wfg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b70c44b5fdso56014741fa.1
        for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 07:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691577; x=1692283577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOZj+WsDvPSgLL0GiBCF5oA8sTHLuXAX5oG+Odz1Xno=;
        b=mEqZxXw7lqhm3DdyNoMhAL2PspC0PHjnaguGT8EocoODwI8g0Qh/5ZX7RxvOHUKHfI
         Ak6rclLVmUqnzgck1e7MHPIPLVuIcYlRjbPRv3Wl4rgDKBsggzkTJHcXeeasEtE/p8A5
         CnkkHkbuvxLXkP+df34CQkgGk7oAc+QgcyJSAoTf9DjDNX77kd4jU3vOwJP+zW9WEa0X
         quifE1Xnlyd2XgtVAD0EZ1ghzzqpmoUaBq1uuiGIGVxZ3weMGrnLw8MFhX4DvB7CuBVa
         O9E18lXZ1ahF8Yjr27z/wB4D8UVUNdMdjZNiBm/DXDp36xEgfxzUVo3cFwQEr3uK+2ST
         Ytsw==
X-Gm-Message-State: ABy/qLYWKFi9dh8I4G5nmroaepsaqFCI5B3PmQOTrLC3KZaZfKmfH0Av
	B9VrflsQCpQiyTZJuxxt5aJSqD8JfLinEn4tmLKm65LAwWxX6/zlGz2Qz0setx5BmpbsYgOJ6A9
	bGAoN0PCUeHIwGFdIXXVR1hlb8QhJZVM=
X-Received: by 2002:a05:6512:73:b0:4fa:21d5:c0a3 with SMTP id i19-20020a056512007300b004fa21d5c0a3mr10036288lfo.36.1689691577186;
        Tue, 18 Jul 2023 07:46:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQQBUI0uQK9kn8BZjjjDsvhgA2vJpwJzuToHzY/U3vGy5dFwVS6mU99tKgqJGup2DUt2igVCbomguCSp9y2jI=
X-Received: by 2002:a05:6512:73:b0:4fa:21d5:c0a3 with SMTP id
 i19-20020a056512007300b004fa21d5c0a3mr10036279lfo.36.1689691576857; Tue, 18
 Jul 2023 07:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1680801697.git.dcaratti@redhat.com> <9414bdc6d3d0212238cec12d4f2d80894910e944.1680801697.git.dcaratti@redhat.com>
 <85d65b14b0550b284bf641ca0db55c550e23b251.camel@redhat.com>
In-Reply-To: <85d65b14b0550b284bf641ca0db55c550e23b251.camel@redhat.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 18 Jul 2023 16:46:05 +0200
Message-ID: <CAKa-r6sF1vZbRHF6ArnD_Z6iMcnk3tf=QX+F=rguyT7==AH+Pg@mail.gmail.com>
Subject: Re: [PATCH RFC mptcp-net-next 2/5] tools: ynl: fix bug in case of
 multiple nested attributes of the same type
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 7, 2023 at 10:00=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2023-04-06 at 19:31 +0200, Davide Caratti wrote:
> > when a policy contains multiple nested attributes of the same type, avo=
id
> > re-initializing .request and .reply members.
>
> It's unclear to me why we need to avoid such re-init...
>
> >
> > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> > ---
> >  tools/net/ynl/ynl-gen-c.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> > index cc2f8c945340..ba55f217a006 100755
> > --- a/tools/net/ynl/ynl-gen-c.py
> > +++ b/tools/net/ynl/ynl-gen-c.py
> > @@ -812,7 +812,8 @@ class Family(SpecFamily):
> >                      inherit =3D set()
> >                      nested =3D spec['nested-attributes']
> >                      if nested not in self.root_sets:
> > -                        self.pure_nested_structs[nested] =3D Struct(se=
lf, nested, inherited=3Dinherit)
> > +                        if nested not in self.pure_nested_structs:
> > +                            self.pure_nested_structs[nested] =3D Struc=
t(self, nested, inherited=3Dinherit)
>
> ... and is unclear to me how the above produces the effect described in
> the commit message :)

FTR: I'm removing this patch from the series as it's already in the
net-next tree [1]. Thanks!

[1]  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3D67c65ce762adaf3515fe0585
--=20
davide

