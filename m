Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E5143C61
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767504593; cv=none; b=pXvwjwrYUChjyO/j+S8i8FKGUynyoMoZWnX9UEf/7AToulGQNN2Itu1FuYDCmDUOgM1Y7JxYAECZ2Lgpp6yKRKHjWgz30Td5RSQVVwaqKpx1rdztDQhA5XzUqIyMA2F9BES/mp/e/119i5arm1hXVq9dJ9yMa17VFv/ZG2tEH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767504593; c=relaxed/simple;
	bh=03u5rjHEYkJz3wA4eeXK8B8sXKSE9eeELIooUqowtBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgIi2973ug59HxkZZa9OYwe5IhTJRHHZpGIjSFIi+9XIpv8mjlqQM62Ay7+gVAXLeeq6lFdbXAJvyHWVAOzSCkQgf1PZNGnooAqM3lOzPrvmH3/bcGb+GC2vpavveWU2VsIGwvt4yNivIyCYgtU4/iax9Xff9Nzu02DS4XqRbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeiNWR5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeiNWR5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB12C4CEF7;
	Sun,  4 Jan 2026 05:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767504593;
	bh=03u5rjHEYkJz3wA4eeXK8B8sXKSE9eeELIooUqowtBg=;
	h=From:To:Cc:Subject:Date:From;
	b=PeiNWR5nDpqV0r6kTsW2ycMBGlcwMqvRShyb6lGByY3EBMxDCaAR3PDxlm3Ld7RwU
	 Hd6WP7+FihR5pUHdf+qS6BuWH88rC7Vj1ptFpvpaprTeVnOT5NLxenhNi+wOQ7NubQ
	 XsEoWmVxLWe7TniOcC/NIZbYohBwOR1nvQg0R5lcFdomPIpEVNBZWh2RFfzgQWYUtf
	 58ZcdNrYac34XepPk27Kjkw7SOjD5Nv640Dpgkaxd1B9korpo7y25OS1uHGBd4xC+O
	 fvnSWoGLRddo8VHeJz5wmLtftROlEwV7bE4NiDWwCWSgKJmtzp+HmHUhvYWiOQBg8V
	 XxvFXTTEghM+A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] implement psock_update_sk_prot
Date: Sun,  4 Jan 2026 13:29:41 +0800
Message-ID: <cover.1767504329.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - Include mptcp_bpf_update_proto within CONFIG_BPF_SYSCALL to fix the
compilation errors reported by the kernel test robot.
 - Add checks for IS_ENABLED(CONFIG_MPTCP_IPV6).

Implement psock_update_sk_prot, for basic MPTCP BPF SOCKMAP support.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521

Geliang Tang (3):
  mptcp: implement psock_update_sk_prot
  mptcp: allow overridden write_space to be invoked
  selftests/bpf: Update sockmap tests for MPTCP

 net/mptcp/protocol.c                          | 105 ++++++++++++++++++
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |   4 +-
 3 files changed, 108 insertions(+), 3 deletions(-)

-- 
2.51.0

