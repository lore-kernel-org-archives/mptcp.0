Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309530;
	b=tix1YiT0+rkGFfjT2QPnp+NYjadgdAUranVKcJXdsewvpkz8DNoFdvS/I6sz56i9GjZe
	 xUSYFseR8CGju7x6DahHWyxvePJsAtyHSs+fk51TandEgiFhy/nSqx00DXeEGy5jrMtF8
	 XlpontVCUGWM7pAgXKVRBzfK/6yURLTi4PobJu4TIHKv3z8qAhKPr+CDCQzGZxRDkQM3y
	 eJxtvy6NZqHFpeotOR/JrWKEuUJmSdbgBvuuYtgNlo4/4imOlfRoep7gpte0IpK8CX8sm
	 lXM8hl/F+un9EVaSvvXGtI93kJeKaI1SCA2L31XrNqetdNN4Hv3SzVf95BCYv3obVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309530;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+rG8wjd7/UcmCF/VguBwrEnXTtMjx98c96s01QDltmY=;
	b=HfTQmIKaHjLSHoXrx63bb+NHpqFtmWZ6HIpEjnViqQzN9GeAFD1lJOHKKbtGE77c2hDh
	 GJDwHLzYkUrWKRGzAbDmTWXg2nBNen2xp9U7XJXVmSTDgFLcWde52JYT10mDME8PZHmXd
	 HKOAK7Wwk7JJq6J/6UNh6gihDpA+F63rgTeRRw+eb/ExoodSt7Mc4QZmMuHXBt5w9/yFT
	 HkkuPWp1P8qjxx0xKNyqFovASbEj02DmpjSOlKeS6cZeGQ/G7G4q8Ixv0iqRhsRRKIrTg
	 k6nesi0h0fJE2HLNRbRHkx9eoZ7oIlyXFjTXUf9Kt3NAZYLF5qRPsqTnka1XM6/3drA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N122CMb2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB4606A323
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N122CMb2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707EF1F031E0;
	Thu, 29 Oct 2026 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309529;
	bh=+rG8wjd7/UcmCF/VguBwrEnXTtMjx98c96s01QDltmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N122CMb2lcSY3PJrRO6Y45WkXUqClmXBbUWj2fcauKQ4v72ZZ4499Tg0DTkHwTh9L
	 PdVH6ltKaYBELqAF1Ms83Q/IBRn14ZaYMhT5ZGWvX7DivyE7pWrPNJBrDriw/NAnC8
	 KTwdJRH8d+QLThf9FwfPT7pBFe/agSCW/pSGyAgT8vx2zRu+Xn+LKo/9uGadzizDGL
	 VbPHhobltpM/9+odZkRMdsaew4se+YrEwWMvhivZw5PVtS3BQgglhij16Qg1ebG9F4
	 arZue0Aa/Ry1oeQN8hvkAUERaEkYuPaEu7FOc8P5FbYR4J2CzIALUcchaaic+hW29X
	 AWtUNezl2eNcg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:31:52 +0100
Subject: [PATCH mptcp-net v4 7/8] selftests: mptcp: join: new ID0 subflow
 from the right IP
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-7-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YxXsgCeXsbOpzwfySAeESEZiUb0qKlMc1QOIqafF2WQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7w6KE/o+4VOacPme+NkRqpp3dp+f0rzEuL9A7rq6d
 6/61Uq9jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImUqDD8012d1r5JWnxnUfo2
 s/8t/sXdLFWBVyvuOAdHvxKXtyv6wchwVsridtdpXePrtkyyiTtstcXZLx8Wv37mUAFvWuMNuRM
 8AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In MPTCP, the local address and port used by the initial subflow has the
ID "0". It means that when this address and port are used for some
operations -- e.g. creating a new subflow -- they should be linked to
the ID0, and no other addresses and ports can get this special ID while
the initial IP address and port is used.

Hence, this is not correct here to try to create a subflow with the ID
"0", but from a different IP address. With the first patch of this
series, this action now returns an error.

Instead of simply using the right IP address, continue to also use the
wrong one to check that the kernel is correctly not allowing the
creation of an ID0 subflow with the wrong IP address.

While at it, fix the dumped address: the initial address is not supposed
to be dumped, similar to what is being done with the in-kernel PM. So no
"extra" addresses should be printed there.

Fixes: b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3ccce96b45b..190ab48acbc6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4214,10 +4214,11 @@ userspace_tests()
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		userspace_pm_add_sf $ns2 10.0.3.2 0
+		# from an IP not linked to ID0: failure expected, no new MPJ
+		userspace_pm_add_sf $ns2 10.0.3.2 0 2>/dev/null
+		userspace_pm_add_sf $ns2 10.0.1.2 0
 		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
-		userspace_pm_chk_dump_addr "${ns2}" \
-			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
+		userspace_pm_chk_dump_addr "${ns2}" "" "id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2

-- 
2.55.0

