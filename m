Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CE18757F
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957342; cv=none; b=ltQWcmSUSeF1DrlL4WqLuvLuCSw5nHJN/IMbt36SSQiWFTl6EBeM1rdA8+Vu6Vn+fYKhMguoJmU7QYlYn97qLeCavAT7oHwj0zWOamRxdso5VeQ8N9kf+v5Kmut4fa8QAl8YZ1zOYX+FEKKy7J1HX1B469FM3N85cF9IiZFyFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957342; c=relaxed/simple;
	bh=pBSJi/yuzJfZjKDLQCNcqN6X3x2nGX2eyStr3qfYW4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eg2ZKfqrNJCC+BeOk5vieA5sYjm4kVIkdnrzjahOcjVRMZXSksKiHLt4KhEexlRLJ/lq/16BF4L+lBaWVA+GUy43eIUG6/Fg19kswKm3MgIw9Fgo33ZS2H/Fal75ge8voqbiUW4YPPdoStCh0g9l084vDJzy4jsuWNLTtCs0Nog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UClYJsyA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UClYJsyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0BAC4CECC;
	Tue, 10 Sep 2024 08:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725957341;
	bh=pBSJi/yuzJfZjKDLQCNcqN6X3x2nGX2eyStr3qfYW4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UClYJsyAUb6FMhcdZ1UTNg6nElYCs6MNAnL4IhxixwTbYhfyD0HZ2NZ/AKoKt8/W4
	 0NsEAypMMJQ9zx+eLBI/6lzQb/1Hs4jYs5NxLK5EKjYEZEb5xIh3m1t4GIJH6LcBYf
	 Qh7Vwhs0RJYBHz3CxMdAdJHBnQJQTSIsE2T788Jb2OzvDq7EZfghSGEDJY+n1mlr6d
	 W8UfxRNWUTlUPMwBO+3t62vHqHH1SclWukZXthLTfeV0BjIykLSbEd+nY/rWqfqLgp
	 he9Dn3avYjQ7luKMj2RDKKyGFSCw4l38X2FOyMpGmxxH+T0yhlHzumHg8XAQq+09+S
	 CpgorsrFATn9g==
Message-ID: <1b4d71dd-6320-4155-bc16-96024d83a80e@kernel.org>
Date: Tue, 10 Sep 2024 10:35:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf scheduler
 test" - drop has_bytes_sent
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <bae090f6945a2621f9ed4de2cb0e29d772a0e760.1725948163.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bae090f6945a2621f9ed4de2cb0e29d772a0e760.1725948163.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/09/2024 08:03, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Drop ss_search() and has_bytes_sent(), add a new bpf program to check
> the bytes_sent.

Thank you for the follow-up.

(...)

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
> new file mode 100644
> index 000000000000..93672e00d23e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024, Kylin Software */
> +
> +/* vmlinux.h, bpf_helpers.h and other 'define' */
> +#include "bpf_tracing_net.h"
> +#include "mptcp_bpf.h"
> +
> +char _license[] SEC("license") = "GPL";
> +unsigned int bytes_sent_1 = 0;
> +unsigned int bytes_sent_2 = 0;

Can you not use u64, similar to tp->bytes_sent?

> +int pid;
> +
> +SEC("fentry/mptcp_sched_get_send")

Would it not be better to get 'fexit' instead? If you hook before the
function, the first time there will not be any bytes being sent, and you
will miss the last ones, no?

(Note that you could also hook where the connection is being closed, to
only check the bytes once, not each time more bytes are sent, no? But I
guess for such test, it is fine like that.)

> +int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (bpf_get_current_pid_tgid() >> 32 != pid)
> +		return 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct tcp_sock *tsk;

(usually called *tp, not *tsk)

> +		struct sock *ssk;
> +
> +		subflow = bpf_core_cast(subflow, struct mptcp_subflow_context);
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		tsk = bpf_core_cast(ssk, struct tcp_sock);
> +
> +		if (subflow->subflow_id == 1)
> +			bytes_sent_1 += tsk->bytes_sent;

It looks strange to increment the bytes here: 'bytes_sent' is the total,
no? Then you should

  bytes_sent_1 = tp->bytes_sent;

no?

> +		else if (subflow->subflow_id == 2)
> +			bytes_sent_2 += tsk->bytes_sent;
> +	}
> +
> +	return 0;
> +}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

