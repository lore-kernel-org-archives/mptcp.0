Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B718F60
	for <mptcp@lists.linux.dev>; Tue, 12 Sep 2023 13:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694524553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG9X+JhBhpei7jS7BjVFnxnqT3CtcbWv76MDv0M6l9Y=;
	b=gF51Lj4eSopI5RIYK3lc9VKPHKbFUA5gn1ni3BOvDY2upy2/OYgJx+u13JL8SvgqQSHk9B
	kc++9abEPkM/llz8mNbz7iPyM2F3kj2g6kJL47P9iN0U1OOSqaB3hEaHvg65q09A1Oj7lJ
	OrOy+FJRstzOeOQYVhoCF3rFThE406U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-y5xVQGFgMe2o3O2UhuyHjA-1; Tue, 12 Sep 2023 09:15:51 -0400
X-MC-Unique: y5xVQGFgMe2o3O2UhuyHjA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bf6f455751so6867071fa.0
        for <mptcp@lists.linux.dev>; Tue, 12 Sep 2023 06:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524550; x=1695129350;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zG9X+JhBhpei7jS7BjVFnxnqT3CtcbWv76MDv0M6l9Y=;
        b=W9vnfAw071BhY3ptc3j1KHeVkAFm7yFveLFgG37sN5vX5QCWil+zZlE+HaB76LI1y2
         VjrFQu5ls1qNZjucQXgzfMZuv8XUm3MjwAEJpEGe7QpQ82j4FCQACsv0wJ9iMfXDMc7+
         /pOQDZTsNqCS2MgqpC/mxoYjEEj2VQN6zqSn9MSI3qDLwyXPBrnT1nqbKztgKswepRZC
         Yun7NLxr5LGz99WBkjGjGUv6xZlcqeF0m0Ubdu1/twvjE0g7TfIcaNqQzXiTs2qUR8l/
         tgKbU5qzfhMxQuupVrr0Qwo4X58bThxJl8KHdKt/uEwkBNEmp08r7Kfb9CZKgIJXb8Sa
         OaLA==
X-Gm-Message-State: AOJu0YxsKJQqkCSFg/iaSSZ4QY+LzfiDkcwa3IAPIH0iPbFMeFrylrP6
	364FCKjWFA51ax5NMwA+EYAIPg/7+nlxqicJ276nvARZSofFqVwKYgsu/gi9q0wHlBxEybqvLiW
	+mUFDqSJbvmbVrnw=
X-Received: by 2002:a05:651c:154c:b0:2bc:ba79:c3ff with SMTP id y12-20020a05651c154c00b002bcba79c3ffmr9749610ljp.2.1694524550216;
        Tue, 12 Sep 2023 06:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeqJ89NOywfiQRGhH4ZC+BA8tY64SctlVUJ8bID8t8LTMX0clXastQqkEqu6Sujf4vrCZ0kw==
X-Received: by 2002:a05:651c:154c:b0:2bc:ba79:c3ff with SMTP id y12-20020a05651c154c00b002bcba79c3ffmr9749597ljp.2.1694524549817;
        Tue, 12 Sep 2023 06:15:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id os10-20020a170906af6a00b0099b921de301sm6800219ejb.159.2023.09.12.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:15:49 -0700 (PDT)
Message-ID: <0c47fada6486e7126c43977bff66e406da3e01a6.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v5 2/2] mptcp: fix dangling connection hang-up
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 12 Sep 2023 15:15:48 +0200
In-Reply-To: <ebd5a0b6-1633-42d5-87cf-af9281b81fa9@tessares.net>
References: <cover.1693988314.git.pabeni@redhat.com>
	 <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
	 <4f8e9b17-e19a-44a3-adac-38771b5fac51@tessares.net>
	 <982b3b51305db17ed5a8371c7cb3abb41c05ab97.camel@redhat.com>
	 <869db5c2-c1e1-46e6-8b97-ce33dfc9f7e1@tessares.net>
	 <5734fb79e301d6e91ada91e3b70009f51c0fcce8.camel@redhat.com>
	 <ebd5a0b6-1633-42d5-87cf-af9281b81fa9@tessares.net>
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

On Mon, 2023-09-11 at 13:34 +0200, Matthieu Baerts wrote:
> On 11/09/2023 12:12, Paolo Abeni wrote:
> > On Mon, 2023-09-11 at 10:42 +0200, Matthieu Baerts wrote:
> > > On 11/09/2023 08:13, Paolo Abeni wrote:
> > > > Can we keep both tags? I would like to track the dep on bbd49d114d5=
7
> > > > explicitly.
> > >=20
> > > I don't know: if we put multiple "Fixes" tags, how is it interpreted?
> > > Does it mean: we backport this patch to kernel versions having all (o=
r
> > > at least?) the commits mentioned in the Fixes tags?
> > >=20
> > > As long as it is not confusing for the stable team :)
> >=20
> > I also don't know how multiple tags are handled by the stable team. But
> > I really want=20
> >=20
> > bbd49d114d57 ("mptcp: consolidate transition to TCP_CLOSE in
> > mptcp_do_fastclose()")
> >=20
> > being explicitly there in the commit message, otherwise I fear backport
> > will cause more bugs then the one they are supposed to fix.
>=20
> When I applied the patch, I modified the end of the last paragraph:
>=20
> > The issues is actually present since the beginning, but it basically
> > impossible to solve without a long chain of functional pre-requisites
> > topped by commit bbd49d114d57 ("mptcp: consolidate transition to
> > TCP_CLOSE in mptcp_do_fastclose()").
> >=20
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
> > Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
>=20
> See: https://github.com/multipath-tcp/mptcp_net-next/commit/8bf3aa786cf6
>=20
> The commit bbd49d114d57 is mentioned in the commit message but not
> marked as "Fixes". I can change that if you prefer and do the follow-up
> with the stable team to see where they are going to backport it.

The current form LGTM, thanks!

Paolo

