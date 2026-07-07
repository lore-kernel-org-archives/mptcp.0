Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03D37F72C
	for <mptcp@lists.linux.dev>; Tue,  7 Jul 2026 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423632; cv=none; b=aB8EvUiyPQQqzZdmqj0vI8hcPgbsI+LTHhldL0zOOK/lCvKg9KmNZplMEKUfrlRdrKj4H5srYm7YB2i8avNYEdmWML2sHrvZM8bccr0p2VjESDpxaPzPBSFJEQoYW0WabeWh22ZLcetWivVxnNLBsQtaPu8i7XcCDD6yyVBBjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423632; c=relaxed/simple;
	bh=T/XYgpu/ULYAhsUBnIj7SIPozNjBSefcJL8IkP40638=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwBaNs9Eb9WMJ/xpCrYXba6OjSyPHyJVI9V0uuIDkdvTLAA2fBclnZT9MJ5ah7rodM0PG9Nqgn6J0DAnrVAL8rV6W6mvmcbNGlT48OdCskIxaRHS5AGxLGjJ2pKtLkxiWSzrfxjeiKo7pjK2fPryPxN9wzqD6/4/Gx9Ew4OUPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MivkY43x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MivkY43x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD391F000E9;
	Tue,  7 Jul 2026 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783423631;
	bh=GgdS985dVOgDkV/zaZ7aBTarS2xFoS9ffuM52S+qljg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MivkY43xrBLdgBTzrXpBN68lLw9GVL5MXh8x7FxN8F/lKyIFbg6RwUQOcHAzSqyw/
	 Gkdh9G/MyI6QwTKS20f8MGFMq6HIV0y5qCD26n2KltiKR3HJTTb2H47aunvBdzqRLy
	 VSA97JHMqRsVnC7t/6eJjA38DuFesALtTVRLiuxJADo9MJSK2NrXzetSIceZCJodvT
	 iDm3u9g+qfbbqLP7h/1SsJg8eYEbWVtYPZcP56JQbpsacDk//wmc11z5Aj/5Cj/vxh
	 rTMoban1xq5IjSiuy6d4axJhPt8xKrOc1ukRdcC6SSTFcLbl5QynGzPRjxNToeMxoO
	 BLynRVwC/AHTA==
Message-ID: <ad9044cd-ff6d-4a88-ba3f-fbba7d40b092@kernel.org>
Date: Tue, 7 Jul 2026 13:27:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing id
 0 endpoint
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, martineau <martineau@kernel.org>,
 pabeni <pabeni@redhat.com>, "shardul.b" <shardul.b@mpiricsoftware.com>,
 janak <janak@mpiric.us>, kalpanjani009 <kalpanjani009@gmail.com>,
 shardulsb08 <shardulsb08@gmail.com>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
 <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
 <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com>
 <bca2ad2f-1f45-45e7-a8bd-7a08dd7100c2@kernel.org>
 <19e830d30d7.701114c6187254.5018026155515510877@mpiricsoftware.com>
 <6d0b954c-4028-4c1e-bf02-5bf5f43f58af@kernel.org>
 <19f3b374a41.2132097d1809464.3759794617307044756@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <19f3b374a41.2132097d1809464.3759794617307044756@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kalpan,

Thank you for your reply.

On 07/07/2026 08:15, Kalpan Jani wrote:
> Hi Matt,
> 
> Thank you for the clear question — here is my honest assessment.
> 
> The blocking point for a packetdrill test of this specific bug is
> that the trigger sequence requires the kernel PM worker to run
> between a "del id 0" and a second signal endpoint add, and
> packetdrill's shell-escape timing is coarser than what reliably
> controls that window.
> 
> More specifically, the reproducer needs:
> 
> 1. A fully-established MPTCP connection.
> 2. A second subflow via MP_JOIN (to keep the connection alive
>    across the id 0 removal) — this part packetdrill handles well,
>    as shown in mp_join_server.pkt.
> 3. An ADD_ADDR for the id-0 address already in flight with the
>    echo withheld — also doable: just don't send the echo packet.
> 4. `ip mptcp endpoint delete id 0 <addr>` via a shell escape —
>    packetdrill supports this.
> 5. `ip mptcp endpoint add <addr> flags signal` to force PM
>    reselection — also a shell escape.
> 
> The difficulty is between steps 3 and 4: the ADD_ADDR for id 0
> only gets sent after mptcp_mpc_endpoint_setup() has accounted the
> MPC endpoint and the PM worker has run. In the mptcp_join.sh
> reproducer this is handled by waiting for the second join
> (wait_mpj) and checking the add_addr_signal counter before
> proceeding. In packetdrill, the closest control is expecting the
> `> add_address address_id=0 ...` line before issuing the shell
> escape — and that does work in principle.

