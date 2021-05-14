Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED772
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 18:41:23 +0000 (UTC)
IronPort-SDR: n51RMmg+Z5/y/UbEk+24SsLnFujoHOdPGyeRLtSBeTGiurCnS+D/IxL5eGfQYlRAL7Lvoql5Rl
 i0pitarj3kVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="285746950"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="285746950"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 11:41:22 -0700
IronPort-SDR: g5rgAmIODGhoNevcN5RagcCpjrDsW+aiPe7XKqib2GpjDvAGJu43eCmqugqnDBLSoE429QxV5D
 mtlqqa0ZbP2Q==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="624808474"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 11:41:22 -0700
Date: Fri, 14 May 2021 11:41:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH net] mptcp: validate 'id' when stopping the ADD_ADDR
 retransmit timer
In-Reply-To: <YJ4/V56p8zc/gcoy@dcaratti.users.ipa.redhat.com>
Message-ID: <543af854-5578-b9d1-d3b4-1a9cc19da4a@linux.intel.com>
References: <68c6032edaf880a958bf7f65afc7e9520f39d5cd.1620754971.git.dcaratti@redhat.com> <e03119dc-67cb-6ac1-67fe-d92a8f954e4@linux.intel.com> <YJ4/V56p8zc/gcoy@dcaratti.users.ipa.redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2081430717-1621017682=:47168"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2081430717-1621017682=:47168
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 14 May 2021, Davide Caratti wrote:

> hello Mat, thanks for reviewing!
>
> On Tue, May 11, 2021 at 03:39:14PM -0700, Mat Martineau wrote:
>> On Tue, 11 May 2021, Davide Caratti wrote:
>>
>>> when Linux receives an echo-ed ADD_ADDR, it checks the IP address against
>>> the list of "announced" addresses. In case of a positive match, the timer
>>> that handles retransmissions is stopped regardless of the 'Address Id' in
>>> the received packet: this behaviour does not comply with RFC8684 §3.4.1.
>>>
>>> Fix it by validating the 'Address Id' in received echo-ed ADD_ADDRs.
>>> Tested using packetdrill, with the following captured output:
>>>
>>
>> Hi Davide -
>>
>> The code path for ADD_ADDR echo ignores the return value of
>> mptcp_pm_del_add_timer(), so there's no chance there of leaving
>> entry->add_timer running if the addr.id doesn't match.
>
> true, and that's the purpose of this patch. When addr.id doesn't match,
> it leaves the timer running to allow another attempt of ADD_ADDR + HMAC.
>
>> The function is also called by remove_anno_list_by_saddr(), which will free
>> 'entry' if a non-NULL value is returned by mptcp_pm_del_add_timer(). There's
>> more of a chance here that the sk_stop_timer_sync() would be skipped and
>> entry would be freed anyway. Looking at the various paths to this in the
>> path manager it seems like it *should* not happen, but I'm not convinced
>> it's impossible. Did you look at the effect of this change on these other
>> code paths?
>
> good point, I only tried packetdrill and the kselftests. I see
>
> mptcp_pm_remove_anno_addr()
>  remove_anno_list_by_saddr()
>
> and its callers: in this case,either 'addr.id' is always read from the return
> value of
>
> __lookup_addr_by_id(pernet, addr.addr.id);
>
> or by iterating over
>
> &pernet->local_addr_list
>
> , so those should all be 'signal' endpoints previously added by netlink:
> the value of addr.id should always match and the timer should always
> be stopped.
>
> However, I also don't feel 100% safe - because 'entry' is freed by
> remove_anno_list_by_saddr() and the value of 'address.id' is never checked
> in addresses_equal(). Maybe it's safer to do soemething like:
>
> 347 struct mptcp_pm_add_entry *
> 348 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> 349                        struct mptcp_addr_info *addr, bool strict)
> 350 {
> 351         struct mptcp_pm_add_entry *entry;
> 352         struct sock *sk = (struct sock *)msk;
> 353
> 354         spin_lock_bh(&msk->pm.lock);
> 355         entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
> 356         if (entry && strict && entry->addr.id == addr->id)
> 357                 entry->retrans_times = ADD_ADDR_RETRANS_MAX;
> 358         spin_unlock_bh(&msk->pm.lock);
> 359
> 360         if (entry && strict && entry->addr.id == addr->id)
> 361                 sk_stop_timer_sync(sk, &entry->add_timer);
> 362
> 363         return entry;
> 364 }
>
>
> so that mptcp_pm_del_add_timer(..., true) is called only in the receive
> path of echo-ed ADD_ADDR. WDYT?
>

I think that's the right general direction, but (entry && (!strict || 
entry->addr.id == addr->id)) is the logic needed for the !strict callers 
to work like before.

--
Mat Martineau
Intel
--0-2081430717-1621017682=:47168--
