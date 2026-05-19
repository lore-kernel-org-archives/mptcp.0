Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044934D910
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169884; cv=none; b=BdzWCSDqsWDSblzkiwQG4dESyjgx5LObWlFUE4vyubEU83CB8pmyHPWW4BfDFwtoyuHF4dzpXobUBKAosgLKNSni35LsCqhSNRuXBiVOiETMoXgooumxzxYDMd91EYbt7IQxk4dHDLdVnU1ZwbbUHDllvNHdqxeo1JKT30jvLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169884; c=relaxed/simple;
	bh=QFJQTxhkD2AgZ9YctJ1WtjN2BjqjUAK9Ui/9GaTBWQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIoCNd+QnaJ+K76mtBBGcDcDK98pJO+LFRWV3y6OG6QcRHCLqsU57RDrpnvEznPDGYMzT7EvbhqFd3zzo/tigxAP2wU2aW9S3TbzXiUcO33VLP99H1JnQR1iUmO7WPelhhG3XbY1WHbO5T3kKuUTbs2fOwT4J2veXN7Tu9forYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgE5lJHi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgE5lJHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714DBC2BCC6;
	Tue, 19 May 2026 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169884;
	bh=QFJQTxhkD2AgZ9YctJ1WtjN2BjqjUAK9Ui/9GaTBWQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VgE5lJHitZXcztH3ydZ62ibAyC97/AtIw3D9Y44nqaSNCrZrMb9uQ2EftzAv00qo5
	 S0UF4ak86xCSZJJVDi/ynRqLQgohNXmwZAQ5FmyCUYuYVgNz3ewvJUu+I/XmdQar4v
	 oRWKNfUR+25fahhPstkyWrLvmqzrgnT4xue99fYTctObR31xNKRPT7YRo+yv217SPi
	 Kar10RQZRtlG6Lr6Bg9flhZvFMCdOtYyp4yAnDyy46NJ9pnwa5zcGJJv0RjOUYsjr3
	 dEkHxjnZYj0X3u1ZJZeNNmna3ZQIKMak/8/T98yGyzopTwxbCKrn956rfumlZhDvYT
	 PgS2M1eOnZ7cQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:16 +1000
Subject: [PATCH mptcp-next v2 07/15] selftests: mptcp: validate ADD_ADDRv6
 + TS + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-7-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QFJQTxhkD2AgZ9YctJ1WtjN2BjqjUAK9Ui/9GaTBWQo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pS38ScJbpb/wKVIwQ79EcE5d/eEfmf1vUqk
 5Ut+ADllMqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 cySoEACNXEIcfXnmKBWX3kLbJL7xX4WTPRab16LZ0Lxtq0rXkJwxQqbQr4PwKVYq3YMOK6Lvqas
 nCd+8vQ+kcQQSeJA8jJzvQo01NxA75g48JQm1QZJYqJaoqf0HoYvVFl4Hq+Jcpkaqve+t8bWDxl
 suXDHofkNgnfQAhnd+nHWRH2GMR76OihE+56VFntaMp1ZYoVd/+mZoK+5/3+IMlDDUiHjxl6uqD
 +EvTi/Ky2vE9skP/XHM8q1RDrg4U95+eGblEiJETG8OU7i1zeNLLK30BTCqYwDmu4mid/coRt5E
 vFQ69ZXCO2ODCWRx94X0TZwBHermRdMgK3Anf6UCcRlONtycmCA8FUXn8nTku6f6v2GqJtO6Bzu
 004aw5BqX25eGQE+f3bbWVUazZgVvdNuTPhLptmgnzcT5Pho+h1MDZfacM362q/ZtJh0CYYJYCy
 0XXyiKCp9m2rh0AXhABNZ+FW+xEpEhuobij7/1b8oDtc6hY50438mR0b+wJpjHNVDdTJ55oPG0Z
 44QOTQP2w2zb3ly9MSGLkE/xbHXsa3vFEW3ENy/ZAQUppTDJvxtiDE1KGF9qrQi4clswwwrlzzu
 pW0YdJmuNYDArSyWBXRPUyNiP6Na+h971EqdpqvSo6YVBKzVXe9JJCckGFmRsJusDeEfB7p5vux
 rmi5COEnJirTvMg==
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

