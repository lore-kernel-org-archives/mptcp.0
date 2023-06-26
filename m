Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439EBA26
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687791861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xBDgNgEyBA41kE66HJu0mpfMquzWn9inrHLQc2nowk=;
	b=QtMaJwd6pEFszFmNd+fjb/Cw1d0Gr4omjYsd+mAPJNb2k+UTO0a8fTQIUF8GyM0BEa87Ce
	W9L6zor6jJX3CPy/Mc9bLYZJv11e2UGfN7tKXCq+40s4lMYnPr3RRRO18hZ59PTn91Vxun
	bJ2wzqmoLNrV978xuAwIfw3quuawkqw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-eoK9TVA2O9GonrzaPByEKw-1; Mon, 26 Jun 2023 11:04:04 -0400
X-MC-Unique: eoK9TVA2O9GonrzaPByEKw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4009567b05eso3253291cf.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 08:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791836; x=1690383836;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xBDgNgEyBA41kE66HJu0mpfMquzWn9inrHLQc2nowk=;
        b=ly0bbhEAbdPPty6RHKu6x6kGXVdRLmB/5iFbFDRevH8F94knJ3ngfb8CU2WMHHqNs4
         LY41kW54eukE2Q4EF5XB6I8uqBvLSuauXd4uBH51o2RoyRlva1afGPip9sdzddCNkrPo
         PMjwgYnIf3nz+3VvZQNNIryCjnmqqELlhqVSbzCTZOiMdgImi5ArtJBNidwwiid+sd7E
         u1qD7d2zGKMlJ3rTW//qDJhR0ttm6lrN5zG4+XdjicgFvTvRCCkXXJx//DN0ByAvGsxw
         LxpIUl8Th4coJLMHol4feYSwE7voB12X7i6nmagezl4836fRnRzT6zMchvA1IkG7DbCh
         xo0Q==
X-Gm-Message-State: AC+VfDyLf9f48x178G5pkiDBO6QGJoM8NmO48dZtUtNd266PAm6Qrmkk
	F85ALEHa0C/7HvtOcZooB6ZFO6YxjT8zUAyNYMirGGHjcbvgR423vbXwIDXk0cJl4rie8h/T2GK
	W17DQejZZlYLuOSlubb239I8=
X-Received: by 2002:a05:622a:19a3:b0:400:9285:81d5 with SMTP id u35-20020a05622a19a300b00400928581d5mr10059265qtc.1.1687791835839;
        Mon, 26 Jun 2023 08:03:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FjAD97a/rC12+l3aagZcA035v3zqVLUIi1ZaYXYS9YxKv7Vgq2MAy7ZMsC52xBseWHlZj8A==
X-Received: by 2002:a05:622a:19a3:b0:400:9285:81d5 with SMTP id u35-20020a05622a19a300b00400928581d5mr10059242qtc.1.1687791835536;
        Mon, 26 Jun 2023 08:03:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id u12-20020ac8750c000000b0040094d6ba25sm3084889qtq.81.2023.06.26.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:03:55 -0700 (PDT)
Message-ID: <4853f865dc24e0ceab3a68830caa9b187b459619.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: ensure subflow is unhashed before
 cleaning the backlog
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 26 Jun 2023 17:03:52 +0200
In-Reply-To: <c199a3b4-0d93-4ae8-07e7-1e716fd919af@tessares.net>
References: <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
	 <c199a3b4-0d93-4ae8-07e7-1e716fd919af@tessares.net>
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

On Mon, 2023-06-26 at 15:20 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 23/06/2023 16:51, Paolo Abeni wrote:
> > While tacking care of the mptcp-level listener I unintentionally
> > moved the subflow level unhash after the subflow listener backlog
> > cleanup.
> >=20
> > That could cause some nasty race and makes the code harder to read.
> >=20
> > Address the issue restoring the proper order of operations.
>=20
> Thank you for this fix!
>=20
> I was surprised to see the CI complaining about the "fastclose server
> test" test, with *and* without the debug kernel config.=C2=A0

Same here!

On the plus side, it's more job security ;)

I'll try to have a look when time allows

/P

