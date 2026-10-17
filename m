Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C492345EB0
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792271238; cv=none; b=pKw7Gt2C2ZIu8ShauZjZJQ7/L7xQCMQXu1IcbPso/rEC5QLJXlzMg7tzvJ4s1oMT3ePRCMjB28uOJM2F7kW0590ElyF20gf5AMKKKv83A6okP31NVhlAOrA090pYoHUOBXpzB64bi6PoFLQTdTVEF1vWUsFiwg14dCe4Q6kBmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792271238; c=relaxed/simple;
	bh=5qkMLd4bOYRSCAxZoh9AGkh17Tfh6N/353hR8v0YrVI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o/VFE+gEJCp3JOUPJEMq+2ihLejHsTrkVKZV7Pod/1jIUB31NQXpQS9WhsFBz7/iVSspNB6FxXdZu6fSdZkvKy2++0FlVtDrMIHwbTSmzxq7mosxEFZrvPSRSx5MeSyLtUOp74N58OP0lhtICJRcz5Flic3ivcZgWe9+8eD2XdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhUUOrf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhUUOrf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0FA1F000C5;
	Sat, 17 Oct 2026 21:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792271237;
	bh=FANVrAEbidWjRNBbSg1s6us0MzuseJa23mU7o5X2yTY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EhUUOrf7g4SToAI7kpUdN96edU+YOIR5NI5kGE+AMOfbPI/V3Qev2DQN/hq/UT6VJ
	 TukJckEAz6Iyr3EN4/bKIceXY9fLOHFraEXMjJWcbYxsmqst4MtSdNtPn5H/bPky5Q
	 +87frFs5fOCTK6pnihaJ90ipAN7e+Fuu2agFbXZz9wFY3wNN90TxNLdaow8RIjQU2n
	 4OhTSkpzsUj9lzSje/UkofM3JfiztjoalNEdceYj1ne5Xnu3IT+qISqEPNrIy3r2Wq
	 wyV1O2Je8DYuNlde3dRRi+7UskCxsAE/ri8VgIWOdsqNWORcGijsKfwblXKl5vHDol
	 VJiQGRk2NQgvg==
