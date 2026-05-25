Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C6DDA9
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779669171; cv=pass; b=p/UmyZEv66zXqMoRvQPlZguwUqJnNO36Yj+pDk0Hv4X2UjC5VmVYktB5Gd1UDsHau3Hm1/9ODu38hoI+NdUTJfN3zNH9Qz6fWTU0s3Zhkl+bZAxQyAelK51b2ICJFxkqOIELKc3dDiIiISwRDYGKoNnTk02FZ7PHRkvdvAL7830=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779669171; c=relaxed/simple;
	bh=LbEinYMuCL0BJ+QonuQhd9KP6K95KzrBN6KkXiijor0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQer+P0wF/XtFR3lBnsYIMK06Oy0qiTfTOY1H3wNl25gNkQu0Z2X0ufgW21E7QY1helFq1wTnfGDP2K3inpehKwdbrA8H/pIjn3gc8LNuG6j0yvwuHIPfi33rmAaADhPqL85BjVq9AJLWTWnBEFICsy15cr1TBLSf5/p1PtIB1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=hoLaOYdW reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="hoLaOYdW"
ARC-Seal: i=1; a=rsa-sha256; t=1779669164; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VVkGPsDzebmzlD+M7N4403MD+NOoUuvULb7fX8ZQeYTzQnm4++A0G7Hazf9UBiFY6aMht256pJxnxzcdh7R87Z9g3+ZGHSGeabHtnLHL/2am++S5fmNzsuIurEDYMyrmVq2aw4c1W5+hbGM9vwXt7gbkNxJzw9juwsGSAH+Ye1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779669164; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0c5WJBRC3k/9zeh9Wr3+8UoKQeG7516mXFx764U0jeU=; 
	b=b+OeKRypIQm8toWF5OrpNfuhEO91AjuDJRhKSTQT2BxM/MmNafNqhpX6p/H9IReaWP/Jwisx3srSOKOCeS9vpOU+I5BGbRSkoIb2/ewhWXMl6nOolDLf9QiylWeQL91rhXtsTJ2913rPIo1Ij3JhHHgIrcWAD5FsQLMEjFcZkrk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779669164;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=0c5WJBRC3k/9zeh9Wr3+8UoKQeG7516mXFx764U0jeU=;
	b=hoLaOYdWq6qVHTTf62YsWvqI4Azoxc1UJ0bCOqwGmn5wirM0MQvy9fugw+5wvUB0
	fY/+1boS2h4LBNSljnU08wVHNhKG/PPcGJYErpe6o++cjZDxXsItV3/tRa+mv2U+L3y
	y9Iky2gvLyE4A0GAPf4uVr3Dj8LpCNrzY6Wl5uYw=
Received: by mx.zohomail.com with SMTPS id 177966916130166.1803714944607;
	Sun, 24 May 2026 17:32:41 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	pabeni@redhat.com
Cc: martineau@kernel.org,
	geliang@kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-net v2] mptcp: fix divide-by-zero in __mptcp_push_pending close path
Date: Mon, 25 May 2026 06:02:33 +0530
Message-Id: <20260525003233.857172-1-shardul.b@mpiricsoftware.com>
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

When __subflow_push_pending() returns <= 0 in __mptcp_push_pending(),
release ssk and clear the pointer in the existing failure branch, so
the trailing mptcp_push_release(ssk, &info) short-circuits on a failed
last iteration: info.mss_now == 0 cannot reach tcp_tso_segs().

Found by an MPTCP protocol-flow harness extending BRF
(arXiv:2305.08782) via the MPTCP_PM_CMD_FLUSH_ADDRS kernel-PM admin
path; the oops is reached on the first qualifying run.

Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v2:
- Replace the __subflow_push_pending() entry-init with the slow-path
  release_sock(ssk) + ssk=NULL inside the existing ret<=0 branch of
  __mptcp_push_pending() (Paolo).  Keeps the fix at the actual exit
  point where the invariant fails and removes the per-iteration cost
  in the hot send path.
- Reproducer status: syz-manager's auto-reducer returned 0 on the
  original hit; a syz-crush replay of the harness workdir log against
  the unpatched build is ongoing.

Link to v1: https://lore.kernel.org/all/20260523211800.2952905-1-shardul.b@mpiricsoftware.com/

 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a72a6ad6ee8b1..44c8d048679e9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1711,6 +1711,12 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					    (1 << ssk->sk_state) &
 					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
 						push_count--;
+
+					/* Prevent the trailing mptcp_push_release()
+					 * from pushing data with mss_now == 0.
+					 */
+					release_sock(ssk);
+					ssk = NULL;
 					continue;
 				}
 				copied = true;

base-commit: 6c7a815d6a7192e42bb1875202df1d48c3a83e64
-- 
2.34.1

