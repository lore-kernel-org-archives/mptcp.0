Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61463D34A8
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383488; cv=none; b=KlKIR1OTIwS/exU21DJbPqNuZGzHx/Qs4jkKp8gfIIBAif7QQHK4+OnodLVRC6qhxF7+D8nGDfzILAKVQlKOufFh74zl/XFKSqOdCD3B78WTrMMz6LuurFIKXdPjNS6LeyKdOlCqrIfGeilAi4VhbAhvNuf7MJzfCo8mMKxNGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383488; c=relaxed/simple;
	bh=3lvINa6EPqxtNxv2IH0zY5eqdZCRJBP7Bf2kBGsLXts=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tgg8CREK7mZr2aagp1FPu9YuhG9xGNPFuebcNjZnHyy114Bf9EDKchlNqD8NAAl8KI0Y/8N4QvR77xVMMcv+S7L4zL8pxsWZBvQETxZV0+8ouZDcSv8wP11Q682zua/0Dv9A2Xac16lJCZPqBHPgpoVF7muvIq9BvIDcXC1OoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0wIwfqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0wIwfqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2812E1F000FF;
	Mon, 14 Sep 2026 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789383486;
	bh=NZgqF9D7kywy9T4BJ8cQS7qeGyaquPbYh8uReSKWijE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=B0wIwfqGkqdNRaofjf6JAwqx6UkAV3btWr4FuYjwJ2Ha6HQ+G0R9tAFZ1YC5chkl/
	 2ifkTfIr63GRrTK3bmV273QnNJLui+FxDF5KNjS8bp+1hjPwe4whRkrkoQgXxnK2Ci
	 96FucDwcmL9ksqIpMiDeVKAan/AsdyLFtyb8P23/uV+/G1ZpRLsCn8BQsnkh7UVl/Y
	 H2Z2ufzUQ2vNwikSDzmUiATN+QfLE/auvZxRuXj+WS8xZzjLOhpiPU/1wRrvsLvZOf
	 +5aWZ2Co8+88pkNOj4JjV1+d4CGF1/7MfxvdMNW9fe3E8NyXB5AzzJskKJu8rciXEu
	 Ssp0saBlGJbDA==
Message-ID: <90b59b07-8200-4990-8186-6e04844c87e4@kernel.org>
Date: Mon, 14 Sep 2026 12:58:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 00/16] MPTCP sockmap support
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <20b73dd157c0e948ba2b33c3600f33097fab5299.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20b73dd157c0e948ba2b33c3600f33097fab5299.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/09/2026 11:48, Geliang Tang wrote:
> Hi Matt,
> 
> On Sun, 2026-09-13 at 18:14 +0800, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> v5:
>>  - Patches 1-4 are from "Reduce the differences between TCP and MPTCP
>> for TLS usage" set.
> 
> I put the four patches from the "Reduce the differences between TCP and
> MPTCP for TLS usage" series here because this "MPTCP sockmap support"
> series depends on them. Actually, it doesn't just depend on these four
> patches - it also appears to depend on "mptcp: remove CB offset field"
> (see sashiko's comments on patch 9) and "mptcp: implement peek_len for
> proto_ops" (see sashiko's comments on patch 13).
> 
> So this series depends on the entire "Reduce the differences between
> TCP and MPTCP for TLS usage" series. I could use "Based-on: <...>" to
> trigger CI based on the dependency, but Sashiko doesn't recognize
> "Based-on", so it won't be able to apply successfully.
> 
> Is there some Sashiko feature that can handle this kind of chained
> dependency between patchsets?

Not yet, apparently:

  https://github.com/sashiko-dev/sashiko/issues/49

> Or do I need to include all ten patches
> of the "Reduce the differences between TCP and MPTCP for TLS usage"
> series in the next version? I'd appreciate your thoughts on this.
> 
> Alternatively, let's first do the review of the "Reduce the differences
> between TCP and MPTCP for TLS usage" series - it's already ready for
> review - so that both the subsequent "MPTCP KTLS support" series and
> this "MPTCP sockmap support" series can move forward more easily.
Probably best to do that. I admit that with all the different series and
revisions, I'm sorry, but I'm a bit lost regarding the priorities. What
should be reviewed first?

These series?

 - Reduce the differences between TCP and MPTCP for TLS usage
 - mptcp: remove CB offset field
 - mptcp: implement peek_len for proto_ops

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

