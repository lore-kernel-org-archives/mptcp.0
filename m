Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC12F83B5
	for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871793; cv=none; b=YEmekGQyKxgpDjFsG/qcq7LvZGDIt323KMdSy7e+uP1Ut3E8WucrgU3SpLI0JJxj4RwLqB3E0Vor2sOlcikqByEfFx+S85C/xRwV4JGXqA7oUgnGyYzENQLTnsdMA+UUustsTpnpzspUFczZw4TRd/SoVAYs3ernLKgwfRJ/EEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871793; c=relaxed/simple;
	bh=4Spu05fNpoVEVDu2sI1GtNaRuA4PQNoxK6PhFLtYJ40=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSyxRU14D6NDClKpi24tfwuJNaE6Pn/rbZaAPNyWDwoap+c2ECoAbSRnkHRpfLsweK0Dpt0zy9xjs383WB75En1qrOYgaeIv7+PwvTN+UH+wrd895vHsuKcloK1Mt3j52z7MW6Ugz5YRxOIUsXTG2aqjH/aFXGScd5VFC+cNhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwyQGSNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwyQGSNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B16B1F000E9;
	Sun, 16 Aug 2026 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786871791;
	bh=d7NEFauAn9p8qN9C8eDidwIMuDC7D3wZl5ic6Kyj+vQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=NwyQGSNAwP9UXRg2JNHFBUOG6GnWbjiSrpLySGbn7DG7HGrdkcq7emJn7EbeJpzeL
	 83QvGF57IuQR8grNlOrE1zFSZ75Q9uyDYe4crEnO2I8GTL++AT2bNo4OsGkcZg/e9q
	 72xjpokYn0bM7tO3pNLuC1mw8n6Ah6buQo3a8bOsRMwCSHMP83esgF8/Z2xS+N2YId
	 Qu9XbScjv1Y7YYAsbe404kbmN8NfpeDHyJkjFdZLeN8YLyFtXrGYFSWKA3VbAzchL+
	 jAAYgPDJdZsdrgFDGIc94l6+JC4YpL3r8b9VjnBVQoVK0qRpG8dr74lBjjRWrKR4QK
	 Mc4god7aMbntw==
Message-ID: <73f3308128089e62966a82b807fb872683a4a6f3.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/7] Reduce the differences between TCP
 and MPTCP for TLS usage
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 16 Aug 2026 17:16:29 +0800
In-Reply-To: <94bbd3cb-4ca8-1002-5456-81fcae695484@gmail.com>
References: <cover.1786445142.git.tanggeliang@kylinos.cn>
	 <94bbd3cb-4ca8-1002-5456-81fcae695484@gmail.com>
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

On Tue, 2026-08-11 at 14:43 +0000, MPTCP CI wrote:
> Hi Geliang,
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

I noticed that this patchset has not triggered a review from Sashiko.
Could you please help trigger it, or let me know if I need to resend
this series?

Thanks,
-Geliang

> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/31498591634
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/8f859f4196fb
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1144100
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
