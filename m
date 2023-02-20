Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77102F3E
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676903427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8l9rRf+vjbY85N1PPAvM83bXBYMvQVqIWaMzUTf9s4w=;
	b=Iq53XCMoMJrclj+j0UeuaZtHtKrcMN0WM2h6mXi+PqKX/5dXmURYLSi58lKbtxVXte2jro
	I3OiiVOGYm+uRRHanZnBXJtK0iwgLLwM6OqlYFbBZCZQVCAMIVTQfIYfxGTH+eqrGTMgXF
	s358pJeYjZhrKHdJJmqhtl9EzXcmC7A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-0sikgl9QPWGIm7oY-lMJrQ-1; Mon, 20 Feb 2023 09:30:26 -0500
X-MC-Unique: 0sikgl9QPWGIm7oY-lMJrQ-1
Received: by mail-qv1-f69.google.com with SMTP id ny17-20020a056214399100b00570f687e908so306956qvb.14
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 06:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8l9rRf+vjbY85N1PPAvM83bXBYMvQVqIWaMzUTf9s4w=;
        b=4BuSVORqjialoJmriH9Q8Uz68BoE1yQsjlMu8HLddPvbcPhTsqWp7HfjPKOOTZQmk/
         bgxjBO1KV7BlHBdXjmBtzzrRbCn2fL3ugWfwd7vTZClFadmPT0eem2DmZFsY8PzIgMow
         NruKeZrXw4smQUBx76+AixpxlM/w70jHnRcB0ZXGTo4Ior4T5/T8R4wm7h/nfdOpkgoJ
         SxNLKGxH8XV4NNWA09sLqVoQVsqYOpCXT35GaOZngDDL33ZAZK7kDfIXAl2dVlUOPUcM
         BHras37NmE4roJTe6M+ZGk3O/uPLMtpXkHY/SGKO60j4XZy9FZAhKk54O9lJE/Cb9QwX
         X2oQ==
X-Gm-Message-State: AO0yUKVkyhhhaWk/ZA4UkybuVfqypYXIHTPgLxcGUf7GXMzgPWsXx6Fh
	vLLPV+MD8Pa6deU02YacZArGsgEcA/vtL/0nMWLwXmP1Sfb6gVsTpgVCJgKTQxCERmgAjEmmoVl
	2pe1Zl9mp6S4tWyE=
X-Received: by 2002:a0c:a986:0:b0:56e:9a8c:8980 with SMTP id a6-20020a0ca986000000b0056e9a8c8980mr1424746qvb.0.1676903425970;
        Mon, 20 Feb 2023 06:30:25 -0800 (PST)
X-Google-Smtp-Source: AK7set8OCtQTvA/gNN60YPvRfVqCDxKk3WYaIgKGOAWRc6kJEXAT8KGY7buzdqn1h5X8q/EkdzSe1g==
X-Received: by 2002:a0c:a986:0:b0:56e:9a8c:8980 with SMTP id a6-20020a0ca986000000b0056e9a8c8980mr1424709qvb.0.1676903425554;
        Mon, 20 Feb 2023 06:30:25 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id v63-20020a372f42000000b0073b4cdb0745sm520002qkh.116.2023.02.20.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 06:30:25 -0800 (PST)
Message-ID: <a00e24a4f9cc571980c0f8aee6c4f9aa68ed0cdc.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix UaF in listener shutdown
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Mon, 20 Feb 2023 15:30:21 +0100
In-Reply-To: <4cef3e6b-ad2b-0757-098d-14f09692f68e@tessares.net>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
	 <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
	 <7c02bf27-2de1-cea8-691a-120c988c4da0@tessares.net>
	 <5eb0dec3-172a-953d-110d-009cadaa711f@tessares.net>
	 <531ceec4b5af0abe463e80a19d98752ed1074aad.camel@redhat.com>
	 <4cef3e6b-ad2b-0757-098d-14f09692f68e@tessares.net>
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

On Mon, 2023-02-20 at 15:05 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> Thank you for your reply.
>=20
> On 20/02/2023 12:51, Paolo Abeni wrote:
> > On Mon, 2023-02-20 at 12:14 +0100, Matthieu Baerts wrote:
> > > Hi Paolo,
> > >=20
> > > On 17/02/2023 18:58, Matthieu Baerts wrote:
> > > > Hi Paolo,
> > > >=20
> > > > On 09/02/2023 19:48, Paolo Abeni wrote:
> > > > > As reported by Christoph, the mptcp listener shutdown path is pro=
ne
> > > > > to an UaF issue.
> > > >=20
> > > > Again, thank you for the two patches!
> > > >=20
> > > > Now in our tree (fixes for -net) with my RvB tag.
> > > >=20
> > > > I had a few conflicts when applying them on -net (and later when
> > > > propagating them to our tree, see below), I hope that's OK but don'=
t
> > > > hesitate to double check if you have the opportunity :)
> > >=20
> > > I probably didn't resolve the conflicts properly (or maybe some
> > > adaptations are needed on -net) because this introduce some regressio=
ns
> > > on export-net (not on net-next):
> > >=20
> > > Any idea what could cause that?
> > >=20
> > > https://github.com/multipath-tcp/mptcp_net-next/issues/361
> >=20
> > I *think* it's not a conflict resolution issue; patch 1/2 here
> > functionally depends on ("mptcp: refactor passive socket
> > initialization") which let msk take a reference on unaccepted MPC
> > subflows, so that incoming reset will not free such subflow via
> > inet_child_forget().
> >=20
> > I *think* the easier solution is moving this patches on export-next
> > after ("mptcp: refactor passive socket initialization"), mentioned
> > explicitly the functional dependency
> Indeed, it makes sense. I just did that.
>=20
> I removed the Fixes tags and mentioned it was linked to the refactor of
> the passive socket initialization: is it OK? :)

I *think* we want to preserve the Fixes tag, to help stable team. We
can send fix to net-next in case like this.=20

Anyway, no strong opinion on my side.

Thanks,

Paolo


