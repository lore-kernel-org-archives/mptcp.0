Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAF5CA3
	for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 18:11:47 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id f205so565449yba.2
        for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oJJKHdCph79ekx0FQxWf6mcRM8elTZFVKG09Lqyve3E=;
        b=C0MZXSvfMEhfrc8pY4wdQo3q+9b5ow+Y5sgnWT2537ow1VUZSdgUsuRHscjf8bRj5c
         Ck8HrtlisALDolXOOV0YznDfnRZmO/IomABTdm3CAwQkE1SwKQEM8XtXBiQGUOIYEx5O
         RmHfnwsnjXOOVLKbTbfdZKoXVmBcbAxRG/ib+7vjSqidgzwkWoumy+prYC2u/MBbyV9q
         e2FNcOahwWfkDuP21DnQGLA/T/XxSDTrjsrPAyzc9tEalsvbEMmblKzhcAdJ/a0J30RH
         F4bT7fOa+sr9CCrKPpmiLXEaAg6KFkPKodoNX13Kx4msAJC933hB62qRpW4F6CRyRqXV
         NBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJJKHdCph79ekx0FQxWf6mcRM8elTZFVKG09Lqyve3E=;
        b=q/dOQjiz/aoAgcFl7/RwSK3mH3umWIJlr2BiMK7eAkI9g6sJZSEDy/TR3SdmQGYhry
         Vu9W5Yo15sdtX/tovV8+5PUWvY4BXZieuRll8KKRG33AJcI+rvYSIohFhIZ4SKGmOh3d
         TyBZzlZwjWm9kOw+BTmVIX95pQ+CyAZXNOW8OPAl64nVzK/b+kCRpWM3mM0V6S+WLt1I
         /ThG6KF+ZtiqKY3Edm2i5Sxzbv0MldJocohTtXjEPmx6eBIzSG+dY0gIxnSAwUIZWb0I
         ax6+oIRhcA3LNko1G1u5tQbEoiUnVN0csGIIjjoWWO370uSylCxh/A4utdNhfcjhsWjU
         f2RA==
X-Gm-Message-State: ACrzQf1NxkoxO2u2jvAu5cuaUW02ZTj7oErRaRRtqRVyn8rV2216vNpk
	Gicy7tD1REVhaftG7KoQnx3QSH4jFFK0UFE8RrlC9w==
X-Google-Smtp-Source: AMsMyM5qgEJXaKS7rT2ocfwhE7lTfIa8CcgthDfVlcgeYrrOVTV01h431iJ1dkXeEzgSNvEx5e9gFVyHw/93fdk1SYI=
X-Received: by 2002:a25:e207:0:b0:6ca:268b:10c3 with SMTP id
 h7-20020a25e207000000b006ca268b10c3mr4536388ybe.407.1666289505845; Thu, 20
 Oct 2022 11:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1666287924.git.pabeni@redhat.com> <dc549a4d5c1d2031c64794c8e12bed55afb85c3e.1666287924.git.pabeni@redhat.com>
In-Reply-To: <dc549a4d5c1d2031c64794c8e12bed55afb85c3e.1666287924.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Oct 2022 11:11:34 -0700
Message-ID: <CANn89iL4z2m5MAxVrd_tNfn9OcmgX5yGm3XyxoJrhEBu99YV6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: introduce and use custom sockopt
 socket flag
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 20, 2022 at 10:49 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> We will soon introduce custom setsockopt for UDP sockets, too.
> Instead of doing even more complex arbitrary checks inside
> sock_use_custom_sol_socket(), add a new socket flag and set it
> for the relevant socket types (currently only MPTCP).
>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
