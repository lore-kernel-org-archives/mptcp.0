Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517A3B53
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 16:15:40 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id n15so10013562wra.6
        for <mptcp@lists.linux.dev>; Mon, 07 Mar 2022 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z9/EWXbo0V6at54tAlhdI4wyS4NCBT/wOp5hrpHiWUE=;
        b=LgB5LvGd/fMdf4moQHv5hqudE5Q2qeNsO8BVcl6v6o/JPaY8r8MMktqWgHZg5hHD5s
         G3gnwyEO9kBhtXAfOLBNXurt0s4WZOXVapVbN0CvbgAuT0r145M/Fqjl1m/H/ouZWuWv
         Wc/KsypxDb02R6ePwAA6wYiThR4yQXuae74sQJH1bfhqPfzBk4m4+H0mxdtAb7ZImEA9
         DuasYhroXGLBkuhwZbqNryzJa8/H2qte/6yLN+jqmRz2gfLsAKpBeUCLSizl6GHjJH0o
         8msOyO/yWkTT0qWhZEJudQiSYCwSzUclaROlYr9uj7MFcFV09EttJMs+uYlleZz4EQA/
         yXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z9/EWXbo0V6at54tAlhdI4wyS4NCBT/wOp5hrpHiWUE=;
        b=moMck9kILdqsdFdiQSDFksckauevtyU1zBdJBJS5iwTLa8T9N/BSU8SJcbn7+ED9HP
         glAYqQGUfut3BcQe8D8l0Wauw/x5xKUPsgUDEElUdOKwHjCUlYjFT6IlUUbaFVUmwAO4
         kf5zp9elTJJe+m//E/teFlSKm2KfFNVNCgW3JfBuAnnWzreuDjWtlLOyUadl/8HkEzdI
         eEv8jfzK/CSpSqrTASTKsQQuyZL6FCrwWwD6n0sy4kjrTzOgmAwkmcnAATNR3p0vwILL
         rX7txJBTlNoos0OD5wbhkoUBFHS9a2cw8jVz6Cu56rt3+HBQQiGJqlCvd7YodCbFYJLf
         q3/w==
X-Gm-Message-State: AOAM530d0mPtWVJrCVGN2OiZ4IdGfWW8XEa53jaA5OoR6ftch026e+jU
	YfFkmEb7rPvSpGqyFgQ+PKwIioBB0uD9Lw==
X-Google-Smtp-Source: ABdhPJyn0WMsis/DBlYa8lYJ0cmmgbHFEXsvZPR6qS6L03ayQ/rtk6cQUuHNdtuaCn944XOz8z/8AA==
X-Received: by 2002:a5d:64e5:0:b0:1fb:5b9a:1a20 with SMTP id g5-20020a5d64e5000000b001fb5b9a1a20mr1834007wri.34.1646669738693;
        Mon, 07 Mar 2022 08:15:38 -0800 (PST)
Received: from [10.44.1.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id w6-20020adfee46000000b001e4bf01bdfbsm11651977wro.46.2022.03.07.08.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 08:15:38 -0800 (PST)
Message-ID: <6cd72c86-9c11-7610-d140-390d2388674f@tessares.net>
Date: Mon, 7 Mar 2022 17:15:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v6 4/4] selftests: bpf: add skc_to_mptcp_sock
 test
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1646528337.git.geliang.tang@suse.com>
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
 <4b248f07-d749-400a-ff81-4f08a12c7814@tessares.net>
 <20220307155851.GA20573@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220307155851.GA20573@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/03/2022 16:58, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, Mar 07, 2022 at 03:15:46PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 06/03/2022 02:01, Geliang Tang wrote:
>>> This patch extended the MPTCP test base, to exercise bpf_skc_to_mptcp_sock()
>>> from C test as Alexei suggested in v3.
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>>  tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 +++++
>>>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 +++++++++++++++----
>>>  tools/testing/selftests/bpf/progs/mptcp.c     | 23 ++++++++++++++++
>>>  3 files changed, 51 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
>>> index b1ede6f0b821..05f62f81cc4d 100644
>>> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
>>> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
>>> @@ -83,6 +83,12 @@ struct tcp_sock {
>>>  	__u64	tcp_mstamp;	/* most recent packet received/sent */
>>>  } __attribute__((preserve_access_index));
>>>  
>>> +struct mptcp_sock {
>>> +	struct inet_connection_sock	sk;
>>> +
>>> +	__u32	token;
>>> +} __attribute__((preserve_access_index));
>>
>> Is it really OK to do that when 'struct mptcp_sock' is not declared in
>> the 'include' directory?
>> I guess the compiler can find where 'struct mptcp_sock' is actually
>> defined but I'm surprised it doesn't need more assistance here.
> 
> Without this struct mptcp_sock declaration, we'll get the following build
> errors:

