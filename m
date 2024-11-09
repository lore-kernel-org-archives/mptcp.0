Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA1288D1
	for <mptcp@lists.linux.dev>; Sat,  9 Nov 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731140119; cv=none; b=X4Qc1FDV1Tvsqw0fCH6NAiz2B9hqXlPXYfoD7zgyyYeF7Idyl7ggHRGiR88BC/l2aVfKtJES9Hy6R18MQuk6dP0Qh5hnY+0Y7eRY30xRZAy0v4DdFQZ9gVt5zLuxzWBoiTObwiYVTCAyHbnlVosWDI7nvsQKS8gTY5zxuhfGZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731140119; c=relaxed/simple;
	bh=s4ExIS24ZWggv4GF4R0ktKUufQea5zObsDCjn9RDXCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQv9M8UIqI3GgSZkFfhPRzV7jd5+x4LgmHRz+tOPjdaj5sN0TtJ9EzE5TydJ3o1uF8yQuVZ3ZxuV4gjgb04Q1tbcBWpbkbfCm4msG8zmX3bM1OQrNtr5nnBlNapVDtWZlMHm81yUmgVnXGECIsFngVMA+LnFlzFxy+OXVX4RJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVTO3nJ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVTO3nJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19629C4CECE;
	Sat,  9 Nov 2024 08:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731140119;
	bh=s4ExIS24ZWggv4GF4R0ktKUufQea5zObsDCjn9RDXCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NVTO3nJ0m0N7y+FhX/F5WUh6L9TNDA5/m7xb3DdJSEHdHIVx7xb4MYSMkbvSbxNQc
	 HVd3VKbNR7H6Q0R4ZC6XLEOGXYBYaE8iBEE+sZKnkMOhMvMNtWRMYi6fDJse0ljryG
	 4ghZpUP2ox3VyuSn/hpgaxVC9c0GQXee7y/0UimJS3QXTwLk7xtXZDSXYmsWlUpZHN
	 dWX5tyE4+HJxUUdf7lm3TqOXTti2zOdO63GfMgQqfA0UDyF65uk7VMVSUcYMtEQ6In
	 y2ofj64iDoxrx1qcTJgxHcgiTy6egd+nj46vEr9zrGA2LgOWNjgIXQ4aVDIPrt5TqW
	 +ygLdy2OXsAEQ==
Message-ID: <0fc4af87de8ceebee1e897d8b3145a62099e15ad.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add
 mptcp_userspace_pm_addr bpf_iter subtest"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sat, 09 Nov 2024 16:15:15 +0800
In-Reply-To: <6de6c4b0-4c17-468a-a45c-77ec6bf018c0@kernel.org>
References: 
	<aeca45ea8522298327715230f45d718338906732.1731055793.git.tanggeliang@kylinos.cn>
	 <6de6c4b0-4c17-468a-a45c-77ec6bf018c0@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Fri, 2024-11-08 at 11:41 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 08/11/2024 09:51, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Enable CONFIG_MPTCP_IPV6CONFIG_MPTCP_IPV6 in bpf config.
> 
> Why do you need this? Is it "just in case", or did you see an error
> somewhere?

I didn't see any error anywhere. I just notice that CONFIG_MPTCP_IPV6
is in mptcp selftests config, but not in bpf selftests config: 

$ cat tools/testing/selftests/net/mptcp/config | grep MPTCP
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
CONFIG_INET_MPTCP_DIAG=m

$ cat tools/testing/selftests/bpf/config | grep MPTCP
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y

> 
> Because if MPTCP and IPV6 are enabled, then MPTCP_IPV6 should be
> enabled
> by default as well, no?

Yes, you are right. CONFIG_MPTCP_IPV6 is indeed already enabled in bpf
selftests ci, no need to add it.

I downloaded vmlinux image "vmlinux-x86_64-gcc" of "bpf: Add
mptcp_subflow bpf_iter support #4095" at:

https://github.com/kernel-patches/bpf/actions/runs/11745455465

Unzip it and check the kconfigs:

$ cat vmlinux-x86_64-gcc/kbuild-output/.config | grep MPTCP
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=y
CONFIG_MPTCP_IPV6=y

$ cat vmlinux-x86_64-gcc/kbuild-output/include/config/auto.conf | grep
MPTCP
CONFIG_INET_MPTCP_DIAG=y
CONFIG_MPTCP_IPV6=y
CONFIG_MPTCP=y

CONFIG_MPTCP_IPV6 is enabled.

Let's drop this squash-to patch. I changed it as "Rejected".

Thanks,
-Geliang

> 
> Cheers,
> Matt

