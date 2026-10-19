Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430709;
	b=x5XAjUiVHDBR0vvUPhdMQvmq8eR81eDtonR+TiPjBVeRhJQCNNAA5AFJ5cNMWAX0+AvH
	 JlZiZ/0UfANJx5C//fSyQO95aDzFALFeMnl5UvCH9aLe79zvaWolT3SeXBw4W9L/AGlSs
	 UlnYKalg7VrCRo9JrBHVjqhittwY72XpEli9cILOueWtLvDScfiB4SvPOJY9syN8qrPQu
	 XNRvWxh7eRp4tG/v7Ie1c51fm91k/vWSPD8NO4IeL7axAlndVp9aQkpswaQQTv5Jn4v2F
	 mmA1oUlz0VL0h5X3FWzrGd4iDQZ3YorosCfuIIHx5ClJTjkGzvjstlhxjj00USmj2ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430709;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HjrZzc6gCuVZJGVM94uiBL9x8kJXAfpl3ojZBi8Ugd8=;
	b=zKEThMZRwdEATXNVfSMFK0ycGmNtoXGfmgbb3Y6UORXfMnO6ya/uhE0RR4lYHAxSw8JT
	 PI5iWqVfryUqFQceK8+tEA3GZxruTJ1CNooIWiu3MTAJVOZ2TPrH56gf/ghcSel+xITr3
	 8kqH8PhEsraDtWEqyEOPurGkAz4QfVF5VBK3D0T7SNXfcx3c6dL3ZVvYjyzJfzDwltVZI
	 iEU8RuK9mL0/+4gQSjCts9w2V+4nSeLXcOJAo6eiQ1VQD9mNvVuNMJhWGbjYYgePYvHv9
	 3MoR2QYEBq3pmhIRNLUG7UfZzfl7pxqE/LwqASk+37zP+cTlJcu85huL660RO6DcwJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aT0XAU0/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FE606A31D
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aT0XAU0/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D551F000C4;
	Mon, 19 Oct 2026 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430708;
	bh=HjrZzc6gCuVZJGVM94uiBL9x8kJXAfpl3ojZBi8Ugd8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aT0XAU0/z5nlmmkdBhgREmCJSVCqLqDGcc+C/Ae8nGRdbVE44KcFgDjuNhW+DVZ66
	 Epnp6yiibsCYYJimbCDNfBv2SOa5vDdvEXYTxIfQ5MxrHyO4ypHGSzRZEqUvCnS0b0
	 /U53+F5/cYusGk9+zKw2nK+SbZDrUtbZVo1WThrayPuhSiqq2wFVmwR/RB9P+c/NY0
	 9FR18xEO6irUA48ctU3gzA6Yhg/hmlvbw7tPp/HFKeVUScWIypEJgsGp9JgsxTSQiO
	 NYzqa7T51sLPd71nI7O8ZL93/UOEGsFgBG50zUZ5n3/QNf5+9bg7HIm50wP/mslza2
	 byyaoO+3VIuqg==
Message-ID: <sashiko-outbox-178023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdul Wasey" <w453y.me@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261019170751.200446-3-w453y.me@gmail.com>
References: <20261019170751.200446-1-w453y.me@gmail.com>
 <20261019170751.200446-3-w453y.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 17:25:07 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: pm: fill_remote_addresses_fullmesh() fails to skip reset =
initial subflow
--

