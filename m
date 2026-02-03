Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478D36EABB;
	Tue,  3 Feb 2026 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144182; cv=none; b=HgRP6iXnCjhwQLa/EJ6mlQi4L362j04BxpYIn+j+wEqsAYQlMwO3DOlL5PZZ/awCX0GDmp2SnAO5G1aBVlaHbv+fZRv2x7ExArUm7FPGqQpw3kQOJ2Pd1ExCgDtVuwlS0tz9KCcgP4j9eBUVucWhA2nEdkz3U3cA784vJAr/1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144182; c=relaxed/simple;
	bh=rkXfTFe2koUjdJzYyG93f1C4RAVaMv0fx5lunmXeuoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4G7BPZn014XI409K1VmBQzHBbmLRVQJ2xFQwuJSs4rbC78MvjKKmfBqfvHKAsHdbaHj4PQhi7w0nyKpVZG5vAinF3QVZjQcxurLrP8RcYKctJ9pLuY1K/pTSpRs5VNj/4I+6jY8uwPpo4PrR2H1eo/Rpvw+Te/enNuHLWrrxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttQhO+r/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttQhO+r/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DBBC116D0;
	Tue,  3 Feb 2026 18:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144182;
	bh=rkXfTFe2koUjdJzYyG93f1C4RAVaMv0fx5lunmXeuoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ttQhO+r/KfAYi8Gr0rSkSLOCIlkGhF6/IygmJacBjvxxC9Uk4D0s9Wi5zFmstl1Gp
	 IdfI+BstQiI7C3J7HX9mbrr5DpwOPYcjDeoOHcCBuAfP+CDrOfq28bgFk3CeQd6moe
	 6aQc+HDteKjcCo/+tMtZedepm207s+VGv1JliYRz6xKf2Gp9sxu7ngYg4++I72QcQM
	 ByjO9zM8L0LRyCbKX6XPNxEn/N1HDhS8jB8Wdbq+j6MulPFSkVP7F9S/Fddcrw2oIA
	 puitMlDLkbftHOaEaP18T6kZFxWlBRgR+6OYFCeSTl5yUFDPw9vFICyjynBGRcA1M0
	 lCHD2PYizs14w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:30 +0100
Subject: [PATCH net-next 14/15] selftests: mptcp: connect cleanup TFO setup
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-14-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rkXfTFe2koUjdJzYyG93f1C4RAVaMv0fx5lunmXeuoY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHPsjj89f6f5HVPXtNY+FT1O2ar1ZW5+Xn1zQM3eTs
 ekd/v6zHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPJSWP4K7LixubFTM6tXo8l
 nldIF66xOTizKUZPoE05S2dlaA4jOyND+6WemNMXtkZw/OBexuJe9StbvnxlykTHfAaN0kKVo81
 cAA==
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
index a74b13e42ecd..1e87757a6894 100644
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

