Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254166;
	b=PKBuH5UWqzX7PwZ5Bse/utoUonGFj/yzoxJDropR4c/jdEQRJqW6rKVOG4soHnJOoQ7/
	 ACAEj1dBvvD+fOsZWz4PBJojXa9KnyLBH7pgiMExnr3aDMsYsJ3nfLrzSF5Sz+sBLefdh
	 /BmTYdUS2yqc9396ooeBOjfI1U6yPw6MKOqZU47PvRFQ2+R03PiJ9Yr06G86hkmNSl53o
	 I1S3CIIEinU4rjhB2719PsZ/fS4JbmbsAsC4dzGP3WPe1DaheL27Ecz6c5+jrdGkUPagl
	 4lfS8PrgXmlGvgYyEN628XFRcxqZSkDfaki77YJb5g9/Ian+Z5O/Kq3yi3e1rm6ncBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254166;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0y7f5/sxZjXJqgSd5XI2WbJo591UdVzTTtgmbftrFRg=;
	b=4JOOI205sbsu11QD12ZsMWIu39XgyM5myKzBoGz3Qh5U4Y6IJ5nnsS29oWXeI8IVrMW/
	 SiaJjv/8OP0MVLcLUJ1q/FiuRdOqcU6YEVzG8DGtsEFn7YqJVa6FjEjXY0Fq8uV7uGb4y
	 XgMVxqrMGKiHLfNxI5sF+S6pe3MyQjJL85WMxZkTA9rqaKk7qE+tHD1Dqegfj5lPQOBV5
	 qlYwo84OXinwRsxzKMk0oqenIwFco6elLf2/FMZh+TQoMG8g7d4K5uY5XUn2Lbr44Pu1B
	 QETAQGzLPJzeMGjOUT2oVE2Kclt1CRCmAlrKHAVbA2UVgCu6o2erp5U0D2Px4nii6mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrEAST3l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23686606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrEAST3l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690661F000C6;
	Sat, 21 Nov 2026 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254166;
	bh=0y7f5/sxZjXJqgSd5XI2WbJo591UdVzTTtgmbftrFRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FrEAST3lLko0N6QPOWVC6DY4zsLy6Ggx+veojba8LCZsHVDfI+goArwIwKncu/E+p
	 sWtL99uJ8jR2hJFs4qzv1jY4DWrXPV7TSHYLJs/X5VF9h7viw2pUIBqNX9ap4aQlHI
	 DI1vpTmLuYxCuPAVF4a9Ew635Kkm0cgiXD25seNW/Kvm+1nXG4W0KF6KA8DqVsHGSq
	 CrKa8SSTry7t5El6sdPuhVBk2kKnkjatKZYqAKLwhPX3rO5p9pku1eLk6AXXLBQi+p
	 5flpP+6gFpc7TVad9bkcGQyVdMwZ3sm0pktkOCeC4E29tuHPJTGelgUNvSNifCWqN+
	 ezJheS5bRK20A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:29 +0100
Subject: [PATCH mptcp-net v2 31/62] mptcp: drop non-MP_JOIN cookie ACKs on
 PM listeners
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-31-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mvP9dPvMO9WcK5n0ED/hpdYpE2ahF96caseeY0WKWyY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0+OPVkjO+furOqNBX9bC4La90W23l89df++Sivr+z
 nO5bsORjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlwnWNk2Glu7bB0rtHpDKP9
 /359f8MZ9KVmdZNy0U7pp29FL7jWvGL4pzxvbYPBvOTHurVLz05dtMdMjpH1w03GD05B8e86fr8
 v4QcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

With SYN cookies enabled, a port-based MPTCP signal endpoint can stop
accepting new subflows until it is deleted.

Nobody calls accept() on the listener that the in-kernel path manager
opens for such an endpoint, so it must create only MP_JOIN subflows,
which never enter the accept queue. The listener is marked pm_listener,
and since commit 3d041393ea8c ("mptcp: prevent MPC handshake on
port-based signal endpoints") subflow_check_req() refuses a SYN with no
MP_JOIN option on it. But a SYN cookie does not record the MPTCP option
of the SYN, so mptcp_subflow_init_cookie_req() picks the kind of child
from the options of the ACK, without looking at pm_listener:

    ACK with a valid cookie and no MP_JOIN option
      creates a plain TCP child, or an MPTCP one if it has MP_CAPABLE
        which stays on the accept queue until the endpoint is deleted
          once the queue is full, the listener drops MP_JOIN SYNs too

The fix used here is to refuse an ACK with no MP_JOIN option on such a
listener in mptcp_subflow_init_cookie_req(), so that the request sock is
freed and the ACK is dropped.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
a client sent 1025 ACKs with valid SYN cookies and no MP_JOIN to the
listener of such an endpoint. Without this patch, its accept queue
stayed full, and another client could not create its additional subflow,
even 130 seconds later:

  TCP: request_sock_subflow_v4: Possible SYN flooding on port 10.9.0.2:6666. Sending cookies.
  [...]
  C2         4.007  [130 s after C1 has gone] RESULT: subflows established 1, in SYN_SENT 1, the service works
  --- V, after that try of C2
      listener 10.9.0.2:6666 Recv-Q 1025 Send-Q 1024

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment, the details are in the commit message. Commit
  message: how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0c97a5ce2d0c..f9ed4cfa4b33 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -312,6 +312,11 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
+
+	/* PM listeners only take MP_JOIN, like in subflow_check_req() */
+	if (unlikely(listener->pm_listener) && !opt_mp_join)
+		return subflow_reset_req_endp(req, skb);
+
 	if (opt_mp_capable && listener->request_mptcp) {
 		if (mp_opt.sndr_key == 0)
 			return -EINVAL;

-- 
2.55.0

