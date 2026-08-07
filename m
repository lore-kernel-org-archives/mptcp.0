Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED306345EB7
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119008; cv=none; b=Dm/tBfZ0zuwZYvuS6Wqr0LXHHE3zqjJKdQliy6ffj0tpXv8UEiPW3B3fZ9N3SptPY85FbfwraZrOJYJC3cot16ABCvSl8A0qn0j9I4Peue8u+A5hTu9098aYfBMSwa+GoYCPdld1SDe5jvUvMZaHrBNecKCUONSLxSg80U0N0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119008; c=relaxed/simple;
	bh=03BTHd6kepChCEulUtnxyh4fbSaCXhGZHrAPNeEmE1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Njh5tYwPL6jvw4oGGqt67FL6jQqlG2Ojnaz9NR3idWWu6Zj+8VUPqenYRY20/3NO4ldJIEBFA9106xXtNtmAwaYSP3becJD03YOffjHbPnTVlQsGWvNVrjGA+4zj3FGsdEnCzor1WV8lw5UtsqogdsKYpfF3I/a8x2H2udk3+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww5uAFwF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww5uAFwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05761F000E9;
	Fri,  7 Aug 2026 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119006;
	bh=LIXwymg6u06kJXC6WUuUb+mMkB/5s6sQgntn4aTb8yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ww5uAFwFroubNSi8oTM5PgaSfkyy49KO5MuWqxsm5K4Lin+HRstIqYED73v9FXG2V
	 14qYozIBkfBq2ukdaaU+mMTA5P9q/XbeYvJYQ6xW3l7g3FajN3tgreEtkTCKh17es1
	 lcElEynLEMW6KwmN6z61/1A5efmUfzyttXcivq/+QjE4NeTv9XMiQpHaDUFoNts+HU
	 V0lafr2Exk6nbBQztTX8El0wQtXEBjB7Fp8RCDVSiwaz9Es1un91QycBlwLmRHDHcA
	 6Bvk9myacQv9gkwlvtTsW+tFT7JkEYzwJv1NSh4K9KBR9XIPx0EjtiWF25cr66hNky
	 enPoVXJ0aQSPw==
Message-ID: <9d846f7b-9c64-410d-a18e-933658f042c1@kernel.org>
Date: Fri, 7 Aug 2026 18:10:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 3/3] DO-NOT-MERGE: mptcp: sched: penalise
 counters
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, janak@mpiric.us
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
 <20260726-mptcp_penalise_send-v1-3-84485e0e995b@mpiricsoftware.com>
 <70fa5aff-40c0-4ca5-8a29-4e57489d3637@kernel.org>
 <30b7b05258dda636068fd53b3e0b5a5ef509d3c1.camel@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <30b7b05258dda636068fd53b3e0b5a5ef509d3c1.camel@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

Thank you for your reply!

On 07/08/2026 17:19, Shardul Bankar wrote:
> Hi Matt,
> 
> On Wed, 2026-07-29 at 13:50 +0200, Matthieu Baerts wrote:
>> Hi Shardul,
>>
>> On 26/07/2026 07:55, Shardul Bankar wrote:
>>> Instrumentation for validating the two preceding patches; not for
>>> merge.
>>>
>>> Adds two MPTcpExt SNMP counters:
>>> - CwndPenalized: times a subflow cwnd was actually halved;
>>> - PenalCandidate: times the rate trigger picked a slow subflow.
>>
>> I think at least the first counter is interesting, probably the
>> second
>> one as well, no?
>>
>> Generally, if you need counters during the development, they might be
>> needed to debug issues. But here with the scheduler, maybe the
>> tracing
>> are better. Did you use "trace_mptcp_subflow_get_send"?
>>
> 
> I did not. Looking at it now, it fires before the penalise decision and
> does not see the halving, so it would need a small extension (a new
> field, or a tracepoint at the halving point) to show what these
> counters show. Which would you prefer for v2: keep the DO-NOT-MERGE
> counters, or add that tracepoint? I will go with your call.

Maybe both?

If you can add a new field for the tracing, that would help with the
development. The MIB counter would help with the debugging.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

