Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ABE2577B
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337194; cv=none; b=TDA5i/ZfYEdSzmoruN6GQtYw6yTsydxIIKqZ7MWDiK9vDGIam2fqGNyprgzbpivLD12KOW7klvDz8kDuOUomD0QmNF6hWoGBFjP4co8yQl077mgVEr4nDAT+jRPncWgafz86psY+NX4wo6WHIShL0QhBV6prtUnP0thGfyDr2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337194; c=relaxed/simple;
	bh=TyN1AgynIJuyDiKh3aWesQ7flsNNJtbK+mDJsH+FXkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb7oGqlb3B02KUQ0dKAVc+4Cmu0w48K8gFFyjOVvs8XZ7GIeAn3OCrUBUgqCIdKpvZEt4aqiLQ8UXeOxfjhlbW/POxXPB3rFK6DwskZt8J+xil6NghlNA3Ng6xyxXjJeuVQhtrjv8PKTNDooUVbUV/RdQEp1t/HYr4nizoR2cx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqhsIspF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqhsIspF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E51FC433F1;
	Mon, 19 Feb 2024 10:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708337194;
	bh=TyN1AgynIJuyDiKh3aWesQ7flsNNJtbK+mDJsH+FXkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IqhsIspFZ2hDESbH65EnQldcaM+fkSaOQOFsi04b5cCg8Q+XZoI2nRK3fPfW673Ip
	 NadofREVMab71x0fRvwb0YUGodt1e+JhTuDQBoEy1OmMgWypSietoVzOVyNVNRB7p0
	 oWcUtjpz/YBMvBDFeIaG04+GP9C6AesFb2xyHOSCEKS9/vGmKxHIdFg7/dUI1P75qe
	 +kR09tHurkwjcgJ0a1P1EYf4f0UnLvRE5gzlL9m8fwfLbC26ZAII0vHyaQyNSP1WNV
	 16dofCJz/b7PMkZKACOnte6hX3WKUT6KBqWdxSRf+hGNbhlzjCjS4NFGPd/MOEMTWG
	 4NUjQGyOhqCAQ==
Message-ID: <c8adeaa3-5186-41f3-b26a-b6b515ad0863@kernel.org>
Date: Mon, 19 Feb 2024 11:06:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
 coverage for CI"
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org>
 <5a19039b-9281-eaa3-f546-e189b2d6022a@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5a19039b-9281-eaa3-f546-e189b2d6022a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 16/02/2024 21:21, Mat Martineau wrote:
> On Fri, 16 Feb 2024, Matthieu Baerts (NGI0) wrote:
> 
>> As discussed on [1], an additional check is done to catch local software
>> bug.
>>
>> This patch is supposed to land only in our tree, for both 'export' and
>> 'export-net' branches, because the warning could be triggered by bugged/
>> malicious peer. We want it in our tree for our CI to detect internal
>> bugs.
>>
>> Link:
>> https://lore.kernel.org/all/20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org/ [1]
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Looks good to squash.

Thank you for the review!

> Would be good to keep some of the above info in
> the post-squash commit message for context (especially the lore link).

Yes, good point, I will update the '.topmsg' file.

> One other thing, I noticed that this is mentioned in the "DO-NOT-MERGE:
> mptcp: improve code coverage for CI" commit message:
> 
> """
>     mptcp: use kmalloc on kasan build
> 
>       Helps detection UaF, which apparently kasan misses with kmem_cache
>       allocator.
> 
>       We also need to always set the SOCK_RCU_FREE flag, to preserved the
>       current code leveraging SLAB_TYPESAFE_BY_RCU. This latter change will
>       make unreachable some existing errors path, but I don't see other
>       options.
> 
> """
> 
> But it looks like the code for that disappeared between
> export/20230405T131056 and export/20230405T132954 (also missing on
> export-net). I didn't find mention of this in the mailing list. A topgit
> glitch?

Oops, I forgot to update the commit message back then. Here is the
modification I did in TopGit:


$ git log --first-parent --no-merges $(./.tg-get-topic.sh "DO-NOT-MERGE:
mptcp: improve code coverage for CI") -2

(...) # (the first commit was an update of my email address)

commit 0fd1a78a8c4d99054a1b47626d45df7f5d36e2ec
Author: Matthieu Baerts <matttbe@kernel.org>
Date:   Wed Apr 5 15:23:56 2023 +0200

    Revert "DO-NOT-MERGE: mptcp: use kmalloc on kasan build"

    This reverts commit 4edee9adfa20120c18e41c26e2ca0a97ead0d93f.

    This piece of code was causing issues, see:


https://github.com/multipath-tcp/mptcp_net-next/issues/371#issuecomment-1496226126

    It sounds safer to revert it then.

    Suggested-by: Paolo Abeni <pabeni@redhat.com>
    Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>


I can fix that!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
