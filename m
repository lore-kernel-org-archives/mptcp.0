Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454953;
	b=AG80e7/UXGuV0/t8OzZJy81VBQFU1s20I6p4hNCSRtSlGBofrcRfbG3MrYJBdc97r9T3
	 +JL+C3U6odfK1RbhVegWe+EfwG62uAjh++fWMjwtzoP/A86xk7ElkUMBtKkhImX3Tq8or
	 qGIFbqTL0Q5mdZnDlWB0Tc3+2Yc3jnLur6bGZCt17lpj9p5Hmz6jyklDgDHRmGduDoskO
	 XMtKVj4RR63yQBZ4WlFYfCWctEqBgN+PjGqUz2ZCvRQ9G7r2zr6dpLpkHn1AbRu4+c8Le
	 TG7xn6loGjEE1XrQYQnSvhxEgQJG22uQUY0cRNTQLwoaymbOCbd6yam8edb1iH+9jew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454953;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=f+zXsjqZ96n5vK3ls94S3LEaJ3ZIA53BarVlhLdvpp4=;
	b=XTVCyjKB24Yb2XfVlxBctshcGtpcNh7p23aQ3DOl1+gAj1zVi3DpLt2aVZ8vGJnaCiI+
	 /ofGlYyfKKMjaOYgQyferKHogyH2l4shLSiYxzAeubb3AmrSzw/dnGqX2d6bcPL54zdkv
	 lxZbsExKxRvDMatm4sEhXmp651DRpZA3o9WEMJ1l/oVg/1hppPFu25oxQBI4W8e0aD/By
	 OLmUae2gXGFiF1NhA9MrQPrKlVpNPlb+73IRekCVVF38Hf9RUvHQEysO8hDhJd7PTgJ5a
	 j9IrJhWU2zucYlSJOVr4Ej0Hw7ECaznhLEClIHO3o6kRYELr1F5qnoE4+X3GcATQkKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i22QkXJG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F7606A32D
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i22QkXJG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6352B1F000C1;
	Sat, 31 Oct 2026 13:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454952;
	bh=f+zXsjqZ96n5vK3ls94S3LEaJ3ZIA53BarVlhLdvpp4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i22QkXJGIwj3jKE+K62FU9heVSz1SKMAzyaKTUFTfEH/+IoVvD0Qin/cDQc99SvRD
	 +Hp63QK7LSbXAXAnv5yNFjQbeVQS9MJNpBYIXdM2pP33co2GD9wvuGTVV/Io+y9lh8
	 v7659e9OyCgrNJrB59sFSzmFeyiyj42nGilJKugOydx3F4wMSQbSUNYwAuJhv1TnKE
	 wjQg85WHLan5iSEEJQZ1Uw4OzUPa28eSLz5AtaVEB1zValQ+L8n64KyzKAp8MSQz11
	 J2JuzvQOsQ1h0+DlMY0IPvyntKPqpeyE6S/9rPcuIZSAu7XrKs4oYWuEUAW/slFslA
	 57I/SXn7WmWJw==
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: reject MP_JOIN earlier
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, chenguang.zhao@linux.dev,
 gang.yan@linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 13:55:51 +0000
Message-ID: <179345495186.3128.17914960473551818732@kernel.org>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-2-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-2-90f119392263@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The early MP_JOIN reject in subflow_token_join_request()
  (net/mptcp/subflow.c:134-143) is racy, as its own comment says.
