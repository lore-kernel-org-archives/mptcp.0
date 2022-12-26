Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179110E2
	for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 13:09:11 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id q15so13798416edb.1
        for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 05:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2a0n9AWe/QBudCGTOmBMZdvWAZzV9CvLX8LoYObRX8=;
        b=62iWvrX62PLs1Wbab3AX+jT5pSqNfvQ+4P2ZO822Poe57pT3XD8GgS/YWSmsC8H5P/
         oXubBP7MbYw0+KIDjGYWCdoImE2vQJ4OkYKi2nIzHVw4wBM0eZ6fp5Zrlli8b0pssZMv
         L5zJHNGZycOvXznuYVPnJW5CEkgU4eF2zEdfmW76Sj6mdrvlnSel1DzBT3CDNiJGhnHf
         GtsAxJF3K9BFmoTGPBitvtVvsmUr2FPIqHpQ75BM/OXSu4eyARC9M3CiBZtDZk9WV5vO
         UGAra9x6NYiO9Iv4Mtycy2Xh6KUMD54deEOjKekrGKgt+np3gYiaXPxM4rj5jJ9IRPHW
         1ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2a0n9AWe/QBudCGTOmBMZdvWAZzV9CvLX8LoYObRX8=;
        b=WJVQe985dJrbw77liFo55FyhLi8f5SgK1n5p2ZNB0iTAuvfmg9btzIK/83YyCMfEwr
         5QkzQ8i50B/LDM0/qKT2hkbFuAk44lmX/pBOEm6dNWPDh7WpYnpWSQeeTXsdi31bfCmQ
         YVYyL+MDfauIInsffxcgROCKyXayEBKn41uO1lr1aF+bwSZBHLT0B5t0ZDgUHI4w5R47
         4XNEUboEB7jAzG3kkazLJOQ1UbACMeXZGpWMSPXE2Yp+yWu7O4kNFNLruUmP2kgWSKs9
         NCCebpmpgo5tNcf57MsI5LPNsU0FhEvD+QRJB/fcT2TFl7uf86oCs3Qn8pQJzH3nmCjE
         cFwg==
X-Gm-Message-State: AFqh2krZEuNGBesAINUgk0otFkQL6NqSazwZBt6hwO1eRVJ0SKm9Sq4J
	TAdpnnGd4n18jm8sSfdjGNvYNERqjgmAj6WlxOs=
X-Google-Smtp-Source: AMrXdXuM0y90RpimaSDDV1q9JVjgH+fhbaC2Q/+ySehY/K1c9T3a0pJCCIbO9eAiu6Zp1yLmnAjQ6w==
X-Received: by 2002:aa7:c30b:0:b0:47b:a6e:6ba5 with SMTP id l11-20020aa7c30b000000b0047b0a6e6ba5mr15336587edq.12.1672060149397;
        Mon, 26 Dec 2022 05:09:09 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id d23-20020a05640208d700b0047f0af53d92sm4627712edz.91.2022.12.26.05.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 05:09:09 -0800 (PST)
Message-ID: <df67ca04-4f4f-3902-58f5-a2c8829ff60f@tessares.net>
Date: Mon, 26 Dec 2022 14:09:08 +0100
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
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671799401.git.pabeni@redhat.com>
 <c2b08053101c90d85634c95840e3a8a637fa8346.1671799401.git.pabeni@redhat.com>
 <45315757-d5fc-8d90-39e1-d7fd8a7682a4@tessares.net>
 <69b575721cd0164895fd634f93d2900485698999.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <69b575721cd0164895fd634f93d2900485698999.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for the replies!

On 23/12/2022 19:29, Paolo Abeni wrote:
> On Fri, 2022-12-23 at 15:35 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 23/12/2022 13:51, Paolo Abeni wrote:
>>> Note that we can't guess anymore the listener family based on the
>>> client target address; use always IPv6.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++----
>>>  1 file changed, 42 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index d11d3d566608..6ef4787ad244 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

(...)

>>> +		chk_join_nr 1 1 1
>>> +	fi
>>> +
>>> +	# subflow IPv4-mapped to IPv4-mapped
>>> +	if reset "simult IPv4 and IPv6 subflows, first is IPv6"; then
>>> +		pm_nl_set_limits $ns1 0 1
>>> +		pm_nl_set_limits $ns2 1 1
>>> +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
>>> +		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
>>
>> Linked to the previous question: that makes me think we properly don't
>> propagate the IPV6_V6ONLY socket option (sk_ipv6only) to new subflows
>> (just before the connect). Now that we can connect to v4 addresses, it
>> might be an issue. Easy to fix with this I guess:
>>
>> --------------------- 8< ---------------------
>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>> index 582ed93bcc8a..9986681aaf40 100644
>>> --- a/net/mptcp/sockopt.c
>>> +++ b/net/mptcp/sockopt.c
>>> @@ -1255,6 +1255,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>>>         ssk->sk_priority = sk->sk_priority;
>>>         ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
>>>         ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
>>> +       ssk->sk_ipv6only = sk->sk_ipv6only;
>>>         __ip_sock_set_tos(ssk, inet_sk(sk)->tos);
>>>  
>>>         if (sk->sk_userlocks & tx_rx_locks) {
>> --------------------- 8< ---------------------
>>
>> (+ a test checking that for v6 only socket as well I suppose)
> 
> This is an unrelated patch. Additionally, I think sk_ipv6only on
> subflow other then the first one is not needed, as we already match
> carefully the sk family and address family (we create ipv6 subflow for
> ipv6 addr)

I'm sorry, I'm not sure to understand. If someone wants to have only v6
connections, it has to create an AF_INET6 socket and set IPV6_V6ONLY
option. Why not reflecting that to the different subflows to have
subflow in v6 only?

But I agree it is not directly related.

>>> +		chk_join_nr 1 1 1
>>> +	fi
>>> +
>>> +	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
>>> +		pm_nl_set_limits $ns1 0 4
>>> +		pm_nl_set_limits $ns2 1 4
>>
>> Does the limit here mean 1 subflow or 1 extra subflow? (it might answer
>> my question below)
>>
>>> +		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
>>> +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
>>> +		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
>>> +		chk_join_nr 1 1 1
>>
>> Why do you not have an extra subflow in IPv6 between the second IPv6 of
>> ns2 (subflow,fullmesh) and the main IPV6 of the server on ns1?
> 
> becayse there is no second ipv6 address in ns2:  dead:beef:2::2 is used
> as source by the first subflow (to connect towards dead:beef:2::1).

Ah yes indeed, I don't know why I had another topology in mind...

>>> +	fi
>>> +
>>> +	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
>>> +		pm_nl_set_limits $ns1 0 4
>>> +		pm_nl_set_limits $ns2 2 4
>>> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>>> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
>>> +		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
>>> +		chk_join_nr 4 4 4
>>
>> Why do you have so many subflows here? The client has one IPv6 and the
>> server 2, no?
> 
> Here the client has 2 IPv6 addresses: dead:beef:1::2 and the one added
> by the 'fullmesh_1' argument (dead:beef:3::2, IIRC).

Indeed, thank you. There will then be 3 subflows in v6 and 1 in v4.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
