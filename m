Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A42D058
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602480; cv=none; b=clyCzw5+G/z5/0x9j1nU7ZgG9oEvNtuv+pkVDBOnGmVhj7Um5G+wzk9HDklcSrcxlt6fn1iRloB3hH0Eri6GINX88H9qCEEo0JT+vg9vgzX7jZNmc6QvQhXKaMpZFIxiX6hzKxK8OsmpPV3tpn1dF++93YmJgHk/sS8XcwpgLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602480; c=relaxed/simple;
	bh=dneBnyriZaBVW1JOVF38WivmNrdLbziecO4haB8MS5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7faJxhK4Gr9VB+1m7873HDqtTBPWBLQWTw0/OY8WouFHstpY7cZTNVfpcC7hbzqJETvcZykH2Rys5HI71j8LMVpXKYdTo2x0YXQoBQ7D2JqBcwdxsuOnVNORUt6h6NvavmFbhw5SVmpodMoxFRJXyB/MAsR50EpFXzGX3eJIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrLMuL74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrLMuL74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202D7C43390;
	Thu, 18 Jan 2024 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602479;
	bh=dneBnyriZaBVW1JOVF38WivmNrdLbziecO4haB8MS5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LrLMuL74h+0gxG2mzWO3E+TIRfBF9reOO9ONxABVw1nLq8O5oUYqIQ+C4sEihOHWJ
	 ZJo3SWK+McThh0NNV3SrxTJejzOiiHEsz4wq/Rpafb7xinQa7HmBP0HkbwKxPC09u8
	 zv8By609/0f4pgm9bgmmqzohIkM3PGCaO4UA3fnDYcE6jDFEaaZug4I12he4pMxzvF
	 NcgRA4oY6Ei9Xo02douXU4+9pTAUhibi7bnyB+W4aQgac/pxYY3Wie3FiRSMkbXVHR
	 GxVMT9cy4xDRa0+9/WW0b5hosEB9veAJZaxfP1qkjHN6JATwXY/XNofDunEDk/hzpn
	 rFLBBLI5kVvJg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jan 2024 19:27:35 +0100
Subject: [PATCH mptcp-next 5/7] selftests: mptcp: decrease BW in simult
 flows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-5-f3a4db41c3be@kernel.org>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dneBnyriZaBVW1JOVF38WivmNrdLbziecO4haB8MS5s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlqW2pRk5z8eErGnJaThxxjoExtWTbcAQoWxqP2
 fjSbqd78Q6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaltqQAKCRD2t4JPQmmg
 c1ZFD/9kB73gRDh/tFMs5Si3V+N8Jr71EbrodMf6l4W6mSTOb7eHy/65YQj5ln/tyzL06YlmEL+
 WP4fTbkquGAM4MWpPHUhnV8PMi/qeOQh1tAUoWXYNCdMhQMcnK7jujrrzHd4BH2BXvHQR40Gj/v
 1qG4496DVZfNV3V2shdlD+OoaSCPXNU3e6b8GbarvUZCpKBufpndwc4OOx93uy2eQCzBmDKnRaA
 Oxm1ps0h/90Gti445bRBHU1HbD8URsExebUU8LgF2EpuOV1y7aQaEdV7RRduhNoK1a10DVg6pcP
 +7sNv8IzXP7Ek7/liClKbSVcF0ATcaQhHTkRCbZZj7WZj468yd28y5LXITj6owf2I79hAHqYf3h
 vGMszv4AxR50Fkw1S15ujVQKeSVjoUbvgdJqjh4SQx885vS8dcLwP7Tb8oaxxlmPOlCf3rhYmjF
 4b/L9EkvaXzRd8BM1acj4AXnTOR0AOp8+yOQBo2rMvUWEtfOcdEB1izwzd+2fsVooTuOF0ZaHgu
 6zIZ8zIuq8xtz1GTR+ORsXoFUDfOAxET/lzYmLGcRugBTitlfisC9AOriLqPpKBYclc2/LlgWtc
 jW7iKlNO1ddwxVAoHU9aWvwbqov3FyseAJCMyYbyi43M/7XvAlBc8GqsYUhkRFGdyWwOvcDC3Rh
 V+wEJJiOXEYkMuQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When running the simult_flow selftest in slow environments -- e.g. QEmu
without KVM support --, the results can be unstable. This selftest
checks if the aggregated bandwidth is (almost) fully used as expected.

To help improving the stability while still keeping the same validation
in place, the BW and the delay are reduced to lower the pressure on the
CPU.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Fixes: 219d04992b68 ("mptcp: push pending frames when subflow has free space")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ae8ad5d6fb9d..0cc964e6f2c1 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -284,12 +284,12 @@ done
 
 setup
 run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
+run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 30 10 0 0 "unbalanced bwidth"
-run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
-run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 
 mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.43.0

