Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F58F58
	for <mptcp@lists.linux.dev>; Wed, 22 Mar 2023 17:34:57 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id v1so11813271wrv.1
        for <mptcp@lists.linux.dev>; Wed, 22 Mar 2023 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679506495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJvRv3MGTn2zfCJiJeDRRiQXTC5u10OkNu/CMPK56tc=;
        b=peOcfMuh6Os5wxZzvplJ2iC+F3NFSE04g00rLeK2eNjhQcY2HZ9OCP6pKytj2QaExi
         rP9FI7b5wqDmsb2L1znKN/4JtqPnYMCTcLLEwIB4VvryDaoHrBjgctKW+eY3uUmuBzoW
         YxZTdJsGz2Jjeo4z0RV5RHGPAI+v1pRk9dnbIsu47FCRVfyjN0j39Tbw93pdB6f4KWYo
         H6/C2c1/DioWKMPqLYXsagk51BableiTT3/8t62owY0PK/52Fz9V37WnEF+ioFg8F5x8
         lcs9lDY26mDRYEsbSEjaMo3CtPE50vY9TQOnCbApzZ65k6whF5C6lfNknSjANlsfTUN8
         j7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJvRv3MGTn2zfCJiJeDRRiQXTC5u10OkNu/CMPK56tc=;
        b=j3TY41a0VwMk57bgfPiH+/LQ/c0Np0mUeM7VhyM2ClwHcTSyZAr4RnA/EyqEa5WM4n
         AGraWsnh57C6E22LR1Qwbx92n/MLdtX6AAsYpuApIpks1qla9sGkmHgyHm/ItShh5byb
         V3/TqLT1su1PWABnrXDigsfiFcF/QTxLaKPTymHAOr2rNkuiBD2gsxTyHP7p8sX7/rBM
         1wGayzwHgu3EBlqFa9wZosmxrrelcdiMC5/zOyNjHUQYmSzihhBeLW0o71TTHd0yHzG+
         4e/wUgpfME+wcfEv1zu43g7yc8OqM1SY7BAP5T//Qz9HETen75nDZYY5kB7vNeHwMMgs
         BFVg==
X-Gm-Message-State: AAQBX9ebOO/GKvgvIJxbz6b0mYDwis5iI54tvaOCJvOAlzU96JoCyQxj
	6JVy+7obJfwNkRP+MZcPxS5Iow==
X-Google-Smtp-Source: AKy350ZCSCiBzCGDXFIX+nh415TvAofcsEkWQ2dyY2xTzncQ0DXLEVl4eu2TphRSiuGTPa+po73xHw==
X-Received: by 2002:adf:e84d:0:b0:2cf:f06b:858a with SMTP id d13-20020adfe84d000000b002cff06b858amr536599wrn.17.1679506495387;
        Wed, 22 Mar 2023 10:34:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4d5c:7535:4763:760? ([2a02:578:8593:1200:4d5c:7535:4763:760])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d60c2000000b002cfe71153b4sm14294686wrt.60.2023.03.22.10.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:34:55 -0700 (PDT)
Message-ID: <2ded8687-38a6-e74b-d47d-df4c9112b80f@tessares.net>
Date: Wed, 22 Mar 2023 18:34:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH mptcp-next v5 3/7] mptcp: close remote subflow when
 destroying it
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1678778977.git.geliang.tang@suse.com>
 <d47a06abb5dae1f333a496183da5ba3e51e5a98e.1678778977.git.geliang.tang@suse.com>
 <067bd46b-9c12-36cd-8ea5-3667669dc6cf@tessares.net>
 <CA+WQbwv1gBROrXG-8Fb=T+p6rQNf5PF0gKB95mJzfQdsH8-mGg@mail.gmail.com>
 <8387b3ee-c7dc-6555-c914-6cf856375fcc@tessares.net>
 <CA+WQbwtPdoG_XA8fFWKDVFS1-rm3LU2BedskF1GuBhQNR=w_qA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwtPdoG_XA8fFWKDVFS1-rm3LU2BedskF1GuBhQNR=w_qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 21/03/2023 03:52, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年3月21日周二 00:09写道：
