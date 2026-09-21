Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEAF426438
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978731; cv=none; b=jiYb5+fk6HryL81UBqJNE1Y8DzRGi2AeOfhwYnyNWqqTLs6zEEZDtMnRitdNLysb+oMpTYixjkzZhRSfcSwcn6PrTxppzUqTb799GzD/rp87seRMOyaZch6nnv9Ge5vuP6fw9GVq8AqqVRKQPalvXBgyeAtss8M4LfgMUEypIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978731; c=relaxed/simple;
	bh=J5K5GQ+tFClf0ej2o0U8v71S1+XK05ZOyzWKmphX9hA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8CGQ10mgD6gou9ZMdSqnK8mWdzj5hDsuZ7jeOqh3SDyRdXNxoqNLBtNWiVhiqN3c8gPqiSB8bxIOqgzy0I2eR9iRjhGu2uDKzji1JSUf77MyRf8ymjXfh3dNzHo2hw5GdSwjnc9Cp78tY4z4Sk2+q8q8YlpzUWlEMUr+QRQ474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP7sl2D7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP7sl2D7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9F41F000FF
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789978729;
	bh=eeSRAFSRZhNwzs09xXy40X63Q4ZXRtXiGTEYYT3D364=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=AP7sl2D70lrYnEkBwNdfxisi4kLHbwS2vtl0VRp9FLQWZuc0rXMWsMwgGs/7IHrBe
	 trsYpk3+lPU2xfX5Lf9mLmxR2H8iJLPPcyd3rmHAr9gTexNDys4ReTtdnWtBjwvISg
	 m8zt0yr5Rrfpakp3bJWuoxBhIlWVlI5zAvyrIaC3YdcniUF5zJOCsCKUqv1UiitLjU
	 GJUIH8O6llF5tn2u+xihW8nKGtNTDjcPPPFcEcpaOSL3KnCqasWHsYx3y4gCHPGCcY
	 8I0ZcO7rVQA6yrn9jlMO2lsYLzCRiOpcr4f18WtDUCdU6rWncJFUzYSmCcLYFkI48Y
	 ORKdGNEKI+GFg==
Message-ID: <0c8156634d1ee0eabbff75bda807e537efd0725e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 0/6] Fix socket options used by NVMe over
 MPTCP
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Date: Mon, 21 Sep 2026 16:18:46 +0800
In-Reply-To: <4a4ce805c08bf5a8c2f34e0fa371b81317af795e.camel@kernel.org>
References: <cover.1786938892.git.tanggeliang@kylinos.cn>
		 <cddcbdb5-b4ab-b99f-54ae-ee6cf8fd8cc5@gmail.com>
	 <4a4ce805c08bf5a8c2f34e0fa371b81317af795e.camel@kernel.org>
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

On Tue, 2026-08-18 at 16:23 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2026-08-17 at 05:11 +0000, MPTCP CI wrote:
> > Hi Geliang,
> > 
> > Thank you for your modifications, that's great!
> > 
> > Our CI did some validations and here is its report:
> > 
> > - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
> > - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> > - KVM Validation: debug (except selftest_mptcp_join): Success! ✅
> > - KVM Validation: debug (only selftest_mptcp_join): Success! ✅
> > - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> > - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> 
> Sashiko has already reviewed this v6 and has no further comments. If
> you have time, could you please take a look and review it as well?

If you have some time, I'd really appreciate it if you could help
review this series, particularly patches 5 and 6. The subsequent series
"nvme-tcp: add IPv6 traffic class support" depends on the
__ip6_sock_set_tclass() implementation in patch 5. Patch 5 was
originally submitted by David, and I've made some updates on top of his
version. It addresses issue #568 and is worth merging.

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1786947923.git.tanggeliang@kylinos.cn/

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> > - Task:
> > https://github.com/multipath-tcp/mptcp_net-next/actions/runs/31994206151
> > 
> > Initiator: Patchew Applier
> > Commits:
> > https://github.com/multipath-tcp/mptcp_net-next/commits/f3f2396df333
> > Patchwork:
> > https://patchwork.kernel.org/project/mptcp/list/?series=1146924
> > 
> > 
> > If there are some issues, you can reproduce them using the same
> > environment as
> > the one used by the CI thanks to a docker image, e.g.:
> > 
> >     $ cd [kernel source code]
> >     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --
> > rm
> > -it \
> >         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
> >         auto-normal
> > 
> > For more details:
> > 
> >     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> > 
> > 
> > Please note that despite all the efforts that have been already
> > done
> > to have a
> > stable tests suite when executed on a public CI like here, it is
> > possible some
> > reported issues are not due to your modifications. Still, do not
> > hesitate to
> > help us improve that ;-)
> > 
> > Cheers,
> > MPTCP GH Action bot
> > Bot operated by Matthieu Baerts (NGI0 Core)
