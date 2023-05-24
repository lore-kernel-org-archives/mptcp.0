Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB73C159
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 09:12:31 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so40442775e9.0
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684919549; x=1687511549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsqFrWFSmSS1D5kxFJrrExiTcbGbT8ebRIxM4nomNJo=;
        b=5A95+kw2fb2QGq1/2FVqsE/QGWTdDEgN7/qk6WhmfRnUSRboGsJT/+VbaOs8NI2DRd
         ppgW2kzCb210HT/N4K76QEQyTLpU9MueNmjtusM0HZW3Yc5zWXvzFYxI9zkO1r52rKZY
         s0Qf7odDT4bvkTEYimdY22SEU8OfL5A2mT4Ydo/K+jJM8SSR1KOSgC0MwpjnHEoUcS9B
         liCkz8ymFyGA8rhSFjLICtLr8auqccIQYUkuhQRdzGqAYhjS1KFhDqJq/FPbl30XORT7
         EAgKu0ok9G8AI9MaYDz7+bmtbs2CiKNEeaP1KfjfcSAR4ZzNRfD1mfcwSGS954My8lRF
         YeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684919549; x=1687511549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsqFrWFSmSS1D5kxFJrrExiTcbGbT8ebRIxM4nomNJo=;
        b=Gp9HEHOd2Ab/dAQmyFBcWNrbG1C+HwESf7S0JMoQU3Z8xc6Rqhk6wMcMuqtNL1Izey
         7X+nTwgeeMooMDbxNK/84lsE2BqyeDjU9Wtl4lnpMJArseh273s/OxpqD86PdH17Hk5k
         49dB3n3g6mfXtkinIUTY5uRav3yNCUS4W2b56PnybFekQQ8Dw6TWV+r1PQ+gbwdpmG8L
         nr5jlrDWB7ijkvCI59IRy32aAvxnR4fwEiVL6+QzkbNXvA+eb4aAE2BU5gs6JHj3i9Qd
         UuslADxN8aOCzH2oW5M3yfLSEqOUaXHIy1mJKHCiaocyhNZBVJIII37wD8qgWYtc4W8c
         MufA==
X-Gm-Message-State: AC+VfDyVp+gvsvBcCml5v5ROnhLs5h/d4FKS/2gCpd3jGYlNPrwCu/8/
	gUItf7OXVbNx5oJi0QooDfL8Zw==
X-Google-Smtp-Source: ACHHUZ5Vpx6pi+8ZKvoZAn2kD/LVXbWzvgUL1DMd69P/+AsyXzSS6l73C674vgKXNkWFShrL6psiog==
X-Received: by 2002:a7b:ca44:0:b0:3f4:e432:7589 with SMTP id m4-20020a7bca44000000b003f4e4327589mr12625454wml.10.1684919549083;
        Wed, 24 May 2023 02:12:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003f50e88ffc1sm1704423wmr.0.2023.05.24.02.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 02:12:28 -0700 (PDT)
Message-ID: <f77041ac-3d88-5f67-4231-91095848a3c8@tessares.net>
Date: Wed, 24 May 2023 11:12:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
 <ZG0FL9XM-MFgfyQ-@strlen.de>
 <fe2191fe-6842-7662-d300-0aa88cdb9827@tessares.net>
 <af0b81822ea9a84da672c2f206e9c1635e57fb65.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <af0b81822ea9a84da672c2f206e9c1635e57fb65.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/05/2023 10:53, Paolo Abeni wrote:
