Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310765;
	b=jwp33Hy1ecWlihmGoPDI2JoD0FDqDRVAXBQCCb0jcvg0ibo5roMN2u/NjwWUBn+tl56e
	 ewnDaDO3YG0PpLJjcy34p6qNI/Bde8nQMydhA7BDv59iyz89nfPsQuBZLgWSFPQXk/OuY
	 kVZBYySAXCoP8e8RaTSwb0qhmlCF9UyaGNT+UDUC5SaFPmG1fElCbbf8kqa8Yg9/v2G65
	 t9tAIH4m9f5KWQYI8LZkp3FrQ+eLu5NjE5lFm8x7ppiHYfl1diYJ/ztRt2dBnXakSgGsl
	 ENM1aPgEkRpucGkwq0xTgOzPqptyKzy+08Ke3GIEGT8TU7G1Fb4s0oe3FS0tkb6HH2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310765;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=61iXqObBoRbHUHb9L4kL8O8fx5dOAyzxdr1sttsno+Q=;
	b=gh1QRi/iTOhcifhp28L3oQ129fPqmtyNdZ68G4wkiJs/KxXthaddgzIECIrTouPatEhd
	 xIV3gv1ixJoZzj3N2AjYqXhQ4k08QsY5eX9C0oWFiq70zMOjmdSTr2jRHDI9Ik3060+Gt
	 CCI2Vi2tjtgSiBalVJK7SdDWBCpK1jxtxzFpSTLa4Wb0OoxEihOkcOClm7zgwb0lWTsl6
	 VyfOL8Ls7/3qu8cJm9BK8rwmV5vGBdcSrlSDWlQ2cvCB5C5eU9SUzMzHmywdrPoCOXXJ5
	 Z3wRxgzSXhIqk3xJ4xqO1WfufCorj5FYFzmCJAb3sWcVtEcWnPMNWb10FDBIDhLt/4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlmAFEMc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA995606A325;
	Tue, 10 Nov 2026 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlmAFEMc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A651F008A4;
	Tue, 10 Nov 2026 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310764;
	bh=61iXqObBoRbHUHb9L4kL8O8fx5dOAyzxdr1sttsno+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FlmAFEMco9/vwwZbY1x8fMa9VkyGo8Df7nTFSSqeQhLgEQHtOi6cU4wOqdby450d6
	 BWgQypHzu6Tos01Zo4HfEFhVTLrDFkvBgMu9pXyZD6WE5RlrnEolFRedJG7co7Rd6D
	 0E3Yf9cD2hiPF+GWkagrC9FcY/1LSy70+xSkIRQDKD2q621tDE90SNpLywhUAe8RJJ
	 +sq5bHADVIvLUGE06ap5bvJWFWD9Ato/I9Hvbcvhegtd7Hy+2067KShGC4KW+zMq1Y
	 IU5Ml58hrfpv3lUf5lnV1DakoACGL3zC1olgnaTv0YwnuAJnOJrtJ+p0Q1sYAaW2jC
	 ib3VCUivyMPGg==
Message-ID: <f3949fb9-8f4c-488a-810b-1f5be8044a42@kernel.org>
Date: Tue, 10 Nov 2026 12:39:20 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 6/6] Squash to previous one
Content-Language: fr
To: gang.yan@linux.dev
Cc: sashiko-reviews@lists.linux.dev, mptcp@lists.linux.dev
References: <cover.1790147728.git.yangang@kylinos.cn>
 <6a1cbdd1a0f4866ff6cda3b8679450172c203f5b.1790147728.git.yangang@kylinos.cn>
 <20260923101140.E62E41F000FF@smtp.kernel.org>
 <da961f27c729d9232a59e509e8e3c2f50bc1db00@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <da961f27c729d9232a59e509e8e3c2f50bc1db00@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

