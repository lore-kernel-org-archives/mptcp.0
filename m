Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063C26E146
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876035; cv=none; b=oTwLY4AEwKHlEoEVPe24bBlkrTssdZsSVY690l1pMt0KEYYfUTiVy2bzL3vtEQs2wk1ezl4h/prsubyCGYIXA87x/UAxWZPLxl41x/2WgYbS3JTUpkoX1DcH5mlawJ8JfXU/BFE9vFa4WK7QHvZY3TNo6iJUZQfREZBew/jvRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876035; c=relaxed/simple;
	bh=/8ePIaJg5isv8TlpN/VGfKw5Rm9eFEcKXACBIH3vp48=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=JRYRUtXkF2S57nAzNIh6oPRjZ58nyt1FYT5xmgtPVCw1MmnMsmFndrpy/X2Ebd4lnxKsYvJI4U3VQRxrCzuth3yPT027YEQ7HfH++yzo9aa9IADoxrGhczEYikbJlcdIPTwyB0TJh5MKcH7LLdZ2KUfAPZnI3PbzyXG4UZVwXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxyUUQnz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxyUUQnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DACBC4CEF7;
	Tue, 11 Nov 2025 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762876034;
	bh=/8ePIaJg5isv8TlpN/VGfKw5Rm9eFEcKXACBIH3vp48=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=FxyUUQnzbj5XCtN2VXFCcjDXrWGyBRSHERRDYNXZ25V7niF8pgtI29fBe01sKq+Hg
	 k8dMSVCqD/XKvn/NdljH3ENKQLJbPZqYu0U9SM9bToyDdOlgAxwAhsTD3fVrYUshS9
	 x5ADkoPTCVJZo44ZiNe7WnIeq7RV6dzduHWkQ8CQHuLDaAWBmwn3ljP3uPp2i/YBsM
	 6xmbUTsDExs6c0aP0XROtmdK01f+85xBq8/oumnvJl5gIAIDrWhIm7FzpfYivAkCGo
	 1pC7OaL9bh4r/Fdc2dLZen5iJhacEMUr01fpo7FtZWnhJBjFPFskgItOeHcIcC0s2U
	 +EGYTyfjK0uCg==
Message-ID: <db7a5754-c4de-48d2-9cf8-892a0d4db38e@kernel.org>
Date: Tue, 11 Nov 2025 16:47:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: fix ack generation for fallback msk
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <14a868192851deb4145a90e3b7eec616544da262.1762474159.git.pabeni@redhat.com>
 <fa8316ac-594e-443b-b9dc-00103ee8557a@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fa8316ac-594e-443b-b9dc-00103ee8557a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/11/2025 16:30, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 07/11/2025 01:10, Paolo Abeni wrote:
>> mptcp_cleanup_rbuf() need to know the last most recent, mptcp-level
>> rcv_wnd sent, and such information is tracked into the msk->old_wspace
>> field, updated at ack transmission time by mptcp_write_options().
>>
>> Fallback socket do not add any mptcp options, such helper is never
>> invoked, and msk->old_wspace value remain stale. That in turn makes
>> ack generation at recvmsg() time quite randomic.
>>
>> Address the issue ensuring mptcp_write_options() is invoked even
>> for fallback sockets, and just update the needed info in such a
>> case.
>>
>> The issue went unnoticed for a long time, as mptcp overshot the> fallback socket receive buffer autotune significantly.
> 
> Should we say "used to overshot"? :)
> 
>> Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/594
> 
> Thank you for the fix!
> 
> (...)
> 
>> @@ -1643,6 +1660,9 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
>>  				      opts->reset_transient,
>>  				      opts->reset_reason);
>>  		return;
>> +	} else if (unlikely(!opts->suboptions)) {
> 
> Small detail: do you mind if I add /* Fallback to TCP */ just above when
> applying the patch?
> 
>> +		mptcp_track_rwin(tp);
> 
> Should we eventually also call mptcp_track_rwin(tp) in case of MP_FAIL
> without MP_RST? Or is this not needed?
> 
> Other than that, it looks good to me, and I guess we can already apply
> the patch:

That's what I just did: I guess the modification for MP_FAIL, if really
needed, can still be added later on.

New patches for t/upstream-net and t/upstream:
- c3a571ff59cc: mptcp: fix ack generation for fallback msk
- Results: 751a2432b7d8..5b6b4e3aef4f (export-net)
- Results: 247540d77d20..a96affe5f0a1 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/7fade8917eeabe227b5ffae540e9cbe48d3e5046/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/b10c1d3d1e5da09bbc2b81eca8f4339b84499268/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

