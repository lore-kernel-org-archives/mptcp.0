Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C658480
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:13:44 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso5190025e9.2
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684916022; x=1687508022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFfkfvhARZTdqdRKqrM2YS0OetAqaqZ3tyugeHQj9aM=;
        b=uD+m2Z9IpNeG/zbYtya47Nn/T56Mvx1KBRzSMO1r3PnOg3jI9e+wWjXFiQLzGR6BYk
         aIxtzrONLaQrojSLVHfBYIv2tgUC4+L+Wrw43Abwv31V9FgJNwzaQeb5QLUrTa7VbotB
         33IVt4BLLb2PnbMEEAcYBTOTCWIh7DhcaFI6Cc6oC9K1lRzvz1wQSyR2b+hfSQLshTJx
         s4xB+cc4rMkXXPYumkvh9WzAFNFaR/VCPQuTniRjRGzmu/3CsBeW4a1CKwocMMH6TFbt
         h5eoq5XMYWasFADy33DZidAieUJYz1fKLvbtwMcsq5FUMFb9ZaWT4nT2dFULBh/XAgT9
         4dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916022; x=1687508022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFfkfvhARZTdqdRKqrM2YS0OetAqaqZ3tyugeHQj9aM=;
        b=P6BrVzO02KTPnL8M6ZNq16TzMDi5YiPDIqVULayRZ6HipZESX/3lYMdo9MgRtxJEYi
         /UlEhLSxpQCIugHIi9UNMhtpliqSA70SkDWt1WFUqRY+yJFSD5yDdaWLvF8XvbEH2w7a
         eFKJYL/JmSogxHNXufbfloVsDYN02BwtLvFrhJS/zXLKIcNlqFAHsJ6mTjdrv5iS8Jh3
         aUReVosJt8cR1nwEGFoqTA/FQBZxx1z7dX7BDGqnEf/6/yZ94CF/uklL+oW5LnquP6Pk
         YvsbTdMTuowYoTG1WuDLka14zKTbXcVs2g4UsYQXspA1MwMXFNu128a/9TCDa58fNI24
         RbaQ==
X-Gm-Message-State: AC+VfDzDOUHVn7ZEuvzj8wih5th0luPz6gRo+QJzbJEWzetPeR/Eacuj
	ZVrlB2TQ0XKXnajybLFarWY5y6MgOsMlKFVFk8dbwA==
X-Google-Smtp-Source: ACHHUZ4CpA9aiSkL3Tv9LOlIpqM1WDVifiH1YnF2rJrBGrGW9Spf80wY87kSdkhk1y8fvA2Qw+AWeA==
X-Received: by 2002:a7b:c858:0:b0:3f6:683:628b with SMTP id c24-20020a7bc858000000b003f60683628bmr6129110wml.3.1684916022125;
        Wed, 24 May 2023 01:13:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id f4-20020a1c6a04000000b003f1978bbcd6sm5986214wmc.3.2023.05.24.01.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:13:41 -0700 (PDT)
Message-ID: <fe2191fe-6842-7662-d300-0aa88cdb9827@tessares.net>
Date: Wed, 24 May 2023 10:13:41 +0200
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
To: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
 <ZG0FL9XM-MFgfyQ-@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ZG0FL9XM-MFgfyQ-@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

Thank you for your nice review!

