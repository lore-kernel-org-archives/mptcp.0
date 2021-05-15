Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EACC70
	for <mptcp@lists.linux.dev>; Sat, 15 May 2021 10:54:03 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id t3so1365369edc.7
        for <mptcp@lists.linux.dev>; Sat, 15 May 2021 03:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7taAHyuW297Slk8k+/c/36+uwY/+rCH7k33SZZrg5sE=;
        b=GSp2Y2nY1oCZe+7+QaoG1K6C2CH+Fb4nr6I+lRIdvUcfCg7ivQmzBC+TklfZMKkQiK
         PX00j1iNet3z9VUZs4yKUPWHqp7poWqR9wlAy0gd3cK3DagstEJELwpCrn+ZmLDZphaZ
         wbCUsdn4Vc+ZcNS+f9aO+FJ+2qHMc7CYmk+pXv3YN7HacEFdEr1PG6bmLLW5KmCxMxbi
         orJIK0ZQaCDMORRLsn7sVPDMLd5ZU5Don9N2RtF0WVCAO4ndG8mLGsEvt3cYuRq51pY2
         KfYAyDfcRyM7bCHdxxEtLbmta80k3/opEW32ln374QxV0yRyBLailzLvOq3jzdmwQq3e
         /iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7taAHyuW297Slk8k+/c/36+uwY/+rCH7k33SZZrg5sE=;
        b=YEIHcCA/WU20daF4xcR1Efm42YEw/O3nHinORZf3DLnxPIClkMoNlJbAyE65ywpwCP
         a7iL42WvUexu9IfKvsCdiatndH/CWKbmiakro4a+Uua+jXqkMnXb/XN5r/NwMpFCCr7t
         TfmZZ1IdJfAcSrzo6PtmfBk5TX3dvPnnOv7FpgSHZhwMaugGK299/YMEwYdpLIuIwaT2
         +2VdVBQmcR3yfXawqb0lMANVWX1pUCTSzDNh/ZsrePCZT+cM2rCJyndhF7qs3cgREfkV
         Y4Nuh+PS5vR0duqkNMU2JvSYfF2JDRL1TiIGRzoOl3sMMeGHv5fJUV0IH/QTtE0IilML
         M0cA==
X-Gm-Message-State: AOAM531bWdD7aKEHsYJsVjcrMqz2+QA3/K5YqkA61PK08Q5PWNQgFmLX
	V4Q0sLkoeRrLgnnnf3M3AmSVZQMVzwr+0BCbeVE=
X-Google-Smtp-Source: ABdhPJx+0+53Tjdl0Vh2WjKveI7tVODzBZrn2GtdH+2lZKDPWMQDYlBn14q443QN0tQXNlN4wbG+3A==
X-Received: by 2002:a05:6402:354b:: with SMTP id f11mr61977365edd.139.1621076042360;
        Sat, 15 May 2021 03:54:02 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2c34:73da:31fa:e084])
        by smtp.gmail.com with ESMTPSA id e11sm6343717edq.76.2021.05.15.03.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 03:54:01 -0700 (PDT)
Subject: Re: [PATCH v3 mptcp-next 0/7] add cmsg support to receive path
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
References: <20210514094857.10663-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <804512c8-0903-deba-d236-2bba90f4201e@tessares.net>
Date: Sat, 15 May 2021 12:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210514094857.10663-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian, Mat, Paolo,

On 14/05/2021 11:48, Florian Westphal wrote:
> Changes since v3:
>  - drop patch 1 (busypoll support), SO_BUSYPOLL will have no effect.
>  effect.
>  - adjust patch 5 accordingly.
> 
> Changes since v2:
>  - fix indendation of a if line in patch 1 (Mat)
>  - avoid useless conditional in patch 5 (Mat)
> 
> This adds setsockopt support for busypoll + and the various
> SO_TIMESTAMP variants.
> 
> To reduce copy&paste, a few helper functions get exported for
> mptcp sake.
> 
> Last patch extends the existing setsockopt test case to also
> cover/enable SO_TIMESTAMP.

Thank you for the patches and reviews:

Now in our tree:

- 480085ab2b4f: sock: expose so_timestamp options for mptcp
- 1dec92e1a886: sock: expose so_timestamping options for mptcp
- 1939fa553ab4: mptcp: sockopt: propagate timestamp request to subflows
- b31cc28dde50: mptcp: setsockopt: handle SOL_SOCKET in one place only
- e353d974b686: tcp: export timestamp helpers for mptcp
- b1555bde4528: mptcp: receive path cmsg support
- 7a134f51c2c2: selftests: mptcp_connect: add SO_TIMESTAMPNS cmsg support
- Results: 36f31371c969..36a7db06660a

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210515T105252
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210515T105252

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
