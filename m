Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7BEEBB
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762236395; cv=none; b=lAFSyDxeqiEy7TBCbt/7lB8SYmxJUTIilnbauorWzfwJ1PsUHswJZENyQ6cZoapYu9BaZYJFKCXW9/UCNmoHvpPL364enJQ/7z60TrRP/4IB6LS9D/nwbKK6B02NDfJIwi1k6aH6boiWodCgsRb/RIMnFBYKpIsqjATyXziYJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762236395; c=relaxed/simple;
	bh=IsNmOokQnSwvcJwCO7wNSt5v5jbQIrKTnz+et6J/p7U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HfHKHS7NALEpzMcIeNoZ/9APZ+LP9Gj17eABvxNffFLt0XmjzVNaJJ5Ww+VUpztZqKL7JHv/QsBUtpVxYJDgjuaVBBYxQH/SXj8Ok8/VTojmUMR9XuoiCRwrGjg69niGib6qikpXgVPMqAvNEV90bUnlS0eXHEYcTn6dSIQDRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1gfVdFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1gfVdFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920F1C4CEF8;
	Tue,  4 Nov 2025 06:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762236394;
	bh=IsNmOokQnSwvcJwCO7wNSt5v5jbQIrKTnz+et6J/p7U=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=C1gfVdFnee1hvEVx+vgfbkX6+HFgZQRuR7Ne+RsTUUn8peiXy/bQyypX5ptQO69MA
	 156AKC5E6z3xksmoJRvcce88qDyVrrklcsqP3JaVmknnBw2BSL+lCyy4Atq2ya1rDD
	 Cj7MCIwaeygAywyh8JkW6nUGjmnz8HzzB9oJPBDfAuJvTekfBRFOLdI8PF7vl+5aWc
	 T/TzMPb3KpidW/eIegmGL2nc1NMBiYQ0+sfrQ7+WLx9t/agv91ogQg6BSfPv3u1ZHD
	 TIW4UJw4Hr7Z3gStleY0cktzc5m0qEc958tx5qU2Rq9UIamGzMHx/PwKA6zKNijkxA
	 Kdu+5oVM51W9Q==
Message-ID: <1d91f6b378b430088d81c2a5a1d33c678fc81cac.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/6] selftests: mptcp: join: rm: set backup
 flag
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 04 Nov 2025 14:06:30 +0800
In-Reply-To: <20251102-slft-join-inst-v2-2-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
	 <20251102-slft-join-inst-v2-2-b4f3ba15a7c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this fix. It works indeed.

On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
> Some of these 'remove' tests rarely fail because a subflow has been

In my testing, only the "flush addresses" test case fails
intermittently. I'm wondering which other test cases have failed in
your environment?

I'm thinking we shouldn't add the "backup" flag to every test in
remove_tests, but only to the specific ones that are actually failing.

Similarly for patches 3 and 4, we don't need to add "test_linkfail=128"
to every test. We should only apply it to the specific ones that are
actually failing.

WDYT?

Thanks,
-Geliang

> reset instead of cleanly removed. This can happen when one extra
> subflow
> which has never carried data is being closed (FIN) on one side, while
> the other is sending data for the first time.
> 
> To avoid such subflows to be used right at the end, the backup flag
> has
> been added. With that, data will be only carried on the initial
> subflow.
> 
> Fixes: d2c4333a801c ("selftests: mptcp: add testcases for removing
> addrs")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 54 ++++++++++++---
> ----------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e0cdb9c662aa..399805812197 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2552,7 +2552,7 @@ remove_tests()
>  	if reset "remove single subflow"; then
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_set_limits $ns2 0 1
> -		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags
> subflow,backup
>  		addr_nr_ns2=-1 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 1
> @@ -2565,8 +2565,8 @@ remove_tests()
>  	if reset "remove multiple subflows"; then
>  		pm_nl_set_limits $ns1 0 2
>  		pm_nl_set_limits $ns2 0 2
> -		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags
> subflow,backup
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags
> subflow,backup
>  		addr_nr_ns2=-2 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 2 2 2
> @@ -2577,7 +2577,7 @@ remove_tests()
>  	# single address, remove
>  	if reset "remove single address"; then
>  		pm_nl_set_limits $ns1 0 1
> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
>  		pm_nl_set_limits $ns2 1 1
>  		addr_nr_ns1=-1 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> @@ -2590,9 +2590,9 @@ remove_tests()
>  	# subflow and signal, remove
>  	if reset "remove subflow and signal"; then
>  		pm_nl_set_limits $ns1 0 2
> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
>  		pm_nl_set_limits $ns2 1 2
> -		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags
> subflow,backup
>  		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 2 2 2
> @@ -2604,10 +2604,10 @@ remove_tests()
>  	# subflows and signal, remove
>  	if reset "remove subflows and signal"; then
>  		pm_nl_set_limits $ns1 0 3
> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
>  		pm_nl_set_limits $ns2 1 3
> -		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags
> subflow,backup
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags
> subflow,backup
>  		addr_nr_ns1=-1 addr_nr_ns2=-2 speed=10 \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 3 3 3
> @@ -2619,9 +2619,9 @@ remove_tests()
>  	# addresses remove
>  	if reset "remove addresses"; then
>  		pm_nl_set_limits $ns1 3 3
> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
> -		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
> id 250
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
> +		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal,backup
>  		pm_nl_set_limits $ns2 3 3
>  		addr_nr_ns1=-3 speed=10 \
>  			run_tests $ns1 $ns2 10.0.1.1
> @@ -2634,10 +2634,10 @@ remove_tests()
>  	# invalid addresses remove
>  	if reset "remove invalid addresses"; then
>  		pm_nl_set_limits $ns1 3 3
> -		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.12.1 flags
> signal,backup
>  		# broadcast IP: no packet for this address will be
> received on ns1
> -		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
> -		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns1 224.0.0.1 flags
> signal,backup
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
>  		pm_nl_set_limits $ns2 2 2
>  		addr_nr_ns1=-3 speed=10 \
>  			run_tests $ns1 $ns2 10.0.1.1
> @@ -2651,10 +2651,10 @@ remove_tests()
>  	# subflows and signal, flush
>  	if reset "flush subflows and signal"; then
>  		pm_nl_set_limits $ns1 0 3
> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
>  		pm_nl_set_limits $ns2 1 3
> -		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags
> subflow,backup
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags
> subflow,backup
>  		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 3 3 3
> @@ -2667,9 +2667,9 @@ remove_tests()
>  	if reset "flush subflows"; then
>  		pm_nl_set_limits $ns1 3 3
>  		pm_nl_set_limits $ns2 3 3
> -		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id
> 150
> -		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags
> subflow,backup id 150
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags
> subflow,backup
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags
> subflow,backup
>  		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 3 3 3
> @@ -2686,9 +2686,9 @@ remove_tests()
>  	# addresses flush
>  	if reset "flush addresses"; then
>  		pm_nl_set_limits $ns1 3 3
> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
> -		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
> id 250
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
> +		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal,backup
>  		pm_nl_set_limits $ns2 3 3
>  		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> @@ -2701,9 +2701,9 @@ remove_tests()
>  	# invalid addresses flush
>  	if reset "flush invalid addresses"; then
>  		pm_nl_set_limits $ns1 3 3
> -		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> -		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.12.1 flags
> signal,backup
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
> +		pm_nl_add_endpoint $ns1 10.0.14.1 flags
> signal,backup
>  		pm_nl_set_limits $ns2 3 3
>  		addr_nr_ns1=-8 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> 

