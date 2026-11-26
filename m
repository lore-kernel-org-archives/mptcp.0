Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704077;
	b=QmPN9DNOuOeFu2w7lXCtu1v5LbaW7CYuZ5SA/moRJ1Aom2kxon6qrpJdTn5KiaqL5QSw
	 nSoSeibKjrGwTrZEUCyoriCLe2ZPC42+8rWMesTVc0wfxzqimq+UfT5z6Vw01kRTjUGNh
	 WwfR5wt16dZi/ZrytK8zXgA5GCK9RPslf17p8n9PjoVrIfnVQWKOX75QZtGMmktZcN7AD
	 MSCXYsSMXpORQ61d87F2+uKe6XzUC2MtBrR6OSPaOBBSvmOI9sOC/KOABGE5PiCXYMKEV
	 tPxVZRQTaFAl5Xkigzj3f91fN+iOf2RWaZ3EgNBpRPrNzLnYuG2YL5Z61igyr10Eejw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704077;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XOYA3lxqSpJINPlJ8ItySiuPAb3kUEsg0YUuY/7JAAo=;
	b=sv2vP96IES2TpYNBmWAZmbHI4T4rz15wjeBiPdLUhJCrg4U7aqFH2qCn80Kyzgm+oZqS
	 0Ach51DG93n1ja9qzyW207ZNgKMBjyWVPMT5H5uQXfSHzNi3xdKQjGNgR64OfIXT7o7aq
	 rGShAsd2dVqtAYJIJPzJxAnfSoqPVPeC5Wb9kgVWu8Wu15P/wyDudmUnM7qm3715uxAJx
	 ssYVYR/sdLCC1OqeR4xAlyAZhFgAP3PnnmLIqADIgPT4vHbNLZHGQxWUBhBmNrI4gLa0K
	 97kmfr099TyjWN/QynhKKeyyi4Nk7PHvWKvXr7+QatzWxq7ZGWSD7jljQ2FHIp9Zl8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZptpJBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA6606A33A
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZptpJBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F81F000C0;
	Thu, 26 Nov 2026 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704077;
	bh=XOYA3lxqSpJINPlJ8ItySiuPAb3kUEsg0YUuY/7JAAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HZptpJBDRweAgEwomP6svQYawO5zdcKRUPPmxnkOd50K4n4jW2PCoDTKOawvXKNIo
	 BTrrFb5/8772Ud1qIJBiQwDvsDkjBuamw+WKwGBsiFzcqtPhDBmQsuTxFIa2NAvHzJ
	 DKSzrsaEXeLHF1sr0fKuGMtwt6/N5C1/iMI6mD/Uw2rijbLz2vsHWCg1gGaO+NmwQn
	 koqFu/Wu5E9p4xFLLQIPkQaeBTaSXutbgvsrGdTZdzSSgcwKKnEJB0BjUKCcWAYHF+
	 0ABoY0UYvxUwVtPkkqlFEcYzVRO43cihLvT/2L6FKpfwsAa3TaDI30lnpmrl+rSQ6U
	 faY33JPgIs75Q==
Message-ID: <a69f2a23-b2a8-4cc9-b6de-a9240c86775f@kernel.org>
Date: Thu, 26 Nov 2026 15:41:15 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 34/50] mptcp: don't charge the backlog twice
 at accept()
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Chris Mason <mason@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-34-416c0920c73f@kernel.org>
 <089c2aae-6368-14d4-ef3f-77021a35408e@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <089c2aae-6368-14d4-ef3f-77021a35408e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the review!

On 26/11/2026 03:43, Mat Martineau wrote:
> On Tue, 24 Nov 2026, Matthieu Baerts (NGI0) wrote:
> 
>> From: Chris Mason <mason@kernel.org>
>>
>> accept() can permanently overcharge the memory cgroup of an MPTCP
>> server, so the server can be OOM killed, if the new connection received
>> data while its MPTCP socket was locked.
>>
>> The sockets of an MPTCP connection have no memory cgroup before
>> accept(), which then charges the sk_forward_alloc and the sk_rmem_alloc
>> of the MPTCP socket (msk) and of each subflow. mptcp_graft_subflows()
>> also charges msk->backlog_unaccounted: the truesize of the skbs that
>> __mptcp_add_backlog() queued while the socket lock of the msk was held
>> and their subflow had no memory cgroup. But the first charge already
>> covers each of these skbs that has not been freed, in the sk_rmem_alloc
>> of its subflow or of the msk, so no later uncharge matches the extra
>> charge.
>>
>> The fix used here is to remove msk->backlog_unaccounted, its charge in
>> mptcp_graft_subflows() and the warning that tests it in
>> mptcp_can_spool_backlog(). An RFC patch [1] removes the same lines, as
>> part of another approach.
>>
>> This issue has been found with the help of an LLM, and reproduced in a
>> VM, with the reproducer shared with the original version of this patch,
>> on a kernel with the previous patch: 100,000 connections to an MPTCP
>> server in a memory cgroup. Without this patch, about 63 MB stayed
>> charged to this memory cgroup once all the connections were closed, and
>> to its parent after its removal:
>>
>>  SNAP label=after-100000 rounds=100000 sockets_left_in_srv=0
>> tcp_mem_pages=0 [...] c_sock=63295488 [...]
>>  [...]
>>  SNAP label=c-removed rounds=100000 sockets_left_in_srv=0
>> tcp_mem_pages=0 c=removed [...] p_sock=63295488 [...]
>>
>> And about 12 MB with only 50 connections, each getting 20,000 duplicates
>> of a byte before accept(), beside bare ACKs with RM_ADDR, which make the
>> MPTCP worker take the socket lock:
> 
> What does "20,000 duplicates of a byte" mean? Just that each connection
> received 20kbytes before accept? If the test case happens to use the
> same byte value for every data byte in the payload, that's superfluous
> information.

Yes, that was not clear what I added :)

I just re-checked Chris' repro, and I meant to say 20,000 one-byte
segments that are new for TCP but all have the same data seq number.

I will replace this paragraph with:

And about 12 MB with only 50 connections, each getting 20,000 one-byte
segments before accept(), new for TCP but with the same data sequence
number, so the msk drops them as duplicates. Bare ACKs with RM_ADDR,
sent at the same time, make the MPTCP worker take the socket lock, so
that some of these segments go through the backlog: (...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

