Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BD846D
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513395; cv=none; b=oZNuU/KrSid5ssQ5cWO2RZYLUnkGGB0s9dIcAucVI7WAsVrcCAQans/CdgplYAuzVmpTBqAyURJMtLzqHn5opS0Wvh4BHgH6gVJLDkvfjffznt1hPMgiJpNzO4z4cfczDF/DLR/qTZnNjM5UwxgSc26za2/2yUHwrzmp7hjIeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513395; c=relaxed/simple;
	bh=WNsnnfl9tkOzsdxiPtqCy5g0mhyAL2ZXyAjPYMm3lRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktk94YCYADKYhfFoYHfWRuETai6uyB1diPvsvv1EYCEZxC6GBpn/wnO3PnJF+SJLXJRvTsS4bWS9c4Yy94Wzx13mPu6Er3EUVLQqfTj8pOJmmGn+0fEFSIv/hbsoVfpJobp8U8Q9RKOAIg1SYnj7wZw48ilGCbKqdv71jXxFH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrND2pT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrND2pT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19533C2BBFC;
	Tue,  4 Jun 2024 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513395;
	bh=WNsnnfl9tkOzsdxiPtqCy5g0mhyAL2ZXyAjPYMm3lRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NrND2pT65pghPbOpY6TERW+CT56g0CY4kQbazU5FV31RvF5mDkYiQ4toNcnEnaD4X
	 3VYgBqfOBY5UtCp3QpkxMwE1J35rJg41nw/X5yKc0Lo3Z2kFNMZx6N6Tx10hQI4c7Z
	 FNDhhM6qJf+W2cbLUisIFNOc/rjTOWzHhmZPI0cVamJQzFXWrsGDDiqQStDGvrdx2O
	 JTrcOqL72kF78eHZAf0k/1DqRnLGXrrZo9qQ4Ba87PchMJNBVwkhS7AmBAad/1UNoO
	 Lwqt55AqHCNLQF9AVVaNapB0jNS6R4iYxFpomGUl95GNypO/yN4JQl0vCRbT/DH8h4
	 9flDowbEeRZdA==
Message-ID: <70d94f2e-b357-4ddf-8cd0-41212dfe9397@kernel.org>
Date: Tue, 4 Jun 2024 17:03:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] mptcp: update add_addr_accepted and accept_add after
 subflow added
Content-Language: en-GB
To: YonglongLi <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com, geliang@kernel.org
References: <1716543865-37448-1-git-send-email-liyonglong@chinatelecom.cn>
 <1990877063.5336.1716773859206.JavaMail.root@jt-retransmission-dep-59f6f76b7b-svmkb>
 <9baca944-9777-445b-8344-d6755c65a509@chinatelecom.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9baca944-9777-445b-8344-d6755c65a509@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yonglong Li,

Thank you for the reply!

On 29/05/2024 11:37, YonglongLi wrote:
> Hi Matt,
> 
> Sorry for the late relay. And thanks for your review.
> 
> On 5/24/2024 23:06, Matthieu Baerts wrote:
>> Hi Yonglong Li,
>>
>> On 24/05/2024 11:44, Yonglong Li wrote:
>>> From: YonglongLi <liyonglong@chinatelecom.cn>
>>>
>>> receive RM_ADDR will update pm.add_addr_accepted and pm.add_addr_accepted
>>> only if remove id match remote id of subflow. so receive ADD_ADDR should
>>> update pm.add_addr_accepted and pm.add_addr_accepted after subflow added
>>> to conn_list.
>>
>> Do you think it could be possible to cover this case by modifying/adding
>> one subtest in our selftests?
>>
> 
> yes, test case for this issue like this:
> 
>        if reset "remove invalid address and re-add"; then
>                pm_nl_set_limits $ns1 2 2
>                pm_nl_set_limits $ns2 2 2
>                pm_nl_add_endpoint $ns1 224.0.0.1  flags signal
>                #pm_nl_add_endpoint $ns1 10.0.4.1  flags signal
>                run_tests $ns1 $ns2 10.0.1.1 0 -1 0 speed_10 2>/dev/null &
>                sleep 0.5
> 
>                pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>                wait_mpj $ns2
>                chk_join_nr 2 2 2

Just to be sure I understand the patch: before the modification, here,
we only see one MP_JOIN, because the client has reached the limit of 2
subflows: one subflow to "224.0.0.1" and one to "10.0.2.1". The reason
is that even if the subflow to "224.0.0.1" has failed, it has
incremented the counter, but this counter will never be decremented,
even after having received a RM_ADDR, right?

