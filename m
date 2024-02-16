Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7178679
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085083; cv=none; b=Fkl5BuQkw4y5xgPuraWopM/itWx6BlJKpYJIRkxbBUnFIQ7e6XA1dnGBg6snHG4k8jgIJe71BqO0c3/vuy0Du/dpiYvUERGEHiwpsAm0kBcrY5DCxukA6ygCcK7yTizpP0k4Bu9s0IVofoJlQN6NnKk7Y5wnUkgeXhqYFrCJkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085083; c=relaxed/simple;
	bh=8VG/4cV4zebAuPsr9w5hWdPcarIbJX40FuPeQwP9Hug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TKUVY/5is/zfuvxt5FDoPzLVXr/N0/eqM5oGSXrqVAt9W88fkLNoyrSpPKc++nrnzLodGk4oXTtOg+5/BOKjaJ4WFFVeo8i3vGilETjVN2zNb3aO622xNPOgHwSCZoE5gYXFZuQaurenG5Lhmm98iNvgmkQAlR060nsXnGg9FDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1hmjYnq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1hmjYnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01EFC433F1;
	Fri, 16 Feb 2024 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708085082;
	bh=8VG/4cV4zebAuPsr9w5hWdPcarIbJX40FuPeQwP9Hug=;
	h=From:Date:Subject:To:Cc:From;
	b=M1hmjYnqxMDypM18zmpDOm+UkQDSkAfougs2zZcOlBswCDH3aOPh9S1UBe/r1dQD5
	 DS3mZRInut6SY+Qid3H7sUMxWgpSMzPgcwI8Z8kAHEZMiKSJceQWm3xbw+z5+7mH1Y
	 qYRi6mpyYv5vnscGVMawYpsN7c6IN5MzrSGvi8RoxrMuoYZbH7BmAybI3LRgHkvki0
	 xFl5v0ZBYcXZtNhSun09MZp2aCNz0FAQ/yWnzEj5xIpEUZSYu1Oi2NSYdwayLZYU9W
	 ocw63JSmAQxmvKHSFDojeDMPa6TDzenGq6l9FJ+rKQThr88PKHDhmmsD+V2/uxiM27
	 AFP4AYwo8vD9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Feb 2024 13:04:38 +0100
Subject: [PATCH mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
 coverage for CI"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFVPz2UC/yXMPQqAMAxA4atIZgO1SileRRy0Rs1gLal/IN7do
 uM3vHdDJGGKUGc3CB0cefUJRZ6Bmzs/EfKQDFrpSunC4BI2F/DsxGO/TnvEIL/M4Jy1qrS6MpD
 yIDTy9a0b+CtP1wbt87x1kVrHdgAAAA==
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8VG/4cV4zebAuPsr9w5hWdPcarIbJX40FuPeQwP9Hug=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlz09ZTOp2MsXp0TGIJb6xwsHdWt1wzlG6q/L51
 B5zcb1u4/OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc9PWQAKCRD2t4JPQmmg
 c2UyEACGCy5DNJ7A3flxN7tYTEnSh+5bSn3IKJtAssDSs1cG/xefT1dK/UB3eDTzPlP1+8Q7Hbo
 kfAjvhkv9QLRWn/0MBuEHhthoi9TIgCR99J26U2+vlQkBST+5K+5U0ZlW+VWj7w9Wr33R2V23p7
 2Ksdi61A/AgtHUcUlKYkevohvuFj8p+y0bkxLDdpX95b3y6VKr8ZoXNq/EDj9UG5292PUzjZfN8
 UZo4Zc+rkWofLqoSts9eJJnrGhOx+YVRPnzuALqwIJpGV1/CW/cQL/8KZKXZAsekZiPk6VA9hSJ
 FIjypv9XmL8mZIhdHJp3xRFFLzhmEaKk7YdKnfjoewsjAi6fng5mX7CfqswQJC6iD3BWBuvNECO
 1Y886JnWhIlmhv6LJElDOumtCU/64Ij57z5bb8gf7z42N/UWxrD53GgKNCKY7gWlmW9tZDBF98r
 pykfHoW4IiUrvH4vwUV9BggC94HmUd55Wa5OjnkuD2OCOLcVcAU0dhbJ6fWOBAr1wqLoPHi60jm
 UZASGUhExSArX93Wz6FsNh/ToIcWHZTOBNbVLR3c+La838bByTz8S5jFpLw1kqATtWT2ugl2JNQ
 83ceeno/czDbpbqWP8plZSnvUo9MvbYcBx1OP/y1Pub1wzTvDUePrHhEFkx9++8RRB62TfU4mOL
 0zeb+wRN1Orx30A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As discussed on [1], an additional check is done to catch local software
bug.

This patch is supposed to land only in our tree, for both 'export' and
'export-net' branches, because the warning could be triggered by bugged/
malicious peer. We want it in our tree for our CI to detect internal
bugs.

Link: https://lore.kernel.org/all/20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org/ [1]
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 27ca42c77b02..5926955625cf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -982,7 +982,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
-		pr_warn_once("bogus mpc option on established client sk");
+		/* DO-NOT-MERGE: use WARN i/o pr_warn: only for MPTCP export */
+		WARN_ONCE(1, "bogus mpc option on established client sk");
 
 set_fully_established:
 	mptcp_data_lock((struct sock *)msk);

---
base-commit: 65bda47e218b37c3dc919d3ccbd19dfad87a99e5
change-id: 20240216-mptcp-warn-bogus-pr-warn-6dcc88038246

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

