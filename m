Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183D3D3306;
	Thu, 20 Aug 2026 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216852; cv=none; b=teG/jaX6esh9a0E6hzF1JsLDKhrV2wIbxowZTJibujk1AW+njmqCRsDarBo4g0gXjH54/L7F2XvioydCz+/6b9OLSq8SYtCNFAlj5jhQAcbCNA3Bs4FsuKMsaKNrvhQeftq6h8uDOa7aZAPGkjJsysrv4tdgTFROCL3dxSPB1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216852; c=relaxed/simple;
	bh=6W2azZ1uSmwIVr7f3j4lM3W+QTIq0cH3gahxSI9FzqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKqIoNZGJElyMXq/kfqiBNczOCRSWOkMJ9740iJv2fw41fUWxg6mSz4UiPQdRqgPKl3CSyYHo8bjAeFvG18JkpuOth0uZo9IWMaeY03XHBE1ksa/prCOg/sCYCh2HQhyf8FlsQ4IyiCGm2c9fC+lEw31zolfVUYPC9Hc9GafVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diZygM0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diZygM0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D5F1F000E9;
	Thu, 20 Aug 2026 09:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787216850;
	bh=nOLC2kGzzcwBMFPJjafG0KvSmE4d6Ma9I+0+fw27vM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=diZygM0zqUyXXoZ1ZCdl34aqloQqlIiIDjwSbi+wzwUjTSaqWA4Mj6WNa5PUPBiEB
	 j3EpxWa+CaQ5aLxRw6j7eLmVq9+ie7gZepWCBaLA28rb8tnVPAnT1iTYJXju9U7Zbb
	 Q18Mm5AeoE01rBd2YFOa3KF0PaNLyMf8mdIssOqFLedG1q7EfW3pXAfA0qSsEfDBQL
	 qcPt6KHHk966UoA2hdaPJltogKWFK4WnEKGCNr8FFsxkN9R06+O+veVJl58a4IKoJJ
	 GgAUfC3nRC/Yx7aR7pThc/U1K+XSoN/lXWmzXtxgGBz9TmAW6xEGdbKF2/iRznFfTS
	 AoUg6ujT7Symw==
Message-ID: <f9fe2eb6-e9ef-42d0-8a24-8f5c550f0c78@kernel.org>
Date: Thu, 20 Aug 2026 11:07:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 5/5] Squash to "mptcp: pm: init and release
 mptcp_pm_ops"
Content-Language: fr
To: gang.yan@linux.dev, sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
References: <20260819125629.49823-1-gang.yan@linux.dev>
 <20260819125629.49823-6-gang.yan@linux.dev>
 <20260819131205.3A0201F000E9@smtp.kernel.org>
 <7b85c6e1e4e270bd368fb7dc6d24279c1c20c3b2@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7b85c6e1e4e270bd368fb7dc6d24279c1c20c3b2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

On 20/08/2026 08:36, gang.yan@linux.dev wrote:
> August 19, 2026 at 9:12 PM, sashiko-bot@kernel.org mailto:sashiko-bot@kernel.org  wrote:
> 
>> [Severity: Critical]
>> Since this series introduces mptcp_pm_ops lifetime handling and module
>> references, is there a race condition with concurrent MP_JOIN requests?
>>
>> When an incoming MP_JOIN request is processed in softirq context,
>> subflow_token_join_request() gets the socket via mptcp_token_get_sock(),
>> which doesn't hold lock_sock() or RCU. It then calls:
>>
>> net/mptcp/pm.c:mptcp_pm_get_local_id() {
>>  ...
>>  return msk->pm.ops->get_local_id(msk, &skc_local);
>> }
>>
>> Concurrently, if a local user closes the socket and triggers
>> mptcp_disconnect(msk), it calls mptcp_pm_ops_release() which clears the ops
>> and drops the module reference:
>>
>> net/mptcp/pm.c:mptcp_pm_ops_release() {
>>  ...
>>  msk->pm.ops = NULL;
>>  ...
>>  bpf_module_put(pm_ops, pm_ops->owner);
>> }
>>
>> Could this lead to a NULL pointer dereference or executing freed module code
>> if subflow_token_join_request() executes concurrently with a socket
>> disconnect?
>>
> 
> Hi Matt, Geliang
> 
> @Matt, Could you help me to trigger the CI?

