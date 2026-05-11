Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E853296BDC
	for <mptcp@lists.linux.dev>; Mon, 11 May 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530600; cv=none; b=ckIm0/BsWATIA6Sphmsl9LWkQ7A99R+2Nd9Q0HjsOj1e897p/qe4jsL7lLr4IfexbL26QZdkPr72Qmfy0vuOGMGi/AIBvnV3///Th/3S6wexh2l8iJy9ryxzoBBcbpvhej3jA4gkmnFe5RW09fZtVsO4V5Rzz7B8yA22ME4zgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530600; c=relaxed/simple;
	bh=PPlAM+AtFK3i463Q+t5j7i1Z+tqAi61NwWdTnyJ55zQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QsyysSv4PXZLsafttZt6IEjZ+k3TIfwtjjynJNrLyRT5+Jj42NcHNw8vmTPH7an8zmskQSGXa2ZqRKXgJal4Y0/Z4LdoLN9jyM+J3jlo02eyfn0kEj2KQdb4RBKyHJtv+/LMtozMJdN8WNyQWKI+xgENVmSftW1C0EPmcc3Ns90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNwfntpQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNwfntpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BC0C2BCB0;
	Mon, 11 May 2026 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530599;
	bh=PPlAM+AtFK3i463Q+t5j7i1Z+tqAi61NwWdTnyJ55zQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iNwfntpQcD5qTDyBIh24pfaWYNaICPugCu8pLyWUii0WJOWi7UZrTakBmNzbzacJl
	 YjnvIjoCv7OQt+BNav5ca5vESRoTtCSG/Cr+/LdU/iwwExeSEHFeHXNBVGeG53Yui2
	 YJ7qYfXb23ODeY3Cz+StvUyIRsVrMjmPhMaJhoM+A0OA5D7uEnHAkpy2IjPb0zOj7D
	 C8nAmhibOpIJT/3+KSWEt3WLx4XI1Xa6sXsDobIFgFiq4pYUBini+r9oY1eCCCoLla
	 5PbE8dTX2yn0C9hOQI9KpuG4a0ke2vi+gJd50gEO7AIuDSYll5p0Dx4xntqZ7masL/
	 1YSTXW/7ZTU3w==
Date: Mon, 11 May 2026 13:16:38 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net 0/3] selftests: mptcp: simult_flows: reduce
 bufferbloat
In-Reply-To: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
Message-ID: <e4290c0e-6238-c7d7-b659-2e9f35b7f401@kernel.org>
References: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 8 May 2026, Matthieu Baerts (NGI0) wrote:

> Bufferbloat is baaaad, even in our selftests, let's kill it (or at least
> reduce it). By doing that, the tests (seem to) have a more stable
> transfer, and are then less unstable. But to be tested on CI sharing its
> resources!
>
> The last patch is for -next, safer.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (3):
>      selftests: mptcp: simult_flows: disable GSO
>      selftests: mptcp: simult_flows: adapt limits
>      selftests: mptcp: simult_flows: disable 'flaky' mark
>
> tools/testing/selftests/net/mptcp/simult_flows.sh | 34 ++++++++++++-----------
> 1 file changed, 18 insertions(+), 16 deletions(-)
> ---
> base-commit: 1b5f90649a5adc94f765b5dee7fbfec433a5a797
> change-id: 20260508-mptcp-sft-sflows-bufferbloat-49122c97440e

Hi Matthieu -

Series LGTM, thanks for stabilizing these tests.

Reviewed-by: Mat Martineau <martineau@kernel.org>

