Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC02C21C5;
	Tue, 19 May 2026 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779164613; cv=none; b=Qvd41JmmZzdwO4DDGvepz+D7mwtkwpRqy50PLym/vcvJ6g483MqI0+dK1jAzeYp12eo4Aqnbo9uzyWvdChvGjKE0MBRlFzbhX5anduM/8MbSSQARUcC1xrxuyUDjZ1yahQzOwVSrCmG9wv5B42JcVg88YyO8NZhmrfyFnIJQLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779164613; c=relaxed/simple;
	bh=zVQMVDdBebHR2DV3/e9jsWNjtOfBbrWTZQ6qoswtPs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EK29GhbGw4CVa/4VhZs2DyEHWgzO1SNQwTq+vntXAJWHhqBrTIvCQ+f1RKgynm7o7LWGTlNRewJvyTJ9+rbgGvlw9Skamdrxn6DlT0rPPXpB4T+ymJROYJeiZE+mHbi63B4u3L3+IyJcr9qYbeUohTvEE00X6a8RTk96MFH874A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8ALYw88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8ALYw88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF472C2BCB3;
	Tue, 19 May 2026 04:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779164612;
	bh=zVQMVDdBebHR2DV3/e9jsWNjtOfBbrWTZQ6qoswtPs8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=K8ALYw88cdK4BhwaFdroAdqMzxDxdjah08K8BYBNKOaGmoKJRd7GAQkdvVPVUESA7
	 22lPTUv/N0UUSLsF7dXeBPzgysWupyUwFjapRg7z2I2U3UusYKLi059PsPK7/mHwf1
	 xYGHCRWln33QiQ4fUaAS/Rz0qtvSgEUGpMHqHbrwqB0Sh1lOXSRJ83GUMi02pl3slJ
	 7J/2s/AzFPz5okv4foBHBH7Es0LC2JGxH5lVB+TUZI5kWbIOhy9jBjmc9y8qS/+CY2
	 gtPOq5iR0bn2/P4HhXo+153HJlazt77kZlSuYuixZNRdgBplz+BbB1h9zHssCY84xL
	 eB91mAk8wYPlA==
Message-ID: <f7ef5f969170bfa77f73f7d280a699d0baeed169.camel@kernel.org>
Subject: Re: [PATCH v2] selftests: harness: fix pidfd leak in __wait_for_test
From: Geliang Tang <geliang@kernel.org>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>,  Shuah Khan <shuah@kernel.org>, Christian
 Brauner <brauner@kernel.org>, Matthieu Baerts	 <matttbe@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Date: Tue, 19 May 2026 12:23:26 +0800
In-Reply-To: <20260420121444-2eb5e0cc-a7fe-4199-9ac2-5bbc9eb421cb@linutronix.de>
References: 
	<a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn>
	 <20260420121444-2eb5e0cc-a7fe-4199-9ac2-5bbc9eb421cb@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 2026-04-20 at 12:15 +0200, Thomas Weißschuh wrote:
> On Mon, Apr 20, 2026 at 05:45:28PM +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Fix the pidfd leak in kselftest_harness.h's __wait_for_test() where
> > childfd = syscall(__NR_pidfd_open, t->pid, 0) is never closed.
> > 
> > Fixes: 73a3cde97677 ("selftests: harness: Implement test timeouts
> > through pidfd")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Would anyone be able to help me merge this patch, please? It's proven
effective, and it would also really help me move forward with
developing the MPTCP KTL selftests.

Thanks,
-Geliang

> 
> (...)
