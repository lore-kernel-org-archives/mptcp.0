Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64393D7C
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685032803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9IS4XZ/eqIvO+FevkbG2YZVf5bsJCFv8eVfAKRW2wU=;
	b=XQE7P84jnR2sG2v61vBlrWQ0zzdbiJQfVU7wXaWiCd6RwWond+PYVtHzL33oaDQRrGRdXH
	KWFZsKN6I8uB53SD4oO43ksEb3JMv6+afy6viwVSNGgXYVQJKCbatEognHxHQHX8JpeUGX
	3V+3zE3LClUVMinfQ9+J2xLWriIDxTs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-1tenFpaaMQabblRepf6hqw-1; Thu, 25 May 2023 12:40:02 -0400
X-MC-Unique: 1tenFpaaMQabblRepf6hqw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f607da7cdbso4006735e9.0
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685032801; x=1687624801;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bx5Z2JdnQ/MHtThF19qhdOTq7ygjFVvC93vMTdp97ak=;
        b=dc415RIGkSrY35SxHO1C3zpwe7J9LGrwkxsHKljJiNgcWqkGCEftyvKnVDCGgB7FNg
         2GB72vHMPwtzV3dU54aLg0yGfZejYeMgAm5csGIgJSDrciZcW733R/tyFHcZxffqF8ac
         5pvwpi8giorTWLe7HqCZIKW/0XhTMrTityHqzyqJCqezdtpLd9WplSYpWdSl1r0A5nqL
         iyyqdimYK3xQMCrxYnbHxVrzySESCwZdAR5sRJQzaqZbYJsdU5KwgWnah3N1oo+SI1Xy
         kUBz5ukMYMEjLL9ahdlOhhViPS55AGRbqyjXdn4do/V5FORB/yTNI3FE85vfjqFD1eOA
         l7gQ==
X-Gm-Message-State: AC+VfDwtfIc7j2mvfzJdwN6vxL7ZYdQ5WwC7CSShk6dVBROYLJ+Locot
	18CkMY/kFV34X4UArrcAL3rHLYNf0DHaEc7Pzq7D2eiWYfTFQMSsjoi+fxX0U+89EhjxpW7Azsu
	QRPlhmYXkjOe/VIM=
X-Received: by 2002:a05:6000:1188:b0:307:a5d1:dbb5 with SMTP id g8-20020a056000118800b00307a5d1dbb5mr4220836wrx.6.1685032801334;
        Thu, 25 May 2023 09:40:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hBQDbasjMiB1i75I9M7GaMBlDLc4P4nPOYw2bX33BHYRSvj3fRk5iNmPnv/fw3L03/Wi3Zw==
X-Received: by 2002:a05:6000:1188:b0:307:a5d1:dbb5 with SMTP id g8-20020a056000118800b00307a5d1dbb5mr4220824wrx.6.1685032800992;
        Thu, 25 May 2023 09:40:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id f6-20020adff986000000b00306281cfa59sm2343897wrr.47.2023.05.25.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:40:00 -0700 (PDT)
Message-ID: <a6d754ce2b57e4827b733f885b3464cebb5c4eb2.camel@redhat.com>
Subject: Re: [PATCH v6 mptcp-next 6/6] selftests: mptcp: add MPTCP_FULL_INFO
 testcase
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Date: Thu, 25 May 2023 18:39:59 +0200
In-Reply-To: <d26ed3cb-3dc3-0c7c-af56-ae0e62c403a6@tessares.net>
References: <cover.1684997011.git.pabeni@redhat.com>
	 <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
	 <d26ed3cb-3dc3-0c7c-af56-ae0e62c403a6@tessares.net>
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

On Thu, 2023-05-25 at 17:22 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 25/05/2023 09:17, Paolo Abeni wrote:
> > Add a testcase explicitly triggering the newly introduce
> > MPTCP_FULL_INFO getsockopt.
>=20
> (...)
>=20
> > +static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
> > +{
> > +=09size_t data_size =3D sizeof(struct mptcp_full_info);
> > +=09struct mptcp_subflow_info sfinfo[2];
> > +=09struct tcp_info tcp_info[2];
> > +=09struct mptcp_full_info mfi;
> > +=09socklen_t olen;
> > +=09int ret;
> > +
> > +=09memset(&mfi, 0, data_size);
> > +=09memset(tcp_info, 0, sizeof(tcp_info));
> > +=09memset(sfinfo, 0, sizeof(sfinfo));
> > +
> > +=09mfi.size_tcpinfo_user =3D sizeof(struct tcp_info);
> > +=09mfi.size_sfinfo_user =3D sizeof(struct mptcp_subflow_info);
> > +=09mfi.size_arrays_user =3D 2;
> > +=09mfi.subflow_info =3D (unsigned long) &sfinfo[0];
> > +=09mfi.tcp_info =3D (unsigned long) &tcp_info[0];
> > +=09olen =3D data_size;
> > +
> > +=09ret =3D getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, &mfi, &olen);
> > +=09if (ret < 0) {
> > +=09=09if (errno =3D=3D EOPNOTSUPP) {
> > +=09=09=09perror("MPTCP_FULL_INFO test skipped");
> > +=09=09=09return;
> > +=09=09}
> > +=09=09xerror("getsockopt MPTCP_FULL_INFO");
> > +=09}
> > +
> > +=09assert(olen <=3D data_size);
> > +=09assert(mfi.size_tcpinfo_user =3D=3D mfi.size_tcpinfo_kernel);
> > +=09assert(mfi.size_tcpinfo_user =3D=3D sizeof(struct tcp_info));
> > +=09assert(mfi.size_sfinfo_user =3D=3D mfi.size_sfinfo_kernel);
> > +=09assert(mfi.size_sfinfo_user =3D=3D sizeof(struct mptcp_subflow_info=
));
>=20
> Similar to the patch I sent to support old kernels, we cannot do these 4
> last assert(), see:
>=20
> https://patchwork.kernel.org/project/mptcp/patch/20230406-mptcp-issue-368=
-selftests-old-kernels-v2-17-50313e4f83ab@tessares.net/
>=20
> Because we cannot guess the size of these two structures in the kernel,

Regarding mptcp_subflow_info we can infer it must be >=3D
sizeof(mptcp_subflow_addrs) + 4...



> I suggest to do this:
>=20
>   assert(mfi.size_tcpinfo_user > 0);
>   assert(mfi.size_tcpinfo_kernel > 0);
>   assert(mfi.size_sfinfo_user > 0);
>   assert(mfi.size_sfinfo_kernel > 0);
>=20
> Better than nothing... In case of error, one would be set to 0 or we
> would not get info from these structures below.

... so we could check:

  int min_sfinfo_size =3D 4 + sizeof(struct mptcp_subflow_addrs);

  // ...

  assert(mfi.size_tcpinfo_kernel > 0);
  assert(mfi.size_tcpinfo_user =3D=3D
         min(mfi.size_tcpinfo_kernel, sizeof(struct tcp_info));
  assert(mfi.size_sfinfo_kernel >=3D min_sfinfo_size);   =C2=A0
  assert(mfi.size_sfinfo_user =3D=3D
         min(mfi.size_sfinfo_kernel, sizeof(struct mptcp_subflow_info));


/P

