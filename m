Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D12F2C
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 18:58:19 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id r11so11687074edd.5
        for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679684297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aM5HxqOV+QtMfuclBgHJH7lTiijH/4O4dxNBYYZxrqc=;
        b=07sSmpXBzc0QBHuyWMaRsKOFNZH+77XWwt9mjxzInZ4xzv3Coh3Sw4irKDABzDLCFj
         +mTqvA6iqrQUaci32rukAbuZY1WfmglHxTkHy4fnvXtg4y8laYEyDyFysnjjUdF0t23P
         xXgDSs+fhVNG6OS5qlNdojtmpMnVHfcIaJ0r7/CK9kvjKcDxeWsy46GgY3tzLUgNLnQg
         bfjn4Qohul6/HLinfXeEFwpNUu08X6BI1tACKZdjUWnIGzi8cIOCl1JWh+OYSIOxkMro
         tgWQ8UJlK6H8YrL6982/5lwTA1mgtrFfzWnKYhEGDCkhQcBtNnVC88LfC2mW4sZDdTZ9
         3svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679684297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aM5HxqOV+QtMfuclBgHJH7lTiijH/4O4dxNBYYZxrqc=;
        b=JjqgaLCmwJts+yqNOIUreJ+0ppJ2qQVp05b0deOTGqV8W1P3iof0n31KCfzrFV8K+j
         2/4YAWk5lU3jodTnL8g0WOD0SdkfN3/seAL7tHQlMjgLsxio/SvDykK7yNWg4+mJdWN9
         5GY20qimFfxnNSVNOrYPbcxxO3b9ptGlUlpVOMgTG2N4C/DK7Vc1fvj2CGphV1a1Y9PW
         pmjhw3Hmf5e6gWNn8r568BdOGhU6m282jkSGPK/Gleq0pVk7XyYp8EBtD/Ma2Q6eAhfT
         LsumZELaa0vK1ZjFsGcTDbSdgDDi2uvirVm5JOdLr4GQgXAAd5urpEyQD5UTBH3KwpLI
         Q2UA==
X-Gm-Message-State: AAQBX9fS9QxqD/WyZz8F8Z/9XO/bWYcyX3YhQGNxd20+oGlLx2pd0ptr
	quT5HjXtm6CXQf9Fb0Fm0L4YrEYErA2eo9vrKEwMmA==
X-Google-Smtp-Source: AKy350YcZXDla4Hwm6jLoOnN+sfMm9+gny+dpA+m4FqxyhLDp9/Pi5Ax324Y3zTe/o1SX4ktCc/cKg==
X-Received: by 2002:a17:907:6d24:b0:93e:9362:75fa with SMTP id sa36-20020a1709076d2400b0093e936275famr2165161ejc.47.1679684297136;
        Fri, 24 Mar 2023 11:58:17 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709064e0d00b009351565d1f5sm7092980eju.52.2023.03.24.11.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:58:16 -0700 (PDT)
Message-ID: <3100c8b2-4576-03eb-52a5-10d6ddf0fedc@tessares.net>
Date: Fri, 24 Mar 2023 19:58:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH net-next 3/4] mptcp: do not fill info not used by the PM
 in used
Content-Language: en-GB
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20230324-upstream-net-next-20230324-misc-features-v1-0-5a29154592bd@tessares.net>
 <20230324-upstream-net-next-20230324-misc-features-v1-3-5a29154592bd@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230324-upstream-net-next-20230324-misc-features-v1-3-5a29154592bd@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 24/03/2023 18:11, Matthieu Baerts wrote:
> Only the in-kernel PM uses the number of address and subflow limits
> allowed per connection.
> 
> It then makes more sense not to display such info when other PMs are
> used not to confuse the userspace by showing limits not being used.
> 
> While at it, we can get rid of the "val" variable and add indentations
> instead.
> 
> It would have been good to have done this modification directly in
> commit 3fd4c2a2d672 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")

I'm sorry, I just noticed I picked the wrong SHA for this commit and my
scripts only checked the ones mentioned in the "Fixes" tags. We should
have this instead:

> commit 4d25247d3ae4 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")

I can send a v2 later to fix the SHA if there is no other comments.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
