Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16892D238F
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983407; cv=none; b=cyPdzBXfY4yMahOgHaPRVHK+W+OGK8wPb0QLAKwlfzzpK2gMH/GctAyQRwqeEVlc0CQEBoI+f7DN+ovmrocKbuepy2QOX9rensyILo1Eo7WxRlOlVz5XNNLk9u2sTCjeutd6iWcnYzJmVZ6dN0AW6VsO0uhhwsOsZVmocrT/Sv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983407; c=relaxed/simple;
	bh=lHwUe98UEAQkXCocp2zBez4eR+De00BE1EqjUXVpkNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnVrisjVRclgm4pvV3iJ1sxNHIniPPvxucTAtbxiAABbuN3yAYP/Irksne8XGxS2oCSaCvV1XZxJghDu8pnuAhHiAoI0S5r36nmUfj7ZW8RkcADTLWcILIziipkcSnbkdBxlqYhiICM3LZXQTvwIe8aNSoEtYEUjmFXohNCAD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRmUJDLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRmUJDLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34A61F000E9;
	Sat, 25 Jul 2026 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983405;
	bh=dvsT4AyOBA1/1nKE55Kd9SPf+h57b0QhDwN0O8muciw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRmUJDLqjpnJSpLg+LMyX7HGPgwtV10K4LkdMcKxeDBrYayJeSzwVyU8Wj+mAO8ni
	 ijmfyWZmlIvPIfWxmV57whCXagdwTuRyXrueLcI84LDOugvwid5NPWc5p+QJZsjBrr
	 Uy216UgQeUyvoXwPWagEM6laiA+rraXRVrNbl47k/iNkIDzGeP+/4+7uMNhOJpRQ6J
	 pmAayVDHdn76fsCYhLdFdy7i5DXB8u34wiLtKMK8bNwJ0m9n1oLKO8tP8eP/6FgVAg
	 KQf4J5OQK48S/TTc4ua/PEqVqp25+Mqg4QSoyxghx72OTM5uzsMBF9CAOq3rvHqTmM
	 0GC+R5L+gglTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 09/12] selftests: mptcp: sockopt: use recvmsg instead of read
Date: Sat, 25 Jul 2026 20:42:30 +0800
Message-ID: <e03c1c21a97331cf2a3cb0e2d34c6c9c375dbf3c.1784981974.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784981974.git.tanggeliang@kylinos.cn>
References: <cover.1784981974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace read() with recvmsg() in process_one_client() to enable control
message (CMSG) handling. The original read(fd, buf, sizeof(buf)) is split
into two recvmsg() calls: the first reads exactly one byte, and the second
reads the remaining bytes. This allows the code to access CMSG data for
each received segment, facilitating the upcoming TCP_INQ validation.

Introduce inq_msg_init() and inq_msg_reset() helpers to manage the
struct inq_msg control buffer and iovec, enabling reuse of the same
msghdr across multiple recvmsg() calls with different payload buffers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 48 +++++++++++++++++--
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index d79f3d069112..cee6992445ff 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -689,36 +689,74 @@ static void check_stat_equal(const char *name, uint64_t actual,
 	       name, actual, expected, (int64_t)(actual - expected));
 }
 
+struct inq_msg {
+	char buf[4096];
+	union {
+		struct cmsghdr cmsg;
+		char msg_buf[4096];
+	} control;
+	struct iovec iov;
+	struct msghdr hdr;
+};
+
+static void inq_msg_init(struct inq_msg *m, size_t iov_len)
+{
+	memset(m, 0, sizeof(*m));
+	m->iov.iov_base = m->buf;
+	m->iov.iov_len = iov_len;
+	m->hdr.msg_iov = &m->iov;
+	m->hdr.msg_iovlen = 1;
+	m->hdr.msg_control = m->control.msg_buf;
+	m->hdr.msg_controllen = sizeof(m->control.msg_buf);
+}
+
+static void inq_msg_reset(struct inq_msg *m, size_t iov_len, void *base)
+{
+	m->iov.iov_base = base;
+	m->iov.iov_len = iov_len;
+	m->hdr.msg_controllen = sizeof(m->control.msg_buf);
+}
+
 static void process_one_client(int fd, int unixfd)
 {
 	struct so_state s;
-	char buf[4096];
+	struct inq_msg m;
 	ssize_t ret;
 	size_t r, w;
 
+	inq_msg_init(&m, 1);
+
 	memset(&s, 0, sizeof(s));
 	do_getsockopts(&s, fd, 0, 0);
 
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
-	ret = read(fd, buf, sizeof(buf));
+	/* read one byte */
+	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret < 0)
-		die_perror("read");
+		die_perror("recvmsg");
 	r = ret;
 
+	inq_msg_reset(&m, sizeof(m.buf) - 1, m.buf + 1);
+	ret = recvmsg(fd, &m.hdr, 0);
+	if (ret < 0)
+		die_perror("recvmsg");
+	r += ret;
+
 	assert(s.mptcpi_rcv_delta <= (uint64_t)r);
 
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta == (uint64_t)r);
 
-	ret = write(fd, buf, r);
+	ret = write(fd, m.buf, r);
 	if (ret < 0)
 		die_perror("write");
 	w = ret;
 
 	/* wait for hangup */
-	ret = read(fd, buf, 1);
+	inq_msg_reset(&m, 1, m.buf);
+	ret = recvmsg(fd, &m.hdr, 0);
 	if (ret != 0)
 		xerror("expected EOF, got %zd", ret);
 	r += ret;
-- 
2.53.0

