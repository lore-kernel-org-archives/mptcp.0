Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512C4689
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 09:09:24 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso6866525e9.0
        for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692349763; x=1692954563;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8L/hDqGBPpjFsNnLJfha3rBK28uCZzuw6Oc+jfl/Ow4=;
        b=djWYLN6/1VgG3wJTGkpkW3p+FzpKGwhHlnDogaocZdIxN6Y6XSqAmJJdGLIfZa1nlF
         9JCYCV7NzVBh8/jPN3EOgAegAq8oyr46VKHKH1iGjD0clD4FiczCFpyJMJ3wDlYbVjr6
         8UAITTGogDciXUwh7PrlWKN8QVukwagHBpqkhP9RL7tCt0EyVaRTpajk0fL20VwEeOMN
         czH3LazGqIBKrpublq8BRN9BRhAnm2AUe23iwMtPqwjyY3q0EhcbbNR9DfYbcj40RJ8g
         lk5HmVb/DIhq+3g0slGbq/IWvZdNZpesSV5QmYj3D0zlDuF4cRE5zQIUl/g4QPFyubFp
         6/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349763; x=1692954563;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8L/hDqGBPpjFsNnLJfha3rBK28uCZzuw6Oc+jfl/Ow4=;
        b=IajYAIuLO2/YgqPxw2PGDL6ESWlmABWbJ5oJ7Mb2TdCM/XtEsrSG6giGQIK4gJG1Qf
         +LOCUOpaPqlpNcMywGV2QKM5di/KrVBIclA6I5eYcuhmuBdnGFW/7rzmwZo70iKUZv9q
         46hrJqWq3ts56bebYSEcFRYd7BCC4J1t+w5J6czAqScPwEEAUTcaFAl2jGeYmSBx2Vbz
         8z8DhLTRE2uH6acMnT0g8rblpOeUtFlYzXB9NGf6nh9eB7rdsseDdqhZcfUDExcDBVAS
         tnOgQesnidi4fuqNj5tvPNz5x8z76jZTdfgypgLHznlp5gboUweha/NlZqUBKlRp9/zU
         mswA==
X-Gm-Message-State: AOJu0Ywc47j2QmpFJxmyzqx6Hv+sLS8scnOb1tv7GHc3FsA67plYDcOd
	0RSINBsY540SOivH7onmeJK3Sg==
X-Google-Smtp-Source: AGHT+IFHWA9FhNoH3O+EUMWvdYE11o2caWKN6FUhy+fMMNKx9VjClOO3obOkkSGsCuxJLXprXqUOUQ==
X-Received: by 2002:a7b:c84b:0:b0:3fc:616:b0db with SMTP id c11-20020a7bc84b000000b003fc0616b0dbmr1748405wml.9.1692349762901;
        Fri, 18 Aug 2023 02:09:22 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031989784d96sm2107600wrm.76.2023.08.18.02.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:09:22 -0700 (PDT)
Message-ID: <a29457aa-5b50-470c-95c7-a72ead69d02c@tessares.net>
Date: Fri, 18 Aug 2023 11:09:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <ee69d8a0379e89d8b194d753129d09d986f7e674.1692247869.git.geliang.tang@suse.com>
 <f71d2015-aa11-473d-ae85-43e760770298@tessares.net>
 <20230818083315.GA20788@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230818083315.GA20788@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 18/08/2023 10:33, Geliang Tang wrote:
> On Thu, Aug 17, 2023 at 10:58:13AM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> (I also have a question for you at the end)
>>
>> On 17/08/2023 06:51, Geliang Tang wrote:
>>> The commit "bpf: Add update_socket_protocol hook" on bpf-next tree will
>>> conflict with the commit "bpf: Add bpf_mptcp_sched_kfunc_set". This
>>> patch fixes it.
>>
>> Thank you for the follow up!
>>
>>> Please update the commit log:
>>>
>>> '''
>>> This patch adds a new struct btf_kfunc_id_set for MPTCP scheduler. Add
>>> mptcp_subflow_set_scheduled() and mptcp_sched_data_set_contexts() helpers
>>> into this id_set, and register it in bpf_mptcp_kfunc_init() to make sure
>>> these helpers can be accessed from the BPF context.
>>> '''
>>
>> Done!
>>
>> I hope everything has been applied correctly.
>>
>> New patches for t/upstream:
>> - 134c0805ac94: "squashed" in "bpf: Add bpf_mptcp_sched_kfunc_set"
>> - de64a137c29f: tg:msg: update after the recent squash-to patch
>> - 0642c8af7143: conflict in t/bpf-Export-more-bpf_burst-related-functions
>> - Results: 88082befad3d..f28cd69d6233 (export)
>>
>> Tests are now in progress:
>>
>> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230817T085246
>>
>> (...)
>>
>>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>>> index 4911293919c2..92cf6fbf8275 100644
>>> --- a/net/mptcp/bpf.c
>>> +++ b/net/mptcp/bpf.c
>>> @@ -144,24 +144,6 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
>>>  	.init		= bpf_mptcp_sched_init,
>>>  	.name		= "mptcp_sched_ops",
>>>  };
>>> -
>>> -BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
>>> -BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
>>> -BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
>>> -BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
>>> -BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
>>> -
>>> -static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
>>> -	.owner	= THIS_MODULE,
>>> -	.set	= &bpf_mptcp_sched_kfunc_ids,
>>> -};
>>> -
>>> -static int __init bpf_mptcp_kfunc_init(void)
>>> -{
>>> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>>> -					 &bpf_mptcp_sched_kfunc_set);
>>> -}
>>> -late_initcall(bpf_mptcp_kfunc_init);
>>>  #endif /* CONFIG_BPF_JIT */
>>
>> Do we not need to move this somewhere else?
> 
> We should keep this "CONFIG_BPF_JIT" here. I tried to move it at the end
> of this file, but BPF maintainer suggested me not to use "if CONFIG_BPF_JIT"
> to include bpf_mptcp_kfunc_init. [1]

OK, great then!

As long as there is no build error, we are all good then!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
