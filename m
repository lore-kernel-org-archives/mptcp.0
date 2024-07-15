Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496218629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038222; cv=none; b=iHLlh0AKYwssIQJ3U1lGnsiSSmPB2uBTimslslBRtagPu/vQlrKLTcpbguxFgY065EceFlNaJT7kNzWR6vfUR1kdpojCwmmBG/Au3QGINq/FBcGm8PeLkQDwPS5xcXlVi9QzEP+Ac7jQxNH9VFaMLmm8JEqiZclySWhQXnvxXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038222; c=relaxed/simple;
	bh=QKZjq5FzzjLTObE8Ae2GrqDt6R0+REs2PPCkJTp/OgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRFirZvE684RPOBKMpvbZ0bfM4xAfK4EOWD7pPfpA5LFQwwDucaflxpBFlXuApxHSlJW0m54OtcP+3cBEOfDrHJHoGDswuOECK4JT60iayYAfSMRR7aIg1yKnZ5r3op1bZHEh44GiqZxo9O83tnxZarLkWPbNBddnHH5A1phycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDvpsEwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDvpsEwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFFBC4AF0B;
	Mon, 15 Jul 2024 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038222;
	bh=QKZjq5FzzjLTObE8Ae2GrqDt6R0+REs2PPCkJTp/OgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eDvpsEwJab+BmkfWqG9Ke0xrAd8gb7oPzE2QvcYFPVY0g7oWQ+Qba2szMq3o5N65l
	 eiU9s/in3FNQr2pqf54/CN4mfDEpXvowQej5vSIETGhbHpcON0SSgUOk0EwVPBIC25
	 iTTSqPY/HilP5fnNmqjqBn70J8UaF+TCCSRfZNQYwXFFt23KsR2pe6wQ0LdfEwk3fK
	 Q+ixllhGedQLYk2pMfxZivMiISwlHpuFn+WR0rnyIcOeatlAwP+Kjkg2c5ldZHENrJ
	 vKZQF22e+2Uak+YK2qkqcFoHzH1cmavYmr6GfeVEi7L51/MDRfnVK/PFhB7mfWBfMo
	 Fghhf2v+T5hBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:54 +0200
Subject: [PATCH mptcp-net v2 16/17] mptcp: pm: only decrement
 add_addr_accepted for MPJ req
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-16-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QKZjq5FzzjLTObE8Ae2GrqDt6R0+REs2PPCkJTp/OgU=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGaU9XfI6VOruw/C3lP2NZmpAMnGWRqVUTra4ya2amZerc9fM
 YkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmlPV3AAoJEPa3gk9CaaBzTooQANLu
 4rnykkGj3Z/YEQ4ot5StI5WzlwxN6dgcH6Lvb/lhBzqte+3Z9qqJlNeXtitRC5syY/nysEpLRO6
 Fa+9bSijtEkW8fumxaeqAIdmfYP+4iUZQYXmorp1dErRVOSPD5Qy9nT3CDnhB1Bu8cpa9XzNIhI
 se6sHD33ud3fRCSfCfL1G1DS3bYk8X5EAkwF909V7OmRIQO9g2y6FGkOx9LBoZQvIv0dN8WlKdI
 nyMmqIVo1u/8j8ZXvvo5u4B7INvuHs2+qPUd0g+0rQP+g2wIEmcC9JZOKDAIo8o0QSFN2NS1Jb5
 75tn/cS/HPdgl5dPcHKvMTqKVdlli1P7loCRalk4bc+d+4qGQ0b8t03+uCdMTONXFNo6NazYK/H
 DMDWdF8eYnr91Ljb3o6pjNxJ6T+GZFL4e+T1Jt3v0f3tBVXsfmkIantu0U8fuYrY1sFHVZ3J7+b
 QSXbHHvMrdo/3R/lHJ1hWOMfX1pEs2IOtj0VoBA5a0kHfU8YzwLdl3EvnTNUjcj2fhsYX4USNkg
 xp5wzvWu9SqPYZJQWDhAA6usxngwXXhvKFs/bd/LHIzUqv7mdNAfPRiEblxlfX7pfK7AmOqMcBc
 H84t0I+I1GegP6pR2MfN1RbVamtr9pZbX6uNPvfoyYsekZJVkdPgepsjE6DBqIA9smUjt8uKJrU
 cpY10
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
index ed24a7045619..d69d51309419 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -830,7 +830,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
@@ -844,7 +844,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
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

