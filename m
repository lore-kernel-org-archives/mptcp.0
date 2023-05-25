Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5AE3D7C
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 15:18:03 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so7790265e9.2
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685027881; x=1687619881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoCUOxQmlfWTY7fTXhFoKN/jnZwO+iZVCFSqOMMo3A8=;
        b=eCi+9V2/RUoFUwGsaLTF6WgX5OmZ84x9bzlIf+ejFBccSbZW2LerUKyZNB4ILf+HYj
         eDavlLXRinQuGfxxPodGhJ0IlagzBpdrcn3cJZO7Vil8bxLtDLGibvyh0nWn3L9YMsbA
         mP0e4OyKC/Nt+s4uAKJAbjITlcl6KvFNJxgtvnvSLhLJxMPGvZ4E3vCL8sW6MsCqUQLs
         LSRtxeGzdj/vqNR97gCTe+1u9LYIv4k87PQVHUvC3KPea3GWo+K3bi6bZaGUFZ0+uWep
         skDqCEPw+AHG1e1AkGRQuHNJU6lLvvXjaSh8jwQUINj5CUAj/CZi8vfQ9WFi1TfkZjZb
         Y+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685027881; x=1687619881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoCUOxQmlfWTY7fTXhFoKN/jnZwO+iZVCFSqOMMo3A8=;
        b=JUbOpxhBR5SDkHWc79qo1OHz1WDSEEHlG4zSLlQgBotYt9NN5GKCeDvti8I1Cde9Un
         QS4arpYchgEACRw7hj3bWYk114op3lT2U7Q88778U3nIKnmm+H+aK4mwKW17EENoH+fC
         Y/qa97HnELcXFLsx2s3xtOth69P0cvfC8VRIOaC530z0ecfWM7xmpDdi2L73EiRc27CM
         ZuWDYshOJYCtWP0J1pOcOtoMLJal/vC/ibQzorWzIC6RG2Sa7NloDHetJ65x3el9iQJX
         NO3ZE8KtqIsurlqhb7FcEBGXBmsztgqm+OjZ5FXpWRvZHsDLO9IOJaTlW/zdgdX8rDVk
         84jA==
X-Gm-Message-State: AC+VfDxh8nBoePDirpGqV2R0ov/nqDvax3NkQsQFOyDf/80fie2a1Oba
	prBK1aKJYRWTGUTwRKN3B4Y1t/s2wLJ5cvIdu+Y=
X-Google-Smtp-Source: ACHHUZ6ZuKuBL+AcSJok+SvqY+C6KEvHB7sw+Vpr3NGBTYp7b/zrXIwiGvEQG3ccgfShk68PawXmjg==
X-Received: by 2002:adf:fc4f:0:b0:309:38af:d300 with SMTP id e15-20020adffc4f000000b0030938afd300mr2566516wrs.33.1685027881183;
        Thu, 25 May 2023 08:18:01 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id t2-20020a0560001a4200b003062ad45243sm2118637wry.14.2023.05.25.08.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 08:18:00 -0700 (PDT)
Message-ID: <b6d9968f-9406-cdca-2867-c093f393f08a@tessares.net>
Date: Thu, 25 May 2023 17:18:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 mptcp-next 0/6] mptcp: add some more diag info
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684997011.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1684997011.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/05/2023 09:17, Paolo Abeni wrote:
> Sorry for the high-freq spamming. I really want to close this topic
> and move forward.
> 
> Introduces unique id for accurate subflow stats tracking and
> aggregate mptcp counters, plus some minimal self-tests.
> 
> The tests themself do not take in account support for running on
> older kernel.
> 
> This is on top of "mptcp: a bunch of data race fixes".
> 
> There should be non trivial conflicts with:
> 
> "mptcp: use get_retrans wrapper".
> 
> v5 -> v6:
>  - fix another compiler warning
> 
> v4 -> v5:
>  - changed again binary layout for MPTCP_FULL_INFO structs (Matttbe)
>  - fixed 32bit build issue
>  - reordered the patches, less controversial first

Thank you for the new version! It looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I'm sorry I was not confident about the previous version and I was not
feeling good asking you to change it!
I do like the last version, I hope you too :)

I have a few questions in the individual patches if you don't mind but
that should not be blocking the series. I can even do the modifications
when applying the patches if that's OK for you!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
