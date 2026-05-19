Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6E3E8C67
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225935; cv=none; b=mPQtVKodwdXUpBZb/b7q/CojcsRhrrTAEzbEXHmMyPz9J2iNwE+nPGZniXNmGlUJct4Yr278KhWPHrRlI/PAq6HzELu0dBjRvmzyfDkDXOUPyYEg1aS3UASf6Wxfu+dVOLAiI/DJRohdtnza++bE9GabHNluJA5x8s4Y8zwti/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225935; c=relaxed/simple;
	bh=QFJQTxhkD2AgZ9YctJ1WtjN2BjqjUAK9Ui/9GaTBWQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4a01v/Ogp+maQcTErv1mZoQnKcDCKvg8Pc5n3UtBE7pD8o5fvSLRofkLbwe9WksfWQdCuXnkBXMixNMPSWTrQK6fe7AhVbh96MGeWkCEnCVM2wKJYL5qFTDp7sAXpQQploIajl4QRxlZiEGslwwYDHcdx1fosV7I6wI73ohOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G099jug3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G099jug3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7E61F000E9;
	Tue, 19 May 2026 21:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225934;
	bh=OjQowhfODzG2mycXkj3A2VJWiOc3DbyvDzkq/m2dH18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G099jug36/BuoQg6JAUArwjxzwRmJm9+TuPe95y2VO0v7vO2roVSuDo168lRi0nBk
	 OMxuA+w2/4NPNsH1M1uLIrFEZbdxMfhKeLWWENFh2zGyLeBbLDyxXywyIaGlRFfKX7
	 J9JqgLLx+7ventFgvEQWdTnykrTzLmzuUtrix4AkW5Qv6UEaRyBvBM29PMJ5QSyeyg
	 YJd+wA0WtmhaX4L67tLf6MwlSc3Bn5c2W89jFi0xBoaPXw+L9Za6w6cG8ZB1O/CsTn
	 Ist11EwtjnGsKkVClCrNt7jRUd72SHKDlL08P4zm46NEVElAbs4oc7gMwiyk819TwV
	 ez+H9M9lEBJdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:19 +1000
Subject: [PATCH mptcp-next v3 08/16] selftests: mptcp: validate ADD_ADDRv6
 + TS + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-8-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QFJQTxhkD2AgZ9YctJ1WtjN2BjqjUAK9Ui/9GaTBWQo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBK+A3xD/hrXNAWxLSuUnVEDDEh2EcKWw8s
 IXUfbXS5feJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 c5DAEAC6Gt4oWR/96Lso28mkRKBH6d9ZvAdDbqVLIrVJ36srDKgCpi8K+L82WVxQvbcLS5KJhz9
 lKvVc5gp0kIfF4IH6LAwNmODM77H2/n8RxQ3W1brtbTyYHylCKALXeQu0izVFO0qCNi2NUUgeel
 Mpr2Iub3kQkQAAJY7dsoa88rB7GMSnaT5NPOHGQiGVnX5TpTWCcm56RkLeA86Z4jXASFvCkZHhD
 ZB/6cOZcETJdw5bG+u9NwNtzNezjl0Rmj6WoqGnPYiqmDLhLLnm5bLSnL2Y7oeFLoLZK6JTGxQ+
 lRk7FPPPVKyR7M9Y7fAbd1EDELJtzMVyYs9kFpbwtvsU6OU++rJvx3Sv9PPSMtZCW8NL/I7OzdL
 jeFX64c89vc7MoHtBlM4k1C/vYIzOv3bjpJBZOMyG5ShFU2KUFRvp2NyMEkg7yeaUiQ8W2cyiKg
 ZQ7gqw6I+Vpw8QhVATcAgwgYAF4s32vZLqI9dQWw5kpBBtLqMcTcGvf9Cr/pDwpr+k++zeDMLSb
 qEan+y7RvU5M9C9kNiFy+LCPvcm1cytc1R8+yyZfaERbrfctbnZ/617yOjZ3k4Ef1E8zx0AKsDQ
 gjZaNPe6QAFKitqVTSB0hTKSg/8CG1QKQ2VTRFHEoh8wzx40PNLQWBzGC4qhNqCICfR7t5WW8ii
 hyiiHQ4VxkD8RTQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the feature added by parent commit, where it is now
possible to send an ADD_ADDR with a v6 IP address and a port number,
while the connection is using TCP Timestamps.

This test is simply a copy of the previous one: "signal address with
port", but using IPv6 addresses. This test is only executed if the
add_addr_v6_port_drop_ts sysctl knob is available. If not, it means the
kernel doesn't support this feature.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: switch back to IPv6 for the main connection to use a v6 socket.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 23b17957686a..d491c3e964d6 100755
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

