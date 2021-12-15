Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C02CB3
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 16:01:14 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id b7so17260842edd.6
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=yF5k/pu6idA7DIS4pAJzWVMjyEm2IvjHRpU9L52aBFg=;
        b=BjmClNd7ule12UQqEWINEKlN2uc8wO42ZZNv75aPAhB9/ozdPJB5hjZt9vVssgLZuh
         lgPclZTJqwawNLPkGpraDhaDjcxSTPcQN7vlbm5IbfK0XqpsTzVNq5NFa+mCGY72WtAy
         blk/hDS2s3QPBpFMQNA9wY42adNdna0xonldDi1FUSG3fLTXDM3iWfCM3e9BEmbSjOtX
         ekUDAn4XwqEWQYBv85lOLMvOAVmb0N/cmf3LscTHxHrtm8xFYf/Q+/BuX8qQiI1CQGv2
         hATLWcbicuAmV6LGPBe3TpCPEv6BCo7zq+07EjI1qucqEbMM8pVlpQdFpQqZTNjZA/hZ
         E7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yF5k/pu6idA7DIS4pAJzWVMjyEm2IvjHRpU9L52aBFg=;
        b=63GXpsCebAehgDYnOGyLQt3tJuFnr/lQlAXjRRLYnnW4gney951HxrfAXC5bytUHUy
         WzH3EoqKyBWAa7VHg/dMVGIzOQAGc+3DnE37QGwlWA5N0m8P7Fg6KCFOLpuDQi9cFGxa
         wXOSjBrh5jRyWGUTjtJy5O1sFxK7xlbZzP8zzWlN5MFUGwZmzKGKLGNf09BmszyhWuES
         r7DbdNflTKyn9WflISCOA82Y43bvzW6nj5C4igcoOmInX7QyXns6Z0RX84o7x3+z1UDW
         xz8AFHNMsMJBD1Oxa4hXBMeWFRY9MSbVg3XVyIWPBwxZeeGW3tLa7Pi6g3JYEKnmXHJ+
         jZfA==
X-Gm-Message-State: AOAM532R275uaI9kkthnfbqKJhFKMnwcffX5ENFjwT+7t7OqEYQ2D6dq
	MW83s3imvDjS7yk5LFyoetv+ZEUN3o6oOQ==
X-Google-Smtp-Source: ABdhPJyj01dHyT7ubIZ+ShKzNjZ+Oh8aPWug1fhYPDm7IHEPyY1n8kHI0JGnpMDI8YI4vdSkKascrQ==
X-Received: by 2002:a17:906:3a8c:: with SMTP id y12mr10823861ejd.517.1639584052825;
        Wed, 15 Dec 2021 08:00:52 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id g18sm864346ejt.36.2021.12.15.08.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 08:00:52 -0800 (PST)
Message-ID: <209983a9-6569-f969-af22-a334ea21f4b0@tessares.net>
Date: Wed, 15 Dec 2021 17:00:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6 mptcp-next 0/7] mptcp: improve subflow creation on
 errors
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1639500873.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1639500873.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/12/2021 17:58, Paolo Abeni wrote:
> This iteration tries to add address the feedback on v5, namely
> test counter update and locking in write_options. The latter
> required quite significant changes in patch 5/7.
> 
> Additionally the series now includes the pending cleanup, as
> they depends on the previous patches. No changes there WRT the
> previous iteration.
> 
> Currently when a subflow connection fails - either the TCP
> connection is reset by the peer, or the MPJ handshake never
> completes - the in kernel PM don't perform any further action.
> Notably no additional subflow creation is attempted.
> 
> This series is aimed at improving the in-kernel path manager
> behavior in the above scenario:
> - each endpoint is used only once per connection (patch 2/4)
> - on failure we try to move to the next subflow, if any
>   (patch 3/4)
> 
> The first patch is minor cleanup, and the last patch adds
> specific self-tests.
> 
> This should address/close:
> https://github.com/multipath-tcp/mptcp_net-next/issues/235
> https://github.com/multipath-tcp/mptcp_net-next/issues/242

Is it OK to close these two issues now or do you prefer to do that when
patch 7/7 will be applied?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