Note that if needed (but I don't think it is if I understood correctly),
you can always call commands or scripts in Packetdrill, e.g. to wait for
an internal state to change.

> Where it gets fragile: after the del+re-add, the PM reselects id 0
> and the WARN fires inside the add_addr_doit netlink handler, which
> is synchronous with the shell-escape command. Packetdrill would
> then need to expect a second `> add_address address_id=0 ...` line
> that a fixed kernel would *not* send (since mptcp_pm_announced_alloc
> returns false silently). That asymmetry — expecting a packet that
> a fixed kernel suppresses — means the test structure naturally
> inverts: you'd write it to expect *no* retransmission after the
> del+re-add, which is harder to express cleanly than "this packet
> must appear". The mptcp_join.sh counter check (`add_addr_signal`
> going from 2 to 1 after the del) is a more direct assertion.

You can also check ss' status. But here, you can also simply inject
another packet after a small delay, and expect an ACK without ADD_ADDR
to be sent instead.

> That said, I think a packetdrill test *is* achievable if it's
> structured around the ADD_ADDR retransmit that fires on an unfixed
> kernel after the del+re-add: on an unfixed kernel the stale entry
> triggers a second `> add_address address_id=0` packet; a fixed
> kernel does not send it. So the test would:
> 
>   - inject the MP_JOIN to create the second subflow;
>   - see `> add_address address_id=0` (the first, legitimate one);
>   - not send the echo;
>   - issue `ip mptcp endpoint delete id 0 $OPT_LOCAL_IP` as a
>     shell escape;
>   - issue `ip mptcp endpoint add $OPT_LOCAL_IP flags signal`;
>   - add a ~`*` line that expects *no* spurious second
>     add_address — which is the opposite of what unfixed kernels
>     produce.
> 
> The main uncertainty is whether packetdrill's `*` (any-packet)
> handling can cleanly express "this packet must NOT appear within
> N ms", or whether we'd need a short timeout + close to flush the
> pipe. That's the part I haven't mastered yet in packetdrill.
> 
> If you can point me at an existing test that uses a negative
> packet assertion (or a timeout to prove absence), I can turn the
> mptcp_join.sh reproducer into a packetdrill test for the next
> version. Otherwise I'll send the mptcp_join.sh subtest as patch 2
> of v6 (with the `addr` fix in patch 1), and follow up with a
> packetdrill test separately once I understand that idiom better.

I think the easiest is to inject a packet after the timeout to force the
kernel to react, e.g. sending a DATA_FIN, data, an out of window packet,
etc. Then see that the reaction is the expected one, not a wrong
retransmission. I just noticed that's what is done in
add_addr_retry_errors.pkt, lines 32-38.

In general, about Packetdrill, I recommend this presentation:


https://netdevconf.info/0x19/sessions/tutorial/tutorial-using-packetdrill-to-write-automated-tests-for-the-linux-networking-stack.html

e.g. on page 15, there are some explanations about timing:


https://netdevconf.info/0x19/docs/netdev-0x19-paper23-talk-slides/packetdrill%20-%20NetDev%202025-03-10.pdf

Back to the series you sent: we could say that the mptcp_join.sh
reproducer is enough, but I think it would be useful for you -- and to
avoid a new "speed=slow" subtest: mptcp_join.sh's execution is already
long enough -- to try a bit more with Packetdrill if that's OK. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

