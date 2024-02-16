Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1721CD11
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077051; cv=none; b=ba/uCu7v0OlL06XKwF32LlGzuruBnSAjwaOcl8bGn1w1+JZUaJkY2jca24MmWXAnk5j/TNn1pfbETnqzc/USh92wFFw7PPfT2nPght3i5ZlQkP4zvC59VJ9dNdZ/vWc+iD62XikKJXxvnB+xtnVnWhquoloxSlpcnrxp73PTpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077051; c=relaxed/simple;
	bh=jkU8fzHKVOY3XrQK/o8fGUMEv+lpAbJD1IclMBjSAxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVyB2FOyFd45aeKJKhIWR2k2KxEE2iQtPjFsqb62zih1FZoQeMRpucApc9q2WYfH5RPJkeW49IzYYAulmAhYQScuORkFCWzhGze+6ucre1DHw1hWr8S/c2y4yKFtEZPbapalgNyDjSbXoAvm+qotNKaItYzkoJ7gVLqDsT5yMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHjcYOsk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHjcYOsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D323C433C7;
	Fri, 16 Feb 2024 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077051;
	bh=jkU8fzHKVOY3XrQK/o8fGUMEv+lpAbJD1IclMBjSAxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHjcYOskMlrX2XSHEtcFyhgpHb3BtEwcC6j+NveJeuAo0MKU5Yoczl+bN2bBseUAw
	 gHHWwTz1HHOzx5umzYVSA1gNULS2iHdAM3Fo+qCUYL8c9bS9Xj8i1ItKXgde8Pb2of
	 PLKbGBEJI1hEid4I6QBl0oomKPfOhGD6S7l3YVZZ7QiJ9WzIBfPbzuhcvXhc9J0oW1
	 Kw+mniKUdDKXwBTIwGVmI6jFcXOTcP8c70VnMgfs3zBEBEcp7ismP9y9xs7vMmEiYA
	 h92WnoKtA/a+4ppObUd5dq3Rch4RzkIptc1HLdzfFBS1JywAy9EaLSrfqeohTs0hsX
	 X5VidAurPBBfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/7] selftests: mptcp: simult flows: define missing vars
Date: Fri, 16 Feb 2024 17:50:30 +0800
Message-Id: <ee7f67e523e39a8438f58e8b5d840846ffee8c79.1708076886.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708076886.git.tanggeliang@kylinos.cn>
References: <cover.1708076886.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

fhe variables 'large', 'small', 'sout', 'cout', 'capout' and 'size' are
used in multiple functions, so they should be defined as global variables.
This patch redefines them at the beginning of simult_flows.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 2f5d3c73db5f..e6e5b933a1b9 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -16,6 +16,12 @@ test_cnt=1
 ret=0
 bail=0
 slack=50
+large=""
+small=""
+sout=""
+cout=""
+capout=""
+size=0
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
-- 
2.40.1

