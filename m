Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA320B812
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407019; cv=none; b=Islv3eFLrgNvU++OPqon59lqC995BgeYyAmIOABardqJH0VrNNxmfDnywDwcukgNFQWXOslumaKDjOSMjW0izzTaIQZ25DrRw2JPg/ze9agEpb2u/LfDtSa+nUuhbn4nJWbN+N3C4ykqgswpNRtV3QdPMx/wafEtHKpdaA0IS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407019; c=relaxed/simple;
	bh=LDexa97/D3k+GGpMIGrPBKjXE+KiYSU/vZlVYzFuhCE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=OUJNqR/YtjEa4WF1SvLXCai+tJfrmzo8pefhZdpBYPZQpB5J6vQY1UcM2x3lnr/eHIBb57KUA+u31t/PsNvkwIBk3qkmrLIJvmEyER3nmdN/nY8puwic6I9ZclL0JvvZiYz74QJmdNpkOeVwQYYfLrJ66J0eNZV8FlTRe4+sRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8m/rcBD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8m/rcBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E6C4CEEA;
	Wed, 19 Mar 2025 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742407018;
	bh=LDexa97/D3k+GGpMIGrPBKjXE+KiYSU/vZlVYzFuhCE=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=i8m/rcBDv0v3LBXyjLEZwZaM7IQBak1irGlalnq99KtL47QErFuzwm9fTmNaq68wV
	 s4eDCmmndrAun9wcXcy8EqFTSCnombQtWl4AKDJVH1qmEwA7I8vXvdA9LLDPx+TMjk
	 7gvmLfkNPnq6PK1NIqBzlv9liXxwGqKFY+ZVxaGzuuyVl6M/ZmCJ5QcboyyfOa0meH
	 I33IM8l2aLukFQ+myHAGwDbvR7lktYM40Qx4fOglNd4+RRHrzOhSbYqk+mVm8RwU6c
	 KWfaq7GBPfeSZrCMlbkXz0VBeKeqzyS3I9zYU5wzMA+r1PpNxLTFLC4AKWG0zft2Tg
	 +bUpA5Ep6g1PQ==
Message-ID: <a09f5831-51e0-4bf1-8f93-7157d16352cd@kernel.org>
Date: Wed, 19 Mar 2025 18:56:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-net, v2] mptcp: fix a NULL pointer result in panic
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Gang Yan <yangang@kylinos.cn>,
 mptcp@lists.linux.dev
References: <20250319022733.51444-1-yangang@kylinos.cn>
 <480b189d-af0b-4af4-8abd-5ebc6873255a@redhat.com>
 <d362ffe5-5596-4656-8317-7e23027caf1d@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d362ffe5-5596-4656-8317-7e23027caf1d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Gang,

On 19/03/2025 18:47, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 19/03/2025 08:38, Paolo Abeni wrote:
>> On 3/19/25 3:27 AM, Gang Yan wrote:
>>> When test valkey in mptcp, the kernel will panic due to the function
>>> 'mptcp_can_accept_new_subflow' when the subflow_req->msk is NULL.
>>>
>>> This problem shows in kernel 6.11.0-rc3 and 6.14.0-rc4. The message
>>> attached is valkey_test in 6.14.0-rc4:
>>>
>>> Call trace:
>>> mptcp_can_accept_new_subflow (./net/mptcp/subflow.c:63 (discriminator 4)) (P)
>>> subflow_syn_recv_sock (./net/mptcp/subflow.c:854)
>>> tcp_check_req (./net/ipv4/tcp_minisocks.c:863)
>>> tcp_v4_rcv (./net/ipv4/tcp_ipv4.c:2268)
>>> ip_protocol_deliver_rcu (./net/ipv4/ip_input.c:207)
>>> ip_local_deliver_finish (./net/ipv4/ip_input.c:234)
>>> ip_local_deliver (./net/ipv4/ip_input.c:254)
>>> ip_rcv_finish (./net/ipv4/ip_input.c:449)
>>> ...
>>>
>>> According to the debug log, the same req received two SYN-ACK in a very
>>> short time. (When the client retransmits the syn ack dueto multiple reasons.
>>> Even if the packets are transmitted with a relevant time interval, they can be
>>> processed by the server on different CPUs concurrently). The 'subflow_req->msk'
>>> ownership is transferred to subflow in the first, and there will be a risk of a
>>> null pointer dereference here.
>>>
>>> This patch can fix this issue by moving the 'subflow_req->msk' under the
>>> `own_req == true` conditional.
>>>
>>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>>> Signed-off-by: Gang Yan <yangang@kylinos.cn>
>>
>> The code LGTM.
> 
> Me too, thank you both for having looked at that!

Now in our tree (fix for net):

New patches for t/upstream-net and t/upstream:
- 40ad50026099: mptcp: fix NULL pointer in can_accept_new_subflow
- Results: 15fd746f34c5..dba54e66e69e (export-net)
- Results: 2bea3081157b..332a74c2a7d4 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/06f515aab4fa9d84ba4dfe81b17aa7d77ea22b4d/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/83da8f611c90d09ade3f1fc8b04302d272c8f7b9/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

