Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EB29B776;
	Wed, 19 Aug 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134944; cv=none; b=N0ao5Je/vVFDembhkOEAwmllDq2U1tOaAQHOhNEYyqsZERAt1JUREWhR4K5TlISbnXJ0pgZxAn4OsEOLrSs+wegBda03PJLs7+FZiyGr+Q25JpRwC+FNaLg/QAo7VoS5i7wKcjKIWTshUp5G7zNis8OaLu8ba3SzLRJXQlKVYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134944; c=relaxed/simple;
	bh=3SSlOy8BmzwUDYpYshZoqNIQUPjH5Sf5o7J9A2n3VOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxVUNdpY/n5zrSs5yekk+WZHyvhe/ncRNfdRYjr7RZrpG4mZw/OqQ+0mA+ua4TusKqWUPxdTl66CoZqlVIJMJjO2UwV6O1yHxwKSGl7PMUZSjusA5AkiZeGWZ8mvaA1o8Cpps0z+CUA17pnelxAL0w9pc6HGU92HBmnnLVsdEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKB0k6lL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKB0k6lL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5171F000E9;
	Wed, 19 Aug 2026 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787134942;
	bh=xRAgWfvJ3FcOivqoE0OkBl00Ae4a9noe5/d6PPorNbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OKB0k6lLj8LHUXuRafEmN9Y6CM9/YkxO8QRuU1PuoupLUjmR0q9V7z7ke4n2OosLZ
	 HiS7g1RiP2Lkf5fMgfRVOdvC3sNNagM2DrdiZVon3+PpkBMcPzU7WSDDNMz5VbI/Rh
	 QH8QmKjQTpbvBxeWMk06gEccBdvj6TdEcnrrKBcIk/lpyvNPUAZJJ1aKpqM99GAT4G
	 fOnb9wEyuVNhZPvcH+tOQlfSv38tWOaEdTi9dp5pNcCNZaiNuSQB4J8SBljQ69abuA
	 3P+bg0bxBQeMb9XZ7VbFAdblpr48EEMAkIQbgoz/3vJSCp9V7dOBlIIKbDx+Gq2odZ
	 1wrPzb3FGy3tg==
Message-ID: <bf25121c-72cf-40a7-bbaf-5db85aee7f59@kernel.org>
Date: Wed, 19 Aug 2026 12:22:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: fix use-after-free of the subflow context on
 the delegated list
Content-Language: fr
To: Hyunwoo Kim <imv4bel@gmail.com>, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org
References: <aoWBrkNwebJe-koh@v4bel>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <aoWBrkNwebJe-koh@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hyunwoo,

On 19/08/2026 12:13, Hyunwoo Kim wrote:
> mptcp_subflow_delegate() links the subflow context into a per-CPU napi
> list and takes a reference on the subflow socket. The context is a
> separate allocation, reached through icsk_ulp_data, and the list holds
> no reference to it.
> 
> inet_csk_destroy_sock() runs sk_prot->destroy() regardless of the
> outstanding references. That path ends in tcp_cleanup_ulp(), which calls
> subflow_ulp_release(). subflow_ulp_release() frees the context with
> kfree_rcu() but does not remove it from the list. Once the grace period
> elapses and the context is actually freed, the next mptcp_napi_poll()
> dequeues that entry and mptcp_subflow_delegated_next() writes to the
> freed context with list_del_init(). That is the use-after-free.
> 
> The freeing path cannot dequeue the entry itself: the list is per-CPU
> and only the CPU that queued the subflow may touch it, as
> tcp_release_cb_override() already notes.
> 
> Delay the free instead. Add MPTCP_DELEGATE_DEAD.
> mptcp_subflow_free_ctx() sets it and frees the context only if the
> subflow is not scheduled, while mptcp_napi_poll() frees it if the dead
> bit is set when it clears the scheduled bit. Either
> mptcp_subflow_free_ctx() gets there first, sees the scheduled bit and
> leaves the free to mptcp_napi_poll(), or mptcp_napi_poll() gets there
> first, does not see the dead bit and mptcp_subflow_free_ctx() does the
> free.
> 
> Also skip mptcp_subflow_process_delegated() once the dead bit is set.
> subflow_ulp_release() has already dropped the msk reference by then, so
> the pending actions must not run.
> 
> Finally, move delegated_status out of struct_group(reset).
> mptcp_subflow_ctx_reset() clears that group on disconnect, and clearing
> the scheduled bit while the entry is still queued would let
> mptcp_subflow_free_ctx() free a context the napi list still points to.
> delegated_node is already outside the group.
Thank you for looking at this. Do you have more context about how the
bug was discovered? Do you have a reproducer and/or a KASAN calltrace or
similar?

Having this would help the reviewers.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

