Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982022BE7C0
	for <mptcp@lists.linux.dev>; Sat,  1 Nov 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988501; cv=none; b=neJQqWhNN9oql7G8SG5Vt3rp9LkLBk2k8+i8//bpSv/M3zAri0ii2Pc5dVvhzInunikTdgG2lrmHUqq1qeHLza0sZJtlD3whM9EfCNhSSfWzwVRAuya3nThlZ1ZORrjgwDsnsME75vabGOOmVmav2IEdLVHJw6g8AK0scUGTJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988501; c=relaxed/simple;
	bh=Z/5W2x7rJRFgws1zoyWeVLKH2bwRKGy6TKM2NYw94wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmAejzU77lfg8AvATXMKRX6jzIMFJc8EUPMe4i5eNurX8qiW6KvFAAmyfSqmna00kvYD8JlgN+r+efyEw088fUD1fzb8IMbDgqF/gPQW0eWLFnjsoG1ciYc2bFU6UyMKiU2+ud+2TxmWSRP5sOseoRC3yVo1sWi4+e6SxbE7/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH1Mfn26; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH1Mfn26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9590DC4CEF8;
	Sat,  1 Nov 2025 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761988501;
	bh=Z/5W2x7rJRFgws1zoyWeVLKH2bwRKGy6TKM2NYw94wY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fH1Mfn26TYisST4SqTEEUxTTtbGUD65tZol4tDcGpFsT6kTd3I219PZII17aMZQQB
	 vhkpymYhMiEPRn4TCWuzfhzLNWRMYaecG1bIYr44W3lxaqUmNRe3V6t0oB+H/UitCB
	 q5iyTNl5DJMsKsfHBJlgfhHqgQfhXsA5tZTS3dMbppKBiiRa+PsBSyqzRaF0UbUf3e
	 3ASmB8wTg2klxEsDr86k/7UHM0WrTMIAF8g7w3nuON6xPIJtIygi1bm8QOEmBL1yZY
	 MGneo8IEDYycyTYPpGD14TlxtGv2xR1fHpNFzVMvzE6KbKQwTzvIEpDp+OvZFZaOSx
	 2d9SsNEISzTfg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 01 Nov 2025 10:14:42 +0100
Subject: [PATCH mptcp-net 1/6] selftests: mptcp: connect: fix fallback note
 due to OoO
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-slft-join-inst-v1-1-10572512a0b2@kernel.org>
References: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
In-Reply-To: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Z/5W2x7rJRFgws1zoyWeVLKH2bwRKGy6TKM2NYw94wY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJZz/ecK2Z9nsxc6RZR/pSv/092uyW76d5Cy4mLkyVff
 bNZLcbbUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJGLNxkZJiTd6n2+2Y/hoOae
 LT+b1Pm+KHEZWWbO9759Y7lNRQnTGob/GVqFrkfSgp9wpzE+YU82rAq9cCvP7Erx1DXLypJyJnp
 wAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The "fallback due to TCP OoO" was never printed because the stat_ooo_now
variable was checked twice: once in the parent if-statement, and one in
the child one. The second condition was then always true then, and the
'else' branch was never taken.

The idea is that when there are more ACK + MP_CAPABLE than expected, the
test either fails if there was no out of order packets, or a notice is
printed.

Fixes: 69ca3d29a755 ("mptcp: update selftest for fallback due to OoO")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 47ecb5b3836e..9b7b93f8eb0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -492,7 +492,7 @@ do_transfer()
 				  "than expected (${expect_synrx})"
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx_now_l})" \
 					  "than expected (${expect_ackrx})"

-- 
2.51.0

