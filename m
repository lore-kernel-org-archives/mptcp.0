Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A71BDDF
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680952; cv=none; b=pquge5yK1UG5ax7/3NBY+n0ITegVN3kToVjUyMFoP5Y+8SymdwTSvkGDV8HxWZlNw6PdTueYvMQrDj8V8R68tI98Sq2H4+zVNajHU/V5dMBN4xVodrJcCB6UaATU2ZZ2YVDMOfXgmwwCWZWCLDV/7ACmrhEWDd6n80oCecNXbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680952; c=relaxed/simple;
	bh=+CaSF9hT8Z8emfxPnM59op85rbiIWtFj0OkkrUemMXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qW5XEGwkaoBf2dK351p5JC4FCzMTm883Kd9Cdm0eYc7dix6UTZiRRqnazUh0MZMC0fSnaXNmhVwq+fBXD8Z7AXOxprirZjB9JjjHH3XrekWes/+olRZx80Hai/Xg2neBA/+qamx6QAcdMZkwHcOCppcZzcViWFfXmKoS+thM7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvUVWElK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvUVWElK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0EAC4CECD;
	Wed, 23 Oct 2024 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729680951;
	bh=+CaSF9hT8Z8emfxPnM59op85rbiIWtFj0OkkrUemMXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TvUVWElKiQrjG4CP4fdH3XTEcWg62Nb3O+zQ5WIVKQxLQkMJrYYiMej/YwjwzhCPi
	 w6raiYbqe8U47CjT6paTWuSMCFLukpH6dVdVUujNijY9w6kV6nJgokqYoXx3qde63s
	 1BCMeI/0rp4AVppD42zHXzweTlHMNdFH+m8q/egCyDoEwJVONt6LCX1x2EG4sdnUKf
	 nDi6E36j74dIsff+r5Qm8KvSghLIcXJ0Z2qZeSEufsz2FKDuLHnEqBDojhujIa1XzY
	 VJswq39NjyR8X+VaFUzw/rK8OZbUnj2DmC3gFOLOOZScVpkq5TrADcFpR4H2FGCL1o
	 SEZHSBs0m323A==
Message-ID: <24923be1-5073-4520-8254-2f968158fc86@kernel.org>
Date: Wed, 23 Oct 2024 12:55:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: no admin perm to list endpoints
To: Davide Caratti <dcaratti@redhat.com>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Organization: NGI0 Core
In-Reply-To: <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide, Mat,

On 22/10/2024 18:43, Matthieu Baerts (NGI0) wrote:
> During the switch to YNL, the command to list all endpoints has been
> accidentally restricted to users with admin permissions.
> 
> It looks like there are no reasons to have this restriction which makes
> it harder for a user to quickly check if the endpoint list has been
> correctly populated by an automated tool. Best to go back to the
> previous behaviour then.

Thank you for the quick review!

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 983e36f915c9: mptcp: no admin perm to list endpoints
- Results: 92052b68f397..0a8a1adbb6dc (export-net)
- Results: 00ca859b77be..608ba5fe2f44 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/9050db2fb737cfee7cbea717bfce23c98a493f7d/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/e11b0188e765c92ab69435e015ab77a3e94b769c/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

