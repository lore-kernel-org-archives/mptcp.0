Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1652D593D
	for <mptcp@lists.linux.dev>; Sun,  2 Nov 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083026; cv=none; b=YAMBxW93sJCDAKkAPxN/sg+Xms8vYJ+XdEWO15sRFgGZyzgE22WCb+gnuNLWZ1iR2KfONde77o1yfDwBNu5JmFRCeIJpxjgt5daIE38yctfB4LNf33TNHg5i6+/HYLIplgtzhtG5rkQVfgblbehcSd4QfngQ4nu3JUZsXQcB2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083026; c=relaxed/simple;
	bh=j85NVJkS37w/7eW+9H26tgNisTYBkmaVUXChPCz532Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N49paivsGT7FrFsatJfD1gxoTB8MWaItU1evHXyNhyIlC+e4kJ2XDwTItWK6CtB1NroEE3Ou/13eAX2KeKrfYxhm9JE60tTqkom+q2af1Yzp/aLmpQLKn5UR8+ZkHvJGfUz0pjVVvqgUx9D58KptEOet2FwpOg7nmiT6HFUMYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk6cld93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk6cld93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A932C4CEF7;
	Sun,  2 Nov 2025 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083026;
	bh=j85NVJkS37w/7eW+9H26tgNisTYBkmaVUXChPCz532Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sk6cld93eoo2DDpbJBHDjOgLhb6PVQyQjRFcVsiYp3u2EZTkPSkrNP4Zjf2IpVnxS
	 beC6nmCSts+Y3aQ26I7U1I0W3ef3gymhNT5b8UOLSRRsoyzqFYZ+yKjbnRgP5myHzj
	 HS9GmRHRxnwgJNYT52xf75CD+0P7LuGHuDQlvlm2xU/sN3twPswq9fTvqPNmUWuPSX
	 Wc+eKhJZguQ86CwBP02g14dnf8NtlA5VBuOQxUiRNGckJj/hfhi84T/7DARASEpdOr
	 /dLNyXpn3dYRK07j84ojd+mUsTAmFfmXXy4HqO/CI1JgSID+pvE/16DAUh23UONE5n
	 2CtjUtp6GHYuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 02 Nov 2025 12:30:07 +0100
Subject: [PATCH mptcp-net v2 5/6] selftests: mptcp: join: fastclose: drop
 plain RST
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-slft-join-inst-v2-5-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3485; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=j85NVJkS37w/7eW+9H26tgNisTYBkmaVUXChPCz532Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZHU57K2VyVUvMXKzkGlD1zi596wX37ktvp+19+EJIo
 jOob93CjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIk4sDP8T7v5ZV6v4sTlNpEM
 NYXNX+V1rnBmMd/KmTlP+GvtY7l4O0aGD/vy1bqfPP1h62W2aE2blmLnqQMMOkd8im8VBDn5u3x
 lBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are sending data without any throttling. Quickly, one side
will shutdown the connection, which will force sending a RST with
MP_FASTCLOSE.

On the kernel side, the following path will be taken:

  mptcp_close
  --> __mptcp_close
    --> mptcp_do_fastclose
      --> __mptcp_close_ssk
        --> tcp_disconnect
          --> tcp_send_active_reset

The subflow will be closed and the reset containing the MP_FASTCLOSE
will be queued to be sent. If some data are received at the same time,
it is possible a "plain" reset -- without ACK -- is sent from
tcp_v[46]_send_reset, because no socket has been found for this packet
(no_tcp_socket). In some cases, this "plain" reset can be sent before
the one with the MP_FASTCLOSE. When this happens, the receiver will
first close the connection upon the first RST reception, and then drop
the second one because the connection has already been closed. In this
case, the connection has been correctly reset, but the MPFastcloseRx and
MPRstRx MIB counters have not been incremented, which is not what the
test expects.

To solve this issue, the "plain" reset are now dropped to make sure the
one with the MP_FASTCLOSE is parsed by the receiver.

Note that this instability seems to be more visible since commit
8cc6e542f150 ("mptcp: propagate shutdown to subflows when possible"),
certainly because the subflows are closed slightly quicker.

Another solution is also possible: reset the connection with no ongoing
data. But this means more changes: data being sent, probably set
SO_LINGER, etc.

With this small modification, the test should no longer be flaky. It is
then OK to remove the MPTCP_LIB_SUBTEST_FLAKY mark.

Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1af96a63516c..0b084c502122 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -335,6 +335,23 @@ reset_check_counter()
 	fi
 }
 
+# $1: test name ; $2: counter to check
+reset_fastclose()
+{
+	reset_check_counter "${1}" "${2}" || return 1
+
+	local netns
+	for netns in "$ns1" "$ns2"; do
+		# Drop "plain" RST sent because the connection is closed
+		if ! ip netns exec "${netns}" "${iptables}" -A OUTPUT -p tcp \
+				--tcp-flags ALL RST \
+				-j DROP; then
+			mark_as_skipped "unable to set the 'fastclose' rule"
+			return 1
+		fi
+	done
+}
+
 # $1: test name
 reset_with_cookies()
 {
@@ -3650,8 +3667,7 @@ fullmesh_tests()
 
 fastclose_tests()
 {
-	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		MPTCP_LIB_SUBTEST_FLAKY=1
+	if reset_fastclose "fastclose test" "MPTcpExtMPFastcloseTx"; then
 		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
@@ -3659,8 +3675,7 @@ fastclose_tests()
 		chk_rst_nr 1 1 invert
 	fi
 
-	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		MPTCP_LIB_SUBTEST_FLAKY=1
+	if reset_fastclose "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		join_rst_nr=1 \

-- 
2.51.0

