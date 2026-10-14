Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28CB640
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938124; cv=none; b=kaIz8BKUoKaBQXmAeE7Jwd7O/09LZSdtBVCxTzpSg/UTwb0VDqushYU7lk3Kp8quZ+l3IQuAvKRVjPODFsVOu1YoBBKo1aMq0IgKniqd5qJifERSIqEBJlAXKH8bNMEMhJWtl1vEs91W0q8LAudoUFPLBaGhUepFLyOz9cBKg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938124; c=relaxed/simple;
	bh=ahKANnHlffOPByaJUCxPTRzxnyolH5QjPatyQO1UPa4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxurVBVObQAIrBI2iJ1GvNN/zMj95c4OKoy+OB51QZ33C5UJT8S8RFjUsg/IqoH6lXYS7k5xLPvLNn79uoIEgmAl7gIXFgjgzLV3KaLIMp1xPjb8HlYlUrPYwnADk4+uu3aSHxZvN0kxmbxW583RMYHXBkU+2x7mTdvUgWY/Kuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTow85Ts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTow85Ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D191F000FF;
	Wed, 14 Oct 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791938123;
	bh=5s6WulDGabmKRfzPjEdUu3qO0RBkG/NzXQxse9v6GY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RTow85TsZO0W5jib4+tbQat26vq81vyePy2ZX+bKkvnucEt8toXYHSWjV46byWdpL
	 w+2gWS2TD7vcU6mJkeHEDUokaD6N1DSx9VLSBMOLKYlfHJkWg5E5JmGKCFNWUhNHcx
	 9bieusQOw5CKDJmPAzIRtd+HxeWWa8uH7HuRDq10aaJrEKeoFcfTajfyBbDXi4iTHU
	 bjXGXoTqRjI+GjWi2UscsrG1w4d3lBdvyQ3H6Jj9UstJZXOjPNiIPcEj+npiaGmCHu
	 7S6uFnJ8PLK5ri7dQ9//xJlZ+3LyoGZrhERc9WtTYALam6dLM6zXeUqpO4PWKgJx3b
	 lEKw94l2rkMhA==
Subject: Re: [PATCH mptcp-net] mptcp: reset MP_JOIN subflows on missing or
 invalid DSS options
From: netdev-bot+sashiko@kernel.org
To: rameshsv06@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, rameshkumar.t@phytecembedded.in,
 kuba@kernel.org
Date: Wed, 14 Oct 2026 00:35:22 +0000
Message-ID: <179193812231.3135.9291068793791022556@kernel.org>
In-Reply-To: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
References: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp: DoS and skipped stats via mptcp_subflow_fail() on MP_JOIN
- [Medium] The patch now resets an MP_JOIN subflow when its data arrives
  after the connection has fallen back.
- [Low] The commit fixes a real bug but has no Fixes: tag.
- [Low] The author and sign-off addresses do not match.

Pre-existing issues:
- [High] The new joined-subflow branch in subflow_check_data_avail()
  (subflow.c:1449-1462) still sends MP_JOIN subflows with…

--

mptcp: reset MP_JOIN subflows on missing or invalid DSS options

This patch changes the fallback label in subflow_check_data_avail(). MP_JOIN
subflows, and any subflow other than msk->first, are now always reset when
they see missing or invalid DSS mappings. Before, they got a fake fallback
mapping once the connection had fallen back. The initial subflow keeps the
existing MP_FAIL and infinite fallback handling.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544
> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>

[Severity: Low]
This fixes the baseline behaviour where data on a join subflow, arriving
after the connection fell back, went through the fake fallback mapping path
in subflow_check_data_avail() instead of being reset. There is no Fixes: tag
though.

Could one be added so stable maintainers know which trees need the backport?
MPTCP fixes for net are expected to carry one.

[Severity: Low]
The author is T S Rameshkumar <rameshsv06@gmail.com>, but the only
Signed-off-by uses rameshkumar.t@phytecembedded.in. checkpatch reports this
as a From:/Signed-off-by: email address mismatch.