- [Low] chk_join_nr() checks for the new MPTcpExtMPJoinDisallowed counter
  with `!
- [Low] The new early check in subflow_token_join_request() uses
  mptcp_can_accept_new_subflow() (net/mptcp/subflow.c:96-102).

--

mptcp: reject MP_JOIN earlier

This patch moves the mptcp_can_accept_new_subflow() check to SYN time in
subflow_token_join_request(). Disallowed MP_JOIN requests are now reset
before the 3-way handshake completes, and a new MPJoinDisallowed MIB counter
counts them. The mptcp_join.sh selftests are updated to expect the new
counter, with fallbacks for older kernels.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..f9785e20e2097 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -126,12 +127,25 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
>  	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
>  	if (!msk) {
>  		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
> +		*reason = MPTCP_RST_EMPTCP;
> +		return NULL;
> +	}
> +
> +	/* Stop it early if the subflow cannot be accepted.
> +	 * This check is inherently racy, the consistency safeguard is given by
> +	 * the fallback check at finish_join time.
> +	 */
> +	if (!mptcp_can_accept_new_subflow(msk)) {
> +		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINDISALLOWED);
> +		*reason = MPTCP_RST_EPROHIBIT;
> +		sock_put((struct sock *)msk);
>  		return NULL;
>  	}

[Severity: Low]

Does this early check catch joins that msk->allow_subflows already
prohibits?

mptcp_can_accept_new_subflow() only checks the fully established state and
the PM condition:

static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
{
	return mptcp_is_fully_established((void *)msk) &&
		((mptcp_pm_is_userspace(msk) &&
		  mptcp_userspace_pm_active(msk)) ||
		 READ_ONCE(msk->pm.accept_subflow));
}

Two places clear msk->allow_subflows without clearing fully_established:
mptcp_subflow_fail() on a local checksum failure on the initial subflow,
and mptcp_pm_mp_fail_received() when the peer sends MP_FAIL. This happens
while the infinite fallback is still pending.

An MP_JOIN SYN that arrives in that window passes this check and gets a
SYN-ACK. The late check in subflow_syn_recv_sock() also passes.
mptcp_finish_join() then goes through mptcp_pm_allow_new_subflow(), and
only then does __mptcp_finish_join() reject the join:

	if (!msk->allow_subflows) {
		spin_unlock_bh(&msk->fallback_lock);
		return false;
	}

Isn't this the case the commit message says it avoids ("the 3WHS is done,
then the joined subflow is rejected")? Here it is not a race, and
MPJoinDisallowed is not incremented either.

Would also checking READ_ONCE(msk->allow_subflows) here close that gap?

[ ... ]

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..308fad861afc1 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -1617,10 +1619,21 @@ chk_join_nr()
>  	if [ -z "$count" ]; then
>  		rc=${KSFT_SKIP}
>  	elif [ "$count" != "$syn_ack_nr" ]; then
> +		# support old kernels without MPTcpExtMPJoinDisallowed counter:
> +		# => connections are rejected later on (MPTcpExtMPJoinRejected)
> +		if [ "${disallowed}" -gt 0 ] &&
> +		   ! mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinDisallowed" >/dev/null; then

[Severity: Low]

What happens here when SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1 and the
counter is missing?

The other mptcp_lib_get_counter() calls in chk_join_nr() run inside $(...).
This one runs directly in the current shell. If the counter is not found,
mptcp_lib_get_counter() calls this helper:

mptcp_lib_fail_if_expected_feature() {
	if mptcp_lib_expect_all_features; then
		echo "ERROR: missing feature: ${*}"
		exit ${KSFT_FAIL}
	fi

	return 1
}

The exit ends the whole mptcp_join.sh run, and the only error message goes
to /dev/null. The exit code is still KSFT_FAIL. However, the run stops in
the middle of a test with no message, the remaining subtests never run, and
there is no TAP summary.

The "syn rejected" block further down uses the same pattern.

> +			syn_rej=$((syn_rej + disallowed))
> +			syn_ack_nr=$((syn_ack_nr + disallowed))
> +		fi

[ ... ]

> @@ -2210,8 +2239,8 @@ subflows_tests()
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>  		run_tests $ns1 $ns2 10.0.1.1
> -		join_syn_rej=1 \
> -			chk_join_nr 2 2 1
> +		join_disallowed=1 \
> +			chk_join_nr 2 1 1
>  	fi

[Severity: Medium]

Can this test get these counts reliably? The comment in
subflow_token_join_request() says the early check is racy. This test now
requires exactly one SYN-ACK, MPJoinRejected=0 and MPJoinDisallowed=1.

On the client, mptcp_pm_create_subflow_or_signal_addr() sends both MP_JOIN
SYNs back-to-back:

	for (i = 0; i < nr; i++)
		__mptcp_subflow_connect(sk, &local, &addrs[i]);

On the server, pm.accept_subflow only becomes false after the third ACK of
the first join has been processed:

mptcp_finish_join()
  mptcp_pm_allow_new_subflow()
    if (ret && ++pm->extra_subflows == limit_extra_subflows)
        WRITE_ONCE(pm->accept_subflow, false);

SYN2 can be processed before ACK1, for example with deferred softirqs, RPS,
or a loaded or debug CI machine. SYN2 then passes the early check and gets a
SYN-ACK.

It is then rejected late, in subflow_syn_recv_sock() or
mptcp_finish_join(). Both paths increment MPTCP_MIB_JOINREJECTED, not
MPTCP_MIB_MPJOINDISALLOWED. The counters end up as synack=2,
MPJoinRejected=1 and MPJoinDisallowed=0.

Without syncookies, chk_join_nr() then fails on "synack rx". The old-kernel
adjustment is skipped because MPTcpExtMPJoinDisallowed exists. It also
fails on "syn rejected" and "join disallowed".

The "subflows limited by server w cookies" case in syncookies_tests() has
the same problem. The extra SYN-ACK is still tolerated there, but
"syn rejected" and "join disallowed" fail.

Before this patch, the non-cookie variant was deterministic because there
was no SYN-time check. The cookie variant survived the race because early
and late rejects both counted MPJoinRejected. Commit e35f885b357d
("selftests: mptcp: be more conservative with cookie MPJ limits") was added
because this race made the cookie variant fail sporadically.

Later patches in the series don't seem to touch mptcp_join.sh.

Should these two cases also accept the late reject path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030-mptcp-reset-mpj-early-v2-0-90f119392263%40kernel.org
