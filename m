Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C692AD00
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 03:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355616; cv=none; b=CgLU/T7nWjTwGAb1j01jNNyBYqw/Uy5LkvZqbFSN0gC9ZFMfJHjeKvmvxAX6jlXHQyKxeK3RqOYlEuXRV949N+9DGTU/fftE0JKyXkDRWpQn40F2hKkH93CHAgJeCmpSnVFngT2YSykvOSsZHWdKjpPxi4BZzIgllSJVg+EL5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355616; c=relaxed/simple;
	bh=/ZSwQquWLk3u/a8WaWK1gdB+3m+JxHAeuMOiNBnFXPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtYZqPXYaguJPie5y2HJUMyv9K3rbj5ttTriSMpB/kzgylWsPCH/9JgRAQo9WMJ73rbHsw2xoNW6CjNCRonggpV58nX9jAB1MDKEDwcGUm96Z/F6DBMPRzHGBsGDNtv0mvf5mM6eyAA6piVlO4ubHi8mNKParQqUh4Wcm4NQl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blUbVVFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blUbVVFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D7C4CEEC;
	Wed, 19 Mar 2025 03:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742355615;
	bh=/ZSwQquWLk3u/a8WaWK1gdB+3m+JxHAeuMOiNBnFXPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blUbVVFrvTv6C92Tb/8vLj+2OlA01FVmF3JvVffaNChinCbUCXcai6siY/CanaR3E
	 SlslVYRaGgWwzlKfow7WjAMs9ofcVPZz5+/sAV0zpkg9fx4HCTvvvTvocBkmzpIeFG
	 SQDY+t0RtBmOOS2jDYKnzhMKPG19VZB/EdtA5+382cHwTW6wtNIvep7SReDGs4zUQb
	 8DSvMJPcmh/cx2EXopUutBthktqetKMw6UuioZxSrCFPeMyRd69HHJwZOGZlCAgmZj
	 TMXhciuktX6uId3AlYUkZvwIQqUNYc3AbH+KOEyYF8d/UKeibZYaSzgI4Uc6VoSy6Q
	 lg5tHT+n3jwXQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Cong Liu <liucong2@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: close fds when copyfd_io fails
Date: Wed, 19 Mar 2025 11:39:56 +0800
Message-ID: <961b887097ccaff040737256cd6a5e66485b4eea.1742355162.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742355162.git.tanggeliang@kylinos.cn>
References: <cover.1742355162.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When copyfd_io fails, it should not simply return an error, but should
close all open file descriptors before that. Here an "out" tag is added
to do this.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Co-developed-by: Cong Liu <liucong2@kylinos.cn>
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 5301062a5f3b..f190f95a3338 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1293,7 +1293,7 @@ int main_loop(void)
 
 	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (cfg_truncate > 0) {
 		shutdown(fd, SHUT_WR);
@@ -1309,12 +1309,13 @@ int main_loop(void)
 		memset(&winfo, 0, sizeof(winfo));
 		goto again;
 	} else {
+out:
 		close(fd);
 	}
 
 	if (cfg_input)
 		close(fd_in);
-	return 0;
+	return ret;
 }
 
 int parse_proto(const char *proto)
-- 
2.43.0