commit 788b7ee55348ab3d2eca027c9a9093fa76b13dc4
Author: Abdul Wasey <w453y.me@gmail.com>

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This commit adds a selftest in mptcp_join.sh to validate deleting and
re-adding the endpoint used by the initial subflow when the fullmesh flag
is set.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..4a7c5f31fc6e2 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4445,6 +4445,36 @@ endpoint_tests()
>  		chk_rm_nr 4 4
>  	fi
> =20
> +	# remove and re-add the endpoint of the initial subflow, with fullmesh
> +	if reset_with_events "delete and re-add, fullmesh" &&
> +	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullme=
sh
> +		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullme=
sh
> +		{ timeout_test=3D120 test_linkfail=3D128 speed=3D5 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=3D$!
> +
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
> +		wait_mpj 1
> +		chk_subflow_nr "before delete id 0" 2
> +
> +		pm_nl_del_endpoint $ns2 1 10.0.1.2
> +		sleep 0.5
> +		chk_subflow_nr "after delete id 0" 1
> +
> +		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullme=
sh
> +		wait_mpj 2
> +		chk_subflow_nr "after re-add id 0" 2

[Severity: Medium]
Does fill_remote_addresses_fullmesh() still fail to skip the initial subflow
when msk->first has been disconnected via tcp_disconnect() and reset via
mptcp_subflow_ctx_reset()?

The preceding commit ("mptcp: pm: in-kernel: fullmesh: skip closed subflows=
")
added subflow->closing checks in fill_remote_addresses_fullmesh() so that
closed subflows are skipped:

net/mptcp/pm_kernel.c:fill_remote_addresses_fullmesh() {
	mptcp_for_each_subflow(msk, subflow) {
		/* The initial subflow stays in the list once closed */
		if (subflow->closing)
			continue;

		if (READ_ONCE(subflow->local_id) =3D=3D local->id)
			__set_bit(subflow->remote_id, unavail_id);
	}

	mptcp_for_each_subflow(msk, subflow) {
		if (subflow->closing)
			continue;

		ssk =3D mptcp_subflow_tcp_sock(subflow);
		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
...
}

In this test, deleting the endpoint while msk->first is in TCP_ESTABLISHED
causes __mptcp_close_ssk() -> __mptcp_subflow_disconnect() to take the
tcp_shutdown() branch, which leaves subflow->closing set to 1.

However, when the initial subflow (msk->first) reaches TCP_CLOSE prior to
__mptcp_close_ssk() (for example, due to a peer RST, peer FIN closure,
timeout, or TCP_SYN_SENT shutdown in mptcp_subflow_shutdown()) and
!dispose_it holds (!msk->free_first && ssk =3D=3D msk->first),
__mptcp_close_ssk() sets subflow->closing =3D 1 and then calls
__mptcp_subflow_disconnect():

net/mptcp/protocol.c:__mptcp_subflow_disconnect() {
	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
	    fastclosing) {
		/* The MPTCP code never wait on the subflow sockets, TCP-level
		 * disconnect should never fail
		 */
		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
		mptcp_subflow_ctx_reset(subflow);
	} else {
		tcp_shutdown(ssk, SEND_SHUTDOWN);
	}
}

Because ssk->sk_state is TCP_CLOSE, tcp_disconnect(ssk, 0) zeroes inet_dport
and inet_daddr, and mptcp_subflow_ctx_reset() is called immediately after:

net/mptcp/protocol.h:mptcp_subflow_ctx_reset() {
	memset(&subflow->reset, 0, sizeof(subflow->reset));
	subflow->request_mptcp =3D 1;
	WRITE_ONCE(subflow->local_id, -1);
}

Since subflow->closing is inside struct_group(reset, ...),
mptcp_subflow_ctx_reset() zeroes subflow->closing back to 0 and zeroes
subflow->remote_id to 0 while setting subflow->local_id to -1.

When fill_remote_addresses_fullmesh() runs afterward (such as when re-adding
an endpoint with the fullmesh flag in
mptcp_pm_create_subflow_or_signal_addr()), checking if (subflow->closing)
evaluates to false for the disconnected msk->first still in msk->conn_list.
The second loop in fill_remote_addresses_fullmesh() then copies the wiped
remote address (port 0, address 0.0.0.0, id 0) from msk->first, sets bit 0
in unavail_id (causing any subsequent active subflow with remote_id 0 in
msk->conn_list to be skipped), and passes the port-0 address to
__mptcp_subflow_connect(), where kernel_connect() fails with -EINVAL.

> +
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		chk_join_nr 2 2 2
> +		chk_rm_nr 1 1
> +	fi
> +
>  	# remove and re-add
>  	if reset_with_events "delete re-add signal" &&
>  	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019170751.2004=
46-1-w453y.me@gmail.com?part=3D2
