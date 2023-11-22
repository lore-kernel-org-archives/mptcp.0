Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC824B35
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="IUQuzQKV";
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="FA4k+jIi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=WZVxmSnphZL7ww7ZQB2dA6o4STdrUULT5KooXvVerwE=;
	t=1700671562;x=1700761562; 
	b=IUQuzQKVrHLe/bC1AZ/W3kzlCp/T7uUlzkaZmZuHOt7xS4kO0sYfymLsa218Un4UyDAX0sjpsoHoKJUSuLt6alna6cCAi+3ZLP28OY/E8fQtumVV5LTYq2jmlUbFxuQkMnwjFM90i/zV3Juz2s9i3GVygvpKfN5ZGBhlvaIU9yE9U3Se1yrI1o3JEryI8pIa5ajtcm26tMretO94wK1wgVp109LIG1SmzXf/Des7XtACgjsyPT3iZ9IvYhshRl6iJgH8UVN+gIojKgrHOz7LEERs+5PF3sZGXGJS+x8Kk7J7ULyLn3+5hWaKhunr7wbwkwVVv361jDexSzvkrPJ3Hw==;
Received: from [10.161.55.49] (port=42568 helo=smtpng1.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1r5pdj-00DDlZ-Vo
	for mptcp@lists.linux.dev; Wed, 22 Nov 2023 18:59:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=WZVxmSnphZL7ww7ZQB2dA6o4STdrUULT5KooXvVerwE=;
	t=1700668787;x=1700758787; 
	b=FA4k+jIiX8PvFi7tF1YTM2hYivNMTbRX1rHKaGkI7IrIwr/KRkg4OhZy36TQdoJbSaTJirq5ydtS+dUOUsAxyiX7i69oOSrmpLP27thZQSvr70Sb+zFUgCxqRVCXF2TsTQWCsJj4rNY+mbZbw1ascF5E9Rk+3MLtFtS1FLDWK40t4CyxiRmMx479317DUEeN18ikHkdMSFDHjLJM30zLvCyarYJxx+yIwS8cDTWrRfaF17IHNkUvjdoN9SKvEisr56yY8fdviAOOrcEDTif0/IO1oOggfnxnVQjBsy0SZIiJIhvliD/sSPq+fAjSXzufunPiedI538cUvZihzNtHPw==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <max@internet.ru>)
	id 1r5pdb-0002rH-AS; Wed, 22 Nov 2023 18:59:39 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Maxim Galaganov <max@internet.ru>
