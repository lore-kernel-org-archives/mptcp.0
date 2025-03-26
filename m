Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F8323D
	for <mptcp@lists.linux.dev>; Wed, 26 Mar 2025 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742951296; cv=none; b=jicRNJT1auPsdV1E5GD1Rfe7F4bIB73je7OTqf5iI9HA+z0S6rFlTl44xhgv+0Z/dFgj8Ce8x+JZTBac+Hu5AuX6591KzECCq3h+c01jmk9Uf8j2FaEJapXo6TFT5MpU3EUVLZZFfEo+/pzsOliX5RCr5eN4C5hI+0a93akdCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742951296; c=relaxed/simple;
	bh=kJbr/uWRW4qWhXvFJYYJcCbAW6/s8GjjQPfOlGXKdbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBxwCTOXBEKFd6y7FYSKq5cUMetgO30q6FJ+fRNB7tcU/Qr0fk4by5nmLAxaIrowNJwmBFCyWf9XFu8SihEn6Blzfn6/p4JELUaCpUICvwUBsPFCOgi6vfuF/mUiY0GBDzV8v+NPl9llGQ68paGTJx49D9IbxmCup3ydijlSd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZWWyrDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZWWyrDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13621C4CEE4;
	Wed, 26 Mar 2025 01:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742951295;
	bh=kJbr/uWRW4qWhXvFJYYJcCbAW6/s8GjjQPfOlGXKdbA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hZWWyrDiqPuk05KvEVsqJSv8sLj7+qbFxkCPhByd3JD7Fwx12HTBKd+x+Q2KfUrGL
	 DOAFp50wAvUFUOejS/AM5w7jI5Xy4mScr3HqT3a18JlCtFudJLfre5tWUES7cBZ1tN
	 ryiNKCwbGK7VpSirLmXViVqxVLuUGtIXRga7AfyBdDkZW3DRLuNB8pmRcacAeYk2/D
	 xBU9Xo8qqxIcjSeWoa6hianLBMvzFGrHZqXdisS57+Zce7xeyqCLS7JOwSgAE6h7O0
	 EQtkW5WbVdGusQ+EO2zgHpnjcQQELrpLMRN3XqaYf8U4nhvSJvYYHWcC3vi6jytQKq
	 9lQUJDxD+UDhg==
Message-ID: <a68756790c7f4a698dfea5e5b5adb3531fdd2a96.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v1] mptcp: fix cast type of
 is_fully_established
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 26 Mar 2025 09:08:11 +0800
In-Reply-To: <90ea00cb-d57e-411e-9108-624aad2194b9@kernel.org>
References: 
	<27b15c2de6fe36088ef95c4823d9e4a6d7bc9ec6.1742898970.git.tanggeliang@kylinos.cn>
	 <90ea00cb-d57e-411e-9108-624aad2194b9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

Thanks for the review.

On Tue, 2025-03-25 at 11:49 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 25/03/2025 11:36, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The parameter type of mptcp_is_fully_established() is 'struct sock
> > *',
> > not 'void *', so this patch casts 'msk' as 'struct sock *' instead
> > of
> > 'void *' in mptcp_can_accept_new_subflow().
> 
> Indeed, but it is not really wrong to use 'void *'. Also, it looks
> like
> we are doing that in most other files from the net/mptcp directory.

I just checked, and there're indeed 6 other places that use '(void
*)msk' too, but more places (98) use '(struct sock *)msk'.

$ grep -r "(void \*)msk" net/mptcp/ | wc -l
7
$ grep -r "(struct sock \*)msk" net/mptcp/ | wc -l
98

I'm wondering if we should change all 7 '(void *)msk' to '(struct sock
*)msk' in v2 to be consistent.

> 
> If you have to modify this line for another commit, feel free to
> include
> the modification in this commit if it bothers you ("While at it, use
> the
> proper cast instead of the generic 'void *'"), but it can also be
> left
> unchanged I think.

Or simply drop this patch. Both are OK to me.

Thanks,
-Geliang

> 
> Cheers,
> Matt

