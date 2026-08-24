Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383343EB815
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555395; cv=none; b=VxN8TIgYnYgOG1CX3Xv9Ay2bFkk3Ld5DR1PN9bwvoQIrk+hEK0tROSq0PLaBpVYwEpDZEWzT3wVN11oHEdDfPOTviaXoWHRibSh8Bwbc8Wu/qEWV3AH83OkiEcguScGVH+29s8h8y0AAnxOeorem1d9xXLUYZjf+fGuHu2F9fqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555395; c=relaxed/simple;
	bh=Tmw0lOI8Ze7FEBjC9WUN/mQJyxYpBTgIxNxJQ3EhqF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTJtAhGyZIZC7DjmI+RA8p2cHSP2Nsj+Atb6qtgeE6PDNyStUEr/jGREd8KynVXgZUREviJQT0SxfIQyZ71N473MvfM+JyrwtHbA5m0QWRzznV8+4L4cBOKFXe793jMyEuqSe7hM7QB/6cRCoVx9xHaah7UNZPMW1mAPu4S/44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcRUyb4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcRUyb4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FAB1F000E9;
	Mon, 24 Aug 2026 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555393;
	bh=96CSdpH7OkqFOKZscA/69I+xKE3GdDtX8UcIsDLaco0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QcRUyb4KHBWEiIUxk6wVRnW0MdtcYDR967BF/c4Gy5lw0zLe3d1PUnKC4yFlC1KZc
	 zfxmCAIGaAJdBtW1biPw3zDYPjHYiFfuHvl172HXOQT1UY/uym+LvHzWcUTW2bpbH0
	 M1HpbkFEwsAs57xrHaagOtVcQVrsHFPSDSDCikiCzfASHUQiyVIEYQr+XzJ8REWrwR
	 zZSTE9GmoXG1YtmphzINx6PHDfbc8rnsCDOi8Hp5dj9YIrSHCpDLpQcLDWOq7+VhJW
	 qGKJLpTyv0gQKLal1w3cJ+x2s4RxjLcVX0wZuo7i6rZt43tHEnrabm2ebAylJLJkPh
	 oN395vYiO4e2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/5] selftests: mptcp: connect: trigger splice_eof
Date: Mon, 24 Aug 2026 15:09:36 +0800
Message-ID: <58c55d194f1191085788313896c00b382aec62c1.1787554581.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Increase the sendfile count by one to ensure the transmission size
exceeds the actual data length. This triggers the splice_eof path
in the kernel, allowing the newly implemented MPTCP splice_eof
interface to be exercised during testing.

The change from 'count' to 'count + 1' forces the sendfile operation
to attempt sending one more byte than available, which activates the
end-of-file handling in the splicing logic and ensures coverage of
the related MPTCP code paths.

Additionally, handle cases where sendfile returns 0 (no more data)
or a value larger than the remaining count (e.g., due to concurrent
file growth). In such cases, break out of the loop to prevent
unsigned integer underflow and potential infinite loop.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..fca5d4606625 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -872,12 +872,15 @@ static int do_sendfile(int infd, int outfd, unsigned int count,
 	while (count > 0) {
 		ssize_t r;
 
-		r = sendfile(outfd, infd, NULL, count);
+		r = sendfile(outfd, infd, NULL, count + 1);
 		if (r < 0) {
 			perror("sendfile");
 			return 3;
 		}
 
+		if (r == 0 || r > count)
+			break;
+
 		count -= r;
 	}
 
-- 
2.53.0