> On Wed, 2023-05-24 at 10:13 +0200, Matthieu Baerts wrote:
>> Hi Florian,
>>
>> Thank you for your nice review!
>>
>> On 23/05/2023 20:25, Florian Westphal wrote:
>>> Paolo Abeni <pabeni@redhat.com> wrote:
>>>> Some user-space applications want to monitor the subflows utilization.
>>>>
>>>> Dumping the per subflow tcp_info is not enough, as the PM could close
>>>> and re-create the subflows under-the-hood, fooling the accounting.
>>>> Even checking the src/dst addresses used by each subflow could not
>>>> be enough, because new subflows could re-use the same address/port of
>>>> the just closed one.
>>>>
>>>> This patch introduces a new socket option, allow dumping all the relevant
>>>> information all-at-once (everything, everywhere...), in a consistent manner.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>> v2 -> v3:
>>>>  - added missing changelog (oops)
>>>> ---
>>>>  include/uapi/linux/mptcp.h | 16 ++++++++
>>>>  net/mptcp/sockopt.c        | 75 ++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 91 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>>>> index 32af2d278cb4..f4f42d88e58b 100644
>>>> --- a/include/uapi/linux/mptcp.h
>>>> +++ b/include/uapi/linux/mptcp.h
>>>> @@ -12,6 +12,7 @@
>>>>  #include <linux/in.h>		/* for sockaddr_in			*/
>>>>  #include <linux/in6.h>		/* for sockaddr_in6			*/
>>>>  #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
>>>> +#include <linux/tcp.h>		/* for tcp_info				*/
>>>>  
>>>>  #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
>>>>  #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
>>>> @@ -244,9 +245,24 @@ struct mptcp_subflow_addrs {
>>>>  	};
>>>>  };
>>>>  
>>>> +struct mptcp_subflow_info {
>>>> +	__u32				id;
>>>> +	struct mptcp_subflow_addrs	addrs;
>>>> +};
>>>> +
>>>> +/* struct subflow_info is not supposed nor allowed to grow in
>>>> + * future versions.
>>>> + * If need will arise, a new socket option should be added.
>>>> + */
>>>> +struct mptcp_subflow_full_info {
>>>> +	struct mptcp_subflow_info	subflow_info;
>>>> +	struct tcp_info			tcp_info;
>>>> +};
>>>
>>> I dislike this constraint.
>>>
>>> Why not do something like this:
>>>
>>> struct mptcp_subflow_full_info {
>>
>> (If we add mptcp_info (cf Paolo's email), better to strip 'subflow')
>>
>>> 	__u32		size_subflow_full_info;         /* size of this structure in userspace */
>>
>> Why do we need this field? Can we not use the option length (int __user
>> *optlen) provided by the userspace?
> 
> With this we can append arbitrary/variable size mptcp_info at the end.

I guess either we use a dedicated field for mptcp_info or we infer its
value by looking at size_full_info or optlen. It looks clearer to me
from the userspace point of view to have a dedicated size for mptcp_info
than giving twice sizeof(mptcp_subflow_tcp_info) but I'm probably
missing something :)

>>> 	__u32           num_subflows_user;              /* max subflows that userspace is interested in */
>>> 	__u32           num_subflows_kern;              /* must be 0, set by kernel (real subflow count) */
>>> 	__u32		num_subflows_copied;		/* must be 0, set by kernel (number of subflow infos copied back)
>>>         __u32           size_sfinfo_kernel;		/* must be 0, set by kernel */
>>>         __u32           size_sfinfo_user;
>>>         __u32           size_tcpinfo_kernel;            /* must be 0, set by kernel */
>>>         __u32           size_tcpinfo_user;
>>
>> Do we need to have the kernel and user size in different fields?
> 
> If we keep, we can re-use the existing code to manipulate this struct.
> Also is consistent with other socket option.

If we don't need them, we don't need to be consistent, especially if we
plan to deprecate the MPTCP_TCP_INFO and MPTCP_SUBFLOW_ADDRS sockopt at
some points :)

But if it allows to re-use the existing code and not deprecate the two
sockopt, I understand we want to do that!

>>> This is more complicated but no need to add new MPTCP_FULL_INFO_V2/V3/V4
>>> etc. in the future.
>>
>> If we add mptcp_info structure as mentioned by Paolo, we are getting
>> very close the the getsockopt(MPTCP_INFO) from the fork kernel, see the
>> section "Get detailed information of your subflows":
>>
>> https://multipath-tcp.org/pmwiki.php/Users/ConfigureMPTCP
>>
>> And the kernel header:
>>
>> https://github.com/multipath-tcp/mptcp/blob/mptcp_trunk/include/uapi/linux/tcp.h#L321-L366
>>
>>> What do you think?
>>
>> If we want to be even more future prove, why not having something more
>> flexible where the userspace puts flags of what it wants and then there
>> is a kind of TLV structure? Maybe it would be too complex to read/write?
>>
>>
>>   struct mptcp_tlv_info {
>>       __u32 type;
>>       __u32 length;
>>       __aligned_u64 value;
>>   };
>>
>>   struct mptcp_full_info {
>>       __u32 flags;
>>       __u32 num_subflows;
>>       __u32 num_subflows_copied;
>>       struct mptcp_tlv_info[];   /* number has to be linked to flags */
>>   };
>>
>> Maybe it would be good to add a size for the subflow info structure: if
>> we use such TLV structure, for info around subflows, we will need to set
>> at least the ID for each subflow (maybe more later). We might then need:
>>
>>   struct mptcp_full_info {
>>       (...)
>>       __u32 size_mptcp_subflow_info;
>>       (...)
>>   };
>>
>>   struct mptcp_subflow_info {
>>       __u32 id;
>>   };
>>
>>   struct mptcp_subflow_addrs {
>>       struct mptcp_subflow_info  info;
>>       struct mptcp_subflow_addrs addrs;
>>   };
>>
>>   struct mptcp_subflow_tcp_info {
>>       struct mptcp_subflow_info info;
>>       struct tcp_info           tcp_info;
>>   };
>>
>> Again, just a quick idea, I didn't investigate more. With that, we will
>> likely not need more getsockopt() to get info about the MPTCP connection
>> and its subflows, just an all in one getsockopt().
>>
>> I'm just trying to reacting quickly before going into a direction :)
> 
> Uhm... I think TLV are not in the right direction: away from the
> current convention for variable size/changing struct. If use TLV we
> could as well move to NL, which will be again inconsistent to fetch
> such kind of info IMHO.
> 
> I think it's preferable to keep the sockopt API self-consistent then be
> aligned with out-of-tree.
> 
> The layout proposed by Florian fits what we already have.
> 
> With some little field re-order I can avoid code duplication to
> parse/store the initial header.

I see, thank you for the explanation!

I was suggesting the TLV structure because maybe the userspace doesn't
need everything, e.g. the different addresses, maybe just the ID per
subflow is enough? But because we only copy info and we don't compute
stuff, it is fine to receive everything.

Also the other advantage is to be able to get more info but I suppose we
can:
- add more stuff in mptcp_info for the MPTCP connection
- add more stuff in mptcp_subflow_info for per subflow info.

So as long as we keep a "generic" subflow info structure like you did in
your patch v3 2/6 and not specific to the addresses only, I think
indeed, we don't need TLVs.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
