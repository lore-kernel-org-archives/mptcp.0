Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7D7460
	for <mptcp@lists.linux.dev>; Sat,  9 Sep 2023 16:13:01 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so32184305e9.1
        for <mptcp@lists.linux.dev>; Sat, 09 Sep 2023 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694275980; x=1694880780; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXaCuoFl5FbfIzBG289NAlsYAd/tsNZ/6qnm1JMGWwo=;
        b=6o5piRUeZOSwCdW+f5n9EcZlXJQGSHpJ2SkvsmE0bYWP9z1yK2EDOfgdA1SP1JL5Ob
         lIvdm2zd/kZ1RUzvNl+yropnNbDNCekuG8DY8XaHTT9UVI2tm+VwKFzkHzEbsLE6VRxc
         cLV1XoQAlp4WxYp6O/5Z8lADevIwaNpI7yMXL9BqUDSxmnC29FkXNZLFIRezyHwJTPSB
         NLHEttfqxVVRdRQ11JiUiCvkwY/AqXbi47vrmjUyKhCB438UntGUEHWcHDLOjrBa3f5S
         AesYkt6Jezp/htCGhIPssLCaMkDUo4olGpAk9b/Z76prGjK/GOwH6eXnbHRRoYOGuedi
         vS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694275980; x=1694880780;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXaCuoFl5FbfIzBG289NAlsYAd/tsNZ/6qnm1JMGWwo=;
        b=JTW2xJ2ZQPFnVAaGuxmGm0sgFhKykF9GbEMk9XHQrllKQpp9qzuJwUiiNrkAqdPi80
         9Mok5XNP25fphjivZjKx8ENsVMrTVDpkcu1uS7yi9QHcgnlMtifehgbCPNVVbalXggKb
         xAAJv9v7C1F8Ps0JCYgip+Jx1rOlsH66KlP5FNko2zoi1KPTBgDkbchYH3ZpUiJApBwP
         0a41gCy7NzWHhSvEu7fNzaM7YuJHqpdjh7JlKbJvjc9HI2GCGZejFVz5IidDrtyp+3RC
         cxM8pb4sae68OQgvPCbWWUIHXu8aHUWSf9qoWxd/5hcT3YgyeWeTN2EXQHrPZB+eB2+I
         3wqg==
X-Gm-Message-State: AOJu0YwqPxC9SxcWFvX3xB3AfoMD+7yGQZF/XM5cqW3TKKR+lNstT5O8
	nIdbpV2zsCO83sKWBtTgdo5ZGIpwyjPFt0Fxe4itHA==
X-Google-Smtp-Source: AGHT+IFsNtH1iiNQPyYUSKHYYdRDENKKs/I0mRy7NLyHL1+qehUfB/gepDRb7gCsy4cpl610w6htsw==
X-Received: by 2002:a05:600c:1e14:b0:401:d1a3:d7f7 with SMTP id ay20-20020a05600c1e1400b00401d1a3d7f7mr4422307wmb.30.1694275980114;
        Sat, 09 Sep 2023 09:13:00 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:91e4:ea9f:cc1e:927a? ([2a02:578:8593:1200:91e4:ea9f:cc1e:927a])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c510d00b003fee777fd84sm2173584wms.41.2023.09.09.09.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 09:12:59 -0700 (PDT)
Message-ID: <f4e8f6cc-d557-4b60-9d22-096595cd2ffb@tessares.net>
Date: Sat, 9 Sep 2023 18:12:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 0/2] mptcp: fix another close hang-up
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1693988314.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1693988314.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 06/09/2023 10:30, Paolo Abeni wrote:
> If the TCP subflows close silently due to timeouts, the msk socket
> can hang-up indefinitely.
> 
> Implement an additional close timeout triggered with the last subflow
> close event and move the msk to TCP_CLOSE when it fires.
> 
> Should address issues/430 and issues/431.
> 
> v4 -> v5:
>  - let the tout always expire for dead socks (Mat)
>  - fix comment type (Mat)
>  - targeting net, added fixes tag

Thank you for your patience (sorry for the delay), the new version and
the previous reviews! It looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

(@Mat: I can add your RvB tag as well, especially because you did the
previous reviews.)

I just applied these two patches in our tree (fixes for -net) with the 2
suggestions I mentioned in a reply to patch 2/2 (still possible to undo
them if needed).

New patches for t/upstream-net and t/upstream:
- 292454bf7376: mptcp: rename timer related helper to less confusing names
- 246aefd6e9b3: mptcp: fix dangling connection hang-up
- Results: 07a89d3454a9..c35c49bddbfc (export-net)
- Results: 07a689bb4cbf..c23e74879d43 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230909T160908
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230909T160908

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
