Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4E2E716C
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987967; cv=none; b=hUJvvBeTr4ULH+edFKOvt/+Kuoo3Be4i9ygCYiFedYJJPQH/PNbSYoG/Rb4MPtDiLxeMwtz1eew7o9FG14QYgFnKuETHe9WruuDA0wwCMAPdvaEfsCV/eSBJ7s5X6nEfmM6QK155eB8oT/fOi7H8LL6eFC7jH5uFYxAFB9C8JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987967; c=relaxed/simple;
	bh=rNeKOBloX0+u0nLEaPssQWu3Y8SM9sXyE1RTeqyV/EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpxvAUakZr5mikE9Kts1NGVavnsDylfROHByVDIcPPIGNY0z5YXsr3o62q6Q/nI4SyWa0hhREfX5W7qBOroVznDXzJo62+2sDtfIea0g0XZdB2Ac5HFg+yQleJxolhhPiPJ8cliyqCm+U4fSIoWkRpIHIXztUzuexIp/vK4dPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIFhj/e+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIFhj/e+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1705C4CEF0;
	Tue, 12 Aug 2025 08:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987967;
	bh=rNeKOBloX0+u0nLEaPssQWu3Y8SM9sXyE1RTeqyV/EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIFhj/e+/Oz+aT4cUBQff3bM7ii7essTIAJA8U81XbC/quByayJDjqaJs2eLDS4bE
	 g4MKJx3uF1X5J28opydYquKYYCc1C/dMn0hr5GXf3nN7UJljNkc+njLuOx9VtHd26I
	 blfP0kocSifvw3J6nYfrX2hxcBwd/TJAiqwug7gULBv0cQoSNUc+l/Lgyj9/woMqmH
	 n+8IB/+P7pjaBkSQfM2iAv77ZTaND6iIAkhIu1z3H9fOqZmlUMVWbh87Pa03TrpEfa
	 UQrIOFqosFB9tdDZWbORfPgP4jV80lt8frdsV/U33EyjLnjcKh+pjsuBdgsqxAx5KM
	 swF8pEDsQQ3/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/2] selftests: mptcp: remove add_addr_timeout settings
Date: Tue, 12 Aug 2025 16:39:16 +0800
Message-ID: <5899c41c862773ed8fef5bbd871a4d6d44322a72.1754987655.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754987655.git.tanggeliang@kylinos.cn>
References: <cover.1754987655.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now that add_addr_timeout can be dynamically adjusted, there is no need
to set specific timeout values in the mptcp_join.sh tests. This patch
removes the explicit sysctl settings for net.mptcp.add_addr_timeout
from the test scripts.

The change simplifies the test setup and ensures the tests work with
the default or dynamically adjusted timeout values.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 82cae37d9c20..e85bb62046e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -347,8 +347,6 @@ reset_with_add_addr_timeout()
 		tables="${ip6tables}"
 	fi
 
-	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-
 	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
 			-m tcp --tcp-option 30 \
 			-m bpf --bytecode \
@@ -2183,7 +2181,6 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 
 		# the peer could possibly miss some addr notification, allow retransmission
-		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 
-- 
2.48.1

