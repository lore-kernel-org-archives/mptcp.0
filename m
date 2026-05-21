Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13F156661
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325018; cv=none; b=EIdi4tMq7nHLJDSjI8t2T9iqQI+a2ICpUuaawXV6qg0GNHRsR2EXRKtmBKZ2+L1K1MqY1s8mYrePFUkR5DTbWDA5QxqhxH6VvE6i9blnes7T1ux/J9UX5vdB0Lo2mYrjxglN3jrqtRxxCHpdS/H29u8GZVVvWVJZ7H7wJnjfhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325018; c=relaxed/simple;
	bh=eiSxacc4CHLGMTQsi+B5uOXZPixax/bx7Lg7Wc5YX9Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P6ZX+Xcib9E6Kqsv4RkFNq/DOR/JIpeBhrpT4CM8uFiN7FWriNJfrSQ/T4k5aWFogSQP+rOMBbeWIoGto7JvTkuGJLrN3HLuh900XwPNKRrYTm2lR/SvqkaEFVMfVXqFGNsNhYAIQyhL0zCqiHLeD/38Tg1qu2LniqTZD7qvCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOY/6JPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOY/6JPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13901F000E9;
	Thu, 21 May 2026 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325016;
	bh=xhxLsx94mhadygDwpqcBHs4QnZpCr6cRb6/8huTY+Tc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=FOY/6JPMGCvCKj3Y2rXDHKNNe3quJ6FAmebUKmLoTBn7x0gH7YqJZ08HwgAOcDzH2
	 iStmNisGpwnSxHyIwubonDNijqEd+BjtU6/Ysrlk2icy9wIKNVTh1dFzJASdfuxGtE
	 TXUYRa/il0hkXJQJc8jMRM278tUTiJJ2HxNwTTuNtxzHzHRPX1pEymkCNUOTkaQj9S
	 tGuDSac71ReSCSxQ6rG8m5IY25mWh5PZlF/EVy6rQjOEHEdMzzCEysOZohCNV+xs0r
	 8GYQlxAAI2aLA7D9r5kMB+X7KqQn0W4//NsuGQCbRPO+9mBrjjr54W+TXECCLmcVhF
	 Dg85qRCaMn41g==
Date: Wed, 20 May 2026 17:56:56 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 0/3] selftests: mptcp: small pcap-related
 improvements
In-Reply-To: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
Message-ID: <ca03a705-9814-aca2-8466-05bb6d589c87@kernel.org>
References: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 1 May 2026, Matthieu Baerts (NGI0) wrote:

> - Patches 1-2: add test name in pcap files.
>
> - Patch 3: drop payload from pcap by limiting the per packet size.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (3):
>      selftests: mptcp: connect: test name in pcap file
>      selftests: mptcp: simult_flow: test name in pcap file
>      selftests: mptcp: pcap: drop most of the payload
>
> tools/testing/selftests/net/mptcp/mptcp_connect.sh |  8 ++++----
> tools/testing/selftests/net/mptcp/mptcp_join.sh    |  2 +-
> tools/testing/selftests/net/mptcp/simult_flows.sh  | 11 ++++++++---
> 3 files changed, 13 insertions(+), 8 deletions(-)
> ---
> base-commit: 7478b1b74fb5013908a4237d3f929f3db03fb74e
> change-id: 20260501-mptcp-sft-pcap-prefix-b6b6250c50ce

Series LGTM, thanks Matthieu

Reviewed-by: Mat Martineau <martineau@kernel.org>
