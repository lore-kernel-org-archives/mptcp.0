Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D3320B
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 15:01:03 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id b35so9495383edf.0
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/QwgVhiMkg85MS7P30UQBPtZshvs45DDJUPlq1RWQsA=;
        b=RSDe5x2gZrejDA3mNdmhEpgPHZsRJnGOAZS2AE0iCoFKmQ0mNX0rZD9aioOmF2k1AK
         sGKKmCYhkEu8GfGmrK7D1p8nCZ1l+dJFCADdHH5lvqaGO27WuWv12nzGurJRvkPO7bh1
         8UCWOTFndiH5xhuGzqPsw8kLqloegYF9d4B8bq3pPlOA+WqMgQNKQELd1IhHESYYMSsQ
         JvWgx/jzdn2z/ZAmR1Sp7bhMvDOG1BJwP4RgFu2YTldVS1fE8YYCk8PJ2noc7A3vLMuh
         ZZKTTsPBgSkq5i9rbP7lhePDk5xoIlOwMgUA9mC4T8NFzhcPse3qAhoghqb9bYxNBwrK
         HbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/QwgVhiMkg85MS7P30UQBPtZshvs45DDJUPlq1RWQsA=;
        b=O4VnWgClKR2mRcoM6Ukns3HRV1PVjtoTwB6Tiu8Mb2cQEpOdYpvIyWhwNtAYKIZn71
         98dV1DJrIs+o0HmnnQ7XKm4imPwoJNrpRFjqVuIjeNENlwUGeX0eSzxFUvDN/IRChUiO
         0+qgoc7pQye5omaIY+Em+FEsUzUrKJ+JgqyrXBvIOMETWngN9qIlexDhhoZw+IyOeJaS
         7vQAFWi4SIOuMLOsbW/IM2bj9qokDi9ptPvquTchibqCg41E35ADqfmgtB7R9sEDDC/K
         Lw9y/XjSOyUjtTkuy2x9H8d2+1LU7GND4Fr211C4GEB2Dt3BfQ6zhMWyrLyh+ohgJ7OE
         AXxQ==
X-Gm-Message-State: ACrzQf2znJvoj2eVZ2Sbywpa9gq1ebXJY993o1j96iKCRIFpgup0aBHI
	dD8wbMo8mA1oR9E8vf6+5Q5KLA==
X-Google-Smtp-Source: AMsMyM629VdaBd3u7Hmut8Xv1FaO0TGc8+6i2B/SNlHNTrdeaUv3kQF1OBwmFqy9EBbHx8nYjULe1Q==
X-Received: by 2002:a05:6402:2489:b0:454:11de:7698 with SMTP id q9-20020a056402248900b0045411de7698mr23033198eda.214.1664204462081;
        Mon, 26 Sep 2022 08:01:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d58b:a76f:9c42:d02a? ([2a02:578:8593:1200:d58b:a76f:9c42:d02a])
        by smtp.gmail.com with ESMTPSA id lh3-20020a170906f8c300b00782ee6b34f2sm4122229ejb.183.2022.09.26.08.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 08:01:01 -0700 (PDT)
Message-ID: <7b093482-2c18-7657-92be-e2784001eeff@tessares.net>
Date: Mon, 26 Sep 2022 17:01:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v11 1/4] mptcp: add
 mptcp_setsockopt_fastopen
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Dmytro Shytyi <dmytro@shytyi.net>,
 mptcp@lists.linux.dev
References: <20220925232601.25252-1-dmytro@shytyi.net>
 <20220925232601.25252-2-dmytro@shytyi.net>
 <84be9c0419af677897836e5af900596bc4713767.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <84be9c0419af677897836e5af900596bc4713767.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro, Paolo,

On 26/09/2022 16:50, Paolo Abeni wrote:
> On Mon, 2022-09-26 at 01:25 +0200, Dmytro Shytyi wrote:
>> Add set MPTFO socket option for MPTCP. This option is needed for
>> the listen socket to accept MPTFO.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> 
>> ---
>>  net/mptcp/Makefile   |  2 +-
>>  net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++++
>>  net/mptcp/protocol.h |  5 +++++
>>  net/mptcp/sockopt.c  |  3 +++
>>  4 files changed, 46 insertions(+), 1 deletion(-)
>>  create mode 100644 net/mptcp/fastopen.c
>>
>> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
>> index 8a7f68efa35f..c42ad8609876 100644
>> --- a/net/mptcp/Makefile
>> +++ b/net/mptcp/Makefile
>> @@ -2,7 +2,7 @@
>>  obj-$(CONFIG_MPTCP) += mptcp.o
>>  
>>  mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
>> -	   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
>> +	   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o fastopen.o
>>  
>>  obj-$(CONFIG_SYN_COOKIES) += syncookies.o
>>  obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>> new file mode 100644
>> index 000000000000..086cbad49979
>> --- /dev/null
>> +++ b/net/mptcp/fastopen.c
>> @@ -0,0 +1,37 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
>> + */
>> +
>> +#include "protocol.h"
>> +
>> +int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>> +				      unsigned int optlen)

I think we should keep everything related to the sockoptions in
net/mptcp/sockopt.c, no?

>> +{
>> +	struct sock *sk = (struct sock *)msk;
>> +	struct net *net = sock_net(sk);
>> +	struct socket *ssock;
>> +	struct sock *ssk;
>> +	int val;
>> +	int ret;
>> +
>> +	ret = 0;
>> +
>> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
>> +		return -EFAULT;
>> +
>> +	ssock = __mptcp_nmpc_socket(msk);

'ssock' could be NULL if the setsockopt() is called once the connection
has been established.

>> +	ssk = ssock->sk;
>> +	net = sock_net(ssk);
>> +	lock_sock(ssk);
>> +
>> +	if (val >= 0 && ((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
>> +		tcp_fastopen_init_key_once(net);
>> +		fastopen_queue_tune(ssk, val);
> 
> Instead you could directly call:
> 
> 	return tcp_setsockopt(ssock->sk, SOL_TCP, TCP_FASTOPEN, optval, optlen);


I agree, similar to TCP_FASTOPEN_CONNECT

> Side note, we could add a generic helper to invoke tcp_setsockopt() on
> the mpc subflow, on the give tcp socket option, and reuse such helper

Indeed. I was already looking at doing that when implementing
TCP_FASTOPEN_NO_COOKIE. I can share a patch for this other sockopt and
then you can re-use the new helper for this TCP_FASTOPEN.

> for: TCP_FASTOPEN, TCP_FASTOPEN_CONNECT, TCP_DEFER_ACCEPT... but that
> can/should be done later.

Note that for TCP_DEFER_ACCEPT, this is a special case because
apparently, the setsockopt doesn't fail even if a connection has already
been accepted.

@Dmytro: Two last things about the patch:
- you also need to support the 'read' side (getsockopt())
- if I'm not mistaken, this TCP_FASTOPEN option is only needed for the
listener side, not for the sender, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
