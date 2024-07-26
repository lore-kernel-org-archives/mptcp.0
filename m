Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF8EEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004138; cv=none; b=CQcIC03ulYAjmoZqISOcxHbE4c2XDaepguiJUbGA71LMY9P5NeYdkoapjpzBwqDCyRk1TCC8Ftu34M7Q2fCcqk2Mgm7+TV8r1lZoczhvIfY1Hs+FKDBxRs2SpxSN9ZFAbTpS1Sjr56M+FfN6pbr1qB8IFfXoH+sOnnODqY89o5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004138; c=relaxed/simple;
	bh=kq3y1H1/YpmOtJdHX3jLabmwtlhBIfmiwDH8AEU7GQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZ3mTBv8RzfgkIzHF0ozKlCiUX+4wK9nSMrWi8c6ktbhYTOr1jXelqkZfk6fTiJEHqzkFz74PfL5vAWjTg2pn1L6yrDAfxf2pi0nm9pcX1/umPHKeP0GdO/2pqrehc2e9oA2XV68H+qIOJqkhPxampE6NbToiaC8Ee84uXkoEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai4qk+R3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai4qk+R3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D39C4AF07;
	Fri, 26 Jul 2024 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004138;
	bh=kq3y1H1/YpmOtJdHX3jLabmwtlhBIfmiwDH8AEU7GQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ai4qk+R3kWiuFDsWdH4k/grYjnh9BBJNTHJHaqRPQJq/TAevNCl+vWNtjH7zAwTNK
	 HFD59ab7IWmEmLU0L9YAccmm36i712MaZS7Gqll39EpERjzhThwq36nYzOU+aEmEXh
	 fhnxmK0KfnpRkpR6D2mc+m0mIOVzUNFewmHba4/1dQP/Kt/LxHAqC2i6ujw14HAakm
	 iZXVSX+g7WGny2XPNYuNo3DRUKwum0NXHoQHqWgyPv4heu3jG7Fuh7Ehr2Ovavk7Lr
	 6roKi5jqmWslt/pGYDBiLUzuv9qZ3n/O6hl5XJl8uHee9rj0Q/tNyUcXbtYotvszl8
	 og7lHvqtZFxKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:35 +0200
Subject: [PATCH mptcp-net v5 09/13] selftests: mptcp: join: validate
 fullmesh endp on 1st sf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-9-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kq3y1H1/YpmOtJdHX3jLabmwtlhBIfmiwDH8AEU7GQk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KcLN2+WFDqtTOwfI5kUJcZ73B5CCcmnV4mi
 SBQC6ohR3eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 c42dEACZRQKTPuKHXMzQuMerC7r6glCEywkLqI88bmN49zd56Vg++MULARcfkS6r7RJ4BbxDet3
 DVy3tYWpOtUclI+jRQZorBLBb9MmUDVooQ0lVPjFJRwgaIbPabaA0u08W+IR37FNyqPFgZLIeyk
 MeoiDr45rDDMdOHC+ioeVLkP35vpEkQAwH6L0OgOUu+RE8iC0GiDWg8NjhEQGK0pJcsGAr9ORcf
 IoUK5OgfuwgXh319hmg9B6AHJDe4UFzRbv7PaiQONK1tHz4sVUjj+xfuSsx6XEfvbsah5vPuT1A
 BnBqXLHZzYqA4dHXkIEzUR/XR3LHRzQZ4P44og/mFbHQ+5ydYxVF6JooYkx+zWQDnmALYaXKuNt
 6b8ov2euUhGbSSIt+Bnien2YP5c4cLtr6Y9DffubqAKnOJeeW3amMRRi69Bthe7BSJJeR/GFVz/
 TpZjnpSuIYtIRw6v0itY8Aa60qQiyW24n51cDP/dpHXphgDAUQKxkKlYvCgG8Mk5szdn8cdE5ND
 m4eFZ1ekmsvJ5jiIFZWjoc+Ayy3qeXu9+nCSZ7HU9y+F4Uh+tYikZjIIMzCkHIQYn0JhEEsxV2Y
 +w7wTbp4wMkflmP+44/hOCaIuqA3MunV+Mt5Q8S92flChItGb8EIZMv4/JWGS87BL342/zGv2lz
 haAPV3K2t66buHQ==
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
index f609c02c6123..e4ac275366ce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3058,6 +3058,7 @@ fullmesh_tests()
 	if reset "fullmesh test 1x1"; then
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		fullmesh=1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1

-- 
2.45.2

