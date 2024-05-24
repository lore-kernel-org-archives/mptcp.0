Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC3284FB0
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563643; cv=none; b=RAh7hPi99iwCDqAsoCtKc1e1U+mGk+r7nAOvQUiOuwFczNC6+eEV+gOCFzTDFPrQJaMayKG3/LdIbGjmi+5Cg8GWfIc44jK2Xgw0qghUR/m/2ryHNhrKfrnYyg5sGacQw2u3+7zcF0QQcr1P9y6CS2YKAZX8z9wWZ59JjovVu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563643; c=relaxed/simple;
	bh=sGr2uTeKlT3jZmTEvKLVKhD90ck6MQ67snxcFD1F3VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QghJxlnyUmNHgNzuInLuLd5bOCKmhS/EOOn9cvNLiBFV/qdFdMQ2+2W184lQ5EhB9UCnuzYRD+bHWfcQPIhR0vvQNh7H3rQOX9pjO6QcJV/V5Nj1073+qUya9a9po6g2KjOyVTfLtpyDvKgwSJ4RSUul3QXnC+vuGkP6fWbC3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUksn74+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUksn74+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2E9C2BD11;
	Fri, 24 May 2024 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563643;
	bh=sGr2uTeKlT3jZmTEvKLVKhD90ck6MQ67snxcFD1F3VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tUksn74+bwD3Rh4cC98JIP0fUd2pXYxlic/oNajEEIQEws5eN+8MQUbOg9wxwNvoM
	 xFetcXaos7mtFwGXjDor8Z3MdID/7b91JpH/mGZMlkuHU4NO0/UALX2H74Rke0Tb71
	 jjx+mNHKLYB7+XHLitIB1ITvjmOyZf6ZwfmxlV4GzwIiJgSA0sTADzipZy5ag0a431
	 wbVxp55H0Ysmbw9EhKSNyN1J/pX8GcWN26ZvSV2Eo8rugxV77oE/B27Wuqt2Jespjz
	 4zc7AkCnDFvAxKHSwgIotPcc6h6GP+JkRxfoAsvtxsZ9eVFcXxwk9+/+ISVq+ItCkv
	 30S2obvHG2gSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:28 +0200
Subject: [PATCH mptcp-next v5 5/9] selftests: net: lib: remove ns from list
 after clean-up
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-5-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sGr2uTeKlT3jZmTEvKLVKhD90ck6MQ67snxcFD1F3VA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6zj2axfXIbxRJmMUe53CrdB215AXPOVK1iN
 EhY7JAm1NmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCuswAKCRD2t4JPQmmg
 c5tBEADqbuZS4M2zIRij+NszDyWvS3cH3dEN3AumbFm7ou/3BxSoK0VXl+pDDgXnno0z8sg7ht0
 RZjOjzWdlXHS8tnOTmrtM1pvtCXsUSIEwwWctx6NCLBwPOLkebUEvq/URwGexhWM+ID6QirINKV
 YVmOGIX6wveJMZkRIT/iOUkBiUseI7hp/Qkyaux4YojpXu7II8JZeSc8rnWt4bI5Q8k1RPF3y5a
 yxtDj4f+HbQN5nj5FivGcnLtt2/uL0dcR0PpMTpEyA7v2NQGQppEypZlWQo+T78UtcyTf75bHWL
 OnhkxA3RrH7+YrFbxrXxNZ3h+gFlup9UygduoiaeFIp5orY05+VKOHKey8jgseXZTZUM/A5QPsJ
 6+JUh1W5sCdRuhiUkD0WzNj8agDQxi+NUUB/zm99BNkSPsvzg6rFPeySI+Y1DhykAm2NVaGXLEn
 2n7yR0amDVreVqWl8RdemdJZTxYRBZCrc5PsPpprZUS46kvCKIUQpItl1u0aaOARS+kUsKZzExE
 24+drJGmMCMiy/tp0MCpP7aSvWsoNDC5O1bbOvOZkdi0GQ5Fr3VdurDvBoA76nCaEuq9IAybguV
 sFZQ6mNoSKhB8bqWEKnzmOv6USEgnVytlquTDg8S8HFFaifAIQFRsVuZtWF5BubWZCi2j6rY/pX
 Yh2lF8NAO9VWgog==
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

