Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733941770;
	Fri, 27 Oct 2023 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D95EF8PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B0DC433C7;
	Fri, 27 Oct 2023 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447442;
	bh=4LaAPrJNRyV9Kxo822qcQi+Li0GOQODfZw7dr5xUWj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D95EF8PS0vAzxAaid2lxNlYPGx1sTXOk1vsQvohtWTt75qmapsLwlnDk15w7RIRz3
	 lTye60XE5oJn+s0B7MIOWavSX01D3axcPt1P/KCYwjf98vQBwVOlWxu6YjIj1LYVCK
	 YXyZZdBgAqvZVoN3KMFA5pYHzIr7C2hEH47hpCLpWlS6ixmenjHt9axURdlF2Gnikg
	 +qmQXuzUDePe5qhdE17FlJdRYPRtS4X9JUT5/XnBWUROnn9p9KrQfDFWVZiyo4+B5J
	 FaEAhxNFo9fPFvbZAA8ZILnqPK8nILjs0Cjj09guv8Ra61ji0T5DuRZ09oIvXU616u
	 Z8AJ7UsSeGh4w==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 27 Oct 2023 15:57:13 -0700
Subject: [PATCH net-next 12/15] selftests: mptcp: add missing oflag=append
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-send-net-next-2023107-v1-12-03eff9452957@kernel.org>
References: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
In-Reply-To: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

In mptcp_connect.sh we are missing something like "oflag=append"
because this will write "${rem}" bytes at the beginning of the file
where there is already some random bytes. It should write that at
the end.

This patch adds this missing 'oflag=append' flag for 'dd' command in
make_file().

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 3b971d1617d8..c4f08976c418 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -593,7 +593,7 @@ make_file()
 	rem=$((SIZE - (ksize * 1024)))
 
 	dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
-	dd if=/dev/urandom conv=notrunc of="$name" bs=1 count=$rem 2> /dev/null
+	dd if=/dev/urandom conv=notrunc of="$name" oflag=append bs=1 count=$rem 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 
 	echo "Created $name (size $(du -b "$name")) containing data sent by $who"

-- 
2.41.0