Subject: Re: [PATCH mptcp-next v4 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 17 Oct 2026 21:07:16 +0000
Message-ID: <179227123648.3133.5320047924383519432@kernel.org>
In-Reply-To: <20261016055010.980819-3-anilkaushikwireless@gmail.com>
References: <20261016055010.980819-3-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In __mptcp_close_subflow(), mptcp_close_ssk() first calls
  mptcp_pm_subflow_check_next().
- [Low] The new uAPI attribute is documented as "SYN retransmissions of a
  subflow re-created after an error", and the commit message says "Their…
- [Low] The in-tree pm_nl_ctl tool and pm_netlink.sh were not updated for
  MPTCP_PM_ATTR_SUBFLOW_RETRIES.
- [Low] Subsystem guide violation (netlink.md, 'Validation policy':
  "Declaring the right attribute validation policy is strongly preferred…
- [Low] mptcp_pm_rm_addr_or_subflow() skips subflows already in
  TCP_CLOSE: `if ((1 << inet_sk_state_load(ssk)) & (... | TCPF_CLOSE))…
- [Low] __mptcp_close_subflow() also passes TCP_CLOSE_WAIT subflows (msk
  ESTABLISHED, no fallback) to mptcp_pm_kernel_retry_check().

--

mptcp: pm: kernel: retry subflows closed after an error

With the in-kernel PM, this re-creates a locally initiated subflow with
the same addresses when TCP closes it after an error. A new netlink
limit, subflow-retries (default 15, 0 disables it), sets the SYN retries
of the re-created subflow. Subflows refused by the peer, reset by an
MP_RST without the T flag, aborted locally, or whose endpoint was removed
are not retried.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index 39f3facc38e55..1b481908980cc 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -196,6 +196,12 @@ attribute-sets:
>          name: addr-remote
>          type: nest
>          nested-attributes: address
> +      -
> +        name: subflow-retries
> +        type: u32
> +        doc: |
> +          SYN retransmissions of a subflow re-created after an error, 0 to
> +          not re-create it.

[Severity: Low]
Is this description exact? The commit message also says "Their number
is set by a new limit".

mptcp_pm_kernel_retry() writes the value unchanged into icsk_syn_retries.
For SYN_SENT, tcp_write_timeout() then adds the linear timeouts:

net/ipv4/tcp_timer.c:tcp_write_timeout() {
    ...
		max_retransmits = retry_until;
		if (sk->sk_state == TCP_SYN_SENT)
			max_retransmits += READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts);
    ...
}

There is also a time-based limit in retransmits_timed_out(). With the
default tcp_syn_linear_timeouts of 4, a value of 15 can allow up to 19
SYN retransmissions.

The value works like TCP_SYNCNT, not like an exact retransmission count.
This attribute becomes uAPI once released. Could the doc describe it
that way?

[ ... ]

> diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
> index c180930a8e0e4..127a1fadaac40 100644
> --- a/net/mptcp/mptcp_pm_gen.c
> +++ b/net/mptcp/mptcp_pm_gen.c
> @@ -44,15 +44,17 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
>  };
>  
>  /* MPTCP_PM_CMD_SET_LIMITS - do */
> -const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
> +const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
>  	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
> +	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = { .type = NLA_U32, },
>  };

[Severity: Low]
Could this bound go in the policy instead of being checked by hand? The
accepted range 0..127 is only enforced in mptcp_pm_nl_set_limits_doit():

	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOW_RETRIES, &retries,
			  MAX_TCP_SYNCNT);

The netlink guidelines prefer a declared validation policy over
open-coded checks. Adding "checks: max: 127" to subflow-retries in
mptcp_pm.yaml would generate NLA_POLICY_MAX(NLA_U32, 127). The bound
would then also show up in policy introspection.

[ ... ]

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..6c081a9c664c0 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c

[ ... ]

> @@ -1464,6 +1474,10 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
>  			READ_ONCE(pernet->limit_extra_subflows)))
>  		goto fail;
>  
> +	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
> +			READ_ONCE(pernet->limit_subflow_retries)))
> +		goto fail;
> +

[Severity: Low]
Should pm_nl_ctl and pm_netlink.sh be updated for the new attribute?
print_limits() in tools/testing/selftests/net/mptcp/pm_nl_ctl.c still
drops it:

			if (type != MPTCP_PM_ATTR_RCV_ADD_ADDRS &&
			    type != MPTCP_PM_ATTR_SUBFLOWS)
				goto next;

get_set_limits() also only sends the two older limits.

Because of this, the "defaults limits" check in pm_netlink.sh still
passes even if the new default were wrong or missing from the reply:

	check "get_limits" "$(format_limits 0 2)" "defaults limits"

The set path is never tested, including 0 to disable the feature and
the 127 upper bound. The mptcp_join.sh test in the series only covers
the default value implicitly.

[ ... ]

> @@ -1591,6 +1605,125 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)

[ ... ]

> +/* Called with the msk socket lock held, before the subflow is closed */
> +bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
> +				 const struct mptcp_subflow_context *subflow,
> +				 struct mptcp_pm_retry *retry)
> +{
> +	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	bool established = READ_ONCE(subflow->fully_established);
> +	struct sock *sk = (struct sock *)msk;
> +	int err = READ_ONCE(ssk->sk_err);

[ ... ]

> +	/* The peer asked not to use this path again (MP_RST without the T
> +	 * flag), the subflow has been aborted locally, or it hit an MPTCP
> +	 * protocol error.
> +	 */
> +	if ((subflow->reset_seen && !subflow->reset_transient) ||
> +	    err == ECONNABORTED || err == EBADMSG)
> +		return false;

[Severity: Low]
Can these reads see a new sk_err with stale reset bits?

__mptcp_close_subflow() also passes TCP_CLOSE_WAIT subflows to this
check when the msk is ESTABLISHED and there is no fallback. Those
subflows are still live, and only the msk socket lock is held. An RST
carrying an MP_RST can be processed at the same time in softirq:

  mptcp_worker                       softirq, RST + MP_RST (T=0)
  __mptcp_close_subflow()
    ssk_state == TCP_CLOSE_WAIT
                                     tcp_reset()
                                       mptcp_incoming_options()
                                         subflow->reset_seen = 1;
                                         subflow->reset_transient = 0;
                                       tcp_done_with_error()
                                         sk_err = EPIPE
    mptcp_pm_kernel_retry_check()
      err = READ_ONCE(ssk->sk_err);   /* EPIPE */
      subflow->reset_seen             /* may still read 0 */

There is no barrier between the plain reset bit stores and the sk_err
store. The reader also has no acquire or smp_rmb() between its sk_err
read and the bitfield reads.

For a fully established subflow the check would then return true. The
kernel would re-create a subflow that the peer reset with an MP_RST
without the T flag. The do_retry result is also cached and not checked
again after mptcp_close_ssk().

In the TCP_CLOSE branch the reads look ordered, because the
inet_sk_state_load() acquire pairs with the release in tcp_set_state().
Should the retry only be considered for subflows in TCP_CLOSE, or should
these reads be ordered some other way?

[ ... ]

> +	/* not if its endpoint has been removed */
> +	id = subflow_get_local_id(subflow);
> +	if (id) {
> +		rcu_read_lock();
> +		endp_found = !!__lookup_addr_by_id(pernet, id);
> +		rcu_read_unlock();
> +		if (!endp_found)
> +			return false;
> +	}

[Severity: Low]
Does this cover a remote address withdrawn by RM_ADDR, or a removed
local id 0?

mptcp_pm_rm_addr_or_subflow() skips subflows that are already closed:

			if ((1 << inet_sk_state_load(ssk)) &
			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
				continue;

Such a subflow keeps close_event_done == false and is collected later by
__mptcp_close_subflow(). That can be delayed while its sk_receive_queue
is not empty. mptcp_worker() also runs mptcp_pm_worker() before
__mptcp_close_subflow().

So a locally initiated subflow can fail with ETIMEDOUT, and an RM_ADDR
for its remote id can be processed before the close is collected. In
that case this function still returns true, since nothing checks
whether the remote address was withdrawn. The new subflow can then hold
an extra_subflows slot for the whole SYN budget of about 20 minutes.

Local id 0 behaves the same way. mptcp_nl_remove_id_zero_address() calls
mptcp_pm_rm_subflow(), which also skips TCP_CLOSE subflows, and then
__mark_subflow_endp_available(msk, 0). Here the lookup is skipped when
id == 0, so the initial subflow can be re-created from an id 0 address
that was explicitly removed.

The commit message says subflows "whose endpoint has been removed are
not retried". Should these two cases be handled as well?

[ ... ]

> +/* Called with the msk socket lock held, after the subflow has been closed */
> +void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
> +			   const struct mptcp_pm_retry *retry)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	struct sock *ssk;
> +	bool allowed;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	allowed = msk->pm.extra_subflows <
> +		  mptcp_pm_get_limit_extra_subflows(msk);
> +	if (allowed)
> +		msk->pm.extra_subflows++;
> +	spin_unlock_bh(&msk->pm.lock);

[Severity: Medium]
Does this take back the slot that mptcp_close_ssk() just freed for the
next endpoint?

In __mptcp_close_subflow(), the close happens first:

__mptcp_close_subflow()
  mptcp_close_ssk()
    mptcp_pm_subflow_check_next()
      __mptcp_pm_close_subflow(msk)      /* extra_subflows-- */
      mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED)
  mptcp_pm_subflow_retry()
    mptcp_pm_kernel_retry()              /* extra_subflows++ */

The check_next step is there so that a "subflow aborted before reaching
the fully_established status" lets the PM try the next one. A
never-established subflow that failed with ETIMEDOUT passes the retry
check. The same failing local/remote pair then gets the slot again.

When the PM worker later runs mptcp_pm_create_subflow_or_signal_addr(),
the limit check fails again, so the next endpoint is not tried:

	while (msk->pm.local_addr_used < endp_subflow_max &&
	       msk->pm.extra_subflows < limit_extra_subflows) {

For example, take limit subflows=1 with two subflow endpoints, where the
first path silently drops MP_JOIN SYNs. Before this patch, the PM moved
to the second endpoint after about 2 minutes of SYN timeouts. With the
default set in pm_nl_init_net():

	pernet->limit_subflow_retries = 15;

it first spends about 20 more minutes on the same failing endpoint.

Is this change in endpoint selection intended? The commit message does
not mention it, and the feature is on by default.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016055010.980819-1-anilkaushikwireless%40gmail.com
