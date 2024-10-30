Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375ED1D3578
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281031; cv=none; b=NVVjs9fcrHXlR0xhxqqwqq+kYfKOkXIe3zxM44U1taCnJl0fqH1lViSDuWWmnULq5aXFlQX/nASj/mn7hwgfrHpNX884QwOqOyqMamxEbgmyj1UTGYKy8BzaDTU2OdluUdk0SF9w4YGJJACElrIIrbfe41XP6Fk6wQSdIcmHRxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281031; c=relaxed/simple;
	bh=wB+HwbpkGcwu2pgBfwAZb6EoShg0+uPdfreeJ59SPdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXuRLSMgyoDSyWBVRY9zojkwUFphQku0xSRtT2Vk1hsyTijtqfTxthD/jHb3xRT5r8JVMcY5ofohOW/gmXa1y37OE0NVVSawvhFtp2UguLir1fFAA/UW/yM1V8Vrmzr1WBKzk0Gbzku1wq2vMRr/v36LjbCPSgmXJV0/2lQfg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgv81psq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgv81psq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0170DC4CEE5;
	Wed, 30 Oct 2024 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730281030;
	bh=wB+HwbpkGcwu2pgBfwAZb6EoShg0+uPdfreeJ59SPdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hgv81psqJgh520nZagt6GBKyicSBvG28ezQtudkIS2QSyIyD0CEcs9kPoVAhg3jgw
	 heYafLPD2YVj0hakg7FH5+KaEeNlmmHyku5jreNnkG4Pxmvc0JKrlYpikwgUTP5zzT
	 TStxVseR8RKDvuq78hPTekoRlcjhc8QUph188jKpeBYWvatYOfiQTbWk1H7fmBbPg6
	 HFBtrxxl/+6vUiDoG7t9G+KSnBbtu2mByqBpaIYBCUVrzCLxVCkMohzZjTjBmhhTYc
	 smJmhp7Z98IhKTiR7sRt0saPGh7IHnRAMZcnCfCBm0bQgNW8Maj99vVMXhIgsnAqCI
	 j8sBc22/gu4Kw==
Message-ID: <83561ed71dd7dd44571bb71c6dc5ac634fb1d9a8.camel@kernel.org>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Drop netns helpers in mptcp
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Wed, 30 Oct 2024 17:37:05 +0800
In-Reply-To: <1b2079c54c089a4d0e55dcb3814f0bdfee7d37faf43a24627fa65b496b21ecf4@mail.kernel.org>
References: 
	<70c1f95bae8ec4884be50e08053364c1d152170c.1730262704.git.tanggeliang@kylinos.cn>
	 <1b2079c54c089a4d0e55dcb3814f0bdfee7d37faf43a24627fa65b496b21ecf4@mail.kernel.org>
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
Content-Transfer-Encoding: 8bit

Hi Matt,

I need some help.

On Wed, 2024-10-30 at 05:50 +0000, bot+bpf-ci@kernel.org wrote:
> Dear patch submitter,
> 
> CI has tested the following submission:
> Status:     CONFLICT
> Name:       [bpf-next,v2] selftests/bpf: Drop netns helpers in mptcp
> Patchwork: 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=904505&state=*
> PR:         https://github.com/kernel-patches/bpf/pull/7982
> 
> Please rebase your submission onto the most recent upstream change
> and resubmit
> the patch to get it tested again.

BPF CI complains that this patch cannot be merged.

This patch needs to be merged into "for-next" branch of bpf-next, not
"master" branch. But CI defaults to merging into "master" branch, so
the merge cannot succeed. Do you know how I should handle this?

Thanks,
-Geliang

> 
> 
> Please note: this email is coming from an unmonitored mailbox. If you
> have
> questions or feedback, please reach out to the Meta Kernel CI team at
> kernel-ci@meta.com.