So there are naively 3 solutions I guess:

(1) either we make sure the counter is decremented when receiving the
corresponding RM_ADDR
(2) or increment it either only in case of success
(3) or to decrement it only in case of failure

For (1), we want to decrement the counter only for used addresses: it
means the counter should have been decremented before if the address is
no longer used (or we need to store received ADD_ADDR).

If we don't want to store received ADD_ADDR, for (2) and (3), we need to
take into account two types of errors:

(a) at the creation time, when calling __mptcp_subflow_connect(): in
this case, the subflow will not be part of the conn_list after the call

(b) later on: after having received a RST, ICMP, timeout, ... or the
other peer simply decided to close it.

For (a), that can be done with the patch you sent. For (b), that's a bit
more complex, and linked with the diff you sent below.

>                chk_rm_nr 1 0 invert
>                chk_add_nr 3 3
>                chk_rst_nr 0 0
>                kill_tests_wait
>        fi
> 
> 
>> The commit message is not very clear to me. ("add_addr_accepted" are
>> also always duplicated, I'm not sure why).
> 
> sorry for mistake. my origin mean is "pm.add_addr_accepted and pm.accept_addr"

OK, clearer.

>> I understand we can have issues with __mptcp_subflow_connect() and we
>> might want to increment the counter only if it was possible to create a
>> subflow (even if the connection can fail later -- I'm not sure whether
>> we decrement the counter in this case as well), but I'm not sure to
>> understand the context: the reason why this call could fail, and the
>> link with RM_ADDR.
>>
> 
> I think we should make sure that update pm.add_addr_accepted and pm.accept_addr
> after new subflow was added into conn_list when receive do ADD_ADDR action. And
> decremant the counter when unlink the last subflow of the addr ID from conn_list.
> 
> decremant the counter like this:
> 
> @@ -827,10 +829,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>                 if (!mptcp_pm_is_kernel(msk))
>                         continue;
> 
> -               if (rm_type == MPTCP_MIB_RMADDR) {
> -                       msk->pm.add_addr_accepted--;
> -                       WRITE_ONCE(msk->pm.accept_addr, true);
> -               } else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
> +               if (rm_type == MPTCP_MIB_RMSUBFLOW) {
>                         msk->pm.local_addr_used--;
>                 }
>         }
> 
> @@ -757,11 +757,32 @@ static void subflow_ulp_fallback(struct sock *sk,
>  void mptcp_subflow_drop_ctx(struct sock *ssk)
>  {
>         struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
> +       struct mptcp_sock *msk = NULL;
> 
>         if (!ctx)
>                 return;
> 
>         list_del(&mptcp_subflow_ctx(ssk)->node);
> +        if (ctx->conn)
> +                msk = mptcp_sk(ctx->conn);
> +        if (msk && !list_empty(&msk->conn_list)) {
> +                struct mptcp_subflow_context *subflow, *tmp;
> +                u8 id = subflow_get_local_id(ctx);
> +                bool lastone = true;
> +                mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +                        if (id == 0 || id == subflow_get_local_id(subflow)) {
> +                                lastone = false;
> +                                break;
> +                        }
> +                }
> +                if (lastone == true) {
> +                        spin_lock_bh(&msk->pm.lock);
> +                        msk->pm.add_addr_accepted++;

(you want to decrement it I suppose)

> +                        WRITE_ONCE(msk->pm.accept_addr, true);
> +                        spin_unlock_bh(&msk->pm.lock);
> +                }
> +        }
> +
>         if (inet_csk(ssk)->icsk_ulp_ops) {
>                 subflow_ulp_fallback(ssk, ctx);
>                 if (ctx->conn)
> 
> And do the same thing in __mptcp_close_ssk

Yes, that's the idea (but this should be done in pm_netlink.c, only if
the in-kernel PM is being used, etc.)

I wonder if it would not be interesting to keep the list of received
ADD_ADDR instead of relying on the conn_list. That might simplify the
case here, and the in-kernel PM code in general I think, no? If we want
to take this direction, we can still apply the patch here (with a better
commit message, and a new selftest) as it fixes one part of the issue,
and it can be backported to older versions. The modification of the
stored ADD_ADDR, and the fix for subflows that are being closed before
receiving an RM_ADDR can be done only in future versions.

I will mention that at our public weekly meeting tomorrow.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

