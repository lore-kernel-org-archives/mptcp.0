Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349257;
	b=ItKij9uh0+tndxP2j1jreeksg/a1R1SoMzfYR8d/i2INUYLgYgg5pZONm1xSjfYaQohg
	 EY8Q8rXZmarBXL/uXQgQ7zmzcLSb6xX99yuM9g/nbiACUCHhuwkjUFsLe595B0xQVvpfB
	 j8hrNxbnDwR/i+emrX8JZi55h9rSUklGyvsQD5Hy0iJamdz9m3GDYXCEIMS8cFLmafQ2u
	 aZKCwLcBQB24cK4q9QJJ6ybowZD61H2M3Dl6WUa948ETZ1XatwU++GWAjlBI7folr1tLJ
	 xIqk7NaRDNX/BcAQdZykgGgm7qF5SGPzmz6CRR+jF7zvhTjz+hG3K0uyaWVMF+Dh0YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349257;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sD0M+vKgWeFaSJtWMQoKW7Y4KLM+Kz8QQh2wr2vp7SY=;
	b=K0DCt1aU5oWmbJ4AJ/1RRrpklXyBn2SbFGa1D2/VZxQBeoFweaoZjZQetWXY6gliot5e
	 13QWRYEMXw6lZ1lUwnmKMXHBhPvAmpvAkdCI/nL4omwkGQFmHfg3rk7aoBnsUt3+FlbaX
	 q6ZPYa5gGxQS++gWwbTrLuroNW/HSRhWfSlq70hVDZflGZPVP9Y2P5yiPwS9RR65SS7cU
	 T9q/1sb2lXpVgQRA1E4E4ZgTa5xcmYjxRAh8hWklygHXb9JzGNtQnvb8xNKSaYlz6g13C
	 1gguSjeUeYMBVgnJxKD0vGixf5N8/W/JnjSbYYEChiUQ53o0u+Ewb4vSSo3f9EDxIsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdwKRAMV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ECA606A32C
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdwKRAMV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4314D1F000D1
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795349257;
	bh=sD0M+vKgWeFaSJtWMQoKW7Y4KLM+Kz8QQh2wr2vp7SY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=LdwKRAMVdcLp40RXgq9AVPTfbYKeOJgyQwLzghEOkDohT4/tEiA/FhkOsZNiy96i0
	 M8MtxByFavY/tILo0qWpYGj2RlpP/a3DnhyiBq6VEGCiDV/4QG+JpSvr+x4wIhmSW3
	 F8b27uX4dn8p6xv3THOUXiDLEVyfEebEGYB6MuHdQO4A9shudwnVB/Tzbx3ovXRoAe
	 HCbZpRiGU/KU0lZrclr6g2wdHXP7W0uFtdMVNuBZOf90HT50QdkXsAUtJRr0ieDFVg
	 zZdjFxqUUsWKPz82PWZW98Dq+MHTQaasWfHZLpZPl9i6rNzSiCs7cH4J816w6NfE8l
	 T1hUOUK/FV31g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 2/4] mptcp: add missing memory barriers for rcv_data_fin_seq
Date: Sun, 22 Nov 2026 20:07:27 +0800
Message-ID: <da8ae9e6c48df602b08475d151a87841ad632400.1795348666.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795348666.git.tanggeliang@kylinos.cn>
References: <cover.1795348666.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_update_rcv_data_fin() writes rcv_data_fin_seq before setting
rcv_data_fin, but there is no write barrier to ensure the ordering
is visible to concurrent readers.

mptcp_pending_data_fin() checks rcv_data_fin and then reads
rcv_data_fin_seq, but has no read barrier. On weakly-ordered
architectures, the reader could observe rcv_data_fin == 1 with a
stale (or zero) rcv_data_fin_seq, causing mptcp_check_data_fin()
to either process the DATA_FIN prematurely or skip it entirely.

Add smp_wmb() in mptcp_update_rcv_data_fin() between the two writes
and a matching smp_rmb() in mptcp_pending_data_fin() between the
two reads.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/options.c  | 1 +
 net/mptcp/protocol.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6365e180d9a0..2b04f083585c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1192,6 +1192,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
 		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
+	smp_wmb(); /* ensure rcv_data_fin_seq is visible before rcv_data_fin */
 	WRITE_ONCE(msk->rcv_data_fin, 1);
 
 	return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5ade9c25d0fb..ac7ee8deedc7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -567,8 +567,10 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	if (READ_ONCE(msk->rcv_data_fin) &&
 	    ((1 << inet_sk_state_load(sk)) &
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
-		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
+		u64 rcv_data_fin_seq;
 
+		smp_rmb(); /* pair with smp_wmb in mptcp_update_rcv_data_fin */
+		rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
-- 
2.55.0

