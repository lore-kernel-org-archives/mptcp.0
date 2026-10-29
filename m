Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317139;
	b=x3Ddi8mlGWaIxF3+0tl06P+7VXGPO0S3QMl1ZFxew8FdxTziFDkBGm0z2OwGvn9jME0l
	 keP21rX9IA8xfgipY2Rj1unMkJrIOeWAHwACAIHNN7KzA/FSHG4uJMaWSEhTGwNpimXDB
	 zp+2oWGGtj1ZLckJkCjGCrgDGiG1tDJQnGsX1jZKEGf6cucSI66W1rF3TOuAeGVd0ovYH
	 3YnENPOSwTXpyWL/Q8vL13dJr22jXHkYa9QbR1fzOO2M6jNX62LnXdr7Ei5UA+O9LYc39
	 rj0kugbJOFYtUNrmH0sMvlgbZVM8/xt8QNdBlGZvmjXJmbJXHkBqWtw9YO7bg2JAkUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jvsGxSyWij+D8hxDHCuP9RmfDfn9v4vNR/Yeu00zg8M=;
	b=WlhT1TpnrOx7z8AdbVJyL37KeJlM+bGEAIonsmnnszpzBX95BF+sPcva+ZwlZQY+WURc
	 4L4gFligXIUzte/Ijmf7ixe20+WW766aOktNXH5zLO/UMFrF+sE86zBks39nl+x7Xji5e
	 fvvaqz/QjrxXYxiVXCIIqP+JUSLF9/PYzBtvUpHCwDEZcASAYNQrS2PRljSJpNWE2HE+A
	 TfxqWJdKb5w8TtidXvd9gdQzNr7xIikrBghZu1O7jKC/3eyicC1KnJswqxdK1eZneWYs2
	 zIIdbjvCZ0YeAklS+FgcFtD9eOz8+mizpjolhWEE75WdIQKhODNgxwfEDMfyr3oIgQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCFylUHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDEA606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCFylUHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAA31F000C1;
	Thu, 29 Oct 2026 23:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793317138;
	bh=jvsGxSyWij+D8hxDHCuP9RmfDfn9v4vNR/Yeu00zg8M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eCFylUHdjsgtfHs3TSWCFsuDlkJ4x+zGhJr2I/HMJp1f02INWjiYI7kwdyaPkpqcN
	 wm/OuQuiPql1RrBmbQkFiZ8aQWskW7W03QbkHZFdRUcykr+RUSXap1a5mCWkZniQSO
	 6H1wS8B2ySue3VpD4czMfiY0Sdfx8bQBvFkSFO2pvmNQj2B8+OneZwiyKjpKZtPj1c
	 H8fGkKEXNzW8DfL5+O9hMvRT0+0V6lbcEMRzvvuZG2QEN3TUJEzLCCMZzor9f494T2
	 DqqrUgHXAnv2wfafGRJKKgdVImaYDr9ms+nd6Odm6swbVGu+14gvocVwNZKXhkfvAW
	 w7Hg1k0TYBRYQ==
Message-ID: <sashiko-outbox-190117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: reject MP_JOIN earlier
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-2-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
 <20261030-mptcp-reset-mpj-early-v2-2-90f119392263@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 23:38:57 +0000
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
- [Medium] selftests: mptcp: handle simultaneous MP_JOIN race in chk_join_n=
r()
--

commit a8174c281034f9fecaa480fc2e253d29198241eb
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: reject MP_JOIN earlier

