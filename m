Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908162CA2
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 15:01:28 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id n28so31586613edb.9
        for <mptcp@lists.linux.dev>; Thu, 09 Jun 2022 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+Uhxt5dZp7I9+jDHUI7oqIzXNqxnOOF3Oa/jvxcSFWw=;
        b=WMdWF6jdPB1UqG+A65G6yE0UQ0GODUIDLCSdn1VuoSU2geUh+OsiV4yIG8oGOEntOG
         p3aOr1Jt5rkkC3H0GkX/mqs4VYsnuFM3gs04GZ0rVFnnMrCvxQzelNqtVzWJwlObxLCA
         tCWwAP1cGNw1NKVl9Ob44Mgq6aix1RBdNzuTyGtTpBZrluEzfvGDexio6TgpVoE4JeeK
         OXef4DdjtooPX7plLd2IBGvihgSG7UK1ch3+pMJ2iiATHe+YH3GVifyvkkyO9GXe8oWP
         1e9hHRyecdqouZSBLp960vx99XxuvzzUwkPxbAlVTL1HPDjtbTK07RQ75IUzTov/yf5r
         5cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+Uhxt5dZp7I9+jDHUI7oqIzXNqxnOOF3Oa/jvxcSFWw=;
        b=SoGA8rL18334D858WNHEWF8EW8EPYshSmKKUCuPkAmi3wo6DKgZFLB9WXYXSTWCcE+
         9AmX3fCPfBN22ThjpgBHV59Mr06/3yZBpi9qwbSP5DAoI+cC/9mGQ2Z6kJYRLSPoiytE
         c6rfgbXEKMRYHId2mOBCtGCnUQDkv7tcft5vs8qANQ1MFBmSMfmaBS6yQeH1UKTWJHPv
         irDO6rf+6BxE0sZy410gl7aO34075t4kYvK2VH46b2zO+0cTiY18Oy03H+Tj7cOpcKFt
         RVA4VgAf7rRpQYndHDAlU+83qZp0PNLC75zprLocobp2wfYxljFQKOIaguNntmR4Drnv
         G/KQ==
X-Gm-Message-State: AOAM532G3Tl/CckhWbY17QA7Djhjlq+0svHd633DFnovyKLO3rQaiYsF
	e6zEDzRSmTeinxwU2Nr7ZwDI2w==
X-Google-Smtp-Source: ABdhPJzUP6LXDk033LlXCLgSD334eST/jHzi0E3sIwY2UZtPZ1xDd1M/bpJWQvr/cNT8WotQ6+bQ5Q==
X-Received: by 2002:a05:6402:28b6:b0:433:2b53:157a with SMTP id eg54-20020a05640228b600b004332b53157amr8448565edb.395.1654786886208;
        Thu, 09 Jun 2022 08:01:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b617:e76d:ff8b:2261? ([2a02:578:8593:1200:b617:e76d:ff8b:2261])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906b31700b006f3ef214dfesm8510292ejz.100.2022.06.09.08.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 08:01:25 -0700 (PDT)
Message-ID: <f225ab6c-27f0-5f41-546a-f3375ce2e846@tessares.net>
Date: Thu, 9 Jun 2022 17:01:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next v4 2/2] mptcp: trace MP_FAIL subflow in
 mptcp_sock
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1654732564.git.geliang.tang@suse.com>
 <005b6c1dda2ecb334cc9f6b07053aa59b69b5613.1654732564.git.geliang.tang@suse.com>
 <3ebc14e-ae9-a4ea-f0e0-4a9652a38f3d@linux.intel.com>
 <20220609012358.GA19426@bogon.HOST>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220609012358.GA19426@bogon.HOST>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat, Paolo,

