Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EF388E5B
	for <mptcp@lists.linux.dev>; Tue,  6 Oct 2026 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313295; cv=none; b=QbNBqiMbXE6VlsFXUwNYC0wQ1H49bpPD9+u51x32FkGteFehQqaWhr8CX4Da/pyEUTU8n872UunxU0oGG0Xgq06DBINo27W+XUVgbe4KjGY2p09ggeC06lL1vJd7mOVX+xSNWHtuUdvdkXHfnWEUa6s3C37iriMVBIezyIczkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313295; c=relaxed/simple;
	bh=PA8cOifQZjtRF4ggvnwxWcL5wCZwN6LOVklyuvVddaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNNu7WTWqMDMnQ8N8WW3cPoynPDq64kuQSfkS0CsqrSzlpd0aRM353SXyVh7hcav6Kc2qcnw2gO0lWZA+EBcuz5YfqVLrxUozfR/JiHmW2ByjngSAvdZlNye39HDHPgnZWwV47HHCnYwI7876NV6PUNL4007OC3vIbmQtTJPPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHw9mtY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHw9mtY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5871F0089B;
	Tue,  6 Oct 2026 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791313293;
	bh=sTyiBfpztr2xfRQmgEGq7IPa/HY4Qpv5kDxa/6c6JO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AHw9mtY3oMwpmUtTQgBG14I9GswTyyXrh9qQcHL7KCOQhxUUDf4jOkklmfWy/4/T3
	 zRhKGjPAuhVM0lxhkdYUhpWt2uMpADdcl04BuDPXKeAAsp5fQUDz9enbxJ5M/tzSnc
	 R/qS6tz83yBY0QvOElp/utxuRl5TWdeq2g00IgdwWMiLkF5ajcvF+4ZTzWilpac81m
	 vLsyPVn+2JCrTra+XR883mS5lwtNYnWvMFMCI4cAZzxSZQhpc4RPDvDn9SNNH64T5Q
	 wOMBcCXuHtmib5pnjCC8N18qdPJFktJ0vop/W7kOceuTEMEe8wG+b8Zzuh0mCHNbQj
	 5Oi3DGrx4U2Fw==
Message-ID: <7ea079f5-f610-4613-a4a4-bcb53cbd2b1c@kernel.org>
Date: Tue, 6 Oct 2026 21:01:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v7] mptcp: normalize seq numbers reported in
 mptcp_info
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com
References: <20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 30/09/2026 12:28, Kalpan Jani wrote:
> mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt report the raw
> 64-bit data sequence numbers, seeded from the connection's IDSN/IASN.
> Since the IDSN/IASN come from mptcp_crypto_key_sha(), these fields
> carry an effectively random offset and are not useful to userspace as
> absolute values: a caller has to snapshot two getsockopt(MPTCP_INFO)
> calls and subtract to get anything meaningful, which is exactly what
> tools/testing/selftests/net/mptcp/mptcp_sockopt.c already does.

Thank you for your patience! It looks like it becomes way more
complicated than expected, e.g. I didn't think about
mptcp_subflow_ctx_reset() being called on the first subflow. Maybe it
should only be called when coming from mptcp_disconnect()?

Also, perhaps mptcp_diag_fill_info() can stop early in case of
disconnected MPTCP socket? Most fields are reset on disconnection, so no
need to bother. (And/Or check icsk_ulp_data validity?)

About the patch itself, and similar to the general "kernel code style",
please avoid big comments in the code, and huge amount of text in the
commit message simply describing the code change. I know LLM loves doing
that, but that's not human friendly. What is important to add in a
commit message are the reasons why you need this modification, and why
you took one way and not another (+ pitfalls/remarks), but no need to
describe the diff. If it starts to be too long, that's probably because
you need to split your patch. If you need to add text to "please"
sashiko, please mention it somehow.

Note: no need to address the 'low' comments from Clashiko (except the
one about the '---' missing after the Signed-off-by).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

