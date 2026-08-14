Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C88433936B
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732470; cv=none; b=SgiVZTRw8Oxv4lFfNiL5qxIhOu8Tx/pgaOkdD2zRR2Wm3oNZP7zNoFato+2uzcUkqyyPhznakcu6UrzZ57woSJCo3S+7FwQ0q/CZkj/6WZNHTOYs9wGnCRKFtoTJH5iCKSc4+oBlh3E85Yvofl+K5v2XwAE0W8l7kqAAUFZ4VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732470; c=relaxed/simple;
	bh=s3O3a+jmWAQBOqUz7xBWv5Y8nA+E5zWe9rFwehGnzyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H71jNoGeO+B3UcwKobczv91Mjq19t0SvuZbgqLd01EZWcycpNVUXZSWP1IsgWC/3Qxui8JQrTLqT8PBrmbbEBDXv5W3VpregUvzsdSaEHub6/xXHpPDsFGAPkHRHiaTuXgWZMNRoBMsg80QJe4iKHv8aMIISa28XK1lJGVGagw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBb40mrT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBb40mrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D8B1F000E9;
	Fri, 14 Aug 2026 18:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732469;
	bh=BR98HkGv1v8FozMqHE8MA5gAFzNhShfGhe4qcLDoPlI=;
	h=From:Date:Subject:To:Cc;
	b=DBb40mrTroV6QVDQIbNmZuJETpmzLA58471BW0BX+V9Z1+jeK7LlsAWv/N4c6+dfi
	 i8OGXckU21yoDVbbaEoWGNuuk6Wy3YUpD67mp+h5Q9P6yWrUPF15vKF6nzyQjmh9NM
	 /Yg87VDF/l7QV47TJ+Sk2KHwxnvNRbIUZ4MyCn6wEgw0n5/ABM3Cs6uXRZkoV0ksVU
	 XOtQqu/vLkx4zJuxn9dV/B17t9WhY0xoxKYUMsD9bc+wmPjLcEvgBM+IPt1m9EOrRL
	 H6IDn8etx4NKHvjKz1DSFcgeovCIT1vkGJ5PVI2RSVR0yT1a+rjMsdNYimQ7mBrxNu
	 5crl0FXkiUgwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Aug 2026 20:34:00 +0200
Subject: [PATCH mptcp-next v2] selftests: mptcp: print stats before socket
 closure
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-sft-mptcp-stats-b4-close-v2-1-b7a8ab3ddae8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6CMBREr0L+2m9oA1VceQ/Doq2/UEVK+ivBE
 O4u4AFcTmbezMzAFD0xXLIZIo2efehXIQ8Z2Fb3DaG/rxpkLlV+FgWyS/gakh2Qk06MpkDbBSa
 UeaUK55RWRsOKD5Gcn/bqG/yInqYE9c/jt3mQTVv3lm49pxA/+49R7Mz/yVGgQFkVpS4rYehE1
 yfFnrpjiA3Uy7J8AVgYiCbfAAAA
X-Change-ID: 20260814-sft-mptcp-stats-b4-close-20964ff6a6ba
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=s3O3a+jmWAQBOqUz7xBWv5Y8nA+E5zWe9rFwehGnzyg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLq47fo33qtxPV7n51ShLPsSX1uDo9gGfcmwT252Z25z
 g9236zrKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMjU2Qx/Rc+cPs0Z0vH4K8tj
 i7t6ok/cHfSlEzg9uXJ6nIUe24r8Y2Q4u4c1/siSsDXvnvznFgr898yX5w2jOdO6wPW3nP6v7/f
 kBAA=
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
Changes in v2:
- use 'ip netns identify' to avoid a warning from AI reviews
- use 'nstat -s *Tcp*' instead of using grep
- add a note about (void)!
- Link to v1: https://patch.msgid.link/20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..e906abcd5409 100644
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
+	(void)!system("NSTAT_HISTORY='/tmp/$(ip netns identify).nstat' "
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

