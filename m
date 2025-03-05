Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A71F63C3
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191285; cv=none; b=puB3f1Tk0JV+RF6Oi4JmLmtPL72f6vC9peEZwhinQCRHMz1bJXHX+jeFfP5umlBg5L/k5mhcvHSFFl68/QDFEITep+TGpOIHDGi62pB/ygXqgFCxEwc97oCA+C963YePWPCMywdnt0oDTmCYlXrEfQkr+QOBlulCITR+dPKJABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191285; c=relaxed/simple;
	bh=wSfrezmaUbGQpeiS/Gn/puTrrPXZwYYtziELArHmqx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjT0W4FcSjE9JVpGyGXfWLDvJ4DOlcePZqPzzGRKlZeueJvOQGT9xzVtclpfJA+aVgIZtxYGzydjuDWRfVRC4GGwQhUxHpBH5GKanAuCrJpjspzOa2anolkB1AXW9RecPUNVyXbNvv8o318aFQ+c2ngD5uiYd1G3AZ803gBQUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B74xuUKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B74xuUKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5784C4CED1;
	Wed,  5 Mar 2025 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741191284;
	bh=wSfrezmaUbGQpeiS/Gn/puTrrPXZwYYtziELArHmqx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B74xuUKSAiwHFnW0lChSbAiQCPcNwF07+wdfosbW3bsR2H6L+dpjROFQ5Q0ULLYfd
	 PPxMUJR6SwExFiqgRr29StiU7NMPpBgJEAINMdE7LbWQLsg6W8I70PWuVzopHn2Bry
	 t+bb/AmV50GUFAqLmQroHDmGlkMeNWuRiH7Wgu5uGbznEyn6mZ3+y24ZtoQ8lkobTf
	 LoYPJsKJeV9ZSNKFAb6YgvXYnyUk+HJJNM4fo9dY4fHa6XsXjkG/i8Hl/DbatVFRhH
	 l1yQ1otNH9wtc0VegQepBbi832XBPQFVphjwtk1dfgyoTa053ojFAoEKX16YdJRO3v
	 lhdKdpnP5SW4w==
Message-ID: <ba7822fb-a0cb-4636-89fc-ad1355e4c234@kernel.org>
Date: Wed, 5 Mar 2025 17:14:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v15 0/8] use bpf_iter in bpf schedulers
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 17/02/2025 11:41, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v15:
>  - patch 7, add the declaration of bpf_mptcp_subflow_tcp_sock

Thank you for the patches and the reviews!

Now in our tree:

- 07aa0978f6c6: "squashed" (with conflicts) patch 1/8 in "mptcp: add
sched_data helpers"
- fa29b1f91c26: conflict in t/bpf-Add-bpf_mptcp_sched_kfunc_set

- 311895dc3441: "squashed" patch 2/8 in "bpf: Export mptcp packet
scheduler helpers"
- 3c6796421a18: "squashed" patch 3/8 in "selftests/bpf: Add bpf_first
scheduler & test"
- 86c995604f64: "squashed" patch 4/8 in "selftests/bpf: Add bpf_bkup
scheduler & test"
- 0b70cc3bdfe5: "squashed" patch 5/8 in "selftests/bpf: Add bpf_rr
scheduler & test"
- 8213e7e2d049: "squashed" patch 6/8 in "selftests/bpf: Add bpf_red
scheduler & test"
- 3fe124ac24c8: "squashed" patch 7/8 in "selftests/bpf: Add bpf_burst
scheduler & test"
- Results: 3161a41b78f4..a37b7ba9c462 (export)

While at it, I added two patches, as a follow-up of b68b106b0f15
("mptcp: sched: reduce size for unused data") instead of patch 8/8:
- e74f811b4626: Revert: "mptcp: add sched_data helpers"
- Results: a37b7ba9c462..a44778c76bc6 (export)

- fe2716bcac00: mptcp: sched: remove mptcp_sched_data
- Results: a44778c76bc6..516dcfe47eed (export)

And the adaptation in the BPF code and selftests:
- 0228f6dcc40b: Squash to "bpf: Add bpf_mptcp_sched_ops"
- 145b54903251: Squash to "selftests/bpf: Add bpf_first scheduler & test"
- 4ebb90f81181: Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
- 2af0575eda92: Squash to "selftests/bpf: Add bpf_rr scheduler & test"
- 1dd84d973730: Squash to "selftests/bpf: Add bpf_red scheduler & test"
- fff0e60b0834: Squash to "selftests/bpf: Add bpf_burst scheduler & test"
- Results: 516dcfe47eed..62dab9e8d979 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/a5cceef4fc35169482ecfd086c3d19c15d23e7e6/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

