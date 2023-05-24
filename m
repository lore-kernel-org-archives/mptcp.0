Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0231FDD
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 13:44:03 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3093d10442aso584484f8f.1
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684935842; x=1687527842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoVncuEGQqhcfC8ns5/q1QwLNpFgl05VFw7ZUCLxAeU=;
        b=KwayabJ9XSQKO2EuegAL3fgPRxSXuLgHRgFndcXKZE/NjdR6Sws8Lnbz8B1ebXkDoo
         HBCF5uJHLrLwcDrcx0mcfVilW1m+jHKam59rII8VHdl/1K5unxNmhbQmWzacjELq31he
         Z0ioijZSAjh/OT3YRHr0wKkvA9aB52aJS3VH5vUzThKWzgHPXqphV8Gka8QsHs3jC+cI
         8yLwvuCL+sY8DWxdeLb4yoemXlp76Z/oJcCJUJmdJl3w8JPY/+7RslTGnxjCSKfnyAyC
         RFWf8UgSCp9DDPdeXYOZRi9vGZmUB7ZFkMb0yPnqETXzbUGRI4SEchh5PGVoPk6SCyeA
         pyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684935842; x=1687527842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoVncuEGQqhcfC8ns5/q1QwLNpFgl05VFw7ZUCLxAeU=;
        b=i9tlUpjZqUkUlOLh99I3NaoStxzQDmltIIqE/lmKbIVB11N9uRAUPMsiNdjWS9yhFp
         vhnxuNoPbB0RJepUxYaIUm7fZUPtFWyWIFZVzF7Pd6Itpz+JMbCFBOGX6pcvFuP1zk9D
         6+qbGr+nfNJEzUIiCe6dOy5xKHgYc6quls7qKl2XDrnWyUbAAUbTAPZdBsMxhLSi8/43
         iVtKBfOdXZOV80UigKJPmmuL7T6JUaubO2LYxmO4WPwYAKMldjCiROGPfphg5shmvrVU
         t5rfR6Je7vz6tHvvph9m+e0wD0uoNp7dZl4z84g4P4VwxYLW1y7i3xOQK/lAKdx851rO
         vCxg==
X-Gm-Message-State: AC+VfDzRcQf3UJ4D9UCcn2QR5jbeR5bgOFVlcoDv/2K7/tgxht5zOu7u
	0Qx/gDviiL/JGYSGysi0r6b7fQ==
X-Google-Smtp-Source: ACHHUZ6aoOwHXoRBa4/hS75RpFAvM9Oi4iq7U89L8MFdk720X12GYo5DGjjHrj1xgr6Jt64gfhkdnw==
X-Received: by 2002:a5d:58d4:0:b0:309:4f23:e52d with SMTP id o20-20020a5d58d4000000b003094f23e52dmr11697657wrf.43.1684935841860;
        Wed, 24 May 2023 06:44:01 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id q16-20020adfdfd0000000b0030642f5da27sm14533718wrn.37.2023.05.24.06.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 06:44:01 -0700 (PDT)
Message-ID: <b93ba574-fa6b-137a-1da4-d8e3f04460df@tessares.net>
Date: Wed, 24 May 2023 15:44:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce
 MPTCP_FULL_INFO getsockopt
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <9c4f161a53250127f0634359433ee51934606342.camel@redhat.com>
 <53030866af889e674647a02c37b0909ee395c9f5.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <53030866af889e674647a02c37b0909ee395c9f5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/05/2023 15:35, Paolo Abeni wrote:
> oops, Matttbe noted I omitted a few recipients, re-sending...
> 
> -------- Forwarded Message --------
> From: Paolo Abeni <pabeni@redhat.com>
> To: Matthieu Baerts <matthieu.baerts@tessares.net>
> Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
> getsockopt
> Date: 05/24/2023 12:20:25 PM
> 
> On Wed, 2023-05-24 at 11:12 +0200, Matthieu Baerts wrote:
>> On 24/05/2023 10:53, Paolo Abeni wrote:
>>> On Wed, 2023-05-24 at 10:13 +0200, Matthieu Baerts wrote:
>>>> (If we add mptcp_info (cf Paolo's email), better to strip 'subflow')
>>>>
>>>>> 	__u32		size_subflow_full_info;         /* size of this structure in userspace */
>>>>
>>>> Why do we need this field? Can we not use the option length (int __user
>>>> *optlen) provided by the userspace?
>>>
>>> With this we can append arbitrary/variable size mptcp_info at the end.
>>
>> I guess either we use a dedicated field for mptcp_info or we infer its
>> value by looking at size_full_info or optlen. It looks clearer to me
>> from the userspace point of view to have a dedicated size for mptcp_info
>> than giving twice sizeof(mptcp_subflow_tcp_info) but I'm probably
>> missing something :)
> 
> Currently, with the existing sockopt we have the optvat pointing to
> something alike:
> 
>> hdr_size | hdr | more storage |
> 
> and optlen specifying the whole optval data. We need the explicit the
> header size field, as optval must specify the whole size of the user-
> provided buffer and we need to know which part of such buffer has been
> filled by the user-space.
> 
> In this case:
> 
> "hdr_size" == mptcp_subflow_full_info.size_subflow_full_info
> "hdr" == mptcp_subflow_full_info
> "more storage" == mptcp_info
> 
> We could add a (rendundant) field inside mptcp_subflow_full_info to
> specify the user-space mptcp_info size, but that would be ...
> rendundant. Unless we drop the hdr_size and we compute that from optlen
> and the new mptcp_indo_size_user field, but that would be IMHO counter-
> intuitive.

Thank you for the explanation!

I think what I'm missing is how the 'mptcp_full_info' structure will
look like at the end.

I thought that the idea was to have 'struct mptcp_info' embedded in
'struct mptcp_full_info':

  struct mptcp_full_info {
      __u32           num_subflows_user;
      (...)
      struct mptcp_info mptcp_info;
  };

In this case, it looks strange to have "size_full_info" being
"sizeof(struct mptcp_full_info)", what we would also give to the option
length, no?

Or the option length should take into account a separated space for the
subflow info and thus use something like this?

  sizeof(struct mptcp_full_info) +
      sizeof(mptcp_subflow_full_info) * num_subflows_user"

where "struct mptcp_subflow_full_info contains:
    - mptcp_subflow_info (subflow id + mptcp_subflow_addrs + maybe more
in the future)
    - tcp_info (which can grow as well later)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
