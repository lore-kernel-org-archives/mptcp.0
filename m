Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B6FBE7
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684171163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHcJ3I1FXHcXNRe1DkM8uJHoTjX2zHdTR/shxGaoBQ8=;
	b=dWrR+U36gmXOEE6R/RwVtAHgqXPRhYqfAV7UMJlMFUEQ1gLP3t6tQsB7L2a1OUs/cph9Rr
	VLYAositLS22S3ue49cDALuzSKcuuScNrUl0aQGpSx17Pc7BOe1MeLN46jzo3UktGGETzA
	rYQIJL6NEdvHbQ//Ze8SxQTOfc+z5Bs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-y4wGM_L9M9ijw4j1t3IOHA-1; Mon, 15 May 2023 13:19:22 -0400
X-MC-Unique: y4wGM_L9M9ijw4j1t3IOHA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f4fffe7883so2149765e9.0
        for <mptcp@lists.linux.dev>; Mon, 15 May 2023 10:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684171160; x=1686763160;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHcJ3I1FXHcXNRe1DkM8uJHoTjX2zHdTR/shxGaoBQ8=;
        b=dsxQUAbgqa6Q9ymFGU+Z1zUn6XVX2nVBWHY+YF/IIlOxENB7qdw07C6XX66pgSOHPM
         fakyALYoliP64sHK3ONaPSzAZ8f1zbPUIe/+jcP7/h73tf09I+JA6cZ7zOP4KdUfkdPw
         J2bBVxN2G7hSbjbTEqAAYBlq4OXuJKznQLlnGp8/Gi7bIzkYtFrZPO/rUfomDqBCSWoZ
         eicNrQbfyD0ifeBVqY/+uSe/WQT3SjkhXrtdwmcarNbUeUqoH50JyHHkMSpoZAsIfW1c
         pt8HvS8QW+sagXqStiOoxPIItkD9QPLsmqa/yf4EmHHRzI2k8epv1cMz2IhoJuV5cj3P
         cmgQ==
X-Gm-Message-State: AC+VfDyry2oHtVX5KAWRtPQoYduHXyf0/hSQGL8anIuLyKrWUuxuDJ3F
	yWir7aRIojKYYCTs22N2T6zPizAvLUDn6n/oU2QBwiOZIEuKqSDId2wYN8AJnF6xzRUuHElDdyl
	rbzSj4RoC8lbIqCM=
X-Received: by 2002:a05:600c:1d95:b0:3f1:7518:e37f with SMTP id p21-20020a05600c1d9500b003f17518e37fmr90858wms.1.1684171160579;
        Mon, 15 May 2023 10:19:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PNskJIAbUWCDBWvtnR8WS9y+KFaqpCTSt5U07N7Zv3S0SZkyGiUVO/Q/oJtMf6DJYj/q6LA==
X-Received: by 2002:a05:600c:1d95:b0:3f1:7518:e37f with SMTP id p21-20020a05600c1d9500b003f17518e37fmr90842wms.1.1684171160275;
        Mon, 15 May 2023 10:19:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-144.dyn.eolo.it. [146.241.235.144])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bcc01000000b003f195d540d9sm84782wmh.14.2023.05.15.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 10:19:19 -0700 (PDT)
Message-ID: <29276f951122b72dcc1972891cb6e013abf6e3c2.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix connect timeout handling
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 15 May 2023 19:19:18 +0200
In-Reply-To: <3ec2e3f8-9a38-1d71-8546-5d464b7c82e9@tessares.net>
References: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
	 <5ba7d292-7128-fc9c-aa13-96c938bb881a@kernel.org>
	 <4c81894956d1ce7fda70200f8de50b3420e5c7e5.camel@redhat.com>
	 <3ec2e3f8-9a38-1d71-8546-5d464b7c82e9@tessares.net>
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

On Mon, 2023-05-15 at 17:46 +0200, Matthieu Baerts wrote:
> Hi Paolo, Mat,
>=20
> On 15/05/2023 10:16, Paolo Abeni wrote:
> > On Fri, 2023-05-12 at 12:24 -0700, Mat Martineau wrote:
> > > On Fri, 5 May 2023, Paolo Abeni wrote:
> > >=20
> > > > Ondrej reported a functional issue WRT timeout handling on connect
> > > > with a nice reproducer.
> > > >=20
> > > > The problem is that the current mptcp connect waits for both the
> > > > MPTCP socket level timeout, and the first subflow socket timeout.
> > > > The latter is not influenced/touched by the exposed setsockopt().
> > > >=20
> > > > Overall the above makes the SO_SNDTIMEO a no-op on connect.
> > > >=20
> > > > Since mptcp_connect is invoked via inet_stream_connect and the
> > > > latter properly handle the MPTCP level timeout, we can address the
> > > > issue making the nested subflow level connect always unblocking.
> > > >=20
> > > > This also allow simplifying a bit the code, dropping an ugly hack
> > > > to handle the fastopen and custom proto_ops connect.
> > > >=20
> > > > The issues predates the blamed commit below, but the current resolu=
tion
> > > > requires the infrastructure introduced there.
> > > >=20
> > > > Fixes: 54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
> > > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/399
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > > Note: there is needed follow-up correctly propagating the SYN_SENT
> > > > -> CLOSE state transition from the first subflow to the msk socket =
in
> > > > case of connect error, but that is somewhat independed/pre-existent=
.
> > > >=20
> > > > Sending out early for testing.
> > >=20
> > > Hi Paolo -
> > >=20
> > > Patch LGTM, and appreciate the cleanup of msk->connect_flags:
> > >=20
> > > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > >=20
> > > I think it would be good to also add a selftest in net-next to check =
the=20
> > > connect timeout (set to a very short time), but that doesn't need to =
block=20
> > > this -net change.
> >=20
> > Agreed. Perhaps a pktdrill script would could be simpler option?!?
>=20
> Good idea, that seems more appropriated, especially with the timeout part=
.
>=20
> Just to avoid deadlocks: is there someone working on that? :)

Yep, just opended a PR:

https://github.com/multipath-tcp/packetdrill/pull/115

/P

