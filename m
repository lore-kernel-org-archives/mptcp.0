Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC8566C
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 17:37:43 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id cy23so41832331edb.12
        for <mptcp@lists.linux.dev>; Mon, 06 Mar 2023 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678124262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nyvu/y9VFoyRQ77khK27YiH3yWQTRpFJIYhMkQjlXs=;
        b=iuQ8tVqaxDEV51yokirvP7BL/u9m6noTDOhZwo+yHY3kDHz0UJhcjyi6c706HcYdKl
         IwIfED1fU8A7qX4VWNJelBHQfKiocLduiUYAB2mJrnIPJpzrW8jb64dBV1T7WeNGy3X5
         P8yoZ/orYqtog8ssjTO+W22QyOixbMBNew6VobEtZGG3xQ9u3m4O3pmWwYaHpJarNX9U
         YPYroCGLrvElQnlhoKnWipiPCGEcOQJKtoGi4Olk/T/I3OzdldY+JTHFZzBP1poyxBvI
         CbBVm1Jem8pQTUua2UpMwKwjorHsocwDgsK74rm/TxgdwIC0gcOSxPuBBVWLDLVJw4xx
         Mu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nyvu/y9VFoyRQ77khK27YiH3yWQTRpFJIYhMkQjlXs=;
        b=0zMlnwOll4wcJXWQcOseFCaAnGaqv/RJs5eOqCtRuSCcLB/CjtZ42BxgPKYNX0jk5m
         RqZI6f/1NQ/srtUreKxczWb6ty9d2gQNHTCXDSwtLBIm/GNenm9YW8uJ4QUajOiJiMm1
         +5ebt53mlcaFlSivmsS74oNpsqcL+Xe3vADultWKRcw9iu2Vc8Vm+XiwOVFWh394la4b
         65a1XaYPk2mHTNRD5onBp/+VjSBd6UqhfyIalu1Sh6i3ASngAGB9yET0UWuOpxJ+T80L
         1Azgca14oLhCKo5Hc2Q9nZNCSvtnVUvn0kvLt+91jggyoKC/9kMEL8+7sS/QDQf69h/2
         HDyQ==
X-Gm-Message-State: AO0yUKXhmSk5JI1nbGgSLcg1ljUBXUZVF2o9/M2snNrlCnFn+KPoR87o
	8mDaulwoyqXuPZrHJixcfpq7cfasZLIwBktSyT8=
X-Google-Smtp-Source: AK7set/OEhKAvnNW35RwcZy2PrCKqcI4rFFsRkyQ53mwSdutNlZCcItv9aVko0imWvJPU5ISWDqd8A==
X-Received: by 2002:aa7:ccd5:0:b0:4ac:b69a:2f06 with SMTP id y21-20020aa7ccd5000000b004acb69a2f06mr12413123edt.0.1678124261977;
        Mon, 06 Mar 2023 09:37:41 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id k22-20020a50ce56000000b004c07b11deb8sm5415592edj.64.2023.03.06.09.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 09:37:41 -0800 (PST)
Message-ID: <ebd7af0c-e5a6-f588-afcc-1fefd8a0e8cd@tessares.net>
Date: Mon, 6 Mar 2023 18:37:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-net] mptcp: fix possible memory leak on syn_recv
 race
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/03/2023 18:56, Paolo Abeni wrote:
> When subflow_syn_recv_sock() loses the inet hash insert race, the
> newly created children will be released by inet_csk_complete_hashdance().
> 
> In that scenario, without any further hint, the ulp release callback
> will keep the ulp context alive, expecting that the msk socket will
> later free it.
> 
> Anyway the dying child is not linked to any msk socket, and the context
> will be leaked, as reported by Christoph.
> 
> Address the issue explicitly releasing the context in the critical
> scenario.
> 
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/356
> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch!

Looks good to me!

I just applied it in our tree (fixes for -net) with my RvB tag:

New patches for t/upstream-net and t/upstream:
- 12727556f008: mptcp: fix possible memory leak on syn_recv race
- Results: 6cf09218c6fa..74e097ee5448 (export-net)
- Results: 9a7404e5bb61..9bd792349d0b (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230306T173558
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230306T173558

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
