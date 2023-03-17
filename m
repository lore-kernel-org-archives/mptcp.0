Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DE36A
	for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 18:56:40 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id i24so6718797qtm.6
        for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679079399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTdUlyOfdt8if93QsQQjrsJH2A0sNNFk09AT9iR57Ws=;
        b=EFi3o0HArF7UU3RivOVQRrRlFW6IQCaBsnCtxNHNCGuutqLAXEx8v31+MZ2nNQY+Tg
         FaeF8G47moLnzYjlgYcpsL4zHbS1+XqXmfiOuBODfSQ1uVBlTkeJFAHKAxsFaubZmE5x
         Zipjfqwm3/dJi7P5ugUcx1BfyqT8Caou44eRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTdUlyOfdt8if93QsQQjrsJH2A0sNNFk09AT9iR57Ws=;
        b=pa96uXKKJxEgfgWP5uXAZgRCwPVy+28RnPYpHt/F15XyfoWYDp6m5uI5w8qiJKNZ0M
         M5hmVXRVdeGIJP2s18g7aVFn0It1TGwBdJ8IQPrhWRdyewBXJLrat5N+QuKJwzDLkne6
         4slwIbfPzWIGRIN3uQSTJgzphMoVTfo59agkgRZvrLomJptzm5CgHfOUnbXt2WDFNXRI
         CWHEeL2NyNeQMmYkDof/qkkY9WEXkOrPX114TM3BLhtd02u90okdRJM9S5gL9JILoceW
         K84FR441rxemZCdOv2c2+pW+ek0ucvtZOe8acsXIhJG8oEgzyVhRoQR6NGL5uicT7X9u
         6Kvw==
X-Gm-Message-State: AO0yUKUpV8OwCMRlrTjUCMnPqxh1y/RAUECpT5+lsbi1hpIBCSbmZDl5
	NZFwWWSusoGDyJ5DzGVzv+jE0Q==
X-Google-Smtp-Source: AK7set9jipsIbDPeQ8GoSgJyYG70m2o786TV4vW4nF1NZSCv49CfSTMV5e2Aa66Gvx3kXmdFh0Da1Q==
X-Received: by 2002:a05:622a:1394:b0:3bf:b896:ff63 with SMTP id o20-20020a05622a139400b003bfb896ff63mr14593551qtk.52.1679079399521;
        Fri, 17 Mar 2023 11:56:39 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id r142-20020a37a894000000b00706c1f7a608sm2156724qke.89.2023.03.17.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:56:39 -0700 (PDT)
Date: Fri, 17 Mar 2023 14:56:37 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Daniel Vetter <daniel@ffwll.ch>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Kai =?utf-8?Q?Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
Message-ID: <20230317185637.ebxzsdxivhgzkqqw@meerkat.local>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
 <81f8be3e-4860-baf9-8e13-fec3a103245b@tessares.net>
 <CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com>
 <CAKMK7uESvC-zgGJEup1OAmf34Rk8s5cCrSBYUNP_REFUuer1-w@mail.gmail.com>
 <7974f3ec-3f17-c21c-139b-fd5651871a75@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7974f3ec-3f17-c21c-139b-fd5651871a75@tessares.net>

On Fri, Mar 17, 2023 at 07:41:04PM +0100, Matthieu Baerts wrote:
> @Konstantin: would it be OK for your future Bugzilla bot to deal with
> the generic "Link:" tag instead of the specific "Closes:" one?

Yes and no -- we can easily figure out that "it's a bugzilla link and it
points at this bug", but we can't make any decisions based on it. Just because
it's a bug that is mentioned in a commit doesn't really mean that the bug is
fixed and we should close it.

E.g. it could be something like:

    foo: initial workaround for bar

    This implements a workaround for problems with bar (see bug link below).
    It's not a complete fix, so further work is required to address all issues
    identified in the bug report.

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=5551212

It would be wrong here to auto-close this bug, but we can certainly add a new
comment that says:

    This bug was mentioned in commit abcd1234:
    https://git.kernel.org/linus/abcd1234

-K
