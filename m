Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E33DD870
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171543; cv=none; b=pZaxl0mTA/PBv5JrtaQDABqdW3qv/VxF+8c7XCRnhZGM0Wzqt/W29kh4lIruG7DYpL7n7qIiM0zP6H/goJpeQ1RwS440D6zSlhQs6vUL5/D4VWeqolpH/m0ecP8Ce0wa7IAOjjQ0dBZYX4qYe+4K6wA55KI8XobYCnzH6S/lQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171543; c=relaxed/simple;
	bh=3juiurH06JG8Z8xtCI+YeesGl66ErXgm1jy6iX7cKjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SrCpLFBiIZ1I8+DzeplMLYdXz9GWVv+fldIs7j44OS2V6REoSZaXHgp7jiYuFvuKCuDu/8Ohe3+h6xfZqkRY14mGIskXokqsP79dQdKe4cUlBr+ihqylC0S/fzXZudP7MHJXe5z5kFkSV7sbj4rsMtzIwBn7yl1UM6fuvqsOpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggnGt6IC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggnGt6IC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF78F1F000E9;
	Mon, 31 Aug 2026 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171540;
	bh=o1gXEZZduxdDk8U837u5vEYnfdEe6hRSkbr9g94zpkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggnGt6IC4mZgKRxuKqv4COwvDNczNugPYrSvqLXlqmCCG6s8h5CJsRiS63VxAYgaF
	 H5iLFZUHXeIE+xNrFcla9+2EQNhsAGjic0Vd25kQvHyM1yf2CHz6UhlMIZLxR6WLje
	 pVLZvtSsWeHL5JYX+9puaAiiw5vkb2SZ2sliaEwRq53b1hZ3XPuhv0kGE6TLFl0ogw
	 SUlRmwJ9hujTY133udJeY97y40XHo39KI0N78hPMTR+5BAMJqWSSEJB50uqm3Vqka+
	 Z23IYIvei9cOOuxLNE+HiAYDMNAP4vBtpf5n6Qpc9KYYypLhxQuOV4Iah3123TXSto
	 LtyKPzKHMhE0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 2/2] selftests: mptcp: bpf: exercise the
 subflow avoid flag across rounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260831094651.2682660-3-kalpan.jani@mpiricsoftware.com>
References: <20260831094651.2682660-1-kalpan.jani@mpiricsoftware.com>
 <20260831094651.2682660-3-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:18:59 +0000
Message-Id: <20260831101859.EF78F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The kfunc mptcp_subflow_set_avoid() modifies the 'avoid' bitfield =
without holding the TCP socket lock, causing a data race with the TCP recei=
ve path.
- [Medium] Global .bss variables are incorrectly used for per-socket state,=
 causing race conditions and test flakiness.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem moder=
n kernel comment style.
--

commit 1f082f0309b048cf33dbb4e85b2d29227d5feef3
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

This commit introduces a new BPF struct_ops scheduler selftest in
mptcp_bpf_avoid.c to test mptcp_subflow_set_avoid(). It sets the avoid flag
once on the first scheduling round and verifies that the core preserves this
state across multiple get_send() invocations.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_avoid.c
> new file mode 100644
> index 0000000000000..8b22c5967a7a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026, MPTCP. */
> +
> +#include "mptcp_bpf.h"
> +#include <bpf/bpf_tracing.h>
> +
> +extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) =
__ksym;
> +extern void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflo=
w,
> +				    bool avoid) __ksym;
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* set once, on the first scheduling round, never touched again -- this
> + * is what makes "avoid" different from "scheduled": nothing here
> + * re-asserts the decision, and the core doesn't clear it either.
> + */

[Severity: Low]
Is this multi-line comment following the mandatory BPF subsystem modern ker=
nel
comment style?

The BPF subsystem requires multi-line comments to have the opening /* on its
own line.

> +bool avoid_marked;
> +__u32 get_send_calls;
> +
> +SEC("struct_ops")
> +void BPF_PROG(mptcp_sched_avoid_init, struct mptcp_sock *msk)
> +{
> +	avoid_marked =3D false;
> +	get_send_calls =3D 0;
> +}

[Severity: Medium]
Are these global .bss variables safe to use for per-socket state?

When client and server sockets run concurrently in the test namespace, the
server's accept() triggers mptcp_sched_avoid_init(). This will zero out the
shared .bss variables (avoid_marked and get_send_calls) while the client mi=
ght
be concurrently executing bpf_avoid_get_send().

Would it be better to utilize bpf_sk_storage for isolated per-socket state
instead of global variables to prevent intermittent test failures?

> +
> +SEC("struct_ops")
> +void BPF_PROG(mptcp_sched_avoid_release, struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops")
> +int BPF_PROG(bpf_avoid_get_send, struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	get_send_calls++;

[Severity: Medium]
Will this non-atomic increment race with both the server's init reset and a=
ny
concurrent bpf_avoid_get_send() calls from other sockets?

> +
> +	if (!avoid_marked) {
> +		int i =3D 0;
> +
> +		/* bench every subflow but the first, once */
> +		bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
> +			if (i++ > 0)
> +				mptcp_subflow_set_avoid(subflow, true);

[Severity: High]
Can calling mptcp_subflow_set_avoid() safely update the bitfield?

The BPF scheduler runs under the MPTCP socket lock, but the underlying kfun=
c in
net/mptcp/sched.c executes a non-atomic read-modify-write on the 32-bit
bitfield word in struct mptcp_subflow_context:

net/mptcp/sched.c:mptcp_subflow_set_avoid() {
	subflow->avoid =3D avoid;
}

Concurrently, the TCP receive path (mptcp_subflow_data_available()) modifies
map_valid (which is in the same bitfield word) under the TCP socket lock.

Could this data race silently corrupt adjacent bitfields and lead to stalled
connections? Would it be possible to extract avoid into a separate bool byte
(like scheduled) to prevent bitfield word aliasing?

> +		}
> +		avoid_marked =3D true;
> +	}
> +
> +	/* every round -- including this one -- just reads back state set
> +	 * at most once above. no re-assertion, ever.
> +	 */

[Severity: Low]
Should this multi-line comment also be updated to place the opening /* on i=
ts
own line, conforming to the BPF subsystem comment style?

> +	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
> +		if (subflow->avoid)
> +			continue;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831094651.2682=
660-1-kalpan.jani@mpiricsoftware.com?part=3D2
