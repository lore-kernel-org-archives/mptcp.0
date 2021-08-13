Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6662FAD
	for <mptcp@lists.linux.dev>; Fri, 13 Aug 2021 11:06:39 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id b10so9096071eju.9
        for <mptcp@lists.linux.dev>; Fri, 13 Aug 2021 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UubqOt/nH20nicFMvA+AkqDny2WcuCWyxlaJQnbLci0=;
        b=kV/SbUfvr9pl+ItBvXvkyxRYTu0gwVvZXAX9Tmh2hyXoLFCW2Zp3GbgzKDsK+W3vra
         r7zSTQZnVrWzM6lMjt4uyYsQDtyD9/zDNparJG4Rsp41JyOvg963zn4xw6cQd1swWwID
         T0f5l9S2sbn4qKSacp2l/ieDCp7PO9R006TcwTxUxJQZvirVerltMMKut0PByT3v8o2t
         XSWrIwTQbBjiXZlADNK0rSObwReuDwqjpM45cKjMpb+OEc5juQTyLbhYeDLy1fqEpI3+
         3WLr8zjBv/QSrdn8jmz/+5oatJwFdiWPHChY0kJhAA2EvEyx1qBBQ9JKcCoRWCSmYQ0d
         /h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UubqOt/nH20nicFMvA+AkqDny2WcuCWyxlaJQnbLci0=;
        b=ExWp0AFlHy6HlbfsbSVS/8RBRdEUeMvlRTdyHAbdjg3dv7QaNzMS1yIJ6KS0DQEpwp
         vFj2oJ2PjoSaJ8orc9AwSjTWCzTtEhVE7a/SsCqcXmxNaKYLfuKRPAcm2pc1dgYHj794
         gb1eUCdkWk3werxz4TICf5YJlymCCD6xRJWZM92i43PmQ2FJa0XKC9WgAi6uYSPdu/0e
         ilfWd7d1zUcwW6tKzmFa0IR6jxLBfoepCwc6o/ydPJxGV6wSVukTWNsw5qsIp3Sz6nke
         0EKmR0XvMnkG0JYMa5B2wP7u9EqI1XW8tI9TaaloO/QaPDTlhlb+/hMhfjbzkt9uKa2x
         29PA==
X-Gm-Message-State: AOAM533ggPTAAywizPgoZelXgK/j+M/i+EDaM0fKLZ8s7nCS0ci2Wdqf
	3zN0pHIlgYbEdkXOQcnIerdQ+A==
X-Google-Smtp-Source: ABdhPJzGIsmoMoxX3n5vqigiYHxtVmTBogykDDUO0ci56fzwDFrJKcgbAxKAQ8EN+GnbZVwWhzLq6w==
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr1861485ejc.196.1628852798361;
        Fri, 13 Aug 2021 04:06:38 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.139])
        by smtp.gmail.com with ESMTPSA id ju5sm483109ejc.8.2021.08.13.04.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 04:06:38 -0700 (PDT)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20210812162757.282366-1-matthieu.baerts@tessares.net>
 <cb97b91e-99d-d7b-4338-a83ddba4e83b@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next] mptcp: full fully established support after
 ADD_ADDR
Message-ID: <e8ce0aa4-c8a5-8907-396e-be420aec6fe4@tessares.net>
Date: Fri, 13 Aug 2021 13:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cb97b91e-99d-d7b-4338-a83ddba4e83b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for your review!

On 13/08/2021 00:30, Mat Martineau wrote:
> On Thu, 12 Aug 2021, Matthieu Baerts wrote:
> 
>> If directly after an MP_CAPABLE 3WHS, the client receives a valid
>> ADD_ADDR from the server, it is enough to prove exchanged MPTCP options
>> are valid. Indeed, the ADD_ADDR contains an HMAC generated using both
>> the client and server keys.
> 
> The ADD_ADDR HMAC is validated after the call to
> check_fully_established(), so I'm not sure this condition is fully met
> with the patch as-is. Looks like an ADD_ADDR with a bad HMAC could
> change the fully_established flag when it shouldn't.
That's a very good point.

If I'm not mistaken, we have the same issue when receiving a DATA_ACK:
here we just check if one is present, not if it is valid, no?

Should we delay when we mark subflows and msks as "fully established" or
is it not an issue to be in "fully established" too soon?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
