Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32817E8E2
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825832; cv=none; b=ccw7EjdQMJ6xScXheQj0HnlgFzOQtrublcsyYtQHmjyBySjE/CDSfgSNW6cNG6s11zm1n3fzmt4h/p/gwbyIThRFnITDPYbbpqJXWWZknejLjh9OJEOGjwvGCjXicCPdl9zF9hwN+fajbaMKwasifL2Rjg5jRrKICYvM00GFb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825832; c=relaxed/simple;
	bh=VHOTTAtL4Tr9odCHigDsTBKfF2APE7KqsHpbJVP0NE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=neu/FalbyANjZ/hGRbM5Uo+0mzSRJoWslk/d2//NyeOp8f5mlMfa7HFFLz6mbVRK+U8YCUHLymjcUu+acC2KTzUC8OZcE4L+DEJdqQ5rl5MSKCyI/frf/6aEpjfvPandmf01pK96lLhQ3QpNRcTEJ9379wRysvZnZtGtoD5HXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUcIvvW/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUcIvvW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0341C32789;
	Mon, 27 May 2024 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825831;
	bh=VHOTTAtL4Tr9odCHigDsTBKfF2APE7KqsHpbJVP0NE0=;
	h=From:Date:Subject:To:Cc:From;
	b=XUcIvvW/1FOoqEN+12kyj1o3y6D2G7Y1JqVAt5sZFiJrxvuWx2HXm8cbVaoqexQby
	 6SfKFysw4dzMq7I8+Mcu0bqxiFDc09m+ggV8UYRhCu/F2lf/CVj2lEsG9ITrnsoLvx
	 qUfmLKjL+INPXcnN2C2SvG1MkSxr2+U0jp/7jxgDUjMHbnVZyIWTJFJohvJBiUPLz0
	 JdmpPTpPzWEW5LwTU0VF9IzCOSdd2ckctWQLlavNKS8bNWVxaeObpooFro58TIUWqE
	 bHVymmRy1S7h+SqlKY9ZHC32O971Y5Zm7Baf7wR3xwVp9oV5CEIMCvwh7Q4H95i9S/
	 Ar5tkeIPen/qQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 18:03:48 +0200
Subject: [PATCH mptcp-next v2] mptcp: increment RmAddr MIB counter once per
 RM_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-mptcp-rmaddr-counter-once-v2-1-3e61360a90ac@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOOuVGYC/yWMQQqDMBBFryKz7hSjScWueo/SRYyjDpiJxLRYx
 Ls32MVfPD7v7bBSZFrhXuwQ6cMrB8lQXQpwk5WRkPvMUJWVLk3VoF+SWzB62/cRXXhLoohBHGF
 daqcarepOdZD9JdLA29l+wl8T2hK88jfE4DFNkexZV426aVO2rUajtEGFIydcSXokb3nGmb9Bx
 jnv4SYWm2gmF/zVCRzHDxco8V7FAAAA
To: mptcp@lists.linux.dev
Cc: YonglongLi <liyonglong@chinatelecom.cn>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=K9TpiPm+MeY/gKhXJVhBOibDAbDSei7NRHba+O+bhjA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVK7mgxfEjMCiu320OtUVB2DqEh7GsB3Z467zR
 GeSu/nt2tOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlSu5gAKCRD2t4JPQmmg
 cw5nEADvQIVN0UU7MXKwxvwepDH1YiyNxjW8DU5iAPejStpMfn5xMWtZ13l3qncG5RtCCqaplid
 4NHRZCl76AGwiMr3GP2wVAo9GXGTOpBD5IGv+5yYlR9CX4kKb99Js/KgOj4EgoXEyupBRWYyHI2
 Rgszy17kuLkqGSskr4SHmiv4eBk04t9skTKZs+Ju5Oa+kzPYdEQQHI/7C9DCgX4wPF9HQjfGCTn
 iXO/og2AVMNazwJM/cu7QKICLGAZlQa2xiF86v4no6LX09nfiTdfgoWfeNpIR5zDqtQ/zN0jHhz
 Rcgh5jgu+RCSitrP08o/LfxkCfDdqGz73fPWOrRpBTiCwZYfNtYvzM7I5uQ5FSvggtyGMuvaMwt
 2umFPMbR08zhhjQn4Uy8vyColbcLRnOQGvAujFuMc5htTM5LBHDNqI8uMqY6mAoZa7eU52qaMdC
 0JPgnZpALmewmwiT1eW9uRiUqVgp8AoLHYA0qfETXhsicf/eVBo88d+26XIT6fYdYLr+fHa2O7a
 298yXjQSFIQ8Isb6wGOCJNVDRIxneg23HCgHMgklde11H5Yvhq0fa/b0d5CDm984DtLQbccdSnD
 baJZ3yy5Qnl7qOgnxnUyVUkUT929KLhmCfNDzlb4cs9ACJP2ve1LM/vyqF411EDUFsZR85Xm2wl
 2PB+vFUNe7zZepQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: YonglongLi <liyonglong@chinatelecom.cn>

The RmAddr MIB counter is supposed to be incremented once when a valid
RM_ADDR has been received. Before this patch, it could have been
incremented as many times as the number of subflows connected to the
linked address ID, so it could have been 0, 1 or more than 1.

The "RmSubflow" is incremented after a local operation. In this case,
it is normal to tied it with the number of subflows that have been
actually removed.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. A broadcast IP address is now used instead: the
client will not be able to create a subflow to this address. The
consequence is that when receiving the RM_ADDR with the ID attached to
this broadcast IP address, no subflow linked to this ID will be found.

Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm_netlink.c                          | 5 ++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7f53e022e27e..766a8409fa67 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -814,10 +814,13 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			spin_lock_bh(&msk->pm.lock);
 
 			removed = true;
-			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+			if (rm_type == MPTCP_MIB_RMSUBFLOW)
+				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
 			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
+		else if (rm_type == MPTCP_MIB_RMADDR)
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		if (!removed)
 			continue;
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2b66c5fa71eb..aea314d140c9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2250,7 +2250,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1

---
base-commit: 13983c0940e0daaea1eda0e04493d1de05bd7a55
change-id: 20240527-mptcp-rmaddr-counter-once-304c17413b1b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

