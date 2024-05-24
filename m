Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8ED12DD84
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563639; cv=none; b=Y2sw0aWwpDpkIsYGx51FPGbnyes3tlQQQMAUKDp7lxzjffJmQREuCe910TJXIEgz+nV7wW0YAXokvT4khZl2Eg4KJJq08pV5eYph3KBPGuIu0Om4ud4gSY3vfVEXa2AH0jmpoLsY7uMi8YQ8uG47zDFrOjw/x/kLTP+n3tgsjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563639; c=relaxed/simple;
	bh=isSgg6Nbw4paOmQkxswWWXT5wo3Wu8UKlwr7DvZsRVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUADxyw8jPR3rDweJUl3hogjoL0SNJfqvS9Ox7quXhLokeFYY/nksHJEf7ZEsUN6oJT4Uejd8uQdzGDblrZ1cAaVmcdva2V1i/688r03c/OECHFeMvoBGQPJWjNH5FO4tWRMsGCvko6F4LcIcqqW/EiEQ06pNyCYlMg8kKIm38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNGR464m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNGR464m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62D3C2BBFC;
	Fri, 24 May 2024 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563639;
	bh=isSgg6Nbw4paOmQkxswWWXT5wo3Wu8UKlwr7DvZsRVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aNGR464m/4f89TKVnQ5i21M4V9/WrTnGZfNn1kAXP2Rc2tRocMAlOkPFq5jUdqE+I
	 GgDdJ5V4fdHEN1tHSkMtx18SDgAUn2fidwwVpv5hwQaup6CQHObI/+0gENDC+cI2Q0
	 4C0VHDkpKWf5Hzeu5Re4z3Y13So5S1bMDRiFXGL0SI2N1ijhgzL+CnnwiIi0oO6WHF
	 FvEnp1EszIff0d5sDqdnhJP+6Y4HcAxYXmGQA3yDl+BgcTKHz9KNyBifozhI6vdTjY
	 sSiy+s0MtZCR663b6I0jFGEHqVBTsulvXTq2cqQg6S4OlqX9Gc8eeZhvC3Tao1GuCC
	 w+PmlLRcYq7Kg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:25 +0200
Subject: [PATCH mptcp-next v5 2/9] selftests: net: lib: support errexit
 with busywait
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-2-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=isSgg6Nbw4paOmQkxswWWXT5wo3Wu8UKlwr7DvZsRVE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6ykgJwPl0+Z/7XOmGk6ni2G8k+Qnu3fNIa9
 K23sxmIb9KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCusgAKCRD2t4JPQmmg
 c0ImD/9Tda9bqGQNxFsz+/JPBe2R7dVNrx7gT0YcwcMd2oit/HW3XpeZD2ooE1jEV1fxL/tEjRK
 vA6GMMGFyTkH8L7JarhZEQAZtPyYdAqUCFRqJ7FuY70KV9paZm+Cd/tgQRcB0+NCaJJoOThZJpR
 jx9WTu8JEc+QlAJ87ob+1zTgDJdKmDQyNcbrtR4n/FpY9hhwTGM4E15d/UEdk+7w55XuiG5Z33W
 tCnCpuHMWWMGkgSFotahXriYe85je4BlIQSimnYp/xEMPUK0UGkq++ZU1AjSjdX0ol6H3FZFV9R
 huCLd0+qf1YbQ2gjX0prJxm7FKS3BMHG/C5lvSkGoNInW25IFPVNzKyTdnl7JN+h+E2itla80k1
 LJG/u/DnmJMlx1evXxdNOqX0HL52zY9hnGoG5nhlHhX23V2rlIJg5a3UZvN8omtoxchdQGqbLmW
 DLt1BlaLziFIajYa0w95hIr87+6N1NhNVBnycWmZw/yRTv9wX1M5H0K0tKN5KmdDvHkbV5njYTH
 6Yj35K6iuJ7szCdIHstIQdQqM7wem1+0BXW9qtYzMpmjjKYWrEXBCxgsMirc6VuWKnsXuHrOur/
 FHuSE5cGVG+Ba1RYM48SOGn14aeFo1HhuShNSPumnjospknuJjaZh7cNoEcjy1WHjWBYTnuvno2
 xXW2nb+tPYvohQw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If errexit is enabled ('set -e'), loopy_wait -- or busywait and others
using it -- will stop after the first failure.

Note that if the returned status of loopy_wait is checked, and even if
errexit is enabled, Bash will not stop at the first error.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index be80f7b1f9d7..2fbc01003b0f 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -68,9 +68,7 @@ loopy_wait()
 	while true
 	do
 		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
+		if out=$("$@"); then
 			echo -n "$out"
 			return 0
 		fi

-- 
2.43.0

