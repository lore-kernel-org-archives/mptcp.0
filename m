Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561E1E1A05
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248537; cv=none; b=VJRjuVIClJZbHcg6o+/1R1tQ7l/6beaqjVhmhPeLY1YsowU1FjUuKuf86taWr9PRDDd2FBcb5xzBD9yjpY0GE/f3Vef3c+XtKEaU+hBeeTE+FncyZIYMmHrF2ltowDSvKMDPPuOjcAqL9s3IHd68Wvq1h0B+ypoucHWu9F29k3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248537; c=relaxed/simple;
	bh=riDy9TG9tnSmJSgPFdsPmKZopV3t4WoK0F0tnUkodUo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKRNqkLY5eIl+rgwFH9rjHEf3f2zqAbn/aZqL67tSEaD4dZ171ypUEA1s/qEE5KHH7gSmLUbNk4yHhJfqs7GpZj5qV/OFH9gKlnFV8lL4Fza6KG3zcoKaz7uhqv0Sb3UWQhzlHkxvX7OZoOndXX2jbxIGt5AwLIHYx556r4uLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBKdP/S6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBKdP/S6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A09C4CEE7;
	Fri, 19 Sep 2025 02:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758248536;
	bh=riDy9TG9tnSmJSgPFdsPmKZopV3t4WoK0F0tnUkodUo=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=LBKdP/S64r28NxWv8S+s/N4SWKqNCjOwBzWw2GpbqhKyQXx1kqj5eIGKqbNPyoTSV
	 hrBD34Qdl4+WFLcTZVHSS45Q+hEpHvKHm7MutgS9ohanzkDgvMnht6T1ixwC0n3Iho
	 j0p7WnMapplh/JAOk8lvVS0ocDhIpRp/4dAFZK2jMkBJr/f02hxfFatduRNCNVLCOH
	 uTzDQi3SU9GdprjNonqknYpCNed9kq+ZxqzRFu/Pgpy18l0mRALpj5FzOM3ANllzzJ
	 mzXTx1ekoNVG7AFgO14y1ESYq4ze9mVMal80AQcmNbYmU1j4JtrOObikS5X8SV5Jhq
	 SxEl5coqM7Euw==
Message-ID: <0387885e84d41f14cf23914c85d2191f1cdfdae9.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/12] mptcp: receive path improvement
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Date: Fri, 19 Sep 2025 10:22:13 +0800
In-Reply-To: <dd39e243-9ffe-86c0-9db7-6c108470b3b2@gmail.com>
References: <cover.1758214563.git.pabeni@redhat.com>
	 <dd39e243-9ffe-86c0-9db7-6c108470b3b2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Thu, 2025-09-18 at 20:33 +0000, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal: Unstable: 5 failed test(s):
> packetdrill_mp_capable selftest_mptcp_connect
> selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
> selftest_mptcp_connect_sendfile 🔴
> - KVM Validation: debug: Unstable: 5 failed test(s):
> packetdrill_mp_capable selftest_mptcp_connect
> selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
> selftest_mptcp_connect_sendfile 🔴
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17836736262

CI reports that this series breaks the mptcp_connect.sh test:

# INFO: disconnect
# 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration 
1348ms) [ OK ]
# 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       main_loop_s:
timed out
# (duration 61185ms) [FAIL] client exit code 124, server 2
# 
# netns ns1-HugJD9 (listener) socket stat for 20002:
# Netid State     Recv-Q Send-Q Local Address:Port  Peer Address:Port 
# tcp   TIME-WAIT 0      0           10.0.1.1:20002     10.0.1.1:47722
timer:(timewait,,0) ino:0 sk:2066
# ^I
# TcpActiveOpens                  2                  0.0
# TcpPassiveOpens                 2                  0.0

I also tested it on my end and found that starting from patch 8 "mptcp:
cleanup fallback data fin reception", the mptcp_connect.sh test has
been failing.

I apologize for not providing this feedback during the v1 review, but I
was too busy yesterday to complete the testing.

Thanks,
-Geliang

> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/20282b41a458
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1003937
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
