Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA943E9C4
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197709; cv=none; b=TtoHQBKIEaIKU3lXMHZ3GJUWABEehNGk9206yMO0DX7ngg8u9pCrc45ThPNcKP6lTS9Fx+kPkWrZWFXPZ7FJbZmkH5mJ+0iDUhS0bjkwuaZBdwvq1n8HO4gugsbUtp6638Uf7W49LToPHR9T1y2qxm3zgyXZuoWVyNmmr3/H0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197709; c=relaxed/simple;
	bh=I9c1mfUknIX0WCm2b/fDww+oELlKfiR8RrnfRjXc1oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtjiGu8w7Zvhzlp4lLuez6gd9Kmx2A84UGQm5uKaJ2sMa+yZt5piQniCMLYwIkQ5L4P5HS7iwOfmf5JtUDs3cKs8zo9Yo5cajtdHVL9znLe95uIpt/mhA6zUQQ4kXowM2X+YYR3bQ5E2v9JMblHgbedErBaqgTWgwnViC5VQZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cXQAebJV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cXQAebJV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkGwGkhf48ODkoYY7Is1VdayqvPpE1l5TX8BJN565+A=;
	b=cXQAebJV+CQUpki5jQCHlg4kZ6A3cKPAtUbAt5YvuVuh16i70vxMKzGViUCrQkMtjiOxWz
	zRWLtp+N6hylY4G/tLZIE2p1OTtpb6QW4/wk1ZeZdLiMiDwIRTHfKM83J8YyQQdOVjHmPo
	5njONTziez05tmMIs6e9NEao0e9oGv4=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 3/9] selftests: mptcp: mptcp_connect.sh degrades to v4-only when MPTCP IPv6 is missing
Date: Fri, 12 Jun 2026 01:07:53 +0800
Message-ID: <3029e2f0cc3bf5b54e405928c9f71e465ff3ca30.1781196828.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Make the IPv6 path optional at runtime:

  - Right after the existing mptcp_lib_check_* calls, query the new
    mptcp_lib_check_ipv6() helper. If the kernel does not support
    MPTCP/IPv6 and the user did not already pass -4 on the command line,
    transparently flip the internal ${ipv6} flag to false and print one
    informational line so the user knows v4-only mode kicked in.
  - Guard every "ip -6 addr add", "ip -6 route add" and the v6
    forwarding sysctl with "if $ipv6; then ... fi".

The -4 command-line option (handled earlier in the same script) keeps
priority: when the user explicitly asks for v4-only mode the new check
is a no-op. In a fully featured kernel ${ipv6} stays true and the
script behaves exactly as before.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 42 +++++++++++++------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7a2a851fa0ad..0e5690d6f68c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -149,6 +149,14 @@ mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
 mptcp_lib_check_tools ip tc
 
+# If MPTCP IPv6 is not available in the running kernel, transparently
+# downgrade to v4-only mode (unless the user already passed -4).
+# This keeps v4 tests running in IPV6=m / MPTCP_IPV6=n kernels.
+if ! mptcp_lib_check_ipv6 && ${ipv6}; then
+	ipv6=false
+	mptcp_lib_pr_info "MPTCP IPv6 not available, running IPv4-only tests"
+fi
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
@@ -169,41 +177,51 @@ ip link add ns2eth3 netns "$ns2" type veth peer name ns3eth2 netns "$ns3"
 ip link add ns3eth4 netns "$ns3" type veth peer name ns4eth3 netns "$ns4"
 
 ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth2
-ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2 nodad
 
 ip -net "$ns1" link set ns1eth2 up
 ip -net "$ns1" route add default via 10.0.1.2
-ip -net "$ns1" route add default via dead:beef:1::2
 
 ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
-ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 
 ip -net "$ns2" addr add 10.0.2.1/24 dev ns2eth3
-ip -net "$ns2" addr add dead:beef:2::1/64 dev ns2eth3 nodad
 ip -net "$ns2" link set ns2eth3 up
 ip -net "$ns2" route add default via 10.0.2.2
-ip -net "$ns2" route add default via dead:beef:2::2
 ip netns exec "$ns2" sysctl -q net.ipv4.ip_forward=1
-ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=1
 
 ip -net "$ns3" addr add 10.0.2.2/24 dev ns3eth2
-ip -net "$ns3" addr add dead:beef:2::2/64 dev ns3eth2 nodad
 ip -net "$ns3" link set ns3eth2 up
 
 ip -net "$ns3" addr add 10.0.3.2/24 dev ns3eth4
-ip -net "$ns3" addr add dead:beef:3::2/64 dev ns3eth4 nodad
 ip -net "$ns3" link set ns3eth4 up
 ip -net "$ns3" route add default via 10.0.2.1
-ip -net "$ns3" route add default via dead:beef:2::1
 ip netns exec "$ns3" sysctl -q net.ipv4.ip_forward=1
-ip netns exec "$ns3" sysctl -q net.ipv6.conf.all.forwarding=1
 
 ip -net "$ns4" addr add 10.0.3.1/24 dev ns4eth3
-ip -net "$ns4" addr add dead:beef:3::1/64 dev ns4eth3 nodad
 ip -net "$ns4" link set ns4eth3 up
 ip -net "$ns4" route add default via 10.0.3.2
-ip -net "$ns4" route add default via dead:beef:3::2
+
+# IPv6 topology: only configured if MPTCP IPv6 is supported by the
+# running kernel (CONFIG_MPTCP_IPV6=y). On a kernel without it, "ip -6
+# addr add" and the v6 forwarding sysctl would fail and abort the
+# script, taking the v4 tests down with them.
+if $ipv6; then
+	ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2 nodad
+	ip -net "$ns1" route add default via dead:beef:1::2
+
+	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
+	ip -net "$ns2" addr add dead:beef:2::1/64 dev ns2eth3 nodad
+	ip -net "$ns2" route add default via dead:beef:2::2
+	ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=1
+
+	ip -net "$ns3" addr add dead:beef:2::2/64 dev ns3eth2 nodad
+	ip -net "$ns3" addr add dead:beef:3::2/64 dev ns3eth4 nodad
+	ip -net "$ns3" route add default via dead:beef:2::1
+	ip netns exec "$ns3" sysctl -q net.ipv6.conf.all.forwarding=1
+
+	ip -net "$ns4" addr add dead:beef:3::1/64 dev ns4eth3 nodad
+	ip -net "$ns4" route add default via dead:beef:3::2
+fi
 
 if $checksum; then
 	for i in "$ns1" "$ns2" "$ns3" "$ns4";do
-- 
2.43.0

