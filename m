Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07287477280
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254104; cv=none; b=Spyab2U3O5HmP/S/NTkTuZZW9GSJxIEBRqHa1XVKmY6rSpHsPL56ctbv2P7wPwdIiquCgpcQ+QlaG6wO8LPZua2GQB5og3IMQSop1OuXPP62rKiAxJSfdHJ/mwCzs7KyV1BY9qIF+8wglx3GCj0OU6or1S7v+DG2Tj7pslVaxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254104; c=relaxed/simple;
	bh=Ri1POuUbcg+s869+I6CPHsSEaIPZyn8k05AjAvQDpRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/iPxBl01fuLbNtu2jtZ5OfD2aZersylp+Spt9L5czCc8GYi8l3EHc7cUYriT/7kmKj+FtqPxCyTC8YFIDtoCIJjF9YEnt2dWBIeYzPGPI0NOYi7ssW+oZXEdeRF/7hQbTsITjCURUcESnNP4SENikzTqzJTfAWEFtZjU5zBE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkKE+THH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkKE+THH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B371F000E9;
	Tue,  1 Sep 2026 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788254102;
	bh=OtDUewMdqSA8eKr/760rrG9gS/axYNndN1cZt2sBEPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EkKE+THH429YM3sxYVGpnYxTOEQkO7W+erQ+GG+x3seXa3fkVXaD4YfvApv6VxdCK
	 mTM6E/alN3sZ653gV4HEvMU8O4T0LwAERGSCF9Xv6mJz9J+5/bLkdpwtARSnRF8AJD
	 Boh4RiqmoPTIW7FGfSd5bH3Ydp8fMwg7yOmwQ55sTVhYEQrEikWzpvCwoHEmdQAW5t
	 YaOC2dLIpA0oEQ47nCWQ2iUkXaNi5LxA3VWLD3JFgVZ9q+inWzJIHQmbZSN7BBJiFj
	 8zEFIXBHzvrJe97hw5tKK5iTz308oqoCZKyowPQjC9yNLAqiF5Ub9yfyyowT2hdUQf
	 YTKScbJRrYRHg==
Message-ID: <5ef1211400852547350e78a70f17a97abcd9ff50.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v13 00/10] Reduce the differences between TCP
 and MPTCP for TLS usage
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Tue, 01 Sep 2026 17:14:59 +0800
In-Reply-To: <31b60fae-bc75-6b41-cdf2-2fb3689f1572@gmail.com>
References: <cover.1788245079.git.tanggeliang@kylinos.cn>
	 <31b60fae-bc75-6b41-cdf2-2fb3689f1572@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo, Matt,

On Tue, 2026-09-01 at 08:07 +0000, MPTCP CI wrote:
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

Sashiko has no further review comments on this series. All CI checks
have also passed. This series is now ready for review.

Thanks,
-Geliang

> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/33479921638
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/02653ba3cbf7
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1155065
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
