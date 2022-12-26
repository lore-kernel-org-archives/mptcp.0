Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2911367
	for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 13:16:05 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id gh17so26027331ejb.6
        for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZE3zrMsb7jWfMfVdfbtXep2qNITRjXhhNIKuVW1zcc=;
        b=meGj9Wpf+dgc84qjdgoAtpeOxwBajziWHLz2mJKB2I0JfCguhD1IaAIelo2lOD/q5F
         svrFVXdTRFu3TumOOTWZ36fZFxz/D+DhqW/GF+LXMbILdzQBvezmbBcWgm8JoOMC0BNY
         QbslmJz2KA+e5laVXux9s81WfZDJa2SIuS4H3sDa5wI2ik6Mm+bfGcOe+6EvJ+Dg+k5m
         fETN0ayJx8J9bLOsLcILWb/VW828drkMVR8U9XXSB0nhcBMFq5TEgVFMx+kxtAFrnLTC
         uQEmY1WBaOQzUqkQYMNiCQuKoJFzp+hMy51xHbtnQ4lm+jGxB9Ujx5Z5f18A4jszeov3
         5jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZE3zrMsb7jWfMfVdfbtXep2qNITRjXhhNIKuVW1zcc=;
        b=xWhnaJj5P7VMFuwVTW9cAiwS/YUpbly8gyLiSktBy3vcqyd18aSayqpjQD/MuER+tP
         oCnFzeV52/oi4B5bHLQ11+UTHW9XDmCbeLBljjpRcbZYg2w5XiZq6oMheORXydTASOWo
         kkkVhp9OQigte14mSg0cAUhE35fNgUbCYu4dTm2jU3AqA5jDTQFMW4rYa0uQOcm1/N2Z
         4my/hAq0Wd6mDQEs2F1rfzAo20XR1DBomyvS+hfc4ZM2/OIO3UTlXGuHKZp8MvZdR8s9
         xeZ4CujnUa5ZY5Z3ilCqmjDys8J3AF+eZ6KFsPu2UHW0r71DqS4B/zIfl9cvXJDY+G4y
         upFQ==
X-Gm-Message-State: AFqh2kozbnXdJrm68V4uZx75kYw6ej2X5yK6AAWmCE0fREj0fizhO90U
	nKkOPZZsko/dGOllepSvpq+98nynNClUI2a6y2c=
X-Google-Smtp-Source: AMrXdXuLpGX61/Bm3jvYwd9D55u/TDoTlXl1YXcA8bX3BnkElXehU8v7q7k6Ur3yElJ97BFAk5//Kw==
X-Received: by 2002:a17:907:d68e:b0:7bd:43e9:d3ab with SMTP id wf14-20020a170907d68e00b007bd43e9d3abmr14958062ejc.52.1672060563367;
        Mon, 26 Dec 2022 05:16:03 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709061ba200b0079800b8173asm4805138ejg.158.2022.12.26.05.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 05:16:03 -0800 (PST)
Message-ID: <8ce97f1e-49d9-d014-fa06-2a971c60037f@tessares.net>
Date: Mon, 26 Dec 2022 14:16:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add test-cases for mixed
 v4/v6 subflows
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671799401.git.pabeni@redhat.com>
 <c2b08053101c90d85634c95840e3a8a637fa8346.1671799401.git.pabeni@redhat.com>
 <45315757-d5fc-8d90-39e1-d7fd8a7682a4@tessares.net>
 <69b575721cd0164895fd634f93d2900485698999.camel@redhat.com>
 <df67ca04-4f4f-3902-58f5-a2c8829ff60f@tessares.net>
In-Reply-To: <df67ca04-4f4f-3902-58f5-a2c8829ff60f@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/12/2022 14:09, Matthieu Baerts wrote:
> Hi Paolo,
> 
> Thank you for the replies!
> 
> On 23/12/2022 19:29, Paolo Abeni wrote:
>> On Fri, 2022-12-23 at 15:35 +0100, Matthieu Baerts wrote:
>>> Hi Paolo,
>>>
>>> On 23/12/2022 13:51, Paolo Abeni wrote:
>>>> Note that we can't guess anymore the listener family based on the
>>>> client target address; use always IPv6.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++----
>>>>  1 file changed, 42 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> index d11d3d566608..6ef4787ad244 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> 
> (...)
> 
>>>> +		chk_join_nr 1 1 1
>>>> +	fi
>>>> +
>>>> +	# subflow IPv4-mapped to IPv4-mapped
>>>> +	if reset "simult IPv4 and IPv6 subflows, first is IPv6"; then
>>>> +		pm_nl_set_limits $ns1 0 1
>>>> +		pm_nl_set_limits $ns2 1 1
>>>> +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
>>>> +		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
>>>
>>> Linked to the previous question: that makes me think we properly don't
>>> propagate the IPV6_V6ONLY socket option (sk_ipv6only) to new subflows
>>> (just before the connect). Now that we can connect to v4 addresses, it
>>> might be an issue. Easy to fix with this I guess:
>>>
>>> --------------------- 8< ---------------------
>>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>>> index 582ed93bcc8a..9986681aaf40 100644
>>>> --- a/net/mptcp/sockopt.c
>>>> +++ b/net/mptcp/sockopt.c
>>>> @@ -1255,6 +1255,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>>>>         ssk->sk_priority = sk->sk_priority;
>>>>         ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
>>>>         ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
>>>> +       ssk->sk_ipv6only = sk->sk_ipv6only;
>>>>         __ip_sock_set_tos(ssk, inet_sk(sk)->tos);
>>>>  
>>>>         if (sk->sk_userlocks & tx_rx_locks) {
>>> --------------------- 8< ---------------------
>>>
>>> (+ a test checking that for v6 only socket as well I suppose)
>>
>> This is an unrelated patch. Additionally, I think sk_ipv6only on
>> subflow other then the first one is not needed, as we already match
>> carefully the sk family and address family (we create ipv6 subflow for
>> ipv6 addr)
> 
> I'm sorry, I'm not sure to understand. If someone wants to have only v6
> connections, it has to create an AF_INET6 socket and set IPV6_V6ONLY
> option. Why not reflecting that to the different subflows to have
> subflow in v6 only?
> 
> But I agree it is not directly related.
I just noticed that in your v2, you added a check in pm_netlink.h. But I
guess it is fine to also apply the patch, just to be sure the check for
pm_netlink.h is not bypassed somehow (by the userspace PM, a future one,
with BPF, etc.), no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
