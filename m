Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4420CCE6
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742363067; cv=none; b=hUy/WrI0epiWyMHj/yYK0O7Hi24acRwgmZCKsy8RLnDbNoQbbOCngf09DR7YKfTq+ACnRdhdlDo9aSNIL5wyPwLxSEc88dPjgTd5zYaGKHojPK7ttMt9kJfJWdRn+u5BMtdqS3oeHdeKweFFu2gjxu3j8dSA8CaaCLpJsu+f8og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742363067; c=relaxed/simple;
	bh=1NINfptwxTP2XleXUB6FF7ohck2PwaqguWW8bkwMFbM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrhHIL+RGKRtCFv8npYxhSLTvfY7z5HsjBGXC0uPyfW1YhDSbP3xbwIgQZ6WeRdWwsWL9FWA9BMYuX6vKmIAavxFWWfgx05fWAwv7B693ZjXcs+7j3YuEEI91uPthEstzTJGs6dNrn80b+NVJ3p1t5+uxnxWkvEejaVvOpKfbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByEZFZXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByEZFZXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B129C4CEEA;
	Wed, 19 Mar 2025 05:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742363066;
	bh=1NINfptwxTP2XleXUB6FF7ohck2PwaqguWW8bkwMFbM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ByEZFZXlpkgVUOXwBl9CH4PUPQSozfLl8h0kckN76XOF1fbjWzVwI4i9deZY2oA2a
	 4w06ySUNJsDq6MgIZXakC8pn+0J9QaVIbslcH1JK4o8RLxMk1Ltf7MZQvcsbX7gEmF
	 YPip74D1CtLRXH85pp4w8BfQLDIlnsbwLLPHgN6rGhwVWQz7e7Low/ybyk7rlEbQ/N
	 Mi8MqIzLjAGwB7C2jKmH1wUo64qVPaaigDWZKaEKdMHUKc55JMkIUF3dGccI6iIQGq
	 MiFpxfATlsiYwhhnXGPa+sy8rfAvd1ucfnzWqByYGH1oN34gNh9KVXyBaVLBX+hxnu
	 MffQwbQs/uLig==
Message-ID: <beefd71a1bb820ca6ae25a59b85a65d268a1ca6f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/2] cleanups for main_loop
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 19 Mar 2025 13:44:19 +0800
In-Reply-To: <229690ef-6351-cfeb-8045-dd299c229169@gmail.com>
References: <cover.1742355162.git.tanggeliang@kylinos.cn>
	 <229690ef-6351-cfeb-8045-dd299c229169@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-03-19 at 04:47 +0000, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal: Unstable: 1 failed test(s):
> selftest_mptcp_connect 🔴
> - KVM Validation: debug: Unstable: 1 failed test(s):
> selftest_mptcp_connect 🔴

Oops, I fixed this in v3.

Thanks,
-Geliang

> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/13938550896
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/ee7ab4397474
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=945419
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
> 

