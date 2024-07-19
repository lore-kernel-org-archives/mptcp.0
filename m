Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AC83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391895; cv=none; b=O8iCL/rjoKwhI63F7QNDapoJyZ9L7IQoVB3asPblUt8iNxXbo+Vi4v5vkY4busA23BeFXad0DxFst94o8OjvJ1REnh6uIC/DJgiM3noBYYfdsvKwhE1YEqUOAR0uPEP6qKYqE83FQjAK2a1bQ5sI0LTvW/gn95d/zAcfbxnjl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391895; c=relaxed/simple;
	bh=TWpomIPCHdgqln4Z9R1XvaM1nsH19QkgyOXDZ5F+sDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5gSz02nJRQuEd4uTev+h+eVKJdF1Iw1ULevMDsJy9xWrD15PcCgSbff+LSXZk8Ky3PHO84yZDSUnY7WnrTi9vN/bgEoqSe/fNNEeZrweXowLktBYmD9THxFdTGlbb+mSYEhl+gmqoxgdjhMzq7pNPfPRklCthGsxPeEMHZ/zp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+Hwz4DT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+Hwz4DT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B727C4AF0A;
	Fri, 19 Jul 2024 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391894;
	bh=TWpomIPCHdgqln4Z9R1XvaM1nsH19QkgyOXDZ5F+sDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R+Hwz4DTNm4BuVSZXJZmbTqiVte79ebKOAhaa6EyADWJGFEO5/ZaBbgICCCDCpKsR
	 t4jjt/UNEfIAnrjvnHOBxHHPQ6F06cElOiaJTJAXdKT75UXowlHB8Tryu6SToT0j2W
	 XAwFSgM+jafa3fX0gpI1IAdEE+aCKvC24MmuVlwTxzOU84xnVf5N6cODr2g/oH0U5B
	 WSAHwdgCpNSTvy93JGiDiLjN90otSZKq8rjSzba0AjMr5dDFzQ8PVXgW4o80JFHFir
	 /FuENoBl2lJN5//pW1UXqeqwtlyBI8owKttGu+U1F5TMiFiM3Nzlg0L42E0w28PmDB
	 RWvpUYCVQ/ujA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:29 +0200
Subject: [PATCH mptcp-net v3 18/20] mptcp: pm: only in-kernel cannot have
 entries with ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-18-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TWpomIPCHdgqln4Z9R1XvaM1nsH19QkgyOXDZ5F+sDQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsAe0SlkH9Y8ultj62cN+aMBN4+RkuGotQnZ
 u/1GVOe1cGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 cx8nEAC6Gc6aUNyQf0a6eK1jJhlFlHIbvrInKzNJrxnUX8+KIID7+y8QsoH9yTDSFnvzDuq6p08
 YPJXUYDePRF7W9toFtGte9dVAyKozcNKkOouHriT40AfxssPdEQ92SvQJ+tmfbEhK7EgqIkItoZ
 41YUvYdyAcFqj3wmaDH1By1fPXNTMuu70Pry/5kVdIOmaNGv9YLb4LK6VbWk2IVz0gKCELafzDk
 RMtHp46hzQWb1Z/9opSZrQLP0frl/VdDXjV+4hhXCWlR4gjruWobfrgrpzCTWyRo4soHrj1UVz5
 lSbo7qwsj2CjCqkhrvLUxfioHtiF6yllyBG3XL/dXrpqiESkfvwj5u1EIbM2kP1ApvwqUf++8CG
 HPX4X1su6QKf6qFpFmCiVEXEQgMsD8/M59qI/si5aFFBwiLuYpdpS7JLbzgrv7BWcFr4Tn7RdUc
 rG1qtfH0wrrSoGNwt2jub9nGqf7I9vq7oAvrg2EcRN1wER/K2Kqa4enwQUN7hWGAgKNQbfDI6Xi
 u0a2Rdyy0qDnqecD+RgGroSaR97dRNmGINjHRr4yzv3zqwxKmyEmjEstBExppO1l3x2H8GsQ0g+
 lR0OUM2WSDPGFublxxYUA9Jy+ww1mD4cBmJ8Zyn78wpAjR8o+9SyILvHs6on6A+k+W9B98MIh2J
 40UUO00SWE+bTjQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The ID 0 is specific per MPTCP connections. The per netns entries cannot
have this special ID 0 then.

But that's different for the userspace PM where the entries are per
connection, they can then use this special ID 0.

Fixes: f40be0db0b76 ("mptcp: unify pm get_flags_and_ifindex_by_id")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 3 ---
 net/mptcp/pm_netlink.c | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1f1b2617d0f5..ddad51210971 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -422,9 +422,6 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	*flags = 0;
 	*ifindex = 0;
 
-	if (!id)
-		return 0;
-
 	if (mptcp_pm_is_userspace(msk))
 		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b6086e9c7fc8..ec23bb32862f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1378,6 +1378,10 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
+	/* No entries with ID 0 */
+	if (id == 0)
+		return 0;
+
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 	if (entry) {

-- 
2.45.2

