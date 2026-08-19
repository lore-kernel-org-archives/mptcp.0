Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582542F6E9
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131344; cv=none; b=GQF0A8NtBIhHTycoVFAi/3dLhovvswxsK8hC2/Fl7eVZuoNcqT67qN9ThqHACQefptfgDT38OuXJsATH8LC3U7Y9Cs2feLKyLQIFB7xINJxtJcx/zObVc+Pn9JtGjBqkoNz/1o64bg5DFQRIXyx1uAdVj8DwASZUZI9bgLUA4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131344; c=relaxed/simple;
	bh=X2w0OB7+WA7nKu1Nzk71vzaYv/pqYab7JkD4Iio01Js=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfCGf4Q0Yf8E7ms0WTaN7yQl1yd5DhNudJ/zhCC0nGFz1+rmSuBGy5rb8lcscBASZb7L8OPOEpoq9RUXvM2kHlJ9DQ8mW6Tag8GhBGZoqtl9usn6DDSJ/4fzbNlTHaU4we23Gtd4+6XNpfsxjYIH22CjpU2td8ZUhwH30F2owSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ+vBXsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ+vBXsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76741F000E9;
	Wed, 19 Aug 2026 09:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131337;
	bh=JK0sdNiHPbwqx3omGDfNamzGzwtMo7YmnZBLM0VoF/M=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=WZ+vBXspbWnnxkj/3SbHJOBeH2WOZ1Fctxf1HB2GI6LvCTlXgDVDdLiFFZI8gB4In
	 uLEaUhi+dAISfAPhj2+NGMXN2qzUNBKC4/cfPeJ4opCVpgz2luzajZF89fh3grJRGN
	 fXzs7eTS8a6gqfvjyCAROijvRFBhb7RK0r6LxvELeumSgH1S0FgNYOxBRNKt5/y2Iw
	 /M6+ZFUUKP2EbuWcVy/SFViYqFa5dM8Gnni4u+aIu1Hu7Hu22ic0hsoscaS02y6PD2
	 uSY9ARUsSV76vlhFMttZZZ2093iJqOWb/gzY2iFRcgK50hQAMMAf0K6CIpgIe8By8n
	 RBd6hxRQli+Ag==
Message-ID: <8e2f92a8918ee5cf7b1a7e86f5bcf64f38030c5d.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] selftests: mptcp: lib: get MIB counters
 for the right test
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>
Date: Wed, 19 Aug 2026 17:22:14 +0800
In-Reply-To: <58a6d0bd-e3b2-3258-593d-0e8c14844af1@gmail.com>
References: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
	 <58a6d0bd-e3b2-3258-593d-0e8c14844af1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2026-08-13 at 11:41 +0000, MPTCP CI wrote:
> Hi Matthieu,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (except selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (only selftest_mptcp_join): Success! ✅
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Success! ✅

This series looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/31693194883
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/1737d20f1a46
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1145356
> 
> 
> If there are some issues, you can reproduce them using the same
> environment as
> the one used by the CI thanks to a docker image, e.g.:
> 
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm
> -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
> 
> For more details:
> 
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Please note that despite all the efforts that have been already done
> to have a
> stable tests suite when executed on a public CI like here, it is
> possible some
> reported issues are not due to your modifications. Still, do not
> hesitate to
> help us improve that ;-)
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
