Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583C3B47C4
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716436; cv=none; b=M3UTss13cPSkTcYAKZjGd0/Wql/Wfzore4PG1nXCfuDH4M6ERrm2qYAcHDqn+B8ZBR4C8vqddWcXfjdAxAclXz3Hsc760jfQA8lzX5bibcaAkTZUs+mABoYWC9owiBRFTbaNrefVxAAC4jp4tFvtQlR0OnW6p64F4av2LdWTydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716436; c=relaxed/simple;
	bh=toCecSLF2ZADhnkOslIogcVk7OM7pfRteqYvOyF7qQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jTLQZ63QE73UL4raDaq3TQxlP0ow6mz6tckE0uIcRNAtbRnCz+NRZue4QSeh+PHgZtyc2rm4UJJ2U3TfrGiFDIIojrq8tkYwoeMAof4liQmZq6P+UulaUsGYEX3j6YbiOC1HXK2DivKMoJWVrtuK214mz8IXwGnRO+GLKBJBVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b//usPs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b//usPs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B9C1F000E9;
	Fri, 14 Aug 2026 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716432;
	bh=rIqrCstTL+7fUpSGuFyT5UZQnqlQVv8XWBTnNrtY0zs=;
	h=From:Date:Subject:To:Cc;
	b=b//usPs7hyNfZb6pBEIja4uz03zr2KB36PA5oJS28keViPdH3Giff7lFvRENfhBZK
	 I2KmT5SjNeX7mfVaayM34MtINN4gsNPFt+xOHVft5vor/BOdMOKUrkIuZxKELG2Rkj
	 wWxYzEeyERXfDpUZzBpcdM5qolD5CJJzBAXqAlt7u8vj73fRypSc0F/mRHlRtLZ0e5
	 UYOFeiQAASZLo/Vh1A3bUX79XycDlNWUOVWDVl5cZBwkQQrUCr2lSjLf5h4qMCU6Hh
	 URvulooFu5wcgmQe+EaSYeOp4wEHuofHzx38hnkAFymGRDfGiFosKUVbwHQdF/rEG+
	 hbp5CExndIQSA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Aug 2026 16:07:01 +0200
Subject: [PATCH mptcp-next] selftests: mptcp: print stats before socket
 closure
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L27EIaQlC/Ih6SuNEVTUN2K4XSv
 xvtcRhmVhBqTALnYYVGHxaeSofxMEB6hHIn5FtnsMZ6cxwdSlZ8V00VRYMKRofpNQmhNSfvcvb
 BxwA9r40yL//1Bfai0KJw3Z3M8UlJf2/Yti8XkfvbiAAAAA==
X-Change-ID: 20260814-sft-mptcp-stats-b4-close-20964ff6a6ba
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=toCecSLF2ZADhnkOslIogcVk7OM7pfRteqYvOyF7qQ8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLqFfkv3L1y5tmm6+eOs1uyalxn2iPeuD4+oJD1sJnyh
 b1nTdyZO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYyMZrhn63xsvlcgWZ5m10W
 piowOTdNL52wSZh3x+pnrNfTTv1ZlsnwPyP4vrzWjfaypy+23VywLO1HxRMTwa9tpZaXOh3aKwX
 WswMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of poll timeout, it might be too late to print the stats after
the socket closure.

Now, in case of poll timeout, 'ss' and 'nstat' are invoked from
mptcp_connect to print the stats before exiting. This should help
debugging poll timeout issues.

Note: for this "workaround", system() is used for debugging purposes
only. The returned result can then be safely ignored.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..842c0eb99aa9 100644
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
+	(void)!system("NSTAT_HISTORY='/tmp/$(ip netns id).nstat' nstat -s | "
+		      "grep Tcp >&2");
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

