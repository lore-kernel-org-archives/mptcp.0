Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43113AF9
	for <mptcp@lists.linux.dev>; Mon, 18 Sep 2023 08:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695024436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hn6abkxsMnCAyxEUP6Hj7XkYUcp4PiNmBPDLkuNKGqA=;
	b=YM4mVJE2xk6+hZfAVF+vgbYjw632UkAH2RA0JOBUdp+lN8qjeFDmCMs0rZLRl9tRweeq1m
	e9z7yX2r6NyWZNnQTn/6n4o7nW1bQ8H3aV38krzfmZiGQgkyWgmYi2q/ixoEIXssCPZBhM
	zD1dkkvhMHT3Qy9r0ZSQ/fYcgXMU3lo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-tSbuRsmKN0OIrcynifadXA-1; Mon, 18 Sep 2023 04:07:15 -0400
X-MC-Unique: tSbuRsmKN0OIrcynifadXA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-501c70f247cso3162802e87.1
        for <mptcp@lists.linux.dev>; Mon, 18 Sep 2023 01:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024434; x=1695629234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn6abkxsMnCAyxEUP6Hj7XkYUcp4PiNmBPDLkuNKGqA=;
        b=KfZe1l6mj/ly+BOEIXI27QPe4p5MU//whpqtZUmYVblyQWdrIBTt/kWOTV8LgmhGjh
         L7MYUL5qrwkRJ+So8u3aCfySZA8eRzgABW48C1wV7Mg7xUMNv4gC4mp1tIRHf7j5TIvF
         HI9U4wpidNj6xWCs1SPsZ81rcGL3bBe4Fu2nkPYhCpD5MDtdBqzCXMNVPkn67pH7XJVD
         pDfq5Vt3ohNCszbJyE1tjTIo3jJrDvVUeDtjMbjvxBCN6JYZl6pJ8UwK5hZMbOWw0Ix4
         x+9kA14PxDwLz7ylPEhnRXVBprgMALC2Frx7Ddm9AI7uXBIZlUBK0u3jdVCcRy6R9Lrz
         q8rw==
X-Gm-Message-State: AOJu0YxKiUxt0F7ynh5k3EvSmFKHZPNz19J2CfHXIH6QZ1kJL6GFDiA2
	M3Ddpkvs/pW9mkwuzywbCdQIXGZjxZkbMwuXvXJ7Cy5Dc3CWpKk5fv1jyiOWyF79RTG0eV8+6Cl
	BuRLWxSzpegtXuXOKrDcUWaqb28RgvFw=
X-Received: by 2002:a05:6512:1106:b0:4fe:8ba9:4c4 with SMTP id l6-20020a056512110600b004fe8ba904c4mr8087469lfg.59.1695024433755;
        Mon, 18 Sep 2023 01:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzrDiW1sIJOK70cUs7AIrb3TqwVblKMA0WOl02IMlNoP3amTj2/jV5c/xtvzVMDeP9MiEnOVpbvyT36DLcYMI=
X-Received: by 2002:a05:6512:1106:b0:4fe:8ba9:4c4 with SMTP id
 l6-20020a056512110600b004fe8ba904c4mr8087450lfg.59.1695024433369; Mon, 18 Sep
 2023 01:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1693921470.git.dcaratti@redhat.com> <2a1c0acc-52d2-4ffe-8216-c6fdf3e24a5c@tessares.net>
In-Reply-To: <2a1c0acc-52d2-4ffe-8216-c6fdf3e24a5c@tessares.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Mon, 18 Sep 2023 10:07:02 +0200
Message-ID: <CAKa-r6uQaqsv7a83r1GkAzssiEcLhiuMdMUVJpnSapiL1Xv4Ow@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 0/6] mptcp: convert netlink code to use YAML spec
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Matthieu

On Sat, Sep 16, 2023 at 1:14=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Davide,
>
[...]
> I was looking at applying them but I just noticed quite a few errors and
> warnings reported by CheckPatch. Do you mind looking at them please?
>
> > Davide Caratti (6):
> >   tools: ynl: add uns-admin-perm to genetlink legacy>   net: mptcp: con=
vert netlink from small_ops to ops
>
> Spaces are used instead of tabs for the indentation in
> include/uapi/linux/mptcp.h and net/mptcp/pm_netlink.c. This code is
> removed later but I think it is still best to avoid having many errors
> reported by the CI when sending them upstream.

yes, and it was unintentional. Will fix that today and resend a v4.

>
> >   Documentation: netlink: add a YAML spec for mptcp
>
> Can you add the path of the new file in the MAINTAINERS file please?
> Also good to add a small description in the commit message, at least to
> say that it is supposed to represent the YAML spec as currently
> available today ("no behaviour change intended").

makes sense,

>
> >   uapi: mptcp: use header file generated from YAML spec
>
> Please add a "*" in the MAINTAINERS file to handle the new one in uapi.
>
> Also, I guess we cannot fix:
>
>   Please use a blank line after function/struct/union/enum declarations
>
> in include/uapi/linux/mptcp_pm.h as it is auto-generated. (Maybe we
> should add a comment about that in the commit message? But maybe it is
> clear it is auto-generated?)

this can probably be fixed in a follow-up commit for ynl-gen-c tool
(that includes a tree-wide fix for the uAPI headers, because the issue
might also affect all headers generated until today). The commit
message says how we use the tool to generate sources, and the header
file has the "do not edit" caveat line - that is sufficient IMO.

> >   net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpi=
t}
> >   net: mptcp: use policy generated by YAML spec
>
> If it is OK to send a v4, please also add Paolo's ACK. I think that what
> he meant to say but he was apparently only allowed to send acronyms :-D

OK is an acronym as well AFAIK :)

thanks for looking at this!
--=20
davide

