Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476478288A
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330147; cv=none; b=AlSSnPB/xzTaPqumvaaPi2jkn2k4nbavj6NQt5a60OTbsykH4zMVHgAxwKk/8x6wG5jVLI4zNqG40SUiDLZAmpOnIu1VN6rX0ZsHfwlQSTfOFtRmFnAGeYol8QCJiJM2ifNlnu9zlo+C8+FEcwLl/06g6MdtCYnTJVy3X7jKW+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330147; c=relaxed/simple;
	bh=FCg66R3dpD9v8yo6mDZUXatJ8PnXAXVMc/jsoadc2+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TJIOVBc6ak+3G7eZyUc8zlycvVgy6cbj6cZ1r7VU23941EB52wz+fPpQNOt0b67QskwTPymx3W+SVsnsr5oB7101E+sp/CBwsZ6F1rBbTRL7dk4248nzdlKnTleRK23DxjLuUJUG6rNT3YwvbvegoBqkQJfybBNL9Z2jgRAPq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVGT4S7O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVGT4S7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E191C433F1;
	Wed,  7 Feb 2024 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707330146;
	bh=FCg66R3dpD9v8yo6mDZUXatJ8PnXAXVMc/jsoadc2+0=;
	h=From:Date:Subject:To:Cc:From;
	b=uVGT4S7Og8pyAjNADNd60CAHkq+w0JYLXe3g6yP90Rtxsig1MSUKBDun+aacifZmr
	 pUhhod2XWvy6g/Ier9kJ7pBGzXTxYbjnvuQE8IbGE2e5bXj44vjqI1s4y4fJPS8YH8
	 q9xj63RA/JYTHbJVgZzeR7lyfXM94+M9SKSTsgvYKV9AidRoWLivgEwfpAW0Futboi
	 o14v2SziJo5MZeVewyXM1b7y9+n2cORhldrhC/NIPyKSjSBVKqPTn/wCvLaZTw/R77
	 3BOxeK2JOziMHgnm9T04d0s5vnAyoknuJZN8DapOt5ixRP1fNok3k34GN9iTIxWHIw
	 jK6k/Qem2l5yQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 07 Feb 2024 19:22:11 +0100
Subject: [PATCH mptcp-next] selftests: mptcp: stop forcing iptables-legacy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFLKw2UC/yXM0QqDMAxA0V+RPC9QS2Hir8ge2ppsAe1KE4Yg/
 vvK9njgck9QakIK83BCo4+ovEvHeBsgv2J5EsraDd754Ly7o9LGRmqKe7VcUarFtJFiYUOfeA0
 xZE7TCH1RG7Ecv/0C/77QYfC4ri+BPudUegAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3275; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FCg66R3dpD9v8yo6mDZUXatJ8PnXAXVMc/jsoadc2+0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw8phYht+J60QMbpvwZNPy6ydTwehwnzz2atQy
 V4Ov5+5oVuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcPKYQAKCRD2t4JPQmmg
 c1BbEADauEiTQS9EkhZY9w1IXwov3q4vil/nC7D4TDhhK8XjmTbJhLrymdWKKRU8p7ly1YXqktZ
 iE9sM42ORQn60JKU93KqJ9ks8//qsk5Dk4YCAVQ4DpsUmXEohlTKP1ngXPREKqX9NxDDyuUoQt7
 YQ8H5iN6PkoWGmanISNjyqHpcpiAVVq/27EEIyG8NMIAlgiPe2c6sOP9HPaESATUCofcb07wUjI
 Gmc2KedCp9G7k3Ly35mmqRldCcqbUN6DUV6vcvFuqNQofjwDOdqnxVFOayaWpaDRKKyDVEPEOM/
 axliGWHGV3On3PZA0VQjZ5ihNtX2QANKEf7Ri9idPIoj320RTrA5Lw83P6qvTgOJKISNLc243DN
 H06xrqbVyArA79u8IZ+SdwgsILEeHQtNoM9Z7zSNwCeAOimfw6lPrcce48zByLbOADj1HQqA2nL
 ymKQxkOOSWnqhmtqNbs7YgzrePvQ1G0zbkeUDpwmOofU6f8Y2hbPUtXczgpnECOhH5CxLTscTSE
 WBZUvTV/uGE82qfs9uJiYsYP+7naKJHfTWR6NyPy7AeF1G73ZYsfnwJ/TJ60RKtyI4B+vNmNf1Y
 utb3z5M3CsrI7vamoNrqYlZEsRphbVcMrl0vDJhqeyW8NOKwEErzyaWNSV0h0oES/fRH/yZF3KO
 JSNrWmDLl2Xh8LA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Commit 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if
available") and a5a5990c099d ("selftests: mptcp: sockopt: use
'iptables-legacy' if available") forced using iptables-legacy if
available.

This was needed because of some issues that were visible when testing
the kselftests on a v5.15.x with iptables-nft as default backend. It
looks like these errors are no longer present. As mentioned by Pablo [1],
the errors were maybe due to missing kernel config. We can then use
iptables-nft if it is the default one, instead of using a legacy tool.

We can then check the variables iptables and ip6tables are valid. We can
keep the variables to easily change it later or add options.

Link: https://lore.kernel.org/netdev/ZbFiixyMFpQnxzCH@calendula/ [1]
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 12 ++++--------
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07386e21e0a..20140ee4de2e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -161,15 +161,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
-	# Use the legacy version if available to support old kernel versions
-	if iptables-legacy -V &> /dev/null; then
-		iptables="iptables-legacy"
-		ip6tables="ip6tables-legacy"
-	elif ! iptables -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without iptables tool"
+	if ! "${iptables}" -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without ${iptables} tool"
 		exit $ksft_skip
-	elif ! ip6tables -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ip6tables tool"
+	elif ! "${ip6tables}" -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without ${ip6tables} tool"
 		exit $ksft_skip
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c643872ddf47..dac8e1fc7143 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -96,15 +96,11 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-# Use the legacy version if available to support old kernel versions
-if iptables-legacy -V &> /dev/null; then
-	iptables="iptables-legacy"
-	ip6tables="ip6tables-legacy"
-elif ! iptables -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without iptables tool"
+if ! "${iptables}" -V &> /dev/null; then
+	echo "SKIP: Could not run all tests without ${iptables} tool"
 	exit $ksft_skip
-elif ! ip6tables -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ip6tables tool"
+elif ! "${ip6tables}" -V &> /dev/null; then
+	echo "SKIP: Could not run all tests without ${ip6tables} tool"
 	exit $ksft_skip
 fi
 

---
base-commit: c2469b38e369c3f2b9577beeb9470cc757abc1b9
change-id: 20240207-selftests-mptcp-iptables-nft-2bfd4a4cfb81

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