This commit moves the mptcp_can_accept_new_subflow() check to
subflow_token_join_request() so disallowed MP_JOIN requests are rejected
upon receiving the SYN, tracked by a new MPJoinDisallowed MIB counter, and
updates the mptcp_join.sh selftest accordingly.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..308fad861afc1 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -1617,10 +1619,21 @@ chk_join_nr()
>  	if [ -z "$count" ]; then
>  		rc=3D${KSFT_SKIP}
>  	elif [ "$count" !=3D "$syn_ack_nr" ]; then
> +		# support old kernels without MPTcpExtMPJoinDisallowed counter:
> +		# =3D> connections are rejected later on (MPTcpExtMPJoinRejected)
> +		if [ "${disallowed}" -gt 0 ] &&
> +		   ! mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinDisallowed" >/dev/nul=
l; then
> +			syn_rej=3D$((syn_rej + disallowed))
> +			syn_ack_nr=3D$((syn_ack_nr + disallowed))
> +		fi
> +
>  		# simult connections exceeding the limit with cookie enabled could go =
up to
>  		# synack validation as the conn limit can be enforced reliably only af=
ter
>  		# the subflow creation
> -		if [ "$with_cookie" !=3D 2 ] || [ "$count" -le "$syn_ack_nr" ] || [ "$=
count" -gt "$syn_nr" ]; then
> +		if [ "$count" !=3D "$syn_ack_nr" ] && {
> +		     [ "$with_cookie" !=3D 2 ] ||
> +		     [ "$count" -le "$syn_ack_nr" ] ||
> +		     [ "$count" -gt "$syn_nr" ]; }; then
>  			rc=3D${KSFT_FAIL}
>  			print_check "synack rx"
>  			fail_test "got $count JOIN[s] synack rx expected $syn_ack_nr"
> @@ -1658,9 +1671,18 @@ chk_join_nr()
>  	if [ -z "$count" ]; then
>  		: # ignore skip
>  	elif [ "$count" !=3D "$syn_rej" ]; then
> -		rc=3D${KSFT_FAIL}
> -		print_check "syn rejected"
> -		fail_test "got $count JOIN[s] syn rejected expected $syn_rej"
> +		# support old kernels without MPTcpExtMPJoinDisallowed counter:
> +		# =3D> with syncookies, the MPJoinRejected was incremented instead
> +		if [ "$with_cookie" =3D 2 ] && [ "${disallowed}" -gt 0 ] &&
> +		   ! mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinDisallowed" >/dev/nul=
l; then
> +			syn_rej=3D$((syn_rej + disallowed))
> +		fi
> +
> +		if [ "$count" !=3D "$syn_rej" ]; then
> +			rc=3D${KSFT_FAIL}
> +			print_check "syn rejected"
> +			fail_test "got $count JOIN[s] syn rejected expected $syn_rej"
> +		fi
>  	fi
> =20
>  	# Per-event MPTCP_RST_EMPTCP JOIN counters; default 0, gated on
> @@ -1701,6 +1723,13 @@ chk_join_nr()
>  		fail_test "got $count JOIN[s] no id found expected $no_id_found"
>  	fi
> =20
> +	count=3D$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinDisallowed")
> +	if [ -n "$count" ] && [ "$count" !=3D "$disallowed" ]; then
> +		rc=3D${KSFT_FAIL}
> +		print_check "join disallowed"
> +		fail_test "got $count JOIN[s] disallowed expected $disallowed"
> +	fi

[Severity: Medium]
Can simultaneous MP_JOIN attempts cause false failures in chk_join_nr() now
that subflow_token_join_request() checks mptcp_can_accept_new_subflow() on
SYN reception for both syncookie and non-syncookie cases, and uses a separa=
te
counter from 3rd-ACK rejection?

In tests like "multiple subflows, limited by server" in subflows_tests() and
"subflows limited by server w cookies" in syncookies_tests(), the client
initiates two subflows back-to-back in
mptcp_pm_create_subflow_or_signal_addr(). On the server,
msk->pm.accept_subflow is only cleared when the first subflow completes its
3WHS in subflow_syn_recv_sock() -> mptcp_finish_join() ->
mptcp_pm_allow_new_subflow().

If the second MP_JOIN SYN arrives before the first subflow's third ACK is
processed, mptcp_can_accept_new_subflow() in subflow_token_join_request()
still returns true. The server then sends a SYN+ACK for the second subflow
and rejects it later on the third ACK in mptcp_finish_join(), incrementing
MPTcpExtMPJoinRejected instead of MPTcpExtMPJoinDisallowed.

In chk_join_nr(), the allowance for receiving more SYN+ACKs than syn_ack_nr
is still restricted to with_cookie =3D=3D 2, even though the same SYN-time =
race
now applies without syncookies. In addition, when an extra SYN+ACK is sent
due to this race, MPTcpExtMPJoinRejected increases and
MPTcpExtMPJoinDisallowed decreases by (count - syn_ack_nr), but syn_rej and
disallowed are not adjusted accordingly before checking those two counters.

Should chk_join_nr() allow count up to syn_nr whenever disallowed > 0 (not
only when with_cookie =3D=3D 2), and shift the extra (count - syn_ack_nr) f=
rom
disallowed to syn_rej when that race occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-mptcp-rese=
t-mpj-early-v2-0-90f119392263@kernel.org?part=3D2
