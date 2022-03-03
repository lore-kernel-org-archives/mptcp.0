Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03417A
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 09:55:38 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id qx21so9370667ejb.13
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 01:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qir8l1eLpsJ5ofb7o5B3fxPqMLB1uKirtE1KlOegA3M=;
        b=scwN/SgqKLe+7pJhNq0tWlniu0F0AWMH8wyLWTDkwQ+yp/O5Y6oOuWpur8owOZn1Q4
         7NKRre7PzYmh/NWzqdkRQc4WMdLnuWyxkJKrmhBvUDGhrdea8ri6ZGn2ja2ty9Ikv/rI
         5Ui+fWlZZr/sZOX1wbtD2tCnVJ4fDK6ztwKE0WIoIPiT7WgVB8x3uOy2aLLIMucCEBg1
         STM2nqt2U8ZqPft8W4fAK9E6MhBpEqYyy2lyLtowZbFX2lruji9C40RVTMObJpbOqiE1
         Ohah+u+yK1gVWrnZcSZF8vufFPgwe14vd+qIenZHSmkDoQc23Yq9Ae3WxOr+Zfs0F3+p
         T2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qir8l1eLpsJ5ofb7o5B3fxPqMLB1uKirtE1KlOegA3M=;
        b=yKTpEjbh8syBdCQbPoC58ahW5eAsOmq5ZnW3d53fURxKxKXaSE9KsL8crq3J6k3sSr
         YeqoJjkuwuOMd6yNW0ponGn5IXgPtim5D9Jt45S5Hg0lCa7uZEHN2Kmr6DfC5sBSdsTy
         z0H3uY9WDCM3k4qBit8xybCBnErOq2OeNqZkrS+tJq1K/DTV7LLg/E0Ax+/sUtRva8XV
         RMgks6tmsMVIBPulARQoCe366COq2guOHj4PPLZ+EUN8xViAA2efI1cbJ7c9IHpPhAH5
         OAkg6rqJ50PLYOqSlTe0v79emqLc5ere3/Uc1AAw9X0m8QJr8UdTBUlBNleMKE0ent1d
         1/3g==
X-Gm-Message-State: AOAM531zo4WtV+92E+8r0wika53QymlXmGGPj2v3V1f5T4XsfC5MCQdB
	QGbGoZwbRsHq1fezgyBCHw4L2mQWr4R4PRcP
X-Google-Smtp-Source: ABdhPJwmV2COHSRC6xmMBCy0DBtYFMHLRnPRfwtkZ1y+nG04pcAf+9IiapKoMrN7q0Tz8usOiHb7Ag==
X-Received: by 2002:a17:907:961b:b0:6d9:acb0:5403 with SMTP id gb27-20020a170907961b00b006d9acb05403mr5966735ejc.568.1646301336278;
        Thu, 03 Mar 2022 01:55:36 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9692:b15:c6e7:1c2e? ([2a02:578:8593:1200:9692:b15:c6e7:1c2e])
        by smtp.gmail.com with ESMTPSA id eq18-20020a170907291200b006da97b09661sm149064ejc.17.2022.03.03.01.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 01:55:35 -0800 (PST)
Message-ID: <e44ddeee-a11c-f412-3a98-7e04580f9c6b@tessares.net>
Date: Thu, 3 Mar 2022 10:55:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] selftests: bpf: exercise bpf_mptcp_sock()
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <4561ea0907db7c1db98a7c6d90f831ee337da5c5.1645716043.git.geliang.tang@suse.com>
 <16274837-34e1-f382-91cd-6f646722c7c8@tessares.net>
 <20220303073159.GA17123@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220303073159.GA17123@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2022 08:31, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, Mar 01, 2022 at 12:56:08PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 24/02/2022 16:21, Geliang Tang wrote:
>>> This patch extended the MPTCP test base, to exercise bpf_mptcp_sock() from
>>> C test as Alexei suggested in [1].
>>
>> Thank you for this patch!
>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> index 04aef0f147dc..eba1b6d12a8c 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> @@ -6,6 +6,7 @@
>>>  struct mptcp_storage {
>>>  	__u32 invoked;
>>>  	__u32 is_mptcp;
>>> +	__u32 token;
>>>  };
>>>  
>>>  static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
>>
>> Do you think we could verify that the token has been properly read and
>> stored here? I know there were some limitations but probably we can work
>> around them, no? We could store items on the msk and not the ssk for
>> MPTCP connections, would that not help?
> 
> Yes, we should verify the token. Could you please give me more details
> about how to store items on the msk? I don't know how the items are stored
> on the ssk either, please show me which code is used to implement this.

The difficulty with MPTCP is that many events on the kernel side will be
linked to a subflow. But the userspace only knows the MPTCP socket.

Because of that, it seems to make sense to store info per msk to be able
to find info from the userspace from a fd.

Regarding how to do that, probably easier to look at the code you modified:

> @@ -43,6 +45,20 @@ int _sockops(struct bpf_sock_ops *ctx)
>  
>  	storage->invoked++;
>  	storage->is_mptcp = tcp_sk->is_mptcp;
> +	storage->token = 0;
> +
> +	if (tcp_sk->is_mptcp) {
> +		struct bpf_mptcp_sock *msk;
> +
> +		msk = bpf_mptcp_sock(sk);

After the modification you did in 'Squash to "bpf: add 'bpf_mptcp_sock'
structure and helper"', 'bpf_mptcp_sock()' now returns a generic "struct
sock *" which is in fact a "struct mptcp_sock *" if I'm not mistaken.

So we should have:

    struct mptcp_sock *msk = bpf_mptcp_sock(sk);

To be able to use this structure, I guess we then need to move the
definition of "struct mptcp_sock" from net/mptcp/protocol.h to
include/net/mptcp.h.

Now that you have a "real" sock, I guess you can use
bpf_sk_storage_get() with the msk instead of the sk. You can store the
token in this map but what might be very interesting is to store an
array of data about the different subflows (or just a counter).

I don't know well the internals of BPF so maybe what I'm suggesting is
not possible but feel free to tell me what is not clear and what cannot
work.

BTW, you can remove "struct bpf_mptcp_sock" from
include/uapi/linux/bpf.h. It is no longer needed with the modifications
you did. The doc around bpf_mptcp_sock() also needs to be updated as the
returned pointer is for a different structure: "mptcp_sock" instead of
"bpf_mptcp_sock".

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