On 24/09/2026 03:53, gang.yan@linux.dev wrote:
> September 23, 2026 at 6:11 PM, sashiko-bot@kernel.org mailto:sashiko-bot@kernel.org  wrote:
> 
> 
>>
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] mptcp: uaf and uninitialized access in pm_ops during disconnect
>> --
>>
>> commit 89b80a47ef923bdc04a9069fdcf06de447841c5b
>> Author: Gang Yan <yangang@kylinos.cn>
>>
>> Squash to previous one
>>
>> This patch applies RCU discipline to msk->pm.ops, moving its initialization,
>> publication, and release to better align with RCU patterns. It updates readers
>> to use rcu_dereference() and writers to use rcu_assign_pointer() under the
>> PM lock.
>>
>> Link: https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@linux.dev?part=5
>>
>>>
>>> mptcp_destroy(), the final close path: mptcp_token_destroy() has
>>>  already removed the socket from the token hash by then, so no new
>>>  reader can find the msk anymore.
>>>  
>>>  Note that rcu_assign_pointer() before pm_ops->init(msk) does not
>>>  publish a partially initialised object: the ops are registered
>>>  immutable, init() only prepares the per-socket state, and the msk is
>>>  not reachable by readers until its token is registered.
>>>
>> [Severity: High]
>> Is this assumption accurate? A concurrent SoftIRQ can receive an MP_JOIN
>> request, look up the socket via mptcp_token_get_sock(), increment its refcnt,
>> and drop the RCU read lock. Concurrently, the socket could be disconnected,
>> calling mptcp_disconnect() -> mptcp_pm_data_reset() -> mptcp_pm_ops_init().
>>
>> The SoftIRQ thread could then re-acquire the RCU read lock and call
>> mptcp_pm_get_local_id(), accessing the actively tearing down or uninitialized
>> per-socket state.
> 
> The concurrent softirq reader you describe does exist -- that is
> exactly the race this patch fixes. But note what that reader
> consumes: mptcp_pm_get_local_id() consults the per-net endpoint
> table (inside its own RCU section) and the msk addresses; it does
> not read any of the per-socket state managed by init()/release()
> (pm->work_pending, accept_addr, ...), which is only consumed by
> the PM worker under the socket lock. So the reader cannot observe
> the teardown/reset of the fields those callbacks manage. It's safe
> for now.
> 
>>
>> [ ... ]
>>
>>>
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>>  index 64244a1a01bca..66fb7c3d9c827 100644
>>>  --- a/net/mptcp/pm.c
>>>  +++ b/net/mptcp/pm.c
>>>
>> [ ... ]
>>
>>>
>>> @@ -1158,23 +1166,39 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>>>  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
>>>  struct mptcp_pm_ops *pm_ops)
>>>  {
>>>  - if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
>>>  - pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
>>>  - pm_ops = &mptcp_pm_kernel;
>>>  + struct mptcp_pm_ops *old;
>>>  +
>>>  + spin_lock_bh(&msk->pm.lock);
>>>  + old = rcu_dereference_protected(msk->pm.ops,
>>>  + lockdep_is_held(&msk->pm.lock));
>>>  + if (old != pm_ops)
>>>  + rcu_assign_pointer(msk->pm.ops, pm_ops);
>>>
>> [Severity: High]
>> Does this publish the new ops to readers before its state is initialized via
>> init(msk) below? If a reader finds the socket, it could access the new ops
>> before its per-socket state is ready.
>>
> 
> On the publish-before-init concern: pm_ops->init(msk) prepares
> the per-socket state, not the ops -- the ops are registered
> immutable, their callbacks are valid from registration. A reader
> entering between the assign and init() would call valid ops code
> and read fields it does not consume (see comments above); this
> ordering also matches the previous, non-RCU code.
> 
>>>
>>> + spin_unlock_bh(&msk->pm.lock);
>>>  +
>>>  + if (old) {
>>>  + synchronize_rcu();
>>>  + if (old->release)
>>>  + old->release(msk);
>>>
>> [Severity: High]
>> If old == pm_ops, we skip the rcu_assign_pointer() above, meaning the ops
>> are still actively published in msk->pm.ops. Does calling old->release(msk)
>> here violate RCU removal rules by releasing the ops state while it is still
>> reachable by readers?
>>
> 
> On releasing the still-installed ops when old == pm_ops: no
> in-tree PM defines release() today, so this is currently dead
> code. For a future PM that does define it, the synchronize_rcu()
> in front guarantees no in-flight reader is executing the ops when
> release() runs, so no RCU removal rule is violated. It's also an old
> issue raised by sashiko before, this code can address it correctly I
> think (call .release before remove it).
> 
>>>
>>> + bpf_module_put(old, old->owner);
>>>  }
>>>  
>>>  - msk->pm.ops = pm_ops;
>>>  - if (msk->pm.ops->init)
>>>  - msk->pm.ops->init(msk);
>>>  + if (pm_ops->init)
>>>  + pm_ops->init(msk);
>>>  
>>>  pr_debug("pm %s initialized\n", pm_ops->name);
>>>  }
>>>
>> [ ... ]
>>
>>>
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>>  index 14aa82647c3d1..4953cfa329e81 100644
>>>  --- a/net/mptcp/subflow.c
>>>  +++ b/net/mptcp/subflow.c
>>>  @@ -94,14 +94,17 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
>>>  return NULL;
>>>  }
>>>  
>>>  + rcu_read_lock();
>>>  local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
>>>
>> [Severity: High]
>> This is where a concurrent reader accesses the PM ops using a cached msk
>> reference. Does this disprove the assumption in the commit message that
>> the socket is unreachable, since the reader already holds a reference to msk?
>>
> 
> It's the misleading of the commit message, as the first comment of this letter
> said.
> 
> @Matt, @Geliang
> So for now, I think all the patches in this series are ready for review. It’s
> not urgent, so please take a look when you have time.

Thank you for having replied to Sashiko.

After a quick look, the series looks good to me. Do you mind sending a
new version after a rebase and having squashed 5/6 and 6/6 together, please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

