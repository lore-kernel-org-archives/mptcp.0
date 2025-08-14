Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B42E9729
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161886; cv=none; b=q1NJZsBjYOqngF7pwuC7mtaxJAIZGkq+xFCC6H+iiAi1mGRaRuJ2OBlygAXH5qZcgv/i2ZQP+ri8BMI7r01z1hyfkDUejK/FVvQDQtNiutoffXl3mJxfYwQzbwuH7t8r4rnqlGbp6TChI7JUSMLCX5ezFVlGVSl3c8Ij/b8cDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161886; c=relaxed/simple;
	bh=yMAz3wQz36cMgGhmIAdt0bJ8a4qKSmkSyd4Kw0CK7y0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkaXdc4yIjI4G/UonuGgmecWwRejDkLL1qEgSWRkLWQvrEJWGnjdQcQoiPjUsHkXGQRZ8d0areXswBN1PqiVfSL0G441VT/nRgPatZI1CEPH55oJsyaeVw2lSASuL6Sl+yqnMr4DvZ1EQZQ2T5bz3Sz69Au71cudC1h2UeB/dJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q23ZT6Ij; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q23ZT6Ij"
Date: Thu, 14 Aug 2025 16:57:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755161880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xs+n3vvlnjn3LxGueC7TzVC0vfJxauS5RjBnT9Q4V54=;
	b=q23ZT6IjDQNVUd3VQVRma50QS3SxY2AC9uAtFzYeV6jxqr3hKuozuOlvzQf4XwSNIREiV7
	pp5sjLlTF8DG3VoyG4JPRCL/hNnLAlcZaRLs/JosjgKE1wDGsYAJqSoXG1mNq9ul1baFms
	4HAjGwCXuukdv4s0UF18hyHVdZoB5Z4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: GangYan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: Re: [RFC mptcp-next] selftests: mptcp: Add a test for self-conn
 fallback
Message-ID: <aJ2k-JhkBmIAfdoX@yangang-ThinkPad-T14-Gen-1>
References: <20250814065818.34804-1-yangang@kylinos.cn>
 <ab7a5df2-2ab7-f5b2-3597-c247ea027913@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab7a5df2-2ab7-f5b2-3597-c247ea027913@gmail.com>
X-Migadu-Flow: FLOW_OUT

>On Thu, Aug 14, 2025 at 08:51:13AM +0000, MPTCP CI wrote:
Hi Matt,

I noticed the 'MPTCP_MIB_SIMULTCONNFALLBACK' is not coverd by selftests
through 'code_coverage'. So, I add a test according to issue#35, and I
would like to seek your advice on the following points:

-Is it suitable to add a test like this patch to cover this part of code?
-If yes, please give me some feedback on modification suggestions about
this patch.
    
Thanks.
Gang
> Hi Gang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal: Success! ✅
> - KVM Validation: debug: Unstable: 3 failed test(s): packetdrill_dss packetdrill_mp_capable selftest_mptcp_connect_checksum 🔴
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp 🔴
> - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/16958528774
> 
> Initiator: Patchew Applier
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a48b6ab5e005
> Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=991327
> 
> 
> If there are some issues, you can reproduce them using the same environment as
> the one used by the CI thanks to a docker image, e.g.:
> 
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
> 
> For more details:
> 
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Please note that despite all the efforts that have been already done to have a
> stable tests suite when executed on a public CI like here, it is possible some
> reported issues are not due to your modifications. Still, do not hesitate to
> help us improve that ;-)
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
> 
