Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DF46BF
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 17:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674754623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hS3zKIJnlAU9EkYRtnK+KX1C2xLqDfBvLI1q+f2YV9Q=;
	b=V573U9VpFE2W6qMb82HeWd0Bwz827L47YnFP+mtZ0Sfna36slLcbn/59uwhFJxXuoymtpA
	LqKxxiHp0d6JLxha4hMtNJwbO9LyjSEgC+pu6TaduzYYJ/3iS3qQPDlb5LHQvxZ4t3DEkr
	hCGdYUFRneCl+4xe3k4torLsqD8s1y8=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-xeoBM4D0MrGJjVPsUOJVvw-1; Thu, 26 Jan 2023 12:37:01 -0500
X-MC-Unique: xeoBM4D0MrGJjVPsUOJVvw-1
Received: by mail-vs1-f69.google.com with SMTP id 68-20020a671947000000b003e927343575so541095vsz.18
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 09:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hS3zKIJnlAU9EkYRtnK+KX1C2xLqDfBvLI1q+f2YV9Q=;
        b=nQ4MZqGFAJ632zmEoU/Bl+OdsuJIKvNyvf16wvUmEL/klVcWxZm5Du0IHth7yhvd6v
         3b+BKOAj2Mx+SnHy95Aem5e7fEZY/ObmLZxbya4d3QGQUH7KiXT5Fryd2ytjkVgYQ1+e
         CBPn0oWow6SnIM9tGGrzZY82jjOUAVuz7cf/l9UoCjxBaJqOw2DTWzhcp7DlFdIk8JjK
         iAQuTpg3pHU5Cs7MmPRheXff0xXssUy7Oc4e+fbtcMPKCgA80YZI91W49I8h+R0jrSuA
         FRyYwxM3nvFZqOWLCLo+0UOnR69x9nvNHUi3xSX4e7A0LPNt3trMPZYb9ArdU1MfpBfR
         gvLw==
X-Gm-Message-State: AFqh2kpY+pet28CeXUKdTOtk+t5DvRI0IA6hWgm63WVL3oM+RzMYetiS
	e7MA+IkzY+RGE2IJGF5gL7x5KYofyyYDi2MnlKYopI5TdU1hT7E/EiNWv2UPrni5Jk+dP1jCbnu
	iIUt+JeH8PMQztfQ=
X-Received: by 2002:a05:6102:a49:b0:3d2:3263:e637 with SMTP id i9-20020a0561020a4900b003d23263e637mr28727008vss.30.1674754620891;
        Thu, 26 Jan 2023 09:37:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvP5uSPbUulnPgYft1881Nodu+09OeD3nmTVsEel6/A496ZmLUlUp3CRUy+GR3wNOGKwxXSuA==
X-Received: by 2002:a05:6102:a49:b0:3d2:3263:e637 with SMTP id i9-20020a0561020a4900b003d23263e637mr28726979vss.30.1674754620572;
        Thu, 26 Jan 2023 09:37:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id z2-20020ae9f442000000b00709041c3206sm1261616qkl.103.2023.01.26.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:37:00 -0800 (PST)
Message-ID: <17e6a8783f4149cf2dd20b876ffaa27a7f35ac0b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: do not wait for bare sockets' timeout
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 26 Jan 2023 18:36:58 +0100
In-Reply-To: <c4d0ff16-125f-4bd3-69aa-5034a36a977d@tessares.net>
References: <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
	 <c4d0ff16-125f-4bd3-69aa-5034a36a977d@tessares.net>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
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

On Thu, 2023-01-26 at 18:22 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 26/01/2023 16:44, Paolo Abeni wrote:
> > If the peer closes all the existing subflows for a given
> > mptcp socket and later the application closes it, the current
> > implementation let it survive until the timewait timeout expires.
>=20
> Thank you for having looked at that and provided a solution!
>=20
> > While the above is allowed by the protocol specification it
> > consumes resources for almost no reason and additionally
> > causes sporadic self-tests failures.
>=20
> I guess if we are in __mptcp_close(), there is no reason to keep the
> MPTCP socket alive if there is no more subflows: if there are new
> subflows requests coming, they will not be accepted, right?

Correct, as both passive and active subflow creation checks
mptcp_is_fully_established(sk), which in turn always returns false
after close() -> msk is not in ESTABLISHED status.
>=20
> When the last subflow is closed without MPTCP DATA FIN, it might be good
> to keep the MPTCP socket alive for a bit longer before closing the
> socket to let the client joining from another network
> (make-before-break?).

yes, and we do that. Even with no subflow alive, the msk is closed only
_after_ the close(). Otherwise it stay happily around and the msk
socket status is not affected at all.

> (this should be controllable from the userspace
> but that's another topic)
>=20
> > Let's move the mptcp socket to the TCP_CLOSE state when there are
> > no alive subflows at close time, so that the allocated resources
> > will be freed immediately.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > --
> > this could land either on -net or net-next, as it introduces
> > a change of behavior that "fixes" self-tests.
> >=20
> > The fix tag would be:
> >=20
> > Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
>=20
> If I understand properly, this doesn't break any 'make-before-break'
> feature but it clean resources quicker while there was no reason to
> wait, right? In this case it makes sense to target the -net tree.

I'm ok with the above.

Thanks for the review,

Paolo

