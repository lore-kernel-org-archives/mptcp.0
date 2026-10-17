Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DB1A6820
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215267; cv=none; b=Zwmx7UMJiZcry93aB2ALkNtSafCfmRu3Yf+Dx7HsKzKiABvl1i6h4uO23svc26X2LiL4RmWkBZ+YgMNs6HJ2WYbezhCnSuTmO7gB7OVIXDGvOEdgEJJOgp6i9CcbDAesb86DCAzraBSHfQfZtjzJpBtiXyDfJuNmeIhW2PGVig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215267; c=relaxed/simple;
	bh=vVb/0A5sJqoTl8S/0POb3mfGNUq7RASu5o8iKWctIX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y7J1SiUjfqMXNh4x5jbdqekkiwIAryxR1Dw2/jZ4+z+scKLt9FKPtgKyzWgEO6pNCY3USMSFT0jKNI060wteFes8pvJ6jrGVY4JP7TgeK5YwxTrcHF4K4ZRCRdoushHd+kYDfWzQ2hA817CLfXaA8rymUx3P3szd8Pzg/40udyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdTkKyfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdTkKyfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A660C2BCF5
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 05:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792215267;
	bh=vVb/0A5sJqoTl8S/0POb3mfGNUq7RASu5o8iKWctIX8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RdTkKyfJPYB6IVioNAJSdDeYe3sw10DJxbPeWR+Bbj6UCO96IwC+NSf/5GxK1nqTf
	 YTbE2gP9w9SNwhSND31mRBRiZ4BdfuSsn8XqsdQMihE5iIRsyORCFRQXa6DK++VmNB
	 nxdWOBcNfXbv18U38bB47jfkOJOqb7bfRlNGPeI/tc5MEVV6NolkIKdg53NDSv47qX
	 jZE596NdywUnQlyslRagsB9cTy4E8Nd1KQVmQT9z9C0XiNNzBjQjotNEf290SQVccq
	 aq9JS7xHRw3BBX7+DH8K6dgailXW8G27jr6zoeHaTtmCARdYizvgZBPll4tYxtdTXk
	 jp+8GtKDg2jzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0308DCC6B2A
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 05:34:26 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 16 Oct 2026 22:33:54 -0700
Subject: [PATCH mptcp-net v2] selftests: mptcp: sockopt: pass total bytes
 to do_getsockopts
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-fix-mptcp-issue-638-v2-1-cc32774a8b0c@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OTQ6DIBCFr2Jm3WkAoy1d9R6NCwtjpYlAAEkb4
 92Luu/y5X3vZ4FIwVCEW7VAoGyicbYIcapAjb19ERpdNAgmWs54g4P54OST8mhinAnb+oqkuNY
 1Gy5CNlCSPlDB9tYHHLClBN1hxfn5JpW21g0eTUwufPcHme+Rv2OZI8dGk5Sy1y3j6u6DS86eJ
 4JuXdcf2Wr1CdMAAAA=
X-Change-ID: 20261015-fix-mptcp-issue-638-ec1dd30f7295
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792215265; l=1730;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=bDtX/TG0Nx3wxWN1lrqFhjE3N6kmDiE8hS4Puy/FOAk=;
 b=vjNMCeKagb08Jo0WPKIqdHp2PfwFCDPgFSMAHeYlimtfTLNzfvNPMMQ1L6FjnCW+kqr7aecOh
 ndy+IePxKh2DHr6xAOZCi++ijmNdOYDgPnU+Jv1TO5vxhnnZdRJ//HF
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

connect_one_server() reads the echoed payload in a loop because read()
on a stream socket can return a partial chunk. After the loop, it still
passed the last read() return value to do_getsockopts() instead of the
accumulated byte count.

do_getsockopts() checks MPTCP_INFO first. The client samples
mptcpi_write_seq before write(), and write() has already advanced
msk->write_seq by the full length, so a partial last read() makes
the write_seq assert fail. Pass the total instead.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/638
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
Changes in v2:
- fix commit message to describe the write_seq assert, not the TCP_INFO timeout
- Link to v1: https://patch.msgid.link/20261015-fix-mptcp-issue-638-v1-1-5de999ad601c@proton.me
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..7b4ccbe10ae1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -627,7 +627,7 @@ static void connect_one_server(int fd, int pipefd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
-	do_getsockopts(&s, fd, ret, ret);
+	do_getsockopts(&s, fd, total, total);
 
 	if (eof)
 		total += 1; /* sequence advances due to FIN */

---
base-commit: a22035be824449c4921ec406f6383089016a628c
change-id: 20261015-fix-mptcp-issue-638-ec1dd30f7295

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


