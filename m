Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884B1E47D9
	for <mptcp@lists.linux.dev>; Fri,  8 Nov 2024 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069521; cv=none; b=kaj+5hgHbupxXGzehEe2YPeY05tPsjEvwhW9/dSvm5kj6McS6Yi4hpk+wzHEo4KRErI6aCDEqeILzfp/eGT0t16qas7D2pheQsACuu81WM53RVb/wrliEehbPOduy+G3IB0xSpRlVSTK7RusJCzjAQuIandEF9XpZR04AYFVkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069521; c=relaxed/simple;
	bh=rBlzUfBKFUQ7xNRQ6CqA3CMJaEWknJGg62TS2CcNDTA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GodUptTBNIYpnCUHsMWJdgkW8/9PLMV7UulL5TSoof8KctK9Am1/aTiVoJY7Tc058rnFTLudhJGOb2PS+uwZoxJEE0zA4CNjJ9hkquvEOMHyBvF5y/n/jn6HIsuzlywrE1A88jn1Fj83BRn9ePo6CMeGCjA+kZO3LRAbDBJdE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIas80CS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIas80CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CEDC4CED2;
	Fri,  8 Nov 2024 12:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731069520;
	bh=rBlzUfBKFUQ7xNRQ6CqA3CMJaEWknJGg62TS2CcNDTA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=iIas80CS7sO59jEgA2riPde5Fge0FVmBS6eOXZ3WaF+QH/Y/NmavGrzsLMGhP8BKe
	 2GDknJjyyo7VmX5N2dgXvCSV/p/p1uJ82kyopFkoGEA6Nk3fiJyxibLDuIL9IUCJ9f
	 2sVq1g4pV46UqMiOz+ELKxGPowk7Wzss5zumVlF/Bgd7j66XbkxpEGPk1nMWiXJGko
	 bihHYtHyoBvlYgIIrW6Plh/ORKcl22+n+m7621Q25Hlla5uwl0dV4zezf9MFMRJezV
	 NbIoL63DJKA5y0GBmrlEEvxyPYPMbtyfmh6ExqivfrASTFxt/14M9CX5UML60SbL41
	 cSyUo0SslJ1tQ==
Message-ID: <a02f2713-1b8f-4a25-b5c8-ffbe427b682d@kernel.org>
Date: Fri, 8 Nov 2024 13:38:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 0/2] mptcp: fix a couple of races
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1731060874.git.pabeni@redhat.com>
 <4e134d6c-645c-4b2a-8f52-845c25e53de6@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4e134d6c-645c-4b2a-8f52-845c25e53de6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

(MPTCP ML only)

On 08/11/2024 13:35, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 08/11/2024 11:58, Paolo Abeni wrote:
>> The first patch addresses a division by zero issue reported by Eric,
>> the second one solves a similar issue found by code inspection while
>> investigating the former.
>>
>> Paolo Abeni (2):
>>   mptcp: error out earlier on disconnect
>>   mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
> 
> Thank you for the patches! This looks good to me and can be applied in
> 'net' directly.
FYI, I also applied these patches in our tree, fixes for -net:

New patches for t/upstream-net and t/upstream:
- b189b3050a9d: mptcp: error out earlier on disconnect
- 8f738a68cd74: mptcp: cope racing subflow creation in
mptcp_rcv_space_adjust
- Results: 3cb39141befa..3f011e8dae3c (export-net)
- Results: 2c114d530011..fe15020312c8 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/4ebfa44b9230463c69b57a0b2b0a91ec4b0ad10d/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/95e17c17557397eafcd64d7af7e7e2c8f9b01025/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

