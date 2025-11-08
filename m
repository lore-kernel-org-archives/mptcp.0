Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78572135AD
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611688; cv=none; b=M8dJBX+y6Vz1Us6Fs60lhLTeuUws3b3erZCrmkhpNA+QZETrTbo8wNiklK3SU4esdSjJPkRtNSNxM4CGnnX5S3xuqSDt9NamiEiEQiVyDNAOk/iSN8j5C/IxNU8RuKCIZE2XcrJKsDiqvrWNakda7qRqIU13wMLbJM/fR7wEYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611688; c=relaxed/simple;
	bh=qPv6F4mXlUcAOs87xigEJE5dZJd0but/nPFkPx6K7cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9AZJ0Q5aoSf1bASE7M+JgO2gnnQn2ZOf4UhMxQranAwMMSo+yHYGaCFUP7OhQUYegOQ7zSrnWtXkPlvvHe/zPfBJSiGbXSDkfn/3qUI1qT9Me65P0Pv0Bf/k01N+o4aHtmLeZwBZSVtqfrhT/DCGJdpDb7MFXpNd54cT1Vdftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9j5nwaU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9j5nwaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0A1C4CEF7;
	Sat,  8 Nov 2025 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762611688;
	bh=qPv6F4mXlUcAOs87xigEJE5dZJd0but/nPFkPx6K7cA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D9j5nwaUHFfxXXd1pgQknT1gpVaWWntr3eWT4lGezFF80rC5Z8pBLgWTW23NEzV/5
	 Sz5msKQhLD6IECQ4rJtOB8QpRGaKRiS2HSuj2RtkE7rF2x5iXrEdkFHAy1Gm50ItdH
	 PSFyEbg680kiV9T2o/Yc//sye+QTyJUl/xtfwCHFB68e79CMrkU4RYEatNDYnNAtCl
	 zoSDU6ptBsnV12u0OB/iLsZcQi5WXNc3CojDfCpYq6cFrrlOYlxB/jHYmiXlx06iBV
	 388qmw5Emc9upEm1zkv3VoA86E283VQ3Hw/fYyDiNCsg/FqZpBEuootqd+Ir0/Vjzy
	 eeiBM3x/k4LCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 08 Nov 2025 15:20:28 +0100
Subject: [PATCH mptcp-next 2/4] selftests: mptcp: connect: avoid double
 packet traces
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-slft-timeout-stats-v1-2-c2234d277318@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
In-Reply-To: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qPv6F4mXlUcAOs87xigEJE5dZJd0but/nPFkPx6K7cA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL5Ax/9WJLGndybxXh7Qs+6aXfNVX3maWm8ThNw7TimF
 2W8XrS8o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCL70hn+e3q8mPL7Tk/ttrAX
 PKkCKc+f1+yKTy3JnMCX12h2YT/DOkaG9fM8rMVmXGyZ3ui6Lq/5Zml/zPQDIozbj/a1bTCNy17
 HDAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the same netns is used for the listener and the connector, no need
to take exactly the same packet trace twice, one is enough.

This avoids confusions when the traces are the same, and wasting
resources which might not help reproducing an issue.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 3a804abebd2c..1149bd150d6a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -378,8 +378,10 @@ do_transfer()
 		ip netns exec ${listener_ns}  tcpdump ${capopt} -w "${capfile}-listener.pcap"  >> "${capout}" 2>&1 &
 		local cappid_listener=$!
 
-		ip netns exec ${connector_ns} tcpdump ${capopt} -w "${capfile}-connector.pcap" >> "${capout}" 2>&1 &
-		local cappid_connector=$!
+		if [ ${listener_ns} != ${connector_ns} ]; then
+			ip netns exec ${connector_ns} tcpdump ${capopt} -w "${capfile}-connector.pcap" >> "${capout}" 2>&1 &
+			local cappid_connector=$!
+		fi
 
 		sleep 1
 	fi
@@ -416,7 +418,9 @@ do_transfer()
 	if $capture; then
 		sleep 1
 		kill ${cappid_listener}
-		kill ${cappid_connector}
+		if [ ${listener_ns} != ${connector_ns} ]; then
+			kill ${cappid_connector}
+		fi
 	fi
 
 	mptcp_lib_nstat_get "${listener_ns}"

-- 
2.51.0

