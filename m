Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723566;
	b=SMpdUQ9ixkl27yaPQX9u6YvEk9Pqu7nNp9r0/+xlwA6JpElFiQEDqdWOwIyA/mennooB
	 CEkafgVZ3U66SjDFBsPmVfUU7jhXVXW8JdpW0fb4JB/ZU4jbsRl56iTRSDy2IvwPOpMlb
	 hA+C2b56eYqJzdzvHoYB5ZXlhVosLvbgdENM3bMUxwqfz93h7MmOX/tytRM5Xqa5UjLKS
	 BuO7BqimWvqYIJhU1mdg2c1lyjqCPhByY4HRz4hQgmGiEShgisnlUjpKWjT0Zfp7k5oWx
	 We0jjkvDt0DDe7MNbgUH61ARtR7f1NTW9nPDU3y+Zm0W4Ni+r/Gr9GB01C2aqqme/fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723566;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vj1HCU3XWCIaIaTQYwUhjHef3P4wf4DKLNnhdpanu8c=;
	b=bncxDH/NonobV+cx2umvBZSIF7Rvkc73v/daUCufFpIwvLAxKB9QlINm8+ytBZLjEIKM
	 tHk+hQVTrIK2WQ8ilKVVfcJ29e5Qo2uR+gHdpTE60iSQXYUYtZiRfHi4ju+n2dvQZ7rLi
	 fw3bBrqlIlx7uSI9Tg8PHqyqz4FxdG9oZObZNgQTZT6hWoF2peqTOn7s+LXGwdui8/kCm
	 k34ehUvDJeCKEE3sk/b7r0a6hS+MEQPMLNMVE2HMyIGCRjK2fJhPi7Ik2RbnnI67vkP44
	 MI6fR0agShA10xRuhDwt/gn5V0a6Q7CGhpvovRsT3ylXLJvQ0LhaADNE6s8PjJfiifg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A+xRPj/R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C743606A32E
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+xRPj/R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC81F00A18;
	Tue,  3 Nov 2026 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723566;
	bh=vj1HCU3XWCIaIaTQYwUhjHef3P4wf4DKLNnhdpanu8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A+xRPj/RxQEnOqWuk/nNry1QFTBrsgN/c8o4eZBvEjxwnQxQxgYS1MWJvHD4SDUgW
	 93oaMQQfBrav1tyD/jqfjwu/IaPv7CJHO/1dRRbVQ0SP1SxbQfF1c6qUjusBioiNap
	 +fUpqwY9S8b9+igmvmaYhZfRIOFFxcKV4Wqtj/e3w/7IQYanIvoqrAJig6gX/7pTow
	 3jGKEt2befaGgL7HM8DWauKsBR8N8im2aAkEOcXmPXsd6zzvTDfe0EAeTiCmTYAkbR
	 KDgi+oqbQ2odEIygfnfgv2BhM5LG3LB/WGXZdG2HQvged/bZo/+AZIUhUQAYShfikd
	 bwYu2wc/8Pl7A==
Subject:
 Re: [PATCH mptcp-next v4 4/5] mptcp: track app-limited state in mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 03 Nov 2026 16:32:45 +0000
Message-ID: <179372356543.488855.12796870901080741390@kernel.org>
In-Reply-To: <b3d85544ac84b3c83617f72a5cfc893bac2a6304.1793588257.git.tanggeliang@kylinos.cn>
References: <b3d85544ac84b3c83617f72a5cfc893bac2a6304.1793588257.git.tanggeliang@kylinos.cn>
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

- [Medium] mptcp_rate_check_app_limited()
  (net/mptcp/protocol.c:2041-2058) returns early when mptcp_rtx_head(sk)…
- [Low] The commit 'mptcp: track app-limited state in mptcp_sendmsg'
  lists 'Geliang Tang <geliang@kernel.org>' as Author, but its only…
- [Low] mptcp_rate_check_app_limited() calls mptcp_rtx_head(sk) while
  holding only the msk's owner lock (lock_sock in mptcp_sendmsg), not…

--

mptcp: track app-limited state in mptcp_sendmsg

