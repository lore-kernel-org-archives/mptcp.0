Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599677;
	b=vLddle2FgAClV/dS2zFg99pKQ2+8WBmvELAJd7iRa8RTMlg5gD2iCgZva643xUQVA2Ep
	 JC5V7ylXMf5yfsgwlP07e75Rs+KVqeD2/qDT9wuxx/zgGai0G0rjrwdBZEFZl70FZ+Vfc
	 IQyTE/N1jU1OuBq9ya0YfxmOYLHCRSyJVQYqo40B7KjsWFilttu5e3hkRXmd/8GJM73Jp
	 ujHvJxrF8ixZ4IR0I+qVjWSKAxvrQYzP05h4EUAIYL2bfbNwTKXsaPEWkIH3gJ8l4amsz
	 sxxV4nL2Ufy1Goj1VeK6q4bhgEVNe7NFBbCdZlMg+pRKA9lX8Q+OuLKEvuj3x2qGUMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599677;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9z0phqwA/x/mKMnhrgbdQ+q0K6pjFpQy6EtNNaJiYlg=;
	b=u2qAvgPi8BZMenjFXFODCbIKNVzCpmLlYQXBzKtDB2FdClKd8Cx6zwKVxTv9m2Tk059H
	 acjCstQhh9P5ghmRQbD/QHbUaROPxW6LuWMeYnJWjK3uQgFxMmvWQTJLFk4yw8NvwIQ6N
	 4bmyGgrTMW/mmXMtojy0soiWt8R+BaYvnJFshCv9l2QiJ/YbCwDBxv/OWprJb1iNbZgG/
	 8vdr3pYz8dTq2Cvb3EDlicMr5Ul9hfxDxOhrWWgkOG8ao74kOELX1Z/zZSYuHOCvX2dXh
	 yJoaSzSQFNQFRfjScJzTCq6utXUI+3oGzQpVOdrHd06UzmQRVAwL4PT1q1LwuJZeEmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU7Iwgg3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147CF60A2616
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU7Iwgg3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90081F000C4;
	Fri, 13 Nov 2026 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599676;
	bh=9z0phqwA/x/mKMnhrgbdQ+q0K6pjFpQy6EtNNaJiYlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lU7Iwgg3l2zbdBX0jp1zTMnp/0fKNs1jkABcEvgLs6SJZOoOWKW6krXrn7HnlzYFE
	 LY/hsHKkaOOCYW0Pz6lEIuF7ySPZIQ5+1u0gucNQwk6Ry7I24DkyzgNrvsu+W2/mSo
	 NPvFVn1qodjp424k0pvXwwFvz6VbsSnEuYYQBE2etp3y/TQV+mI0/Knja0k/GcGuvf
	 495JV7NwFAMNCM1z/Z8T2FNU/BCgdg+kq3tuT3NUnwpf7Xuc9rReySztrcLwc+UQql
	 jZTl8h3A56zwGgCKRuOfXzzGX4nHJd6yRrOAchCVu5nAUeYV2TR4VGy1IhZyeWnAUU
	 anF9oqwrqC+VA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:50 +0100
Subject: [PATCH mptcp-net 12/34] mptcp: drop non-MP_JOIN cookie ACKs on PM
 listeners
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-12-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nAccD7htPNqufXaAEbi057sDDtIAX41OxigkYKSnCgg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z90q7jmkv2yyrtZ/+cXcYYUmD2NS706aFMTvkRz8S
 F/58gTLjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlImTEyTM2SX3JDv37JgR0V
 ufzZVa4PNjSU5RY/+PGV5UbplopX3xgZWj0l3h58arNeg0eg0q1cUkQjunR1aNiPaSJTlgvz7ez
 kAgA=
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
index 00677fb3efcd..14e4557c3a9c 100644
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

