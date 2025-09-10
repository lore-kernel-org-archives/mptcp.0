Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889A2AE99
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494638; cv=none; b=to6lqflwsBB1+/YAJc8yMSVsn930zctN/RqqICwrxWWo2dIfot2zomtejOWi06asp3g/zUaXJjgRudGYa2c18CK72vKR1ZcIdF0P4yutC8snXbwidup3tfAvN7uDyx61gQuxJ9uessAzxuT6ptO6JINfXf8Toi3lr5/ca/YLTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494638; c=relaxed/simple;
	bh=Ee84vhhloGWzA2XT0E22CrpaB5Mp4lCARLlvOOwRIu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X++o42aTjHCm5CkXqCHynp5B/JkDelBGC+tnMJMYdKvkTuo6ViIJF/eQEHUcUSGio2PEpTxVlPqyYDF5dOboc7SloW5R0+9dIyKj92k0/ikJCxyg3FyRThf8g5PluSGnJbIWOXkJIxON+Y3zw2jFhx93ennFN1dVlOZ5GO6wlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbGHVRUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbGHVRUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68013C4CEF0;
	Wed, 10 Sep 2025 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494637;
	bh=Ee84vhhloGWzA2XT0E22CrpaB5Mp4lCARLlvOOwRIu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IbGHVRUyEVL+JeVuuL4gOghUCza2WWvBADCCLaRsSejnkARyilfru28H2d3DkHwGu
	 k7hSBLXcFfrXoFMRDdqOc4Ppg6EDhO0xIYYDAlsPgPsXpc2sIRs2gKhUVWNtDRgrq0
	 a1xAIopcpkaysSBglOVYxYzH/Gbg1OMP99fxIUxh4h71hJHrRLqZwtBowcjmpZ+gM7
	 8pes7z/MJzDI38Vxbw7i4rr5JFIARPHPMUUFKPBhI0+4zlqE0kUYmiwlVQ//LPq9bP
	 mwL4/8RB1MC4UKxxYb6v6Lsn+PQ00qWdIbKlXQ7jH2THhUYBLFwNos2pJpeYtRSCDW
	 dmgtQsUVlX/7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 10 Sep 2025 10:55:51 +0200
Subject: [PATCH mptcp-net v3 5/5] selftests: mptcp: connect: print pcap
 suffix
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-sft-mptcp-disc-err-v3-5-6799fa467d77@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ee84vhhloGWzA2XT0E22CrpaB5Mp4lCARLlvOOwRIu4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIO2mYUP+b8qlv3ZM39g17e5y/GhOfWZp8qXMnDWmPjm
 5MW9b24o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKLHzP8U3tVL+Z5bO1e3oLk
 3R6TZyUY2870WKZT1nF+2qzT74JkSxn+qfo/WaqzW9rHKeXjtl0xevtaw//byVhniN84YvT40Z8
 SFgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To be able to find which capture files have been produced after several
runs.

This suffix was not printed anywhere before.

While at it, always use the same prefix by taking info from ns1, instead
of "$connector_ns", which is sometimes ns1, sometimes ns2 in the
subtests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c2ab9f7f0d2133559bb18ce884b613d21d1ec5f0..47ecb5b3836eb5c64787bda0f6f1cc7c3af338aa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -211,6 +211,11 @@ if $checksum; then
 	done
 fi
 
+if $capture; then
+	rndh="${ns1:4}"
+	mptcp_lib_pr_info "Packet capture files will have this prefix: ${rndh}-"
+fi
+
 set_ethtool_flags() {
 	local ns="$1"
 	local dev="$2"
@@ -361,7 +366,6 @@ do_transfer()
 
 	if $capture; then
 		local capuser
-		local rndh="${connector_ns:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else

-- 
2.51.0