This patch adds mptcp_rate_check_app_limited(), which runs
tcp_rate_check_app_limited() on every subflow under the subflow socket
lock. It returns early when MPTCP still has unsent, queued or
retransmittable data. The helper is called from mptcp_sendmsg_locked()
so that BBR and similar controllers can ignore app-limited rate samples.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Author line is Geliang Tang
<geliang@kernel.org>, and the only Signed-off-by is
<tanggeliang@kylinos.cn>. No sign-off matches the From: identity, so
checkpatch reports "From:/Signed-off-by: email address mismatch".

The other Geliang-authored patches in the series have the same mismatch:
"mptcp: implement peek_len for proto_ops", "mptcp: add sendmsg_locked to
proto_ops" and "selftests: mptcp: sockopt: check app_limited".

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7ccb1c7506a37..ab7de11a448ce 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2038,6 +2038,25 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static void mptcp_rate_check_app_limited(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (msk->write_seq != msk->snd_nxt ||
> +	    mptcp_send_head(sk) || mptcp_rtx_head(sk))
> +		return;

[Severity: Medium]
Does the mptcp_rtx_head() check do what the commit message says? The
commit message describes it as:

  data awaiting retransmission (mptcp_rtx_head)

However, mptcp_rtx_head() returns non-NULL whenever any data is still
unacked at the DATA level:

net/mptcp/protocol.h:mptcp_rtx_head() {
	...
	if (msk->snd_una == msk->snd_nxt)
		return NULL;

	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
}

rtx_queue holds every sent dfrag until __mptcp_clean_una() sees snd_una
move past its end. So this guard returns early whenever any MPTCP-level
data is in flight. Subflows only get marked when the connection is fully
idle, with write_seq == snd_nxt == snd_una.

The TCP call site in tcp_sendmsg_locked() has no such gate. The wrapped
tcp_rate_check_app_limited() already allows marking while packets are in
flight below cwnd, and it checks lost_out <= retrans_out per subflow.

Pending reinjection also looks like it is already covered by
mptcp_send_head(), because __mptcp_retransmit_pending_data() sets
msk->first_pending = rtx_head.

That means the common app-limited case is never marked: an application
that writes slower than the path, where each write is sent at once while
earlier data is still unacked. Since snd_una only advances on DATA_ACK,
an idle subflow is also not marked while another subflow has unacked
data.

Those low-rate samples then reach bbr_update_bw():

	if (!rs->is_app_limited || bw >= bbr_max_bw(sk)) {
		/* Incorporate new sample into our max bw filter. */
		minmax_running_max(&bbr->bw, bbr_bw_rtts, bbr->rtt_cnt, bw);

The bandwidth estimate can then decay toward the application rate.
The fully idle case, which the series selftest checks, does work. The
remaining patch in the series only touches selftests, so this code is
unchanged at the end of the series.

Should the mptcp_rtx_head() check be dropped, or replaced with a test for
data that is actually pending retransmission? If the restriction is
intended, could the commit message describe and justify it?

[Severity: Low]
Can the plain read of msk->snd_una in mptcp_rtx_head() race with
ack_update_msk()? Here mptcp_rtx_head() is called with only the msk
socket owned, not under mptcp_data_lock().

In softirq, ack_update_msk() takes mptcp_data_lock(sk) and updates
snd_una even when the msk is owned by user:

net/mptcp/options.c:__mptcp_snd_una_update() {
	msk->bytes_acked += new_snd_una - msk->snd_una;
	WRITE_ONCE(msk->snd_una, new_snd_una);
}

Only the rtx_queue cleanup is deferred, through MPTCP_CLEAN_UNA when
sock_owned_by_user(). So the list access is fine, but the snd_una
comparison is not serialized.

The existing mptcp_rtx_head() callers (__mptcp_clean_una(),
__mptcp_retransmit_pending_data() and __mptcp_retrans()) all hold the
data lock. Other lockless snd_una readers use READ_ONCE().

KCSAN would report this race. On 32-bit, the 64-bit read could tear and
give a wrong app-limited decision.

Would READ_ONCE() work here? Another option is taking mptcp_data_lock()
around the check and releasing it before taking the subflow locks.

> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast_nested(ssk);
> +		tcp_rate_check_app_limited(ssk);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793588257.git.tanggeliang%40kylinos.cn
