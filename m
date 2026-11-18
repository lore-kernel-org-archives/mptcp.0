Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027989;
	b=B5yj5pUrwbRX0t1u4uB9Gm+j+i7YvAd8CWcWfGrY64tb473bPuxZe/QNGsFIz2EHVYan
	 v5fO4/u/iVl+e9aX/pPLiOUo4D/ApzY5apWfE6lo1dheNN5MLQmQISXd3Z4KFmaRSxlaR
	 X3ICPFxPm4AmWRE096HS37Zy5oomKcsBS5NQ7wfCDaeza/0nOXoAHrX3BVxfkNJqlVARo
	 1xGyk5tsyTVvEbjZRi+1U272A+hbuuYoohbySvLJwnHYd75zdbFo8NI8WZZepo+ZRfGRM
	 gKTQt+VjxhUm2pdujzynlj/cXWgcfjzdo33Hv7lr3Ev+02COSuN3/ZJKT6eJWYCZ0tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027989;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FI8eRl5mtLkd7cEuucdrJA4vFNBBpt/klEt5rIO4kZ4=;
	b=GOc5T7rtZ/M6qn5lr4a9bVcRv8JfzHpuzZlKv3rKio79ItVXdj+Wyn307fTN6QnBTXCj
	 36a2NQSwTMmDtAnuZaTkR+/DDKuIcS4j6tdr3saCd1y4h5vWB4P4Ixtif4QvbcliiKetL
	 XdbZHImRuro/sgkEVSBnJqSy4ECc9HfCV4tRI2MF4/6ICqFfedLlylZKQd9aJb8A6jX0k
	 z18S5O31jzQEb5Sb+HnLF5c12E4VCyXa3PR9kiSSdvHAjhloosG4dNIlNtpliD1+IVWXf
	 RSAkgR8GbXqmbefl2fUmj8Bag/NIXQq+w6nILvWQ8g8d03z+mzCy2SquynerjWnTnXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+LgFYyI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF8606A32C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+LgFYyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5F71F000C5;
	Wed, 18 Nov 2026 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795027989;
	bh=FI8eRl5mtLkd7cEuucdrJA4vFNBBpt/klEt5rIO4kZ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D+LgFYyIIApH9Vt1ILHMgKEBHopNWwviSpPT19Ru7sC+WKlbsedFIbWE46/e3HdXh
	 HC9ByxrcvoLg6o3B079QWFPC3tP2EY39XTlH0CvVhT0KK6sV01AkDdKgrS8F2iUMM0
	 pkwCBUtcZuD9Wv9XcHHOgStZKsv1k6Q7fRcvqXZKsraanu8ided+B9wZhuDdl1aOgo
	 HsD1tvY9fyC+IrsDxUN2oyknLz9Df1uklzyPQHzZhd02a5s1+/4DUw49v5nUzsmt5u
	 ySjcI/6YRU0UvEkgDftDpOgIRz7cU1CJZLEDyc9aProvUJmQzQmmCiD4/bVuEZTj+Z
	 m8s664lE7u0SQ==
Subject:
 Re: [PATCH mptcp-net v13] mptcp: hide sequence numbers in Netlink diagnostics
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, kuba@kernel.org
Date: Wed, 18 Nov 2026 18:53:08 +0000
Message-ID: <179502798858.3133.4822986587776409521@kernel.org>
In-Reply-To: <20261117050804.134954-1-kalpan.jani@mpiricsoftware.com>
References: <20261117050804.134954-1-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/mptcp/mptcp_diag.c, mptcp_diag_get_info() now always
  sets mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt to 0 in…
- [Medium] The new 'chk dump_one zero sequence fields' subtest in
  tools/testing/selftests/net/mptcp/diag.sh:chk_dump_one() hard-FAILs…
- [Low] The commit message does not say who the change protects against
  or what users will see change.
- [Low] diag.sh:chk_dump_one() calls `ip netns exec "$ns" ./mptcp_diag -z
  -t "$ss_token"` with no stdout redirect, between mptcp_lib_print_title…
- [Low] struct mptcp_info (include/uapi/linux/mptcp.h) is a single uAPI
  object with two producers that now disagree.

--

mptcp: hide sequence numbers in Netlink diagnostics

This commit zeroes mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in
the MPTCP sock_diag INET_DIAG_INFO reply. The getsockopt() interface is
left unchanged. The mptcp_diag selftest helper gets a -z mode, and diag.sh
gets a subtest that checks these fields are zero.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> MPTCP Netlink diagnostics expose sequence numbers that can reveal
> internal connection state.

[Severity: Low]
This isn't a bug, but could the commit message say who this change
protects against? For example, unprivileged users in the same netns
reading data-level sequence numbers of other users' MPTCP sockets through
sock_diag.

The message also doesn't say that these three fields become 0 over
netlink for every requester, including root and tools like ss -M. It only
says getsockopt() is unchanged.

The Fixes: tag means this user-visible change will go to stable. With the
current wording, it is hard for backporters to judge its impact or to
weigh it against CAP_NET_ADMIN gating.

> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0eeb..fe1603ce80162 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -215,6 +215,10 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
>  		return;
>  
>  	mptcp_diag_fill_info(msk, info);
> +
> +	info->mptcpi_write_seq = 0;
> +	info->mptcpi_snd_una = 0;
> +	info->mptcpi_rcv_nxt = 0;

[Severity: Medium]
Does this also hide the values from CAP_NET_ADMIN callers? The fields are
cleared in mptcp_diag_get_info() for every sock_diag requester. Root
running ss -M -i, or a monitoring daemon, now always gets 0 where it used
to get the real msk-level data sequence values.

The subflow side of the same reply family already uses a different rule:

net/mptcp/diag.c:subflow_get_info() {
	...
	/* Only export seq related counters to user with CAP_NET_ADMIN */
	if (net_admin &&
	    (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
			 sf->rel_write_seq) ||
	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
	...
}

The privilege bit is already in scope. mptcp_diag_dump_one() passes
netlink_net_capable(in_skb, CAP_NET_ADMIN) into inet_sk_diag_fill(), but
inet_sk_diag_fill() only hands it to idiag_get_aux():

net/ipv4/inet_diag.c:inet_sk_diag_fill() {
	...
	handler->idiag_get_info(sk, r, info);

	if (ext & (1 << (INET_DIAG_INFO - 1)) && handler->idiag_get_aux)
		if (handler->idiag_get_aux(sk, net_admin, skb) < 0)
	...
}

If the concern is unprivileged readers, would it fit better to gate these
fields on net_admin, as the subflow attributes are?

If the concern is all readers, a privileged user still receives
MPTCP_SUBFLOW_ATTR_MAP_SEQ, which is in the same data sequence space. Is
the hiding complete in that case?

The new selftest runs as root and requires zeros, so it would lock in the
unconditional behaviour. The Fixes: tag also carries this into stable.

[Severity: Low]
Is it intended that struct mptcp_info now has two producers that disagree?
getsockopt(MPTCP_INFO) and getsockopt(MPTCP_FULL_INFO) go through
mptcp_diag_fill_info() in net/mptcp/sockopt.c and still report the real
values:

	info->mptcpi_write_seq = msk->write_seq;
	...
	info->mptcpi_snd_una = msk->snd_una;
	info->mptcpi_rcv_nxt = msk->ack_seq;

INET_DIAG_INFO now always reports 0 for the same fields. Nothing in
include/uapi/linux/mptcp.h or in mptcpi_flags marks the values as
suppressed.

How would a netlink consumer tell a hidden value from a real 0? A
TCP_LISTEN msk, for example, really does report 0, because
mptcp_diag_fill_info() returns right after the memset(). The in-tree
print_info_msg() also still prints these fields as if they were real.

Should the per-interface meaning of these fields be documented?

>  }

[ ... ]

> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 27cbda68144e8..abe732a5c1c37 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh

[ ... ]

> @@ -223,6 +224,18 @@ chk_dump_one()
>  		mptcp_lib_result_fail "${msg}"
>  		ret=${KSFT_FAIL}
>  	fi
> +
> +	zero_msg="....chk dump_one zero sequence fields"
> +	mptcp_lib_print_title "$zero_msg"
> +	if [ -n "$ss_token" ] &&
> +	   ip netns exec "$ns" ./mptcp_diag -z -t "$ss_token"; then

[Severity: Low]
Should stdout be redirected here? Even in -z mode, parse_nlmsg() in
mptcp_diag.c prints the full info block before it runs the check:

		print_info_msg(info);
		if (check_zero) {

This puts about 30 lines of info output between the title and the result
marker. The other two mptcp_diag call sites in chk_dump_one() and
chk_dump_subflow() pipe the output through awk or grep.

The failure text "MPTCP diagnostic sequence fields are not zero" is also
printed for every failure of this condition. That includes an empty
$ss_token, where the tool never runs.

It also covers the other non-zero exits this patch adds to the tool:
a recvmsg error, "Empty Netlink response", "Netlink dump failed",
"Netlink request failed" and "No MPTCP diagnostic info received". Could
the message be made more generic?

> +		mptcp_lib_pr_ok
> +		mptcp_lib_result_pass "${zero_msg}"
> +	else
> +		mptcp_lib_pr_fail "MPTCP diagnostic sequence fields are not zero"
> +		mptcp_lib_result_fail "${zero_msg}"
> +		ret=${KSFT_FAIL}
> +	fi

[Severity: Medium]
Will this subtest fail outright on kernels without this change?

On an older or stable kernel, mptcp_diag -z sees non-zero write_seq,
snd_una and rcv_nxt. check_zero_seq() then returns false, the tool calls
exit(EXIT_FAILURE), and this branch sets ret=${KSFT_FAIL}.

__chk_nr() in the same file handles unsupported features like this:

		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
			mptcp_lib_pr_skip "Feature probably not supported"

Should this subtest report a skip in the same way when
mptcp_lib_expect_all_features is false?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117050804.134954-1-kalpan.jani%40mpiricsoftware.com
