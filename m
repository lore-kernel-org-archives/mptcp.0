Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D421DF748
	for <mptcp@lists.linux.dev>; Sat, 23 May 2026 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779571098; cv=pass; b=Qq5sBKixW/etumI+J0n2NGQA3IXvqLcXhio41VXIGz9aGImamEKagj4LyWm6dO+l2rwaYRcaYCgOpJ5BnRuxJ1YKV7Kt7bhpqDSEkMHI5/pfJnQ/Ltued7BIKEkUPAwJeX1/RHP+mQVlF/x/MG7pX9qJ8Fk7Gldc1Z+NduMSd8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779571098; c=relaxed/simple;
	bh=ND4P45RwCSWMveumSBQZosWYtfOv+AGqEyGR/wmkwNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Utosv+GZbXi1RIfva5tQKzAq3GkQ/ERj4I8u4nrjxtexai1ul5KojIs8KSIvmJxBSfaUSoslSugJpWlCCDJjmMtRY478xrJQvl9IXHbzlUGZLhJRjUoWsd/H83KPR5goLqpmhujRcdckgN7sy3K0q29V1/iV8kdPeQL9beFmVQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=ZsaXMEby reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="ZsaXMEby"
ARC-Seal: i=1; a=rsa-sha256; t=1779571092; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gmBim9foPZhRRU7vmRy5FKCLT0sYf/3V3Zf65gPQLBgxw6FNpEktyU1/+xVs6GXtOrwmzZA+93Mx0jsEVGIcGT6JzjI6cBU/aE/c7H1RbJHYXygoY/VZeEyJwIlDLNzUB2qxSrEKNzMV9Fs/n+M5rw/Vqu4JxUozx+XRkojGvLY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779571092; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bDOjnNJxQG2PxceOnKYN5W1mERZaouOnolN0GKCKn4Q=; 
	b=i/P/0bpT4Y2trSZ6G+2bF2u27t/iSmWzZFAltqWOdys6QOAKPr+So4tBJb1631oJMEsRRYcEXWBHO1vVvEEH9pkpmJ73n6FinRQRfOI3vMw0wkY7nyhzLvKW3XaJKv8ZX+PiZzm3/NdLBsqnUUAjKNXkG0lMCEbqmm9to+g1fas=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779571092;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=bDOjnNJxQG2PxceOnKYN5W1mERZaouOnolN0GKCKn4Q=;
	b=ZsaXMEbyIWt+rLkefHv8iVYaTGYum0WgRXOebAZ/ffltBC8AXLkDmFK5e8eL+GiP
	XyEO4Moy1AsyK5HKyqMnfJPvSFsbE88C0y6i8kmBoS+0VkfLcpxwqN5i+es2Qzmu3s8
	bAp5h2F7D7jQ3b8LjdQ8iSbazpXrLA0D74yvW9EM=
Received: by mx.zohomail.com with SMTPS id 17795710893391009.7707119522464;
	Sat, 23 May 2026 14:18:09 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-net] mptcp: fix divide-by-zero in __mptcp_push_pending close path
Date: Sun, 24 May 2026 02:48:00 +0530
Message-Id: <20260523211800.2952905-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

A divide-by-zero in tcp_tso_segs() is reachable via __mptcp_close_ssk ->
__mptcp_push_pending -> mptcp_push_release(ssk, &info) with info.mss_now
== 0, triggered by MPTCP_PM_CMD_FLUSH_ADDRS.  __mptcp_close_ssk() leaves
the ssk in a state where __tcp_can_send() is false (FIN_WAIT1/2, CLOSING,
LAST_ACK) and then unconditionally calls __mptcp_push_pending(sk, 0).
For such an ssk, mptcp_sendmsg_frag() returns -EAGAIN before reaching
its tcp_send_mss(), so info.mss_now stays 0 when the trailing
mptcp_push_release() feeds it into tcp_push() -> tcp_tso_autosize().

Commit 1094c6fe7280 ("mptcp: fix possible divide by zero") covered the
alloc-failure branch by moving tcp_send_mss() before allocation; it does
not cover this -EAGAIN-before-tcp_send_mss() case.

Initialise info->mss_now and ->size_goal at __subflow_push_pending()
entry, before any early-return path.  Idempotent with the assignment
inside mptcp_sendmsg_frag().

Found by an MPTCP protocol-flow harness extending BRF
(arXiv:2305.08782) via the MPTCP_PM_CMD_FLUSH_ADDRS kernel-PM admin
path; the oops is reached on the first qualifying run.

Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a72a6ad6ee8b1..7977f60f98474 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1627,6 +1627,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
+	/* Initialise mss_now/size_goal: mptcp_sendmsg_frag() may return
+	 * before reaching its own tcp_send_mss() (e.g. !__tcp_can_send()),
+	 * leaving __mptcp_push_pending()'s trailing mptcp_push_release()
+	 * with info.mss_now == 0 and tripping tcp_tso_segs() on the divide.
+	 */
+	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
-- 
2.34.1

