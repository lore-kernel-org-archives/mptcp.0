Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A4110E
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680854448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1b24xZ95YQQ3+puLwM4Th9SB79EvalVOOrgqjnnsIQ=;
	b=VVI6oBRqoQn7DTSyed1sUhuXkZjwY1KU3Gpg7QHHUeu+oMnqGGaBYmCK6KK7kEr0o7cJbR
	8qS4vb42RyLUj65ouKEkOFThcW2EnF/9+bkEFcG4F6ols8nYW4FodJLsnPsymIuIHjDgCd
	MDorhgx6QlG4je6hMLLU/IWzMBlu6TE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-e6Wyog7KNQCIbnYd5rdflA-1; Fri, 07 Apr 2023 04:00:47 -0400
X-MC-Unique: e6Wyog7KNQCIbnYd5rdflA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e1522cf031so15739771cf.1
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 01:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680854447;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d1b24xZ95YQQ3+puLwM4Th9SB79EvalVOOrgqjnnsIQ=;
        b=bS1r47yAJkAY2JI9Nmg6nLao7KPi2k2b4wVCSFgWdTXykVQeU3N+R04lmoyXpralrh
         lQsblc0sVXhk/B3tnGkAj6IQaVse3fBrBYchPiEx7tgNQMew59TlQyZlicBERl9tDywK
         PJf93xdnUk3QOH8NZd4rxTNkbObwCnBxSnugmiEaApdEJFVnMueiW15Dl8njIXGppeEG
         sB28LjE6v5BApL7qJ1jYLNltkL/wf2Mar/wWY6Vab8BigdasQ9k6ad4ntNgLkYiZ6917
         Wk7iuhKtZ7aGUA8F+hwCJtfPFu/q0eqqqaPHafm+9O12UXvx3l52l5/Ru9XbBX6d5olO
         xOUg==
X-Gm-Message-State: AAQBX9e7IUDS+h4Eh3s5YEXfL49dgqu0vh98ESki3IAVc9f7zrOIl+Na
	4etEJUnotkK1dumpT35QTXmhrFGC84OOlKtXbFbtRdsWw5U4WnjQknsJD8yPTRk6HkSxmV5DZ/c
	pU8IVujjmnbCpxsw=
X-Received: by 2002:a05:6214:518c:b0:5da:b965:1efe with SMTP id kl12-20020a056214518c00b005dab9651efemr2932082qvb.4.1680854446853;
        Fri, 07 Apr 2023 01:00:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZXnfWbO2H+VvovWLQzf33Zb2bYKXwaJX02PqU9T36D5fz/eOfVDN1gDMMRYG1CeBS/LnWCKg==
X-Received: by 2002:a05:6214:518c:b0:5da:b965:1efe with SMTP id kl12-20020a056214518c00b005dab9651efemr2932043qvb.4.1680854446532;
        Fri, 07 Apr 2023 01:00:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id r190-20020a37a8c7000000b00746b79101b6sm1120455qke.67.2023.04.07.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 01:00:46 -0700 (PDT)
Message-ID: <85d65b14b0550b284bf641ca0db55c550e23b251.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp-net-next 2/5] tools: ynl: fix bug in case of
 multiple nested attributes of the same type
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 07 Apr 2023 10:00:43 +0200
In-Reply-To: <9414bdc6d3d0212238cec12d4f2d80894910e944.1680801697.git.dcaratti@redhat.com>
References: <cover.1680801697.git.dcaratti@redhat.com>
	 <9414bdc6d3d0212238cec12d4f2d80894910e944.1680801697.git.dcaratti@redhat.com>
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

On Thu, 2023-04-06 at 19:31 +0200, Davide Caratti wrote:
> when a policy contains multiple nested attributes of the same type, avoid
> re-initializing .request and .reply members.

It's unclear to me why we need to avoid such re-init...

>=20
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  tools/net/ynl/ynl-gen-c.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index cc2f8c945340..ba55f217a006 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -812,7 +812,8 @@ class Family(SpecFamily):
>                      inherit =3D set()
>                      nested =3D spec['nested-attributes']
>                      if nested not in self.root_sets:
> -                        self.pure_nested_structs[nested] =3D Struct(self=
, nested, inherited=3Dinherit)
> +                        if nested not in self.pure_nested_structs:
> +                            self.pure_nested_structs[nested] =3D Struct(=
self, nested, inherited=3Dinherit)

... and is unclear to me how the above produces the effect described in
the commit message :)

Thanks!

Paolo

