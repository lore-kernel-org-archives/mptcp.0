Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599688;
	b=nndEBA2TECMe5D0IZi8OJnum6HRZ9HHY1Z3KoVnjCCaqGMDtZ+LddkZzZ97ZbLzQwOtY
	 8twm0+rTwVHJq9L+ZuR0Rzw7PYrgpikzxQTcMcd2KQeNH7hSMwNbBOFK3A3JGL7e2rqS4
	 j/domG13Yr0F9BNE4QY0aijRSLZ/dLvRPXKGQ2QLtWhDuEmb2w1PFPcfD8Maj7NxU7S1A
	 PYbrcy0U8COXX8cOyR+MnmRCPWowHWyuR5AFO2r9YW67P2gPvvru+R2aSD2qp7HZlCYoZ
	 G8bHk4/ynvuPvfj/f90650GV2ECPcl2AxRQLqkGAKQ9ik4uYYK42423vWj7yAKHp5CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599688;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lMRIQVsONxIKglrvSyqr5H/29Al6TnhbZxn2Kyw6k9w=;
	b=nsjRRQ3aHul29dj2KfMmkJZ8kgN9lx7gJApr1DcfvYu1u3eHNPkdzVBhrliGw3QGgzsO
	 6ipZ9v2NxOPhCJS4sa/moWkXdj9+31D8uoz4sffpMsafCSFNCqF1pSgr89jeEHQr8CSEP
	 wBZbqnmMxO7cEhuBRS4dscYJsUyZDYQfjrjtlB2PcLw7166w0QSTUSqKQManK4UOaR+9K
	 J6yC9WgYTETYg6+slb2M2fWh6+9aywTee9iPM70qXPvAXP2Yh2/W/HL9lHcieeWa+v+Rn
	 A1DEQahm9CeiOzi84PYbQF7MuRrG8unywnTr0GMpZxLGWDND6yg9iNCZzTXtQKQ/fGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyyQor6H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888A606D0D1
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyyQor6H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831381F000C5;
	Fri, 13 Nov 2026 19:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599688;
	bh=lMRIQVsONxIKglrvSyqr5H/29Al6TnhbZxn2Kyw6k9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EyyQor6HXmT/yJx5Wbxa+Tl6d2e+cuZ95bKX9+YsJ+HofTSuKWKyQdSKGSzu7yPa8
	 KvwF7BtDQ0YqMSk0mTWP7rfPRBAPE/C521UYjSXJUpgZx1cSk+ku/ORtjKwgTIVddg
	 5muXc2tLo8DbgIFQHjuCAkslfpC8IiDKuPjsP7oTNkeoX2lnYH49KSAObX3ei/veCz
	 1vAoqBwbc/atptZa/x9zXRYfws0l6HkBwA42kIuuW71XgtlWBh5ZSW919aUkKbp2yd
	 TbCstqvzzx+GtyUe8g604NxUHAXjQst0xnlYjQ8LCkLGvAa73lOZ+QjIiJWcBgizy3
	 2Q1f9bO4MpUQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:00 +0100
Subject: [PATCH mptcp-net 22/34] selftests: mptcp: join: check re-adding
 signal+subflow ID 0 endp
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-mptcp-cmason-fixes-v1-22-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TjBpwuHhNzRS1ipzelTDYXpHBFaY0+qGHmTDuX/fwbc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz3smPVupV9/yYJ7Hl5Hrjv/sg9OYr4Zq6n8rzPiU
 rdh3/e+jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlopDEyLPx5es2VDHX7nR+s
 1ub/dFxwvbTROtK2YU/VrEnP7tYt5mVkmMQlsGRqyGuTkj79DXOk52Y8MjsdlrhaSD7sv4v5xJt
 L+QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit:
when the endpoint linked to the initial subflow (ID 0) had both the
signal and subflow flags, it was counted as used each time it was
re-added, while this counter is not decremented for this special
endpoint. Once the counter reached the number of subflow endpoints, no
more subflows were created.

From the second round, this endpoint is now re-added with the signal
flag too: without the previous commit, the subflow is not re-created at
the third round.

The ADD_ADDR sent at these two rounds are dropped, and not
retransmitted: if the server received them before the new subflow, it
would try to connect back to the address and port of the client, and
fail, which would change the counters.

The 'Fixes' tags here below are the same as the ones from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by these
commit IDs.

Fixes: 9366922adc6a ("mptcp: pm: fix ID 0 endp usage after multiple re-creations")
Fixes: 579a752464a6 ("mptcp: pm: in-kernel: always mark signal+subflow endp as used")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3ccce96b45b..6cd187577479 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4387,17 +4387,23 @@ endpoint_tests()
 		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
 			ip saddr 10.0.1.2 meta l4proto tcp \
 			"${RM_ADDR_OFFSETS}" drop || nft=0
-		local i
+		# No ADD_ADDR to ns1: it could try to connect back to ns2's port
+		ip netns exec "${ns2}" sysctl -q net.mptcp.add_addr_timeout=0
+		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
+			meta l4proto tcp \
+			tcp option mptcp subtype add-addr drop || nft=0
+		local i flags="subflow"
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
 			sleep 0.5
 			chk_subflow_nr "after delete id 0 ($i)" 2
 			chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
 
-			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags "${flags}"
 			wait_mpj $((3 + i))
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
+			flags="signal,subflow" # ID 0 not counted as used either
 		done
 		[ "${nft}" = 1 ] && ip netns exec "${ns2}" nft flush chain ip filter OUTPUT
 

-- 
2.55.0

