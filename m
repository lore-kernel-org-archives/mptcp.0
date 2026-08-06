Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73453F1ADA
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007805; cv=none; b=atE6vneHY2Hi7sj8AM2oBmD+DRNQ2LouVg/8DLv0sh8VLEuhWyCpyz/hI8MuQhByubA4333v3uRkhlr14lJw/rK0w1faAcBGkwlUuShY2QwKMYHRKdinHQIT/sHoTE11A53CuLtPCeZZz15TTnZFMeiZwFotNjqYgimfdRpFoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007805; c=relaxed/simple;
	bh=WkAx3O06UNLpQ6cgPz3u++qRCJ+Rw2xwktnWliyhqPA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+hbW3Ex/iuIHEr3w0p0elbOfdA03ttSejEbk3wGN9TkOM0G2Ldrl5UhzmNQ4b3vtBp3fInyGotlKRahfqLdxP9WhCJ6DzklfoYK1mrwEL3Rqee9A2cGwdrEKg9hngws/X39OnMn/y4DCKL4hhIUoVuY3uGNF3QTqiPb1WeH0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VswabQQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VswabQQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D9A1F000E9;
	Thu,  6 Aug 2026 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007804;
	bh=yNw6kfL/jSUJwzXzV0Ug5w60dIACD6JjS57y2v8EQYA=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=VswabQQ6N5EFDmwui6NhZpWY9jgbt0f2+mZTtwHcDnQysgYrpGoX8rF1RZNjTWuhQ
	 bSnXbhkEI+OMn2HvCO6U7DBQ9J1T9zOOTqJJRLrMJMZehH3OtZkhY6v7vZz3AgAaKa
	 NjMPs/g2dJwCFfqPC3W8FbOYU6JYCM9Ml+2wB4osGE1F8Pwt4oQt3NHT1kcx3/csSA
	 1AUmn+x8VL+gRLfd9Fbq8+6nuw2cFCmCozVvmy2a/qG2Wy3U/tE9D6VCJSjdiDOyN+
	 Z+XUjrJui3NlP7OPaSU7BygiLy7YkBRL3c/k+fSzKol0rLUE2YPbH69O3BpRifOHxh
	 cJ2RwJO0H9G0Q==
Message-ID: <355f231057ea5c58415d67efa6fde6ab5bef36ca.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 0/7] mptcp: address stall under memory
 pressure
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Date: Thu, 06 Aug 2026 17:16:39 +0800
In-Reply-To: <53bf5917-392d-34b4-a12a-3e5d0ac31d29@gmail.com>
References: <cover.1785943854.git.pabeni@redhat.com>
	 <53bf5917-392d-34b4-a12a-3e5d0ac31d29@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2026-08-05 at 17:30 +0000, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (except selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (only selftest_mptcp_join): Success! ✅
> - KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed
> test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-
> no_alu32_mptcp bpftest_test_progs_mptcp ⚠️ 

Since mptcp_pm_subflow_chk_stale is removed in this series, it also
needs to be removed from BPF to keep the BPF tests passing. I just sent
two squash-to patches to fix this.

Thanks,
-Geliang

> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/31026237379
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/503660467176
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1140906
> 
> 
> If there are some issues, you can reproduce them using the same
> environment as
> the one used by the CI thanks to a docker image, e.g.:
> 
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm
> -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
> 
> For more details:
> 
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Please note that despite all the efforts that have been already done
> to have a
> stable tests suite when executed on a public CI like here, it is
> possible some
> reported issues are not due to your modifications. Still, do not
> hesitate to
> help us improve that ;-)
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
