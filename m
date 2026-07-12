Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2202373BEE
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850101; cv=none; b=qzIJa63wMizqk4nmst4B3+TLdU+/wbJ2B/eP2r/eIz3iz8diJZmjp+d1gLyO3BvnYsnq7kfaa5+DOrOCMFbhfLbFr0IiXc9txBol5nZDktiNHQxcNA31+c4iEF4TlWrjQ1nkUNQpZsFX9NsqWtytmo2NGBFBbNZaYJ/ulZ2Fm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850101; c=relaxed/simple;
	bh=tUV/bG2aSdVj/OffuGWN6+Gm/WPwU9Cw0uIodlOIVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+C1aRb+fqZFGwmo9pgdH/NR8s4Lk8INha4+7twb0tDin2KYzo5JT0wJM0TtwLlCaV9xrQqaRiEmrHueN6EOYWROSm8pCfdNpVeNjatxmKVUh1I4xMw6ayzG2/D/XwqMZ/udtu3Cqg2fIjll+rEJZONiHEmpJEg9Ny079M88Cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcjOg6ZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcjOg6ZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFF01F00A3A;
	Sun, 12 Jul 2026 09:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850100;
	bh=VsSoKOMdG6uaju5gb7OaiZJvP8qbDxGhPteeWsy1wUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcjOg6ZMSUo8xpXoOdIdskEryFYCa8orT7wIYTJF6C8q2/UpRr3P+kjMF43JtBwVj
	 O7x1ot5/wioMkdqV1NPVPD3lvEJ+ZTTAtrC+wb/3J3GGPxGYzCoxPIEj6BGav/8qf3
	 ge4QF3pWRNqrZGU+N+9cV8qDcligMtUf9wuDorvZa1F2wD3ExsxWSeCZfdiHq9NtYb
	 7Ol3ER5OfVQ3FgH8fC1ODesiECvNylRu8SQkTwpm9g70kmgczkJrUjLlmGWVN3aRjj
	 N85SiQ4/ThnHCKtzRKv1py47/qGwAGYLkVFD9oJPr2PVqqVu/aBj8YNbAM9GW8HJ25
	 dk1dofgrT4gcw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 08/15] selftests: mptcp: sockopt: read exact payload length
Date: Sun, 12 Jul 2026 17:54:14 +0800
Message-ID: <9b27a4c74db82b52f09fd1f3ca9e8ac42c9e9c60.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the exact remaining length ('len - total') when reading the echoed
data from the socket, instead of the full buffer size. This is possible
now that the payload length is passed from the client via the unixfd
control channel, making the read size explicit and avoiding any potential
over-read.

This also silences a false positive -Wstringop-overflow warning from GCC,
as the compiler can now prove that the destination buffer is large enough
for the specified read size.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index c7605ce5b9e1..e717dddc6734 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -638,7 +638,7 @@ static void connect_one_server(int fd, int unixfd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
-- 
2.53.0

