Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788265665
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 17:09:59 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id a25so41838088edb.0
        for <mptcp@lists.linux.dev>; Mon, 06 Mar 2023 09:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678122597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWsSjH2R8tumBawryp/NNuAfGhDFOsu4DU1nosBLQzM=;
        b=BhJCnDwzwtgae93ufoxtoiH40/jA9qJehrm8QIm3NdRE04CRfg3FvmIjYcgezomk03
         qfd3r/Y6EyF4AbPExVCwUO1e6NBI0eilhBGb5NyqIN3qkvHjm48n+2EH44CoUBuF19k3
         dnMTYQbSmwhDpM5jEcVPoIo0HB8jFK2+Hqpxakvp5+rAmD6mxCV4hzXm8x0wKok6YHPT
         we3drNmsCB7J/1zBfQTVvyZMcbKgI1udF1GgF9D7IoOlgOoVW0BI8EAKLgsyjtkCMaDQ
         mwOT7r7Cgq79MccbSQeDqwT0gkdhVy6t66GGec/SYpmpJT97NWyWD11wT4RY/H9+7VCr
         yGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678122597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWsSjH2R8tumBawryp/NNuAfGhDFOsu4DU1nosBLQzM=;
        b=ZsOhViuyplGykxAJ8zY47Ml5Z+hY5H9KoXiI+sGRnfi32PvcUTB9l2FaToZPBwImzH
         9VPA178iPU+yaF1h4i0rbyTmWXbZCfofpxLTSu6uGdta0ObG4uYZ50XOSH06oC1YClIc
         4P+6s//F2T5GNws3TOop7BuqC/ciAk3W9wQmyVmHSDtmm1M9CFtG6UBydPZQL7OimXUg
         0t/OvFQA2SbkU+8Kn+3+GxcLz3WeSoHDi5KG0TAvHzEsh/6Zi0/QisCFNzLnS2dfsaUk
         5xJQagTK5ZWbiApsGQETS36zBaZOeKYxrxiie9UAn0iiDbko5xrs3CFLcUOZUF9uhkCV
         wHug==
X-Gm-Message-State: AO0yUKULN/IGsqRL6S9BwqNZNVAlf43uwB0DfjLVwXftHcGOJPdz6DkD
	0Xnga3iblQ+rOQbgBjgpuRU61HqQZxMbhs7CNmo=
X-Google-Smtp-Source: AK7set/VQZcIKekYdIBeJX3X714D9Am08PcgR7HLDDTct0vp5AJDyKLjQ2NB3vmsvkc8SbrtKD8Vfw==
X-Received: by 2002:a17:907:787:b0:8b1:7de3:cfb0 with SMTP id xd7-20020a170907078700b008b17de3cfb0mr14531958ejb.2.1678122597572;
        Mon, 06 Mar 2023 09:09:57 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id gw5-20020a170906f14500b008c1f68ba0e2sm4765567ejb.85.2023.03.06.09.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 09:09:57 -0800 (PST)
Message-ID: <7940d35b-789a-6179-f564-c66acd50a6b8@tessares.net>
Date: Mon, 6 Mar 2023 18:09:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 mptcp-net 1/2] Squash-to: mptcp: use the workqueue to
 destroy unaccepted sockets
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <f2408481e722ba13f5303ab1e6328d97388487fb.1677666206.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f2408481e722ba13f5303ab1e6328d97388487fb.1677666206.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/03/2023 11:24, Paolo Abeni wrote:
> The workqueue could trigger before inet_csk_listen_stop() kicks-in,
> or the closed socket could even land to accept(). Solve the race
> falling back to TCP - we already complete the MPTCP level close
> signaling.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/366

Thank you for this v2! I also closed #367

New patches for t/upstream-net and t/upstream:

- f5b198218ffa: "squashed" patch 1/2 in "mptcp: use the workqueue to
destroy unaccepted sockets"
- f3aef91ddcb2: "squashed" patch 2/2 in "mptcp: fix UaF in listener
shutdown"
- Results: ad3ea9f741f1..6cf09218c6fa (export-net)
- Results: 24567d3d38e2..9a7404e5bb61 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230306T170503
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230306T170503

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
