Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB333F5BE;
	Wed, 16 Sep 2026 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534101; cv=pass; b=PwRpiLP0IrWevS92/ytTLGnFLt6q1n8qqRtt3cufhdWKL8RrjIZ1m33yDSuky9ZX6qGfci92Yq/qUxJDmO+1IgubTmvwg+Y9lbJZ4iwScqiJWM6olcEjqlO2uGxjUX7rSOgxMO/GlYOLQA0fR/tJg6PKVtfUrhEzCY/Ta3C6n64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534101; c=relaxed/simple;
	bh=3/ss3YkEQS0YNIsP4KwP1vxy0SLAWyuGXSI4iKC8f3M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bVAJ2ApGRi4DxtSXJUj8fswxPWrn1EC+TnMUaFfpy/0mNJC89c9WUgJefErNYwtCFIcYtt50sw0FUAtKe1Q7tF7+Kn9NEz6ZjP6TDDXg6/0xqiHEwYsK5k0BM2kITWfu6DVhL2BI8ejZXtazLjJudyRad9G5JVnPPlPUQTQzG+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=CUbkCP6Y reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="CUbkCP6Y"
ARC-Seal: i=1; a=rsa-sha256; t=1789534095; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CBsyZWhkm/Cm2XROfsmaCQ8VtLZkVcwa/Z11GTU8znhMtySvT0iQ6iU7wxhEiHfl3DarhqhNhumKC7aXgGv5IvXCa8Hn5aeSgm9k54y2Gq1wmOBMewWafQpIBO5l4WludDJUYlprKzIG13DuAqsswBem1P9Mb4RFHSEGt5gjevc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789534095; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WRcJzQNqiNBFf2sNL97Oaj3Xj63LhUDWalmAFAjkh2E=; 
	b=Dri+wn8E+/4hklF8Rx2ZITzrn9DNAyXaFeVkNcWovTQE1/v8nZJmQEkDUMweT90Vjrs0BMY1JUR/zogxeu3mbVmmmpk+iURzw3nWsooZft1y/dgOTZKBX+wmQJV/ruuSyPuJFK9X85jpF4TYUUGunvKAR4yY+uCPbvXqUMkHekU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789534095;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WRcJzQNqiNBFf2sNL97Oaj3Xj63LhUDWalmAFAjkh2E=;
	b=CUbkCP6YN94PeRDaTs29Hkst2WO6QgYCYwcpmlN+s4yjmLddqQg0aAU665B2NwYP
	JQnGZfbFeHjdIzyhuMde+0UKVnvqwoyMyWSfAfINOQyWqWYdBajKQxdI03cjY3Agul8
	LvzsosO7ofzGenFThRZhARBpkuIqMPA5PkMXMBq8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1789534095811708.2340570793463; Tue, 15 Sep 2026 21:48:15 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1789534094803919.0589216275839; Tue, 15 Sep 2026 21:48:14 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:18:14 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matttbe" <matttbe@kernel.org>
Cc: "sashiko-reviews" <sashiko-reviews@lists.linux.dev>,
	"Mptcp" <mptcp@lists.linux.dev>
Message-ID: <1a0a88b45c0.2487fce6673796.3552940371542702370@mpiricsoftware.com>
In-Reply-To: <20260909094800.766170-1-kalpan.jani@mpiricsoftware.com>
References: <20260909094800.766170-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v6] mptcp: normalize seq numbers reported in
 mptcp_info
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

Sashiko flagged a possible bitfield word-sharing race in v6:
remote_key_valid is read in mptcp_diag_fill_info() under
mptcp_data_lock(msk), but it shares a storage word with map_valid,
which is written in subflow_check_data_avail() and
subflow_data_ready() under the subflow socket's own lock in softirq
context. Different socks, different locks, so a concurrent read and
read-modify-write on that u32 looks possible.

As far as I can tell this is pre-existing rather than something this
patch introduces - remote_key_valid was already read and written from
those paths before, and the patch only adds one more reader. Is this
a known/accepted characteristic here, or does it need addressing? And
if it does, should that be part of this patch or a separate one?

Cheers,
Kalpan Jani


