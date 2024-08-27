Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295F1C4634
	for <mptcp@lists.linux.dev>; Tue, 27 Aug 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765719; cv=none; b=gb/RkzfFkOsPuKYtc3Wq9qLO/2eq8LOcSB/kqadS7N7db2gdENu78OeSO0nJsOCrxvQHQ2xTreMzQrTSqmz8NXxc5Q+zG4HembpPYKwhdHXQw+dVsLw3BSd/FQYCAg9iZg5pA4uKPGLKHk6tcugNRUIXRR5Th0uElX0YA83Sx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765719; c=relaxed/simple;
	bh=WJb/Kgt9lR8/dWqylu2fOxhLzw/aMaNSn5UlKGkvWF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYVIbqR3hht6xrHFS8X2nAIJz7olE782rBe8O1bhoRtccjR1vSmK0bLEaT2oscZLFleol/uQwRI07/jkCeQ+U2XhP+8YQ3/tLfuNPM02qXEIczsv+CsazHlEQUxH25kETMwPZ9E8H4DAPL7asnBUqY8UIyVzc77MPhmijqyzxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVu3IE6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVu3IE6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF828C61051;
	Tue, 27 Aug 2024 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724765719;
	bh=WJb/Kgt9lR8/dWqylu2fOxhLzw/aMaNSn5UlKGkvWF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GVu3IE6N0ESmKMKoNezskf+VMMdMdrF6zHBBruXAJT1mMkz73QNxHnxRvcYr6lOOq
	 szQ5njcC5aAwsPsG/vv1u7vioBPp5SCIdRJGBaWJJdQq79jIGQlDN8HrCBS13im6af
	 My86u/nx9sp4z10sf7tq7i+4gyMSjZQrO3XzuIXr9EpzxNWDmt3fgfDyc5PaPtqkio
	 Z3rxoYvbedl5Yvjg4/eJiGHW5wLW9/cpBnqfgCt8976sApCVrWoIgyETUvmb5ypAqy
	 MnX8jMCy+78rBP+4mjsWcCmFrBB/RmG3elkQTbiVfaZGNZnQ8sRUISJeDSaL99k0D5
	 QmS86u4OaYRiw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Aug 2024 15:35:11 +0200
Subject: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: join: check
 re-re-adding ID 0 signal"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-selftests-mptcp-longer-tests-v1-2-ec11c05fe980@kernel.org>
References: <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
In-Reply-To: <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WJb/Kgt9lR8/dWqylu2fOxhLzw/aMaNSn5UlKGkvWF8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzdYUBu9g1j7kqwo0mcmhnPIA9M15TFwqu7/xd
 lk9jOcicsKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs3WFAAKCRD2t4JPQmmg
 c90gD/4+KU1VaFPSUTd1Zr0bdfZSUZnhFd9MDQg7braYmCmx6NijnDjnBGMX1MU6xicccwe8kut
 7TBgNtigatIsCN3EIBp/ZA0oexViQNewBgG6HwEo1RhN2JmUeo+kBza/5SEHj4rb0UdqG+lp1TM
 Rc/DJoJCsE9fKr3mhFLXDdNdolOPjS/VgGQ/YTDLPlSQ5OpNeN6/OeRzmXUAHs/G8NiBv2mw5kv
 b5YJNi/0rAbgoQRvFts8rDiTy85yAeHYwW4IDfmlOyiJuN317lgT1hMuN1OfJgvj80fV2VaQ6aF
 0OnMQwDyr4KDAgus6pOmOYtgnbVgb6UJAkUS/JXmloutbtGW20MaVHeBSctJmegeDp7tfrPg8/s
 XfAQjVaC5X3Nns/yVRyCzm12/F+mD6w0FDzo7CtuGX2r5rO20W2HSiU1387T/MDilAPdA7a25Oo
 XEafulTiOzVj/RvK8fKuk40PASmnGgMUGJEt5gmul5bLy2KsnP2rBs07wP69wW7+E4jnYExJJHY
 ItTzNEPMV4XCVAJ6wZdSScYMqhjW8dS3kDe5okv+j5Zb+ZKaMhD+Dl+eg9fmAZRq0ZD94iVdPVD
 5+fJunUTSKO/XLKgdpiWv/VamfSLiVTOJ1eAKMyFMO4soVAYH9NrdrgZK80q8+RItLqy6rzXf7e
 Q3yYWDmlo2SLd4g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Just to align with the previous test (delete and re-add), here we do the
same for "delete re-add signal".

It doesn't seem to be an issue on the Netdev CI for the moment, but
better be safe than sorry. Plus, it doesn't change anything for the
test: the connection will run for longer, but it will be killed when all
operations have been done.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 19abc3c1a7ae..3564cd06643c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3762,7 +3762,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		{ test_linkfail=4 speed=20 \
+		{ test_linkfail=4 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 

-- 
2.45.2

