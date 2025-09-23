Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288CA265CAD
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614951; cv=none; b=mUmWczB/9TIxBpoa57O4JklCdU5uLrpzMNB5w7+7+WHAQ6qgFnYK2TkIEk/ab1cWJt6rUuGiAPsv+CPM6LIPM2EXehJ1JWu1xMhnGviAi7naufT8EuiO7QLgTo4kqENPAgGp4LaCeBdM50oUP8MiIplfu62FWLMhjL8iRnJ5VuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614951; c=relaxed/simple;
	bh=CIrV2u3N9zHD7gZRQKdmBOLSRTZTquEWcNFIMSjoZaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZk78ucq5Or58O3kTFLQOMKBSSXvwy5fa8qcKQ7qOV11n7ms0u6MIkfV5JLv1lytxADdnREX2ZoKvfKVTMb1qRMQvflXpWXv73WxxaE94bAjPSMfoWuK7QPG1NfHKGVCJCHh+ClDTBmMz/FyuwKXtrTCRKWX+j3U1X0eM90VYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMYFFI+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMYFFI+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A899C4CEF5;
	Tue, 23 Sep 2025 08:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614950;
	bh=CIrV2u3N9zHD7gZRQKdmBOLSRTZTquEWcNFIMSjoZaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gMYFFI+cF7OK7ZtNAemWVml2URsYxJH92ILaEaL7B7yb3la/9y5qOqB0BxotZu0/5
	 voTLB0H5pwseyFMszFg2ARI+b0pAoNMLJw7ROjGUMVRkJjSqXS9FBK2JBHFXdD56zp
	 ipRXqLzp7zmBwuQHvdSfAOLuFG1/jQAES1m65EyF95ya9KRCCcLs/2J4u15lROdsFR
	 ZqXblZchH2NmyqcmIa1OiRolp3bcX/8jbQlL8i/+EUqls+q+Hc4Mc8SAzj8gThoZ9D
	 +mHIJAKrjcQPAxfpCEEwQhk7au9Q7gyxHoAxY5lhToj0ElS24mOjgDrqOV2TxKh8KH
	 bQB+0eYWJgQpg==
Message-ID: <587b50ce-3d82-41ae-8115-b1566d4fc784@kernel.org>
Date: Tue, 23 Sep 2025 09:09:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 3/6] mptcp: pm: in-kernel: compare IDs instead
 of addresses
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
 <20250923-pm-kern-endp-add_addr-new-v1-3-60e3a8968f45@kernel.org>
 <9aaa8915-0747-3fe3-ccab-0b2c88ce42c1@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9aaa8915-0747-3fe3-ccab-0b2c88ce42c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 23/09/2025 04:27, Mat Martineau wrote:
> On Tue, 23 Sep 2025, Matthieu Baerts (NGI0) wrote:
> 
>> When receiving an ADD_ADDR right after the 3WHS, the connection will
>> switch to 'fully established'. It means the MPTCP worker will be called
>> to treat two events, in this order: ADD_ADDR_RECEIVED, PM_ESTABLISHED.
>>
>> The MPTCP endpoints cannot have the ID 0, because it is reserved to the
>> address and port used by the initial subflow. To be able to deal with
>> this case in different places, msk->mpc_endpoint_id contains the
>> endpoint ID linked to the initial subflow. This variable was only set
>> when treating the first PM_ESTABLISHED event, after ADD_ADDR_RECEIVED.
>> That's why in fill_local_addresses_vec(), the endpoint addresses were
>> compared with the one of the initial subflow, instead of only comparing
>> the IDs.
>>
>> Instead, msk->mpc_endpoint_id is now set when treating ADD_ADDR_RECEIVED
>> as well, if needed, then the IDs can be compared.
>>
>> To be able to do so, the code doing that is now in a dedicated helper,
>> and called from the functions linked to the two actions.
>>
>> While at it, mptcp_endp_get_local_id() has also been moved up, next to
>> this new helper, because they are linked, and to be able to use it in
>> fill_local_addresses_vec() in the next commit.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/pm_kernel.c | 81 ++++++++++++++++++++++++++
>> +------------------------
>> 1 file changed, 43 insertions(+), 38 deletions(-)
>>
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index
>> ae6ab3178c226fe3ec66d156bb0dc919075043e5..7be454196a41f625100a6e0d6cbf1ee360dff553 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -268,6 +268,44 @@ __lookup_addr(struct pm_nl_pernet *pernet, const
>> struct mptcp_addr_info *info)
>>     return NULL;
>> }
>>
>> +static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
>> +                  const struct mptcp_addr_info *addr)
>> +{
>> +    return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
>> +}
>> +
>> +static void mptcp_set_mpc_endpoint_id(struct mptcp_sock *msk)
> 
> Hi Matthieu -
> 
> I see how this was pulled out of the function below, but it is both
> setting the id and taking action to send the MP_PRIO. Is there a better
> name for what it's doing? mptcp_mpc_endpoint_setup() ?

Good idea!

> Or maybe handle MP_PRIO in a separate helper?

Mmh, it should be done only once, when looking at the MPC endpoint,
under the same conditions. I think it might be easier to keep it there,
but rename the helper, no?

