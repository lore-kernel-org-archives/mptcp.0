Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844623FC3
	for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 16:41:49 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id 73so14237061qki.4
        for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBN/qteeDyWq3TS58wIG7jkerkKlW6l9HEuk/o/IJuw=;
        b=r5mpIFNZvGulvdrw3rSLgYXpkDniFlpqk5vIULMa+KB0DSjC28smVp6qRCp2hx55KZ
         C4sTR9D7nkm8LoE9ZXEqyiL7m2oIlikhWrHvuPrW8t73lOOGv29onrZwgMYuDfgG6G51
         QUnP3bJlu6rxqfxLYJVgkB1SdeBqcNVzWBUooCooS2O+eVHQat+mW4JxvG36gYoGErEK
         AulBCrYlpJTodeN2Z9BvVIB24MYOZnJv36Kcns6HJWf3FDP5iUYcae97ZrJ2j6liyXp7
         YpSVbh+ZLL8UK4jj+BK4JmxMhc09hMRnUzTvpLwtnsVSRD+PW3axVnyOSV1/ekEg4ud2
         M/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBN/qteeDyWq3TS58wIG7jkerkKlW6l9HEuk/o/IJuw=;
        b=TDKdY0q3EwrriJp5ehlKbZrfuuLwvgd/Tl2pbIaKL2kIPwkvTIKROjeGYfsBrmabTg
         bA1g8TPg560Zv30npzdLCGiC9QCziyn/L/RXIsQn0sk9HrBSru8MwCPgy+PHdXn5gZic
         xoqb3tGEQUtWO2B/cyChi5Pr4P5l2Y0z4nwu06Gc8PH+YGuXemtgUFgzSPkTiYFjEMC+
         xQ2dGAh/l1ydn+LSAue+NkjIV8PXPw4aAawKwI0AVweBVyU+Zu8PvVtnXZnKwieK8q9S
         irLIsMaFWSRKn/h56OuaPmzsf5NSfM08fiCsqpj+m0ntmIt/jaq1Zx/ZTH1fw7KPrc8M
         av+A==
X-Gm-Message-State: AOAM5319mIKo2WqcVHhhGcYGxnLHc4NjEFXx3gESqBxQg1xmuzaJu5ZR
	M+z8U+fe1CE1OQ5r6qfIpJoolhZ7RGZBpsfkrr8Frg==
X-Google-Smtp-Source: ABdhPJx8xbbL5om+QcGPAEAT3lJo4fDv/2nif/i01ZdnYHpFl6YANYMunB9IPePN6HRZD/WUU4luVE20BYE6hg38u5A=
X-Received: by 2002:a25:c011:: with SMTP id c17mr14015458ybf.291.1631896908105;
 Fri, 17 Sep 2021 09:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1631888517.git.pabeni@redhat.com> <aa710c161dda06ce999e760fed7dcbe66497b28f.1631888517.git.pabeni@redhat.com>
In-Reply-To: <aa710c161dda06ce999e760fed7dcbe66497b28f.1631888517.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Sep 2021 09:41:36 -0700
Message-ID: <CANn89i+e7xVLia3epGLpSR70kxuTMyV=VtKGRp3g0m56Ee30gQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] Partially revert "tcp: factor out tcp_build_frag()"
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Ayush Sawal <ayush.sawal@chelsio.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 17, 2021 at 8:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> This is a partial revert for commit b796d04bd014 ("tcp:
> factor out tcp_build_frag()").
>
> MPTCP was the only user of the tcp_build_frag helper, and after
> the previous patch MPTCP does not use the mentioned helper anymore.
> Let's avoid exposing TCP internals.
>
> The revert is partial, as tcp_remove_empty_skb(), exposed
> by the same commit is still required.
>

I would simply remove the extern in include, and make this nice helper static ?

This would avoid code churn, and keep a clean code.

Thanks !