>>
>> Hi Geliang,
>>
>> Thank you for your reply.
>>
>> On 20/03/2023 12:41, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Thanks for your reviews.
>>>
>>> We always remove address together with subflow, see
>>> mptcp_nl_remove_subflow_and_signal_addr() or
>>> mptcp_pm_remove_addrs_and_subflows().
>>>
>>> So we always get "chk_rm_nr 1 1" in these tests:
>>>
>>>         # single subflow, remove
>>>         if reset "remove single subflow"; then
>>>                 pm_nl_set_limits $ns1 0 1
>>>                 pm_nl_set_limits $ns2 0 1
>>>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>>>                 run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
>>>                 chk_join_nr 1 1 1
>>>                 chk_rm_nr 1 1
>>>         fi
>>>
>>>         # single address, remove
>>>         if reset "remove single address"; then
>>>                 pm_nl_set_limits $ns1 0 1
>>>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>>>                 pm_nl_set_limits $ns2 1 1
>>>                 run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
>>>                 chk_join_nr 1 1 1
>>>                 chk_add_nr 1 1
>>>                 chk_rm_nr 1 1 invert
>>>         fi
>>>
>>>         # userspace pm add & remove address
>>>         if reset_with_events "userspace pm add & remove address"; then
>>>                 set_userspace_pm $ns1
>>>                 pm_nl_set_limits $ns2 1 1
>>>                 run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
>>>                 chk_join_nr 1 1 1
>>>                 chk_add_nr 1 1
>>>                 chk_rm_nr 1 1 invert
>>>                 kill_events_pids
>>>         fi
>>>
>>> But the userspace remove subflow test got "chk_rm_nr 0 1":
>>>
>>>         # userspace pm create destroy subflow
>>>         if reset_with_events "userspace pm create destroy subflow"; then
>>>                 set_userspace_pm $ns2
>>>                 pm_nl_set_limits $ns1 0 1
>>>                 run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
>>>                 chk_join_nr 1 1 1
>>>                 chk_rm_nr 0 1
>>>                 kill_events_pids
>>>         fi
>>>
>>> "chk_rm_nr 0 1" means getting no rm_addr, but a rm_subflow.
>>
>> Indeed but you have this behaviour only because the userspace PM didn't
>> send this RM ADDR, no? I agree it might be better to do so but it is not
>> mandatory if I'm not mistaken, especially for the client side. Then it
>> is up to the userspace PM to decide to send the RM ADDR or not and we
>> cannot force it I would say.
>>
>> Or maybe the client side cannot send a RM ADDR? (on the other hand, the
>> address was not announced with an ADD_ADDR so why do you want to send a
>> RM_ADDR?)
>>
>> (if there is a need, we can ease its use with an extra flag but I don't
>> think we should force this behaviour, it is up to the PM to do that, no?)
>>
>>> This behavior is incorrect. This patch fix it. It looks through the
>>> userspace_pm_local_addr_list to find the addr id, and send RM_ADDR
>>> with this id.
>>>
>>> So patch 2 is needed to add the address into
>>> userspace_pm_local_addr_list, and patch 1 too, no clear the address
>>> id.
>>
>> Would it not work if you modify do_transfer() to use pm_nl_ctl to send
>> the RM_ADDR then do the destroy (I don't know if doing the opposite is
>> supported)?
>>
>> But again, I don't think we need to send an RM_ADD if no ADD_ADDR have
>> been sent before by the client here.
> 
> No, we must send an RM_ADDR to shutdown the subflow and close ssk on
> the other side. I guess we should hear Paolo's opinion here. @Paolo
> Abeni

We discussed about that at the last meeting: we confirm that here, the
userspace daemon is the owner and then it is in charge of all actions
related to the PM including sending RM_ADDR then.

Typically, the RM_ADDR are sent when a previously announced address has
been removed. In the test you modified ("userspace pm create destroy
subflow"), it might even looks strange for the client to send a RM_ADDR
for a subflow it has created on an address it didn't explicitly
announced. The client no longer wants to use it, fine, it simply sends a
TCP FIN, no need to do more, no? (or at least, no need to force the send
of a RM_ADDR)

WDYT?

Maybe we could even think about changing the in-kernel PM not to send
the RM_ADDR if the address was not announced before?
(I think we should not change that, in the case of the in-kernel PM,
these RM_ADDR are sent only when the address has been explicitly removed
from the endpoints so it somehow makes sense)


While talking about that, I was thinking about this: for the moment, the
userspace PM can only send RM_ADDR for addresses it has previously
announced, right?
In this case, if the userspace PM daemon for the client side detects an
issue with its "2nd" address -- e.g. a Netlink event is sent to the
userspace daemon because a subflow got closed with an error or because
an IP address is no longer available -- the userspace PM daemon cannot
send an RM_ADDR to the server to tell it to stop sending data on this
subflow. I can create a new ticket on GitHub for that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