Could the sign-off use the author address, or could a From: line be added to
the body?

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 2c72cb50fbf36..421832874cc62 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1446,7 +1446,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  	return false;
>  
>  fallback:
> -	if (!__mptcp_check_fallback(msk)) {
> +	if (subflow->mp_join || ssk != READ_ONCE(msk->first)) {
>  		/* RFC 8684 section 3.7. */
>  		if (status == MAPPING_BAD_CSUM &&
>  		    (subflow->mp_join || subflow->valid_csum_seen)) {

[Severity: High]
This is a pre-existing issue, but this block now handles only joined
subflows. Is the mptcp_subflow_fail() call under this MAPPING_BAD_CSUM check
still correct?

mptcp_subflow_fail() only works for the MPC subflow:

net/mptcp/subflow.c:mptcp_subflow_fail() {
    ...
	msk->allow_subflows = false;
	spin_unlock_bh(&msk->fallback_lock);

	/* graceful failure can happen only on the MPC subflow */
	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
		return false;
    ...
}

Every subflow that reaches this branch has mp_join set or is not msk->first.
So the helper either returns false early or hits the WARN_ON_ONCE(). The
data_avail = true / return true success path cannot run here.

A remote peer seems able to reach the warning. When mptcp_finish_join()
defers a passive join to join_list, allow_infinite_fallback stays true. It
is only cleared in mptcp_subflow_joined(), on retransmission, or during
MP_FAIL handling.

A peer that negotiated checksums can then send a DSS with a bad checksum on
that subflow:

subflow_data_ready()
  mptcp_subflow_data_available()
    subflow_check_data_avail()
      get_mapping_status() -> MAPPING_BAD_CSUM
      mptcp_subflow_fail()
        WARN_ON_ONCE(ssk != READ_ONCE(msk->first))

This also clears allow_subflows on the msk. With panic_on_warn set, it
becomes a panic.

The baseline made the same call under !__mptcp_check_fallback(), so this
path was already reachable. The commit message says joined subflows should
simply be reset. Could this branch set send_mp_fail if needed and go
straight to the reset label without calling mptcp_subflow_fail()?

> @@ -1461,6 +1461,28 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  			return true;
>  		}
>  
> +		subflow->reset_transient = 0;
> +		subflow->reset_reason = status == MAPPING_NODSS ?
> +					MPTCP_RST_EMIDDLEBOX :
> +					MPTCP_RST_EMPTCP;
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
> +		goto reset;
> +	}

[Severity: High]
For a joined subflow that sees MAPPING_BAD_CSUM, this branch still
calls mptcp_subflow_fail() first, and that helper cannot succeed for a
join subflow. That has two consequences.

First, when allow_infinite_fallback is already clear,
mptcp_subflow_fail() returns false. The code then sets
MPTCP_RST_EMIDDLEBOX and jumps to the reset label. That label sits
after the MPTCP_INC_STATS(..., MPTCP_MIB_DSSRESET) call in the
mptcp_try_fallback() failure block. So a join subflow reset for a bad
checksum is never counted in MPTCP_MIB_DSSRESET. A join subflow reset
for MAPPING_NODSS or MAPPING_INVALID is counted here. The commit
message says joined subflows get the MIB bump before the reset. Was
the bad checksum case meant to be left out?

Second, when allow_infinite_fallback is still true, the helper gets
past its early return and clears msk->allow_subflows. It then hits
WARN_ON_ONCE(ssk != READ_ONCE(msk->first)), because the ssk here is a
join subflow.

A remote peer can get there. When the msk is owned by the user,
mptcp_finish_join() only queues the passive join on join_list.
allow_infinite_fallback stays set until the join list is flushed and
mptcp_subflow_joined() runs. If a DSS with a bad checksum arrives on
that subflow in the meantime, subflow_data_ready() handles it in
softirq context and it reaches the warning. With panic_on_warn set,
that is a remotely triggerable panic.

The baseline made the same call under !__mptcp_check_fallback(), but
this patch now dedicates the branch to join subflows.

This branch can only end in a reset. Could it skip
mptcp_subflow_fail() altogether, keep send_mp_fail if an MP_FAIL is
still wanted, and share the reset code just below that bumps
MPTCP_MIB_DSSRESET? Or is MPTCP_MIB_DATACSUMERR enough accounting for
the checksum case?

[Severity: Medium]
Can this reset of a join subflow close the whole MPTCP connection, even
after the connection has already fallen back to the initial subflow?

On the passive side, when the msk is owned by the user, mptcp_finish_join()
only queues the new subflow:

net/mptcp/protocol.c:mptcp_finish_join() {
    ...
	} else {
		sock_hold(ssk);
		list_add_tail(&subflow->node, &msk->join_list);
		__set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->cb_flags);
    ...
}

mptcp_subflow_joined() has not run yet, so allow_infinite_fallback is still
true. Suppose the initial subflow then falls back, for example because a
middlebox strips DSS and mptcp_try_fallback() succeeds. That sets
MPTCP_FALLBACK_DONE and clears allow_subflows.

Later, data arrives on the join subflow and get_mapping_status() returns
MAPPING_DUMMY. This new branch then sets ssk->sk_err = EBADMSG and moves the
ssk to TCP_CLOSE. The msk is owned, so subflow_error_report() only sets
MPTCP_ERROR_REPORT.

mptcp_release_cb() flushes the join list first. __mptcp_finish_join() fails
because allow_subflows is false, but mptcp_subflow_reset() returns early:

net/mptcp/subflow.c:mptcp_subflow_reset() {
    ...
	if (ssk->sk_state == TCP_CLOSE)
		return;
    ...
}

That leaves the subflow on conn_list with EBADMSG still pending. Next,
__mptcp_error_report() walks conn_list and reaches it.
__mptcp_subflow_error_report() checks only the connection-wide fallback flag:

net/mptcp/protocol.c:__mptcp_subflow_error_report() {
    ...
	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
		return false;
    ...
	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
		mptcp_set_state(sk, ssk_state);
	WRITE_ONCE(sk->sk_err, -err);
    ...
}

Wouldn't this move the msk to TCP_CLOSE and report EBADMSG to the
application, even though the initial subflow is healthy?

Before this patch, the join subflow got the fake fallback mapping and no
sk_err. mptcp_subflow_reset() tore it down during the join list flush, and
the connection kept running on the initial subflow.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012112625.578911-1-rameshkumar.t%40phytecembedded.in
