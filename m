Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8B1CD2A
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949836; cv=none; b=LgHKWNNz7seB7fMqETSsvMa2+CpLQiyJuvQLg96pu3IaJHkGoP97Uh5GxzBL/bMbO9dtX/4FjR5g/2T9BPa8/oBOY7Uw/92SzvNwNoCu8piQHW4odeJqp/IpPskHiN6QiCMsxY4nzIVftY4K5Ck6nzBJ6wu37EK2WOZlW1n5ofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949836; c=relaxed/simple;
	bh=KjhO3Tg3bNQIEVwl5GZhwoJi8Jh4VdnGXIqjKX8TaRM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t0anW7KgRd4hDGGOtw0xN3jh2cpJoitCN3PTVscGHdDKD2dKoGTedwv5N0p5FF5GINnVmMTxl/G0AMlNF8oGY+roFwHEHgQ7Bt1dKRqd28KwPsSd27W6zqbUl90sbfpvNUnpFZq+FWJiALv4Wi8Eoicw7ySHT7KwNv9ggDmiuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgbbZx8u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgbbZx8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E88C4CEC3;
	Tue, 10 Sep 2024 06:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725949835;
	bh=KjhO3Tg3bNQIEVwl5GZhwoJi8Jh4VdnGXIqjKX8TaRM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bgbbZx8udFrApIhATZymeRU6VT2bPK46K2bXPbwo9j41pPyCFbp26i3AqSHw8UOGM
	 gaeqJCw+Iq8EOubC0n8QBgTj5HB2WWsjVKjpZsY/YgOctK2r0mhcwelHqeaER3Vy7r
	 4rZJzzeGJ4Q9SrZX2nazTi7tig4pOl7NXhhbQJ4365QqxEzZtnCKNlMzGZF7VH4skT
	 G68tdMf56Mhgaf4yDre/yZEl5riVBlgMtER87cOaBJ1rtn5C+PgWPRs4R+Zcq2yIg0
	 pTVS9KVwZhfWoYpAkxosJEJrVky9jUzo/YpozyaX4mVoCqmsYj3ZFAcIfKU7Yt0HW0
	 /kBuHogYKQx+g==
Message-ID: <7bfdec07684954b812924b51f7295ef3a8ef7226.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/5] add mptcp_subflow bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 10 Sep 2024 14:30:28 +0800
In-Reply-To: <34c218c7-bab6-28b3-1940-949977146e87@gmail.com>
References: <cover.1725946276.git.tanggeliang@kylinos.cn>
	 <34c218c7-bab6-28b3-1940-949977146e87@gmail.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-09-10 at 06:02 +0000, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build
> it.
> 
> You can find more details there:
> 
>  
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/10786552828
> 
> Status: failure

These errors reported by CI should be ignored:

Unable to compile mptcp source code with make C=1 net/mptcp/bpf.o:
net/mptcp/bpf.c:215:17: warning: symbol 'bpf_iter_mptcp_subflow_new'
was not declared. Should it be static?
Unable to compile mptcp source code with make C=1 net/mptcp/bpf.o:
net/mptcp/bpf.c:228:42: warning: symbol 'bpf_iter_mptcp_subflow_next'
was not declared. Should it be static?
Unable to compile mptcp source code with make C=1 net/mptcp/bpf.o:
net/mptcp/bpf.c:243:18: warning: symbol
'bpf_iter_mptcp_subflow_destroy' was not declared. Should it be static?
Unable to compile mptcp source code with make C=1 net/mptcp/bpf.o:
net/mptcp/bpf.c:247:42: warning: symbol 'bpf_mptcp_subflow_ctx_by_pos'
was not declared. Should it be static?

Thanks,
-Geliang

> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/ed6d012aaff4
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=888713
> 
> Feel free to reply to this email if you cannot access logs, if you
> need
> some support to fix the error, if this doesn't seem to be caused by
> your
> modifications or if the error is a false positive one.
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
> 

