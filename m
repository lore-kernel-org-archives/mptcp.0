Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A32F36
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 22:46:01 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id x66so2428170pfx.3
        for <mptcp@lists.linux.dev>; Thu, 08 Dec 2022 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GXy3yVe6q44PfcggGGGUoLM0qgF3oqADIjhfyUy/5w8=;
        b=m0U0ZyFNHfG7+MToeaYyNjB7X1PggzXeEpqu2rb1ZJ7cTBviwA7gIG9Tyg572P8M1b
         aKoxD95GRuURnVVDMmNXtach1deUW3CYeOF5HiN+hYwwM+xShJ0zYF+iP0iEFmn/cHM2
         lEauTXA0ZpM1jcwn45Hth/b30ZBTjfcRMzgHJkIvt3Pl08Id5JbUY7+Vupwn4p0vOjJE
         1E6B+2w13xlykPVmmMf+fKKASvtjbBEG8Tui51K4xAhWtHIyua0fwLbOPhtad3sc6YB0
         wnq14MofX2PUUUiAPae/85s/LGMAQZtc8xd1yTvA1WF4lH5xFjw8y2ZZoxfgpGRWjQOd
         6QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXy3yVe6q44PfcggGGGUoLM0qgF3oqADIjhfyUy/5w8=;
        b=CehuICPOJ+TymvUwJglfRqReZ89pA+F8Km4I9SMBJ3UoUh9SLe8gY61uhCleQWQgT2
         VImAOisHY0qUSlGWMor+uZzBdCfm9egrAkBcx8XeXyPYcZtz4wsC4vSv7BXUmX+hxzTF
         yQToEnmPfIPgR3EBzwFgz1pHGh+o4WZmumDI4w/5dZ7tkcvSqHLKZaiGDnoVfGX+fL5t
         px4oiCCYfGOwaEZ9JAu9VIf8Af+WAtyfZUNVRwkGUOC5IuRCZOxoSqDCjHYu65HRfrjl
         nluQDgWcRLYqXIQTVplwlKI769H2nDuHrbjb7vorX4zpFaVsu9Mfq1DjWaHjRxyU9sNp
         Dx+Q==
X-Gm-Message-State: ANoB5pk08ocMZxeeCzu8NIsBfDsJInvsdqnkNMXJJOVEb6waN2aasMR4
	KX92TOTMARd/SzVczQN24ECnDeVIrERruLM03ZUU
X-Google-Smtp-Source: AA0mqf6bVEu+zdRUSkuWOcp4cIkScjpUe3duREc67t/ScI57nnNA5ajNFIWKMsygOUVvxfoMtTAQsEEbtmvq9CmQ8oU=
X-Received: by 2002:a63:e74a:0:b0:478:42f:5a3d with SMTP id
 j10-20020a63e74a000000b00478042f5a3dmr48968019pgk.3.1670539560762; Thu, 08
 Dec 2022 14:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com>
 <108a1c80eed41516f85ebb264d0f46f95e86f754.camel@redhat.com>
 <CAHC9VhSSKN5kh9Kqgj=aCeA92bX1mJm1v4_PnRgua86OHUwE3w@mail.gmail.com>
 <48dd1e9b21597c46e4767290e5892c01850a45ff.camel@redhat.com>
 <CAHC9VhT0rRhr7Ty_p3Ld5O+Ltf8a8XSXcyik7tFpDRMrTfsF+A@mail.gmail.com>
 <50e7ea22119c3afcb4be5a4b6ad9747465693d10.camel@redhat.com> <CAFqZXNtOku4vr5RrQU4vcvCVz5iK79CimeUVHu0S=QoN-QVEjg@mail.gmail.com>
In-Reply-To: <CAFqZXNtOku4vr5RrQU4vcvCVz5iK79CimeUVHu0S=QoN-QVEjg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Dec 2022 17:45:49 -0500
Message-ID: <CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com>
Subject: Re: Broken SELinux/LSM labeling with MPTCP and accept(2)
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, mptcp@lists.linux.dev, 
	network dev <netdev@vger.kernel.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 6, 2022 at 9:43 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Dec 5, 2022 at 9:58 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On Fri, 2022-12-02 at 15:16 -0500, Paul Moore wrote:
> [...]
> > > What if we added a new LSM call in mptcp_subflow_create_socket(), just
> > > after the sock_create_kern() call?
> >
> > That should work, I think. I would like to propose a (last) attempt
> > that will not need an additional selinux hook - to try to minimize the
> > required changes and avoid unnecessary addional work for current and
> > future LSM mainteniance and creation.
> >
> > I tested the following patch and passes the reproducer (and mptcp self-
> > tests). Basically it introduces and uses a sock_create_nosec variant,
> > to allow mptcp_subflow_create_socket() calling
> > security_socket_post_create() with the corrct arguments. WDYT?

I'm still working my way through the recent patch posted by Paolo
(sorry, I lost some time due to build failures and other discussions),
but I wanted to comment on a few things in Ondrej's email ...

> This seems like a step in the right direction, but I wonder if we
> shouldn't solve the current overloading of the "kern" flag more
> explicitly - i.e. split it into two flags: one to indicate that the
> socket will only be used internally by the kernel ("internal") and
> another one to indicate if it should be labeled according to the
> current task or as a kernel-created socket ("kern"?).

The problem here is that labeling behavior isn't always going to be
the same across LSMs, or rather I don't want to force a specific
labeling behavior at the LSM layer.  We pass the @kern flag to
indicate a kernel socket that is not visible to userspace, but we
leave it up to the individual LSMs to handle that as they see fit
(including if they should label sockets based on @current, an
associated socket, or something else).

> Another concern I have about this approach is whether it is possible
> (in some more advanced scenario) for mptcp_subflow_create_socket() to
> be called in the context of a different task than the one
> creating/handling the main socket. Because then a potential socket
> accepted from the new subflow socket would end up with an unexpected
> (and probably semantically wrong) label. Glancing over the call tree,
> it seems it can be called via some netlink commands - presumably
> intended to be used by mptcpd?

Yes, this is something we need to be careful about, if we want to
treat all of these subflows just as we would treat the main socket,
the subflows need to be labeled the same as the main socket,
regardless of the process which creates them.

As a FYI to the non-SELinux folks, a socket's label can be important
even when it is not visible to userspace as the label is used both to
set the on-the-wire label (CIPSO, CALIPSO, labeled IPsec) and in the
per-packet access controls (see security_sock_rcv_skb()).

-- 
paul-moore.com
