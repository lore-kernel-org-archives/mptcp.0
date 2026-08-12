Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBDC470E81;
	Wed, 12 Aug 2026 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546598; cv=none; b=tfpKa2HGb6V83QQtNTKTLmMCi7umEY0tkb3EC0HG5mGtJq9OUlqBtgWqh0NhfJaeZQW7oZM/wamJkeK1slBCsS36kutV5em6i9RVPlnaoOtiFaFadHqj619cGJSRlGBUDoAjk40sSS8I6f6px5AFxMSww1fjxaJ73ib+Wndwyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546598; c=relaxed/simple;
	bh=/++cNIwC7scRn8UAnBZ/X3QB/AugdSo4EyuJlLOOXrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUoNrW4jvUxTUlevQ4ZhBjttJVdLtVCLhqbtVOgyPPhIrgHFo78u2BNQuo4o36Ja1/IKqQIpKBpX39VrpH97/jktW76uI2gE3vLIkUOSE9Le/rbQL0ygK22GzW5QF0SJXAVIVdt2oOrsI4xjphDM9JcXhTOOeC/g7wH8WPi13y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV6KIz5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV6KIz5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0D01F00ADB;
	Wed, 12 Aug 2026 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546585;
	bh=99L7Qb0T1mZdY2Odsi01Idha5EYcQTmoWYTTFhZRnHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bV6KIz5dmp8qX+pi+mqDj+BkXdVohtD9I0x19mq/m9KfJKaASGE7d00I0q+bwnZ3K
	 UFSZBI41kJe867EdTTiHu7s4MaCGQMSBJvJtyE61S+2ZhSPhtuEoQr/h4KsqXDkGI9
	 mj2vIMPnmf96HxZE3s8RYzXZKMnhq0wSHmQ7FlD+w9u6TXk0BB8BvgBK6s1mFnUcUk
	 QO6J38f2wCYKXFNXjlyuhUJi4h4RM1GrRd4YkehVDRhOxH/x4tPrz0WYzMNGw8JaPZ
	 AMR0To2YQPgpa5XC4lh4IHRYOnKHmvXK4lA6YZGDDSAaoiG5zkq7llat8fWUPKzKFG
	 kHOvNLy7KI09w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:46 +0200
Subject: [PATCH net-next 11/11] selftests: mptcp: diag: fix stack buffer
 overflow in get_subflow_info()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-11-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Jiangshan Yi <yijiangshan@kylinos.cn>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZQd/MrYUKm4TlmYB1vFvMyTuLUJRZJTgoE3JKvtLoTw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOit9Mv9vmsirx8LlLxLWOHm/sFXVNDNdPkexr/x6W
 f/C7Od0lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATER/MyPDvmestoGPzDNv31n3
 1OOBr4zb8YIpe81v6UQtWpFw+8UvJoZ/6ukpvDFiRj6OKdrz/AyLtx3fekChRKtP4vbMX5J9LZG
 sAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Jiangshan Yi <yijiangshan@kylinos.cn>

get_subflow_info() parses the subflow address string with:

	char saddr[64], daddr[64];

	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d",
		     saddr, &sport, daddr, &dport);

The subflow_addrs buffer holds up to 1024 bytes and is taken directly
from the command line ("-c" argument). The "%[^:]" conversions have no
maximum field width, so if the address substring before the ':' exceeds
63 bytes, sscanf() writes past the end of the 64-byte saddr/daddr stack
buffers. This overflows the stack, corrupting adjacent stack data such
as the saved return address, and can crash the tool or lead to
out-of-bounds writes controlled by user-supplied input.

Bound both string conversions to the destination buffer size by adding
an explicit maximum field width of 63 (leaving room for the terminating
NUL), so at most 63 bytes are written into each 64-byte buffer:

	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
		     saddr, &sport, daddr, &dport);

The subflow address can be passed in argument, so fixing this is helpful
when the tool is manually used.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 5e222ba977e4..3b8d2c8a6216 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -377,7 +377,8 @@ static void get_subflow_info(char *subflow_addrs)
 	int ret;
 	int fd;
 
-	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr, &sport, daddr, &dport);
+	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
+		     saddr, &sport, daddr, &dport);
 	if (ret != 4)
 		die_perror("IP PORT Pairs has style problems!");
 

-- 
2.53.0