>> +{
>> +    struct mptcp_subflow_context *subflow;
>> +    struct mptcp_pm_addr_entry *entry;
>> +    struct mptcp_addr_info mpc_addr;
>> +    struct pm_nl_pernet *pernet;
>> +    bool backup = false;
>> +
>> +    /* do lazy endpoint usage accounting for the MPC subflows */
>> +    if (likely(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED)) ||
>> +        !msk->first)
>> +        return;
>> +
>> +    subflow = mptcp_subflow_ctx(msk->first);
>> +    pernet = pm_nl_get_pernet_from_msk(msk);
>> +
>> +    mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
>> +    rcu_read_lock();
>> +    entry = __lookup_addr(pernet, &mpc_addr);
>> +    if (entry) {
>> +        __clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
>> +        msk->mpc_endpoint_id = entry->addr.id;
>> +        backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>> +    }
>> +    rcu_read_unlock();
>> +
>> +    if (backup)
>> +        mptcp_pm_send_ack(msk, subflow, true, backup);
>> +
>> +    msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
>> +}
>> +
>> static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock
>> *msk)
>> {
>>     u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
>> @@ -278,28 +316,7 @@ static void
>> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>>     bool signal_and_subflow = false;
>>     struct mptcp_pm_local local;
>>
>> -    /* do lazy endpoint usage accounting for the MPC subflows */
>> -    if (unlikely(!(msk->pm.status &
>> BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
>> -        struct mptcp_subflow_context *subflow =
>> mptcp_subflow_ctx(msk->first);
>> -        struct mptcp_pm_addr_entry *entry;
>> -        struct mptcp_addr_info mpc_addr;
>> -        bool backup = false;
>> -
>> -        mptcp_local_address((struct sock_common *)msk->first,
>> &mpc_addr);
>> -        rcu_read_lock();
>> -        entry = __lookup_addr(pernet, &mpc_addr);
>> -        if (entry) {
>> -            __clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
>> -            msk->mpc_endpoint_id = entry->addr.id;
>> -            backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>> -        }
>> -        rcu_read_unlock();
>> -
>> -        if (backup)
>> -            mptcp_pm_send_ack(msk, subflow, true, backup);
>> -
>> -        msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
>> -    }
>> +    mptcp_set_mpc_endpoint_id(msk);
>>
>>     pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
>>          msk->pm.local_addr_used, endp_subflow_max,
>> @@ -396,12 +413,9 @@ fill_local_addresses_vec_fullmesh(struct
>> mptcp_sock *msk,
>>     struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
>>     struct sock *sk = (struct sock *)msk;
>>     struct mptcp_pm_addr_entry *entry;
>> -    struct mptcp_addr_info mpc_addr;
>>     struct mptcp_pm_local *local;
>>     int i = 0;
>>
>> -    mptcp_local_address((struct sock_common *)msk, &mpc_addr);
>> -
>>     rcu_read_lock();
>>     list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
>>         if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
>> @@ -419,8 +433,7 @@ fill_local_addresses_vec_fullmesh(struct
>> mptcp_sock *msk,
>>             __clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
>>
>>         /* Special case for ID0: set the correct ID */
>> -        if (mptcp_addresses_equal(&local->addr, &mpc_addr,
>> -                      local->addr.port))
>> +        if (local->addr.id == msk->mpc_endpoint_id)
>>             local->addr.id = 0;
>>
>>         msk->pm.extra_subflows++;
>> @@ -443,12 +456,9 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock
>> *msk,
>>     struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
>>     u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
>>     struct sock *sk = (struct sock *)msk;
>> -    struct mptcp_addr_info mpc_addr;
>>     struct mptcp_pm_local *local;
>>     int i = 0;
>>
>> -    mptcp_local_address((struct sock_common *)msk, &mpc_addr);
>> -
>>     while (msk->pm.local_addr_used < endp_subflow_max) {
>>         local = &locals[i];
>>
>> @@ -460,8 +470,7 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock
>> *msk,
>>         if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
>>             continue;
>>
>> -        if (mptcp_addresses_equal(&local->addr, &mpc_addr,
>> -                      local->addr.port))
>> +        if (local->addr.id == msk->mpc_endpoint_id)
>>             continue;
>>
>>         msk->pm.local_addr_used++;
>> @@ -507,6 +516,8 @@ fill_local_addresses_vec(struct mptcp_sock *msk,
>> struct mptcp_addr_info *remote,
>>     bool c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
>>     int i;
>>
>> +    mptcp_set_mpc_endpoint_id(msk);
>> +
> 
> What do you think about moving this before the call to
> fill_addresses_vec() in mptcp_pm_nl_add_addr_received()? Again, taking
> this action is different from filling the vector.

Good idea! I was so focus working around fill_addresses_vec(), I forgot
it was called from mptcp_pm_nl_add_addr_received()!

> 
>>     /* If there is at least one MPTCP endpoint with a fullmesh flag */
>>     i = fill_local_addresses_vec_fullmesh(msk, remote, locals,
>> c_flag_case);
>>     if (i)
>> @@ -927,12 +938,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff
>> *skb, struct genl_info *info)
>>     return ret;
>> }
>>
>> -static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
>> -                  const struct mptcp_addr_info *addr)
>> -{
>> -    return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
>> -}
>> -
>> static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
>>                       const struct mptcp_addr_info *addr,
>>                       bool force)
>>
>> -- 
>> 2.51.0
>>
>>
>>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

