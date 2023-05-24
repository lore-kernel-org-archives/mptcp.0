Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841828480
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:16:51 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso6005335e9.0
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684916209; x=1687508209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Si0F4115Xg27aZ/7QK9dStbPwa+29SVqS6Mq6xzUQe4=;
        b=qyiU4hlnLQ2ReV24Snp3FBA2cBaxADcNEdau8eWG9fkflzajKE/iwZTpxJydgZMYoL
         Pu7gaTyZT1Y368F8yHWg+difXBChBkN3bqZ+3N1ZWQ751ha7MHORV4n4sbSESGEEj4YS
         v8lDnuOJdU9oig5wwE326PW8YJEN7NKBdcezxtt/0h2JvhqE6VzglW8vPj1oamb//Xu+
         EcgGrj3JU2VGR4jGKRJkOf273yCqLX+yRGRTw0zaHt0ElbvalmIN2Pi9duuiwghSlEDr
         7wQi6E7OgxvKJ/xWPzVkvCuNJGg1wAdn8nPdKvSELDbak2CsOJec5fIxE1aiHQA4sfW3
         YAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916209; x=1687508209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Si0F4115Xg27aZ/7QK9dStbPwa+29SVqS6Mq6xzUQe4=;
        b=SoNFkVzHONGhYkvIJK3whpC5KSQ/h1VkTnTUfTCJbO+KPD2IhYk+aq8g/6oTSTEe+b
         VeywQsW0eLmPFg+moH8h1tymS02l9as8Fs9tmpnN2IEayyE3Cl0l+LIjeIa0H+MBkbTC
         CzuVVataJcNHBPsWNhNMMsjeLrVjZ0o1be+6anH6wW76kGytcUmUEjt7ebNJ6Pr/5LvF
         wCt54jxXUzx0hsmmoSLvN/S1Z7bbmsPK4bx5kRg4NvjD5WSaBNzBF43dY2wXUqWYK1Pi
         gxL4Azq5bZbbjNlg5ERaChb3qz4VKIWGRbr882ko8fbUR+SD2znX7BozxDD2CopItTUH
         lJ7A==
X-Gm-Message-State: AC+VfDyGhpYqT1a6R0qaMFJ6fy8FyCMbiiIVUKRJ1PaIQyo1G+hoNMQ4
	Z2+KUxQZqBYeYbvrOm3xkr5zlQ==
X-Google-Smtp-Source: ACHHUZ46bqMqjUrvaJp0aCqgcb2NnnlR89sCE7h/v68r0JY5Vwykk04tJ2aUDyxgb3ROaNocT+lrmg==
X-Received: by 2002:a05:600c:2295:b0:3f6:795:6d1c with SMTP id 21-20020a05600c229500b003f607956d1cmr5659337wmf.4.1684916209551;
        Wed, 24 May 2023 01:16:49 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bcc10000000b003f60fb2addbsm1443665wmh.44.2023.05.24.01.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:16:49 -0700 (PDT)
Message-ID: <b507982c-6595-9115-88b4-66e1d9939cba@tessares.net>
Date: Wed, 24 May 2023 10:16:48 +0200
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
 <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
 <d48dcb197962141d36529c16f6bb365d4599846f.camel@redhat.com>
 <f21e784f-8c97-f876-848b-f909d4e1daf0@tessares.net>
 <b2db55ec8e8aaf06b562236150c4f111e38f6f21.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b2db55ec8e8aaf06b562236150c4f111e38f6f21.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/05/2023 10:11, Paolo Abeni wrote:
