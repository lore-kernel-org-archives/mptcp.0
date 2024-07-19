Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16EC83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391897; cv=none; b=pxIfCVfwLmhmT5T8kcaj6p7GFUF8KAWhIXUqjoqurzShr42/gPceKiG9vHqt/9Ihmzhn6PwbrcoiCWt10f7s6EcNLk2tfRTdDAphOpWq2N4R2o77BZjlZCQlmr8H1LtN87oeODLAsucANcQkneSWgIVQg3iAzEAEk7LLWSfmPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391897; c=relaxed/simple;
	bh=tZmsTr4h7z/PWxZXsPVa1fhv9uKUkReD+8TToEemtVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5u0ka3el9krnda7qy4+bCBfhVrr97f6qJzr9FIwFp2SLXIdJzivEPgQt3aBNpQ1gxpcfqCJlsdB2l3n0KcG2/HdD6UYtXFDGve20xZ6nBXZGzPsIs4U7XJZ95iItmqFSJkwZXKCIuFPrmdXSnUwupG9mDnhnfajykA1RD1pbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugmxQqGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugmxQqGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E81C4AF0D;
	Fri, 19 Jul 2024 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391897;
	bh=tZmsTr4h7z/PWxZXsPVa1fhv9uKUkReD+8TToEemtVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ugmxQqGLOh3KnovYSst9WkKBsIP14YNsYZrhPpXScGUagXL3bWWR2nLEjJuQ/eFJX
	 KAHSB6vSwpBe6U6omCZvsQxMePCKR3fOVKTfXellIDKv0JJ0pDgqtT6MDIhqYGx1jU
	 hU7KoZX73njqWbDYhQD7VqA4+tuaPOFb/FBo0mzl/w6merDbMWKiShh3KU4Xen5mOZ
	 v0TfKH/2vEYIoGbGPBUDB583Zwg7CiRY+fxM6H/mxtne67wddKpV4odHHDfx0gspdm
	 hE/1UgmNwZMjNtz/hH+pDtOYZxNdPGSVkjoZFz4XQ1XTtDfFOt2TZ1ylJ4LwM9Wfah
	 znzNiScp7PhxA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:31 +0200
Subject: [PATCH mptcp-net v3 20/20] selftests: mptcp: join: validate
 fullmesh endp on 1st sf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-20-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tZmsTr4h7z/PWxZXsPVa1fhv9uKUkReD+8TToEemtVo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsAH2+5tODIE8IMU4VvWPFx5M5lXCrSbWkmg
 vtruJDyNriJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 c06QD/4obBPKx9/DWrPcIHO4JXsa5Qy9EOnUfoX2gagmM6NFwXq9EN/ZxvkMXSnkH0dccP2z1yQ
 qwGN0SDZCoIJuZEF13J0MzWfW2cHKrWRLJ3ClqGFHFHhBgkE8clyH0+bx2EJSpKTq6bgUzrAbc+
 Grj89/qZy1BasYvZgiE1hHt+bmPK2/L34TeOztKfFbNr7FGuVkcj5BfgXKews0bh9uyf0MUfKa+
 gchzyWSMGwVleov/NaFyhSCGvjSIxfMDhzynnF95bf6wCLKKzXGsm8iNJZ72fU1Prj177MUw+RX
 3xFoQ8XajYseVYutxzvFvfkQxC8wXZSVJtLcdsRqfZ33RN27JtXgTy0FBMCngr/NM5HNCtGe4aT
 4rhBjBkFsfg+3Y8dJMs0xJxyM0AMRwo9ASSTL3XxmMHKJ38QBMOAs+eQ9g8yUUDFuHqJSwAl2/6
 8I2KTecAJgGmmdzdsMr5iSjIbXDqJ2jGud7Y3zZGaO43Noub0pbwG/V4sAWUoSBpwsscGy2WA8H
 KUjKrhnPyX7SRUOAMwLb+IpdQ6DuFtFHfTl7sFwmZ8ArKxqWkAuz0AlXp/KkdFJaDfrxAZ/TJnE
 33zM4YXbRgt6GNMByDkuweU4Aoo/VCeu3qiRRD9Y//FUU9GEksxDzqUSToZrFCp0QyQGyQptyxu
 /zgBMvE0eCAqPxw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This case was not covered, and the wrong ID was set before the previous
commit.

The rest is not modified, it is just that it will increase the code
coverage.

The right address ID can be verified by looking at the packet traces. We
could automate that using Netfilter with some cBPF code for example, but
that's always a bit cryptic. Packetdrill seems better fitted for that.

Fixes: 4f49d63352da ("selftests: mptcp: add fullmesh testcases")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3565d8b48125..c4bb390933d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3014,6 +3014,7 @@ fullmesh_tests()
 	if reset "fullmesh test 1x1"; then
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		fullmesh=1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1

-- 
2.45.2

