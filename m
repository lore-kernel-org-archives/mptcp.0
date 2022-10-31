Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7EA7E
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 14:55:57 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id y16so16309358wrt.12
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spG1pWgs0HKo374iFo7pt4NWqUFOCN2WvDteMvi2fG8=;
        b=FbImRK68+zg9kdSzZZJT35eKNaVxTWSaji8sFHyxIcyVRLctJPZmFf6GS6Igbs/YKD
         /dC/kGT/6nfi5bqYajPd00n8fI/09yESSt9Opq0LJqU08VEfn+qFnUt8BEEaU0If2uC2
         KfMR9JrUQ4jaAwFQXGvhXACBegoTe/pDKKau2k0PFhrRUlu29M4cqGD5Up5V0J9cmAp2
         QDqpLrppZpfBb7DkiE1S9xcD4TXDINJnbZFlVvwYM8NWPbSmcV7NrmPuhbBnagxIONrP
         N/ePRTzuIq365b1h1t8u71URKrW1SKi+MqQf+wDl1kcZ4OoEg8SlPbdWr1TB9IUWvQqR
         yi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spG1pWgs0HKo374iFo7pt4NWqUFOCN2WvDteMvi2fG8=;
        b=Mqf9QUe3HZecpfzfCu2gDjiYbrxKmR+JZBWzlWx9LPOFz+wLz1yRghK6pRHECGznnS
         8tuNCs06FidENcYrOzmITtXVr6Wfc1NU96hxhMVykdhl3NT9rkEnCVQxzCIOI420u5rg
         TErD9Ns7ucW2DdJehyy0CrL9Wvr/db6wPNE9CE2PSn+DD5gRnM9Oj09cBws6irIsUO+2
         9S+ZCIFh5P3Lkd5hfE6hu0W7P9rJcehq8U7P5+7Ny5y7m2yPyLWhzWuVx2juXd0zcegt
         kOxTewgSWMjmBAke/rm3HHTjC6nmhlCfNM0FL3wGXKXH7zW0SfkGJ+h9NMCP9ruOykdU
         xcTQ==
X-Gm-Message-State: ACrzQf0at5mDesC9D4We4hzYu5R0z54aoU9jdykg3xxfJOpCbKwjeYAG
	SqbstxxCFOfzPWnSwORJkIyHdQ==
X-Google-Smtp-Source: AMsMyM7THE2sgpnECExfxXL5Ops8vzITXfxH3K/10Lip9XJ5fTS/c3JHiOicFnB0QYQJAawYAZeCnw==
X-Received: by 2002:a05:6000:d:b0:236:6662:5bb9 with SMTP id h13-20020a056000000d00b0023666625bb9mr8703226wrx.619.1667228155190;
        Mon, 31 Oct 2022 07:55:55 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b003c6b9749505sm7937381wmq.30.2022.10.31.07.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 07:55:54 -0700 (PDT)
Message-ID: <0d68ba00-b4fd-29bb-42f6-e518527272a0@tessares.net>
Date: Mon, 31 Oct 2022 15:55:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net] selftests: mptcp: gives slow test-case more
 time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 24/10/2022 18:27, Paolo Abeni wrote:
> On slow or busy VM, some test-cases still fail because the
> data transfer completes before the endpoint manipulation
> actually took effect.
> 
> Address the issue by artificially increasing the runtime for
> the relevant test-cases.

Thank you for the patch and the review! Sorry for the delay, I was
having a very good relax time in Italy ;)

Now in our tree (fix for -net) with Mat's RvB tag:

New patches for t/upstream-net:
- 46fa4797d3cc: selftests: mptcp: gives slow test-case more time
- Results: e29d415f8a2f..b05afbfd1a6e (export-net)

New patches for t/upstream:
- 46fa4797d3cc: selftests: mptcp: gives slow test-case more time
- Results: c2faaafd29b3..9bcf275fb027 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221031T144932
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221031T144932


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
