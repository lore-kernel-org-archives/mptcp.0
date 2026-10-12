Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FC3A783F;
	Mon, 12 Oct 2026 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800513; cv=none; b=bG8oyqCsoES/HISH3cQQaLO3N4WcPfE25/HNETgapZOPYGh4Z6Y5ey9gV2ErbMueQ3zXI4YfMcC3fqKOlP4DIyu8/5w7TbGLIuucB+HW13vX15opux/FwlYFSWcCgvi95Hdz1rQtRMpplWVVCrKG+Hs2IghY2HIrfnTzCeBgEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800513; c=relaxed/simple;
	bh=tt1Olzp1MD4fsUOy/cOmWDm5X/BFh/k9tqnzJQ6JJeY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHsyGyhopiuHujLoBIK2cSK03QE06TxWn3NPrLYhjFZuRwJ/9n6+NEk1WVs2ukg68af+jUg7dvhYzQaWHLAevdH/5Cm7JlKHMxbGvl5mn6fKm5pYF8aWt8Kw0JU5rw05EHSGvrguY61YcY/Y5xR3Yz7lKlgY/+0+LPAjb4dtFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liUoouJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liUoouJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46A51F0089D;
	Mon, 12 Oct 2026 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800497;
	bh=zEdqtRomAjkOUDRAt/clQFYIks43Xswl/Vr+ajWSkcA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=liUoouJI2ptjjd7Y3JhU1ykbk3N55YsW4/nLE6RweftHuMotNQnNb5XL790tHEHP3
	 V8/0KG2kNA77xQyzyokP7J9gfXi+m4vPazkmh0Caui4NdWSKbsAicsdP+/E88tvqxh
	 gP+WB4ost7IHgA+GVE1PzNnSnawamFrhlfApKcTcqPhhb9zSVFM+ies5NaxZBgAJZ4
	 ZdkykrEFTGRVK8cuaUHwAq5aXNaQa5n6VjJ2tIvCEaX1aE4i334qUQJt40tqAUhygX
	 adI2FePQgg/5x8JOmPqB2/WJh5kEC6G0UP2FOC6DAE68HpGbgda8kgtKGu8dM6g0mg
	 En1RnDt3+dqjA==
Subject: Re: [PATCH] mptcp: push queued data on passive TFO subflows becoming
 established
From: netdev-bot+sashiko@kernel.org
To: rameshsv06@gmail.com
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 petar.sakic@ink.fish, rameshkumar.t@phytecembedded.in, kuba@kernel.org
Date: Mon, 12 Oct 2026 10:21:36 +0000
Message-ID: <179180049633.434549.1829139205933181446@kernel.org>
In-Reply-To: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
References: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete because both new push triggers depend on
  subflow->is_mptfo.
- [Medium] The new block in subflow_state_change()
  (net/mptcp/subflow.c:1897-1900) checks only subflow->is_mptfo.
- [Medium] subflow_state_change() now does set_bit(MPTCP_PUSH_PENDING,
  &mptcp_sk(parent)->cb_flags) without holding the msk data lock…
