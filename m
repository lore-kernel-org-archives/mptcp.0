Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438E44AB62
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432930; cv=pass; b=Hnqr76inEDdqvZpFLbfzasY377EGK2EOzHStZFBF+xh71fM4pOTzy/al0dGAS4+QOeRflZAQij4tZw5kVcGFUR3q0DaVjrKh3/vamMHIlsKugGFtT7CdJN4gy4qbjdgw8LSAQHas6kUytYYdDK8j6m5+ehtmd1moIfkQMIEqJLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432930; c=relaxed/simple;
	bh=ETJmZwD35daioAWuQrPzaJBoEF2CE/6h+yS3j1GOvpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIT4DClSTf/WH4QtYrEGkVfiBv1vJTQWjMPA9ieh2F2fR+OZMf7CXAxdqgoUV10FBkLOO6MwL7jRSTNLM/GZL3PvFXKPAs5+Ziz9E/HVVI/fty1Q1jnEyNPm3SLgNvPbTKV/mgXqsrh6zYkx2ZgDtYU/QglrlWUuUDkXU5cnMbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=S/yPujYo reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="S/yPujYo"
ARC-Seal: i=1; a=rsa-sha256; t=1788432926; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IzhCn0qLlAKe4cwGqgDksNd8+WI/V8MAb17TFeBY0Erfmdr12WfPg9IU/ceA+PmskaVMSwhpxi4XOJvIyHzjAlVhb93M8u7p00Gz2UQId1enTa4B0H3cn7/LU8fxD2uNg01gV+2qP2Isa8cxa1z3yrBgbJZzkR0T4RsS+iLL6CI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788432926; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fl/6sHEj+s/O/ltdwszEFCGgMC6qzYVvWI2+XkaWsKI=; 
	b=gOg6vdDvvLv0Aj/FAoEE4/gQ6qHSA18ezR7w7dMDHtHFJR8WgqMltTcgSnxkLURowpGuJCvh/J8S8PFELz6bHjYPYgX82IMI4T7iSbza2V/nz+Vs1a1kQ/lIUEbVBpxnI/c0vQkUmocOHAmNoo+mShlAVpGw9tqurT1JtHRsCtw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788432926;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fl/6sHEj+s/O/ltdwszEFCGgMC6qzYVvWI2+XkaWsKI=;
	b=S/yPujYoP59KyiI2RumiCtP7iUg2SWLdlxCWTVLlrsiEj+H3cfBdQXfC4Of3lfsL
	hsIYGT3dHptB3DVVdb045VqIYNM26VL8fOEDmf/pX9HDPXmteEVCbigDlpvPRn8uTvr
	kYINrCP/2fjapQqtGkl438dnlxap8yEU6B3xXSsM=
Received: by mx.zohomail.com with SMTPS id 178843292413814.299452031180635;
	Thu, 3 Sep 2026 03:55:24 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net-next v5] mptcp: normalize seq numbers reported in mptcp_info
Date: Thu,  3 Sep 2026 16:25:15 +0530
Message-ID: <20260903105515.906187-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt report the raw
64-bit data sequence numbers, seeded from the connection's IDSN/IASN.
Since the IDSN/IASN come from mptcp_crypto_key_sha(), these fields
carry an effectively random offset and are not useful to userspace as
absolute values: a caller has to snapshot two getsockopt(MPTCP_INFO)
calls and subtract to get anything meaningful, which is exactly what
tools/testing/selftests/net/mptcp/mptcp_sockopt.c already does.

mptcp_info also reports mptcpi_bytes_sent, mptcpi_bytes_received and
mptcpi_bytes_acked, which give the same information as a plain byte
count starting at 0. The snapshot-and-diff workaround for the seq
fields is redundant once those are available.

Normalize mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in
mptcp_diag_fill_info() by subtracting the local and remote initial
sequence numbers, read from msk->first's subflow context rather than
caching them on mptcp_sock, to avoid growing every mptcp_sock for a
diag-only need.

msk->first only changes when the whole msk is already in TCP_CLOSE,
confirmed by testing with a debug print in __mptcp_close_ssk() under
mptcp_join.sh: every NULL transition observed had msk_state ==
TCP_CLOSE, none while the connection was still established.
mptcp_close() holds the same sk lock this function acquires via
lock_sock_fast(), so no caller of MPTCP_INFO (direct getsockopt,
MPTCP_FULL_INFO, or the netlink diag path in mptcp_diag.c) can
observe that transition mid-flight; if it somehow did, write_seq and
snd_una are just left unnormalized on an already-gone socket.

subflow->idsn is set once at handshake time and never modified
afterwards, so local_idsn can be read directly under the socket lock
alongside write_seq and snd_una, which are themselves socket-lock
protected.

subflow->iasn is different: it's written by subflow_set_remote_key(),
called from mptcp_propagate_state() under mptcp_data_lock(), not the
socket lock. remote_idsn is therefore computed in this function's
existing mptcp_data_lock() section instead, right next to where
ack_seq is read: this puts the read under the same lock the writer
uses, and samples remote_idsn and ack_seq atomically together, so a
concurrent subflow_set_remote_key() can't update one without the
other being visible here too. subflow->iasn is incremented by one in
that function to account for the peer's virtual SYN, and ack_seq
carries that same increment, so the increment is undone here
(iasn - 1) to keep rcv_nxt normalized against the same baseline
write_seq and snd_una use.

