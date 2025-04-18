Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4F224F6
	for <mptcp@lists.linux.dev>; Fri, 18 Apr 2025 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744937888; cv=none; b=lf0XHx+SuHzOt0b+nxhlGG5jris/9v/3NrMaWk/L8Sg1RHEk/JenyyPtZtoTDIS/KmEa294BcOXean8+BDjrOguNPCyCz8wH3GWIyIujFy1LlUT+5A8sPaysPCYxMZ7F6gsj7yk+uMescr2MpyRB+95PJAyNzLMTPdfh6N2O3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744937888; c=relaxed/simple;
	bh=SE7BwSgmZ3vLgxvfJgGA7G+8MBpPVRJrFt7Lh+JytOc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iUJJaisV8RVqCAj1UhEBfwXUN8T4nYKh4z0ikhfFQRzMYRzDmeOoKu2kxlkBa91ERqY56xCIFitTrpTIG/DMYjNmkTJ8bzIELzrLuqUlLwTo/+4ztSB4Spsgv3SmWgeMlPuTVzyAWE920UW6pM4DwvY7DNLCCERLtxnkCJIWJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRrkdsjN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRrkdsjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF1BC4CEE4;
	Fri, 18 Apr 2025 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744937888;
	bh=SE7BwSgmZ3vLgxvfJgGA7G+8MBpPVRJrFt7Lh+JytOc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LRrkdsjNXXjx8W6fJMR3MQu3et0ySS+xBYUNNN795ubmUR6HqPX4c7AP9Q6mOEF05
	 ktcUaVJY0t4kducAPIVkd2O9+4nTnL+3HeVRT5Gx65uKN1VESaQ6R4QgGtYxa4AjnE
	 tZjmxzSQVnhPAurHe1sE9CiHc1ZG5KrbK3mPBncXAfzu1LWDTAOtZRVOX1k0WoV/Jj
	 we/Gm1/Xztmv/McBT2yRnc02XNfZwbNfFtxbYUnvjq4Dn8g7W083xF1JMWdy5rjeaz
	 TnWTBlbl8fNrMAoNNqvQqKtB13yirMu/H3lZXJoUHAYcXCDcRqmgql2V5Wi+LD+Sb4
	 bIH0lWYOL/RjQ==
Date: Thu, 17 Apr 2025 17:58:07 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] only remove entry from local_addr_list
 when sending a REMOVE_ADDR
In-Reply-To: <cover.1744787273.git.tanggeliang@kylinos.cn>
Message-ID: <aeac99a0-df48-3aab-31db-43c6f4c7d35f@kernel.org>
References: <cover.1744787273.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 16 Apr 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v3:
> - update userspace selftests.
>
> v2:
> - squash patch 1 into patch 2 as Mat suggested.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
>
> Geliang Tang (3):
>  mptcp: pm: userspace: drop delete_local_addr helper
>  selftests: mptcp: join: update userspace dump_addr outputs
>  selftests: mptcp: userspace: send RM_ADDR between server and client
>
> net/mptcp/pm_userspace.c                      | 37 +++----------------
> .../testing/selftests/net/mptcp/mptcp_join.sh |  6 +--
> .../selftests/net/mptcp/userspace_pm.sh       | 12 ++++++
> 3 files changed, 20 insertions(+), 35 deletions(-)
>

The series LGTM, but I would like to do some more testing with mptcpd 
(outside the unit tests) to double-check behavior before upstreaming to 
net-next or -net. I won't be able to get to that before the middle of next 
week, though. Matthieu and I can talk about it on Wednesday.

Reviewed-by: Mat Martineau <martineau@kernel.org>
