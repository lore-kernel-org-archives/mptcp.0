Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C628E1
	for <mptcp@lists.linux.dev>; Mon, 27 Feb 2023 21:17:57 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id cy6so31446608edb.5
        for <mptcp@lists.linux.dev>; Mon, 27 Feb 2023 13:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUA73YG4yXPbURTwSoy9K63ZTwALevNoZURjeZoeoeo=;
        b=Zzb/TbfR9EivTSHt6zOoGvySn8k0Yojn42Kuzx2cHyaJ3cdsd6tEz7y6/slfxPs21E
         6B+0R6Tcqew16clzpe2lqH/lkK+Lk5uBXsnCeRjgHsURVpYX18AuNrdBJyxn//3UpvaJ
         hkSCMwNmrmJ3usofEFf+tThdqa+WAf7FP/UZjqE0bhxZ8TVDQEMaz/PowUoVYsOwf8t5
         5qSsBJ6kgNCxZ1uJR+8eM55aoFJHliRPCRiFZW+5GRjh/0fRbz5vX30I69wvxO+MfZsp
         ugEyRWxmSQOe+7tPX4kQLOmCRg/bTdjwkc3SAS3XdDXudc24F0cLq8Z4ESOyUae37CxX
         xhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUA73YG4yXPbURTwSoy9K63ZTwALevNoZURjeZoeoeo=;
        b=O08+YXVMq8Alln0NexU/c23fqWd1oqmyFXeswdyjVAdQGDqdP7QppfJN7wEZni3f6M
         Ogo4VOk9+T0vYB02dUgI0H59Y5oZC57Sn5La4bmmQq45dCmL+R8TMY4OqVVNr1iT5bU/
         IrjQ4Bv9DXngVdCiuA03yVe7i/lUGBjqFZBlZvUbXhE0oB6I8KvI+50BeYKElgHlT42g
         N1+gYD4SJzSVZeMCv8UUKB6q/RtsiwbjsUf+IVj/AR4inIlqn/lKiB+rB1Zflqy6Uip+
         cIZ/x7oa0sifjlyaiqq+abV8Lep9NJ5s8roWtaHXUVsC+62KBM2WEQZwmgnO74EC5Rm7
         YfEQ==
X-Gm-Message-State: AO0yUKUSgb4OHJmaaSjPrUK4bwub10fxZHc0iI48WS73DIOPXKpYGklV
	eg6P2qz8MEdP5amwHXS14NjFWQ==
X-Google-Smtp-Source: AK7set90pISaDuD++i/ii3u7bet/1KRenn4aJbLjymZWen29YC57AYkdFaoMHKbHhZBxksOP5g920Q==
X-Received: by 2002:aa7:cb0a:0:b0:4af:649d:da4e with SMTP id s10-20020aa7cb0a000000b004af649dda4emr1113555edt.20.1677532675833;
        Mon, 27 Feb 2023 13:17:55 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9d8a:f91f:ec0e:ec0b? ([2a02:578:8593:1200:9d8a:f91f:ec0e:ec0b])
        by smtp.gmail.com with ESMTPSA id h11-20020a1709063c0b00b008e82cb55195sm3621460ejg.203.2023.02.27.13.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 13:17:55 -0800 (PST)
Message-ID: <bca9a072-c211-fa93-9b78-8bae610074b0@tessares.net>
Date: Mon, 27 Feb 2023 22:17:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-net] mptcp: fix lockdep false positive in
 mptcp_pm_nl_create_listen_socket()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Christoph,

On 24/02/2023 13:01, Paolo Abeni wrote:
> Christoph reports a lockdep splat in the mptcp_subflow_create_socket()
> error path, when such function is invoked by
> mptcp_pm_nl_create_listen_socket().
> 
> Such code path acquires two separates, nested socket lock, with the
> internal lock operation lacking the "nested" annotation. Adding that
> in sock_release() for mptcp's sake only could be confusing.
> 
> Instead just add a new lockclass to the in-kernel msk socket,
> re-initializing the lockdep infra after the socket creation.
> 
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Fixes: ad2171009d96 ("mptcp: fix locking for in-kernel listener creation")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and for having tested it!

I just applied this patch in our tree (fixes for -net) with Christoph's
Tested-by tag and without the issues reported by checkpatch.pl (I hope
that's OK).

New patches for t/upstream-net and t/upstream:
- 6f002c31c364: mptcp: fix lockdep false positive in
mptcp_pm_nl_create_listen_socket()
- Results: 48ec0932754d..8d03cb1e10a4 (export-net)
- Results: 3bf7fef56098..f84e6823c4bb (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230227T211242
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230227T211242

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
