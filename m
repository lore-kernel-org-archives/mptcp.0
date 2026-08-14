Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376853624D3
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746534; cv=none; b=EsDRwsizhtjS0LHkxezXoJZFGU65gOqY9UH67duV6q6mjzgV3yboFSZ/CsEGmYWJQhEJFQTBZlxCxHITH0luHtxQvB8MxwJfAjPeOHj+mwpMO/nD57K5TyIvj+rRrDzhGsGQBmACeemF6LmHjxsJT0/YthQl6rCFPW9EwCmAG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746534; c=relaxed/simple;
	bh=5iHRJnGlVAtMQB4Y1+ODVQcpfdQ6sF0erYkqKkIVtY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YPHcxJvqpUauuLRJ0BrV+awe0ICcbv/4S2bydgGshwn2FrdBusGk8iXIus8iocPaBL+16vxf8BjWx4GQ3p7j9wRYSddy0uD/hQeSszUkXQ4U3++CgZW5CraKE2m7hu/imd4yELqAcRS4gqnnuEwpehqrWZwgUHizoeK2b0ZN3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtBdrW3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtBdrW3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535C61F000E9;
	Fri, 14 Aug 2026 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746532;
	bh=wOlVjlFfwJEniF+byrodibMbjmc+BDBGyK+RfHffVz4=;
	h=From:Date:Subject:To:Cc;
	b=EtBdrW3eWJqPINn0/KwwmuZDb6e4+uRwiGvrgpKTQwugWsbn4FQ44NvHxQ2WyPRH2
	 0Ug173n62Y62NpoOM7H30osqCDAw+77SYQMKF8V60Qt6IoXbSJKUV7cC4o5Zg9rrdb
	 bWGXQfnFZ17DP4aK7YtgkLmDw0liNZ+cEdudHE3Rlq19WvkkTwXskgB/oWB5XbDlJL
	 rzjXfEMYoevkS20o9LD9IWO2MeLwNFwK0LF2CJ2sgkwdvEQREdcNmePRTJ3Rj0/2yP
	 j/+LmrnydmWEB0TgSBC9mwBAFC9s+c2j0DeEP8B0ZjFXGXkMgEM+6VlqeL3tCFNLVA
	 jy0zw+lgMaK4Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 15 Aug 2026 00:28:48 +0200
Subject: [PATCH mptcp-next v3] selftests: mptcp: print stats before socket
 closure
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-sft-mptcp-stats-b4-close-v3-1-ccd9af14cf73@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oyw6CMBBFf4V07Rha3q78D+OihUGqWEinNhjCv
 wtl5UqXN3fOuTMzQquR2CmamUWvSQ9mDckhYnUnzQ1BN2tmIhZ5XPIUqHXwHF09AjnpCFQKdT8
 QgoirPG3bXOZKshUfLbZ6CuoL2wmDk2PXvaOXumPtNvd23Wlyg32HPzwPzO9Jz4GDqNJMZhVXW
 OD5gdZgfxzsLex48a9JrCZVyFKqpGkkll+mZVk+HJGx9SkBAAA=
X-Change-ID: 20260814-sft-mptcp-stats-b4-close-20964ff6a6ba
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2633; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5iHRJnGlVAtMQB4Y1+ODVQcpfdQ6sF0erYkqKkIVtY4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLqpy223/N4Rcyt5XqCj5paAgpv311p18C198D7lO2MR
 ZxHpx7g7ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIbA6Gv5Ja2QcjXx5OFYqK
 mvs7J+T3h8TSIxxBqq3bTXrjVHfkvmNkeGo94RPrwjCTRykCXwqVzpYZnLmQvOQMryuX4pvHa7r
 OcwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of poll timeout, it might be too late to print the stats after
the socket closure.

Now, in case of poll timeout, 'ss' and 'nstat' are invoked from
mptcp_connect to print the stats before exiting. This should help
debugging poll timeout issues.

Note: for this "workaround", system() is used for debugging purposes
only. The returned result can then be safely ignored, hence the (void)!
to avoid unused-result warnings.

Also, 'nstat *Tcp*' will print '#kernel' at the top, but that's OK, and
it seems better to avoid using a pipe here.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- use double quotes instead of single ones (Sashiko)
- Link to v2: https://patch.msgid.link/20260814-sft-mptcp-stats-b4-close-v2-1-b7a8ab3ddae8@kernel.org

Changes in v2:
- use 'ip netns identify' to avoid a warning from AI reviews
- use 'nstat -s *Tcp*' instead of using grep
- add a note about (void)!
- Link to v1: https://patch.msgid.link/20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..d6c2237bdba0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -210,6 +210,19 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
+static void print_err_stats(void)
+{
+	char cmd[128];
+
+	snprintf(cmd, sizeof(cmd), "ss -Menitam -o '%cport = :%s' >&2",
+		 listen_mode ? 's' : 'd', cfg_port);
+
+	fprintf(stderr, "socket stats before socket closure:\n");
+	(void)!system(cmd);
+	(void)!system("NSTAT_HISTORY=\"/tmp/$(ip netns identify).nstat\" "
+		      "nstat -s '*Tcp*' >&2");
+}
+
 static void set_rcvbuf(int fd, unsigned int size)
 {
 	int err;
@@ -656,6 +669,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 			fprintf(stderr, "%s: poll timed out (events: "
 				"POLLIN %u, POLLOUT %u)\n", __func__,
 				fds.events & POLLIN, fds.events & POLLOUT);
+			print_err_stats();
 			return 2;
 		}
 
@@ -1194,6 +1208,7 @@ int main_loop_s(int listensock)
 		return 1;
 	case 0:
 		fprintf(stderr, "%s: timed out\n", __func__);
+		print_err_stats();
 		close(listensock);
 		return 2;
 	}

---
base-commit: d536472a82d18356d323227213acb5603bb9050c
change-id: 20260814-sft-mptcp-stats-b4-close-20964ff6a6ba

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

