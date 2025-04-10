Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51C202C50
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311247; cv=none; b=sggz7D4fJP2iPnLpQfShWzxmGnujF4GMa4SRXjGHIblymhBS70nBZQz1Vi7jCtKjgm5DEUcdwwUaHS3m53anjTGF7XMb9BLOX6OciLyLhdd62LaeI6TcUFYvwNHtNaC0fnqvmYRdTWG59UF/WSmuUkXUo2MYXxoL2LASXdxsuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311247; c=relaxed/simple;
	bh=IRY1hOaZgiSMPss5BrOjTAWOKW2a5ckEjhxgGzKe2aw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mWP5TH6g+iQI8E6O0geJQ5pihRaBP/7DnG0EmPRlfTZAqpdSRUVGXTL54G6APtqTsXuz7wHIgr6AMnvZtWoX/plvyWqlTPniu0CbcL53I4vowz8ws2ewJw1CFqO1q+tBmvRzYe24j0eCFvk+77vqUF1/Q7hiqULaKE0iH3HAq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq7MbwUu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq7MbwUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE8EC4CEDD;
	Thu, 10 Apr 2025 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744311246;
	bh=IRY1hOaZgiSMPss5BrOjTAWOKW2a5ckEjhxgGzKe2aw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bq7MbwUu5QIVDnJ5uUj1zZA2LzePv1zFuHjLR6T/KpcYzn1DEj6Ya8qD3UM9b8enu
	 XRGzkmmlQfe5GUPV6aNumHIu0OxUZLlqID7FEbPUYB07ROLR2uJesX7lCvSRCoubmH
	 J9FD8lFvolWZVf+sxdSjG1m68Wee94TqFRx+E96GmakEcikBrsuQ3crm4tNHXFOfaR
	 gb+fEjC4LipJIJqralCntmiYvSEHsuHVapmmB4eUYtBgOHFTKLTNF8IhE+UuS6tEts
	 pYD2PIOlvRv/gY4YlfJ9mw3OqDKghLnfKMjEjpxmmiaqcdluW7pInLsUpe2+5n9QA3
	 vAaURXALEDIvg==
Date: Thu, 10 Apr 2025 11:54:05 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [mptcp-net] mptcp: pm: Defer freeing of MPTCP userspace path
 manager entries
In-Reply-To: <6787063a-9d8f-4489-adf1-f8db7133d3f7@kernel.org>
Message-ID: <325d39df-8867-d2fa-4389-24806c8bc6b2@kernel.org>
References: <20250410025931.1882967-1-martineau@kernel.org> <6787063a-9d8f-4489-adf1-f8db7133d3f7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 10 Apr 2025, Matthieu Baerts wrote:

> Hi Mat,
>
> On 10/04/2025 04:59, Mat Martineau wrote:
>> When path manager entries are deleted from the local address list, they
>> are first unlinked from the address list using list_del_rcu(). The
>> entries must not be freed until after the RCU grace period, but the
>> existing code immediately frees the entry.
>>
>> Use kfree_rcu_mightsleep() and adjust sk_omem_alloc in open code instead
>> of using the sock_kfree_s() helper. This code path is only called in a
>> netlink handler, so the "might sleep" function is preferable to adding
>> a rarely-used rcu_head member to struct mptcp_pm_addr_entry.
>
> Thank you for having looked at this!
>
> Should we add a Fixes tag? The following one or was it already there before?
>
> Fixes: 88d097316371 ("mptcp: drop free_list for deleting entries")

Hi Matthieu -

Yes, for -net I should have included a Fixes tag.

>
>
> Also, should we not also modify mptcp_userspace_pm_delete_local_addr()
> doing the following?
>
>  list_del_rcu(&entry->list);
>  sock_kfree_s(sk, entry, sizeof(*entry));
>

Geliang's series deletes this code, so I skipped this change intentionally 
(as explained in my note after the signoff).

> If yes, and while at it, do you think it might be good to add a short
> comment above "atomic_sub()" in the code explaining this is doing the
> same as sock_kfree_s(), but with RCU support? In case sock_kfree_s is
> modified later, and to understand what's being done here without using
> blame.

Good point, I can add that comment. It's a small change, but I'll send a 
v2 with that and the Fixes tag, and get the [PATCH mptcp-net] subject 
prefix correct this time :)


- Mat
