Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79113FC7
	for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 13:07:01 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id eq6so10041553edb.6
        for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u8l7HUNbb6T5hd+GJ4MBYUKuc1ALWgwKw98IY+lEVpI=;
        b=x1XIDJ9vm3CAvlnarSpe7uglRwDqmE8M6stiFxOTIdwFxpdKgwHffh1b/dNbDmb249
         hFFj6Sn6Q4HSz+jYD2xDHZDQ1iR9EGYCj7hdmr4ponqVai7IxXBqsy2ujBl9meOsRDmk
         qNxcmAQnAnqRWE64umeVIfzV8RINc/XYuZ/h8ZMcnTlEdyJDlTwpdsIrN+29f5R3bgpv
         G1IRdwuShnscAORDtZSJl9NE5rPA1XTr6KXynOU3Ug3GdFPlV29+7OOYgLPMN2BhOYTq
         Mnm1HTHWj8CaMeH83hHHph26cTlXoOLNg+KpSQrASDwrpn4UHvUJmB/aiJBLJUUzlfP9
         pXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u8l7HUNbb6T5hd+GJ4MBYUKuc1ALWgwKw98IY+lEVpI=;
        b=nlLxbpGdmJ/HNWRvkIBcIXg5vZ+osRlUDF5e/Clv9YVug9DkCAYgFKPQS5Mguv0fYC
         ZIPtDRo0Kzl7q8QrXb0QqomvdKUhJhY7zl9sM7h10WloZfrWQ8iGIqrMN5qw9puXAZy/
         PxpULWbpdXTty05SOvu7mcMDlV1qhswbMB2gMdTOOAfR6Oji3vJo5p1s5KCjEkVKh2ml
         9XxpEQrCXbbZrv4VkT+KHizPODlWAZWfMuQRts5Sg/szh72mNNndt+Zhv6OLQwfFdQXS
         c/MNG8cTAix/1N/fAnAuc/q7mApd+urd8dGXnPK2MKnwpxjsrwt8NO6AFt5odwkgAjCL
         Pd4w==
X-Gm-Message-State: AJIora+PIAAl0LDSjlq2AGENXb0xw+loTMdpT/QuhKQRVCazwkfInbSP
	RaWv1AblZNeyuQUJnXqrc8541w==
X-Google-Smtp-Source: AGRyM1t8RW+y6Zxso6IzSZ3nkCgU3iEFhL1cDkcOEW8Kb/4rto+4atb4ox05QRxohqhGkATqzRgT2Q==
X-Received: by 2002:a05:6402:2395:b0:43a:6d91:106c with SMTP id j21-20020a056402239500b0043a6d91106cmr32509494eda.299.1657631219727;
        Tue, 12 Jul 2022 06:06:59 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ef5d:b12d:ae7c:8d1? ([2a02:578:8593:1200:ef5d:b12d:ae7c:8d1])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b0072af92fa086sm3746055ejd.32.2022.07.12.06.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 06:06:59 -0700 (PDT)
Message-ID: <23fa8509-5b2d-6263-1543-443c9c896348@tessares.net>
Date: Tue, 12 Jul 2022 15:06:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] mptcp: Add struct mptcp_sock definition when
 CONFIG_MPTCP is disabled
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <20220711130731.3231188-1-jolsa@kernel.org>
 <6d3b3bf-2e29-d695-87d7-c23497acc81@linux.intel.com>
 <5710e8f7-6c09-538f-a636-2ea1863ab208@tessares.net> <Ys1lKqF1GL/T6mBz@krava>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <Ys1lKqF1GL/T6mBz@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiri,

On 12/07/2022 14:12, Jiri Olsa wrote:
> On Tue, Jul 12, 2022 at 11:06:38AM +0200, Matthieu Baerts wrote:
>> Hi Jiri, Mat,
>>
>> On 11/07/2022 23:21, Mat Martineau wrote:
>>> On Mon, 11 Jul 2022, Jiri Olsa wrote:
>>>
>>>> The btf_sock_ids array needs struct mptcp_sock BTF ID for
>>>> the bpf_skc_to_mptcp_sock helper.
>>>>
>>>> When CONFIG_MPTCP is disabled, the 'struct mptcp_sock' is not
>>>> defined and resolve_btfids will complain with:
>>>>
>>>>  BTFIDS  vmlinux
>>>> WARN: resolve_btfids: unresolved symbol mptcp_sock
>>>>
>>>> Adding empty difinition for struct mptcp_sock when CONFIG_MPTCP
>>>> is disabled.
>>>>
>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>> ---
>>>> include/net/mptcp.h | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>> index ac9cf7271d46..25741a52c666 100644
>>>> --- a/include/net/mptcp.h
>>>> +++ b/include/net/mptcp.h
>>>> @@ -59,6 +59,10 @@ struct mptcp_addr_info {
>>>>     };
>>>> };
>>>>
>>>> +#if !IS_ENABLED(CONFIG_MPTCP)
>>>> +struct mptcp_sock { };
>>>> +#endif
>>>
>>> The only use of struct mptcp_sock I see with !CONFIG_MPTCP is from this
>>> stub at the end of mptcp.h:
>>>
>>> static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock
>>> *sk) { return NULL; }
>>>
>>> It's normally defined in net/mptcp/protocol.h for the MPTCP subsystem code.
>>>
>>> The conditional could be added on the line before the stub to make it
>>> clear that the empty struct is associated with that inline stub.
>>
>> If this is required only for this specific BPF function, why not
>> modifying this stub (or add a define) to return "void *" instead of
>> "struct mptcp_sock *"?
> 
> so btf_sock_ids array needs BTF ID for 'struct mptcp_sock' and if CONFIG_MPTCP
> is not enabled, then resolve_btfids (which resolves and populate all BTF IDs)
> won't find it and will complain
> 
> btf_sock_ids keeps all socket IDs regardles the state of their CONFIG options,
> and relies that sock structs are defined even if related CONFIG option is disabled

Thank you for the explanation. I didn't know about that.

Then it is fine for me to leave it in mptcp.h. If it is not directly
linked to bpf_mptcp_sock_from_subflow(), I guess it can stay there but
maybe better to wait for Mat's answer about that.

> if that is false assumption then maybe we need to make btf_sock_ids values optional
> somehow

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
