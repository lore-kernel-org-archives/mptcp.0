Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877070
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 13:14:48 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id x14so3417048edr.12
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMPC9hkJv8/6o3bkC2y8FMCyLzLmWPgT2vp66/9ib28=;
        b=VE0Jja2I93kI+GfHZEvwnhdItLhDadUu3NPSiI8VIGR9BwUN+2CGVN3qVNypG0/lJK
         OAfAeMxXgQemDxYzbhxAmXmWxnoMLdJf/piGXC/28Mqs15pjtCQnIu2Oil1tSQZcWCNl
         vPrZoi7sHO0NrajrEgcJcvpCUtQWrzvSPeOFyDTy+tOCx5AxqmZL1AtmU6koUxR3/eGf
         dJR8z8dynzht4ziNZpZG0eB0umPMzhH5rW+Ye00b6g+H1v02bYICdqDmvN2E/4T8bzEE
         qb6Ju6FNy2aTLuhOePQ03VWzKalZEKvg9mGmvOWJdwMdv7ZJZmlJCk7Ru6hI1LLv0leK
         Uzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMPC9hkJv8/6o3bkC2y8FMCyLzLmWPgT2vp66/9ib28=;
        b=Wwf7qJD6VPrs4yrVY7V/EjW42EdeyDiPTsrZPiBPqA3aAvWg91lC9oI/plfmVAwfpX
         V1wJGPHMUWxQYei7RHlituqho7K21XQwcc7nFTuPn9MHghgDKiT0aoH2ubSDm+t7QkgU
         mvd1aaFb4cg4+8b/WNIvMhd8kEkPeWQspLh+gji3C+d5v6Dc0sS04PuXvd34ZfcLQyYD
         EsqfqbIiqtc46us1BGPciEAjOJClLZmzr8+O8YGseYAPxciAFoiCbNPqBxiW9jjsukOS
         GPeI46dNwtQOa2aBUra4ET2WD0yDvh6TUnTYXjn4YdNWu3CgqYqOnpaV9ZIjipFhkPX9
         twHA==
X-Gm-Message-State: AOAM531pXahp8v6kM1KpPqolD8fwOkKbXhBnuy3KbJNkAC+Usmwa2EUX
	tTkGfR7tsDguLBtF50CGRSD9hBveIoUJokpUQFs=
X-Google-Smtp-Source: ABdhPJyk0EOcDVN47s4rr5nVk0KiuGXITDspUaJO8ezcSu0ALBMZ6r+IHsuVa8U4zzimP3hP1wZgGQ==
X-Received: by 2002:aa7:dd84:: with SMTP id g4mr31837749edv.134.1628082887240;
        Wed, 04 Aug 2021 06:14:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.61.dyn.edpnet.net. [94.105.102.61])
        by smtp.gmail.com with ESMTPSA id k21sm673954ejj.55.2021.08.04.06.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 06:14:46 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20210804072556.664287-1-matthieu.baerts@tessares.net>
 <7655f9a1-df47-cfc8-3281-cd5fbd1e3c1b@tessares.net>
 <CA+WQbws-UiT5-ZFKBPiXBAATJGt1G2AmtU=F0=cpJQm=pkWUMQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add fullmesh
 testcases"
Message-ID: <64ab20bd-c5cc-b149-5996-3afbd0498c2b@tessares.net>
Date: Wed, 4 Aug 2021 15:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbws-UiT5-ZFKBPiXBAATJGt1G2AmtU=F0=cpJQm=pkWUMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 04/08/2021 13:44, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for fixing this.
> 
> Acked-and-tested-by: Geliang Tang <geliangtang@xiaomi.com>

Thank you for the review!

- 3f64b5497607: "squashed" in "selftests: mptcp: add fullmesh testcases"
- 2b21fc8ab588: "Signed-off-by" + "Co-developed-by"
- f5fe84d6868b: tg:msg: remove mention of addr ID >10
- Results: 90dec655986b..e33e07851d84

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210804T131406
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210804T131406

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
