Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965035;
	b=S/FKZKhf2Mmy/VjEcl4VJf0+yPYSO/AYKEka9ymTjpZu7P8T1k1K7gqLPwOea5Fd4yM1
	 SdUm8HEDS8GqrHPXQxzrjRQCQAK3ZjoTeNNDT33hQScSdDG1nCNRu+Uqbkn33SJLhwi5X
	 Io3K1fMWCIjh3La8nU4Avj4i0yKld4Ra3+xgYHNyGRY8eg2StyEtjQKd2DeNzoQav2hJx
	 xpzVyr8huLtEzbvPInlksCl3uIQJIorUm70yiOeIWsvHvhc5uBmX2G2T9z/eG0Rj/zWK+
	 ZxomAJdO1927/0iTAAhDDv3xVuXOwc6gg2HbVGNomxWGX0XhQww1aT6C5/1lpJnm2Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6K3VF7qe7xqCuJ7XT+tgtmwumtm+zZmrEQTMAoysf3M=;
	b=LJwp32Dsq8PAdzIoWmstqBdc0sKXPDDw0MFyaRoL/wwTx/dtYOZz+ePe4UOQI0auBe4c
	 3I0MEdccAEX3BVsDqenQ31P0e7QIhWH69ExTrc3445oX7UctAM9seAjjIazXKv0Ojwtbo
	 J4VQuyYO5EKVZ2riotDhmXqCfCbvkrQWlnMgSyZ1IZz9y8Fn2KALTZJkoXrOcqCh2ZpFA
	 Jn/2SiFkMIrGA9ZkiuQOKUEEZKghBnAZk+A3MkrBEAYzJlLktAzLpdbss5D0voIR3DNFI
	 aeDB0Ah85rXVoat1kXvCzcqhBdoC0pyRKgYuadyNsYnd1MlNcHvcBiycoKGnSegsrXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv1M0yp9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1F606C6F4
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv1M0yp9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBB31F008BE;
	Fri,  6 Nov 2026 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965034;
	bh=6K3VF7qe7xqCuJ7XT+tgtmwumtm+zZmrEQTMAoysf3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lv1M0yp92wjg1PMym4/gYDsugCm9ofsMVbwAkRSXNHmf7e+3/HzDXgHVqJpu0CRKa
	 9cOkSsZLMrw9zBxfruy5WD2XcdKBlMTDsd8NtdGwb464ylQbKiS4pjlVh2JtMq/1qY
	 MAjcblSXcUpJHnl+SL+lx04Op7afOnAbHBG3VP8LvKxUJ43LpolO2vtkOMSLQUDQN2
	 c/k1joGDzardQEWiRJSZ7I5PYj83SiZ3/Q+Kt81ZK5HH7lKf+eBvq4sfVir0AJtU52
	 MNcDvsXgPA6NjNR9t4sEJQe3RE0OL6kJy+GbJR/DElypGwwUgF1I8iU+8qRasBe1/u
	 9PQbjeUjmBx8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v22 2/8] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Fri,  6 Nov 2026 19:36:58 +0800
Message-ID: <db502fd327a473221aef9a5bf2995cf627ec187f.1793964796.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793964796.git.tanggeliang@kylinos.cn>
References: <cover.1793964796.git.tanggeliang@kylinos.cn>
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

Add a SIOCINQ check in mptcp_connect's server mode when the MPTFO socket
option is enabled to detect TFO SIOCINQ overflow regressions.

When a TFO connection is accepted, the test polls MPTCP_INFO until the
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED flag is set (with 100ms timeout),
ensuring the third ACK has been processed. It then checks if SIOCINQ
returns INT_MAX, which would indicate the regression where mptcp_inq_hint()
incorrectly returns INT_MAX for passive TFO connections.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..41eff818e950 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -34,6 +34,7 @@
 #include <linux/time_types.h>
 #include <linux/sockios.h>
 #include <linux/compiler.h>
+#include <linux/mptcp.h>
 
 extern int optind;
 
@@ -1176,6 +1177,24 @@ static void maybe_close(int fd)
 		close(fd);
 }
 
+static bool wait_for_remote_key(int fd)
+{
+	struct mptcp_info info;
+	int retries = 10;
+	socklen_t olen;
+
+	while (retries > 0) {
+		olen = sizeof(info);
+		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0)
+			return false;
+		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
+			return true;
+		usleep(10000);
+		retries--;
+	}
+	return false;
+}
+
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
@@ -1207,6 +1226,24 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int avail;
+
+			if (!wait_for_remote_key(remotesock)) {
+				fprintf(stderr,
+					"TFO: timeout waiting for third ACK\n");
+				close(remotesock);
+				return 1;
+			}
+
+			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
+			    avail == INT_MAX) {
+				fprintf(stderr, "TFO SIOCINQ overflow\n");
+				close(remotesock);
+				return 1;
+			}
+		}
+
 		if (cfg_input) {
 			fd = open(cfg_input, O_RDONLY);
 			if (fd < 0)
-- 
2.55.0

