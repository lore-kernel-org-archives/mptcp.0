Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3D4C85
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521766; cv=none; b=G49U0uUX2ohFAFGalDU1jjo61xl3EIGm74EeUfq+QRow9Jj6YylYrbljtpsvUnoTC+GrKqN6067m4tE/N38uN59curXj0ej+5/tsb9/BMYu3TQ8GBc6BLMgJatXOoj3G/sneraI3xyo7ICN+GFBAqEqhPumYzhG5hPhd48IA4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521766; c=relaxed/simple;
	bh=v00w3C8wqJOGzWIXBuPPACMyU7rF7W+F9UKrpy2UPXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtNfeXeU9YXV2IlT9yX35ye3cXoG+9GN74rMpkjdJRaSGZ3SgOdzrPqH5SdEXM/MggCG5zMSK1/vhK6IWdHVCeM9rVDlyWgvhE9A84GnlWXdfIEwZfHZopP5ESA/f8+ficZrPOE4sC+DWUAtagVCWVlA+46efY2G+IjTGNyw+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBXV0DkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBXV0DkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03C2C4CEDD;
	Fri, 21 Mar 2025 01:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521765;
	bh=v00w3C8wqJOGzWIXBuPPACMyU7rF7W+F9UKrpy2UPXA=;
	h=From:To:Cc:Subject:Date:From;
	b=CBXV0DkZZAxOanq8TEOyjBKbAYN2SAY/wZVJOtCVTrHkyscn0S+DbhV7F+mMLVBEY
	 MK6bLmHPDa0zlsISfvUCZqhiva6IX/b9WUf72NbSsuLMSKT0RZQC6k8vqU5eAdNTIN
	 1ua52VmPqw+MLqcQ1dwLBq7G02klCRRooHZBdMPs7ir9bcLzrtX41wItAqG0M+hoGf
	 c2jFRZnrjGoqA4z6+vW5kujs8lpFzSPG66TcljNnCt/nZ+/fIqqeXeneYv3qv7BGSh
	 FcjHUzJY1QTj3A8rnen28PSfImBzihBPJEutFEI6ZKMx+w0DX+yY437pGiitkSuc/s
	 qncnOcoVLxhGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/4] BPF path manager, part 7
Date: Fri, 21 Mar 2025 09:49:14 +0800
Message-ID: <cover.1742521587.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp bpf_netlink pm subtest.

Depends on:
 - BPF path manager, part 6, v3

Based-on: <cover.1742521397.git.tanggeliang@kylinos.cn>

Geliang Tang (4):
  bpf: Add mptcp path manager struct_ops
  bpf: Export mptcp path manager kfuncs
  selftests/bpf: Add mptcp netlink pm subtest
  selftests/bpf: Add mptcp bpf_netlink pm subtest

 net/mptcp/bpf.c                               | 307 +++++++++++++++++-
 net/mptcp/pm_kernel.c                         |  27 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 284 ++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  27 ++
 .../bpf/progs/mptcp_bpf_netlink_pm.c          | 204 ++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_pm.h        |  52 +++
 6 files changed, 900 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_netlink_pm.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_pm.h

-- 
2.43.0

