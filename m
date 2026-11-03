Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676635;
	b=l9TlwCUiJtcjl+JnS2MT6OEQz+5v4pdfP3c+gAObWXD3w2b/woTVUSlIjwnnWjmeJVr4
	 Oc8ImGE5gsYLSZeW44SuyxvAMGzD+zXrMuEiDUTtiO3++cjJgdVVkC6T3NXAz4Od3b+Nn
	 Z0uo71aLbOmSjisiV3fLu+Pu+H11r3+Pxc93B8tuIE0IvbS3XpgasHJ8pY/gkZmQi0SHI
	 zK2+2+2WIV0t/ZwoDLZteJ2ZsvGLOFWde0dKGxpdavll/CawUWF7xy36k5dQyyWHu7jRC
	 hZh3ecq/47io1dPBLZ4Wr3uQEMYtne+/81QsuU1PnwJu218opGUeAdeaGigLpdx3Kow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7+j85nzl2zC+6eFpOE4tO71tHI7dTH1G+8o1HEDJfMA=;
	b=An+mgFGKPoFzXRJFpI7yVy7/FRCz6OTy9dmiVXUR7NPgAdYZOcw2oUrVLXZh9IwNnoG9
	 5WyKNTzPLRXv+QnlQOQJXJHzLsWkYl5uwXuQKgC/IJhf4X4iehKw6bm6sKFbeiIY0MQBn
	 eMlMTceDL3iAmQgLZbocBsDHIBTurCdGh8+Iq9gkji4ZBtIL4chnUtRTL62OW90Uevl4o
	 tFXK3z+xP8HHsIBxamhmaZOlarwKut6VR+gl0huH9ffKM2VZshkb1CimA2IozStOWo02Z
	 M9XeCPUEGOl8ak8j7L4Ma9GJPIFl2dQwsIHit9G4LZSBxbfDv9KVBy6ychqEUWhnkVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxTdwWo6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B625606D82A
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxTdwWo6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F8E1F00A1B;
	Tue,  3 Nov 2026 03:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676634;
	bh=7+j85nzl2zC+6eFpOE4tO71tHI7dTH1G+8o1HEDJfMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxTdwWo6Zkinn6CkM4D8iUHrbzFrFeNqKNRLehKXYbSqlTvRjLlylg6wa09YBuso5
	 v7xfz7D47yDBPAWOL/IyqAlQFN7M6CC/RxpASHDyIdSb2BS7ea4eee2oLzqRSvi6DH
	 f1lnj9H6E5BugF7c8xlSEbxxI79uN8lQahMkA3pFUPyaIkwI3MmyTCIYVZh0S19qB7
	 RUBvWJfMHDSgVOZkp4rK5dHuh6CX8d3yg2oe8CwL674ELIlKTgt4weBrLRov2LJrUc
	 alLm6rcYzadNK8zIlaPse9JPC+IptPczqpTvehPVFKXYAfQgfwT6UYjc/fBrJdv29p
	 4kyN4o4N7/0tA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 7/7] selftests: mptcp: sockopt: check app_limited
Date: Tue,  3 Nov 2026 11:29:56 +0800
Message-ID: <7f5deed2c76c4470c30cce0571574568dce05a01.1793676064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After a small data exchange, assert tcpi_delivery_rate_app_limited == 1.

rate_app_limited starts at 1 (tcp_init_sock) and is cleared only by
non-app-limited rate samples. The preceding commit makes
mptcp_rate_check_app_limited() set tp->app_limited on subflows when
MPTCP has no pending data, marking outgoing skbs as app-limited so rate
samples don't clear rate_app_limited.

This guards against regressions in subflow app-limited accounting.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b8158a1198eb..9517c530ba21 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, total, total);
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	/* app-limited accounting only checked under EXPECT_ALL_FEATURES */
+	if (expect_all_features())
+		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
+
 	close(fd);
 }
 
-- 
2.55.0

