Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05AA923
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 04:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797681; cv=none; b=k5NdrbRcgdeFyCV9G7Ju0Vfa4brQfbph70YX3MtbWIc1kmOMK3Ql5Z5sbMYb/NXTt4xm/IVjbAtdFL8fgEYimx6UHpYsdjMrGjApN2ZSMyrbcmJNxHiRbPBZNcu3cu4G1uFXur/5FSsukeXRKWjFsvLN3ZxyHVa4MrLWyl8Zx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797681; c=relaxed/simple;
	bh=H4IffA2U5o9sY524ccj/Ls4urMqKJ4LUD7sRZbuHjfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3i0Zshg+SyhlIrAjixashL0AjWz8Acs00nVB2UAuK5zxPyNHCWFaJwCQbeOyF6mzK9w7dCUuubDe4k/nKRPjZ0xSyGCc4gXQyYvf5oPvUheyfL3r+4sHKkynCDXuB5T6jSVqvkWuNR2mEMeOFj+QEIuFF3NzeEWBzaMPc7y9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR3QuTnU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR3QuTnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C60C433F1;
	Tue, 13 Feb 2024 04:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707797681;
	bh=H4IffA2U5o9sY524ccj/Ls4urMqKJ4LUD7sRZbuHjfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mR3QuTnU6O7VwljFCNloLvLH9tMbILGZX6hqJACt1NbeYPgKeiNzriQWBTWeneLXV
	 Nc8e6VxbtbZcTMYoCQnW4Gmi6HhAgeyvbE9KvdmwAf32yfD95L1/6oigKT8AydY89L
	 ljlF7s386DDozNJvHHnd9IzEmx55guTY501oC0z9+WIaczX5eDvSiHzLcSN8OXkc7A
	 /B24nQ6oPvq3PBi4eAv7w58myLF8D+Ry9mm3CVercioTUCAmOzsmNwJ+nMm3fgBpNU
	 Q6WW0+Gclbe/d/pZ1YYQ72J3OSp0eYF+Nk5cQ/gvJQtKOktQe8fiOj1YvqIB/I+fw2
	 hXycuS6O6NZxg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 1/5] selftests: mptcp: netlink: drop duplicate var ret
Date: Tue, 13 Feb 2024 12:14:24 +0800
Message-Id: <dd5c10825806803e3fc9fcf5090e8cd4dfc5887f.1707797566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707797566.git.tanggeliang@kylinos.cn>
References: <cover.1707797566.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable 'ret' are defined twice in pm_netlink.sh. This patch drops
this duplicate one.

Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..ed1e8380838a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -28,7 +28,6 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 err=$(mktemp)
-ret=0
 
 cleanup()
 {
-- 
2.40.1