On 09/06/2022 03:23, Geliang Tang wrote:
> On Wed, Jun 08, 2022 at 05:31:00PM -0700, Mat Martineau wrote:
>> On Thu, 9 Jun 2022, Geliang Tang wrote:
>>
>>> This patch adds fail_ssk struct member in struct mptcp_sock to record
>>> the MP_FAIL subsocket. It can replace the mp_fail_response_expect flag
>>> in struct mptcp_subflow_context.
>>>
>>> Drop mp_fail_response_expect_subflow() helper too, just use this fail_ssk
>>> in mptcp_mp_fail_no_response() to reset the subflow.
>>>
>>> Acked-by: Paolo Abeni <pabeni@redhat.com>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>> net/mptcp/pm.c       |  2 +-
>>> net/mptcp/protocol.c | 35 +++++++++--------------------------
>>> net/mptcp/protocol.h |  2 +-
>>> net/mptcp/subflow.c  |  2 +-
>>> 4 files changed, 12 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>> index 45a9e02abf24..2a57d95d5492 100644
>>> --- a/net/mptcp/pm.c
>>> +++ b/net/mptcp/pm.c
>>> @@ -305,7 +305,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>>> 	if (!READ_ONCE(msk->allow_infinite_fallback))
>>> 		return;
>>>
>>> -	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
>>> +	if (!msk->fail_ssk) {
>>> 		pr_debug("send MP_FAIL response and infinite map");
>>>
>>> 		subflow->send_mp_fail = 1;
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 917df5fb9708..58427fabb061 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2167,21 +2167,6 @@ static void mptcp_retransmit_timer(struct timer_list *t)
>>> 	sock_put(sk);
>>> }
>>>
>>> -static struct mptcp_subflow_context *
>>> -mp_fail_response_expect_subflow(struct mptcp_sock *msk)
>>> -{
>>> -	struct mptcp_subflow_context *subflow, *ret = NULL;
>>> -
>>> -	mptcp_for_each_subflow(msk, subflow) {
>>> -		if (READ_ONCE(subflow->mp_fail_response_expect)) {
>>> -			ret = subflow;
>>> -			break;
>>> -		}
>>> -	}
>>> -
>>> -	return ret;
>>> -}
>>> -
>>> static void mptcp_timeout_timer(struct timer_list *t)
>>> {
>>> 	struct sock *sk = from_timer(sk, t, sk_timer);
>>> @@ -2507,19 +2492,16 @@ static void __mptcp_retrans(struct sock *sk)
>>>
>>> static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
>>> {
>>> -	struct mptcp_subflow_context *subflow;
>>> -	struct sock *ssk;
>>> +	struct sock *ssk = msk->fail_ssk;
>>> 	bool slow;
>>>
>>> -	subflow = mp_fail_response_expect_subflow(msk);
>>> -	if (subflow) {
>>> -		pr_debug("MP_FAIL doesn't respond, reset the subflow");
>>> +	pr_debug("MP_FAIL doesn't respond, reset the subflow");
>>>
>>> -		ssk = mptcp_subflow_tcp_sock(subflow);
>>> -		slow = lock_sock_fast(ssk);
>>> -		mptcp_subflow_reset(ssk);
>>> -		unlock_sock_fast(ssk, slow);
>>> -	}
>>> +	slow = lock_sock_fast(ssk);
>>> +	mptcp_subflow_reset(ssk);
>>> +	unlock_sock_fast(ssk, slow);
>>> +
>>> +	msk->fail_ssk = NULL;
>>> }
>>>
>>> static void mptcp_worker(struct work_struct *work)
>>> @@ -2562,7 +2544,7 @@ static void mptcp_worker(struct work_struct *work)
>>> 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
>>> 		__mptcp_retrans(sk);
>>>
>>> -	if (time_after(jiffies, msk->fail_tout))
>>
>> Hi Geliang -
>>
>> This condition could be unexpectedly true depending on how close 'jiffies'
>> is to wrapping around, if msk->fail_tout remains at its default 0 value...
>>
>>> +	if (msk->fail_ssk && time_after(jiffies, msk->fail_tout))
>>
>> ...so it's important to fix it like this!
>>
>> I think the two patches should be re-squashed to avoid introducing the issue
>> in the previous commit. Sound good?
> 
> Sure. Please update the subject and commit log when squashing this patch:
> 
> '''
> mptcp: refactor MP_FAIL response
> 
> mptcp_mp_fail_no_response shouldn't be invoked on each worker run, it
> should be invoked only when MP_FAIL response timeout occurs.
> 
> This patch refactors the MP_FAIL response logic.
> 
> Add fail_tout in mptcp_sock to record the MP_FAIL timestamp. Check it
> in mptcp_worker() before invoking mptcp_mp_fail_no_response(). Drop
> the code to reuse sk_timer for MP_FAIL response.
> 
> Add fail_ssk struct member in struct mptcp_sock to record the MP_FAIL
> subsocket. It can replace the mp_fail_response_expect flag in struct
> mptcp_subflow_context. Drop mp_fail_response_expect_subflow() helper,
> just use this fail_ssk in mptcp_mp_fail_no_response() to reset the
> subflow.
> '''
> 
> Thanks,
> -Geliang
> 
>>
>> Also, I think the change should be for mptcp-net so we can get the fix in to
>> 5.19-rcX

Thank you for the patches and the reviews!

I just squashed these two patches and applied in "Fixed for -net" part.

@Mat: careful that there is a conflict when merging with net-next,
please see below:

I also renamed the subject because "mptcp: refactor MP_FAIL response"
didn't sound like a fix. Feel free to suggest better subject :)


- 9f0b1fb5ff57: mptcp: invoke MP_FAIL response when needed
- Results: 96aa91051266..5ffedd7d32e6 (export-net)

- a87560169aa5: conflict in t/mptcp-add-scheduled-in-mptcp_subflow_context
- Results: 91b7cc881cdd..19fb763aac71 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220609T145706
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220609T145706
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
