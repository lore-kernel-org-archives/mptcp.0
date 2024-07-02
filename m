Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CB84D39
	for <mptcp@lists.linux.dev>; Tue,  2 Jul 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910272; cv=none; b=h1Szf8xWpPt44j8dXWZjJO8MaxkI33yWNG+pbGmWOsrhl/dW5jvbhfmjgyptKxQTM+wjq1DCIFNdYrMs5CtklyOa02AqMwL1pvXYq1eWZ2c6PckOnUgpg280cxzCI8TkW5BROxyc1FmFvkIfDX3bPL/7K33hS1fMeZ5sBPb6ajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910272; c=relaxed/simple;
	bh=yOKMwK/fhC7kRUOKykLDr0UZ3UhD8CzyvWkXCHogCxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTrBJfgm/4ccxvNCLf3yvSS/UQYv/qKuuzR7Lq/r72CdififmX5bDzpXO/vlGNih64BtgNFjT+8IKc6REJZmcGXm+NUjDyxcT/ZOt8dIktmv6qDwZ6p5M9ngdaMPmx2rS1F5gRyOxyF3sNdDAhqLJdBC3ypCxcG0fWnHsbgd/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExDpacO9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExDpacO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596D9C116B1;
	Tue,  2 Jul 2024 08:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719910272;
	bh=yOKMwK/fhC7kRUOKykLDr0UZ3UhD8CzyvWkXCHogCxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ExDpacO9P8xeTrRJueM3Ky2TW1l2VviZ39nsqVaBeq3Dzh0HMjVw8SPehsNYa+jjM
	 cUUqkEL2DYlPtbOl3YGw1ZABM+vQ0/OSFRyG+AyI4rVJwJHm/qhnt43Pvds5Ho0hO6
	 7i1AXZDFYHs67kIH4gARAxc5iuUCllz8etar3+kw1JTeldKk0SBKIwD5xpeFg08FLO
	 5CgqnAG3l4zYmITVtO4jntoscVY31H0xVVyg4NMiky4IvY53crsePBKeIuWJ8/BIXh
	 nTZUKQQO7m3oSGte1khuWJvn/2x775HqFExbiHmF9x0Q/8C6R0FFgClBtpBmGnWaWs
	 uDFH8FzbzQD4A==
Message-ID: <82e70747-2a6e-4a40-b5f7-573b23317780@kernel.org>
Date: Tue, 2 Jul 2024 10:51:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/3] mptcp: fix announced address accounting
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1719589916.git.pabeni@redhat.com>
 <4a8ac95282ec2b551a64134f24b2e2fd7d82973c.1719589916.git.pabeni@redhat.com>
 <f5abcf0d-1ca3-5601-3159-2d553f3591c4@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f5abcf0d-1ca3-5601-3159-2d553f3591c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 01/07/2024 20:08, Mat Martineau wrote:
> On Fri, 28 Jun 2024, Paolo Abeni wrote:
> 
>> Currently the per connection announced address counter is never
>> decreased. As a consequence, after connection establishment, if
>> the NL PM deletes an endpoint and adds a new/different one, no
>> additional subflow is created for the new endpoint even if the
>> current limits allow that.
>>
>> Address the issue properly updating the signaled address counter
>> every time one of such address is removed.

Thank you for having looked at that!

>> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> slightly unrelated: is unclear to me why mptcp_pm_remove_addrs() does
>> things slightly differently from mptcp_pm_remove_addrs_and_subflows(),
>> with the latter IMHO doing the right thing (TM)
> 
> Hi Paolo -
> 
> I don't remember why mptcp_pm_remove_addrs() has the extra code to send
> the RM_ADDR for addresses that are in the conn_list but not the
> anno_list. Maybe to allow a way to sent RM_ADDR as a "request for the
> peer to initiate a disconnect" even on implicitly added address IDs
> (from outgoing subflow connections instead of ADD_ADDRs)?

mptcp_pm_remove_addrs() is only used by the userspace PM, it should
probably be moved to pm_userspace.c in fact (but it uses helpers from
pm_netlink.c, I guess that's why it is there). My understanding is that
it also checks the local subflows list because the userspace can ask to
send a remove ADDR for addresses that have been "implicitly" announced
via the MPJoin as well.

Maybe the modification in mptcp_pm_remove_addrs() should be in a
different commit? With a different Fixes tag then:

  Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")

> 
>> ---
>> net/mptcp/pm_netlink.c | 27 +++++++++++++++++++--------
>> 1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index ea9e5817b9e9..624f9ea66aea 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1401,6 +1401,7 @@ static bool mptcp_pm_remove_anno_addr(struct
>> mptcp_sock *msk,
>>     ret = remove_anno_list_by_saddr(msk, addr);
>>     if (ret || force) {
>>         spin_lock_bh(&msk->pm.lock);
>> +        msk->pm.add_addr_signaled--;
> 
> Looks like this only be decremented if ret is true, since that indicates
> a list element was removed and add_addr_signaled is supposed (?) to
> track the length of the anno_list.

Good point.

Should we not also set the corresponding bit in:

  msk->pm.id_avail_signals_bitmap

Linked to my series:


https://lore.kernel.org/mptcp/20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org/T/

Otherwise, we will not be able to re-use the same ID, no?

And if we change add_addr_signaled counter here after having removed an
address, maybe now we are no longer at the signalled limit, should we
then call mptcp_pm_create_subflow_or_signal_addr()?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

