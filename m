Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544826AFA
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807530; cv=none; b=PJ7UO+9SHecOwNguDZu+GMYPgNI2g3Goxh394Kf8iHfqR3o1hMz+eiKTNtWovG8uRjLiwa9rg9njQu3XFM3ToxkF2FXW2oF1H/RbAZkpcfXFR89ITx+fTrG0qoEAcSsCaxBxf2l85tNpuUTWuz6BYhZJ/txIKB6wg4GknDsutjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807530; c=relaxed/simple;
	bh=sGr2uTeKlT3jZmTEvKLVKhD90ck6MQ67snxcFD1F3VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2/zoBI4QvqK4wGUKJyjR5npLX+co3EFxTs42vcnC5ilSRGsu/1uDO95bqOB2fUK/FFRsgxe+FeWojWwpQTmelXisfr/0DaUHtiSd4DFUlMXWsqAtW2SI37dtsZh//Cf3zndjiEXEuDUq2fsrSLYLY1q4OwH4LaMPq84+eibCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZyo6qa5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZyo6qa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2458BC4AF08;
	Mon, 27 May 2024 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807529;
	bh=sGr2uTeKlT3jZmTEvKLVKhD90ck6MQ67snxcFD1F3VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QZyo6qa5jckejtIa+g6ibDvveZPgI3e4qB3As9CK0LO+E6EaSh0k3DKrLBy2ZBQi5
	 dLmUz45VFsR/D96zFzj6BnJy2DyZPo+q/xuxry1RQAv0RPujYQNhLme+tUD7NoSuvh
	 q9INzGXfYTbntxnWlcMdDLYwOPq8w3XViDsttCgpxh39JVbyeICDFSY0xY7hN8VCN0
	 4qHyHFWYnXjcFMVSLBS+KmIR8Eg3i12vitgbzERQL1cGWYiEJBj/lgijMeQfNQdrd4
	 SWg/mYkdC/vUY+q5mev0JbWO6cGR+EKHvSfiIIw5eMIUltFudOKGU1FZ1vGohR9UYX
	 qeh4II0rKQq5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:32 +0200
Subject: [PATCH mptcp-next v6 5/9] selftests: net: lib: remove ns from list
 after clean-up
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-5-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sGr2uTeKlT3jZmTEvKLVKhD90ck6MQ67snxcFD1F3VA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdikuSiqcSemsCMtIfeqF4avuftvdwoO79ev
 oekFYMEjIKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYgAKCRD2t4JPQmmg
 cxbeD/9TbF6IAactOHpOOZqRsezXqXzRqIxMKG92fGDaNX3rQn8sY/F2g/nd4S9iZ5Z7JVp+/BU
 yGg/QfrecyRfzoJ8WdJs0H4HMZrP4/5h/omAJ7OGSZLg4QZ5XsobJNunkADbVoZU6riLZH08Q63
 J1vIKIiNpA2QBzvJbtKVaMvDY6wV8EB8b3JqPhZQwEvVeJl6YZMI9NQ4ocoT3CdITmBUTMUxNLw
 M5bZni972tvgFZK3zzWH4Vb4Q5MxrCNWF2hLRbQmWO9k9VR3fsBkfri8/sN4TbLJPNH9ad0wym0
 sbCZBnyF1WoCLGQSneYsDdRwJ4lBRKiorMqzbLXbuB0L9xPtn1KzbuSIt81LILCCLWj7IrGdeNP
 rSFgnp9DOhylmFRAMCBVw33dqQ6/HsUaDalyLSqYGZ9T3tzVmIBoWxVW0/uSz71IzAuQLmCM8Kh
 ypVy95JCt7itz+bd2DDIpC96kLX4nAyzgORB6fNh+xDpAhnVDC68l72tys4ofMgCiU/TZR6rlG+
 1xy4bR2Y1EZNQVJUuzW/uqG8MDTkiYyhNbT6wylufGz8rHW/JPlDI8KTy7ZDD0hpFT1sXXzzIKU
 1Y41NCRE4gx/OLdYcPlwLzVuJtjWGiM/w9YtvB++QSq9Nh+eJxNRZFeNWtrxyc3FFxe+v4Xnggz
 pjjyIOVgs58XIDQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of only appending items to the list, remove them when the netns
has been deleted.

By doing that, we can make sure 'cleanup_all_ns()' is not trying to
remove already deleted netns.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b2572aff6286..c7a8cfb477cc 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -125,6 +125,20 @@ slowwait_for_counter()
 	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
 }
 
+remove_ns_list()
+{
+	local item=$1
+	local ns
+	local ns_list=("${NS_LIST[@]}")
+	NS_LIST=()
+
+	for ns in "${ns_list[@]}"; do
+		if [ "${ns}" != "${item}" ]; then
+			NS_LIST+=("${ns}")
+		fi
+	done
+}
+
 cleanup_ns()
 {
 	local ns=""
@@ -136,6 +150,8 @@ cleanup_ns()
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
 			ret=1
+		else
+			remove_ns_list "${ns}"
 		fi
 	done
 
@@ -154,17 +170,14 @@ setup_ns()
 	local ns=""
 	local ns_name=""
 	local ns_list=()
-	local ns_exist=
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
 		if unset ${ns_name} 2> /dev/null; then
 			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
 			eval readonly ${ns_name}="$ns"
-			ns_exist=false
 		else
 			eval ns='$'${ns_name}
 			cleanup_ns "$ns"
-			ns_exist=true
 		fi
 
 		if ! ip netns add "$ns"; then
@@ -173,7 +186,7 @@ setup_ns()
 			return $ksft_skip
 		fi
 		ip -n "$ns" link set lo up
-		! $ns_exist && ns_list+=("$ns")
+		ns_list+=("$ns")
 	done
 	NS_LIST+=("${ns_list[@]}")
 }

-- 
2.43.0

