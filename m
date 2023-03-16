Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9077612F
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 17:38:29 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id eh3so10622533edb.11
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678988307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YryrzFP9xzjyk98MIHgDswzk42M925/BWmA7MtQw0v4=;
        b=A0Pimr4j0yRzB2HtZL9bze3pGqBPiEF6xNKE5vfcyBt677cjSAtvg+x/oOre2qx4f4
         uZZ9DGORTYr5Abdzg70+rqONkWvZC8UETXpsg8oaJvuYOj6CmaiXDh3TNBO93cCZZaTW
         CjkJsZMOuoWZi0SDYyZ55rb5UtAhm53yF+J+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YryrzFP9xzjyk98MIHgDswzk42M925/BWmA7MtQw0v4=;
        b=0bvDawnODfxUxgb1+5WvYtJ9TB7pJbctt4St2YmXVVTTe6DbJkj4Zo+LxigI8AcdAr
         d4j5JGx5iXYaN0YnPdfDHNtMSMmf7a/I8b6TF+9NuIHOv0rxZxDEnKJoRhxW/i1galew
         eW9Njjxxzo0UGVmTkPVSr/y9nbLcmZ3H4XFomsdlBbTbMxtymPKq0ELgzKtUOACe6DPc
         Z+xihQEONuogQ/oUW8TIRiyPTK/Nd7BpYJaevjTLVDgSFlLlNdg9WOFVF1uGiG0shwc8
         CvMb5sPH92cdXH6Y8L7mFefpT1WjLVSU1UBBfA3zSE8cRmeBhBwWhgfVU1HT1G5Tm32h
         y1vw==
X-Gm-Message-State: AO0yUKWnpnoPptxExN6n5cU/AoXrVEPYTfZ9H8WDNzcQxs1E9STm4KKO
	6J5QR4c3HwjYR1uQala9ddOXmldzktqFm77Vhg4Vjg==
X-Google-Smtp-Source: AK7set9S8WAIuWwNlp7wkyI1MXQ3uaflwWWvsFXwPCipHizqM2teMtDlOq0LCR9tRgTiHMvBnqA8bg==
X-Received: by 2002:a17:906:1ed6:b0:92b:ff31:45bc with SMTP id m22-20020a1709061ed600b0092bff3145bcmr10800332ejj.44.1678988307647;
        Thu, 16 Mar 2023 10:38:27 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id u22-20020a170906125600b008db605598b9sm4089088eja.67.2023.03.16.10.38.27
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:38:27 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id x3so10638300edb.10
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 10:38:27 -0700 (PDT)
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr5816749ejb.15.1678987850768; Thu, 16
 Mar 2023 10:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info> <81f8be3e-4860-baf9-8e13-fec3a103245b@tessares.net>
In-Reply-To: <81f8be3e-4860-baf9-8e13-fec3a103245b@tessares.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Mar 2023 10:30:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com>
Message-ID: <CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	=?UTF-8?Q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 4:43=E2=80=AFAM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> @Linus: in short, we would like to continue using the "Closes:" tag (or
> similar, see below) with a URL in commit messages. They are useful to
> have public bug trackers doing automated actions like closing a specific
> ticket. Any objection from your side?

As long as it's a public link, I guess that just documents what the
drm people have been doing.

I'm not convinced "Closes" is actually any better than just "Link:",
though. I would very much hope and expect that the actual closing of
any bug report is actually done separately and verified, rather than
some kind of automated "well, the commit says it closes it, so.."

So honestly, I feel like "Link:" is just a better thing, and I worry
that "Closes:" is then going to be used for random internal crap.
We've very much seen people wanting to do that - having their own
private bug trackers, and then using the commit message to refer to
them, which I am *violently* against. If it's only useful to some
closed community, it shouldn't be in the public commits.

And while the current GPU people seem to use "Closes:" the right way
(and maybe some other groups do too - but it does seem to be mostly a
freedesktop thing), I really think it is amenable to mis-use in ways
"Link:" is not.

The point of "Link:" is explicitly two-fold:

 - it makes it quite obvious that you expect an actual valid web-link,
not some internal garbage

 - random people always want random extensions, and "Link:" is
_designed_ to counter-act that creeping "let's add a random new tag"
disease. It's very explicitly "any relevant link".

and I really question the value of adding new types of tags,
particularly ones that seem almost designed to be mis-used.

So I'm not violently against it, and 99% of the existing uses seem
fine. But I do note that some of the early "Closes:" tags in the
kernel were very much complete garbage, and exactly the kind of thing
that I absolutely detest.

What does

    Closes: 10437

mean? That's crazy talk. (And yes, in that case it was a
kernel.bugzilla.org number, which is perfectly fine, but I'm using it
as a very real example of how "Closes:" ends up being very naturally
to mis-use).

End result: I don't hate our current "Closes:" uses. But I'm very wary of i=
t.

I'm not at all convinced that it really adds a lot of value over
"Link:", and I am, _very_ aware of how easily it can be then taken to
be a "let's use our own bug tracker cookies here".

So I will neither endorse nor condemn it, but if I see people using it
wrong, I will absolutely put my foot down.

                    Linus
