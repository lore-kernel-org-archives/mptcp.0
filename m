Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5C443F
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311976; cv=none; b=ZQyefSEnuE0cY5omp43uS7GH2E1C3VDSEYg9Iehv68Ctwl0ae26aXyuwPFWDG5tRv8zPk6DBwwNjptNfdIbgyVk35YHRMBUtvcScRfo/I4+7IK0Q58QvxuIEHQjdt/IgLmyF64IrLmwFWBpRYOYrgAiOYQR1Vft/Cg2lj4P7JA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311976; c=relaxed/simple;
	bh=29dduxNk86gOJ1gFyjB7NE3XqRj070mcAUeTBKEBoHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Loy5FB4RXVsj+u3CkKhp+RZxIvYrCRYvXe8wGcQBHUx6DeHg8YbR3q8EFRlTpWERfIKB/gQivdEIkmRSyNKVYxEM0SRYnoe7rCyoe2YZxszCfElGsp7VH+8E9ZmXolQV5xbqUNlkdOSbPuzcn1htFM1SITWp1cY3hM1qN0C/iOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yeq9lAiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yeq9lAiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD32C433C7;
	Fri,  1 Mar 2024 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709311975;
	bh=29dduxNk86gOJ1gFyjB7NE3XqRj070mcAUeTBKEBoHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yeq9lAiUrOhu6lHHPmjZPyu57rQ8SboWITMt7ewSRfkwfI+LuTUwsMbL/pHj7AhUF
	 spajOZgGIIaNYw3eCp/Uekbt8VbQQcxjL4KWsQn+E7beORuL+akYSEunr+x7hOLBZD
	 GBOa7RB//LjrWYqPcr1ietrEHK/enqW8Ma6oGJe4HvCnN/P9tyE7a+8XT3nAPmoB69
	 6nriFtZteo8romlEEFq0ZUvzDVXARwjRLF398SqkWCZSIVXvJYE03vgitfdjwu8SsN
	 oD44V77nT/JRang9gMG8Qz9qYBrPOjaY97X3kf0Lh+/eqXxQtgFH1N2Z6BRlFb00yL
	 vGkpC45OgQ1+g==
Message-ID: <32dcce93-7180-487f-839b-239b5331f9f4@kernel.org>
Date: Fri, 1 Mar 2024 17:52:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: mptcp: diag: avoid extra waiting
Content-Language: en-GB, fr-BE
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20240301163846.1370114-2-matttbe@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240301163846.1370114-2-matttbe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/03/2024 17:38, Matthieu Baerts (NGI0) wrote:
> When creating a lot of listener sockets, it is enough to wait only for
> the last one, like we are doing before in diag.sh for other subtests.
> 
> If we do a check for each listener sockets, each time listing all
> available sockets, it can take a very long time in very slow
> environments, at the point we can reach some timeout.
> 
> When using the debug kconfig, the waiting time switches from more than
> 8 sec to 0.1 sec on my side. In slow/busy environments, and with a poll
> timeout set to 30 ms, the waiting time could go up to ~100 sec because
> the listener socket would timeout and stop, while the script would still
> be checking one by one if all sockets are ready. The result is that
> after having waited for everything to be ready, all sockets have been
> stopped due to a timeout, and it is too late for the script to check how
> many there were.
> 
> While at it, also removed ss options we don't need: we only need the
> filtering options, to count how many listener sockets have been created.
> We don't need to ask ss to display internal TCP information, and the
> memory if the output is dropped by the 'wc -l' command anyway.
> 
> Fixes: b4b51d36bbaa3 ("selftests: mptcp: explicitly trigger the listener diag code-path")

(Note: mmh, I start to have too many commits in my repo, I need to force
'abbrev = 12' instead of using the automatic value)


I suggest already applying this patch and sending it to netdev ASAP, to
stop all the unstable diag.sh tests when using the debug kconfig:

https://netdev.bots.linux.dev/flakes.html?br-cnt=88&tn-needle=mptcp/diag-sh

New patches for t/upstream-net and t/upstream:
- 195a689388c8: selftests: mptcp: diag: avoid extra waiting
- Results: 7b9cbda58a89..cd1cba94145c (export-net)
- Results: 00e04e87933b..bb1b366ebd4b (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20240301T164913
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240301T164913

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
