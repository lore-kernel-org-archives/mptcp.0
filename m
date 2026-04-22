Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917F382288
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876054; cv=none; b=m3AxJ641H9y9Q3t1HDCyZinwmYZxTemczLN/CwahY8bKvQSclhho5GkV4BWm/yt2OUIOFYMFUsr5V3AILmx3sA00qMa9dY/y3Ztcof5/xQxF/zkNys3Mx9mOXnXVyIncAv0b2EbQYCu8YRyfIAiOjz/qnY29h6tHSgaShKNZ2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876054; c=relaxed/simple;
	bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVHeRI70e5GknWG2geinNndPjW+2UeLWdEqc3/6dHQgX3H4muzbpdtEs1PUJXdX4Xv7TJlKUAC4BxyWeauk8fs8kJiUuM9dEcWlQypn2feRmAzpUgGfXtNcbHMPXlRhAFYw7DixqDnL/eh9PeitcDsrtOe/3KgeIQIAoiPN2XvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YryN/uk2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YryN/uk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D30C2BCB4;
	Wed, 22 Apr 2026 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876054;
	bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YryN/uk28gZdDB0HQwLh5NzAL0XbfU5cbMLKtVjZlGG0Tal8FoV1tzGdC4fSzI4Wf
	 k+W/ytAjsHU7IVeaTL3lufkkDHnmoswSaziXY0OY1E/5oNCP+KdgpzgaVUdQjcAy1b
	 L3HNGQtIWsYCZDxv9daJW3C351oNuoDG13UwmLi/OKMA1JsAsT4tqS0bq0BIAEpezJ
	 VLTJileIrw+kwdqc5rl4vy8FugvzeUTC23rzhuHBfT/QO1/odVIvEHzJxNQFxl++8w
	 mQGtmefWORFFQfShmXXOyeGlYDEKGLrGXvHaRpqlma2U9vUCpOTZKVOg9TYr/S2ixD
	 EBgbjUf7OExcw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:30 +0200
Subject: [PATCH mptcp-net v6 16/19] selftests: mptcp: join: allow changing
 ifaces nr per test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-16-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GKTcL71kU1t/eO0nEUKhd2bN7zt+HfRVLX4PmP9E
 8e3vpPYO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYy04jhf0pWUS//3ub+6Dbd
 1n3ZImd6534vevRoweXYA2uvmKapTGH4n36Q4csCp81+6vNikjdeMXDRTFg+LSI1zzDiclrl3WX
 beQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

By default, 4 network interfaces are created per subtest in a dedicated
net namespace. Each netns has a dedicated pair of v4 and v6 addresses.
Future tests will need more.

Simply always creating more network interfaces per test will increase
the execution time for all other tests, for no other benefits. So now it
is possible to change this number only when needed, by setting ifaces_nr
when calling 'reset' and 'init_shapers', e.g.

  ifaces_nr=8 reset "Subtest title"
  ifaces_nr=8 init_shapers

Note that it might also be interesting to decrease the default value to
2 to reduce the setup time, especially when a debug kernel config is
being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..28da9df797ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -63,6 +63,7 @@ unset fastclose
 unset fullmesh
 unset speed
 unset bind_addr
+unset ifaces_nr
 unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
@@ -146,7 +147,7 @@ init_partial()
 	# ns1eth4    ns2eth4
 
 	local i
-	for i in $(seq 1 4); do
+	for i in $(seq 1 "${ifaces_nr:-4}"); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -165,7 +166,7 @@ init_partial()
 init_shapers()
 {
 	local i
-	for i in $(seq 1 4); do
+	for i in $(seq 1 "${ifaces_nr:-4}"); do
 		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1ms
 		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1ms
 	done

-- 
2.53.0

