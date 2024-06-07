Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D20193099
	for <mptcp@lists.linux.dev>; Fri,  7 Jun 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768714; cv=none; b=bw9ak6NXUm87MKDD6O6DemJi0RkbIUUdTNDjcIYmLdS//KrFOgHyx+E+Tfzqb9AmvKiae80e3sgSWmYxAJiulL6maaqViwlxB/lh8+hr1SpCRp+PzLvh2yHEmxVmXM4Y/9pPVq+8TqY3mMb8aSv63AZ8LAPYl7GLrv6z/qR0+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768714; c=relaxed/simple;
	bh=hIVIgLjbKfOABzqKjZ8js3XD88+coKcN00OUDaEleKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ab9+wHtvntxBU10IYDkriCjR4+tMSSt3zezGk3sg1tjr+84o4AzAInGaB82tyR5m+nVi8TzrXWEYZdQAKvulp70DYglFAjGKcts6LtUcsCG7wjay4b3h2za1o7pciwy3i66tbx58HsfnTwQW0imITev7qeuIrosiqDu//TJPN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abwhT70Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abwhT70Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC42C2BBFC;
	Fri,  7 Jun 2024 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717768713;
	bh=hIVIgLjbKfOABzqKjZ8js3XD88+coKcN00OUDaEleKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=abwhT70Q6cLayFlOtuIkOiCjOB6XdqCSvUPvUViLMTwLJEK12mzJDGV1WGOKIhcT1
	 ehmIHqasG73vpquQg1TtfQWRlCGHK8TFd58tIdrxpiNYWEO0j9P0j5NcZqrz2PBcWT
	 bHze4pEEaVurLEVehTosfpSBew8HKLiQdzGD/c847zQThiDubISRc8B1S5UD0MQIhT
	 caIa19eoL+GRYYa9fXBWQTUL6WdfL7XIfha4yGT2mqQyiBXMTNSI8GyYWM8CO9geAj
	 GVOj6VnEBaEiETg6kU4HJ63ilxtuljstItMUesPZ86vABsCV9bztfhflLuuukcLGkp
	 FA72W7iCtCVcg==
Message-ID: <e1d9f050-69a0-41fb-9015-49ee31caa677@kernel.org>
Date: Fri, 7 Jun 2024 15:58:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: update add_addr counters after
 connect
Content-Language: en-GB
To: YonglongLi <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>
References: <20240606-mptcp-pm-inc-cnt-sf-create-v2-1-67c4759a4885@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240606-mptcp-pm-inc-cnt-sf-create-v2-1-67c4759a4885@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yonglong Li, Mat,

On 06/06/2024 19:16, Matthieu Baerts (NGI0) wrote:
> From: YonglongLi <liyonglong@chinatelecom.cn>
> 
> The creation of new subflows can fail for different reasons. If no
> subflow have been created using the received ADD_ADDR, the related
> counters should not be updated, otherwise they will never be decremented
> for events related to this ID later on.
> 
> For the moment, the number of accepted ADD_ADDR is only decremented upon
> the reception of a related RM_ADDR, and only if the remote address ID is
> currently being used by at least one subflow. In other words, if no
> subflow can be created with the received address, the counter will not
> be decremented. In this case, it is then important not to increment
> pm.add_addr_accepted counter, and not to modify pm.accept_addr bit.
> 
> Note that this patch does not modify the behaviour in case of failures
> later on, e.g. if the MP Join is dropped or rejected.
> 
> The "remove invalid addresses" MP Join subtest has been modified to
> validate this case. The broadcast IP address is added before the "valid"
> address that will be used to successfully create a subflow, and the
> limit is decreased by one: without this patch, it was not possible to
> create the last subflow, because:
> 
> - the broadcast address would have been accepted even if it was not
>   usable: the creation of a subflow to this address results in an error,
> 
> - the limit of 2 accepted ADD_ADDR would have then been reached.

Thank you for the original patch, and the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 98857efdda00: mptcp: pm: update add_addr counters after connect
- Results: a39272cab4d2..773de679718d (export-net)
- Results: 4dce5dfd2129..ce1f2fbad3db (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/af11f42fc788bc4832e56eac10228a31d8fb0764/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/0bcdbf97432494747dd13cec8d264f2e670e1bb6/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

