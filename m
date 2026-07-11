Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AB26ED59
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741479; cv=none; b=kQKhfaB0aryb6c8h/ULFTCsuxPNz6LDLLckcoZAdzwKGEHwJU4lJH4Ut8FBMr9HJkjzWRd6S4+0H1RrtFSGGcM3BpTSXPBej1dA1PsDVni/JwY7eAWkg4sjooi6hOmcm6JzR3C7/95DGW/3878k3WHTnhHYFBgh80ooUkb7av7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741479; c=relaxed/simple;
	bh=LiajPK8MZIldVLyvEXRV738yvvLYz1fsaX7CtprqIjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOcpFCqGhxwBCc9yKFyX25+YKjBKkkoZxIvm3ifrny4dP+kLHE/FrvGBscBmqvaCcRSRhH/I/LzcDLuhgQ+ZN7CRodyvhbkNWkSmQCs53kB/quJ6a+OQa0LQyEtblUt4fIUa8/jNmsZajcbxtun7q2QXSbTw6S81XDvjUYcWGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/eVrCg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/eVrCg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2191F00A3A;
	Sat, 11 Jul 2026 03:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741478;
	bh=D4EjOjNTL56tA/2M17Ksd4eNhPTrpq3KnBTcDkHC+ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/eVrCg5T1DWTLcjmggCs/RctuX44kkr0wfPntKc13//Jh1H38DjHHiCgEFWkSToB
	 VIgnwmTw+TelLq210mnm3JAvPGqOz6P3BTlYQEstg0I/DHoR8c24uH+DV4z7eutc50
	 Y383Z26ni4iiZWQu+AsMEFM51qAmga/U05XACq86NMJUAnB1vpnNVmiGzZBGdVaaut
	 koUDBE/zRDyYteTpzuaTh0nh/whppSJ/buZYy9zLPAgha8OCVbthOAkOmAPOsYWYCz
	 dZKRjwlB9EDjcU4kSky7yjqkzWUsqOHM3ISqFaI55sBfcF4+L09rNsB5yJ74tX4zkr
	 6Dk7QULvWUo5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 07/14] selftests: mptcp: sockopt: read exact payload length
Date: Sat, 11 Jul 2026 11:43:35 +0800
Message-ID: <6f4f49cda462f116478be3a8153d7f0ad5222b9f.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
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
index 28dc825b9d48..96259f81240a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -637,7 +637,7 @@ static void connect_one_server(int fd, int unixfd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
-- 
2.53.0

