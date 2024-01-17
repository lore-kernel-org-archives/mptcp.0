Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE47F5
	for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458730; cv=none; b=lfGZ0zRFYISEajUKJoyFgFHjMLBV/gTH4Q862jmb1xh10scJDPZSeRti+o86cIeDBNYZqbQcxr8ByNHe9FRXMexwCwHlHfPJQmO/lXPvkI7WZxjWlD4XHM5kWrM1P39u9D3SMisDEquGUXNGQGDUmNBRSE/avUGsfnsoKWx0eKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458730; c=relaxed/simple;
	bh=LDrBRxXlo9GT/YnUQZUTO8LfdHFCtw3mO77BhPyjf7M=;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type; b=eDok8Y236lTF5gsXi+TKOGWuECiv9NFi2/Lw/7C+Rn99CQvEexUq6QvVfvd4YBcIzF1rkTI1Vooei370uVd0XdjtGIeF9E5++y0zxxPIQwlYEK3XEQr6A0RcTAM1d4jiao5EgBZd2G/kdfjZYe8UBV5WXmR87m6G+6ySDP5LVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJYm1LlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJYm1LlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF79C43390;
	Wed, 17 Jan 2024 02:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705458730;
	bh=LDrBRxXlo9GT/YnUQZUTO8LfdHFCtw3mO77BhPyjf7M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NJYm1LlBZKp5TM0J9h1SYRLT1heknF6pdIKWwdi7eWRc++0xynx7P/x8Ktx8EhoOl
	 GSpq6/jz0P6eqowkcM7igZlsn4Mec0FHgxL51K6yOOoKEXC/nqIv/gmRrNI0qGxcDe
	 lAVqBCCpxILobSIJFBY/aISqhFHk9JQPp96JT3oxic+ZFtpa+UyvgFpLndBTeJC+RU
	 MqfTwmwORw9NDcg/g5Uox951vkySTILQaN6jIlbOqmFQ/VXsNeGpbZr6pFzIs4bEAP
	 sQq5Pojod42FPZqHAlblKUAj6vB41pbO1RSGA6+w4GszZ5x2mQZFNlfbUq+LjPmS+q
	 j9pld+d33wLUQ==
Date: Tue, 16 Jan 2024 18:32:09 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/4] mptcp: locking cleanup
In-Reply-To: <cover.1705331716.git.pabeni@redhat.com>
Message-ID: <fb88e379-a40d-0b8a-d64c-0f5957c85c81@kernel.org>
References: <cover.1705331716.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 15 Jan 2024, Paolo Abeni wrote:

> This is a preparatory work for the TCP_NOTSENT_LOWAT support. The latter
> will need tracking more state under the msk data lock.
>
> Since the locking msk locking schema is already quite complex, do a long
> awaited clean-up step, moving several confusing lockless initialization
> under the relevant locks.
>
> Note that patches 2-4 carry fixes tag, and could target the net tree,
> but AFACIS no real race could really happen even prior to such patches
> as the MPTCP-level state machine implicitly ensure proper serialization
> of the write accesses, even lacking explicit lock.
>
> Patch 1 has no fixes, but still is logically tied to the other patches.
> Possibly we could target net-next for the whole series.
>
> Paolo Abeni (4):
>  mptcp: drop the push_pending field
>  mptcp: fix rcv space initialization
>  mptcp: fix more tx path fields initialization
>  mptcp: corner case locking for rx path fields initialization
>

Hi Paolo -

The series LGTM, assuming the CI failure is the issue fixed by "mptcp: 
relax check on MPC passive fallback":

Reviewed-by: Mat Martineau <martineau@kernel.org>

> net/mptcp/fastopen.c |  6 ++--
> net/mptcp/options.c  |  9 +++---
> net/mptcp/protocol.c | 31 ++++++++++---------
> net/mptcp/protocol.h | 13 ++++----
> net/mptcp/subflow.c  | 71 +++++++++++++++++++++++++++-----------------
> 5 files changed, 75 insertions(+), 55 deletions(-)
>
> -- 
> 2.43.0
>
>
>
