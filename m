Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBD1B9B27
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032211; cv=none; b=FaV+Z5NMYzkHoC2E7IThib7Zgi/492HWFxlnKcdW/u08TKJccGCG6WfWuLINSWUXyUGQumsbrYgHVev6xw3oLxB448OvwGaW1YgByG6d5btQqBns7rvgdK5yt9p/jUtyE8PO8Qsy+/ZvZrIg8OUOM3dGtyBexM8HyTrPE2l2jRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032211; c=relaxed/simple;
	bh=SRUIWc8xECvDd1lAdDNH4oC3EvajDbhku1Ug/GpfGRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z7/gyOEIxj1OXR7g69GwEbpZLG4uml7QW6PXrBtX0S93BpEK6iHUTV8RCTZTxgB5bAi41R52PPJNgJE2SGVvUFiXrx0gJmFxbww1H5Q6gzvIAiz8W5XUKe1W8OdRjsXefrHiCqy73bDm6c4z8YJrWROxtLSM3Eq3Xyw+KHqCMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+jnwmiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+jnwmiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8593BC4CEC2;
	Fri, 30 Aug 2024 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032211;
	bh=SRUIWc8xECvDd1lAdDNH4oC3EvajDbhku1Ug/GpfGRQ=;
	h=From:Date:Subject:To:Cc:From;
	b=g+jnwmiv9Y/GA/eNLMSTqlduho1kUgEWBd40vDpMkVqVoYTYIShJVxeTiBYYoHPHY
	 ihsSNOZg7XQJ8OX5i9y+1VU2osiSGcIaK6PXwPpHDvgrm7I72Q36J9nb0jjIvtkkmA
	 SjkC9uiwxMUMnvmUaxWB6E91c7vryU4jNpNSiY3Lu8qWfhzMk0wGUgxFcrfcECEkx3
	 x4NSgmipfQYXs1SbSEt2KmzjRdE+3iQv/huA71fxQ65h2bRhGk4f4vcuqUxYtRL/9/
	 d4GX/b25NjEq23tzqhahYuM2ADWnvwhs1Ps2WX0w6IWlRblQ1mBGQUpE3gWLxY61Da
	 IIUNY0DEdVDEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Aug 2024 17:36:12 +0200
Subject: [PATCH mptcp-net] mptcp: pm: do not remove closing subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-mptcp-pm-minor-fixes-v1-1-89737b847a8d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOvm0WYC/yXLQQqAIBBA0avErBuwxki6SrSImmoWmmhEIN49q
 eXn8xJEDsIRhipB4FuinK5EU1ewHLPbGWUtDa1qtTKk0Ppr8egtWnFnwE0ejkhdb1ZFZDQZKNQ
 H/kaRI/zC8QVTzi+LqyuAcQAAAA==
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SRUIWc8xECvDd1lAdDNH4oC3EvajDbhku1Ug/GpfGRQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm0ecSjHjg3sXrKatVGpExmgZNUI2kjhxKtQAYo
 +GgnNn9iDWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtHnEgAKCRD2t4JPQmmg
 c3GkD/4objxIvqW12PGUAdSI7om3RZ33L9OWwBMs4FBzUnbRNittB0EYE4Bds1GJeCR7Jacszqv
 ns5JkaZ+JKqgYLLz/+j3oQqIRIKqcF2wpIy13sQBqWhyk7SqEjrm07NbQJsfofJ99fi3IflGFsG
 iRWWup67MUmWkaDA0c15lOiIWy4CfXNo8PwGmdiZTqGTMGh6uBidGnbYPHxG4ljkKqvHpdUUjn7
 rIXeF2drBahzPZkj875irPBYsi74yt8TwLS4ClTC5BHfkrk2toxu6yPJ1bbXmB2bqoxcsIDMv13
 Ta+UiD7RNzyi0PqyNH4oG/28gu/4rDqUa9ONcNzSEE78tBvyi4eaI0NYSiI6r0kNVoxi+90Bm2w
 DRUzACagqOTGLzeas06Kt3nPfOs+ej+xhXEErDTVk3L/qxyhSmnyyb7134it4HhWb+4yX8gb116
 b5PmzmueAAzP5Mf1tRnQY/HjWer92e4WLMVvBL3u02l/A0zcObGEtIcQIfYP/vHJg1Qju99ro3C
 lfEHUygZRxFvx8carFxVZ+ziq1m8tkB3jEiB0a0Sqf7DRilzBD0XH3vfqZ1DdRF9wJO7uXc+GBC
 Frs3y3nPt7aLPGkjJ20zY26TetCfywHAtVmOR/RdgkVlqSNVOex/QvcEAl3nKIThq5Iyl9FPmkM
 BqKyNXJWuCaB1uw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In a previous fix, the in-kernel path-manager has been modified not to
retrigger the removal of a subflow if it was already closed, e.g. when
the initial subflow is removed, but kept in the subflows list.

To be complete, this fix should also skip the subflows that are in any
closing state: mptcp_close_ssk() will initiate the closure, but the
switch to the TCP_CLOSE state depends on the other peer.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: Fixes: 58e1b66b4e4b ("mptcp: pm: do not remove already closed subflows")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- I'm not sure looking for TCPF_CLOSING is really needed in this case.
  I can remove it if it is not needed.
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a006ce39d41a..f52718e1c30c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -862,7 +862,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
-			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+			if ((1 << inet_sk_state_load(ssk)) &
+			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
 				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;

---
base-commit: 6b336f0e1c2b1f649f86fde82abeae5b87ce09b4
change-id: 20240830-mptcp-pm-minor-fixes-3578d0338438

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

