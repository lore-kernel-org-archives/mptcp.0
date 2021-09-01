Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68E3FC1
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 16:09:55 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id j13so4507671edv.13
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GuGPMy9wyhIVf9/M3dZMDi6jnPBAi1kugfgCYTmCxqg=;
        b=CM78f/PTgP4ZKbukFuCjEabvuwnBjQo3GpzWFfkOCWh3w238Bon2mVby4eBHC/bF/I
         PrU1fDWukyKuvHP0JSXSRvKvg+JQdfjyJSxKfVebJcyUHZidtBlKvNn6sycI8TgmSHqO
         mGCz/MNB5krwHNWiw0Gruaxc2AOLnWFk9VhNOgf8RfHbEiHY4URNq4GNwZpECpGC3Rk6
         ZpunKGPbGhyJFy7x3G2Z2K1XxqPGyppOTG8bGSZ4hbx6zRQPppBUtK78Y7v6Nk72Knpn
         mos5W/0rprb9tW1cIbo3udFzXi+A+/5ooohB25AfN7fx0JI7EQfLRXchroKTIAdexKJA
         9n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GuGPMy9wyhIVf9/M3dZMDi6jnPBAi1kugfgCYTmCxqg=;
        b=Gg3wKEzSGfWaEM8/wurfEM2lAy2FUW4iGmAju7msu49MLMdX9g4KcCoYAtM8JnMLKR
         MeKx05oqn010fxjBKP68Vs6HBGOyfKu1l8EbZCt9uXdKweem1PX9RYNnzXj21UTOdllO
         wkcYw7vZ14axMt/y9UHq6WduDu1NoPncAX+MSXEm52Z/YYu0zXVTJKMuEsrP5+vvqbrs
         A4qmsIfjEySyMIWjzMGdMTdJsJBp8Z6xbZKR4DBQHGexXF/hXMhp2skrOJrYW32ar8Vd
         lCwIwFxwOSigtx/2DurjzCqDekQY5lVkmNqEEUUUSGe4kfQDYfO2RGFP7xMSHCwmeSov
         j2CA==
X-Gm-Message-State: AOAM530ZQUJ73QyLLigEEkdBV1ImkxjPQ0TD4W3c+YwM7glU/hHqOL5l
	+FwzIxbXTuX+kQHOuJGw7pjJdAOXTwXWPw==
X-Google-Smtp-Source: ABdhPJxKnOr7FugQb1UAr/dFaVLX7+A8XwY/3oSf5fgZqFfHxFEaEs8IGHYSuM+A0vSqBtHjEY50+w==
X-Received: by 2002:aa7:d710:: with SMTP id t16mr392766edq.42.1630512594199;
        Wed, 01 Sep 2021 09:09:54 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id n10sm77706ejk.86.2021.09.01.09.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 09:09:53 -0700 (PDT)
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau
 <mathew.j.martineau@linux.intel.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <20210831171926.80920-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH net v2 0/2] mptcp: Prevent tcp_push() crash and selftest
 temp file buildup
Message-ID: <b9fa6f74-e0b6-0f61-fc5a-954137db1314@tessares.net>
Date: Wed, 1 Sep 2021 18:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210831171926.80920-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi David, Jakub,

On 31/08/2021 19:19, Mat Martineau wrote:
> These are two fixes for the net tree, addressing separate issues.
> 
> Patch 1 addresses a divide-by-zero crash seen in syzkaller and also
> reported by a user on the netdev list. This changes MPTCP code so
> tcp_push() cannot be called with an invalid (0) mss_now value.
> 
> Patch 2 fixes a selftest temp file cleanup issue that consumes excessive
> disk space when running repeated tests.
> 
> 
> v2: Make suggested changes to lockdep check and indentation in patch 1

We recently noticed this series has been marked as "Not Applicable" on
Patchwork.

It looks like we can apply these patches:

  $ git checkout netdev-net/master # 780aa1209f88
  $ git-pw series apply 539963
  Applying: mptcp: fix possible divide by zero
  Using index info to reconstruct a base tree...
  M       net/mptcp/protocol.c

  Falling back to patching base and 3-way merge...
  Auto-merging net/mptcp/protocol.c

  Applying: selftests: mptcp: clean tmp files in simult_flows

Git auto-resolves conflicts. Is it why it is considered as "Not
Applicable" or did we miss something else?

Do we just need to resend these patches after a rebase?

Thank you for maintaining net!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