I agree that we need it. But I was just surprised GCC/CLang knows the
'token' entry is not available at:

    [mptcp_sock address] + sizeof(struct inet_connection_sock)

like we could think it is when reading this structure here but instead
it is available at:

    [mptcp_sock address] + proper 'offsetof'

by looking at the structure defined in net/mptcp/protocol.h.

So good to know the "preserve_access_index" attribute works very well :)

>> In your tests, did you check that the token seen in the kernel --
>> outside the BPF part but in MPTCP code -- is the same as what the
>> userspace program can see after a capture from BPF side? I mean: the
>> current test only check the token is different from 0 but it could also
>> be set at a wrong value (any random value except 0) and we would not
>> notice the issue, no?
> 
> Yes, in my tests, the token in the userspace (both bpf and ip mptcp monitor)
> is the same as it printed in the kernel:
> 
>> sudo dmesg | grep mptcp_sock
> [ 3057.842339] bpf_mptcp_sock_from_subflow sk=000000004370e862 sk_fullsock=1 sk_protocol=1 sk_is_mptcp=1
> [ 3057.842341] bpf_mptcp_sock_from_subflow subflow->conn=00000000f16c62fd msk=00000000f16c62fd token=3420716048
> 
> # cat /sys/kernel/debug/tracing/trace_pipe
>       test_progs-22898   [007] d..21  3057.858031: bpf_trace_printk: is_mptcp=0 token=0(0x0)
>       test_progs-22898   [007] d..21  3057.872544: bpf_trace_printk: is_mptcp=1 token=3420716048(0xcbe3fc10)

(detail: maybe good to use "token=0x%x" instead of using "%u" in your
bpf_trace_printk's format you added in
tools/testing/selftests/bpf/progs/mptcp.c)


>> sudo ip mptcp monitor
> [       CREATED] token=cbe3fc10 remid=0 locid=0 saddr4=127.0.0.1 daddr4=127.0.0.1 sport=54646 dport=60123
> [       CREATED] token=68f336ad remid=0 locid=0 saddr4=127.0.0.1 daddr4=127.0.0.1 sport=60123 dport=54646
> [        CLOSED] token=cbe3fc10

Great, thank you for having checked!


>>> +		storage = bpf_sk_storage_get(&socket_storage_map, msk, 0,
>>> +					     BPF_SK_STORAGE_GET_F_CREATE);
>>> +		if (!storage)
>>> +			return 1;
>>> +
>>> +		storage->invoked++;
>>> +		storage->token = msk->token;
>>
>> Linked to my previous comment about checking if 'token' had the right
>> value: it is not enough to compare this 'msk->token' printed with
>> 'bpf_trace_printk' here below with the value you have in
>> 'prog_tests/mptcp.c' because it is supposed to be the same one if the
>> BPF MAP storage does its job (I guess it does).
>>
>> Instead, we should compare with either what you can see with 'ss' or 'ip
>> mptcp monitor' or with the code in 'net/mptcp/' dir (pr_debug's print it
>> at some points I guess). But doing that is not enough: that will not be
>> part of the automated tests, just a manual check. But still good to do :)
>>
>> My point is that the token is supposed to be random: if you read the
>> wrong address in the memory, it will also appear as a random value
>> because it is unlikely to read '0'.
> 
> I did these manual checks. The all token values are the same in both
> user space and kernel space. I'll try to add the automated check in the
> next version, using netlink (like 'ip mptcp monitor') to get the token
> values from kernel space, and compare it in bpf.

That would be nice but hopefuly not too complex. It can also be done in
an additional patch.

> 
>>
>> Maybe it would be good to also check other values from 'mptcp_sock'. But
>> I don't know which one can be known in advanced in this structure appart
>> from booleans: fully_established, cork, etc. But I guess we should avoid
>> using booleans: one bit, we could be lucky to have the good value.
>>
>> Or maybe interesting to use 'struct sock *first' (or *last_snd or
>> *subflow)? I mean it would be a good test case to keep a ref to a
>> subflow. Then from the userspace, we could get info from the MSK and
>> then get info about the subflow.
>> But I don't know if it is possible: typically from the usespace, we get
>> a sk from a fd. Can we get a sk from its pointer?
>> I guess it will be needed to iterate over the different subflows from a msk.
> 
> I'll try to check other more 'mptcp_sock' members later.

Thanks!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
