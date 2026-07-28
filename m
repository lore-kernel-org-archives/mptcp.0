Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D23FB067
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230347; cv=none; b=U3vlT3pDlBAYLpfS31aogLACjGGnRPpV5DNYnlP5Z7qJcnhin4bg5W2hlDMqhyLA2XpkJQZO4X/bl86aRDyvN3rct3f76yqHSaRseeseI+z8sltRUKuccuOAM6+9aUOwem60uEM/2/PgNmvVw7dG8nTW5wZBzLvv4/HjsInKK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230347; c=relaxed/simple;
	bh=4vMoLi0SJEel+yOM7NHPzNElv5wfpdq4XCKP1oOVxo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=edAUtJEx58b0cD8H64st3hXxEZGEd9MnMvE/dqyMSMpYcfzHcADB8xOGp+QmCfVh+eLupKE4iRIOdFdWbF1A6G6rcvzfJm4b03+y3XW2E4ySZBQCXcOQFrRKnG9xRZGnvUY1/u0MB5Zlt2Ho8WRPEOX5VUk7dLfCn8+dIJLCURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4NR/3jO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4NR/3jO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2701F000E9
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785230345;
	bh=mCu97LPY3NY6//+iZi//xC4QkCgBhb5cOI7+YkmVaek=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=C4NR/3jONk9lHfbgzJRYT5Rr8pjNrdUFuWAEFWb+FHwbQHwIcgIrS3d4vxOQd3Ryu
	 0vNZVYwzUYfQZXgQaekXDGIXWuvBDXzIQ86r5x9I603LR3WUwoWMY8RSfScycugCNF
	 CcUFLolvUF9s+ipjan06b1mXkE7M+MDsfD6RcMHbPqPy/YdR67DzlSZbhaklFEdOwW
	 zaPlae6nfdK53pPAp0ARD9zbxNTavd+nV7vLFi6b+US2M7QThzcHzNVSQdYuw9Z5o0
	 zRVYS2AUC4iUaxChYva8VdKFTie4SCKcksqI6/2Te0l09J4LQR/a3Kgl5hqSntkw3a
	 3EyeL45FaPd/w==
Message-ID: <9b249085-49bc-4150-99e9-02d5c2cb8e3f@kernel.org>
Date: Tue, 28 Jul 2026 11:19:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: avoid combining some incoming
 suboptions
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260722-mptcp-harden-combine-opt-v2-1-2021e67703f3@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260722-mptcp-harden-combine-opt-v2-1-2021e67703f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 22/07/2026 00:57, Matthieu Baerts (NGI0) wrote:
> Some MPTCP suboptions are mutually exclusive according to the RFC8684,
> but also because in different places, the code doesn't expect some
> combinations to be present. That's specially true for suboptions that
> would be present twice, but with different attributes.
> 
> The new restrictions are the same as the ones applied on the output
> side, with mptcp_write_options. The same rules can be reused:
> 
>   Which options can be used together?
> 
>   X: mutually exclusive
>   O: often used together
>   C: can be used together in some cases
>   P: could be used together but we prefer not to (optimisations)
> 
>   | Opt: | MPC  | MPJ  | DSS  | ADD  |  RM  | PRIO | FAIL |  FC  |
>   |------|------|------|------|------|------|------|------|------|
>   | MPC  |------|------|------|------|------|------|------|------|
>   | MPJ  |  X   |------|------|------|------|------|------|------|
>   | DSS  |  X   |  X   |------|------|------|------|------|------|
>   | ADD  |  X   |  X   |  P   |------|------|------|------|------|
>   | RM   |  C   |  C   |  C   |  P   |------|------|------|------|
>   | PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
>   | FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
>   | FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
>   | RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
>   |------|------|------|------|------|------|------|------|------|
> 
> The only difference is with the 'P': another stack could send and
> ADD_ADDR with other suboptions (DSS, RM_ADDR), and this should be
> allowed.
> 
> A point of attention is with the MP_CAPABLE: it could be used with a
> RM_ADDR, but there is no reason to add it with a SYN. Note that even
> with a 4th ACK, it doesn't seem to be useful, except when IDs are known
> in advance via another channel. Better not to break that.
> 
> Also, in mp_opt->suboptions, there is also a bit reserved to the
> checksum, which can be used in an MP_CAPABLE and a DSS. Each time a DSS
> option can be used in parallel with another option, the checksum can be
> set, so the verification is combined into a new OPTIONS_MPTCP_DSS macro.
I hope that's OK if I apply this patch: I would rather send it upstream
soon to avoid even more AI-generated reports when combining incompatible
options.

New patches for t/upstream-net and t/upstream:
- f34e22f63cde: mptcp: avoid combining some incoming suboptions
- Results: 2668d30f6377..aa8e7044082a (export-net)
- Results: a596e199424d..f630d7e8910a (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/bffeddcac4e2dc23c53eeb0b2cc0251289dd1948/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/5daa351aeda080c736302d73482d93f9b78e5aa8/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

