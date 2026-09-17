Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463704A7CAE;
	Thu, 17 Sep 2026 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636787; cv=none; b=eSysg/j7DbsKApoqrDnSZ3JN2psuuoUZ5XAjdCrZ29jfalkV+iYtT5DZTDNnwICX6Vc7Bk6RmAPx82GqXSl6jJfZViiyaoPAfBe4Uh0wJ1EUZVU/FqW5KXRtmfaP9ZJge0eD13D1OJ40z8WyDceg7SPFpmuRqOP8Di6k0MviplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636787; c=relaxed/simple;
	bh=6hUuYPcWxqXPQ36Q8DpYTJSlN3WpSLI1Ia1MqQ3Lh68=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S8tcC+IfhUcG+0vYK5gkuBwnz5Udp0rWKsyMKnvAafWtiXOHvStS9tEOW9BiqGQxB35RZjURatEI2VphnNTvO7yObocKayGKS9n30gK71xsHaY7lG9RJfgp845Bp1EbFNUx7YdwV9c8OxktJi0OVm8Mtd52VvZ4RsRUxHCn+GkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky8zNg2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky8zNg2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140F41F000FF;
	Thu, 17 Sep 2026 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636782;
	bh=wduxLqvH7l65E4HRHZRiG4ffV/S85OxQP9Lm4sYKkIc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ky8zNg2Rj/O662bhRp4Ok7dOz1U6VBLfH0YfjMvq4smARtvLWDCyUqouuV1yZ5Wk5
	 CHRR2WVlNaqRJ2Bage394GkzwlT1wPlfA9iw/XzF0HIGzFfg1z95EH2BwNhXbonIvg
	 chy+ZzUGOZtiysiz4KKaOL7c22i8zMOxC+zwVQB91qqZpj+XtoDVidx+qopDfsLBG2
	 /A9pCOVDdFqrnSeWjAYRMgHW27g+DTiNTLisS5gwaNcu0Egywi7ZIuRsJjIZEL34ou
	 yjlkeJFRV2u5nby2nl7vwBnOaIVe235MaIgrQZKZLNzC941eLHgr/znhtgDkwRaBQA
	 C/giGoZKwTT8Q==
Content-Type: multipart/mixed; boundary="===============2920527551366109915=="
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <b93838fa6a820d34225ddcfa69056a560d42df034aff760452e09f0f3d5b3f75@mail.kernel.org>
In-Reply-To: <20260917081209.361367-2-jiayuan.chen@linux.dev>
References: <20260917081209.361367-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: add verifier tests for bpf_skc_to_mptcp_sock
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,mptcp@lists.linux.dev
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,matttbe@kernel.org,martineau@kernel.org,geliang@kernel.org,tangyazhou518@outlook.com,tj@kernel.org,mattbobrowski@google.com,nicolas.rybowski@tessares.net,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 09:19:41 +0000 (UTC)

--===============2920527551366109915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 8b439e194bcc5..8d5908e34c9b4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_mptcp.c b/tools/testing/selftests/bpf/progs/verifier_mptcp.c
> new file mode 100644
> index 0000000000000..1f679265e0437
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_mptcp.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"

This isn't a bug, but since nothing from bpf_tracing_net.h is used here,
would a plain #include "vmlinux.h" (as progs/verifier_sock.c does) be enough
for struct mptcp_sock?

The file doesn't use any AF_*/SOL_*/TCP_*/IPPROTO_* constants or
bpf_core_read/BPF_CORE_READ that bpf_tracing_net.h provides. It only needs
the transitive vmlinux.h for struct mptcp_sock. The 9 verifier_*.c files
that need BTF kernel types include vmlinux.h directly.

> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u32 token;
> +
> +static __always_inline struct bpf_sock *lookup_subflow(struct __sk_buff *skb)
> +{
> +	struct bpf_sock_tuple tuple = {};
> +
> +	return bpf_skc_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4),
> +				  BPF_F_CURRENT_NETNS, 0);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35199493791
--===============2920527551366109915==--
