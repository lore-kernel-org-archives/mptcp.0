Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A31420A8
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325971; cv=none; b=Eb7r5s/jKkM7/9vTz7qB0xv+IvW8Q/c66timHtbrc8bIEyi8zwoF1aTVbPGANGQUubSsb1T8ziwa6/Vrrwwr1kbSyAp8jbMbW/CKFt/WyDL3bZHPUMBszBfV3G1DNazx6e5EyJJ9fRDHK2iN9WAlDf8eKDh7hhBxniPXrWSKGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325971; c=relaxed/simple;
	bh=LpXZRWrvUE8Ff3Amz2N5jioeK82ZoJIYda14syrRTWQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PdbR5NNdmLXNJgENE1Fyws+rN6d0+INTF1uDBGtIx3G8wVbXVG1Iy320vF4ukdMqiJWsRInWd8kDMlbPCPVqrnkbkcATGEear4+aQD5WYJ45xQtaFjk9SX9by86nN27bJ0tvXQm4j10gluZLA2kb6W7O9PzkEkz3tVDFyMV3rbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlSkly07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlSkly07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E57CC4CEC6;
	Mon,  7 Oct 2024 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325971;
	bh=LpXZRWrvUE8Ff3Amz2N5jioeK82ZoJIYda14syrRTWQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FlSkly07Ik3tX82zVnglWszePc7Ji87AS27a461AXDCZnmSKratpazm/3OywwpObF
	 hjH2udWrd0rVSyXSw0Q3UNF5W0LKdNfXqFaDIhMtA0YHWrmM9QkUW+lL5xZdiGxBTh
	 GFbSErd+WyIx/JH8OUYSGxmUWdfqteLEVGIt+1PFC4SZlQ7WFYV+cAkW+5DJkjt5xu
	 OMxcK6NkTTXnwvosTUtIXP5A1j6Hv0a9iWlkPPkit+fV66BhlFkeYhIP35u4S1j/5h
	 B0tXYXw9vJccrvqoa/74YFmq2CUi69qnFRDZr8FaglsBtZ7I3CGo0BqdwpuQQxxSYI
	 dSoUQr+r360Xw==
Message-ID: <671066d8-6ca3-4d75-9018-8b20b79b40a9@kernel.org>
Date: Mon, 7 Oct 2024 20:32:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: fallback if MPTCP opts are dropped after
 1st data
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>, Davide Caratti
 <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>
References: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
 <4e7fbc5f-3521-436b-a25e-007d5ce5c972@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4e7fbc5f-3521-436b-a25e-007d5ce5c972@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/10/2024 20:26, Matthieu Baerts wrote:
> On 03/10/2024 20:43, Matthieu Baerts (NGI0) wrote:
>> As reported by Christoph [1], before this patch, an MPTCP connection was
>> wrongly reset when a host received a first data packet with MPTCP
>> options after the 3wHS, but got the next ones without.
> 
> I would like to send this patch tomorrow to netdev: we already talked
> about it at the last meeting. Any objections?
> 
> Can I add any Acked-by/Reviewed-by by chance? :)

I just added the patch in our tree, I can add the tag(s) when sending
the patch tomorrow ;)

New patches for t/upstream-net and t/upstream:
- 501099bf8c1a: mptcp: fallback if MPTCP opts are dropped after 1st data
- Results: 400d24177d84..2a3f9c146e18 (export-net)
- 78ff2df2e86f: conflict in
t/mptcp-annotate-data-races-around-subflow-fully_established
- Results: 2ce52e0f26d3..e93738912d75 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/df4f7ff6d778e59b9f7ad5dc1d659805dc86e1ab/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/6ce058e0f7a716c81c5cacf692f285abfbd87a39/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

