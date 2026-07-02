Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A6386C12
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973434; cv=none; b=qEJmgvGZhqV9DC/I5O4OBMp3/q6vcqayhYYkg9SOPUqykmN7eyEpXg2raJYJL3XY+gNZGwizWdVCIcTwGKbNRGHMH+T1CukmEwRU7vRbj4TrAkEFSEs7wNIEvKGA2+LmttrgcEAWEM1k2bQ3py3NBKOYqRaQGDOKDuwHTJ1J+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973434; c=relaxed/simple;
	bh=Cu1P8FC1KfSdN5JOXbua45ot5lTwqX0lgWOB89cUTNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQRqYEkHfhs6+dw3Z946tV7WSu3psX0UAvtfCpd75OII4KxRtyshpeUY1DBGTbUMoqnV3hXjtuN3xrROhrbAjsK+80FXpAbwtJSNgDdH09bBV2S8LN8U9BqdiI+TBnQcFItQ8CFSyEv/86uCK8irD5n8G2vNpmqAELt6Eh6TMuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN9nP0Un; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN9nP0Un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE021F000E9;
	Thu,  2 Jul 2026 06:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782973432;
	bh=dkaWcF6lPhlXDHR/l/1Bc9EwwG7U7AdPwG8pQN5l78g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZN9nP0UnOuhJO2wkbHzyfhcAJeayHgkPZ41M/bDL7Si+fiXbStRubdMrJFAqQe26J
	 /OSXrEevt/sKteoTxJ4wqwkcNZFskipD133DOsiD2KL1ByuNcNZvw8sWPzFeRAi37v
	 KxSOzDblsvfobDmmLj/xp++bxGXWhdGr9Pe0J24xns8NbwzvRmMOBpEyGdvp6SqWeG
	 GBHFc01NF6AxMJv72aiq5liDFJzKVsxszHOYsr8MYFh2UJuMhdK6HNAOx1l/hHI8ys
	 UlKmIw8U5AdLn2D9xCjXACoRNUhbfOKc2ZGd9Xl9I/tMRJRPkETZaruF+9ocsYYeEc
	 b7REp/Y++06+g==
Message-ID: <5188aca74aaa8ce3024e5661cb493f49cb690170.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 3/4] selftests/bpf: mptcp: verify scheduler
 rejects non-msk socket to set_timeout
From: Geliang Tang <geliang@kernel.org>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Thu, 02 Jul 2026 14:23:38 +0800
In-Reply-To: <20260629-mptcp_bpf_kfunc_fixes-v1-3-8cc875f36f53@mpiricsoftware.com>
References: 
	<20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
	 <20260629-mptcp_bpf_kfunc_fixes-v1-3-8cc875f36f53@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2026-06-29 at 17:37 +0530, Shardul Bankar wrote:
> Add a negative test for the bpf_mptcp_set_timeout() kfunc: a BPF
> MPTCP
> scheduler whose get_send() passes a subflow TCP socket to it, where
> the
> kfunc takes a struct mptcp_sock *, must be rejected by the verifier
> at
> program load time. This guards against widening the kfunc argument
> back
> to a generic struct sock *, which would reintroduce the socket type
> confusion between an MPTCP-level socket and a subflow TCP socket.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c     | 31
> +++++++++++++
>  .../selftests/bpf/progs/mptcp_bpf_bad_sched.c      | 54
> ++++++++++++++++++++++

I don't think it's necessary to add a dedicated "bad_sched" BPF
scheduler, at least not for upstream. It can be kept locally for
verification purposes, which is sufficient. Therefore, I suggest
dropping patch 3 and patch 4 from this series. Alternatively, if they
are intended solely to validate patch 1 and patch 2, please prefix
their subjects with a "DO-NOT-MERGE:" tag to clearly indicate they are
not meant for integration.

WDYT?

Thanks,
-Geliang

>  2 files changed, 85 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 7f48fd9e94e1e..ff8209ebc8388 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -18,6 +18,7 @@
>  #include "mptcp_bpf_rr.skel.h"
>  #include "mptcp_bpf_red.skel.h"
>  #include "mptcp_bpf_burst.skel.h"
> +#include "mptcp_bpf_bad_sched.skel.h"
>  
>  #define NS_TEST "mptcp_ns"
>  #define ADDR_1	"10.0.1.1"
> @@ -813,6 +814,34 @@ static void test_burst(void)
>  	mptcp_bpf_burst__destroy(skel);
>  }
>  
> +static void test_bad_sched(void)
> +{
> +	struct mptcp_bpf_bad_sched *skel;
> +	char *log = NULL;
> +	int err;
> +
> +	/* bad_sched_get_send() passes a subflow TCP socket to
> +	 * bpf_mptcp_set_timeout(), which takes a struct mptcp_sock
> *. The
> +	 * verifier must reject this socket type confusion at load
> time, and
> +	 * for the right reason -- assert the specific verifier
> message.
> +	 */
> +	skel = mptcp_bpf_bad_sched__open();
> +	if (!ASSERT_OK_PTR(skel, "open: bad_sched"))
> +		return;
> +
> +	if (start_libbpf_log_capture())
> +		goto destroy;
> +
> +	err = mptcp_bpf_bad_sched__load(skel);
> +	log = stop_libbpf_log_capture();
> +	ASSERT_ERR(err, "load: bad_sched must be rejected");
> +	ASSERT_HAS_SUBSTR(log, "expected pointer to STRUCT
> mptcp_sock",
> +			  "verifier rejects subflow sock to
> bpf_mptcp_set_timeout");
> +	free(log);
> +destroy:
> +	mptcp_bpf_bad_sched__destroy(skel);
> +}
> +
>  void test_mptcp(void)
>  {
>  	if (test__start_subtest("base"))
> @@ -835,4 +864,6 @@ void test_mptcp(void)
>  		test_red();
>  	if (test__start_subtest("burst"))
>  		test_burst();
> +	if (test__start_subtest("bad_sched"))
> +		test_bad_sched();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
> b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
> new file mode 100644
> index 0000000000000..14041c1e5ffd7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026, Mpiric Software. */
> +
> +/* A scheduler that passes a subflow TCP socket to
> bpf_mptcp_set_timeout(),
> + * which takes a struct mptcp_sock *. The verifier must reject this
> at load
> + * time; see the bad_sched subtest in prog_tests/mptcp.c.
> + */
> +#include "mptcp_bpf.h"
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
> +
> +SEC("struct_ops")
> +void BPF_PROG(bad_sched_init, struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops")
> +void BPF_PROG(bad_sched_release, struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops")
> +int BPF_PROG(bad_sched_get_send, struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *ssk;
> +
> +	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
> +		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
> +		if (!ssk)
> +			return -1;
> +		/* ssk is a subflow TCP socket (struct sock *), not
> an msk.
> +		 * Passing it to bpf_mptcp_set_timeout(), which
> takes a
> +		 * struct mptcp_sock *, is a socket type confusion
> that the
> +		 * verifier must reject at load time ("expected
> pointer to
> +		 * STRUCT mptcp_sock").
> +		 */
> +		bpf_mptcp_set_timeout((struct mptcp_sock *)ssk);
> +		mptcp_subflow_set_scheduled(subflow, true);
> +		return 0;
> +	}
> +	return -1;
> +}
> +
> +SEC(".struct_ops.link")
> +struct mptcp_sched_ops bad_sched = {
> +	.init		= (void *)bad_sched_init,
> +	.release	= (void *)bad_sched_release,
> +	.get_send	= (void *)bad_sched_get_send,
> +	.name		= "bpf_bad_sched",
> +};
> 

