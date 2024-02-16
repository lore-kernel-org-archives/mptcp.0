Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAD535C0
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080668; cv=none; b=P0jdDfQkN+Odnj2TccLtXQMjahMpxH+ntaogxOvg/JLCiMi49A5RkFCaxfw0jTOAyMHXGugpfhLhpgzyMtngHFOStLypJisi+65nExZpP5pWFYtaS1fJ8YeM4C4Q8ifoqnGTt+8QNkdFC6cKBxHFHEW5sVUbEZFmHgKoJzu6xYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080668; c=relaxed/simple;
	bh=N5GhfUuJM+rV9KxGopcFNgAGqnFDPzbXmRFRBkKmfYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ta3sGE+lRfkftq0lt6HZqXSsxjFXrTMK0pPtruLZZJfi9DA7foev6Iouy8Br6yY8hBUd7dnP8I6X2eLuzC4pDvuY+kqb3dXBvaLmmQxq4DlJT7HJ9Klh92L0Nrp1rfwkW5UgdaD4kcUmF4ndpvJIQSYvt9TMfaxnzBiggnenS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYbiJ92D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYbiJ92D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B9FC433F1;
	Fri, 16 Feb 2024 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708080668;
	bh=N5GhfUuJM+rV9KxGopcFNgAGqnFDPzbXmRFRBkKmfYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bYbiJ92Di3N7sBs48cHUqzOvL1S+qLdvw94GC4vGYF4Z6MzV7IRnwTCXAwWsBNFxW
	 HL6pAUGsQwGCW8pzGp2RTB5JIKm22cVmQ4haW7Y9ERyG00vnFAhDPJXXpHd81t2cXZ
	 2oszBrnZU770iMNISaVrSWYgd0+EDW5G5AiogLcsyKLgtDii1NczXAZpYT57ldOKbU
	 qqAr4Ey6O6+0Qz09OdsGEWO/p2ZuHu2LXDdDjy3/RJGUfKypN6NC53YSD+17gG9DYZ
	 w2Ej+DB8JwZE/mZbRgFdZ/lXHJX/Xmdxcc8Di2sLUPCheLPrmcn1nyUbNQbpHJGlNe
	 Y3+dmafjF0kuw==
Message-ID: <52cd0993-f76f-4bf3-9c47-4cfabeb4e408@kernel.org>
Date: Fri, 16 Feb 2024 11:51:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v4 0/3] mptcp: check the protocol with
 DEBUG_NET
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
 <fc259bf3-2ebd-120d-fed3-8c5b35ad2e54@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fc259bf3-2ebd-120d-fed3-8c5b35ad2e54@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 16/02/2024 00:01, Mat Martineau wrote:
> On Thu, 15 Feb 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Recently, Paolo fixed a bug where a TCP-specific helper was used with an
>> MPTCP socket [1]. The bug was not detected by fuzzer or static analysis.
>>
>> Following this, it has been suggested to add a check, only in debug
>> mode. This is what this series is doing.
>>
>> The series has been split to be upstreamed: a preparation patch for
>> MPTCP, the modification for TCP, then for MPTCP. It is not clear if it
>> would be OK to add that upstream. If not, we can squash these three
>> patches in "DO-NOT-MERGE: mptcp: improve code coverage for CI" commit we
>> have in our export tree.
>>
>> Note that the MPTCP Token kUnit test needs to be adapted for this new
>> check. This is what is done in patch 1/3.
>>
>> Link:
>> https://lore.kernel.org/mptcp/35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com/ [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v4:
>> - Patch 2 and 3 have been modified, please the changelog on each patch
>> - Link to v3:
>> https://lore.kernel.org/r/20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org
> 
> Thanks Matthieu, v4 LGTM:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree:

New patches for t/upstream:
- c3442c02434d: mptcp: token kunit: set protocol
- 63ecd0ec9a16: mptcp: check the protocol in tcp_sk() with DEBUG_NET
- 6b84a8f44c8a: mptcp: check the protocol in mptcp_sk() with DEBUG_NET
- Results: 0b8245446c36..27e2360c238b (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240216T104727

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
