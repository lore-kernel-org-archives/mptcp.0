Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993327FD51
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994964; cv=none; b=nMgI3yytIqkXV49hkvoiRf+OHZKe7IeXXVTwXXoMe+omCqci7jn9PkW7Z0ykE4sGoQpFtGU9Aj2sKoTxVGHDydcVDZacGr3bGZxgoAgrD4xPH5iNThl+q89BV73mIbF/SaVgWM3yGgBjqbqmuzUVb8XYTsmflQ7/cUIMUumog0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994964; c=relaxed/simple;
	bh=xY3Jrz7DHqrlZTDts8LE0cTJU986/V5IDCKLgpBUcGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFrFSqU9a42Sf16Thxb0dABqjMW3DDeqI7RW1dDlpN0Hqulz2Umf+MvIRIsbQma8NTtkpqHN/HOdINyHzZpF9y4WNZyT6BPW0IJxs9lqiD8OFZHKXtkFtpOnvF35T3qGcFxO8rvFdxTCtLk336705xtSzz9fuB6cJ4xBip8WgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7d4EGqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7d4EGqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377ED1F000E9;
	Tue, 14 Jul 2026 02:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994963;
	bh=rprTC4QLGXt3kdKTKNzxsjt5ZuKLPqQSPHB0wRXoAVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7d4EGqEo50r9qTFeqNH62ZsCr5HL9JnzLKHV7qU2ReipMWfu10xnJE31ElPDqqmm
	 D7iaMFy854SAnose58q4JLNHGlomH5hkUtH3v7+Yq5iESEoQEjcmuAocsfBoi6eoYu
	 USVd2dX0w4qRhYJB5/ogLhLaQz72uSjThc6uBr++ZCNYtTk+8fugBoSLG1E6WLpQFt
	 aqwlVazawxCSlU53AJ6hDnoF/LLupdWZvlBHjvz3UA79i0/PqL7gkwYaJAGmh6mnLv
	 gVDKTQXUpHfD5d5hEG+alj5Al+HdYIwIKXfM6Gk46YIaLYM68yltpr93l41wDsHKJ1
	 i/OVXo5WrTJvA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 10/13] selftests: mptcp: sockopt: read exact payload length
Date: Tue, 14 Jul 2026 10:08:55 +0800
Message-ID: <027f4ac4507fa246c0f2b38f30f794fae2acb992.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the exact remaining length ('len - total') when reading the echoed data
from the socket, instead of the full buffer size.

This silences a false positive -Wstringop-overflow warning from GCC, as the
compiler can now prove that the destination buffer is large enough for the
specified read size.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index cc1d45e85fb2..ba13898d8cf6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -638,7 +638,7 @@ static void connect_one_server(int fd, int unixfd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
-- 
2.53.0

