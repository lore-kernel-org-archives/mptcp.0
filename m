Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2513B7BC
	for <mptcp@lists.linux.dev>; Wed, 24 Jul 2024 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859916; cv=none; b=cPvP87JYcV842N7sg01zxBNzfXbQyoyOXtS3RoNLgY3fWpOW6sTxQiYjnEAIJ4njGM6//OPKkl4ZRb+mpVx4tnlr2iAxJ9P0GOsyGhU8U+ZO5ybBQ29txeQoqykJtpuGCjGVJG0iTt71HT7dHF45h1NtGGH8wkc5O493YeOmoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859916; c=relaxed/simple;
	bh=312R/1MVWUYeTK5fYt0mNu+G0dgu63k3kB6V7Nt7VVY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jE/II1AmvsFRcjRBaEYV/v1sVR4YO3zPG2ofbYdmm39bZfyhg5+ZW449J7XkN67tfcwKnps+OIcugXfd3uSoGUuMCWUxRSgU4TGZI6Md+GsOcc8+4tDBKpuWR1IVJ2CLlvFhC4CVZCKKdaIB7m9/pGuIDSaHtgIwpiI6VkO8jUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FieeBnhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FieeBnhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971E2C32781;
	Wed, 24 Jul 2024 22:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721859915;
	bh=312R/1MVWUYeTK5fYt0mNu+G0dgu63k3kB6V7Nt7VVY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FieeBnhYdMkatYQEOvHUXghghiFk1B4+1BK8Dpcvlc2lTg0c13afrCFf4/GoxtGTy
	 ek6oxU1LsmYzyGj0elKf2xpvjOeTcCXzTzJQ8jqjCNpGpmAbcTWvz7BRE+3s134vQT
	 Yf26uqOMRGDhb58VxLRuttqIWPl695ijb71brUJATt6ejRzFNr8kFZtHzE4RBX7M/l
	 NMr9pKIBCAcv9EV0anohlVmoN/uu+4z7QwM3M15rvMSvR32/7CQU2IOxRPvig34XEL
	 vC1smdmPde3msXf1O+cFHjrM04XQsFo+SlZ/tb+ehhhWfL/EvZKMsMgp5QR9bGJSOf
	 H05MGRZSjBsRA==
Date: Wed, 24 Jul 2024 15:25:14 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-iproute v2 4/7] man: mptcp: 'backup' flag also
 affects outgoing data
In-Reply-To: <20240723-mptcp-user-feedback-v2-4-59f18975401c@kernel.org>
Message-ID: <478fa8ca-30e1-6be3-d8ec-4469a0f3b816@kernel.org>
References: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org> <20240723-mptcp-user-feedback-v2-4-59f18975401c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 23 Jul 2024, Matthieu Baerts (NGI0) wrote:

> That's the behaviour with the default packet scheduler.
>
> In some early design, the default scheduler was supposed to take into
> account only the received backup flags, but it ended up not being the
> case, and setting the flag would also affect outgoing data.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> man/man8/ip-mptcp.8 | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> index 11df43ce..4d4c879b 100644
> --- a/man/man8/ip-mptcp.8
> +++ b/man/man8/ip-mptcp.8
> @@ -172,8 +172,9 @@ If this is a
> endpoint, the subflows created using this endpoint will have the backup

Hi Matthieu -

I think we should clarify this text some more.

> flag set during the connection process. This flag instructs the peer to

Changing it to "remote peer" on the above line will help clarify the part 
about the packet scheduler below.

> only send data on a given subflow when all non-backup subflows are
> -unavailable. This does not affect outgoing data, where subflow priority
> -is determined by the backup/non-backup flag received from the peer
> +unavailable. This does also affect outgoing data when the default packets
> +scheduler is used. With it, the subflow priority is determined by the
> +backup/non-backup flag sent to or received from the peer.
>

How about: "When using the default packet scheduler with a 'backup' 
endpoint, outgoing data from the local peer is also affected: packets will 
only be sent from this endpoint when all non-backup subflows are 
unavailable."

The other patches all look good to me.

- Mat
