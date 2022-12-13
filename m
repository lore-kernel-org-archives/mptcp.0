Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C95CBC
	for <mptcp@lists.linux.dev>; Tue, 13 Dec 2022 15:53:10 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id h10so16078718wrx.3
        for <mptcp@lists.linux.dev>; Tue, 13 Dec 2022 07:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXHAKkuUPNmajc/w3tltJtXy78gtRsK2DOHkSFZZn7Q=;
        b=IYW3tq2HdGpXdSfmNIl0k5BtLFD8dn47gpHI65VjbhelYOKqYXvj/Q0AZHOw1jHtpD
         XLuIZuq8mVL2oSML7DvFRohkf63R4nBihsmN3liguYbi/s+9ZclPqfe6otda4so1vKsC
         DEr4otO9SQYUEguQhmZ/lnRxnFvxKf7FjuinVJl/3IQUbnqN7pJSA1/eyWjGO1vbI1FN
         ENANboSoJwalvCxMSGeA6tM8iRTeXDDZs/wBI6zUZvuMQ48pz+UhOXPilwFN+ZAeVDAG
         HJUPFe1dep1pflJYu+MCBs4aNh6PGEw0fPI0vU/tL3SeW5KOH/nvSXoAXk3PkpTxtDUV
         BLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXHAKkuUPNmajc/w3tltJtXy78gtRsK2DOHkSFZZn7Q=;
        b=o8ehJwDUsC9pgpaOuZWwu1Cu5pVAK/g37JQ9xyJQYswrxv9sEQ+ynDogKMZCfAWSx9
         qynsJSEzhOFxGxXsxW2ZLoQNP0r58GtoSurw8lMxibTatbuKB929qpwFKqFhr9pgs+Tt
         scPHuKTy60BE48aVP6yyx0e6UdAGQJom7V5r86ekLtbmWeJ/UYjAl9rbUO01azoADT+b
         8hwBxkeLUfGac3qKZOqByFTyDy3/QcAdiDT3eRXjEec7rKjd/ZxzpyJws+1DAZw2epHH
         ZyIgNRDa+OhMr4Hnpvxt3wA5H8y4OiLxbRatpw3sGX+922syQmCl64Txd+pvFK8jZIJL
         ZaAA==
X-Gm-Message-State: ANoB5pmQbwB3oL56DkM0JupQhXdg+2EfhGbFQUV/WqrQC/CRGcJ6ZF0+
	59CwlXW1zmHeFXerP92gzUGgpdBUzPYbjpB9A/U=
X-Google-Smtp-Source: AA0mqf4gAVapSfVVbOAdjnaAR7nBangYMt6DEIe/g8giKaQFz8Eu8vkU5HiyDcDPcHWD3g2Ytz82vA==
X-Received: by 2002:adf:bb04:0:b0:242:144:90d0 with SMTP id r4-20020adfbb04000000b00242014490d0mr14179079wrg.57.1670946788447;
        Tue, 13 Dec 2022 07:53:08 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:766d:43c5:d004:76be? ([2a02:578:8593:1200:766d:43c5:d004:76be])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b00241f029e672sm81802wrp.107.2022.12.13.07.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:53:08 -0800 (PST)
Message-ID: <82b017e9-7d62-29b9-e2f6-8960973d067b@tessares.net>
Date: Tue, 13 Dec 2022 16:53:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [Weekly meetings] Change day/hour?
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Ossama Othman <ossama.othman@intel.com>,
 Davide Caratti <dcaratti@redhat.com>, Florian Westphal <fw@strlen.de>,
 Benjamin Hesmans <benjamin.hesmans@tessares.net>,
 Dmytro Shytyi <dmytro@shytyi.net>, Christoph Paasch <cpaasch@apple.com>,
 Geliang Tang <geliang.tang@suse.com>
References: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
In-Reply-To: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 08/12/2022 18:51, Matthieu Baerts wrote:
> Hello,
> 
> At the last meeting, we discussed the idea of re-scheduling the weekly
> meetings we have because some people might not be able to join or prefer
> another moment.
> 
> But because we were exceptionally only 3 today because of the feast of
> the Immaculate Conception, we didn't take any decision. Instead, we
> would then like to hear from people who want to participate to know what
> they think about eventually:
> 
> - Changing the day to Tuesday?
>   - It might be better to avoid Monday (morning) and Friday (evening).
>   - Wednesday was not OK for today's participants
> 
> - Changing the time to have it one hour later?
>   - It means 17:00 UTC (9am PST, 6pm CET, 1am CST)
>   - This is late for people in China but midnight is late anyway
>   - Maybe we can also schedule less frequent meetings at a different
> time (or on request), e.g. morning in Europe, afternoon in China?
>   - (the BPF weekly meetings are on Thursdays at 17:00 UTC)
> 
> What would be OK or not OK for you? Tuesday or Thursday, same time or
> one hour later?

Thanks to those who replied to this question already!

I suggest we take the decision about changing the day and/or time at our
meeting this Thursday.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
