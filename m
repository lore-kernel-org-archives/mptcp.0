Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCE27877D
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455498; cv=none; b=ea0VPJ6sPlS/yPotYldMUsRo1vdiqafUmMMANjysANGZsJdVljkeOhYP6NPWcfKK6ooizmZFSCY6edrIUAc0SjsjhFm93WkMs1KY+yTuCtTYJKhX2R+mVkrkUk6129ThsfLgY1v42X0Td1sadhkmvTqCQsZB1hVFa+yaCD8dTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455498; c=relaxed/simple;
	bh=EHENzNVQYoEkrsZOJYba954H0Z36EQpT8zSFFfpaLyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+3vsp+1zLdJEL6uAwhG3tDEVxNUGGYUGov0iMCDhGq0shyAsSbzEDnesDlncvXmM0iAVe3V43+rnA4DrQMfrQE1cmkH7UgaZQ1uX8BIO6c+n15Xe+MuQf0XWJhKiw6fiyLARoYMLwNDUb1Dbf9Bot+8Ce6VADxu1H0BP6q2v9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLdO6IDP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLdO6IDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A638C116C6;
	Mon, 26 Jan 2026 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455498;
	bh=EHENzNVQYoEkrsZOJYba954H0Z36EQpT8zSFFfpaLyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KLdO6IDP0oCuZO0AdVA1OWWkWuMEA5YkZNzV1gHf54vY4Pi1hX62S8MC4C5ujnUEX
	 C3Ml5JvJ2EqqAnZim//Z8R1xzSXggaiEMS/esbJDROoYHwCwD/TAVbXjxGoei9kfVs
	 RzaH62Ayj7mAQzRxtlXHc53VNemeUD7gofIpJwj+UKLgpaZQR42r3zIPQN30vUO7H7
	 E4eS1MG7yuwq3OG39VRpxym/kPfFrlG0xmfp6AjaLj1OmcwOyT9rtPnhlbgBS3n7lQ
	 5LbG0cgSAVND4vtPd6Kc/Lg7ILD1Zwv3GJxGmYbifE+rc3FtGFljc+o98jCvZ0t6KI
	 XXLr6yHEQWnyA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:48 +0100
Subject: [PATCH mptcp-net v2 11/11] selftests: mptcp: connect cleanup TFO
 setup
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-11-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EHENzNVQYoEkrsZOJYba954H0Z36EQpT8zSFFfpaLyY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL99e/Vr2ycF/a67lBqRVP9s4XdWfc3lgpGeuykVlSd
 q7mHUOujlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl8FmNkeJVQsF75y+ZuDrnT
 zcmKplNqfM/43wuIKizY/f/aoohDxowME32y1hXtucM/UVP0esSsND3ldCazyY+fp/GyR12aZqP
 KAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To the TFO, only the file descriptor is needed, the family is not.

Also, the error can be handled the same way when 'sendto()' or
'connect()' are used. Only the printed error message is different.

This avoids a bit of confusions.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 554886f23d6a..ff1a298d3469 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -259,7 +259,7 @@ static void set_transparent(int fd, int pf)
 	}
 }
 
-static void set_mptfo(int fd, int pf)
+static void set_mptfo(int fd)
 {
 	int qlen = 25;
 
@@ -336,7 +336,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 			set_transparent(sock, pf);
 
 		if (cfg_sockopt_types.mptfo)
-			set_mptfo(sock, pf);
+			set_mptfo(sock);
 
 		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
@@ -407,21 +407,18 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 				*peer = a;
 				break; /* success */
 			}
+			perror("sendto()");
 		} else {
 			if (connect(sock, a->ai_addr, a->ai_addrlen) == 0) {
 				*peer = a;
 				break; /* success */
 			}
-		}
-		if (cfg_sockopt_types.mptfo) {
-			perror("sendto()");
-			close(sock);
-			sock = -1;
-		} else {
 			perror("connect()");
-			close(sock);
-			sock = -1;
 		}
+
+		/* error */
+		close(sock);
+		sock = -1;
 	}
 
 	freeaddrinfo(addr);

-- 
2.51.0

