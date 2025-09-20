Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80A212550
	for <mptcp@lists.linux.dev>; Sat, 20 Sep 2025 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758339935; cv=none; b=THJrU9a18fkL7KsqKEpcbhaZvjNNgcjISIYorY88dx7czGunvULbI53eT4QWiONbXn6zoxttvCVivYgyTl3SRRenNpS0QY0nEOX1DlMtQVpu1PKUH3vFpBvfA1NhuMC/Ri+juB7nLqBv/K72v4rw6pepSmE6NuPQ9w3SognAaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758339935; c=relaxed/simple;
	bh=isRYjgPnJpGvNNt9xhyARWr2U9zz1kRyoyeQN+Li0Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idsOmwTdaW6Kh9np7a9tS21z96+k8wcj1gmoBjV5WEf4OT6Iq04khKZxCKsj7BWcQwyi9KEpRqPCBoMrdTYqzO81jc0PcxqGUGwqGpfphgAspRiMwrdstIYN9jvkMrkHIJZUpOiIJL9yBlghxJIbrCzRThVEk+jmLnj9rLlB/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD9qDt7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD9qDt7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C77C4CEEB;
	Sat, 20 Sep 2025 03:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758339935;
	bh=isRYjgPnJpGvNNt9xhyARWr2U9zz1kRyoyeQN+Li0Q8=;
	h=From:To:Cc:Subject:Date:From;
	b=HD9qDt7TUZdLqDimuyrigtumkVM2wh8M/EuECyu3rjMEJXshozCC+m/FKLr8CEoqO
	 qIAKFODb/CUbYbud/iNINVEW9K0xVoHoa52eA5Gn1TTbAKzyxl01Wz7uZWGu9+kkUl
	 co+eUMpHzZTMrpyeM9rdYAKDsX2yH5GkTP2gjLQQY8m3PJr5NPitkAR5JVnFktseS2
	 r2Zlc2PghpoAEKjbYTrAmk2ajwE+l+/wUJZ/ho3f/M4KZbHKXWfo5Hx+EI1meFj+cG
	 m1WQkSN9hUDCsALJgEh2qyKf5rc3Kwze4Gg+X40Fh2hKsHJcFybwlXOWqxd2msXXDd
	 UoIN2+JS+QN1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] fixes for "mptcp: receive path improvement" v3
Date: Sat, 20 Sep 2025 11:44:24 +0800
Message-ID: <cover.1758339666.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Try to fix errors reported by CI.

Based-on: <cover.1758296923.git.pabeni@redhat.com>

Geliang Tang (2):
  Squash to "mptcp: factor out a basic skb coalesce helper"
  Squash to "mptcp: leverage the sk backlog for RX packet processing."

 net/mptcp/protocol.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.48.1