On 23/05/2023 20:25, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>> Some user-space applications want to monitor the subflows utilization.
>>
>> Dumping the per subflow tcp_info is not enough, as the PM could close
>> and re-create the subflows under-the-hood, fooling the accounting.
>> Even checking the src/dst addresses used by each subflow could not
>> be enough, because new subflows could re-use the same address/port of
>> the just closed one.
>>
>> This patch introduces a new socket option, allow dumping all the relevant
>> information all-at-once (everything, everywhere...), in a consistent manner.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v2 -> v3:
>>  - added missing changelog (oops)
>> ---
>>  include/uapi/linux/mptcp.h | 16 ++++++++
>>  net/mptcp/sockopt.c        | 75 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 91 insertions(+)
>>
>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>> index 32af2d278cb4..f4f42d88e58b 100644
>> --- a/include/uapi/linux/mptcp.h
>> +++ b/include/uapi/linux/mptcp.h
>> @@ -12,6 +12,7 @@
>>  #include <linux/in.h>		/* for sockaddr_in			*/
>>  #include <linux/in6.h>		/* for sockaddr_in6			*/
>>  #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
>> +#include <linux/tcp.h>		/* for tcp_info				*/
>>  
>>  #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
>>  #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
>> @@ -244,9 +245,24 @@ struct mptcp_subflow_addrs {
>>  	};
>>  };
>>  
>> +struct mptcp_subflow_info {
>> +	__u32				id;
>> +	struct mptcp_subflow_addrs	addrs;
>> +};
>> +
>> +/* struct subflow_info is not supposed nor allowed to grow in
>> + * future versions.
>> + * If need will arise, a new socket option should be added.
>> + */
>> +struct mptcp_subflow_full_info {
>> +	struct mptcp_subflow_info	subflow_info;
>> +	struct tcp_info			tcp_info;
>> +};
> 
> I dislike this constraint.
> 
> Why not do something like this:
> 
> struct mptcp_subflow_full_info {

(If we add mptcp_info (cf Paolo's email), better to strip 'subflow')

> 	__u32		size_subflow_full_info;         /* size of this structure in userspace */

Why do we need this field? Can we not use the option length (int __user
*optlen) provided by the userspace?

> 	__u32           num_subflows_user;              /* max subflows that userspace is interested in */
> 	__u32           num_subflows_kern;              /* must be 0, set by kernel (real subflow count) */
> 	__u32		num_subflows_copied;		/* must be 0, set by kernel (number of subflow infos copied back)
>         __u32           size_sfinfo_kernel;		/* must be 0, set by kernel */
>         __u32           size_sfinfo_user;
>         __u32           size_tcpinfo_kernel;            /* must be 0, set by kernel */
>         __u32           size_tcpinfo_user;

Do we need to have the kernel and user size in different fields?
Is it not enough have:

  num_subflows;          /* will be set by the kernel */
  num_subflows_copied;   /* max for the user, kernel put what it did */
  size_sfinfo;           /* user set it, kernel put what it used: min */
  size_tcpinfo;          /* same */

> 	__aligned_u64	subflow_info_addr;
> 	__aligned_u64	tcp_info_addr;
> };
> 
> userspace does:
> 
> x = calloc(sizeof(struct mptcp_subflow_info), 42);
> y = calloc(sizeof(struct tcp_info), 42);
> 
> struct mptcp_subflow_full_info {
> 	.size_subflow_full_info = sizeof(struct mptcp_subflow_full_info),
> 	.num_subflows_user = 42,
> 	.size_sfinfo_user = sizeof(struct mptcp_subflow_info),
> 	.size_tcpinfo_user = sizeof(struct mptcp_subflow_info),
> 	.subflow_info_addr = (u64)x,
> 	.tcp_info_addr = (u64)y,
> };
> 
> kernel does:
> 1. put_user() the real sizes uses by the kernel
> 2. put_user() the real subflow count
> 3. copy subflow_info_addr and tcp_info_addr addresses
> 4. treat as userspace pointers
> 
> for each subflow, copy tcpinfo and subflow info to the
> two arrays provided by userspace.
> 
> Kernel truncates copied data via size_sfinfo_user/size_tcpinfo_user so
> that new kernel won't populate fields that don't exist in userspace.
> 
> Kernel stops copying after 'num_subflows_user' or 'num_subflows_kern',
> whatever comes first and updates num_subflows_copied to the real copied
> value.
> 
> This allows userspace to discover when kernel had more subflows
> but could not place the data due to lack of space in the
> userspace-provided arrays.
> 
> This is more complicated but no need to add new MPTCP_FULL_INFO_V2/V3/V4
> etc. in the future.

If we add mptcp_info structure as mentioned by Paolo, we are getting
very close the the getsockopt(MPTCP_INFO) from the fork kernel, see the
section "Get detailed information of your subflows":

https://multipath-tcp.org/pmwiki.php/Users/ConfigureMPTCP

And the kernel header:

https://github.com/multipath-tcp/mptcp/blob/mptcp_trunk/include/uapi/linux/tcp.h#L321-L366

> What do you think?

If we want to be even more future prove, why not having something more
flexible where the userspace puts flags of what it wants and then there
is a kind of TLV structure? Maybe it would be too complex to read/write?


  struct mptcp_tlv_info {
      __u32 type;
      __u32 length;
      __aligned_u64 value;
  };

  struct mptcp_full_info {
      __u32 flags;
      __u32 num_subflows;
      __u32 num_subflows_copied;
      struct mptcp_tlv_info[];   /* number has to be linked to flags */
  };


Maybe it would be good to add a size for the subflow info structure: if
we use such TLV structure, for info around subflows, we will need to set
at least the ID for each subflow (maybe more later). We might then need:

  struct mptcp_full_info {
      (...)
      __u32 size_mptcp_subflow_info;
      (...)
  };

  struct mptcp_subflow_info {
      __u32 id;
  };

  struct mptcp_subflow_addrs {
      struct mptcp_subflow_info  info;
      struct mptcp_subflow_addrs addrs;
  };

  struct mptcp_subflow_tcp_info {
      struct mptcp_subflow_info info;
      struct tcp_info           tcp_info;
  };

Again, just a quick idea, I didn't investigate more. With that, we will
likely not need more getsockopt() to get info about the MPTCP connection
and its subflows, just an all in one getsockopt().

I'm just trying to reacting quickly before going into a direction :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
