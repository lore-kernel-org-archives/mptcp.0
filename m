Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3305681
	for <mptcp@lists.linux.dev>; Wed, 15 Mar 2023 18:12:08 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id jl13so13277943qvb.10
        for <mptcp@lists.linux.dev>; Wed, 15 Mar 2023 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678903927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PS5OB3AO5CNPuv7NYq4FqsiUlkdNQVwkaY5HT7lJGkE=;
        b=bFcK1BVVp+Fpmx62ppND1CCgS30Nof0np8KQcOy5IwENwvc4ZHxk6oVKnu01TssBc4
         Y3CuOpANJjRF+ciAo6WX0LrExb3onjgODmH2L23lV7cHe7h31wGOFQw5Q1+Bj+VEx8Mb
         etj6Y18ekY2Rcl9UUtQMUnwgoacI2SzmSETf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS5OB3AO5CNPuv7NYq4FqsiUlkdNQVwkaY5HT7lJGkE=;
        b=ZU7VDMixsplHv4Iig0WGzOnMp31sMgv/AFxR7g70zrDBuD3D8rCkw6WVK1LAjlqzOi
         RspK+0o3LqMz8i8Ly+afROnEBlDxOhCXJhdDVccvugdlL1evJb7zXDVH31aZU7UxvJO+
         gX6r1+t8jZkG448bNzRQ3o4G9yhclaP+GMU4M48bKRUhIHWCjF4SZ0V3ihlrcZJu6rVe
         QeE1ilVst15Tw9SRjTcjxU01K4NVyb8zqMdLo6GOEVo+9+2jiSYo2ycWvl8seQ4X/a/y
         GC3BEl7rlod8seRwJnuE82wuzHqvl7sBl4HcQ+75HxEfJh7jq54qOraPpuJr/pEzjXUF
         J7Vg==
X-Gm-Message-State: AO0yUKUhbHF98tsc6UW9zhaDx/+NYfveL5Yq5m73YfD1ciZlqiKjolZm
	cIynF8be62YpEjiA7JYAEz3VNg==
X-Google-Smtp-Source: AK7set9rrNpfb0/qEWxFOnB6R5Sm+ReQx329l+TzH4ao5UaiZyCVwdLD9M7+YcA+iA9IRzAmUxnvDg==
X-Received: by 2002:a05:6214:130b:b0:5a3:79cd:8ef7 with SMTP id pn11-20020a056214130b00b005a379cd8ef7mr27365952qvb.23.1678903927652;
        Wed, 15 Mar 2023 11:12:07 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id a20-20020a05622a065400b003bfd8e2ab40sm4299551qtb.16.2023.03.15.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:12:07 -0700 (PDT)
Date: Wed, 15 Mar 2023 14:12:05 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Kai =?utf-8?Q?Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
Message-ID: <20230315181205.f3av7h6owqzzw64p@meerkat.local>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>

On Wed, Mar 15, 2023 at 06:44:56PM +0100, Matthieu Baerts wrote:
> Note that thanks to this "Closes" tag, the mentioned bug trackers can
> also locate where a patch has been applied in different branches and
> repositories. If only the "Link" tag is used, the tracking can also be
> done but the ticket will not be closed and a manual operation will be
> needed.

We will soon gain this ability on bugzilla.kernel.org as one of the features
of the bugbot integration tool (which is still WIP). So, if it helps, I
support making this a recognized trailer.

Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K
