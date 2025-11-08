Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B961CAA7D
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611689; cv=none; b=sqLXi9YIGFffa7zylqcdWJz4FzMEYQhxqYJ9ZhIpUJssiJw2BsLzqnC+FCzNy6DyRpPmYV0E7yYR0a4Tm3y/8jhNw7mJTIV3Zmv55hq3Q+gvbQnfpNm83R7nD3lgMvHsFJEIGqgHXZTQ4wNZuPxABQumhzpwlST7x/3bmmea4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611689; c=relaxed/simple;
	bh=6UxiqWQQB6hX/tOfxfSpxRRQ1SsHP7IoG34fAd4vbls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1V/gIFH6wCei8nSWUYG8/Pq7BpCDgFquSPy2q1SKkQCUnK0cKmg/bmA05ywotsNdsIcg6LRoAFZNmkwXKPAJtkVFckxzM9/it3uccnvjEAJu/SffzGb6g1/gMJe3YyL5Qb5OWzI0qQDkhMw8hijkdinMOEdJoaOfWqmCs4ifAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuGUy4l0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuGUy4l0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A008CC116C6;
	Sat,  8 Nov 2025 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762611689;
	bh=6UxiqWQQB6hX/tOfxfSpxRRQ1SsHP7IoG34fAd4vbls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AuGUy4l0jG09fNpm3LOQ3AikbYxuu/W9xpFGYlpmSTF4mCQoZUE27hjBVMG0euK+u
	 LBdJcy7PapXg9fLoAmZMyMRyqV9WfQZC3uAji59+z21gd7ZmlSpikRv+CJNT2LTnVO
	 mZ7fgbFgzjgqaqIGOuKyUH+8DtmK0lAaiif8o0Lbo9gUaDpswooqHttr8A1BIgit3h
	 eksmjaJRNyVJKuw+boMViaYO6GPgz9GIHNrZK2DDtnHOo4hRlLWdd/LzfCyOEBNMMK
	 hiktmks0bMi4iyGVxHgaJmUbrF2WPq7x7Ztba5Ulnyi4M6wllz0iBvLoFSHJ3H7opv
	 LJdAaFkiBZAkg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 08 Nov 2025 15:20:29 +0100
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: wait for port instead of
 sleep
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-slft-timeout-stats-v1-3-c2234d277318@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
In-Reply-To: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6UxiqWQQB6hX/tOfxfSpxRRQ1SsHP7IoG34fAd4vbls=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL5A59ETsr5uri/9Fuv0Kz3D0uffp6aPLHyezTzEnY11
 xPyOe+MOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayYw0jw6bps9fzG+zvWPN/
 ua42gxBf/w9PnRJTxkduHSc22HdZbWNkeP/lsVLgTIMqSVPz2qWpPJPei/CG9hpV/y10ObhwQaI
 bEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After having started mptcp_connect in listening mode,
'mptcp_lib_wait_local_port_listen' can be used to wait for the listening
socket to be ready.

This is better than using the 'sleep' command, not to pause for a fixed
amount of time, but waiting for an event. This helper is used in all
other MPTCP selftests, but not in these two.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 42d533b95ec7..6cde7429104b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -178,7 +178,7 @@ do_transfer()
 				${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
-	sleep 1
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 87323942cb8a..e9ae1806ab07 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -211,7 +211,8 @@ make_connection()
 	ip netns exec "$ns1" \
 	   ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $listen_addr > /dev/null 2>&1 &
 	local server_pid=$!
-	sleep 0.5
+
+	mptcp_lib_wait_local_port_listen "${ns1}" "${port}"
 
 	# Run the client, transfer $file and stay connected to the server
 	# to conduct tests

-- 
2.51.0

