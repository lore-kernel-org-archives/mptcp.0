Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38553A6
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 08:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690963403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo+8dg/DBj2V+G5oZvUMnojMP7aeWCXmA1VlhFSPE34=;
	b=P1x4Yi/ZuajV2n5EuuGhKK43K2qZN2adjihUUI80hCKq7OncUcbXnKndOLz5mZTQQyrNSw
	2T0GJ65OXa2ed97r9W0LgXD15PNh2IJdfEYxNEKIhTETTJ8+nXdEqNfr88yr9XD850Q9nW
	5WpLzNa0kMdta97v9/e8rLEbe2Dx1rg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-mnRWds6pMKm5bUK3TaLUjQ-1; Wed, 02 Aug 2023 04:03:20 -0400
X-MC-Unique: mnRWds6pMKm5bUK3TaLUjQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76ca3baaec8so76570985a.1
        for <mptcp@lists.linux.dev>; Wed, 02 Aug 2023 01:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963399; x=1691568199;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oo+8dg/DBj2V+G5oZvUMnojMP7aeWCXmA1VlhFSPE34=;
        b=itg/a2ZLxZcXGlmtRLceRFLjQJEuctK0h8/bZQXJ/erLzgmnNwY2GCzVC8MJ1aRzII
         8UGz7lEGoRLoWb5xVKQ5YozWM+oI2TjQZOMLCy+UaJiZaAlszjVI34wVcF5uku44zMVS
         qeKpJ2U3QKrioeSe9olsBaWfiYwlML4clb0YjJ20WQlMv0YpcZUCaNzymJymsASlmFQZ
         KXnaZti9XC1IcXOG/93TEFaB5tNlE2S7whprBlTJ8WbtlovsBGP0SWUgWRYuC00qg8be
         qBqEXHUSzamX3beDYF4yB+9wuptYJ3VUOou+Qbe9zfZ7FZRJVc0C0v2MyZtHOn4fGiuY
         hXug==
X-Gm-Message-State: ABy/qLYPxct5l0gEuSa7pC9KbymQOCVtPcX1SjKq3U2xIKv9ksWZbGVN
	fnAvxwpoRvcsuxjW65OXR+FMPcxY+Y5GpvH0JhHfNuXkVmTu7wpdp25jDFixQ6bqTkPwmIT0x0P
	vFqQVAgRBy9zmZO0=
X-Received: by 2002:a05:620a:31aa:b0:767:7a4c:1b9e with SMTP id bi42-20020a05620a31aa00b007677a4c1b9emr15272974qkb.7.1690963399779;
        Wed, 02 Aug 2023 01:03:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnNAWWhSXb/HktBSfXGFmabV1fvsy307saOx2MgChsfs7xTXLkVxm9csctRpjZ4apFAXP/zg==
X-Received: by 2002:a05:620a:31aa:b0:767:7a4c:1b9e with SMTP id bi42-20020a05620a31aa00b007677a4c1b9emr15272941qkb.7.1690963399461;
        Wed, 02 Aug 2023 01:03:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-7.dyn.eolo.it. [146.241.233.7])
        by smtp.gmail.com with ESMTPSA id p12-20020a05620a132c00b0076c9cc1e107sm3299044qkj.54.2023.08.02.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:03:18 -0700 (PDT)
Message-ID: <1b51c79c59cb3ec4be95e993be9be2e5d9441670.camel@redhat.com>
Subject: Re: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
From: Paolo Abeni <pabeni@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Geliang Tang
	 <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Florent Revest
 <revest@chromium.org>, Brendan Jackman <jackmanb@chromium.org>, Matthieu
 Baerts <matthieu.baerts@tessares.net>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  John
 Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris
 <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev,  apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,  selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Wed, 02 Aug 2023 10:03:12 +0200
In-Reply-To: <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
References: <cover.1690624340.git.geliang.tang@suse.com>
	 <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
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

On Mon, 2023-07-31 at 17:43 -0700, Alexei Starovoitov wrote:

> I still think it's a hack, but its blast radius is nicely contained.
> And since I cannot propose any better I'm ok with it.
>=20
> Patches 1-2 can be squashed into one.
> Just like patches 3-6 as a single patch for selftests.
>=20
> But before proceeding I'd like an explicit ack from netdev maintainers.

Just to state the obvious, I carry my personal bias on this topic due
to my background ;)

My perspective is quite similar to Alexei's one: the solution is not
extremely elegant, but is very self-contained; it looks viable to me.

WRT the specific code, I think the additional checks on the 'protocol'
value after the 'update_socket_protocol()' call should be dropped: the
user space can already provide an arbitrary value there and the later
code deal with that.

Cheers,

Paolo