From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: <mptcp@lists.linux.dev>
Cc: <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Date: Wed, 09 Sep 2026 15:18:00 +0530
Subject: [PATCH net-next v6] mptcp: normalize seq numbers reported in mptcp_info

 > mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt report the raw
 > 64-bit data sequence numbers, seeded from the connection's IDSN/IASN.
 > Since the IDSN/IASN come from mptcp_crypto_key_sha(), these fields
 > carry an effectively random offset and are not useful to userspace as
 > absolute values: a caller has to snapshot two getsockopt(MPTCP_INFO)
 > calls and subtract to get anything meaningful, which is exactly what
 > tools/testing/selftests/net/mptcp/mptcp_sockopt.c already does.
 > 
 > mptcp_info also reports mptcpi_bytes_sent, mptcpi_bytes_received and
 > mptcpi_bytes_acked, which give the same information as a plain byte
 > count starting at 0. The snapshot-and-diff workaround for the seq
 > fields is redundant once those are available.
 > 
 > Normalize mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in
 > mptcp_diag_fill_info() by subtracting the local and remote initial
 > sequence numbers, read from msk->first's subflow context rather than
 > caching them on mptcp_sock, to avoid growing every mptcp_sock for a
 > diag-only need.
 > 
 > msk->first is snapshotted once via READ_ONCE() and held with
 > sock_hold() for the duration of this function, instead of being
 > re-read separately for local_idsn and remote_idsn. This avoids two
 > problems: a lockless double-fetch of msk->first (the pointer could
 > change between an "is it set" check and its use), and local_idsn and
 > remote_idsn being computed from two different subflows if msk->first
 > changed between the two normalizations. The subflow context is
 > otherwise released via kfree_rcu() once msk->first is cleared and the
 > last reference drops, so holding a reference keeps it valid regardless
 > of what mptcp_close()/__mptcp_close_ssk() does concurrently; the hold
 > is released with sock_put() before returning.
 > 
 > msk->first only changes when the whole msk is already in TCP_CLOSE,
 > confirmed by testing with a debug print in __mptcp_close_ssk() under
 > mptcp_join.sh: every NULL transition observed had msk_state ==
 > TCP_CLOSE, none while the connection was still established. If it
 > somehow did happen mid-flight, write_seq and snd_una are just left
 > unnormalized on an already-gone socket.
 > 
 > subflow->idsn is set once at handshake time and never modified
 > afterwards, so local_idsn can be read directly. subflow->iasn is
 > different: it's written by subflow_set_remote_key(), called from
 > mptcp_propagate_state() under mptcp_data_lock(), not the socket lock.
 > remote_idsn is therefore computed in this function's existing
 > mptcp_data_lock() section, right next to where ack_seq is read: this
 > puts the read under the same lock the writer uses, and samples
 > remote_idsn and ack_seq atomically together. subflow->iasn is
 > incremented by one in that function to account for the peer's virtual
 > SYN, and ack_seq carries that same increment, so the increment is
 > undone here (iasn - 1) to keep rcv_nxt normalized against the same
 > baseline write_seq and snd_una use.
 > 
 > subflow_set_remote_key() also sets subflow->remote_key_valid only
 > after subflow->iasn and the other fields it guards are fully
 > populated, instead of first, so it can't be observed true while iasn
 > is still stale.
 > 
 > Note: this changes the semantics of mptcpi_write_seq, mptcpi_snd_una
 > and mptcpi_rcv_nxt. They no longer report the raw on-the-wire MPTCP
 > data sequence numbers, but values relative to the connection's
 > initial sequence numbers. This is intentional. Tools that correlate
 > these fields directly against captured DSS sequence numbers (e.g.
 > via tcpdump) will need to account for the offset; mptcpi_bytes_sent,
 > mptcpi_bytes_received and mptcpi_bytes_acked remain unaffected and
 > are the recommended fields for tracking absolute transferred-byte
 > counts.
 > 
 > Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
 > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > 
 > Changes since v5:
 > - Replaced the two independent READ_ONCE(msk->first) snapshots (one
 >   per lock section) with a single snapshot taken once and held via
 >   sock_hold(), reused in both places local_idsn and remote_idsn are
 >   computed. Two independent snapshots could each briefly return a
 >   non-NULL msk->first and then, less than a beat apart, see it
 >   become NULL, so local_idsn could be computed from a real subflow
 >   while remote_idsn fell back to 0 for the same call, producing an
 >   inconsistent baseline between the send and receive side. This also
 >   replaces the previous rcu_read_lock()-only protection, which only
 >   covered the lifetime of each lockless dereference and not a
 >   msk->first read that was itself unprotected against a concurrent
 >   WRITE_ONCE() from __mptcp_close_ssk() (reported by Sashiko).
 > 
 > Changes since v4:
 > - The v4 reorder of remote_key_valid alone was insufficient: it only
 >   fixed write ordering inside subflow_set_remote_key(), but the read
 >   in mptcp_diag_fill_info() was still taken under a different lock
 >   (lock_sock_fast()) than the writer (mptcp_data_lock(), reached via
 >   mptcp_propagate_state()). Moved the remote_idsn computation into
 >   this function's existing mptcp_data_lock() section, next to
 >   ack_seq, so both are read under the same lock as the writer and
 >   sampled atomically together, closing the cross-lock race, the
 >   TOCTOU window between remote_idsn and ack_seq, and (as a side
 >   effect of using a real lock) any 32-bit tearing concern (reported
 >   by Sashiko).
 > 
 > Changes since v3:
 > - Reordered subflow->remote_key_valid to be set after iasn is fully
 >   populated in subflow_set_remote_key(), instead of before: reading
 >   remote_key_valid as a readiness flag while iasn could still be
 >   stale/uninitialized was a data race (reported by Sashiko).
 > - Added a comment in mptcp_diag_fill_info() documenting why the
 >   msk->first NULL fallback to 0 cannot be observed by any external
 >   caller, given the shared lock_sock/lock_sock_fast serialization
 >   with mptcp_close() (reported by Sashiko, confirmed with Matt).
 > - Documented in the commit message that this intentionally changes
 >   the UAPI semantics of the three fields, per Matt's request
 >   (reported by Sashiko as a compatibility concern).
 > 
 > Changes since v2:
 > - Dropped the msk->local_idsn/msk->remote_idsn fields entirely.
 >   Read idsn/iasn from msk->first's subflow context in
 >   mptcp_diag_fill_info() instead, per Matt's suggestion, to avoid
 >   growing mptcp_sock for a diag-only need. Verified msk->first only
 >   goes NULL as part of whole-msk teardown, not during a live
 >   multi-subflow connection.
 > 
 > Changes since v1:
 > - Cached msk->remote_idsn before subflow->iasn++ instead of after:
 >   the increment accounts for the peer's virtual SYN, and caching
 >   remote_idsn post-increment left mptcpi_rcv_nxt starting at 0 while
 >   mptcpi_write_seq/mptcpi_snd_una started at 1 for the same
 >   connection (reported by Sashiko).
 > 
 > v1: https://lore.kernel.org/all/20260825113355.3573376-1-kalpan.jani@mpiricsoftware.com/
 > v2: https://lore.kernel.org/all/20260827041058.2833707-1-kalpan.jani@mpiricsoftware.com/
 > v3: https://lore.kernel.org/all/20260902102125.2035540-1-kalpan.jani@mpiricsoftware.com/
 > v4: https://lore.kernel.org/all/20260903054853.3400545-1-kalpan.jani@mpiricsoftware.com/
 > v5: https://lore.kernel.org/all/20260903105515.906187-1-kalpan.jani@mpiricsoftware.com/
 > ---
 >  net/mptcp/sockopt.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
 >  net/mptcp/subflow.c |  4 +++-
 >  2 files changed, 53 insertions(+), 4 deletions(-)
 > 
 > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
 > index 922f6ae5c80cb..0e6c4cd0dc9f1 100644
 > --- a/net/mptcp/sockopt.c
 > +++ b/net/mptcp/sockopt.c
 > @@ -1047,6 +1047,8 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 >  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 >  {
 >      struct sock *sk = (struct sock *)msk;
 > +    u64 local_idsn = 0, remote_idsn = 0;
 > +    struct sock *first;
 >      u32 flags = 0;
 >      bool slow;
 >      u32 now;
 > @@ -1084,9 +1086,37 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 >      info->mptcpi_flags = flags;
 >  
 >      slow = lock_sock_fast(sk);
 > +    /* msk->first is only ever NULL once the whole msk is already in
 > +     * TCP_CLOSE (see __mptcp_close_ssk()); mptcp_close() holds the same
 > +     * sk lock this function acquires via lock_sock_fast(), so no caller
 > +     * can observe that transition mid-flight. If it does happen, write_seq
 > +     * and snd_una below are just left unnormalized, which is harmless
 > +     * since the socket is already gone.
 > +     *
 > +     * first is snapshotted once here, rather than re-read later, so
 > +     * local_idsn and remote_idsn below both come from the same subflow
 > +     * and stay consistent with each other even if msk->first changes
 > +     * between the two normalizations. __mptcp_close_ssk() can drop the
 > +     * last reference on this subflow (sock_put()) before it clears
 > +     * msk->first, so refcount_inc_not_zero() is used instead of
 > +     * sock_hold(): if the count has already reached zero, first is
 > +     * treated the same as NULL instead of resurrecting a dying socket.
 > +     * On success, the extra reference keeps the subflow context alive
 > +     * for the rest of this function; it is released with sock_put() at
 > +     * the end.
 > +     */
 > +    rcu_read_lock();
 > +    first = READ_ONCE(msk->first);
 > +    if (first && !refcount_inc_not_zero(&first->sk_refcnt))
 > +        first = NULL;
 > +    rcu_read_unlock();
 > +
 > +    if (first)
 > +        local_idsn = mptcp_subflow_ctx(first)->idsn;
 > +
 >      info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 >      info->mptcpi_token = msk->token;
 > -    info->mptcpi_write_seq = msk->write_seq;
 > +    info->mptcpi_write_seq = msk->write_seq - local_idsn;
 >      info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 >      info->mptcpi_bytes_sent = msk->bytes_sent;
 >      info->mptcpi_bytes_received = msk->bytes_received;
 > @@ -1099,11 +1129,28 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 >      unlock_sock_fast(sk, slow);
 >  
 >      mptcp_data_lock(sk);
 > +    if (first) {
 > +        struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(first);
 > +
 > +        /* subflow->iasn is incremented once in subflow_set_remote_key(),
 > +         * which runs under this same mptcp_data_lock() (see
 > +         * mptcp_propagate_state()); compute remote_idsn here, under the
 > +         * same lock as the writer, and atomically with ack_seq below.
 > +         * first is the same held reference from earlier in this
 > +         * function, so it is guaranteed to still be valid here and to
 > +         * be the same subflow local_idsn was computed from above.
 > +         */
 > +        remote_idsn = subflow->remote_key_valid ? subflow->iasn - 1 : 0;
 > +    }
 > +
 >      info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
 > -    info->mptcpi_snd_una = msk->snd_una;
 > -    info->mptcpi_rcv_nxt = msk->ack_seq;
 > +    info->mptcpi_snd_una = msk->snd_una - local_idsn;
 > +    info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;
 >      info->mptcpi_bytes_acked = msk->bytes_acked;
 >      mptcp_data_unlock(sk);
 > +
 > +    if (first)
 > +        sock_put(first);
 >  }
 >  EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 >  
 > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
 > index 2d7ccb01d2342..a3313a3db5a76 100644
 > --- a/net/mptcp/subflow.c
 > +++ b/net/mptcp/subflow.c
 > @@ -482,7 +482,6 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 >      if (subflow->remote_key_valid)
 >          return;
 >  
 > -    subflow->remote_key_valid = 1;
 >      subflow->remote_key = mp_opt->sndr_key;
 >      mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 >      subflow->iasn++;
 > @@ -494,6 +493,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 >      WRITE_ONCE(msk->ack_seq, subflow->iasn);
 >      WRITE_ONCE(msk->can_ack, true);
 >      atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 > +
 > +    /* publish last, once iasn and the fields above are fully populated */
 > +    subflow->remote_key_valid = 1;
 >  }
 >  
 >  static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
 > -- 
 > 2.43.0
 > 
 > 