It looks like GitHub was sick that day. I reset the tag manually.

> And I think it is a pre-existing bug: 
> 
> When it calls msk->pm.ops->get_local_id(msk, &skc_local) between
> 'mptcp_distroy_common' (which calls mptcp_pm_ops_release) and
> 'mptcp_pm_data_reset'. The pm.ops will be NULL and cause a NULL deref, right?

Can you first check if this can happen? I thought that
mptcp_destroy_common would first close all subflows, remove the token,
then release everything linked to the PM → so the PM will no longer be
called at that point for this msk, right? (I didn't check)

But maybe this will change when the BPF PM will be fully implemented? I
guess no because msk->pm.ops should only be called from events linked to
the network, so not after mptcp_destroy_common?

> If I'm right, I think we can using rcu to solve this based on this series, like:
> 
>   - Add a helper to get pm.ops, and then call the get_local_id/get_priority under rcu_lock:
> '''
> +static struct mptcp_pm_ops *mptcp_pm_deref(struct mptcp_sock *msk)
> +{
> +       struct mptcp_pm_ops *pm_ops;
> +
> +       pm_ops = rcu_dereference(msk->pm.ops);
> +       return pm_ops ? pm_ops : &mptcp_pm_kernel;
> +}
> +
> 
> bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
>  
>         mptcp_local_address((struct sock_common *)skc, &skc_local);
>  
> -       return msk->pm.ops->get_priority(msk, &skc_local);
> +       return mptcp_pm_deref(msk)->get_priority(msk, &skc_local);
>  }
>  
> So does the mptcp_pm_get_local_id like this.

I think you should then rename the helpers, to make it clear they need
to be used from a RCU read section, and to get a warning when
backporting code around that.

> static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
>                 return NULL;
>         }
>  
> +       rcu_read_lock();
>         local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
>         if (local_id < 0) {
>                 SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
> +               rcu_read_unlock();
>                 sock_put((struct sock *)msk);
>                 return NULL;
>         }
>         subflow_req->local_id = local_id;
>         subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
> +       rcu_read_unlock();
>  
> '''
> 
>   - Refactor the mptcp_pm_ops_init to support reuse socket, and put the
>     mptcp_pm_ops_release into mptcp_destroy:
> '''
>  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
>                               struct mptcp_pm_ops *pm_ops)
>  {
> +       struct mptcp_pm_ops *old = msk->pm.ops;
> +
>         if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
>                 pr_warn_once("pm %s fails, fallback to default pm", pm_ops->name);
>                 pm_ops = &mptcp_pm_kernel;
>         }
>  
> -       msk->pm.ops = pm_ops;
> +       if (old) {
> +               if (old == pm_ops) {
> +                       mptcp_pm_ops_release(msk);

Maybe return here, no need to re-init, right?

> +               } else {
> +                       rcu_assign_pointer(msk->pm.ops, pm_ops);
> +                       synchronize_rcu();
> +                       bpf_module_put(old, old->owner);
> +               }
> +       } else {
> +               rcu_assign_pointer(msk->pm.ops, pm_ops);
> +       }
> +
>         if (msk->pm.ops->init)
>                 msk->pm.ops->init(msk);
>  
> -       pr_debug("pm %s initialized\n", pm_ops->name);
> +       pr_debug("pm %s initialized\n", msk->pm.ops->name);
>  }
>  
> 
> 
> static void mptcp_destroy(struct sock *sk)
>         /* allow the following to close even the initial subflow */
>         msk->free_first = 1;
>         mptcp_destroy_common(msk);
> +       mptcp_pm_ops_release(msk);
>         sk_sockets_allocated_dec(sk);
>  }
> 
> '''
> 
> But I think it is a large fix, do you have any idea?
> 
> And as I said at the beginning, it seeems like not a issue attached to this issue,
> could you review the v3 code with ignoring it ?

Yes, the 4 first patches can be reviewed.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

