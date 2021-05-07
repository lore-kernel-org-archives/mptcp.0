Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54C70
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 15:41:48 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id di13so10761931edb.2
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EByMNjCf4Q/7PjCQclIPBquLApcbaIlxxEFyo4N3wFM=;
        b=K7wPs2dLyqfPmUhht2LiIlC0iQEtWUJOQxk6ncb1BHJhXxB43evD6Xo3wLakaTUUfI
         JYidofQTSd7fZ9ktos3M4KnMlRuUkzmBbmbtDLcqivjeKBEi74NXA2hj/5193NFguT55
         dfMEVm/8J4K4+AcvNEUVws2vqzuRtDBSWWKVxU2N2K2nJSnZcSR89SVgsy0JTEPXQkzP
         YvRe4WFU3CIwJSoEoTYRQsxqmIRm0tFg6n2HzEfGOO4evaxnpa1wfxU9Aq7k7EA5bI7+
         gUcQe2E531WTWrfXRPjWUYP7K6qjXeo8R33IP6+kipA1qf2joEHgSIRedLzG7Qb0AGC4
         7Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EByMNjCf4Q/7PjCQclIPBquLApcbaIlxxEFyo4N3wFM=;
        b=WHs07hFp9BpkocmT8hSnMEaVoTlM7PhXQuoeEfmAh40xjMCxqHbklL+ml9o8g0xPyc
         wHBapd7JoYCZ5RqMdarBsKmcceuqoXCcGM8Jet5VXWCGalgPTYi9gkduWtyenLiI5f4p
         M0AOJFn9DfgCvakcRejAQI9rtR3rvohaKKdqIcy3PDbcj7dI2Livcr3Su8zSB4Kt9NSA
         iZNvEq2q3PVaRfW2Niwzlkrz1zAVvcg4wFeJJ4nuVvDQ5avoaTzzn/Lk6VGsLKlxWdbT
         fJhhnPWfsixZAtUWTt3jHWWURNuqVe9A+dABlo/9iM+1RXEvOXy85ZHVVMbebLDn5fhR
         bQ9g==
X-Gm-Message-State: AOAM533Yv9JuLZ1AhA8OjASwWbAunZjc4nfy6l5cw+WBh2GvdGZMyc4+
	/uMB6z8afjD1De8XBSLiKKLsCf3lQfE3jVg+bnM=
X-Google-Smtp-Source: ABdhPJwJ6T5H9dB+gsPl3nCM24dsNlik6sAFT6LzW3OCAsehIV/jBisNCCuGRwSO7oGnJd0IpsrVJw==
X-Received: by 2002:a50:8a99:: with SMTP id j25mr11918727edj.253.1620402107013;
        Fri, 07 May 2021 08:41:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2fa9:2d27:234d:525d])
        by smtp.gmail.com with ESMTPSA id dk13sm4450911edb.34.2021.05.07.08.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 08:41:46 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net] mptcp: avoid OOB access in setsockopt()
Message-ID: <a73a8ce9-bf15-a94d-e936-444632eaa7dc@tessares.net>
Date: Fri, 7 May 2021 17:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Florian, Mat,

On 06/05/2021 19:24, Paolo Abeni wrote:
> We can't use tcp_set_congestion_control() on an mptcp socket, as
> such function can end-up accessing a tcp-specific field -
> prior_ssthresh - causing an OOB access.
> 
> To allow propagating the correct ca algo on subflow, cache the ca
> name at initialization time.
> 
> Additionally avoid overriding the user-selected CA (if any) at
> clone time.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/182
> Fixes: aa1fbd94e5c7 ("mptcp: sockopt: add TCP_CONGESTION and TCP_INFO")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

I just applied the patch with Florian's Ack, a fix for the typo spot by
Mat but not RvB tag for Mat (@Mat: I guess you are OK with the patch but
it is unclear :) )

- 20744dcd6f36: mptcp: avoid OOB access in setsockopt()
- c69b45723290: conflict in t/DO-NOT-MERGE-mptcp-use-kmalloc-on-kasan-build
- Results: 37818f5e301f..837dc82fa10b

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210507T154124
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210507T154124

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
