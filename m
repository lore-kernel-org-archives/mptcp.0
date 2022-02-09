Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501B2F25
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:29:17 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id d10so5403885eje.10
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 01:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gm3d940xQae/Byh83mU22MRhzEuwOarLDb6WebDD2LA=;
        b=0a4s7tArzG+aQBIpLO38TQF1Eqi4A7Wqo/6zVVJwS6uChvZ6sskqLRknM0n+HqBhLs
         /3JwN1UbUItxRVUwCG9qHw0rrw1c1sNz/jMOLM5BiYir9L6MKDfS2y+6KmR3b2P8PQgd
         VSVBUGklHcevqbkkIGA4SaOIg64hC8kazZ5jVMw2/66xhIzn52JZZmf3+9gpIFQUamRP
         ojUNAMYen9xUXd3k/+PIA7/6MQFFvKWWSmWnCKFjLwYFmuYfABi7TBCzWJ1N8evEepUn
         qGkc6zfxehzYY8ci64JeqBDOo0YzGf1lw4rNl7O74iZnnCEgtgyzMbv25R/kXbR+L2KS
         9ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gm3d940xQae/Byh83mU22MRhzEuwOarLDb6WebDD2LA=;
        b=SivDz6QNtR+nWGtpcG1KxeNxC1/oNcqLp1TrjzYSlCFi5M4NxRBtdWOYXhjLWcZV+A
         SGMFpEv5zMwRp+w8mwXeGOI1q310Z1tsKbFVbUHfHbSxlOgQ0VGPoYSzJV3mZYEejzGS
         yM4J0M6QIsZOwoQ03sbK90CjTRD9Ad/IHLm9TdvREsSLlBem6miRMy8eT+IrYKRcSUQo
         2Q9UhYA0K3ylJOkF8Vp2T5vat9PKTyNmb3k97ExbPn0/oh6/jkQCVet4FnP70zcSn5+3
         GTedAi98HzCtUJ3V9k/bAQ78lAofS6AARtGpTfEfBzgdhaZ0IjAGcBeglAuZS/0tnNzg
         Kc4g==
X-Gm-Message-State: AOAM530fOGvtqZExfWw1cqAVzofZkDFLLPaTjm/ksHJKhbqoQfFiKc7R
	B2gNErQ24StuaUUsYvc/TshJN9tYuIO6QTYC
X-Google-Smtp-Source: ABdhPJwYzDc8UIm/ij50AH4B4vgJn/1BQee6syPNY+879v/6mNLNSKMWrpSExBRWQqtCJ6I1CdUHZw==
X-Received: by 2002:a17:906:7a10:: with SMTP id d16mr1127899ejo.290.1644398955630;
        Wed, 09 Feb 2022 01:29:15 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:268e:dc63:f3ef:de99? ([2a02:578:8593:1200:268e:dc63:f3ef:de99])
        by smtp.gmail.com with ESMTPSA id o4sm2685515edq.45.2022.02.09.01.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:29:15 -0800 (PST)
Message-ID: <1047ddf4-fe35-6bbf-0676-6a92a92ed4e5@tessares.net>
Date: Wed, 9 Feb 2022 10:29:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-net v2 1/4] mptcp: fix race in overlapping signal
 events
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1644346664.git.pabeni@redhat.com>
 <fe2ee45c579ea83d5aec853c80d6088aebc6ef26.1644346664.git.pabeni@redhat.com>
 <5b78d02e-c47c-7ecb-f0d0-8464f71ed49b@linux.intel.com>
 <53f313b91ef91c0bf7764238ec5cba2960450153.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <53f313b91ef91c0bf7764238ec5cba2960450153.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 09/02/2022 09:54, Paolo Abeni wrote:
> On Tue, 2022-02-08 at 16:54 -0800, Mat Martineau wrote:
>> On Tue, 8 Feb 2022, Paolo Abeni wrote:
>>
>>> After commit a88c9e496937 ("mptcp: do not block subflows
>>> creation on errors"), if a signal address races with a failing
>>> subflow creation, the subflow creation failure control path
>>> can trigger the selection of the next address to be announced
>>> while the current announced is still pending.
>>>
>>> The above will cause the unintended suppression of the ADD_ADDR
>>> announce.
>>>
>>> Fix the issue skipping the to-be-suppressed announce before it
>>> will mark an endpoint as already used. The relevant announce
>>> will be triggered again when the current one will complete.
>>>
>>> Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/pm_netlink.c | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 93800f32fcb6..fb8d4bfcfbd6 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -546,6 +546,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>>> 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
>>> 		local = select_signal_address(pernet, msk);
>>>
>>> +		/* due to racing events on both ends we can reach here while
>>> +		 * previous add address is still running: if we invoke now
>>> +		 * mptcp_pm_announce_addr(), that will fail and the
>>> +		 * corresponding id will be marked as used.
>>> +		 * Instead let the PM machinery reschedule us when the
>>> +		 * current address announce will be completed.
>>> +		 */
>>> +		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
>>
>> There is a helper for this: mptcp_pm_should_add_signal_addr()
>> (which also uses READ_ONCE())
> 
> I chose to not use it, as the condition I'm really checking is: "is the
> PM already processing a signal addr?" which incidentally boils down to
> the same code, but the helper name would be misleading IMHO.

If it helps, we can also have a new helper:

    mptcp_pm_is_processing_signal_addr()

simply calling "mptcp_pm_should_add_signal_addr()", no? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
