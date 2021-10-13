Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33732C80
	for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 15:29:45 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id g8so11858343edt.7
        for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=YkfV5G2ndj8iBMd69UHQ3SBWR8876HpGpTKwrnMJr+k=;
        b=tzFYnkP7jwfJiuI4uB6+sfRyPF4RgyTHogY5US0RULBOZmnc0JegBoDaIaRULe1onW
         OhcR073Fk1ipyBp/RPt8k1kU/QXpDRfM4Za2OlVPDGHg1BnDODxWNOzimyd0gTmk7juT
         9eh2dj1OCvfBtJ9MK/jkC1lVS21/ziFrT6gMXu4etU2/7iMHPDWMobfsr6zKaK8B6tUc
         aYV2ysBd5XGxDDjHt5nNgE7omJ8zpHfMKEQjWG/EJcIP6Ud5pZwGAxA86k+zpL4Ywslc
         2S5sQcQoZ0johWkapnvEzBZ2wLmRMLivU2uw0ip00Jpl+XxJL+wh1CP30UKVpnBFCF8q
         Lb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=YkfV5G2ndj8iBMd69UHQ3SBWR8876HpGpTKwrnMJr+k=;
        b=hcE7OZ7M9+aWuIvSrfj2gVBbgYOMVU4um2tEs8eq2ZGD/jSthw4m7nszTyvIofjTz/
         L6WT+X7MLDiWBfuoJBYAMdqUOjT48VkVuCFpzV6+AU/wYsDb6nBmO9aIfQ//hfmv3wU9
         Y9jBQt4C9TQgUGJaFhKMkD8wpomh+wbRnuFe22PZXovjKMExGx2JGW1lTqkf16E4GOow
         7H/paA2VJ9d7CBa6UrZXmjmz+7VuRE23cgtiltHJlpn05oFQP4BOrqZJVbubbZOABxi+
         9KGJnfGs7MlO6av1EkY1yj5daL30pNVCIaHUrESvP+/P9pxV74LCgD0Kix22TjBDhF5u
         tUNw==
X-Gm-Message-State: AOAM532dOfU+tEAgaLxE3ndicMEtfU29qTrW907fVDBPNs1NFk3pOwtf
	YkjrQ8mazBjadvcH2l5AgRxb/41oc1Qm5g==
X-Google-Smtp-Source: ABdhPJyK+b52jhqpW7pcbz6ye9DJbwDL0FXv89i/pPqkKoeMkrOciF54AR++U64fr1ijHf0NJrkp3w==
X-Received: by 2002:a17:906:2dc9:: with SMTP id h9mr142969eji.431.1634138982253;
        Wed, 13 Oct 2021 08:29:42 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id p23sm8967583edw.94.2021.10.13.08.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:29:42 -0700 (PDT)
Message-ID: <3292a94b-666b-6130-f3b8-48086bddd6d7@tessares.net>
Date: Wed, 13 Oct 2021 17:29:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] mptcp: increase default max additional
 subflows to 2
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
 <ed428aeb-8d9f-90c8-60cf-5c714b3460e5@tessares.net>
 <f9860e6de0d54d4644a4a7eb94748ee2a1cb0fab.camel@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f9860e6de0d54d4644a4a7eb94748ee2a1cb0fab.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 13/10/2021 16:54, Paolo Abeni wrote:
> On Mon, 2021-10-11 at 18:09 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 08/10/2021 19:27, Paolo Abeni wrote:
>>> The current default does not allowing additional subflows, mostly
>>> as a safety restriction to avoid uncontrolled resource consumption
>>> on busy servers.
>>>
>>> Still the system admin and/or the application have to opt-in to
>>> MPTCP explicitly. After that, they need to change (increase) the
>>> default maximum number of additional subflows.
>>>
>>> Let set that to reasonable default, and make end-users life easier.
>>>
>>> Additionally we need to update some self-tests accordingly.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/pm_netlink.c                          | 3 +++
>>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
>>>  tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++---
>>>  3 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 050eea231528..f7d33a9abd57 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -2052,6 +2052,9 @@ static int __net_init pm_nl_init_net(struct net *net)
>>>  	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
>>>  
>>>  	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
>>> +
>>> +	/* Cit. 2 subflows ought to be enough for anybody. */
>>> +	pernet->subflows_max = 2;
>>
>> Sorry for the late reply, I just thought about something when looking at
>> applying this: let say that in a typical setup we would have 2 subflows
>> per connections because the client has 2 interfaces and connect to a
>> server not announcing other addresses. With this setup, could we arrive
>> in situations where we would (internally) have 3 subflows?
>>
>> I mean, could we arrive in a situation where 1 (or 0) subflow is OK, 1
>> is being deleted (network reconnection?) and the PM is already trying to
>> create a new one? In this case and because of the limit, the PM might
>> not try to create this 3rd subflow and might not retry when the dying
>> subflow is actually being deleted? Or maybe the PM already wait for the
>> full deletion before re-trying to establish a new subflow?
> 
> If I understand correctly, your fear is that we can end-up with 2
> additional subflows even if there are only 2 different local IP
> addresses/interface, is that correct?

Correct: typically in a "mobility use-case" where we move from one
network to another. Or we simply get a new IP, etc.

> Anyhow the above scenario is not possible with the in-kernel path
> manager: it will create new subflows only for local addresses not
> already used by the mptcp connection.
> 
> Unless the 'fullmash' flag is set, but in that case user really wants
> multiple subflows per local address.

Yes sorry, I was thinking about the 'fullmesh' case. But if the client
has 2 interfaces -- each of them with one IP -- and the server only has
one IP, we are in a "typical" UC I think. The behaviour with and without
the "fullmesh" flag is the same.

> Please let me know if the above solves your doubts.

I guess here, it is userspace's responsibility to first remove the
"broken" local address and then add the new one. If the opposite is
done, we will have 3 local addresses, we will not create a new subflow
but we will not create a new one when the 2nd subflow dies even if there
is another available local address. But again, that would be userspace's
fault, no? :)

> Side note: the in-kernel path manager takes no additional action when a
> subflow is closed.

Should I create a ticket to check if another local address is not
available after a subflow is closed and if we are still under the limit?
Maybe the PM could also re-establish the subflow using the same 5-tuple
depending on the err, e.g. if the subflow got disconnected after a NAT
timeout, etc.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
