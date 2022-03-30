Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F57B
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 14:51:29 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id i4so10832498wrb.5
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZjNf3ipo07k3pokNq1B/M1pZNVO8n/oj5dqkTm9vhN0=;
        b=vxuhcvUEE20TyUvcVROK7zIrqXamGlxg77n0wVaL3ZB1qiWJVRloU0JWUa1MKv79DA
         3II+ZMGi+tgchhIHAHEPa0jShwilxhmWKqG8gFL+BqrGWR5YUh411OlZN9TsfvJJqLJ8
         +HaHs5esdTjBVt+wWlBh6uIZbaK5F+fOdxYSRdagUAmgrHSoHGpbJ7emWNE7+QSODmbg
         ViqQvNeeOCbaRdJPZR4+mkbjBM5sXJCVsspP/OXtfX+oW619CdcoSZ/aIDbNADEuygqR
         1skQHiL5owA34Ett8DhNV1i1B5HUHFyJ/F0XXOdgf5fTeJCUGrf1d3BTKFd5FwIn2Acy
         t7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZjNf3ipo07k3pokNq1B/M1pZNVO8n/oj5dqkTm9vhN0=;
        b=BWt15tmyMWozKO9WQh6bplUTS9K2StcZgHF9x5MEjteVKcjxFp1sS3GKUxCSWO1zq0
         pJx12K7/pBYLR0y9YyzoVJH9RVDgImiY9QQR8ZGIWckIStnILIquZ1vLKTsihuZxcw5m
         ACsTwCvaF6jjS8oa1jY0473LYSHD+a6ig2Gxjg8F95rsfmEeO1TLhqkKZPZqhuIe3HMJ
         NvUmrJ0+qUalhvX3MIzoDOCBXCxAOjp/vy6U2jsCNksKkcMdaVKvMPFwuEojeJBJX6ne
         YEF/3YKjPdo0QqTACGjxPUpDo4w4mmyF6QiQu4iH6KYDpvV6YGoIOcmjfKQfiNLl7fiE
         TwFQ==
X-Gm-Message-State: AOAM5323HdD8nCp0jwjVcXcHX4qReLlVGRy9HsmJ/Tlmp/Ryftl17BtL
	Oo5rLxexf74TV6VCBH80vS6584msT2Y6eQ==
X-Google-Smtp-Source: ABdhPJxXulAlJAc7CSMmN+rhuZNi9m+gpBMMpn+Aq+I0Hr9HVdzFEUl1Jhs1D4bvTC0UDahYFefdJg==
X-Received: by 2002:a5d:50d0:0:b0:203:ee99:a8fe with SMTP id f16-20020a5d50d0000000b00203ee99a8femr34984321wrt.600.1648651887478;
        Wed, 30 Mar 2022 07:51:27 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d4051000000b00205a8bb9c18sm13453916wrp.67.2022.03.30.07.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 07:51:27 -0700 (PDT)
Message-ID: <49947509-864b-3d30-5934-a50c3b2d80a4@tessares.net>
Date: Wed, 30 Mar 2022 16:51:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add
 bpf_skc_to_mptcp_sock_proto"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <ffd704984e4e76741161d35ef127fde082d0add1.1648624018.git.geliang.tang@suse.com>
 <ecc7a980-d75f-2172-8fc2-eb12de7cf7e3@tessares.net>
 <20220330142214.GA861@localhost>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220330142214.GA861@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/03/2022 16:22, Geliang Tang wrote:
> On Wed, Mar 30, 2022 at 03:29:06PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 30/03/2022 09:08, Geliang Tang wrote:
>>> Fix the build breaks reported by kernel test robot:
>>>
>>> [mptcp:export 32/40] ld.lld: error: undefined symbol: bpf_mptcp_sock_from_subflow
>>> [mptcp:export 32/40] filter.c:undefined reference to `bpf_mptcp_sock_from_subflow'
>>>
>>> - add defined(CONFIG_BPF_JIT) too.
>>
>> Thanks for the fix!
>>
>>> - move bpf_mptcp_sock_from_subflow from bpf.h to mptcp.h.
>>
>> Should we add an explicit #include <net/mptcp.h> in filter.c.
>>
>> But maybe it is enough to have net/mptcp.h in net/tcp.h?
> 
> Yes, net/mptcp.h is included in net/tcp.h already. So no need to add it
> in filter.c explicitly. No build errors for this occurred in my test.

Yes but I don't know if the recommendation is to add mptcp.h directly
just in case instead of "indirectly" via tcp.h. But that's more a
question for BPF maintainers, easy to fix later if needed!

So good for me to apply this and avoid issues reported by Intel's KBuild!

Now in our tree:

- 3b9cc9f027bf: "squashed" in "bpf: add bpf_skc_to_mptcp_sock_proto"
- Results: d2b06f03e554..ccc95f7c14d9 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220330T145030
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
