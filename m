Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A28EEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004132; cv=none; b=XSGjSboGTB0BSlK7aYNDBfkVE9MNHpWAZ7/JsXYOfHIv3Wzs+hQ6SRR7k6dCoKo4518rPbvdpaEB9ittR/Igqy0tr52YBw2sMNTTNRrv+XsNnPb8fIGfz2ZeB/TL7tOytkKyxPFbv/4QOwlheIgmJdlYyvz2rO52oGXn59gLaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004132; c=relaxed/simple;
	bh=mduGCcRiIBP5OAgif5NxHWNVDMa/IglXvs1M/ZW6KUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCxB8U0nxLZDsHKeijcxilj9HoRIT2MjJJx6+/z+eJD/E2/F8Ab8zakKPHNaIvttccr8So+Leofb6xd3rOu5B8fO1ASQHfrRxiNsBIYJ4APJhosdx4dnzo91GGPdl8rbQPeGl7gHuBjxS9aMbwPOShFvyA5bl+kO3cTGBg4FV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcBPC5jA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcBPC5jA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AB7C4AF07;
	Fri, 26 Jul 2024 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004132;
	bh=mduGCcRiIBP5OAgif5NxHWNVDMa/IglXvs1M/ZW6KUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WcBPC5jA/qgwV+uuoXR6NlzX2zdtjPEhANcTFCQHtQfhlwPXfR1i2nycbqRAViWzm
	 WcJX49VLmhwDhwgx7NDQPbBYGJW0zpqlOkMZHDvMsIbsWXptos6CsQ9DY8VNcMkHQv
	 sOFKI0aTwWGWnVZdyEievaCaUFfu9LtlOaltPf4v0xCoe+G21e7BNG0OBTicB4ZDhM
	 mS9S9wvKmMB4OjQQOHFlZ+jAyTzM9fWbPtXLZ8DPBvdhtTpXnSvAF2TSTCtSYwAtMD
	 ia6Lswx+vjNt46l55uwODe3CMepdLwKifhHWoVhs60Nt7Sh6+EUlR5EYlE+cSV6ZyI
	 dDU9Pg0knpOGQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:31 +0200
Subject: [PATCH mptcp-net v5 05/13] mptcp: pm: only decrement
 add_addr_accepted for MPJ req
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-5-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mduGCcRiIBP5OAgif5NxHWNVDMa/IglXvs1M/ZW6KUg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KcbU1IKILfLpcRR+eMm+dE7ZCuOzCyVtPBT
 5ghiWsDyIeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 c8I0D/9pRyka/ZPynJ0zjmmFLw5RIsxKtHYG+hHPEe0NuzikXUU4zy+MIDErVFsZ1+S+ly3C/Xq
 64Lj6acBd5d9B2WEn0PJ06hmFUBe7nFSPrfcOtYqPARdtoIAJnVIp3VglUsHESVC/0cAIvuOOdo
 Rjk6Ew2834G4u5A+qokzJ2iFyppSO2AOvW+CVAHCZHUhJ5HdEEthQYGnAhL6/a0W4By4oVV86bG
 Ztspfg8bdw/VRhzvbtW9a4J45Iq+284RNTnXOCNmXydnnpi8kQiUAhyF4/dv/Tu8sfrot7fhUtZ
 xuEACvB5UEDeG7CTeFkf84CaFNpxVwODxj1VodDSzK8CO1FFYhpgM36BVIQDGNi1yFu5GkzntO7
 hXYSxAC5OLLcHGziP2QHZpRTx3wz8gTy6iUFI+hbYco8PHiHQpBnNrTaQHBAThE5o+JhUdxBUJH
 4QtDMT/gONO/0MA4Sb1A12P60ab5tCgu5xw1zddPCi0qpHlP35Dyx78dT3u/SYDScuIFsgPPAiZ
 CB+tnDZjmPUFuEUiqpiZyPPMOyPoCyHuCjmui1G4yHKuzfz3UnCOfDq6eslf3zK4ZmT3onW9sW4
 Mjj99/MQpg2mBdvwkhKT9FU1EOrqbJTvzpB5XXR+c94ZnoYUZfz/LOK77/jzBuwyvGcxtYzEiJ1
 5Rr/sRt7T3w1J4Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)

... before decrementing the add_addr_accepted counter helped to find a
bug when running the "remove single subflow" subtest from the
mptcp_join.sh selftest.

Removing a 'subflow' endpoint will first trigger a RM_ADDR, then the
subflow closure. Before this patch, and upon the reception of the
RM_ADDR, the other peer will then try to decrement this
add_addr_accepted. That's not correct because the attached subflows have
not been created upon the reception of an ADD_ADDR.

A way to solve that is to decrement the counter only if the attached
subflow was an MP_JOIN to a remote id that was not 0, and initiated by
the host receiving the RM_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3ea417b52ff4..061fa3183eca 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -829,7 +829,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
@@ -843,7 +843,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!mptcp_pm_is_kernel(msk))
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
+		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
+		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
 		}

-- 
2.45.2

