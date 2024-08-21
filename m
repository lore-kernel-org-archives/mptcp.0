Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA019259F
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239717; cv=none; b=hX4GG+RrBSejdcqPENZJvAwwUVwOD5IO7thut/BNLzssJtD/E0fcE415eai9u3KOF303FinYA3geREyd2WiGsQLSfszB3aMTLmlwYW2M9PrVKuf1rUqKtHhsTJ31oRRuOAtmgjpDcqc+YopAwreMlJgwmPDRwXCd1RKrlufdHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239717; c=relaxed/simple;
	bh=rwzY4Yx4YajOr35ejccVb8MbkNsLer0JH0j5lMHZAQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXfet07m309LeePlsHhBFnQQIO2l+KUVoyWwHeVaA9w9WN9YHEm/fS3/zJCz1eGPA06OUq0UtnWf5Oh7bMD7ow1JBlFaleWx4gSiHutwetuiKzrkF5uK0bBIcjB86rc+JZaRESecovzz3KTyTfeLwD7jV/7RRmw8A6jgOPCEjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHVLHVU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHVLHVU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03538C4AF0E;
	Wed, 21 Aug 2024 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724239716;
	bh=rwzY4Yx4YajOr35ejccVb8MbkNsLer0JH0j5lMHZAQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fHVLHVU5boja28fP5O5u6opyNgUofxoadIKLPmX8aur1LG/DiezqUNBY7WeL6BsEp
	 UkFheAmQGvwk0F1BW6r+P8qGz/+0J9QUyifc7lshQ4gW0l1zfQbnULvzuCqJN0fhYT
	 hU8kETNfVWiLveSVqTN6n7MzJ6yqo9Aj4OoIQPZekT0jqEh4PMRGOxUPYEt53/k4LN
	 rMcVOnDKbLcEEdVy+MnrRrbZCFp+gL8zzt4guaXBrb0ntNgz9g5djRB5JExn2BA/6U
	 vILmB4jZMW0j+6ZEdkaKXFCpX5+ggzOH8AJoYHQX5CxXhlcicgXeLjtvxRDB+dyigH
	 Q71HuTK0vFwuA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 21 Aug 2024 13:28:31 +0200
Subject: [PATCH mptcp-next 2/3] sefltests: mptcp: connect: remote time in
 TAP output
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-mptcp-ksft-time-v1-2-c4ea94f41244@kernel.org>
References: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
In-Reply-To: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rwzY4Yx4YajOr35ejccVb8MbkNsLer0JH0j5lMHZAQk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmxc9hxXz4fF0lnGk0ZbMagkrQYcGJi/Gx/nhR6
 rh2aMS9EHGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsXPYQAKCRD2t4JPQmmg
 c44TD/9vmsc5TyhTwf8QjM/AstEhKJ6z0AZZ4r7txS4jnoE09rHCxWwf/vwFFjofSHl0P8iuEnD
 bbA9ysOOCDAe7JuMN7juUzs0crHX7YoYa4xBL8GhfhCMfYQRF06WpQUmGa5nGV6gg2yDP6WuPME
 w7M+maDpTcSh2h4+natcSNqedFbuxri4n7i3McLy7n7JNPb8GWU8Uu0tbV23ogr5L0GzjcQH3hq
 enAi14jUmDdtiAbrqBxiK0CqDnANgZO2dwTx+h9gvHy9s95AmzfajdKtsTek6VKtYI4FEg06w5v
 /tXt+INUnuCCxQOPbgzYJDfEunL87FLEYcn9kh0QkeYvor+ZWcyOjF0K5FsaI/TXoXTbwyQuZ7o
 DfpfzHfmV30a8xKB4uCz2yLE6Ood9marbil2yBIM58aJ/BcK9X6k/br/7hgj/FkWqxHlHJebrvW
 2II9RzmbGfKCPBLHH15WqFauu1GHfUwCAt0cR0UDT4kVoBMxEchNBMbEWR9P1sHrK9cn+YWb4L+
 oI8il5bxcXz/oTw3DXgd6bi/vh93IsZcgICs+pcjVYY26UGcwZtrw7F02vdGvKUh+yirbW2M2n8
 Pq1JPMj5d4bppJDdiJg56eVKYpuUZHibuHO6kEK1RMW5O5J8TH+rs2NUudAsC8PIjUXbko76koN
 jU6obN/DxqkW0CA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is now added by the MPTCP lib automatically, see the parent commit.

The time in the TAP output might be sligly different from the one
displayed before, but that's OK.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b77fb7065bfb..f61e2f5870ea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -431,7 +431,6 @@ do_transfer()
 
 	local duration
 	duration=$((stop-start))
-	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"

-- 
2.45.2

