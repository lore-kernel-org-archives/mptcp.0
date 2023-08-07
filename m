Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9811196;
	Mon,  7 Aug 2023 15:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43936C433CA;
	Mon,  7 Aug 2023 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691423820;
	bh=Iopmv+W8uy8uD0k3ogKDht+ceVh8rBeVYwhjSufP83E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VU5bcDi7ArPZqb6glNgWpk5ny7460mZ0gBPyrh/PlhDGp00jUZ+35I0SFnIA1WpWs
	 uqDS6BjdxOCSAd5LUG9Sg5A/zU7Q1TRWfJd1K5BcIw+hO10wxxlVItjcZ7KUsHLYMW
	 JQJkDlAGLexH5OEKSY0JZtP/pDSHxryKXX9WlHHuDYsWaylWlOFsZKXP+k6n5G96m2
	 HcI+ZFRiu7IPgw3UgQRfrFxcgh4kx3Mc5KJQqQQFfGMveeQuAy+Vf7EjTxIeigNaQK
	 Ku0euTTi4UBE2pCD30rrMN4wDj5Clod4/Mjyi6xNdED5bPGo+D35sknmKjdcXg1kHY
	 Pnc8+3o9eOfFw==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-58439daf39fso50839767b3.1;
        Mon, 07 Aug 2023 08:57:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNX2K8ZHDn+Adpcb8oRu+PBW3fB+k8PHoRr3eUuGWna8MmueaB
	dNtC673lGh6sXatMaqDdTEPDBPFfvT8aI+OT+jA=
X-Google-Smtp-Source: AGHT+IEcbPuDjuDLG1OuOckkYLVwk/OnR5k1qorstnsiJ62vul1IfTXd1TdZqwIwEugXgCw+qf7jmNF3PcpAkZySXLY=
X-Received: by 2002:a81:5e0b:0:b0:586:9fd4:6b84 with SMTP id
 s11-20020a815e0b000000b005869fd46b84mr10694794ywb.46.1691423819458; Mon, 07
 Aug 2023 08:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTnX0=-GK8sFzd4S+V2+cA8E-FAqYHNndZui2Sh_MvoHPw@mail.gmail.com>
 <88f7a06b-b044-9fdc-b3dc-4b374dbca332@tessares.net> <3E1DD5A9-A8CB-4951-839A-6EF229CFA8EA@icloud.com>
 <4830cc62-64fd-f74b-bbfc-b8e44e023513@leemhuis.info> <CAFkjPTnAV6Rngwn6voCF332CX+eUyeJd7U0GcYn9BbkBqcTkHA@mail.gmail.com>
 <bad1180f-dc6d-45d8-9acc-08edd548261a@tessares.net>
In-Reply-To: <bad1180f-dc6d-45d8-9acc-08edd548261a@tessares.net>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 7 Aug 2023 10:56:48 -0500
X-Gmail-Original-Message-ID: <CAFkjPT=xrkc1UVVFO8Qt35iEUWDTY0MMKO+CxwosySZvpME5vQ@mail.gmail.com>
Message-ID: <CAFkjPT=xrkc1UVVFO8Qt35iEUWDTY0MMKO+CxwosySZvpME5vQ@mail.gmail.com>
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, evanhensbergen@icloud.com, 
	MPTCP Upstream <mptcp@lists.linux.dev>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's good news because I was having a horrible time reproducing it.
I'm glad we removed that extra bit, we were thinking it was benign,
but I guess it turns out it wasn't!

     -eric

On Mon, Aug 7, 2023 at 10:42=E2=80=AFAM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Eric,
>
> On 13/06/2023 18:07, Eric Van Hensbergen wrote:
> > Understood, this on top of my 9p stack, but day job has been getting
> > in the way lately so I need to unstack there first.  Will do my best
> > to reproduce and understand as quickly as I can -- but given its a
> > performance regression it is likely going to be tricky to reproduce
> > and understand, so I'm not sure how confident I am that we'll be able
> > to close it out prior to the final -rc.
>
> Good news, it looks like the bug has been fixed!
>
> I recently noticed some new patches fixing some issues in 9p in Linus
> tree because they were conflicting with the revert of 9p's v6.4 PR I did
> in June to stop having random issues in our tests. I then tried
> reproducing the issue we had on top of Linus' tree and I was not able
> too! (but I was still able to reproduce them just before the recent fixes=
)
>
> After a quick git bisect, it seems the bug is fixed thanks to
> 350cd9b95975 ("fs/9p: remove unnecessary invalidate_inode_pages2").
>
> So we can also tell regzbot to stop tracking this:
>
> #regzbot fix: 350cd9b95975
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
