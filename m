Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0D4502A
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197594; cv=none; b=WnqOp0jlOlnGna/xxxNNMu0AiGehj5zVNW42rTWIxoUeZAmoe/15iTzOYlGuqXNPONIN6OhTw3f4c10mBL6kEfR9Mmyh/Cxg8ocv72ia66aGc0GfQx1PLBfw0cOoHwf41g31RHWYn190scYy6hB5Akrmt74uAMXgJV117zHm1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197594; c=relaxed/simple;
	bh=56YEkVJG32LKXgKyLYxW3RpM843KanqvmIy0SURcTQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbYZ3RqN+/2JwMJGAQEhiYAeg0JcwAgLyMlbYoHeYGaSOJo129ukiORNhAcMjYPhtCp9TYpouOaCkKf6PCroHzXEN/8crNfVmQvPyRl4svx/L7ZmFwfgpMewYH5zitUK0Y4stjbVzx3tQ48sxWvfCeILzPEbX6Ri7rVLVY74bKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP8sKtzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP8sKtzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BE2C4CEF8;
	Mon,  3 Nov 2025 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197594;
	bh=56YEkVJG32LKXgKyLYxW3RpM843KanqvmIy0SURcTQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CP8sKtzk9m2xfPurIHNgp59e653OJB9IXBjQhZCpP4fOx/2czIUcOrdzYy0zJ5iW5
	 CYAj5j48R6iUuWFwZ4efsA0XZx+D2oU0epACQyh6nSUvx12jo0tgcHxhPdnzB16GSv
	 FJmKH0gz1/Azu3ZDRUyA/ZJK07EAvmFl8M5FJXcJ5Rbi/LI63Cag9qWHLPNA/Pa9Sd
	 FD1KfpgxYXbJqXB/TMmkjEOXIAgTuwsBViv07G96Hjov301VpH2is5/PBbtsbmisVb
	 Bbn836fROi6Z7id3qip8ft5Jshw1eAOvcgKIFOdc9Jouwr9KXoP0i+WWzM7MGO3Qd0
	 Hxn1hlZowe6zw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Nov 2025 20:19:33 +0100
Subject: [PATCH mptcp-next 3/5] selftests: mptcp: lib: stats: remove nstat
 rate columns
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-slft-nstat-cache-v1-3-56025c09e56a@kernel.org>
References: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
In-Reply-To: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=56YEkVJG32LKXgKyLYxW3RpM843KanqvmIy0SURcTQo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI5GYLPWnhapawpMbzrpXun+zn3vYjdtlUvv91m+layo
 iAzJtqko5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCK6kxgZFlXIifTPdeuY3fJp
 JWOFI9u81zuipxt6xYTnOUyZvfAJNyPDba9U/+NiT4qyzF9az3AsLJi75QPHfsYfR/QiftjyZx7
 jAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With the MPTCP selftests, the nstat daemon is not used. It means that
the last column (the rate) is always 0.0, and that's not something
interesting to display.

Then, this last column can be filtered out.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 22ab39749ca2..f59268b25707 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -369,9 +369,9 @@ mptcp_lib_nstat_init() {
 mptcp_lib_nstat_get() {
 	local ns="${1}"
 
-	# filter out non-*TCP stats
+	# filter out non-*TCP stats, and the rate (last column)
 	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat |
-		grep Tcp > "/tmp/${ns}.out"
+		grep -o ".*Tcp\S\+\s\+[0-9]\+" > "/tmp/${ns}.out"
 }
 
 # $1: ns, $2: MIB counter

-- 
2.51.0

