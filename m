Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789C8BF8
	for <mptcp@lists.linux.dev>; Sun, 28 Jan 2024 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706422619; cv=none; b=Z4kL2G2nUpRXFl7auHYGWqaq5abE9Tdykott12fVHwp082jMjCZ07KjhgrRiCJUmcyQhqMCy5k86tcTqsqjpdwJvWt5w2qv32qQrwwoj8CWY10CmoF/6Ck+q+BhLN9Y3KZhfkr/zcRHZOWzle9qPoFeOdozhWI3veNmSqmvL8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706422619; c=relaxed/simple;
	bh=+8t+OaCFiFMftVPUT71HQw8aAEuyVXhizteYQNL6LJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IUKgaF5uoCcmOwfnd/rIKRvuqbcPnvD0SDxdGmKPiOgNSfF6hDjpGvqQdWbHQrjLnOMZsoRBFUStyWsbsnO7gviDTIbH89VzguaqCe0RnNEZE9HNj3CkV7SmITtpNNKllJ/Z3Miq+NkPwX4wkbzj8LgLDm1i+XujfjjXceelmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmyaUpPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmyaUpPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A41C433F1;
	Sun, 28 Jan 2024 06:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706422619;
	bh=+8t+OaCFiFMftVPUT71HQw8aAEuyVXhizteYQNL6LJs=;
	h=From:To:Cc:Subject:Date:From;
	b=dmyaUpPaYo4tYaFaA86xI+zfuXIXHXORZrtG5OowtqIsD8Wx7xyHy6vx579S5HMb6
	 9WC3PO5DKL34X1xJa6ajiVlWvcE+ZUEkBS+waK+3iomSmWsh2CmotQx3bDau3DQMcZ
	 OsVT8HTlo2hvFqsbc9r5bUf3LO20DD9a6iXGSECte5+QJcla1HGL2SjHSg/PTmC3F8
	 4DKPivHrQmpqXu5/JjbwUnwzSecyRxLiqQ5UTR9X7VMhq9C8lQ5GRC1RgDj+OGUWH/
	 SAi6lIcSu1bYuij0OVzDv4cHEy3fPfh8T4yk6ad/Tx/dpGodV9xRBtudhla/P65ygg
	 pWt3NcvryaenA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH virtme-docker 0/3] bpf: add bpftests support
Date: Sun, 28 Jan 2024 14:16:00 +0800
Message-Id: <cover.1706422466.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address #406.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/406

Geliang Tang (3):
  change watchdog to device
  upgrade to ubuntu 23.10
  bpf: add bpftests support

 Dockerfile    | 10 ++++++++--
 entrypoint.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.40.1

