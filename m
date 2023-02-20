Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661B46AF
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 15:01:30 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id h32so6002676eda.2
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7M8tx4XkT0iQH66Skl8NVm6AqOqki+S5S5PJS6Us814=;
        b=Uj24ofzYIVLCkwOohsMmuzic04PjTTyEnvyTEiHtqY9rT45mO7NwlTXe7admIWjFYM
         6VHuVEeYXokwcNyh6IPJId5MLxqdM8MfAirh2fNfRgEkMWpdaVi78PnvH1IO5fTGyi7I
         CIK0M3PogJWFMGR36Hpdk56A8v8Wsl9nwYfL4aCOAh91BmiJQsGhyixHl/A/M83nEfrH
         9BAkhG/dZAckwjNe6gSpjIiZaN2+XBbaibA6RsaEkAiMkJy6YFdXtR7GxV2PMmnrVvGp
         cuQ2x4/Thpn5z0OwLdTRtWOVWlUeX8011u3gQa3HSRajiMxxXAYOBYE/4/vARFZsuXYM
         m2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7M8tx4XkT0iQH66Skl8NVm6AqOqki+S5S5PJS6Us814=;
        b=sKjPqZBn0RSWnGSqBT90iD5pOkaTxvKuu3ndUovSWwsOdkZvmr0qcWUHimbc79W7UJ
         VKLBhSvZcnAlwpdx690h3+BKnRy7aCHPWlJzQHAmjzlb0Vkme6fsAmKp17oObmEYXr3e
         bgfUXwOfrTa7VYqy73ONGBCiBZe56T/vta/7eBsMO6oQNFt1HEAF2ZYW0kP/ikJj+Fw2
         fpe5jEbMOituXNjIvfzHY5DZ2CopIU107gnaf5o/T/eSNpjeIgHyYEHZlXAsIBPEQkxp
         ckyltggmHUUE5oiilZXrL7/G5dzPV6fgphERHm66H4AVnrhZpE64JxeORMcN9hTvlr1D
         XXJQ==
X-Gm-Message-State: AO0yUKV3lslJ8ijW8a2zAFYhjwlUn8zlHcgol9GTcXNX+uvkHo8tWqes
	/xjg7YaCJLSC79tZuEyA4ZjLog==
X-Google-Smtp-Source: AK7set8zTyczaRse1lUw0TPfI51Z01YuJv4ptDrPKrr2Ls7XDOEhRlMttESSG7MCTERtDmvXEtCm6A==
X-Received: by 2002:a17:906:265b:b0:8b1:3813:7b6 with SMTP id i27-20020a170906265b00b008b1381307b6mr8800087ejc.30.1676905288466;
        Mon, 20 Feb 2023 07:01:28 -0800 (PST)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id t18-20020a170906949200b008bfe95c46c3sm3202033ejx.220.2023.02.20.07.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 07:01:27 -0800 (PST)
Message-ID: <7a23540c-0c17-6a8a-7826-2cea1e7c2ebf@tessares.net>
Date: Mon, 20 Feb 2023 16:01:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next] Squash-to: mptcp: refactor passive socket
 initialization
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/02/2023 15:27, Paolo Abeni wrote:
> Since the squash-to commit, msk->first is set even for unaccepted
> sockets: mptcp_mp_fail_no_response() can take action and reset
> the subflow even when msk->first is still in the accept queue,
> after that incoming reset already closed such socket.
> 
> That in turn will end-up calling tcp_done() - via mptcp_subflow_reset()
> - on already closed sockets, which is illegal.

Should we not add a WARN_ON() there for our CI (and syzkaller) to catch
that earlier?

> Let's fix the issue explicitly checking the subflow socket status
> in mptcp_subflow_reset().

Thank you for the patch, it makes sense!


New patches for t/upstream:
- 7dd3244ceddc: Squash-to: mptcp: refactor passive socket initialization
- Results: 07db02c0176e..1e2b17c72708 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230220T145128


> Since is a squash-to patch this will likely lose the reported-by
> tag, but perhaps we can preserve the:
> Tested-by: Christoph Paasch <cpaasch@apple.com>

I added this on the refactor commit.

- 74e8c30799a7: tg:msg: add Christoph' Tested-by tag

> Also:
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/357
> but I think it's better to handle the issue workflow manually here

Indeed, I can close it manually.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
