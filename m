Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC62D7384
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527686; cv=none; b=C4zkDxvOERVpf8KqenBN0gJxfqCrIN6b8M/dM6SHsXkm90sqKRwNn5yLHlKd2ASmsPVchhx91O7lG+vVuHrIkUsew4H2PN4iNOB98hJy2DqgzSXZDmpOnmO8Fye1FCpw7rQVJE1b3pbs9cq4CdiL7xabJm19n+vHUoVSeOh6ybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527686; c=relaxed/simple;
	bh=FDOE6Hzy0xI0KWSNeDlizYstzi2H3iZs2LW/KL+5SDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgqq0t2QOVtZMglZg4JLQrCOuktBihQCHkkW8FCl70cM2nKyUuwLez9rKo4GS2QI6LPZS4jTyMHeJw8YZBo+5pbKNIwI5Xpul+8nis77aQv+PigZlhQn02OnU85dVfd/sC7GV5/cvIcQOW9Zb794/ZwJd+kwCTTkV7q3BmiVy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw1LFgFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw1LFgFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6941CC19424;
	Thu, 19 Feb 2026 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771527685;
	bh=FDOE6Hzy0xI0KWSNeDlizYstzi2H3iZs2LW/KL+5SDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iw1LFgFzQ493Q0bVty6B3I1oS5N32dAbT6nMk9pdWgugX72+qPRH900loFbhrXGHt
	 vaima6f/giLp4NeXmcUukT3OaZg/u57wbZsTsxgFzj33a037w5l6MeAWYCfEz6VZDV
	 bHKgGes7t9kSWLPnTX+/kgZx8ngViS9CBit9NWEHAdH190+c2Bz939r4tybPyksaJR
	 qpo3ngtFCoR4QMJFOyCRgSE8aWjNm0mR89uTycZpJnQ/ggelsuUun5YzzMwmYjfTwj
	 3LtUyBVd+zQRuMVb7GoiLUdgJgO88NbnuNjAorCkwXjwmuB8amFkJOZGHZaBXM45tm
	 KEIDA20Rn+2JQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Feb 2026 20:01:16 +0100
Subject: [PATCH mptcp-net 2/2] mptcp: pm: avoid sending RM_ADDR over same
 subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-mptcp-issue-612-v1-2-839e20d96fe7@kernel.org>
References: <20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org>
In-Reply-To: <20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3669; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FDOE6Hzy0xI0KWSNeDlizYstzi2H3iZs2LW/KL+5SDI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKnxzFLLW6YIbuw/w2zrcmm/Vam12JXarQ1NyhG5YTfn
 1LjW2TYUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJF5Kgz/g1+smC7REmV0ZbFc
 3ZrOt8vd/jjtku1b5GDPaaLOEfYnguF/oaKt/dTcDXkfFD5decXYOX3W+kk/LDzUalffWCWl1je
 NDQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

RM_ADDR are sent over an active subflow, the first one in the subflows
list. There is then a high chance the initial subflow is picked. With
the in-kernel PM, when an endpoint is removed, a RM_ADDR is sent, then
linked subflows are closed. This is done for each active MPTCP
connection.

MPTCP endpoints are likely removed because the attached network is no
longer available or usable. In this case, it is better to avoid sending
this RM_ADDR over the subflow that is going to be removed, but prefer
sending it over another active and non stale subflow, if any.

This modification avoids situations where the other end is not notified
when a subflow is no longer usable: typically when the endpoint linked
to the initial subflow is removed, especially on the server side.

Fixes: 8dd5efb1f91b ("mptcp: send ack for rm_addr")
Reported-by: Frank Lorenz
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/612
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dc1f200aaa81..058ad5a13d24 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -104,6 +104,24 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
 			       6 0 0 65535,
 			       6 0 0 0"
 
+# IPv4: TCP hdr of 48B, a first suboption of 12B (DACK8), the RM_ADDR suboption
+# generated using "nfbpf_compile '(ip[32] & 0xf0) == 0xc0 && ip[53] == 0x0c &&
+#				  (ip[66] & 0xf0) == 0x40'"
+CBPF_MPTCP_SUBOPTION_RM_ADDR="13,
+			      48 0 0 0,
+			      84 0 0 240,
+			      21 0 9 64,
+			      48 0 0 32,
+			      84 0 0 240,
+			      21 0 6 192,
+			      48 0 0 53,
+			      21 0 4 12,
+			      48 0 0 66,
+			      84 0 0 240,
+			      21 0 1 64,
+			      6 0 0 65535,
+			      6 0 0 0"
+
 init_partial()
 {
 	capout=$(mktemp)
@@ -4217,6 +4235,14 @@ endpoint_tests()
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
+		# To make sure RM_ADDR are sent over a different subflow, but
+		# allow the rest to quickly and cleanly close the subflow
+		local ipt=1
+		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
+			-p tcp -m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
+			-j DROP || ipt=0
 		local i
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
@@ -4229,6 +4255,7 @@ endpoint_tests()
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
+		[ ${ipt} = 1 ] && ip netns exec "${ns2}" ${iptables} -D OUTPUT 1
 
 		mptcp_lib_kill_group_wait $tests_pid
 
@@ -4288,11 +4315,20 @@ endpoint_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
+		# To make sure RM_ADDR are sent over a different subflow, but
+		# allow the rest to quickly and cleanly close the subflow
+		local ipt=1
+		ip netns exec "${ns1}" ${iptables} -I OUTPUT -s "10.0.1.1" \
+			-p tcp -m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
+			-j DROP || ipt=0
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
+		[ ${ipt} = 1 ] && ip netns exec "${ns1}" ${iptables} -D OUTPUT 1
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj 4

-- 
2.51.0

