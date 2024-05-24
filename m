Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B412D77C
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563642; cv=none; b=MiFLqrXvWTgm6ELqznP0RdKTb1w5uz0cMD8Xhe5RifIiXtvPr0htHgvSqIqgjQfmgTkbtnCJI4Bj40So+U9Z3Cb54lSts/YpbUZq4Yq8FfjwXEjg3guZOsG0cRm36n/am3Nlu9n91fM56JQDRrX0NIWhoPwWZV+7D86X70egZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563642; c=relaxed/simple;
	bh=JXMQEe3zsXqCqykV0TiMzHSF/bLvNSHAVqPzoUmJcJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XR7sdf9rs3lMP57yE+9KI8thbnw7ue5IhqtGGnc4e6a8wlYHc21OY27a0JFXoqaZfdEGHgrcjPA0aItM7rEnJJUuWo0IKkOKCEOfomusUIPcxQmWLndiLe7f2ExgZIQ6NzQ/Y7qpTf3VNvrtiYwMdIH0rb2EgybfTl2gsJ+id5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL1/P3AS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL1/P3AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5C4C32782;
	Fri, 24 May 2024 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563641;
	bh=JXMQEe3zsXqCqykV0TiMzHSF/bLvNSHAVqPzoUmJcJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZL1/P3ASVG8hau4zhdX+SREX7RaRCO3/HVY0oQQdLXLBafUFfChnBAQ9SSues8ZXZ
	 SIaIh4NtYBmMnDjvb7f3rxNV1IcHPGw9ivhmzsGxagHBOyOPS9omd8F8/64v/oQO3J
	 z0MwP621XXeo3GY1AJRIKH9jE2amfTLzWCDd9hbOgVcud2qut6PFiGT/RBKFyuMpdG
	 cwVzxZvT4/NaVIJlMf2qnCZ6Mad+T/MHmif3SUW1ftaKt85hWDsy0XCQCuHZ9NbI2L
	 Ip/h+uh6cvVxewH+o/NTykEXAZoX1radbFCTnbWG29E7Y8OQ8i1fBQWr2EJx03lC7Z
	 k53k4KeE6O4Fg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:27 +0200
Subject: [PATCH mptcp-next v5 4/9] selftests: net: lib: ignore possible
 error
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-4-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JXMQEe3zsXqCqykV0TiMzHSF/bLvNSHAVqPzoUmJcJI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6zQsMmWzZZg4rq7SCU5FAt8jFEgF+8PdvB5
 FHW6oyo/+OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCuswAKCRD2t4JPQmmg
 c9EqEADAdaIQk3BePIqXhJTkZzXeHECJb++AeXbSdDkPpPwvpb9WRU6smm1gPQc8NS29ZZzyuVh
 +sRYYTuhlIJat09hlC5WaBG6n3cjT3f3+WUYUsjz1a7u8gjOrN2u9qo/ZY34dVfwK98edvdbcRO
 9Sx1ELvglQnRA9S29kLEyFo33P2ak2plmZIB9v4rLzkbbN19H28Rvkx172/brcTeAYJ7Iz/SDcG
 yKz9HmsILOFewI96BFEms2eQtW3eYooQIR2Q0Z0DhrquP0qV1nltByU2q9iLrinRL5zxwSazwHK
 Zv/OAN54tJSOmnd4r8VMC4J3c8sPeoflinKX4gEncOOwp4mHXwQRq32b2rY97Wb0ZfqTIQsai/w
 zdUuiYTh96+V3Kbn+O3IQgewsdJN8+cIBmywNXbY2A10wmHGFRg6qoPjkZpN/fdO4fJKInHdnNK
 iNXiw7X8JK911FzkFK5E3QJvmGQBbBjkyhrTZIKXJMruEj7zdm7BVso8RWU4olqRth+VL1P/R7A
 gYoKbmxdnXF8PoB90Gz37a2F5aGwo4MVfSkG8k2J2tw9m4Cpo34q2TiVlw+y43hCG04QAp9X7NM
 SVDcETbE88E7+gAmW8aJMz3vVPz7tPigM5wNSeRDX61dpafEyR3u1lhJx57vHZ2mjT5Qh16AFNq
 2r/mDbzhHb5nASQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to disable errexit temporary, simply ignore the possible error.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 9155c914c064..b2572aff6286 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -128,25 +128,17 @@ slowwait_for_counter()
 cleanup_ns()
 {
 	local ns=""
-	local errexit=0
 	local ret=0
 
-	# disable errexit temporary
-	if [[ $- =~ "e" ]]; then
-		errexit=1
-		set +e
-	fi
-
 	for ns in "$@"; do
 		[ -z "${ns}" ] && continue
-		ip netns delete "${ns}" &> /dev/null
+		ip netns delete "${ns}" &> /dev/null || true
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
 			ret=1
 		fi
 	done
 
-	[ $errexit -eq 1 ] && set -e
 	return $ret
 }
 

-- 
2.43.0

