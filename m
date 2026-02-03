Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA191E5724
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100028; cv=none; b=nENd+DEzq1N8+b94lXoG5t0UUPhWigWn5ec3c023NZEQ6bRvdtIpkJrJ+H6DqX5OuaYht4vkQ8nYyJPvHkQspk8yy4Mv3uCnI0J4e+n5bS6JF35lgTLxKOOUE0IygN7rR5z+iHd+F0UkLZR+gkHrpJh6ZG1N9tIf4/zGkcmtYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100028; c=relaxed/simple;
	bh=gqbbrScttRv4ZBRc/H/IYaO9jRfKz7BIRQn8Okuj7VU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqawLgvOsMMFuJPTWUEGy4b95f0Ihoo/YRY+e9BgCgJ+S/xU8fHEgIDGKj99ahXET0NjYuhadOGIA5EkbNvpSXCMWMxdVrULAFjF+ufcchIHsRoAhq10vLFIdYGDOhE0o0ZaIgwQbT5ZXlT35zB33vhn1VeTpY3qd4y5Y6AlifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSISKc2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSISKc2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31726C116D0;
	Tue,  3 Feb 2026 06:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770100028;
	bh=gqbbrScttRv4ZBRc/H/IYaO9jRfKz7BIRQn8Okuj7VU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=LSISKc2OzLrhp6c0JVV3zw0AMuPMOkWsSP2qmqXcU+t6TlaMFH59gbFWtT6QqjjbL
	 EfUi2nWS7IWfiHlM62iCMMSvqPPapSYqjUgqTXu3qgdDCVIPbkl4ur+WqK+v9fDBrY
	 t8pNXb7dVLiwQkH5yPE6D6BidogLZQa8/sn9eF18jYJEbcoNUlJT72egNg/XZrY0It
	 BwP/dwgIF7L6DCxT8uNq/Wp0cdwGAMj1GG+7BALX7GPVneHrvjxS1A6No7/6+N/0CV
	 Cs0XXIazcTIg1EuvSet7YAQAFU2QUtIonqYrT64/uQssUHWFwc9H3K5K+ISKt9h4Aj
	 6XhI44PXCzmyA==
Message-ID: <40996f0d035da6570fd37b5515ce4e2e23543b2c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: connect: trigger
 splice_eof
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 03 Feb 2026 14:26:08 +0800
In-Reply-To: <09050e23-1292-4d3c-8056-b23ffbbef0b4@kernel.org>
References: <cover.1770023932.git.tanggeliang@kylinos.cn>
	 <467dfcbcd3e11849c507db5360c3a394c3d117a5.1770023932.git.tanggeliang@kylinos.cn>
	 <09050e23-1292-4d3c-8056-b23ffbbef0b4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Mon, 2026-02-02 at 11:09 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 02/02/2026 10:21, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Increase the sendfile count by one to ensure the transmission size
> > exceeds the actual data length. This triggers the splice_eof path
> > in the kernel, allowing the newly implemented MPTCP splice_eof
> > interface to be exercised during testing.
> > 
> > The change from 'count' to 'count + 1' forces the sendfile
> > operation
> > to attempt sending one more byte than available, which activates
> > the
> > end-of-file handling in the splicing logic and ensures coverage of
> > the related MPTCP code paths.
> 
> I'm a bit confused: is this splice_eof interface not linked to
> "splice"?
> Why is it used with sendfile()?

.splice_eof hook is indeed triggered by sendfile(), not by splice().

sendfile -> do_sendfile -> do_splice_direct -> do_splice_direct_actor
-> splice_direct_to_actor -> do_splice_eof.

> 
> Also, what's the behaviour without the implementation of
> "splice_eof()"?
> Was it a wrong behaviour or is it the same? What's the differences
> between the situation before and after this series?

Without 'splice_eof', it was no a wrong behaviour, but MPTCP didn't
previously handle the splice EOF notification. TCP handled it.

> 
> Cheers,
> Matt
