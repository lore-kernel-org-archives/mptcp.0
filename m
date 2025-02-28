Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103F25BAAE
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737393; cv=none; b=UoG68kN4q+yMMYSGjOkQN60yokTCmjbIfTgAVIy8IdL9w8SnvUZXtjvUmE6+o3II50hqqQ5RBV+C+gH1E/H0OegkeB29uI2uzcbxe0k7HYKA80pnwoDZMALL7NfnVKznriMheBDgwDAGFQxJ82Yp8MqSrxdCDNx6WI1rz4kwQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737393; c=relaxed/simple;
	bh=/86EY+nqbdQy4Bt7KlzHd0WJwmmUjgeCNCh+V+OiHBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PZnei7fDnx8PVjiaK8la1fUSfablC/wPxYTKtWfHkAnGOeaqFtZae8kc6ntqeBRMxStbsNiDZgNcHULgyi1uh6BSgOoRPiCK/U1deHGjGSDRDCiMyDyDOJiZ0mpS0tgVf+l/qVvX2E3BBr0598tYNEZfDVFgegejEKdsL8I+rjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8CyoZyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8CyoZyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED98C4CED6;
	Fri, 28 Feb 2025 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740737393;
	bh=/86EY+nqbdQy4Bt7KlzHd0WJwmmUjgeCNCh+V+OiHBQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=U8CyoZyT+WwVMW0BeHDmLl/8nFzrf5feNdXySENAVJ04W53w8aYcvX+qiSxi78Q06
	 SJWYjUrUU4cAc3YZCPBGXB2UhxmiGOHcbL843wMEz0vTYVjWld6fmaFAalyRt4oO6C
	 e6FbYbwFsZ4ql0U1H2THIshUUmA0DgsZ85imEd0u6R2o80+ubNTFUGWSG/Xs3i5nQP
	 cNknNF3zSZQNnw8WnP0yGdtKhay8t1zOnpaBDr1QijFX4/CvbX+0p1JXOtMTXoKlD5
	 jemKIB9TA8ixncElNGRvhnhZSrwXogSPCmAVqM5ZvtADeJCTNtpCFI62oc/DALrX7Q
	 SvOlJlaEuBJMw==
Message-ID: <ebd83ca4-2068-41a6-a2b8-56bcb4ba1156@kernel.org>
Date: Fri, 28 Feb 2025 11:09:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/7] mptcp: pm: code reorganisation
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
 <ec9413f7d72c88231a72e3aebcda847ad15a16d2.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ec9413f7d72c88231a72e3aebcda847ad15a16d2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/02/2025 04:27, Geliang Tang wrote:
> On Thu, 2025-02-27 at 21:08 +0100, Matthieu Baerts (NGI0) wrote:
>> I have been thinking about that during the past couple of months, but
>> now, with the recent modifications done by Geliang, and the
>> associated
>> reviews, I really think it is time to reorganise the code around the
>> path-managers to avoid confusions, and a mix of code used in
>> different
>> conditions.
>>
>> Here is a first proposition, feel free to comment! :)
>>
>> Please look at the last patch for more details about the why and why
>> now.
>>
>> I hope this will not cause too many issues with the in-progress
>> patches.
>> I tried only to move the code around, and minimise the functions
>> renaming. Then, to switch to the new code, it might be easier to
>> simply
>> copy your modified code from the old place to the new one. In other
>> words, duplicate the net/mptcp directory, then do a rebase, resolve
>> the
>> conflicts with 'git restore --ours', then reapply the modifications
>> by
>> copying your old code to the new place. If it is too difficult,
>> please
>> let me know.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Cc: Geliang Tang <geliang@kernel.org>
>>
>> ---
>> Matthieu Baerts (NGI0) (7):
>>       mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
>>       mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
>>       mptcp: pm: remove '_nl' from mptcp_pm_nl_work
>>       mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_or_subflow
>>       mptcp: pm: avoid calling PM specific code from core
>>       mptcp: pm: worker: split in-kernel and common tasks
>>       mptcp: pm: code reorganisation
>>
>>  net/mptcp/Makefile       |    2 +-
>>  net/mptcp/pm.c           |  685 ++++++++++++----
>>  net/mptcp/pm_kernel.c    | 1410 +++++++++++++++++++++++++++++++++
>>  net/mptcp/pm_netlink.c   | 1934 ++----------------------------------
>> ----------
> 
> Patch 7 has too many changes to review, so I suggest splitting it into
> multiple small patches for review, and then merging them into a large
> patch after review.

Thank you for looking at that. If we split, maybe no need to merge them
later.

> I think it is possible to make "move the code from pm_netlink.c to
> pm.c" as a separate patch, and "move the code from pm_netlink.c to
> pm_kernel.c" as another separate patch. Moreover, these two patches
> only involve the movement of code, without any renaming or relocation
> of functions, and these changes should be done by separate patches.

OK, I will try to do that.

> In addition, we can try to keep the original positions of the functions
> that were originally in pm.c, such as mptcp_pm_addr_families_match,
> mptcp_pm_schedule_work, and mptcp_pm_add_addr_send_ack.

I moved mptcp_pm_addr_families_match() to be with all the new "addr
helpers" coming from pm_netlink.c. It looks better there. Maybe I can do
the move in a separated patch.

For the two other helpers, that's because mptcp_pm_add_addr_send_ack()
is now static, but called by code imported from pm_netlink.c. Maybe I
can add a signature above to ease the review here. Would that be OK?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

