Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C48322A
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148947; cv=none; b=SkUGzjirqMXb6yJNWuIokzNYtsHY7sWu51eg3mgb33lSl2VKYgCPoKyfp6qoJXYmHIzU0k+b7o8caPRf3EsTKFplKd5gfMI/lpHj98YCkxCuUJo+UZ1+mh4cqVovmhRWs1CwRkctc9wtlCRqwBctBSm+siFnSwP9FSCvBSdXNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148947; c=relaxed/simple;
	bh=Auh4W8DBIw8MWylaX4dpSeCVz3YRZtMDGx2HtJq1dis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdCHRP1v593pTJS4v7tP+0AAfcpM4I3Q3OR8Y6suCnU08ZdVr69J4F3ubSYkxzPTJwqcx1Se82d4lc3cS1DXwszU+2NOAPLFnyq2t9Yw05jM78bgh5jfwuMH6fQ5xyGg0jBgEpNJ5VrqRkZLeKdUV9USVh205aFKgGHY4GJLhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyPhUPnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyPhUPnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39BC1F000E9;
	Mon, 22 Jun 2026 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148945;
	bh=Reenm3To5BvZsOPpGyw7nzeXuqlPKnsMFiN89EIFCnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lyPhUPnDymEz+RpSA7fdFUIJ+HGPwh/IrXL+gjfADDUS/2+GqltXZdkvNfL2PaVOl
	 u6aJtHGoM97K7llx5xR8pDXm1ixHqF6QyE2PXzBw5qRM2DiJO5h7esjbhTbqc7AKwH
	 nzLUtnd+/RtcZYFRvgmI2Z36k7DAS5mctEM8g+rrPLJtf6g0i8OU1fRe/xiI+4QXNa
	 TiRGgp9m0DeLaGYSvLzDPWKX3J1qBkp1sHewioybklQ9m7eoTQMBoG/T2F1doHZCvM
	 YyR2dfyqJ7ASN+YfkJGTTLKTsT2TKlYxZC1mMXTEonpni5puCKNfDjXV7jtclPjhYx
	 1j97wdb2mJ02A==
Message-ID: <c2a423fe-6d4c-466e-8e24-194438c40d80@kernel.org>
Date: Mon, 22 Jun 2026 19:22:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4 2/2] selftests: mptcp: add regression test for
 stale ADD_ADDR on id 0 removal
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, pabeni@redhat.com, cuitao@kylinos.cn,
 syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
 shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com,
 shardulsb08@gmail.com
References: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
 <20260622092838.1267134-3-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260622092838.1267134-3-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 22/06/2026 11:28, Kalpan Jani wrote:
> Add a kselftest that reproduces the bug fixed in the previous patch:
> removing the id 0 endpoint while a pending ADD_ADDR echo is outstanding
> left a stale anno_list entry alive, and a subsequent PM reselection
> re-announced that address and tripped the WARN_ON_ONCE() in
> mptcp_pm_alloc_anno_list().
> 
> The sequence is deterministic:
>   1. Establish a fully-established MPTCP connection kept alive by a
>      bidirectional /dev/zero stream.
>   2. Signal 10.0.2.1 so the peer joins: the second subflow keeps the
>      connection alive across the id 0 removal.
>   3. Signal the MPC address 10.0.1.1: an anno_list entry is created.
>   4. Delete id 0 (10.0.1.1): on an unfixed kernel the stale entry
>      survives.
>   5. Signal 10.0.3.1 to force a PM reselection: on an unfixed kernel
>      this hits the stale entry and fires the WARN.

Thank you for having added a reproducer, but in general:

- We try to avoid new "main" tests for maintainability reasons.

- If possible, please prefer packetdrill [1] for the reproducers: that's
easier to read (shorter, focussed on the essential to reproducer an
issue), faster to execute, and easier to maintain. Please try to use it,
and do not hesitate to ask for help if needed. Mastering packetdrill is
really helpful in this area of the kernel.

- If not, please check if adding a subtest to an existing selftest is
not possible, e.g. mptcp_join.sh

- We try to avoid using "sleep": it is either waiting for a too long
time, or not enough depending on the kernel config and test environment.
Prefer waiting for an action instead, e.g. checking if a connection has
been established, the number of subflows, etc.

[1] https://github.com/multipath-tcp/packetdrill/

> The test counts WARNING: net/mptcp/pm lines in dmesg before and after
> the sequence and fails if new ones appear.

That's not needed, the executor (i.e. CIs) will monitor that.

A few more requests about this series, please:

- base your patches on top of the export branch (or "for-review" or
"t/upstream" branches), but not the "export-net" one: the CI will always
try to apply them on top of the "export" branch, and that's easier for
me when I have to resolve conflicts. (Note that the "export" branch
contains both "net-next" and "net", plus all patches applied in our tree.)

- ideally, avoid renaming the patches, or at least the cover-letter,
between versions, so it is easier for reviewers and bots to follow. Here
for example, you switched to one patch to multiple ones: it would be
easier if the cover-letter has same title as your previous single patch.
If renaming is required, please add a note in the patch/cover-letter.
Note that b4 automatically adds a link to the previous version, that's
also helpful.

- use "mptcp-ne(x)t" prefixes instead of "ne(x)t" when you send patches
only to the MPTCP ML (which is what we prefer).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

