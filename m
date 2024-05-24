Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C84584FB0
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563638; cv=none; b=JdxOJxdb3J3EwPeUqUjrbavRVBZ+I7zI2SbWJXcHMox4+dnp81ziOqmI3SvBJIGBCtNirheRhz+jZHGpt7bh/tqrSbWsSOIJC5zk8seS5W4+AoPZ5Sf4osQyWak9CXfd2NlhAg0T68kB83/zIeRTZ5MiGRyTZLWC/C3vJ8HabbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563638; c=relaxed/simple;
	bh=5sF13AQ0XQYTT9ojTSNuw2FASfABGqn7HXvokl2i96o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJqx+I67Ja6FU6d0LXBsxRzHjQ+gNP1aYx+2SK2twv3VwRWNMIwzvLA3UWn9hQF30RHvupjwftnVm2I8uX4JHIBF27x/L9XT5gYl5a/Pc3xBLmWvb5X+xnFIQW/st8+1k/IBFacHgB2stXcZdhoN2IW8sd+tJOrljxva1jaaONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZWVD/6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZWVD/6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72928C4AF07;
	Fri, 24 May 2024 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563638;
	bh=5sF13AQ0XQYTT9ojTSNuw2FASfABGqn7HXvokl2i96o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YZWVD/6LShvFj22Q3ZyXFy9Q0dRIYx1s49qWDZfAW6yZiGnsgO83hsh/GBJ3pU+Wu
	 Hd8mVsBx4jN1WsdwnZZJBWrX2vr8a9jXNWQO4h+sAEsNB+tpF/jIPs3728SkbHhdS8
	 Fu5X+ut94dCVU+MuhY9VCrhgWN3ILOJGp2djMBx4ptzlXatBrrXDkkrs2ftRXA8gzK
	 fonRh7H8M+cziZAlyiKnFZanZA8hA8hOpsB7L5ruzMxPdVRXWGfXZJBBiXI1aC2CN/
	 uqIeN/iJXWeWCn7wL1VysvlINvzGoaAk64FqkCNDpAdv62JUH0pTFcCArhEAdo1G7x
	 eCcN+j/aKaGDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:24 +0200
Subject: [PATCH mptcp-next v5 1/9] selftests: net: lib: set 'i' as local
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-1-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5sF13AQ0XQYTT9ojTSNuw2FASfABGqn7HXvokl2i96o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6yh3fCKOwNvBlpGvGfTcphtq/zWnetB79A9
 sZ7qVFQYc+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCusgAKCRD2t4JPQmmg
 cwzMEAChUn7BJAYzIS6Cz53pSNOwynH7dHCHJQa+rjgZ7IE7pFk4jwEi3ZI4FJyMkbDAM3m+DvD
 tiDH0ulia5e4k+B0RyboS2p/SdjibDH4a1QJtGspCkRNME8t2yBnAgkXAaIzZoVZ0fNrZuvFHCp
 +YgQD8VfQT+Mc+gD7Ol5JdYqwyregSBcqdh8LSUcc2bX+2QxDZ6mT+zzclqrNTzUNAbkhSJpNqR
 UDSWo+dHhb0QmTHJxzbWho+X6NQU212quJy8Lq7lnCYpbibCywI2VxgwrgcsMqvdLp7qh0ScIxH
 r6VdjVjzV6zvMlt9GfhGA5PbOTHOa9TZdoXfKkrhGB5S8fyXXX0I4TDsANEF0aGh/Bdbb3RKNIi
 a75rgiFJ8ghTX8M5eykKBAWsZgiFqPYEXEPOL8FChon4Ozx+BrMWmEqLxCp6v/hZdNmi0uBGm43
 cGDxEdqUon3m7SbApmHwF0VuYF+Ks2g73lxT9WqcxvixE0JI0XZMoEBNKS7BncWqPmBJHhHBA6M
 uiDUZ7vLQPTlIl48NG6X1DdFEMJa3JIPF7E+wXpJzltYseIc81wrisehHGXWGCawHS+ffzflvme
 rNydB5efjcP5tc7dAtcBowc+Txk+jDFK2c+NSJiKsASy+HJ/Q8iva2gieTTkawViMT2XL3OJExt
 AeSowTkC69dXeeA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Without this, the 'i' variable declared before could be overridden by
accident, e.g.

  for i in "${@}"; do
      __ksft_status_merge "${i}"  ## 'i' has been modified
      foo "${i}"                  ## using 'i' with an unexpected value
  done

After a quick look, it looks like 'i' is currently not used after having
been modified in __ksft_status_merge(), but still, better be safe than
sorry. I saw this while modifying the same file, not because I suspected
an issue somewhere.

Fixes: 596c8819cb78 ("selftests: forwarding: Have RET track kselftest framework constants")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index edc030e81a46..be80f7b1f9d7 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -27,6 +27,7 @@ __ksft_status_merge()
 	local -A weights
 	local weight=0
 
+	local i
 	for i in "$@"; do
 		weights[$i]=$((weight++))
 	done

-- 
2.43.0