> On Wed, 2023-05-24 at 09:36 +0200, Matthieu Baerts wrote:
>> Hi Paolo, Florian,
>>
>> On 24/05/2023 08:36, Paolo Abeni wrote:
>>> On Wed, 2023-05-24 at 08:34 +0200, Paolo Abeni wrote:
>>>> On Tue, 2023-05-23 at 20:25 +0200, Florian Westphal wrote:
>>>>> Paolo Abeni <pabeni@redhat.com> wrote:
>>>>>> Some user-space applications want to monitor the subflows utilization.
>>>>>>
>>>>>> Dumping the per subflow tcp_info is not enough, as the PM could close
>>>>>> and re-create the subflows under-the-hood, fooling the accounting.
>>>>>> Even checking the src/dst addresses used by each subflow could not
>>>>>> be enough, because new subflows could re-use the same address/port of
>>>>>> the just closed one.
>>>>>>
>>>>>> This patch introduces a new socket option, allow dumping all the relevant
>>>>>> information all-at-once (everything, everywhere...), in a consistent manner.
>>>>>>
>>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>>> ---
>>>>>> v2 -> v3:
>>>>>>  - added missing changelog (oops)
>>>>>> ---
>>>>>>  include/uapi/linux/mptcp.h | 16 ++++++++
>>>>>>  net/mptcp/sockopt.c        | 75 ++++++++++++++++++++++++++++++++++++++
>>>>>>  2 files changed, 91 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>>>>>> index 32af2d278cb4..f4f42d88e58b 100644
>>>>>> --- a/include/uapi/linux/mptcp.h
>>>>>> +++ b/include/uapi/linux/mptcp.h
>>>>>> @@ -12,6 +12,7 @@
>>>>>>  #include <linux/in.h>		/* for sockaddr_in			*/
>>>>>>  #include <linux/in6.h>		/* for sockaddr_in6			*/
>>>>>>  #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
>>>>>> +#include <linux/tcp.h>		/* for tcp_info				*/
>>>>>>  
>>>>>>  #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
>>>>>>  #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
>>>>>> @@ -244,9 +245,24 @@ struct mptcp_subflow_addrs {
>>>>>>  	};
>>>>>>  };
>>>>>>  
>>>>>> +struct mptcp_subflow_info {
>>>>>> +	__u32				id;
>>>>>> +	struct mptcp_subflow_addrs	addrs;
>>>>>> +};
>>>>>> +
>>>>>> +/* struct subflow_info is not supposed nor allowed to grow in
>>>>>> + * future versions.
>>>>>> + * If need will arise, a new socket option should be added.
>>>>>> + */
>>>>>> +struct mptcp_subflow_full_info {
>>>>>> +	struct mptcp_subflow_info	subflow_info;
>>>>>> +	struct tcp_info			tcp_info;
>>>>>> +};
>>>>>
>>>>> I dislike this constraint.
>>>>>
>>>>> Why not do something like this:
>>>>>
>>>>> struct mptcp_subflow_full_info {
>>>>> 	__u32		size_subflow_full_info;         /* size of this structure in userspace */
>>>>> 	__u32           num_subflows_user;              /* max subflows that userspace is interested in */
>>>>> 	__u32           num_subflows_kern;              /* must be 0, set by kernel (real subflow count) */
>>>>> 	__u32		num_subflows_copied;		/* must be 0, set by kernel (number of subflow infos copied back)
>>>>>         __u32           size_sfinfo_kernel;		/* must be 0, set by kernel */
>>>>>         __u32           size_sfinfo_user;
>>>>>         __u32           size_tcpinfo_kernel;            /* must be 0, set by kernel */
>>>>>         __u32           size_tcpinfo_user;
>>>>> 	__aligned_u64	subflow_info_addr;
>>>>> 	__aligned_u64	tcp_info_addr;
>>>>> };
>>>>>
>>>>> userspace does:
>>>>>
>>>>> x = calloc(sizeof(struct mptcp_subflow_info), 42);
>>>>> y = calloc(sizeof(struct tcp_info), 42);
>>>>>
>>>>> struct mptcp_subflow_full_info {
>>>>> 	.size_subflow_full_info = sizeof(struct mptcp_subflow_full_info),
>>>>> 	.num_subflows_user = 42,
>>>>> 	.size_sfinfo_user = sizeof(struct mptcp_subflow_info),
>>>>> 	.size_tcpinfo_user = sizeof(struct mptcp_subflow_info),
>>>>> 	.subflow_info_addr = (u64)x,
>>>>> 	.tcp_info_addr = (u64)y,
>>>>> };
>>>>>
>>>>> kernel does:
>>>>> 1. put_user() the real sizes uses by the kernel
>>>>> 2. put_user() the real subflow count
>>>>> 3. copy subflow_info_addr and tcp_info_addr addresses
>>>>> 4. treat as userspace pointers
>>>>>
>>>>> for each subflow, copy tcpinfo and subflow info to the
>>>>> two arrays provided by userspace.
>>>>>
>>>>> Kernel truncates copied data via size_sfinfo_user/size_tcpinfo_user so
>>>>> that new kernel won't populate fields that don't exist in userspace.
>>>>>
>>>>> Kernel stops copying after 'num_subflows_user' or 'num_subflows_kern',
>>>>> whatever comes first and updates num_subflows_copied to the real copied
>>>>> value.
>>>>>
>>>>> This allows userspace to discover when kernel had more subflows
>>>>> but could not place the data due to lack of space in the
>>>>> userspace-provided arrays.
>>>>>
>>>>> This is more complicated but no need to add new MPTCP_FULL_INFO_V2/V3/V4
>>>>> etc. in the future.
>>>>>
>>>>> What do you think?
>>>>
>>>> I ended-up with the current code trying to re-use as much as possible
>>>> from the existing infra - specifically the
>>>> mptcp_get_subflow_data()/mptcp_put_subflow_data() helpers.
>>>>
>>>> I agree the constraint on mptcp_subflow_full_info is not nice,
>>>> especially if we want to include subflow level indormation alike
>>>> local/remote address id, flags, etc...
>>>>
>>>> Isn't num_subflows_copied always implied? == min(num_subflows_user,
>>>> num_subflows_kern).
>>>>
>>>> Otherwise LGTM, I'll try to have a spin.
>>>
>>> Oops, I forgot... should mptcp_subflow_full_info contain mptcp_info,
>>> too?
>>
>> Good point. Indeed I guess it is very likely someone who want info about
>> MPTCP subflow will also want info about the MPTCP connection.
>>
>>> Overall layout:
>>>
>>> struct mptcp_subflow_full_info {
>>> 	__u32		size_subflow_full_info;         /* size of this structure in userspace */
>>> 	__u32           num_subflows_user;              /* max subflows that userspace is interested in */
>>> 	__u32           num_subflows_kern;              /* must be 0, set by kernel (real subflow count) */
>>>         __u32           size_sfinfo_kernel;		/* must be 0, set by kernel */
>>>         __u32           size_sfinfo_user;
>>>         __u32           size_tcpinfo_kernel;            /* must be 0, set by kernel */
>>>         __u32           size_tcpinfo_user;
>>> 	__aligned_u64	subflow_info_addr;
>>> 	__aligned_u64	tcp_info_addr;
>>> 	struct mptcp_info mptcp_indo;
>>
>> I guess you will need a size for the mptcp_info structure, no?
>>
>> Maybe this should come before the previous ones?
> 
> I'm coding the thing right now: it turns out we are better of not
> including mptcp_info inside mptcp_subflow_full_info, so the
> manipulation schema will look alike the exiting
> mptcp_{get,put}_subflow_data().

(if you are coding this right now, and also linked to my previous email,
we can also continue the discussion on IRC if it is easier for you :) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
