Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579E3D7D7F
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778240262; cv=none; b=bCFTfy/Os1YZ1kE0j67Qr2gvhSxaDCbss9cRkCBlWTiiDgGM1hXLDYt3WCc6tSEK13EcYPIkcWYrgmpwwnyJtvC/L9q1lWCIcQHW/1fJDajYD1D0fyNsS6OFc3ksEvz2pHlo38VuSDnlobd9uTG9V+kH3kaEUiuXVJh0rNdPpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778240262; c=relaxed/simple;
	bh=7TD3SE2pC1I5awZkHnIk7an4VWLr1UwELB9A73JLb+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfmR1nM98+fctWaEAaT+/KqgdLnkrxwsH5Paz26hV9baQv27DCiJ6Jv2zQxlun1M82yBg2qtI1QisvkLDphyWNYtl/EoXoXnm0MEwrvo6ATHc2g1nIhsYOCsXKXg2UmXlNjCnWK9j7Ioz7nbfNSAf0gokIyw+OYIQjOFEGBjNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1d3JR6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1d3JR6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EEDC2BCB0;
	Fri,  8 May 2026 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778240262;
	bh=7TD3SE2pC1I5awZkHnIk7an4VWLr1UwELB9A73JLb+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f1d3JR6LpClqaYduDgofmm3RKsi3R9AOotEPe77HnShgjQ/w2sAUbDjkjtNQiuPa4
	 nSydPupLhyeGxmkNzhbtolSMRjA0GhEGE5j+ggVFU0qvb4wyxtylWBrm1ySS3D3/we
	 orWi0k8sB7CMRCXU28S2FB5oopngH70xEHGckTz1oIguJU8h9towloJ+RndoIv5nyN
	 xk7W/WH7yr3wbWpNKKCTAqLzS3wOMw9u9yGF0fV9qIMqg27crKieiudfXBN1iZFm8u
	 vcltiuCzh8W3dC27LJzLW2MknCpAZB+2AWbOWfe9hcC7EmpRh1DKqwNe/aRDxLfkcI
	 N1I5rkxRV+Q1A==
Message-ID: <6dd57952-26c9-4f72-bb58-48e3f8b84caf@kernel.org>
Date: Fri, 8 May 2026 13:37:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: pm: fix ADD_ADDR timer infinite
 retry on option space shortage
Content-Language: fr
To: Li Xiasong <lixiasong1@huawei.com>, mptcp@lists.linux.dev
Cc: weiyongjun1@huawei.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com
References: <20260507125224.3536507-1-lixiasong1@huawei.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260507125224.3536507-1-lixiasong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Li,

On 07/05/2026 14:52, Li Xiasong wrote:
> This series fixes a bug where the ADD_ADDR timer can keep rescheduling
> indefinitely when TCP option space is insufficient, blocking subsequent
> addresses in the endpoint list from being announced.
> 
> The issue is reproducible when sending an IPv6 ADD_ADDR with port while
> tcp_timestamps is enabled. In that case, option space may be exhausted on
> pure ACKs, and ADD_ADDR retransmission can stall PM forward progress.
> 
> Patch 1 clears the signal in this path, skips the matching ADD_ADDR
> retransmission entry, and preserves PM state-machine progression.
> 
> Note on concurrency: timer cancellation in this path is best-effort.
> A concurrent add_timer callback that acquires pm.lock first may still
> perform one final ADD_ADDR send attempt before cancel state is applied.
> After cancel sets entry->retrans_times to ADD_ADDR_RETRANS_MAX, the
> callback-side check prevents further ADD_ADDR retransmissions.
> 
> Patch 2 adds a selftest to cover this behavior and prevent regressions.
> 
> Patch summary:
>   - patch 1: mptcp: pm: fix ADD_ADDR timer infinite retry on option space
>     insufficient
>   - patch 2: selftests: mptcp: join: cover ADD_ADDR tx drop and list
>     progress
> 
> Changes since v2:
>   - document the possible timer-cancel race window in the commit message
>     and code comments
>   - keep best-effort cancellation semantics (possible one extra send
>     attempt under lock-order race), while preventing further retries via
>     retrans_times gating
>   - selftests: remove the redundant ADD_ADDR tx-drop subtest that
>     duplicated existing coverage for list progression behavior
>   - link to v2:
>     https://lore.kernel.org/mptcp/20260430112026.343691-1-lixiasong1@huawei.com/
Thank you for the v3, it looks good to me!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

