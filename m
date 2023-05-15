Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2B8829
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 08:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684138611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfFlIif7N1Pw8NHf8fey7n5neIlw5Q5L1JTIsqCGCCI=;
	b=iyDXoCcCp3+lAn9SVg4xBdUUWIB2JfSkUgs8IVzdeyrieNXAJ/Cmf2LEAr0fREosEmHboW
	jwlYKKAuJIWGtEgvWK15xSFf5Pqx02EfwH+R54yhX45K2ZEaEEcVnSuaTuyrX9Xh54Qpkw
	NsahsgeNTqNBjWh7ywikizoNab404xU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-gsF-apxTOcStcNIFjaF3BA-1; Mon, 15 May 2023 04:16:50 -0400
X-MC-Unique: gsF-apxTOcStcNIFjaF3BA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62143c665cbso13257396d6.0
        for <mptcp@lists.linux.dev>; Mon, 15 May 2023 01:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684138609; x=1686730609;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfFlIif7N1Pw8NHf8fey7n5neIlw5Q5L1JTIsqCGCCI=;
        b=TGHk/Lc3h+UTqS6iJ94YxN25fbtHlnAbzdIQiABp8v6z7sf1bU9Wxfw57vGWHbhjhJ
         hxghYgIzNSOuUUmRUMlEnD7bdHv05hBlRkASoaWPnOYUsqX80Zb91RVDRCEjio3re2G6
         xakABA31WT2Hx0DXZs0HPyieGS81fZIc+1M7mQDmDkcgAxmKNXFejMdWfZ4WriKlPBBe
         akT9TQsf1S75672WTKsLx+olbQR0eeR/perECvYqGS8fNHnT7ivXHxoNlXpREgF8639U
         nA67GlvQugl5CngG4wk/lclUXYSjT5CSxyJznlLNEZWOzpk0hyfDJZaz4Q/b08jvs2kD
         Uj/A==
X-Gm-Message-State: AC+VfDzHi0/tvkajT9V1zV5jDg30qHl794WweX+zDZjCmCmVOJWTo9+l
	V1WVDxz/LiSSBkVqx3q/v5/MOc4FkndN9nnBKgrv9iXoOe0BXlYVI/iaJX+hv6LChCkky9Gtr6m
	UAEniS6KhGtAUxEA=
X-Received: by 2002:a05:6214:4001:b0:603:fa46:d368 with SMTP id kd1-20020a056214400100b00603fa46d368mr48741380qvb.1.1684138609710;
        Mon, 15 May 2023 01:16:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/88meju5BJDT82P//H/TPDetLlS+0yFHrWZ0xZai9/b/lSl3yXtyoiXKAK/Q9KVjZXCgnNg==
X-Received: by 2002:a05:6214:4001:b0:603:fa46:d368 with SMTP id kd1-20020a056214400100b00603fa46d368mr48741368qvb.1.1684138609411;
        Mon, 15 May 2023 01:16:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-144.dyn.eolo.it. [146.241.235.144])
        by smtp.gmail.com with ESMTPSA id j7-20020a0ce007000000b0062168714c8fsm2813687qvk.120.2023.05.15.01.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 01:16:49 -0700 (PDT)
Message-ID: <4c81894956d1ce7fda70200f8de50b3420e5c7e5.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix connect timeout handling
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 15 May 2023 10:16:46 +0200
In-Reply-To: <5ba7d292-7128-fc9c-aa13-96c938bb881a@kernel.org>
References: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
	 <5ba7d292-7128-fc9c-aa13-96c938bb881a@kernel.org>
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

On Fri, 2023-05-12 at 12:24 -0700, Mat Martineau wrote:
> On Fri, 5 May 2023, Paolo Abeni wrote:
>=20
> > Ondrej reported a functional issue WRT timeout handling on connect
> > with a nice reproducer.
> >=20
> > The problem is that the current mptcp connect waits for both the
> > MPTCP socket level timeout, and the first subflow socket timeout.
> > The latter is not influenced/touched by the exposed setsockopt().
> >=20
> > Overall the above makes the SO_SNDTIMEO a no-op on connect.
> >=20
> > Since mptcp_connect is invoked via inet_stream_connect and the
> > latter properly handle the MPTCP level timeout, we can address the
> > issue making the nested subflow level connect always unblocking.
> >=20
> > This also allow simplifying a bit the code, dropping an ugly hack
> > to handle the fastopen and custom proto_ops connect.
> >=20
> > The issues predates the blamed commit below, but the current resolution
> > requires the infrastructure introduced there.
> >=20
> > Fixes: 54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/399
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note: there is needed follow-up correctly propagating the SYN_SENT
> > -> CLOSE state transition from the first subflow to the msk socket in
> > case of connect error, but that is somewhat independed/pre-existent.
> >=20
> > Sending out early for testing.
>=20
> Hi Paolo -
>=20
> Patch LGTM, and appreciate the cleanup of msk->connect_flags:
>=20
> Reviewed-by: Mat Martineau <martineau@kernel.org>
>=20
> I think it would be good to also add a selftest in net-next to check the=
=20
> connect timeout (set to a very short time), but that doesn't need to bloc=
k=20
> this -net change.

Agreed. Perhaps a pktdrill script would could be simpler option?!?

Thanks!

Paolo

