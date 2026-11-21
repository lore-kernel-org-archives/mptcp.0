Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254177;
	b=F7JOEZN5KSJN+qoHbBEBsnUMxvFXKWQqxdl3YkbmLD4IZru7Tf9Bunzums0hayvlmQ7a
	 ydnEma7O1e9izOAAawAzN+LbMRnReO/SXmpJdJ7eEFnOVwrqnkJF8AK0rnlq5Io5gyinl
	 wrk9ANtrtbGL6ETttj8+9k134vY9Fi69bdGbCo5cgGb/ql3ED/Q/m3vSTlxFe8t9gJh4n
	 SlZ2bgV8vSL9XsOfNbhsJtRoLeRiZaeZhhoUQZwoP5eiEpAIknAKqevzPZovTF2lRmGsE
	 kxTFH1SAqql1Wf6AKuY70Ekv63b5sWdMPXwWAUU67N8QCbZC0cuUF7taYz8Sa5/PKkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254177;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wbAbnYLs2apZxN093TzfpkoYrML8/18qG1jS6EmpIZs=;
	b=lyzCBFJJS4sEtjcapRLDhWEW4xw/7nL34gAewLLDHKYjnMXmBA/Nl9GxS/zS7sZWF5q4
	 oQppUjcRWaz1hAIp2Dx3rKVg1JPm5Ort25BBzOnky3Gpa2l5rxwsXq59hOOdFY0bCLGXn
	 4iVwInTkL8nlw8BQLH+rX2rU8e2DZcBrJvl7uln52g4mPQG/CqSOm2BgufGHZRBFGA2ns
	 Wj9rM5oP3t+2v/Ycz7rdCQbtGXTk8RHnkatbZOZsJKaqNgJ67VcAXZT9DQzfXIyvETkzO
	 io9qcs3CeoDZMOjtQAZ30Onv9rVEuILitd1ECoigvkGa3mlBDZYo2AS4fscZmE1EuzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJQGBSRI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A9606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJQGBSRI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359DB1F000D2;
	Sat, 21 Nov 2026 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254177;
	bh=wbAbnYLs2apZxN093TzfpkoYrML8/18qG1jS6EmpIZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IJQGBSRIqjwfiiQLzoptvzyab/B+Qpw/4g/IllIVHwK3Oc7AqoxNpO06u8o4V0QY/
	 5BbCrsa8yLNRwsCXGScMurVr7sKpSdXT+fJylcuQ+WJYpe77YdtCjJmpluAL5MHBv7
	 x2ng5hTi2x4bBZDfaSId0uN/CkMTEaisEq4da8nzDzZ1U06bzgfvPLI+K1haS5ZGAY
	 8cddw4GI3I/v+tlTTYaWpPoli5kgM0tAaiWC0LKFeCP7hbk8A0dTk6PC/vobjouIXF
	 bx1YUvX74HZxJmgmP3KzV1I2+qYGZ3O30avUaEVtNi5eoqCtmjCzPYyujZRVOyWq12
	 imRBkBv/AnRhQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:42 +0100
Subject: [PATCH mptcp-net v2 44/62] selftests: mptcp: join: check re-adding
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-44-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gTxHTW3EiHcEbebTLKtci6ohXctGsjdpDOtO1WTEqRo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0zNZlmfXzzxk/HHpg/KbEp+ftH55+f6Mx02H479yz
 6melWtg6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiI72RGhobNWz+bRPRcPu+e
 ocTG8lOHS2RnjMeyyTNeOh7hzZle3MrIsOnuByenw1oVD28flTqgsE7p8pasx2ouykrrT77R1Dr
 /kBkA
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
fail, which would change the counters. If they cannot be dropped, e.g.
with an older version of nft, the signal flag is not added, and the
subtest is marked as skipped.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 9366922adc6a ("mptcp: pm: fix ID 0 endp usage after multiple re-creations")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: skip the signal part if the nft rule cannot be added (Clashiko)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3ccce96b45b..4c045532f137 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4387,17 +4387,26 @@ endpoint_tests()
 		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
 			ip saddr 10.0.1.2 meta l4proto tcp \
 			"${RM_ADDR_OFFSETS}" drop || nft=0
-		local i
+		# No ADD_ADDR to ns1: it could try to connect back to ns2's port
+		local i flags="subflow" signal="signal,subflow"
+		ip netns exec "${ns2}" sysctl -q net.mptcp.add_addr_timeout=0
+		if ! ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
+				meta l4proto tcp \
+				tcp option mptcp subtype add-addr drop; then
+			mark_as_skipped "unable to set the 'add addr' rule"
+			signal="subflow"
+		fi
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
+			flags="${signal}" # ID 0 not counted as used either
 		done
 		[ "${nft}" = 1 ] && ip netns exec "${ns2}" nft flush chain ip filter OUTPUT
 

-- 
2.55.0

