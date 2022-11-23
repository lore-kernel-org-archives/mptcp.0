Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACD7E
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 15:46:39 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id z18so25382565edb.9
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fz+0B+IV8RQyIaB/pG+qKtOQK7hir8xgob6gjhhdjlQ=;
        b=IUo+wN2WDKQosZbUiwiVe6Prm1yTcqI/8M0HvzdtOE8jWIZZUDSRw8HgSySlpy6TGC
         5+yrGmFIWfDP8cxYC0Jne4iD6eiSAuuPDBvImKpn6oAsBYc+boeNp7Ga1mQzHPrrRDQ1
         CoQQn96EoGdR1hA2R8Z5mES4QP+lVxWkvh+JjAi5IBH78LRngZxuD5VEioVexeGaxvQ2
         RiL7sAntJC1aZCMskbq7hkZZ1ZYac3vWh6lzaCGmaYGiVj8AM6e7jBl/QscE9kwI0+Am
         QsLOLxMfsQlA4UiD1AVBCn4rW5klI2Ufh2F1VBP8y3rZuPp9/Z0q0Ltq3xdQK0KckUH/
         eGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fz+0B+IV8RQyIaB/pG+qKtOQK7hir8xgob6gjhhdjlQ=;
        b=r40/FJrsWlUaMIZF4k9eo2QEr/Tf+J15rgux7bNiOy/44gmmRnVOX4IQG+2XMOt6Vo
         G3nEEiGC7gALytDZ3K7FXrz+t0iy0SmP4xz19qgPXCEEfPb7l+NPpLpzyA2aNbO5ZVq0
         O3krsP1xhPpicWAanV6liUJMmM8CzEXhnh8G1ji25v5pLC9isAlMy29v28tISpWn8KOQ
         W5UpAPE0sT/K9f4dWJObprUiOQLOVevkmJR+GNHg7ZbeJ+8BsmXZ5IsGJtStdYXX4ESA
         2gjMdCbTk/REGS9YHo/CcgbbVOFTEt7jwFv+C7zvilUDQlybij5Dw6BzY/ONgQNG8Kzg
         Sfyg==
X-Gm-Message-State: ANoB5pkjCEAriGWhMWD4bXuX1aoSXLnwWbNrsdxTUb7BEakxpTVQwDnC
	dzUAIEWL9JIY4KgA4AoIZ4ODeSQYAVgwa+v8
X-Google-Smtp-Source: AA0mqf4l3fkFY3DFchzthzni9i5ImTsI0CyGijfN7012mTrknBcgUhqyCiavl8gsLWpuX7UTJmcNkA==
X-Received: by 2002:a05:6402:1ca8:b0:469:980c:5a2e with SMTP id cz8-20020a0564021ca800b00469980c5a2emr14189876edb.197.1669218397499;
        Wed, 23 Nov 2022 07:46:37 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:aeed:e7e9:2ae2:91e2? ([2a02:578:8593:1200:aeed:e7e9:2ae2:91e2])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b007a4e02e32ffsm7331012ejb.60.2022.11.23.07.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:46:37 -0800 (PST)
Message-ID: <0bae439b-31cf-e358-5038-e46791a1c3bc@tessares.net>
Date: Wed, 23 Nov 2022 16:46:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net] mptcp: fix sleep in atomic at close time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Jiang Biao <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
References: <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
 <4f78725c-7e72-63fe-854a-c6b48f09b932@tessares.net>
 <4f616c8658b67cbbc4557c9521efad2a149500d0.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4f616c8658b67cbbc4557c9521efad2a149500d0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2022 16:42, Paolo Abeni wrote:
> On Wed, 2022-11-23 at 16:36 +0100, Matthieu Baerts wrote:
>>> Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> Closes: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> Please don't close me, it took me some times to find how to re-open
>> myself...
> 
> What can I say? at I list did not accidently close the b&b ;)

:-P

>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/316
>>
>> For the rest, it looks good to me!
>>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> feel free to add even your tested-by tag, as you already did that :)
> and we can produce same monster tag like 'reported-reviewed-and-tested-
> by: ...' ;)

I guess it is better to avoid them :)
We don't need my Tested-by but I will keep the Reported-by just to
understand to which "Mat" you are talking about at the beginning ;)

> Or do you prefer I'll repost?

No, thank you, I can of course do the modifications when applying the patch!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
