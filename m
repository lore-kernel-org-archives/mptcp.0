Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A1403E8B
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078331; cv=none; b=BqxvuQ8QNLfYX3ttOGx5c214PDqJU/8k9KwNGU5EYp7YResGM3laGzC47wcfVQYJxoF8CaFDpKiVbTq50jrn/ePfgxNbQJfKFe01fgo8JB3lKJdI+7seqN0q6R183WbtvR/B73FZ/QDMMz4nsdVph5X9P16asthwU92H2gjVihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078331; c=relaxed/simple;
	bh=9M4/ehVXwfExxfS96Sh8nLGr8gRHhfPfwHgBpKbq3dY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BHPDegQ41XthdROyRphPKRZN4Oq54nSwHhX9XI5f0iFDryDgw+T+6KMRkqUA6R4CD3SaPm0UUafz2oNI8P6W0VUZ/l9oo+21GVZb+XBqwHc73X16nXh86eUPtfXdicXe6lADfWHQmchXhN+ufRA9NLR7Kc5iUfciU4qjZ4KMxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjdLZT7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjdLZT7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8B61F00893;
	Fri, 29 May 2026 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078324;
	bh=kjk7Tka0sC/mOgR0aVRLPSfhA2g2FUIJiDAMDoxUQBc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=SjdLZT7bXR+h6AhfrArfowVJLx9BE+d0rwkp75I3mNx+vuhO0FR4ozf4KGARcIGFm
	 GwdV3VTY9t1ExTkSheIPOn1U2W3sVxTbnI5yaJyYQh99DsuQ/dEOmYIim8QwmUKbY8
	 bo0Ap8oGe7aAWktCvUDmzbatLZedm8pOn6MwmgLcE2hVktXq/LYX/B/3TXMWzLnGuS
	 SIdxbJHxAc9AwswUvBaDEqTEnNGHtb5NdcRj76GbcDRnkJTAXl9L/41a1kvnSyvVF4
	 0OtW2C8wv1Qgk1puDKiXIiog3wxZRJFuPJEEY+nD5s7w9i3ROU8NJBRK2T8fE9PTVh
	 BwPHofQbjXnyw==
Date: Fri, 29 May 2026 11:12:03 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net mptcp-next v4 00/15] mptcp: pm: drop TCP TS
 with ADD_ADDRv6 + port
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
Message-ID: <6b4b5e7d-1663-c84f-b09a-e2afeb7b866e@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 May 2026, Matthieu Baerts (NGI0) wrote:

> Currently, it is possible to add a "signal" MPTCP endpoint with a v6
> address and a port, or to directly request to send an ADD_ADDR with a v6
> address and a port, but such signalling option cannot be sent when TCP
> timestamps is used due to a lack of option space. Instead of simply
> dropping such ADD_ADDR, the TCP timestamps can be dropped only for this
> packet.
>
> - Patch 1: fix for PREEMPT_RT kernels, for -net.
>
> - Patches 2-4: small cleanups to avoid computing ADD/RM_ADDR twice.
>
> - Patches 5-8: the new feature, controlled by a new sysctl knob.
>
> - Patch 9: extra checks in the selftests.
>
> - Patches 10-15: refactoring/cleanups: some of them were part of a
>  previous patch: "mptcp: pm: clearer ADD_ADDR related helpers names"
>  [1].
>
> Note that the mptcp/add_addr/add_addr6_port_ts_server.pkt packetdrill
> test is supposed to fail with this series, until this PR is applied:
>
>  https://github.com/multipath-tcp/packetdrill/pull/198
>
> Link: https://lore.kernel.org/20260415-mptcp-inc-limits-v5-20-e54c3bf80e4e@kernel.org [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v4:
> - Patches 2-4: uniform "size" type: signed for all suboptions. (Mat)
> - Dropped previous patch 16.
> - Link to v3: https://patch.msgid.link/20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org

Hi Matthieu -

Thank you for the updates in v4, all of my concerns are addressed and I 
agree that this approach to fitting ADD_ADDR headers w/ IPv6 seems like 
the best tradeoff.

I'll also give a +1 on the packetdrill PR.

For the series:

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> Changes in v3:
> - Patch 1: sk_stop_timer() should still be called under rcu.
> - Patches 6-7: split + s/has_ts/add_addr_drop_ts/.
> - Link to v2: https://patch.msgid.link/20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org
>
> Changes in v2:
> - Patch 1: new.
> - Patch 3: reset size in mptcp_pm_add_addr_signal for dropped options.
> - Patches 4-5: split from previous patch 3. (Paolo)
> - Patch 4: fix typo.
> - Patch 5: fix reverse Xmas tree order + change label. (Paolo)
> - Patch 6: back to v6 connection.
> - Patch 10: fix comment.
> - Patch 14: fix typo.
> - Link to v1: https://patch.msgid.link/20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (15):
>      [mptcp-net] mptcp: pm: avoid sleeping while holding rcu_read_lock
>      mptcp: options: suboptions sizes can be negative
>      mptcp: pm: avoid computing rm_addr size twice
>      mptcp: pm: avoid computing add_addr size twice
>      mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
>      tcp: allow mptcp to drop TS for some packets
>      mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
>      selftests: mptcp: validate ADD_ADDRv6 + TS + port
>      selftests: mptcp: always check sent/dropped ADD_ADDRs
>      mptcp: pm: use for_each_subflow helper
>      mptcp: pm: rename add_entry structure to add_addr
>      mptcp: pm: uniform announced addresses helpers
>      mptcp: pm: remove add_ prefix from timer
>      mptcp: pm: make mptcp_pm_add_addr_send_ack static
>      mptcp: pm: avoid using del_timer directly
>
> Documentation/networking/mptcp-sysctl.rst       |  13 ++
> include/net/mptcp.h                             |   3 +-
> net/ipv4/tcp_output.c                           |   6 +-
> net/mptcp/ctrl.c                                |  18 ++-
> net/mptcp/options.c                             |  65 +++-----
> net/mptcp/pm.c                                  | 189 ++++++++++++++----------
> net/mptcp/pm_kernel.c                           |  22 +--
> net/mptcp/pm_userspace.c                        |   6 +-
> net/mptcp/protocol.h                            |  46 ++----
> net/mptcp/subflow.c                             |   4 +-
> tools/testing/selftests/net/mptcp/mptcp_join.sh |  83 +++++------
> 11 files changed, 240 insertions(+), 215 deletions(-)
> ---
> base-commit: 4d6bda29d05f8789f40c095d5d08396ffd6b470f
> change-id: 20260508-mptcp-add-addr6-port-ts-371653e0f843
>
> Best regards,
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