subflow_set_remote_key() also sets subflow->remote_key_valid only
after subflow->iasn and the other fields it guards are fully
populated, instead of first, so it can't be observed true while iasn
is still stale even by a reader sharing its lock.

Note: this changes the semantics of mptcpi_write_seq, mptcpi_snd_una
and mptcpi_rcv_nxt. They no longer report the raw on-the-wire MPTCP
data sequence numbers, but values relative to the connection's
initial sequence numbers. This is intentional. Tools that correlate
these fields directly against captured DSS sequence numbers (e.g.
via tcpdump) will need to account for the offset; mptcpi_bytes_sent,
mptcpi_bytes_received and mptcpi_bytes_acked remain unaffected and
are the recommended fields for tracking absolute transferred-byte
counts.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

Changes since v4:
- The v4 reorder of remote_key_valid alone was insufficient: it only
  fixed write ordering inside subflow_set_remote_key(), but the read
  in mptcp_diag_fill_info() was still taken under a different lock
  (lock_sock_fast()) than the writer (mptcp_data_lock(), reached via
  mptcp_propagate_state()). Moved the remote_idsn computation into
  this function's existing mptcp_data_lock() section, next to
  ack_seq, so both are read under the same lock as the writer and
  sampled atomically together, closing the cross-lock race, the
  TOCTOU window between remote_idsn and ack_seq, and (as a side
  effect of using a real lock) any 32-bit tearing concern (reported
  by Sashiko).

Changes since v3:
- Reordered subflow->remote_key_valid to be set after iasn is fully
  populated in subflow_set_remote_key(), instead of before: reading
  remote_key_valid as a readiness flag while iasn could still be
  stale/uninitialized was a data race (reported by Sashiko).
- Added a comment in mptcp_diag_fill_info() documenting why the
  msk->first NULL fallback to 0 cannot be observed by any external
  caller, given the shared lock_sock/lock_sock_fast serialization
  with mptcp_close() (reported by Sashiko, confirmed with Matt).
- Documented in the commit message that this intentionally changes
  the UAPI semantics of the three fields, per Matt's request
  (reported by Sashiko as a compatibility concern).

Changes since v2:
- Dropped the msk->local_idsn/msk->remote_idsn fields entirely.
  Read idsn/iasn from msk->first's subflow context in
  mptcp_diag_fill_info() instead, per Matt's suggestion, to avoid
  growing mptcp_sock for a diag-only need. Verified msk->first only
  goes NULL as part of whole-msk teardown, not during a live
  multi-subflow connection.

Changes since v1:
- Cached msk->remote_idsn before subflow->iasn++ instead of after:
  the increment accounts for the peer's virtual SYN, and caching
  remote_idsn post-increment left mptcpi_rcv_nxt starting at 0 while
  mptcpi_write_seq/mptcpi_snd_una started at 1 for the same
  connection (reported by Sashiko).

v1: https://lore.kernel.org/all/20260825113355.3573376-1-kalpan.jani@mpiricsoftware.com/
v2: https://lore.kernel.org/all/20260827041058.2833707-1-kalpan.jani@mpiricsoftware.com/
v3: https://lore.kernel.org/all/20260902102125.2035540-1-kalpan.jani@mpiricsoftware.com/
v4: https://lore.kernel.org/all/20260903054853.3400545-1-kalpan.jani@mpiricsoftware.com/
---
 net/mptcp/sockopt.c | 28 +++++++++++++++++++++++++---
 net/mptcp/subflow.c |  4 +++-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80cb..56e10d27835e5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1047,6 +1047,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	struct sock *sk = (struct sock *)msk;
+	u64 local_idsn = 0, remote_idsn = 0;
 	u32 flags = 0;
 	bool slow;
 	u32 now;
@@ -1084,9 +1085,19 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_flags = flags;
 
 	slow = lock_sock_fast(sk);
+	/* msk->first is only ever NULL once the whole msk is already in
+	 * TCP_CLOSE (see __mptcp_close_ssk()); mptcp_close() holds the same
+	 * sk lock this function acquires via lock_sock_fast(), so no caller
+	 * can observe that transition mid-flight. If it does happen, write_seq
+	 * and snd_una below are just left unnormalized, which is harmless
+	 * since the socket is already gone.
+	 */
+	if (msk->first)
+		local_idsn = mptcp_subflow_ctx(msk->first)->idsn;
+
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
-	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_write_seq = msk->write_seq - local_idsn;
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
@@ -1099,9 +1110,20 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	unlock_sock_fast(sk, slow);
 
 	mptcp_data_lock(sk);
+	if (msk->first) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
+
+		/* subflow->iasn is incremented once in subflow_set_remote_key(),
+		 * which runs under this same mptcp_data_lock() (see
+		 * mptcp_propagate_state()); compute remote_idsn here, under the
+		 * same lock as the writer, and atomically with ack_seq below.
+		 */
+		remote_idsn = subflow->remote_key_valid ? subflow->iasn - 1 : 0;
+	}
+
 	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_snd_una = msk->snd_una - local_idsn;
+	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;
 	info->mptcpi_bytes_acked = msk->bytes_acked;
 	mptcp_data_unlock(sk);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d2342..a3313a3db5a76 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -482,7 +482,6 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	if (subflow->remote_key_valid)
 		return;
 
-	subflow->remote_key_valid = 1;
 	subflow->remote_key = mp_opt->sndr_key;
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
@@ -494,6 +493,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+
+	/* publish last, once iasn and the fields above are fully populated */
+	subflow->remote_key_valid = 1;
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.43.0