Subject: [PATCH mptcp-next 1/2] mptcp: sockopt: support IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
Date: Wed, 22 Nov 2023 18:59:18 +0300
Message-ID: <20231122155919.11393-2-max@internet.ru>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122155919.11393-1-max@internet.ru>
References: <20231122155919.11393-1-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD92D71B79D2A671AE628886E7395E1296DC5DACA20BBF2B5A3182A05F538085040B232A35C8B7F6FD1DA94D4C9D048B98ABAB66114F7F7E66E3546CD1220D9C1CD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BC08626EA5717D14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375ABF1810CDE7D0E9EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD871EBE1075EB72B537FF69238ADB5765E3020879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FA18204E546F3947C457EE4B4996FC546F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006377C8EE06721B8D324389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FCF80095D1E57F4578E2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B895CADBD5EF1EE27EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A553BB7EF17E3C77E2E22301315A8F93B283421B4DFC4D7E64F87CCE6106E1FC07E67D4AC08A07B9B0B4B51A2BAB7FBE05C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF2C4AEB66E1145BBB05C249C5EBC5688575DC392129CC249109901A050F223CBFBA297A5F7262141F88AD3775A6B0C834C65EA8E46CD9AE616D40FEDE263B69BB40B08DDBC5CE87D002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojGZhPsaRkbblSTS3KUsd8Pg==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE334D974532C77D78A04506EB52D28E360FE94AC9D29F4E5226FD262907200E8C52FB559BB5D741EB96C728B2FC74FAA16AD7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4C412E14AEF4742E1D915F33BAFA678CC5A0CB2ECDC47A2F3049FFFDB7839CE9E432D8BDF4FB0405F438198C2DD497370733732B143699E45BC136391F456C3FB
X-7FA49CB5: 0D63561A33F958A513372EFACD8ECAF76525AA74018445F6EF6F2C7944D113D5CACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdjNtV51DQSTBn4UV4nD80eQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Support for IP_BIND_ADDRESS_NO_PORT sockopt was introduced in
90c337da1524 ("inet: add IP_BIND_ADDRESS_NO_PORT to overcome bind(0)
limitations"). Recently ca571e2eb7eb ("inet: move
inet->bind_address_no_port to inet->inet_flags") allowed its value to be
accessed without locking the socket.

Support for (newer) IP_LOCAL_PORT_RANGE sockopt was introduced in
91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option"). In the
same series a selftest was added in ae5439658cce ("selftests/net: Cover
the IP_LOCAL_PORT_RANGE socket option"). This selftest also covers the
IP_BIND_ADDRESS_NO_PORT sockopt.

This patch enables getsockopt()/setsockopt() on MPTCP sockets for these
socket options, syncing set values to subflows in sync_socket_options().
Ephemeral port range is synced to subflows, enabling NAT usecase
described in 91d0b78c5177.

Signed-off-by: Maxim Galaganov <max@internet.ru>
---
 net/mptcp/sockopt.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cabe856b2a45..53f27354412f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -440,6 +440,8 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* should work fine */
 		case IP_FREEBIND:
 		case IP_TRANSPARENT:
+		case IP_BIND_ADDRESS_NO_PORT:
+		case IP_LOCAL_PORT_RANGE:
 
 		/* the following are control cmsg related */
 		case IP_PKTINFO:
@@ -455,7 +457,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* common stuff that need some love */
 		case IP_TOS:
 		case IP_TTL:
-		case IP_BIND_ADDRESS_NO_PORT:
 		case IP_MTU_DISCOVER:
 		case IP_RECVERR:
 
@@ -688,6 +689,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sock *ssk;
+	bool slow;
 	int err;
 
 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
@@ -710,6 +712,16 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 		inet_assign_bit(TRANSPARENT, ssk,
 				inet_test_bit(TRANSPARENT, sk));
 		break;
+	case IP_BIND_ADDRESS_NO_PORT:
+		inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
+				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+		break;
+	case IP_LOCAL_PORT_RANGE:
+		slow = lock_sock_fast(ssk);
+		inet_sk(ssk)->local_port_range.lo = inet_sk(sk)->local_port_range.lo;
+		inet_sk(ssk)->local_port_range.hi = inet_sk(sk)->local_port_range.hi;
+		unlock_sock_fast(ssk, slow);
+		break;
 	default:
 		release_sock(sk);
 		WARN_ON_ONCE(1);
@@ -755,6 +767,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_FREEBIND:
 	case IP_TRANSPARENT:
+	case IP_BIND_ADDRESS_NO_PORT:
+	case IP_LOCAL_PORT_RANGE:
 		return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
@@ -1346,10 +1360,20 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (void *)msk;
+	bool slow;
+	int val;
 
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
+	case IP_BIND_ADDRESS_NO_PORT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	case IP_LOCAL_PORT_RANGE:
+		slow = lock_sock_fast(sk);
+		val = inet_sk(sk)->local_port_range.hi << 16 | inet_sk(sk)->local_port_range.lo;
+		unlock_sock_fast(sk, slow);
+		return mptcp_put_int_option(msk, optval, optlen, val);
 	}
 
 	return -EOPNOTSUPP;
@@ -1450,6 +1474,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
+	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	inet_sk(ssk)->local_port_range.lo = inet_sk(sk)->local_port_range.lo;
+	inet_sk(ssk)->local_port_range.hi = inet_sk(sk)->local_port_range.hi;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.42.0

