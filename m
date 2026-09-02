Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF0543CE4B
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344505; cv=pass; b=U+y2Y7AjnGE+XZtccG3Lep96sgl6rxc5k6PIgArXABhx9zxaSlePMISSJ2LhzGRuRVvEE3BU1mfKZZycDu2K5Tjd4GJQbcj6IISu1AQucFc0G0hDWNiLPMEGXJPhFlJkhUBI/DYR1k1GTsQay+UtfcYIuaUFBfYztzctRIGacGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344505; c=relaxed/simple;
	bh=Y4n+NsHuObBt2t/dtGApMQS84GoRLcxErF8cYWbuzZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyPUIZYiGSfR0p81gIcsye587ps4phDkkrzjqkWHt7herA8alPKd2zO18nbsdG9qPVsqou32Xih7QAJxF1bJaFbSTXnwggh1naD4ey31epqtCnC1Wson10/hpVgpH2VJMhi6iQ3+9lSQwP2zx7VQKPR8PiHJBB9V9YNoQPmMiKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=W5b90Lvk reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="W5b90Lvk"
ARC-Seal: i=1; a=rsa-sha256; t=1788344495; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZwJnjUlV1SI8ShhTkiRgklZm9cHe4vOnrbf8xYpkN8mZzsIm66YbsTIcv2JZR2sMlgvhAOcuFRTQePmYl6BXenjwLzzpps95KZPxxSoFyMgI76cNZYR1fiKKSsfAS8h5vFqM1Ga5xe8i4zbOeLCY2Q+MhYO3Ut9phM9v4ArvfXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788344495; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KEhnYv/y0K/PZddFbltoXnwBkZsGwPqXRIaVJaPbj+g=; 
	b=M0bkMrst0agPQKRcJrryfkg+BJ7D6vvPdd1NI/FiO/+r4UwWWDv7MVUADts+kuNkD3saXeTFrjGg5ZcGNxXXyt+xPhQIYmU0EMzSSCQDu37Y9LviTAq4rwBFJGZoWGOZliG7C1JhTOgnqQpt9CgcF5IoHoUsxzyveH7AjgyC4SY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788344495;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KEhnYv/y0K/PZddFbltoXnwBkZsGwPqXRIaVJaPbj+g=;
	b=W5b90Lvkz/F0qA1o6Ao2smJ730pY+7oH2nf+ysMZWGQeHBkTkcrqXlJd6kqeuKW7
	FuySRFic9eJXGSg5z+nmLzVKiRiW2D4RonE/teT+cWCtR/A1iEhjzpHmFM28i9fS9xs
	yy+sh8QoZgp1/SQexhwxmB5aLMvOc8q2LjWIM62A=
Received: by mx.zohomail.com with SMTPS id 1788344493561554.9517492555292;
	Wed, 2 Sep 2026 03:21:33 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net-next v3] mptcp: normalize seq numbers reported in mptcp_info
Date: Wed,  2 Sep 2026 15:51:25 +0530
Message-ID: <20260902102125.2035540-1-kalpan.jani@mpiricsoftware.com>
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
TCP_CLOSE, none while the connection was still established. So a
NULL msk->first at diag time just means write_seq/snd_una/ack_seq
are no longer meaningful anyway, and the subtraction safely no-ops
to 0 in that case.

subflow->idsn is set once at handshake time and never modified
afterwards, so it can be read directly. subflow->iasn is incremented
by one in subflow_set_remote_key() to account for the peer's virtual
SYN, and ack_seq carries that same increment, so the increment is
undone here (iasn - 1) to keep rcv_nxt normalized against the same
baseline write_seq and snd_una use. This mirrors the fix from v2,
which cached the pre-increment value directly instead.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

---
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

---
 net/mptcp/sockopt.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80cb..5026ccc55e230 100644
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
@@ -1084,9 +1085,22 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_flags = flags;
 
 	slow = lock_sock_fast(sk);
+
+	if (msk->first) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
+
+		local_idsn = subflow->idsn;
+		/* subflow->iasn is incremented once in subflow_set_remote_key()
+		 * to account for the peer's virtual SYN; undo that here so
+		 * rcv_nxt normalizes against the same baseline write_seq and
+		 * snd_una use.
+		 */
+		remote_idsn = subflow->remote_key_valid ? subflow->iasn - 1 : 0;
+	}
+
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
-	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_write_seq = msk->write_seq - local_idsn;
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
@@ -1100,8 +1114,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 
 	mptcp_data_lock(sk);
 	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_snd_una = msk->snd_una - local_idsn;
+	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;
 	info->mptcpi_bytes_acked = msk->bytes_acked;
 	mptcp_data_unlock(sk);
 }
-- 
2.43.0

