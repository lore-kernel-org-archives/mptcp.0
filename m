Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB1817
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806137; cv=none; b=uBzCv5Ivecc0jdkATfKawe+6o4OP7bwPTuC/92RtDmFsN6OnWN/1LpqzlTtfvggaGUfxbjYbyN78pITXq8JUrDW7aLGzQXEWK6Z2WpfGYGVbmgYr+HBG8YvOgCY2L0JjK53eNeFCjKkv3smtnZhnUAMQDRhgJ9SYfwQ8LsAo2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806137; c=relaxed/simple;
	bh=/Lx0fUCqoVVYQ7bsrG3kIZ6PEYhnhTU5aspq/nEkXPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrrGX7s8F7hyKIOGOeSxhlyFSDAeAFic7qz6X0+uEeIcABDbZq+0L8+U0Lo7KEZv3YQp2ubrTyoClPQKNKT482a6mrayAsbfcMAQVHIy/Dox9GJ6ad8361eB3+I2Xtq+fZ5w8FXy0MYc0Qidtdt2JDbGt5GJuVTUssDl/eDeNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVxswA2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVxswA2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF9FC4AF09;
	Fri, 16 Aug 2024 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806137;
	bh=/Lx0fUCqoVVYQ7bsrG3kIZ6PEYhnhTU5aspq/nEkXPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sVxswA2c0ReAGuxWqde4Gzo1l901EYxpOxnZKL1S/zZQxvPP94ahKw3yDFqXRs5VZ
	 CydcUGmyNbL/MKqXBeMZfAANKCB0hsjTrvsbif0vcccDhlyGk66JjXSe17/1+3rWk7
	 73+qgojPQ3iQJnrgR+71oBHP7stgmUOq0LpMWdU4BUeorfy2sxhohtV6gBMtBf+H6c
	 gXol4hU15ZKdbvxDzSSeDCD6CAfgQ2t9cRyH88aiLidE5XJ/psBfxoGWDAOmyyJyGi
	 I9tvVdge0Vi9/Milt2Hax1mUscYwE9bVHW6Uq0I0ZmoCrUyMNbfwovqd/7/8dd5vZ6
	 Y2eCau3IU33vw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:02:02 +0200
Subject: [PATCH mptcp-net v2 08/12] selftests: mptcp: join: check
 re-re-adding ID 0 endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-8-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2276; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/Lx0fUCqoVVYQ7bsrG3kIZ6PEYhnhTU5aspq/nEkXPA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGuSqXS2/jgjeQLNCW4hbgU4ZvYjsyCFMYFO
 UEr23hggW6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c1ItEACcAph4MmrKkxxaoqXz4x6yScJkeSYiVDSdZMjRQWYMQSW8123PIH0lmWHLCKRog6QLaau
 IhvyYpIRB6/DH/w3be5p/EFJgflu+2lMmXsi+OuofUDdNhtXnaSEfp42TXeiOIYK/HhS8Fzvpmc
 YJchhGWfFk9aMB/1nJuc8Go3yI6V0IW7E4EpfzdMO8OyssNQXv3pOYEOJPJ3vpVZV19fWi1Rg8e
 bWGLINA33L4iKVNeMLPdO7v76G8qgLFLAIFQDzAI0WGtvbbdKMTTRs9PU7i5VTAPBMpl1C0BU4g
 Q7EIH134mn6ppU7KuoOGJIIioL4S2wIc3LjYi731i2Ywi9Cy6G8PQFfaKiu0b5EOqaf3pYI3i0/
 Zvw+CHwXfgTD8QOZLjooI8M/ECNpxK5IO4LOuwVxbP521fdAmoAtXGvzxvYiegpx3sdk9A4/duy
 VfQjWQUWBZh8JwO6h5Vi5TqSaEWXpWOmtOisIAk/oFS4TcDhsiGOY36nMgsuOHqNwVzSf7qkjPT
 w51PlkrWwVNjDp/2h7PuMwuPBCi7uE3KrJT/6unYSw5slsFguAxJWWi1d4KlYXEDJXyataKjDWF
 KJPT0QowfYOW6TbqA/FVJi6F6z6wnD5coaHOpfEF2Pts1KnBL+UJdbnM2QeAR3KkU5xogcCG80Y
 ahSYj/5ZzKtSHVg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit:
when the endpoint linked to the initial subflow (ID 0) is re-added
multiple times, it was no longer being used, because the internal linked
counters are not decremented for this special endpoint: it is not an
additional endpoint.

Here, the "del/add id 0" steps are done 3 times to unsure this case is
validated.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
- Re-create the ID 0 endpoint 3 times, in a loop
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0494610694df..7867a6ab0646 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3684,21 +3684,24 @@ endpoint_tests()
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
-		pm_nl_del_endpoint $ns2 1 10.0.1.2
-		sleep 0.5
-		chk_subflow_nr "after delete id 0" 2
-		chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
+		local i
+		for i in $(seq 3); do
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			sleep 0.5
+			chk_subflow_nr "after delete id 0 ($i)" 2
+			chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
 
-		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
-		wait_mpj $ns2
-		chk_subflow_nr "after re-add id 0" 3
-		chk_mptcp_info subflows 3 subflows 3
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+			wait_mpj $ns2
+			chk_subflow_nr "after re-add id 0 ($i)" 3
+			chk_mptcp_info subflows 3 subflows 3
+		done
 
 		mptcp_lib_kill_wait $tests_pid
 
-		join_syn_tx=5 \
-			chk_join_nr 4 4 4
-		chk_rm_nr 2 2
+		join_syn_tx=7 \
+			chk_join_nr 6 6 6
+		chk_rm_nr 4 4
 	fi
 
 	# remove and re-add

-- 
2.45.2

