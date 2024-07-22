Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E517109F
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676976; cv=none; b=G1NaTdGKVENsfA5H276NmbZt99g0tKaZnmjOjbO8dSKN3Z8wcd6lHuO4lSy+7rVuM6EvIIP8RojAg33dOfERGF1imy06T/8mtHT1ItJm6qrGsGt+VagEsEqk7N2m1dMNsQqFTZJE+Cju6fM9kePVVdSuCzXgIGNNxIU7xFg2pu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676976; c=relaxed/simple;
	bh=tZmsTr4h7z/PWxZXsPVa1fhv9uKUkReD+8TToEemtVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+PFXIY3nT33kojMVkLctm0KGAJbECPaOsy2CPBooIKmX1HK9yEqZHiMgqEKy/Er93Zi7pKKWGtuy+JCBKGYYb6cJi4Q0oNvrEj0COcdJST3AO59bVimAkaCUqdqlapEGwMwVAiD7nGzqJDaAWCxtX2tuMVEH64KhdKPRKiHxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQKBakj/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQKBakj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1568C32782;
	Mon, 22 Jul 2024 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676975;
	bh=tZmsTr4h7z/PWxZXsPVa1fhv9uKUkReD+8TToEemtVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bQKBakj/En1/25Y+CzA6zDglqvTXyxIcbS8hsBmbR/a53TRGBnG7FXuzZ1nSa3f0e
	 EYh8wVUo6R+aUIEHe48mcjR905rgUz/GFHwUae2WagAJBhPXA52H+GlavbR61njwzc
	 2t8LlR3bkBrD/z/B9WxRMLbRKj4F8Vy4wMXF+bfPhhWer4rgoK3pIWfgAIuMuk+Ogi
	 7vSV2PARh4ejPhdlXWUT+Dv25bhmwhh0v1sAibqhemuYaHe3FVxUdFFm4UIYLPpeVp
	 x8QgNrgJqd9tw+AM12UeXF6ddlm4MYXRD43EjxHFmGZwzyY+FeATdZn2NVkp59/Y9V
	 ZTUxNtNaqA+DQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:58 +0200
Subject: [PATCH mptcp-net v4 20/23] selftests: mptcp: join: validate
 fullmesh endp on 1st sf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-20-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tZmsTr4h7z/PWxZXsPVa1fhv9uKUkReD+8TToEemtVo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSXVWG2sXLadwkPcnkortDPzl8YAJpEglh6R
 d2gRwYnbVeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lwAKCRD2t4JPQmmg
 c72TEAC4UYLX4F6ofkdeV+nTP9RdigYI65U6yfRuGhmEWIltQ1ezS+YNVWLXmMul2rGcNz/xDik
 +N4hHLCfeW2BA8vNtTGU5sI18R08yhKTplJzQVwx728L0OWJlFpJfWUby31ZRSuD/IqG4kP/kum
 HBw9ryUQEpFsRJifzA2zBzZqyDEnwoCipRdpyI9XS2bil6rZkfOYmS22ZZl3jqc8SbHmvXBcTbK
 +T5EfrZpOTFFKwqoaMkyb0MzDaW2jQzEsXhs7NSI3E6yGW/msJGwmxtqd7CEeTwDnxa0klI7Ef7
 Qza0GscRz6jWOLHsMxD3wUmAEyimJMfs/8/DXG8l7XxPL/O4gXyU9LMEDtQDBiEkx5KBD39R+ig
 pcCn8g0N0R9UuxBcS9FlWyJKH4eRN35AWm1V4fxtlqee9U4wFISGuVU/Nxcw0V76tfaxg7Rdwn/
 muMfCpVjrOilOlqhK/85B9HQI00f6A3BF0KvRhKsIRsH0lnf0UPBLChoFzVq81kDxG69GDVvW9Q
 fw1jfz2dh4NJ+JXzX3DtuKoqrKAg9FJ+wW7plE/XDaAOVQWXBhtb5A3OJ4pyfjXuv3vJtwpdc7k
 GRWtGk0EbSXggMVroarDb2lcoeRYpBbxnx0rNyfN7t+g84xnzy7RhldCLYU4f5vxpD34TqAoi22
 ziT57mCtlx1Lqlw==
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