- [Low] The Fixes: tag names e00b63056fb4 ('mptcp: fastopen: only mark
  MPTFO subflows with SYN data'), but that commit did not introduce the…
- [Low] The commit author is 'T S Rameshkumar <rameshsv06@gmail.com>',
  but the only Signed-off-by is 'T S Rameshkumar…
- [Low] The new comment in check_fully_established()
  (net/mptcp/options.c:1045-1049) says '... nothing else spools the msk…

--

mptcp: push queued data on passive TFO subflows becoming established

This patch targets data that gets queued in the msk write queue while a
passive TFO subflow is still in SYN_RECV. That data stays stranded after
the MPC third ACK arrives. The patch adds a __mptcp_check_push() call in
check_fully_established(). It also sets MPTCP_PUSH_PENDING and schedules
the msk worker in subflow_state_change(). Both changes are gated on
subflow->is_mptfo.

Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/

> Fixes: e00b63056fb4 ("fastopen: only mark MPTFO subflows with SYN data")

[Severity: Low]
Is this the right commit for the Fixes: tag?

The diff of e00b63056fb4 ("mptcp: fastopen: only mark MPTFO subflows with
SYN data") does two things in mptcp_fastopen_subflow_synack_set_params():

- it removes WARN_ON_ONCE(!skb)
- it moves subflow->is_mptfo = 1 after the skb_peek() check

It does not add or remove any push of the msk write queue.

This patch targets TFO SYNs that carry data, and for those the behaviour
is the same before and after that commit. The missing push after the MPC
third ACK seems to date back to the original passive MPTFO support.
e00b63056fb4 points there with its own Fixes: tag on 36b122baf6a8
("mptcp: add subflow_v(4,6)_send_synack()").

Would 36b122baf6a8 be a more accurate Fixes: target?

> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>

[Severity: Low]
The author is T S Rameshkumar <rameshsv06@gmail.com>, but the only
Signed-off-by uses rameshkumar.t@phytecembedded.in. checkpatch.pl reports
"From:/Signed-off-by: email address mismatch" for this.

Could the From: line or the sign-off be updated so they match?

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ce0de02f5a3a1..d5238fa111dee 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1042,6 +1042,13 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  
>  	mptcp_data_lock((struct sock *)msk);
>  	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
> +	/* Passive TFO: the application may have written data while the
> +	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
> +	 * it then and nothing else spools the msk write queue when the
> +	 * MPC third ack (no DSS) arrives. Push it now.
> +	 */

[Severity: Low]
This isn't a bug, but is the "nothing else spools the msk write queue"
part of this comment still accurate?

The same patch adds a second push in subflow_state_change(). It fires on
the SYN_RECV->ESTABLISHED transition caused by this same third ACK, before
check_fully_established() runs.

The subflow.c hunk also has no comment explaining how the two mechanisms
relate.

> +	if (subflow->is_mptfo)
> +		__mptcp_check_push((struct sock *)msk, ssk);

[Severity: High]
Does this cover TFO connections where the SYN has a valid cookie but no
data? Since e00b63056fb4, is_mptfo is only set when the SYN had a
payload:

net/mptcp/fastopen.c:mptcp_fastopen_subflow_synack_set_params() {
    ...
	/* A valid TFO cookie does not guarantee SYN data. */
	skb = skb_peek(&ssk->sk_receive_queue);
	if (!skb)
		return;

	subflow->is_mptfo = 1;
    ...
}

tcp_try_fastopen() still creates an early-accepted Fast Open child in
SYN_RECV whenever a cookie is present, even without data. A cookie
request without data also qualifies when TFO_SERVER_COOKIE_NOT_REQD is
set:

net/ipv4/tcp_fastopen.c:tcp_try_fastopen() {
    ...
	if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
	      (syn_data || foc->len >= 0) &&
	      tcp_fastopen_queue_check(sk))) {
    ...
}

In that case mptcp_sk_clone_init() puts the msk in TCP_ESTABLISHED, so
the application can accept() and write() right away.
__mptcp_subflow_active()->__tcp_can_send() refuses the SYN_RECV subflow,
and the data stays in the msk write queue.

When the MPC third ACK arrives:

- check_fully_established() reaches set_fully_established but skips
  __mptcp_check_push(), because is_mptfo is 0
- the new block in subflow_state_change() is skipped for the same reason
- the ACK has no DSS, so ack_update_msk() is not reached
- nothing was copied, so no rtx timer is armed

Wouldn't the data then stay stuck until the peer sends something? That is
the same stall this patch is meant to fix.

Should the condition be whether the msk was exposed or written to before
the subflow was fully established, rather than whether the SYN carried
data?

>  	mptcp_data_unlock((struct sock *)msk);
>  
>  check_notify:
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..f499073a62d7c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1894,6 +1894,11 @@ static void subflow_state_change(struct sock *sk)
>  	if (subflow->resetting)
>  		return;
>  
> +	if (subflow->is_mptfo) {

[Severity: Medium]
Should this be limited to the transition to TCP_ESTABLISHED?

is_mptfo is set once in mptcp_fastopen_subflow_synack_set_params() and is
never cleared. So this block runs on every sk_state_change of a passive
TFO subflow for the life of the connection, including:

- FIN receipt via tcp_fin() (ESTABLISHED->CLOSE_WAIT)
- FIN_WAIT1->FIN_WAIT2
- tcp_done()

Each of these schedules the msk worker, which takes the msk lock and runs
a __mptcp_push_pending() pass.

The commit message says this flushes "once the underlying subflow
transitions to TCP_ESTABLISHED", but there is no state check here.

Even for the SYN_RECV->ESTABLISHED transition, the callback runs before
the MPC third ACK is parsed:

tcp_rcv_state_process()
    tcp_set_state(sk, TCP_ESTABLISHED);
    sk->sk_state_change(sk);        <- subflow_state_change()
    ...
    tcp_data_queue()
        mptcp_incoming_options()
            check_fully_established()

So the worker is scheduled before subflow->fully_established is set.

Change 1 in check_fully_established() already pushes on the third ACK,
and the commit message doesn't explain why both mechanisms are needed.
Could that be clarified?

> +		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(parent)->cb_flags);

[Severity: Medium]
Can this set_bit() race with the non-atomic updates to msk->cb_flags?

subflow_state_change() runs from the subflow's softirq path with only the
subflow lock held, not the msk data lock (parent->sk_lock.slock). Every
other cb_flags writer holds slock, and most of them use plain
read-modify-write operations. For example, in mptcp_release_cb():

		msk->cb_flags &= ~flags;
		spin_unlock_bh(&sk->sk_lock.slock);
	...
	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))

and in mptcp_check_and_set_pending():

		mptcp_data_lock(sk);
		mptcp_sk(sk)->cb_flags |= BIT(MPTCP_PUSH_PENDING);
		mptcp_data_unlock(sk);

An atomic set_bit() on one CPU doesn't protect against a plain RMW on
another:

CPU0                              CPU1 (softirq)
release_sock(msk)
  mptcp_release_cb()
    load cb_flags (X)
                                  subflow_state_change()
                                    set_bit(MPTCP_PUSH_PENDING)
    store X & ~flags
                                    mptcp_schedule_work()

PUSH_PENDING is lost, and the worker's release_sock()->mptcp_release_cb()
then finds nothing to push.

Suppose the third ACK has no MPC option. check_fully_established() then
falls back via mptcp_try_fallback() and returns without pushing, so this
hook is the only trigger and the queued data would stay stranded.

KCSAN would likely also report the unlocked writer racing with the plain
reads in mptcp_release_cb().

Would it be better to set the bit under mptcp_data_lock(parent), as
mptcp_check_and_set_pending() does?

> +		mptcp_schedule_work(parent);
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008095231.103186-1-rameshkumar.t%40phytecembedded.in
