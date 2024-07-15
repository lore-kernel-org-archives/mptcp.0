Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997018629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038210; cv=none; b=sk/ZbcdalPjkugVFqLyMUJakya2jacoW/xhg+UY4EzzrW5eQKQCxYyHQjmw8IOpYIhIHB8JeWgnZuZGvD1afVvGnLGRqiWK5GS9f5hXda5RFHW70N1MQ4/ec3FLT+RNA5TrEyMdjWTDHAmlyWNcGBQ1LBkkl1hSLwElpFjaWZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038210; c=relaxed/simple;
	bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJCqFk08j9M/Eki5kcGnTyrUGc7TrtyduJOx4zc76oulKaMIJ3PdLBLHKIJVR/j9qWTx/DaubpjUXSPyJSq3CCNA3XrV2osDl4j94+nYZKaxee2KDOunyrPLT4HCbYWv+GEk8gWWRMpytTzOyXMDU6SkdVDJsf/eBwQOlbywFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eswVMMUf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eswVMMUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C20C32782;
	Mon, 15 Jul 2024 10:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038210;
	bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eswVMMUfxyueM1BgoXvFxnU5pRV5Fcbbs2NVGBLyyttTiTPK5YqMqFPT+muO4f4lZ
	 0d1NFYZz3daxhu2g42/qHp1zZhO4xQhHCg+qUJIplWnqYh/n+PYTN6hCCE+I9vWkFE
	 8EUitwYKAkaU62PjEd0K4oguq0TqThfrAPM3+JAzz0gmopgzwxfXX7c+PN1AsS3WjH
	 x9Va46u0sH0OR9kDJTF95BSlMLh8kfVyfqtPew+c5b+WBuFMCx5M88fMLkl3j0PZ1Y
	 p0i32Rv2DFOYkL6ix6Tk5QIN1NPui8OYkL5okzofQO2VTZPk6u5uiFmzvzw6ym1DSx
	 yGhDGP21M1RHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:45 +0200
Subject: [PATCH mptcp-net v2 07/17] selftests: mptcp: join: test both
 signal & subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-7-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3w9jVNk+Pu7JsNgwc3Z5KNtVyFMp/eMqCo
 FytUGbsUHyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c8OOEACkvIm2wtnx9f5l78yYEhhep5CB50ATJL+977y/wwodGUC9/I4y+qCUc2RqNwmU+Eb1AgJ
 mI8Kn5APb+zaMxx/198zzDjWbpVnLd3c0PQ1npSLHl9QjoFcc2it0CWmogydEVyxzXioCnJMQ9N
 nqG0sbkgWnh9WPg0KYXtTlA+WUgnDwAX1ZoIkTCaHgzhJ5WFP0KpqYe/n7epLdZ68KBi0jM2wlt
 PNpLfRHOXxdIjkMioLY0HD8MyJvsBTqkRIRTsSIW6z2cT0iPAmmnJZj50i0s4Hb3pho6ypg9ahE
 hPLA3VpV0QeDk1I2g963YJeeHLzgyiHWTJZ/4Bv2M77t5cfZLiVzNhQ42aLhm1yZnyRy8IoVktQ
 oWa+N/ieY5TqMk5fyop5EXSUuuwWzTXs4pKHFphRsKQiebm9CJdf7rcWHI0smLBoBai9r+aIgKi
 6ZRrsEQmDYqq2qC4KT+q26uwJHewq2AZItRzEqC2iSWP5N52Iiewd5mGNWvawsuwVDl/u9A/H+L
 wbo9cAOgzb4JafIXbskkLct1c2ItZWkJaMoYTFbjixRXEYnmiGa2zESRgz3yFVMFcb9nkx6QAkE
 u1P99NFEaYLRkMEzOpOZzB/4YqZcgx10rOvNwJYYkN6LU4C+4VHJKGQTS5bQOTznRDLC4X1w03p
 2QqWwWof5yQV3jA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It should be quite uncommon to set both the subflow and the signal
flags: the initiator of the connection is typically the one creating new
subflows, not the other peer, then no need to announce additional local
addresses, and use it to create subflows.

But some people might be confused about the flags, and set both "just to
be sure at least the right one is set". To verify the previous fix, and
avoid future regressions, this specific case is now validated: the
client announces a new address, and initiates a new subflow from the
same address.

While working on this, another bug has been noticed, where the client
reset the new subflow because an ADD_ADDR echo got received as the 3rd
ACK: this new test also explicitly checks that no RST have been sent by
the client and server.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55ccc4fdf18a..d25ac561e050 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1967,6 +1967,21 @@ signal_address_tests()
 		chk_add_nr 1 1
 	fi
 
+	# uncommon: subflow and signal flags on the same endpoint
+	# or because the user wrongly picked both, but still expects the client
+	# to create additional subflows
+	if reset "subflow and signal together"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 0 invert  # only initiated by ns2
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3

-- 
2.45.2

