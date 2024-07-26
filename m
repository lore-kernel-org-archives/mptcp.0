Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C4176240
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990005; cv=none; b=PbT9gyZFoy3wGWDgf7/n/aajK/aTlAYUR9zFmQkgi2l4mva4TQ4huTjELsM4q1q/XLTmazH3UorFsIzG7bmIc4eUEzLkpzdInVTfx5dXP3alL0oYLCn28BqCxZV/sgONEThYB6Ahmedvnb0c07zjpwwLH51oBBpz2W2Gzg3vw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990005; c=relaxed/simple;
	bh=LF0k9SW/vi87sqBGsfeCgwArdoRM6kIP5C4BoFv2qtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrymM2dj9zfdsCIsI4lMuDEH55BAD7Nghw1eFMS8I/Qj6hGycu86UwizLJToaP/BplJOVj6hes9WWETCnzE7tbO17QzxGk5MoFLDLt8uX9YCyeGkUGYPq4CXNCxw5dGf79hO8kVg1PiTVaoifd/TnZ9/Cve8TId0O/k5/+6SMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ5akwWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ5akwWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE3DC32782;
	Fri, 26 Jul 2024 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721990004;
	bh=LF0k9SW/vi87sqBGsfeCgwArdoRM6kIP5C4BoFv2qtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NJ5akwWv+kx35KZ89h6ImAkI8xjv89kbrJhprqTBvF+PakQhFSehfj83cIRqBvySE
	 pU2AHD91arsi+vsXBC1Wx8xYbvrMza2fYxzDTTEI8N9Ru59i54RneW93QFSDXLNE0y
	 xOZcNbown247BanXoX/gYp0XecIyfdEcBfXCiNq9AQYCAe7ytmsOkp3+wS0RoH2Ach
	 UYswFi45gH5kkoy8F7XDcpRixHELeiHJoAYStOROM450nNuYgOEs/mDTOmirpx1z3n
	 3ub5XqYdyQudRugUbCVA4SrX0ZNpOvjI3r3vOKf1IJDdMSwRMQIKWS8BC+/NXdlob0
	 IL8Pb8QAUwrJA==
Message-ID: <018a25b6-46ec-4ac4-93f9-d932b445db14@kernel.org>
Date: Fri, 26 Jul 2024 12:33:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix duplicate data handling
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <51cd83cb7690d756e9a71797b133bdd9f286de76.1721921695.git.pabeni@redhat.com>
 <1ca08110195a81b95a38449f1a12b5593dfad864.1721921695.git.pabeni@redhat.com>
 <415224da-e982-2d69-d1de-f234abdc09fb@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <415224da-e982-2d69-d1de-f234abdc09fb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 26/07/2024 02:42, Mat Martineau wrote:
> On Thu, 25 Jul 2024, Paolo Abeni wrote:
> 
>> When a subflow receives and discards duplicate data, the mptcp
>> stack assumes that the consumed offset inside the current skb is
>> zero.
>>
>> With multiple subflows receiving data simultaneously such assertion
>> does not held true. As a result the subflow-level copied_seq will
>> be incorrectly increased and later on the same subflow will observe
>> a bad mapping, leading to subflow reset.

Thank you for the patches and the reviews!

>> Address the issue tacking in account the skb consumed offset in
> 
> Just one fix but Matthieu can adjust: "Address the issue taking into
> account..."

Just did, thanks!

Now in our tree (fixes for -net)

New patches for t/upstream-net and t/upstream:
- 6d60c2cf352d: mptcp: fix bad RCVPRUNED mib accounting
- 2e6def94f212: mptcp: fix duplicate data handling
- Results: a1f9b538328a..0e547869a341 (export-net)
- Results: 8149d851361f..9a749f3dd928 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/865fc5f5109629347844c647fa71a50484d02dec/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/166ef45101617d160bacd4c3330e32f8f71fcf17/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

