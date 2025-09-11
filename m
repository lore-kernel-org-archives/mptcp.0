Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B404923D7EA
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611821; cv=none; b=Tk5l11oRapAUmy/PjGLATBbPyzZELCCOLhUExkigPYLYblqs97+FIZfXKe1a9rO/fhbpYvqrTV+JY2btVV67+1Zep+iBm6Iuie6rQQOSAPxuliVEuWF1H5phj3hSW0045p76D9sVvakSO8kPLZWqPoEOl27WdCmODTLkZswUiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611821; c=relaxed/simple;
	bh=/pSi7xmRDYYPNDfxR8G+cDUX8WQX6gZcu6NxQI6BoGc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qibaH4jC2tjVupOHwRW+5/grDW268eEyysfYFZm4W73TjsidCm5C7vmPK4TkLEOjjHVr4i65IFWF1qY6cncjn4MPig0lfXijLOTVNC5GjMFoif5aLJgcQI/BnOUggWY+COeEqSBgFmjE3NVRRAPWmu1gzpKR+YurEd6avXzRwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us6bA2Nf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us6bA2Nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3B5C4CEF0;
	Thu, 11 Sep 2025 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757611820;
	bh=/pSi7xmRDYYPNDfxR8G+cDUX8WQX6gZcu6NxQI6BoGc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Us6bA2NfI19onBh3/mTZUxfjfC937SyKs6DcsXD5/AOODNkjpGVXWHEQgM8sY1ib0
	 bxyj7VVhn4U27VJ6L/rRTfcjj1hr+/kgMnGNbc1BJtdMHFUcgYguu0gwk1Pgmb1cGw
	 DAWHIEFPPptmC6jZ5TXX7iCPmIdGAbJFOFx9FKFWCffg+j5toaPureX4PbDKN/ZtmG
	 tYgLmdR3cWcvTDmquCbXQGf4aKe+GBlRAoW+iuGVXY0/j5GUHYewpM2rA1xL06kbDd
	 K/49gcA1tOoVeQnpeQCXko5W1qskcuqQoCZEjAW6Pq8lASdaM+kv/IHicW62CXvqjB
	 7pbkvsYCybZzg==
Date: Thu, 11 Sep 2025 10:30:19 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: Patchwork: Prioritising the queue
In-Reply-To: <36cc4557dbabf935e9a4e027f1e76aeed3caea42.camel@kernel.org>
Message-ID: <883e342a-fdd0-2721-9591-0efdc86b099a@kernel.org>
References: <6ddd8121-331b-4f93-b0ce-5eb7871ac553@kernel.org> <36cc4557dbabf935e9a4e027f1e76aeed3caea42.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Sep 2025, Geliang Tang wrote:

> Hi Matt,
>
> On Wed, 2025-09-10 at 19:05 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> As you may have noticed regarding the reviews of your patches, we are
>> lagging a bit behind, sorry for that.
>>
>> Here is the list of pending series:
>>
>> - only remove entry from local_addr_list when sending a REMOVE_ADDR
>> - mptcp: TCP_MD5SIG support
>> - refactor MPTCP socket option handling
>> - mptcp: add more sockopts
>> - selftests: consolidate TCP_INQ testing into sockopt
>> - implement mptcp read_sock
>>
>> (+ the WIP ones marked as "changes-requested")
>>
>> Can you help us to prioritise this list please? Which ones should we
>> start with? Priorities can be given based on the dependences and/or
>> your
>> own priorities for example. With that, we can iterate over them one
>> by one.
>
> All my queued patches can be divided into three groups: Path manager,
> NVMe over MPTCP, and sockopts. These three groups have no dependencies
> on each other.
>
> 1. Path manager has two sets:
> - "BPF path manager, part 6"
> - "only remove entry from local_addr_list when sending a REMOVE_ADDR"
> These two are not directly dependent on each other. "BPF path manager,
> part 6" has higher priority, as there is a part 7 still queued.
>
> 2. NVMe over MPTCP has only one patch set:
> - "implement mptcp read_sock"
> Its priority is not as high as the BPF path manager, but there is
> another set called "NVMe over MPTCP" queued in my tree.
>

Thanks for the help understanding these priorities!

I'm planning to look at the read_sock series today or tomorrow.

- Mat

> 3. The rest are all sockopt-related and have lower priority:
> - "refactor MPTCP socket option handling" is still valid and does not
> depend on any other patches.
> - "mptcp: add more sockopts" depends on the previous set and is still
> valid.
> - "misc fixes for sockopt selftests" has been reviewed and requires a
> v3. I have marked its status as "Changes Requested".
> - "selftests: consolidate TCP_INQ testing into sockopt" will conflict
> with the previous set, so I have marked it as "Superseded".
> - "mptcp: TCP_MD5SIG support" depends on the previous set, and I have
> marked it as "Superseded" too.
>
> Thanks,
> -Geliang
>
>>
>> Cheers,
>> Matt
>
