Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591401;
	b=ZhzrAXmrhALAVVdYYzOleiZdcN7i51+7zkaRZgjzHqCRUpl+ou2d09h+T7+mZ4B1sWvT
	 aSdKVvNnZFe7e0bzPJQdIwhxY+yIMtEejgPe6AgGsAOtWoLXB9V6O21ZpJqEGxHcwDAek
	 T4lrW8jig8g3U/+uCJCWX0mM+KX/Q9xc1/Pw1A/QnR47oY+ToxebW7DIYf1j91OV4jZQH
	 RivL2xqAcXsJhDdT+gTgkpFQI527GeUbFlpu3BcL+holVJsMx6EqKvhT46JO2aXBEclw/
	 YldoeEOqDhCAeG9SFbftAsYbf5zKcTKHUPUxRgpqJn3svKXvNbuEIiNELRdIyAeufzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591401;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J92Qo7WMwZoKpkdT60N7mxxDmyA0luIC4GV4VqOzfE8=;
	b=xX/TvTTJyw3rzlUcjoO7LMfDH7jV8Yf3bNyOe/498mMZAdqjou9BAFkoELdbDoUkGtQm
	 2prmhqeUrAxDt3CzNKi3t2Ucm/gXsQQHtgQO41UQDawkfo3JJcagI7x9T//ayZd5GjqIW
	 Jt7ToqHzsOp36LZX8OfrKsnLgRUOxtJidStHQUmAQO6p/teZLODQceax6hprh0dXxPnlE
	 JuOGEvdmIdvkcN1CZhDQmAuNYIaswbz0SxHwyRj7jbWy1FjPCVxnyksyhZNWdtJ7KDj/0
	 vQbA3VovpWRsLRh8ZQXUVkKUxKHMi1UaZuzXuxtwbWeFH0hVTRjWCB6jRnDLYiJ08KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Co+TyhE0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E410606A334
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Co+TyhE0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E27D1F000C4
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591401;
	bh=J92Qo7WMwZoKpkdT60N7mxxDmyA0luIC4GV4VqOzfE8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Co+TyhE0DgJVfN9DrApPhHp46HlIWdJnK+uC+TtJZ8hPkg9OdDrXjhwsMYxo/z6EU
	 pcsa2016bhM3kJ5DzPLdnShvT81WaEMSF0s2wtQFruoO7ZEkIX2EQ7pIMUalysr8ct
	 ugPCO3SKtROQs1UiQH1LJV5xFco4QIIfAqXOFa+Ebzw0HcGjkUFg4CAogXMa/HGGFj
	 PnMRA6ZNXM/VxI1h63rqslJtplpvq6wnMqDV6yotS9ABKggDvdTxSSkWJ2DFyAeBww
	 UjYs1draPBjD3NqIZ9IM9P1XHjHa8w4FAzL9QOPwQaRWDzjtIUAVzh02u84JCp/8EE
	 +mxit3o/WDv9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 7/7] selftests: mptcp: cover msg_zerocopy test
Date: Wed, 25 Nov 2026 15:23:05 +0800
Message-ID: <3bd50e8f16d828fd027f3c0c8ce0df829401a362.1795591278.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add the msg_zerocopy test to the MPTCP selftest suite by creating a
symlink to the existing msg_zerocopy.sh script in the net selftests
directory.

Update the Makefile to add msg_zerocopy.sh to TEST_PROGS, add
msg_zerocopy binary to TEST_GEN_FILES, and add build rule to compile
msg_zerocopy from ../msg_zerocopy.c. Also add msg_zerocopy binary
to .gitignore.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/.gitignore      | 1 +
 tools/testing/selftests/net/mptcp/Makefile        | 5 +++++
 tools/testing/selftests/net/mptcp/msg_zerocopy.sh | 1 +
 3 files changed, 7 insertions(+)
 create mode 120000 tools/testing/selftests/net/mptcp/msg_zerocopy.sh

diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/selftests/net/mptcp/.gitignore
index 833279fb34e2..1f318a297f70 100644
--- a/tools/testing/selftests/net/mptcp/.gitignore
+++ b/tools/testing/selftests/net/mptcp/.gitignore
@@ -3,5 +3,6 @@ mptcp_connect
 mptcp_diag
 mptcp_inq
 mptcp_sockopt
+msg_zerocopy
 pm_nl_ctl
 *.pcap
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..17d0d1051165 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -14,6 +14,7 @@ TEST_PROGS := \
 	mptcp_connect_splice.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
+	msg_zerocopy.sh \
 	pm_netlink.sh \
 	simult_flows.sh \
 	userspace_pm.sh \
@@ -24,6 +25,7 @@ TEST_GEN_FILES := \
 	mptcp_diag \
 	mptcp_inq \
 	mptcp_sockopt \
+	msg_zerocopy \
 	pm_nl_ctl \
 # end of TEST_GEN_FILES
 
@@ -37,3 +39,6 @@ TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 EXTRA_CLEAN := *.pcap
 
 include ../../lib.mk
+
+$(OUTPUT)/msg_zerocopy: ../msg_zerocopy.c
+	$(CC) $< $(CFLAGS) $(CPPFLAGS) -o $@
diff --git a/tools/testing/selftests/net/mptcp/msg_zerocopy.sh b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
new file mode 120000
index 000000000000..b2f82b8fa5f2
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
@@ -0,0 +1 @@
+../msg_zerocopy.sh
\ No newline at end of file
-- 
2.55.0

