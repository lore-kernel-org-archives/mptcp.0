Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81714F94
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 16:55:44 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-401da71b85eso5346615e9.1
        for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1693328143; x=1693932943;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxMYMVH1Zbb80AeIZ4jQTUKnEbq+8KWc82Zxzt2jn9A=;
        b=LVDWFSwKMVqNHlZxa0/OTh/KyW2R3LWdnPxT3oVIq+82Lv9qrgUGs5eaGQGBo9gLZz
         JAVdRa/wQxw4AUXoFyj7v8GVeQcByRZmlzv4pn7kRvv8noKmwJtYHN62hWMaU5IPG6ok
         OIk1DskYZmFm4r3xxfNquSbLmw5hoBfmE0PjG5+rB3meac0PrxP34AYIKyruNQ2o6tW1
         4xzW1koDJLN3pp6Bpb6VyP2kn1yV6buz/082LvXqkrNcshlL4myzQBUOTFdVD0/I0+cD
         3KxllsiP5BRU3HLHAyDCUSKBdXOmg7fOemUIODVAVTg9uOegiyFnwQaIyktLyT0OX3dF
         MlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328143; x=1693932943;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxMYMVH1Zbb80AeIZ4jQTUKnEbq+8KWc82Zxzt2jn9A=;
        b=D/xr+IJZMR4F3q+mTx0jfkiqVVlo8EjHP3YXKJwuXDwVCxzcqcSoJHfDzrdTIUzUyv
         RHnk0jQWaq9NAxTbNs4ySoRCoX4hgTAQTU5h6K2PTRrUjwWlM36qywfi+q0HJH7L3LdL
         W2iFkFE/1AIa8c2p6VYc+/rtfGm2C5R+t6JhIrsnJZuhVTnH8loA00rwedz0INZaWlif
         kXMqYPIOGZLMZ27EyAy4r9fs9/L/jKBxWJ2c4iPwK4sJW2aATJEMC8EZtSaQ1T5x8aC9
         HRYJ6C8XT0AI+yYIaTyGGxkGpVdSE1sXahPFkaa+/g48iwDvy76LPB8NgJ/VDSKNxoEk
         5beA==
X-Gm-Message-State: AOJu0YwhTGpCveN8LXyV2JuXEfm+Iq6cs2dQPbGA2jhTBGh70iLdwLko
	gTuUAgRBEUt9tH13CIhP/Amzxg==
X-Google-Smtp-Source: AGHT+IFydJPdRwsWnZn6xWpcsSOJe0FF28t6t/bWZq0GaSoLmk3uRxi710zMfbgiJucFihFG27AnWw==
X-Received: by 2002:a7b:cc81:0:b0:401:519:c5 with SMTP id p1-20020a7bcc81000000b00401051900c5mr12252794wma.41.1693328142939;
        Tue, 29 Aug 2023 09:55:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2f72:9e4e:9104:797e? ([2a02:578:8593:1200:2f72:9e4e:9104:797e])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c024d00b003fe2bea77ccsm14544625wmj.5.2023.08.29.09.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:55:42 -0700 (PDT)
Message-ID: <0ee0e369-1a7f-4da0-93f1-fcf70ad51890@tessares.net>
Date: Tue, 29 Aug 2023 18:55:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix bogus receive window shrinkage with
 multiple subflows
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 23/08/2023 10:18, Paolo Abeni wrote:
> In case multiple subflows race to update the mptcp-level receive
> window, the subflow losing the race should use the window value
> provided by the "winning" subflow to update it's own tcp-level
> rcv_wnd.
> 
> To such goal, the current code bogusly uses the mptcp-level rcv_wnd
> value as observed before the update attempt. On unluckly circumstances
> that may lead to TCP-level window shrinkage, and stall the other end.
> 
> Address the issue feeding to the rcv wnd update the correct value.

Thank you for the patch and the review!

Sorry for the delay but this is now in our tree (fixes for -net), with
the "Closes" tag:

New patches for t/upstream-net and t/upstream:
- 59d3c92821f2: mptcp: fix bogus receive window shrinkage with multiple
subflows
- 490c75fb2e65: tg:msg: add Closes tag + typo
- Results: 33d85a2cd769..fa580ac35599 (export-net)
- Results: a96bdbce1428..54ea4fcf4272 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230829T165049
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230829T165049

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
