Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769F4C6F10;
	Fri,  5 Jun 2026 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651346; cv=none; b=a1WDhMa+Qgguvowh8AZlGPrOvloWXrKscaD3RbmIhK5XKjez/FsQhOtIJt6VbruZKh4rCGN46BcukEnyKxN4QNGKEKFbHA6oMssUyKYj3uvT1j7gjX/p8VIfRJlhTOS/VuQY15Dkz8zUJIPmP15HDZhlOiRu8LYLA5f38wNU9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651346; c=relaxed/simple;
	bh=CjXL5/8/7Hb1P8HDY6vD1OstvudZM0ZnMlfKR/jru2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/hko4hSojo/QHyhWe/ncafTc6e4BjH54XCOl3MEsyn7Y4MU7stjj4LaKX5+uKLBkhf2AL03najk/KUb6mxHIBIrJe+47p/V3X9ANRN265JzN8VHz6mfQcR/BLBUxGTDVmNFoN2ssRnsCopvItACG+WcWJqRXcurIyRmFqk5pt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/HiQPj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/HiQPj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CF61F00893;
	Fri,  5 Jun 2026 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651345;
	bh=K3bZiqv764PbsLbkRIRrFv3ZqK/WkJGz8mKHhPf+RUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G/HiQPj45ely+abCmjIqQC6LPBTRZmUucaLjGkpCPY1s8KMpQetXmWRVLwd3+yMnK
	 35yiPyHcGdCOUlcVkuLA7yH7Qu6Fng4KTLPwTWWr/sKX6ZqGBn1OsfZysqGlAL/MCS
	 Jiu10HE5VGfFnLA5QdyD9TpRi52zRw7fzHZax+0iWlNCE1ezQTq1kg2cKvlK+GWpy0
	 RIgkWIx9lk5VCLNAh6fjYLP9zfLYgELhlT+YAhYDKEmkO5KILdb9gIMnlVIc72nEsv
	 /zGulQQYt0DxBUE2vaIYnGbXVa4lFyl3EPSaKi8O/blrKnjIs/bqw4Evb6NSUJqoBN
	 BGcoMwozzLJzQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:51 +1000
Subject: [PATCH net-next v2 07/15] selftests: mptcp: validate ADD_ADDRv6 +
 TS + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-7-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CjXL5/8/7Hb1P8HDY6vD1OstvudZM0ZnMlfKR/jru2g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxM5NRLQuTAUE61b9T78riOefcRQRP0E4aS
 pWiAiNZ06KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c8pSEADfrye0bd7EMEhd9dvvuylvfymPjlCmZAF6DZlKBVN3egY2AbtF/kF4DDwctHLD8ikWyRb
 x0ze92mcr0Jvp2WCKFVXRC0DqSDX1Dv7leSU2Y3Rsbp+PipMch0aM4zU9bFu8sb0Kwz9rTBaL8C
 JCmJOPGIIyZdTBeDvhHiCZbH+qYyNxQ1wSE3hdeVuE8OT3l6FKQVMG3WfWxWe4YBFA5erBhskpI
 ulUVaGd3S7D1y1fTFGI8PBrvULDWuaTTgPYig2iJyDfYPqR9lk3O2sI8uSz7xoUnzm+Bcl3IRTT
 AgoVTxgRMaaaafzLD3vufIRQ9F35bRT6AsDHrJUibZaS3HEecio6p/nGnSjAsDUBMk84I1ubT/2
 CUEfLrpqbzVNIHNB+zxCo7Jx18Z/CNUMLkqtYL943z2qUK/z2K7S6YXxKEFbjzi1Ud7EoNrPKSw
 pgrOlLyxfA8TokztRDTOoluE1PzB433mao+qmYX8CcXflmxxKBnBu1cPwsGQn6NKcBHGmma+M8a
 isuZDKUQf9GuN9Bg5BbCv+yNEsl5QavWxe3pkhs7aOiBt46UtNsYTtbjCQ9oqdzLc8Eqg/Idc9y
 K5664CWIECN3wggyLuEN9gF9toCRlnlbHjDEXuUkzR3f1ielO9lxSDOc4PfWg/R9XEVsDWzcG3r
 Gg9zN2K2iKTEECg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the feature added by parent commit, where it is now
possible to send an ADD_ADDR with a v6 IP address and a port number,
while the connection is using TCP Timestamps.

This test is simply a copy of the previous one: "signal address with
port", but using IPv6 addresses. This test is only executed if the
add_addr_v6_port_drop_ts sysctl knob is available. If not, it means the
kernel doesn't support this feature.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 70d5b26be4e0..6aba8f97275a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3214,6 +3214,17 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 	fi
 
+	# signal address v6 with port
+	if reset "signal address v6 with port" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/add_addr_v6_port_drop_ts'; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
+		run_tests $ns1 $ns2 dead:beef:1::1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 1
+	fi
+
 	# subflow and signal with port
 	if reset "subflow and signal with port"; then
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100

-- 
2.53.0

