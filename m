Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184DDAD59
	for <mptcp@lists.linux.dev>; Tue,  7 Mar 2023 16:28:27 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id e13so12705263wro.10
        for <mptcp@lists.linux.dev>; Tue, 07 Mar 2023 08:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678206505;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oiix92S2TXE+PWViTA2DXkcV3phfzlyeFOXAidurpT8=;
        b=17V5uqPUXwZDXI5slz5/6u1qksSxbHcYFXZ6srXXn20V/DudUaf8akgC+E0KdPXtaJ
         dG+h382v88mkVZwz0YWztIS21BPVBlBdxpI+hWaWIsEm5GYT+blVdsgQ8U1DHEPzz0xg
         185czgPRNSOQakA3vD3dOoK1Xl3/zTHy6dYrNbgGOwDmZwzdqR2m+Gfn51s4WES4rVBP
         V+qmL39Npbn/837okkyIFCdQ4xHOoBW+cCz7g0q9CQzI2E84XpWTFeuI5UeT8HtFDIUd
         xGeZQwfNQFQQaAOW9262zqs9rjU5Bi3PI82rqM/03CyuXoQml/573KW5CtjxHK8H5pPL
         lBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206505;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oiix92S2TXE+PWViTA2DXkcV3phfzlyeFOXAidurpT8=;
        b=i+2Wz/OPIZfSgi1gPICI/a9QXgR+dfaulBAQ1sYD6dFv0hk+wT4h+xfpI0IgexQOUU
         kCgLf4NgCS/uT8CzqJYIZeCulenY7TvM87uPK/g0YFV3L+6y3JuWtMa9EnRk8Y/5zn/p
         Ju0kmbcu/8u4hHXQv4zNW7+sIEBVG9+3PdSu1J9Q/dzun3HQEmROn9qyGpPN9SPtTm7t
         VLv4fqrkNmSILfdSnR8TlFtBu/4M70MyiuRdHQonAJxmh0AELu7Llv/4GrupF7jgN9Lu
         SvV/bsIPcTTfh6/reuWPPneXTPgpdb8VATsRe0Xa1wH207pB1yIUHvNEElq0VAm2m5Km
         higw==
X-Gm-Message-State: AO0yUKVsEa3sBm++7WFWOegt5SLTBnuiCwsCm8s+loMeZ0n8KqIVYP3H
	1/w0X9ZlNZVA2YkHOSRAuw62s9ZNPlR/7GYYx3a3xw==
X-Google-Smtp-Source: AK7set8SQy7dwJzdJXFicpWHMWIxQ9vx9acP6JyFBb40tEMOul9FR/zPpSbVOdXyGCfNWzsW8PdRRg==
X-Received: by 2002:a5d:56c9:0:b0:2c7:6ce2:bb37 with SMTP id m9-20020a5d56c9000000b002c76ce2bb37mr9640492wrw.29.1678206505233;
        Tue, 07 Mar 2023 08:28:25 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d66c8000000b002c573a6216fsm12910996wrw.37.2023.03.07.08.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:28:25 -0800 (PST)
Message-ID: <e1714da4-4b60-f748-2611-bb0149d5104b@tessares.net>
Date: Tue, 7 Mar 2023 17:28:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next 0/2] mptcp: a couple of cleanups
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1678122760.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1678122760.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/03/2023 19:30, Paolo Abeni wrote:
> After the recent fixes we have both a good changes and some
> needs to simplify subflow_syn_recv_sock().
> 
> A couple of patches in that direction, also addressing a long
> standing feature issue.

Thank you for these patches!

I just have one question about the first patch but for the rest, it
looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
