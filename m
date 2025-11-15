Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31413D521
	for <mptcp@lists.linux.dev>; Sat, 15 Nov 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170328; cv=none; b=I+mts4S2zm7AgQvxJUKNeln5D//JI5Y/AXd3DulGWtTon1B2C9aC9na3MONUtkguv81XkWobxU/ZtVRaU4OG7WChBKXO7w18gcXPMn9AA84OZH9vbMDDuF1jW0O+ZOs7gAeGytUlZbaevVJT83Zorx1gs8JhvG285jgmbEGEe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170328; c=relaxed/simple;
	bh=hBR7fB7xrRfooGi2N8U9sx8z03rz2u0IlQh2QO2Iv8A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MBt4JQeT4dAwJeZTauMhrjdjRtN3Fr9jAYEAei3jw3nyl3Grtoi020Su9GpNtcMZv3uKUIHr8cDK1u9ZAmVYkLoQYABD+E9x/Bowd8AHNO8MdT2zyN2gNW5AX3Py1V72DllcRAPN2sNxV5YEE3OYjATUC4Lh13dxNmFjdJkNnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evpkeIMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evpkeIMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A49C4CEF8;
	Sat, 15 Nov 2025 01:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763170327;
	bh=hBR7fB7xrRfooGi2N8U9sx8z03rz2u0IlQh2QO2Iv8A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=evpkeIMSFY76Idk0vH33H/LJg6Ox19SVfoZQKConqj9xiHbYDxP8BIJ4vdB5KPH94
	 jjMMXagejeVynsOKLgcxPIE9g7lyc0XcuaRF3WkCVwivMM14DsExL2tXvQDYWAF+4K
	 aRZFN1XWhWf1SI7L4UUj4TWddQV2hFWlmgkDkLJDFL58TMbJbQ9BbpaQxWbv2sY6hB
	 T5yfxpdK73ydpLS3QCJ5Qmo0KjMSd6AqbVpPGpN4qN6E4awBVSpHQZKjCTn2FMjxu1
	 DBlWb1BDQrB+QrWiZ/WDpmaEZNQJO5boofVNzvWO0JTaBPO6/QWVdmpTFcA17GGAA+
	 m5hQf7fDj6xkQ==
Date: Fri, 14 Nov 2025 17:32:06 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 2/6] mptcp: fix receive space timestamp
 initialization.
In-Reply-To: <7152b5431a95b1b52251e7df3120590c28749a1a.1762940290.git.pabeni@redhat.com>
Message-ID: <60fc0dfb-df45-f57b-7a9c-02cb8271adbd@kernel.org>
References: <cover.1762940290.git.pabeni@redhat.com> <7152b5431a95b1b52251e7df3120590c28749a1a.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Nov 2025, Paolo Abeni wrote:

> MPTCP initialize the receive buffer stamp in mptcp_rcv_space_init(),
> using the provided subflow stamp. Such helper is invoked in several
> places; for passive sockets, space init happened at clone time.
>
> In such scenario, MPTCP ends-up accesses the subflow stamp before
> its initialization, leading to quite randomic timing for the first
> receive buffer auto-tune event, as the timestamp for newly created
> subflow is not refreshed there.
>
> Fix the issue moving the stamp initialization of the mentioned helper, as
> soon at the data transfer start, and always using a fresh timestamp.
>
> This will also make the next patch cleaner.
>
> Fixes: 013e3179dbd2 ("mptcp: fix rcv space initialization")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> -- factor out only the tstamp change for better reviewability
> ---
> net/mptcp/protocol.c | 7 ++++---
> net/mptcp/protocol.h | 5 +++++
> 2 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Mat Martineau <martineau@kernel.org>

