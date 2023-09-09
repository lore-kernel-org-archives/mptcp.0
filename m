Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A586FC2
	for <mptcp@lists.linux.dev>; Sat,  9 Sep 2023 15:50:26 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so34090815e9.1
        for <mptcp@lists.linux.dev>; Sat, 09 Sep 2023 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694274625; x=1694879425; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVOUfLS+7cbfMp6qJGYTJ7Nxk9WG/6KeYhQ+zxmFkXs=;
        b=Kagt5IVtb3V3v6ULYLdd6CCN3s0SkA8PTioOnhnv21u6QN9pkE8PyRyj2vERX/Km2w
         BslfAmeQn1D4wIM/c8UmdG68KSIgz0w4QP1GE04yJPeE6rHnDlEkcr7HKtBDw+asntNw
         5SoKbDMlbX7VspvFauh9t3gYnooJSHufRwLG5jhpWrjoG7UzXorvMOLyBgaZybUfXw6a
         2BpuSdqML8WLjgm3rRFWWobQtsz06E+1YVWLu+g31Z7KxOmNtcBMOFPRWN+yofUKIieP
         LoX38u9J82h9LQgFJ1hlQclTZvxI5BasxQQ2rTyBK9OUMoA15cyhwcsjs/4b2Yi0nkHB
         gvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694274625; x=1694879425;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVOUfLS+7cbfMp6qJGYTJ7Nxk9WG/6KeYhQ+zxmFkXs=;
        b=LgqxM3JdzHKlbVYg5UphsCeWXKYo4u5AAUBijkGm1AJJ7swdhSY9Dw03LmiqgwlOhh
         2Las+4zMca6QrKBapbHG85C6npDiegT9idQTxaGCSYvoQJAkT1CYDh48mog5si/HRFQ9
         uBra95R2ADGUY4Qcufzc6WVDsj/yPXdN4gSyJb4QCZt8kWJouMC5wAJmqggi5SfNecO/
         ZqMYAkNVWz1khSOOLmMFOEJ2RowraPeK2uCEok2j1Rzn/JiBnjJj2xVhR9eCs9LQGpcH
         7UJOzwrwzIm8cpezEVFcmCf4dUIqtSpXCIk1lNouWKySmZGeBB3aszuTD4Xd4rtAwvx6
         dEsw==
X-Gm-Message-State: AOJu0Yw/C2vvGHk5wZNPVTyDd5IcYCXMMX8hlVryMwHzCjEhVfMPYrYE
	VXEhRCEXdLKm4cwmet08bigZmkquMt1G4LXipmehAw==
X-Google-Smtp-Source: AGHT+IE/k9eIH/+s7cGqGn0mtqYAKBpsLOs57No8h5SYa3CDCQ1hvCxq3SqZLWkjIkv/CVP5bNetxA==
X-Received: by 2002:a05:600c:210f:b0:401:dc7c:2494 with SMTP id u15-20020a05600c210f00b00401dc7c2494mr4744337wml.27.1694274624355;
        Sat, 09 Sep 2023 08:50:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:91e4:ea9f:cc1e:927a? ([2a02:578:8593:1200:91e4:ea9f:cc1e:927a])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b00402fa98abe3sm4261564wmb.46.2023.09.09.08.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 08:50:23 -0700 (PDT)
Message-ID: <4f8e9b17-e19a-44a3-adac-38771b5fac51@tessares.net>
Date: Sat, 9 Sep 2023 17:50:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 2/2] mptcp: fix dangling connection hang-up
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1693988314.git.pabeni@redhat.com>
 <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/09/2023 10:30, Paolo Abeni wrote:
> According to RFC 8684 section 3.3:
> 
>   A connection is not closed unless [...] or an implementation-specific
>   connection-level send timeout.
> 
> Currently the MPTCP protocol does not implement such timeout, and
> connection timing-out at the TCP-level never move to close state.
> 
> Introduces a catch-up condition at subflow close time to move the
> MPTCP socket to close, too.
> 
> That additionally allow removing similar existing inside the worker.
> 
> Finally, allow some additional timeout for plain ESTABLISHED mptcp
> sockets, as the protocol allows creating new subflows even at that
> point and making the connection functional again.
> 
> The issues is actually present since the beginning, but it basically
> impossible to solve without a long chain of functional pre-requisites
> topped by the blamed commit below.

Would it not be better to put another "Fixes" tag and mention that
bbd49d114d57 is required for the backports?

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
> Fixes: bbd49d114d57 ("mptcp: consolidate transition to TCP_CLOSE in mptcp_do_fastclose()")

My fear is that this patch will not be automatically selected to be
backported below 6.5.

Instead, I suggest to use:

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")

The issue was certainly there before but hard to backport without that
one anyway.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
