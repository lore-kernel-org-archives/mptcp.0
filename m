Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A9186F
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 14:28:08 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5so3148116wmo.1
        for <mptcp@lists.linux.dev>; Fri, 04 Nov 2022 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IEK9p8Dpdgtcyzpq8YSLNP/wT2HHgay9mwfXtgMXJc=;
        b=F+2QzhyMOUb1HZkKUtkF0kjBW0lahXey2pCWFCN0U37hPz5dznD3c1RDWlZIZQ91OF
         Mvp7gHyNR9glR8ise/90E20urADHRX+EixqGYGPGzzbLJf8unFm1FG17E7bCTFJQ/HBl
         NDFKhjcgwcC4RHUFkiCXlYeP9NaQ+1bsTKnAQzQz/XhbHkW9rQ1gu8hdtJGkwDz1bfiB
         Ng9QPOEfXfyNUlMIOIBbqzOKM/ZQTTy1y6OOrteqnAQjFaCuJOIziPhuNCrHn5oWtC5s
         UbA+NawpA3rdeGxPuMaJ0qzmLP5xYTZmY+f42Tn7cm9V4qtJQcFTuY4h9dne970LRlF1
         o83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IEK9p8Dpdgtcyzpq8YSLNP/wT2HHgay9mwfXtgMXJc=;
        b=ZTxP815v7FjxpmQTfV69W2iOA+0TElQJ4nUbUiV0Cr+8A+/mFlzKTHFs8E9MD78vBc
         KfBkFSKfXfH0OY9MN40rh/v7BfX/0w3yrpjp6zHct3FlqGpPuQesxLnucawItegUA95Q
         8oSEeAqyfkNlvyn6Sohu77SekoPQyWnJuMEGeq/L77E9MXzz30bN+JAtpc/qDUqxRiyk
         mXoAmXJwsKOnIz3o2nb5EKYc9ctXjOOcZOuuo1Xwp67YG1dHUz/e8pphqslKE24ax5Zb
         x6+XkHuPzvPzu/OG/72PlJqhLJbpvwGgDQ0xc4JzKRbh1Hj29ikq+DlElv9rCetgdeVj
         oe/w==
X-Gm-Message-State: ACrzQf0iH3UDK/Vt9LCbIXhalZ6AD7oALd5omTP/2dU/ms9YU0oWQVO3
	pjzQmHd4N7nGzqoeRYVooZrvchjKqvo5Cg==
X-Google-Smtp-Source: AMsMyM4fEO+gCTiWJ9F8092XMTdAOUN0b3/bwV2EW89Z9F3rwunEGR2fj8pKX+tGoJz6YzwSz1Vorg==
X-Received: by 2002:a1c:2502:0:b0:3cf:6f44:3e4d with SMTP id l2-20020a1c2502000000b003cf6f443e4dmr19415336wml.177.1667572087069;
        Fri, 04 Nov 2022 07:28:07 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b003c21ba7d7d6sm3201042wms.44.2022.11.04.07.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:28:06 -0700 (PDT)
Message-ID: <18645841-3b43-5520-3dd6-d8bbd5485576@tessares.net>
Date: Fri, 4 Nov 2022 15:28:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net v3] mptcp: use entry->lsk directly
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <20221104115354.3413-1-geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20221104115354.3413-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 04/11/2022 12:53, Geliang Tang wrote:
> entry->lsk should be used as the PM listening socket directly in
> mptcp_pm_nl_create_listen_socket(), not the initial subflow socket.
> 
> This patch fixes this, use entry->lsk directly instead of ssock.

I'm sorry but the commit message is still unclear to me: it doesn't
explain why "entry->lsk" should be used directly instead of ssock. Do
you mind adding this justification?

(The "reason" why a commit is needed is for me the most important info
to add in the commit message because it is not always obvious: here I
can clearly and quickly see you are using 'entry->lsk' directly when
looking at the diff but I cannot extract the "reason" that easily).

Please also note the public CI reported a possible recursive locking
issue with this patch when creating a listening socket on a different
port (single address with port):

- KVM Validation: debug:
  - Critical: 1 Call Trace(s) ❌:
  - Task: https://cirrus-ci.com/task/6164964783161344
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/6164964783161344/summary/summary.txt

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
