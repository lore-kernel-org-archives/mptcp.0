Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E6450EE
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195963; cv=none; b=j8+OQ+VK2aAvGdDHmyjSpFMLiyo54U4Iek8Inz7U36IX+k821RdWGTxX4aVWwhj64a5iAbuvcWGdoGNzwzXu4kJcR6cZZ9by4jCphMZ9gpW7t5h+jCVh7pNly9hG3FghOZDfLlazbGp5IWZ6gCK8YCk/QaQyPExU911mHsJJz1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195963; c=relaxed/simple;
	bh=jX0Cpx7XHymXuGVHyTcL9KfAtZlnZp6YZ+71/YCjZyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qp8ZS1x1P8yjG8jbVvfJRdqZx4bei9f/OBSae6YIfiWk/nGJR1znS+Y585wdwOZaiqR8eKvoOZJ4zSLNLcBgj2s6aPrGsdFNuA+f5oRYT5oGSNjCQ0T9XC/UHdP8CnrdSP+LOzLFeITzQ6O0ACQfT29sskjhIm9nJmkdSFqwqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9XVbOhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9XVbOhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFB6C4CEC4;
	Tue, 24 Sep 2024 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727195963;
	bh=jX0Cpx7XHymXuGVHyTcL9KfAtZlnZp6YZ+71/YCjZyI=;
	h=From:Date:Subject:To:Cc:From;
	b=d9XVbOhnCc5p5zIg3rtHUYJbApW9xsK3hLHDsjn30rydcrTi6Sg5gn74TMcgiREc+
	 HfzcZdhNqguWyO1KJatcmT755TqxojFvSSZo4BXsU+XwCEvq0LabC5gtQfFdyi58Fr
	 EN1sdDsch6sJxuD58wn9UbSSAXPAfPmfk+4WMyt4zlRIWn3OndKSR3GllpY5gDZW67
	 yV2U79DJFfZN+TX3HO7/vUFxHW0XLVcuZfhTtofjWr3NZLIQvQDy++DI9+y8QrLQtP
	 L4bd/Usbd2co8A5JgwTA8pP/3sa5a0BmFKhO03B/JQB3S89gzvAyJeItsPrKPJrtMi
	 8mN3b2zcuP71w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Sep 2024 18:39:15 +0200
Subject: [PATCH mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
 coverage for CI"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-mptcp-gcov-v1-1-b259d5dc5fa6@kernel.org>
X-B4-Tracking: v=1; b=H4sIADLr8mYC/yWMQQqAIBAAvxJ7TqhNIvtKdCjdag+ZqEgg/T2p4
 8DMZAjkmQKMVQZPiQNftkBbV6CPxe4k2BQGbFA2CqU4XdRO7PpKQqquH0yrVsQNSuA8bXx/swl
 +z9IdYX6eF54QIhpoAAAA
X-Change-ID: 20240924-mptcp-gcov-49368d19b22f
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jX0Cpx7XHymXuGVHyTcL9KfAtZlnZp6YZ+71/YCjZyI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm8us6l9SjhItQnsIwVAwiGooOmfMGkzFEvmkBR
 f34YHiyWhGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZvLrOgAKCRD2t4JPQmmg
 c+n0D/4ynGBBZO9cRXPZVDpWYhB97uo+6Dg1Hf9P1+CMvGJ2+1fpS3C5ILZPkMougDz1R8f+9lu
 CH8u7izJ188IpHE7euednh/VL35pQ/F6MN985Yh0ECyH5LkjLcWCdPiO0renRFcciwzAJWXRGhd
 5Ru/UlhQkyO/qI4RuXVLWY2AkazNasoMlLVVtPe5sEM6pCaBQzUEevVlgpHK+kWsTxstei2QsMR
 hoIddyTX9l7vIwKaoIym//JwvUzCwGhst48oX4m4o07W+muTzsu7w3GCBiKkec38jPAf+hyJgqo
 jI5lEsxnHu+Cq0W2OOhMjwlGllTrC9R/Bw234dvUfzAyGD6uVGOm8uCJ9+eqxTe0iOAnmgKrt60
 hn0y1i2cH03n1plKfaSohFawhwAtQBNCsHcoKaOKLYZWfn2kCY8fweLjsTA9EYmJBOFCu5nIVD8
 IQ4GDPEoq5nmRE4N+/g7gxOy/YP+qB3HSlCjRfCTPLG39xdiH+L4C9serpHZWPPm7E/QdJoAKKa
 ziuVzlVmw37zLlVef75AhrRUuXsWxczqOQ6cggE84tmGmRi/tPafAAn5rlZxs9M8gfsD0PjkdsL
 hqFidIMNTVaUPnbY/i6fBSR75R99CALC6igr66eIvqN2IG1aLteaJXQ4byFg3bBj7dzpPkvlt3N
 mNgQTFnHXnM3K1w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

And in "DO-NOT-MERGE: mptcp: improve code coverage for CI (net)".

This is similar to commit bc75dcc3cea7 ("net: rds: add option for GCOV
profiling"), but I don't think we need to upstream that. Or not for the
moment as the selftests don't depend on GCOV support.

If we do, we will also need to update Documentation/dev-tools/gcov.rst.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/Kconfig  | 9 +++++++++
 net/mptcp/Makefile | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 10c97e19a7da5cbb1538b34a8eeca2e89795dfae..f674915dc31e521e6fe9dbcef03e65bdba10dd3d 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -37,4 +37,13 @@ config MPTCP_KUNIT_TEST
 
 	  If unsure, say N.
 
+config GCOV_PROFILE_MPTCP
+	bool "Enable GCOV profiling on MPTCP"
+	depends on GCOV_KERNEL
+	help
+	  Enable GCOV profiling on MPTCP for checking which functions/lines
+	  are executed.
+
+	  If unsure, say N.
+
 endif
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index bcf1dbf3a432f7423b048e985667f199797042b3..5dbc37d38d7a4b0779c71e7b291ef83a49e46648 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -13,3 +13,8 @@ mptcp_token_test-objs := token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
 
 obj-$(CONFIG_BPF_SYSCALL) += bpf.o
+
+# for GCOV coverage profiling
+ifdef CONFIG_GCOV_PROFILE_MPTCP
+GCOV_PROFILE := y
+endif

---
base-commit: d269ec78a30bc7a57999838c477a83b0e0101a57
change-id: 20240924-mptcp-gcov-49368d19b22f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

