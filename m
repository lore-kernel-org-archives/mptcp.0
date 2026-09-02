Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF631F98E;
	Wed,  2 Sep 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347028; cv=none; b=NzmlMmAMgzdsEus3z9iL6Wbq3emkhmw9ITCy2brpQRAveUskbDSxtW6riyiJ+8iZafzLDCSk9Rw0zWQ1g/BVdm3NfyOKL/iDblGqe+zM+dDeUUi0oOT+qKfEl/ccuv9dr7/fz4MYPnrQCki+cooy9rTpGg7EtvXkKTI1SPPzh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347028; c=relaxed/simple;
	bh=ulib2FxU7/7qkD/xjF0V/zMk/K3gFKkLQSocwhDjl10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cyf2pZutQsklfgR6wQ8ZK1XgSciyp/3syKbrArjwQZ6riQ5ANm5Wk2or6cuHQZ2+gMhioWR5A3pxlgdmjkLaulklGcuS42wXkwgf7pusWzQiMNYJw9YYa01wjrseQLoA7fCH6+kZvtqrRW9pDdtU9OeoKFgVb9KG3irrRfiO2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrW9cwDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrW9cwDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6876C1F000E9;
	Wed,  2 Sep 2026 11:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788347025;
	bh=6Rzs0/DQGET9NSqst0PdWuOtgQe5rwYBXBRpcRgwgQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RrW9cwDiYJiOsBuMBWuRgtT86sJhUMrf/Z/C/nvM8MDyZmVLGuIPCd/JhinnoLYam
	 rD+IihuoQcmglgyKjn1VC4iAftTp3iHnRGBs0J8TIrf+bjnYjm/UqH5ExvMoH776YH
	 PhqyYcY/3KyGZqU1fdpxsuHcpCVQuVxTeERoHLyoXwcdGAKTN31yPJLEmxHnN2o+Xx
	 7vadcR5fpM8GBk96ifSuolbegWbqHP9YTvQz5+snhS7wKGI9AAh52oxTvrDhpCrTtZ
	 V+0HRzVUH+Lq24xVSvoTxs0UUR0Iuys5bZrEdWomab0ns18t2jJaXd55nQ2faI5Res
	 B77Cnmo0ZIRGw==
Message-ID: <db4d28a9-f751-493e-8270-44e206ebecbb@kernel.org>
Date: Wed, 2 Sep 2026 13:03:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3] mptcp: normalize seq numbers reported in
 mptcp_info
Content-Language: fr
To: sashiko-reviews@lists.linux.dev,
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
References: <20260902102125.2035540-1-kalpan.jani@mpiricsoftware.com>
 <20260902103649.04FD81F000E9@smtp.kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260902103649.04FD81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 02/09/2026 12:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Changing existing UAPI sequence fields from absolute to relative breaks backwards compatibility.
> - [High] Normalization falls back to 0 when `msk->first` is NULL, causing massive UAPI metric jumps for closed sockets.
> - [Medium] Data race on `subflow->iasn` and `subflow->remote_key_valid` yields corrupted UAPI values.
> --
> 
> commit 630c5d1d1841bed28f7903466f4319e79bf43c4c
> Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
> 
> mptcp: normalize seq numbers reported in mptcp_info
> 
> mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt report the raw
> 64-bit data sequence numbers, seeded from the connection's IDSN/IASN.
> Since the IDSN/IASN come from mptcp_crypto_key_sha(), these fields
> carry an effectively random offset and are not useful to userspace as
> absolute values. This commit normalizes mptcpi_write_seq, mptcpi_snd_una
> and mptcpi_rcv_nxt in mptcp_diag_fill_info() by subtracting the local and
> remote initial sequence numbers.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
> 
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index fcf6feb2a9eb5..88bd75672c96e 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
> [ ... ]
>> @@ -1008,9 +1009,22 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>>  	info->mptcpi_flags = flags;
>>  
>>  	slow = lock_sock_fast(sk);
>> +
>> +	if (msk->first) {
>> +		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
>> +
>> +		local_idsn = subflow->idsn;
>> +		/* subflow->iasn is incremented once in subflow_set_remote_key()
>> +		 * to account for the peer's virtual SYN; undo that here so
>> +		 * rcv_nxt normalizes against the same baseline write_seq and
>> +		 * snd_una use.
>> +		 */
>> +		remote_idsn = subflow->remote_key_valid ? subflow->iasn - 1 : 0;
> 
> [Severity: High]
> When the MPTCP connection enters TCP_CLOSE, msk->first can be set to NULL.
> When diagnostic queries execute mptcp_diag_fill_info(), local_idsn and
> remote_idsn will remain 0.
> 
> Does subtracting 0 cause the UAPI output to abruptly revert to the raw 64-bit
> absolute sequence numbers?
> 
> For diff-based monitoring tools relying on the new relative behavior, could
> this cause an astronomical jump in reported sequence values?

I would say (without checking the details), in this case:

- either we return 0 for the 3 different values below

- or, when closing the first subflow, the 3 fields in the msk are
updated with the offset.

But, before that, is it still possible to retrieve info from this socket
after the destroy part? If I'm not mistaken, this destroy part is
reached only after a "close(fd)", not a disconnect or anything else. So
the userspace shouldn't reach it via a `getsockopt(MPTCP_INFO)` (or
similar).

I guess there is still possible to reach this code after the destroy
part when diag info are obtained from netlink (e.g. `ss`) in parallel.
But that seems to be more a race than a specific "post-close" query, no?
If yes, then the main point is not to crash. Then maybe a workaround is
enough, e.g. resetting fields, or modifying them with an offset.

> [Severity: Medium]
> Is there a data race when accessing subflow->remote_key_valid and subflow->iasn
> here?
> 
> mptcp_diag_fill_info() accesses these fields under lock_sock_fast(), which only
> acquires the process context lock. Concurrently, subflow_set_remote_key()
> writes to these fields in softirq context under mptcp_data_lock():
> 
> net/mptcp/subflow.c:subflow_set_remote_key() {
> 	...
> 	subflow->remote_key_valid = 1;
> 	subflow->remote_key = mp_opt->sndr_key;
> 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
> 	subflow->iasn++;
> 	...
> }
> 
> Because remote_key_valid is set to 1 before mptcp_crypto_key_sha() populates
> iasn, can this diagnostic code read iasn while it contains garbage?

Set "remote_key_valid = 1" after having set iasn?

> 
>> +	}
>> +
>>  	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
>>  	info->mptcpi_token = msk->token;
>> -	info->mptcpi_write_seq = msk->write_seq;
>> +	info->mptcpi_write_seq = msk->write_seq - local_idsn;
> 
> [Severity: Critical]
> Does changing the established UAPI semantics of mptcpi_write_seq,
> mptcpi_snd_una, and mptcpi_rcv_nxt from absolute cryptographic sequence numbers
> to 0-indexed relative values cause a regression in the kernel's ABI?
> 
> Could any userspace application or tracing tool that relies on these fields to
> correlate socket state with on-the-wire MPTCP packets (e.g., using tcpdump to
> match DSS sequence numbers) break immediately?

That's on purpose, adding a specific note in the commit message is
enough? People shouldn't expect these counters to be exactly the same as
on the wire.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

