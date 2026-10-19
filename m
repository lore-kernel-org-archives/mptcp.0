Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429686;
	b=XgWqHteYcvuYzBSrADJIPinAbO9ewWS0/QZ2kZPH7sb50iBDBwjB1u75A6TneVVLobxX
	 GruBkjJBcLZcrOQRtX2oaRBnT/vc0p93WTz6xGLN2C9wWkFWgSOb6eClkWKejufjE9K1U
	 I7WZ8Cgs2RMM8Skv9rpowvfX1IuaQYzlxE39ZMiWZOKvwtzx03yUSm9gdnIGXueb83KB6
	 zN1iHwNVYskS4kQzcQg34hDGOkxADvj/qt7mzQttywPMSaDApYs2cb9Q+qCGQIvVUnu+6
	 wCS7PkMOWotZJORFtJUXEMdhzFR7iqLJVHa4jbAHkjuUkvLBL0mnk12MwZX/jIDKaxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aEwwJDaRcKrXZUQ9HwzKMxOcMEY2QwFfDX9Xru12yGs=;
	b=LFOoFxX8CGc/NMmQMIy01eCKoUDrwTSgNocCdCvLpAj/tfHz2Tern6bRb3v74hheYezu
	 aOsxdbVcMMg0JAIJWOgG0DuYLJwa4IngH3BYJOxjnNABk7AP/LHunPSz2pRBA13AnYHCI
	 QKokfS9/AZI1MVJ655OZf/qaQcVljA7vaBWWudsaN4YTjDierR3n19mMLFv6Fan7zZ0O9
	 310a9wildo3Obsnlw1iafDGcmTQMD6FmJiM/2D9c8gcCNUnBMB7KKW4olv5tKY5p9AsTs
	 IX4RE9/euBZEKgGnhtNwbbNLcUozl0go1DdjvhMapGf6vM7OOlkqmL5xNaHtT6DLirA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HYNN8uNA;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA71606A31B
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA71606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HYNN8uNA
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-16079d54c17so5171169c88.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429686; x=1793034486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aEwwJDaRcKrXZUQ9HwzKMxOcMEY2QwFfDX9Xru12yGs=;
        b=HYNN8uNAR8s9KF2xPwWfNW2aLeTwbmcW4+2YjHJrGtssg56zB/AMkth3GdiSZlvLQf
         zJI4WZXZ4PXQeXBGAaxbVy4kpZxwnDG8CnOIvyNU+g3aI7JxdhGrquQGh+HdPEJUodr6
         nq2fu9nooYpcntc7c+GvUb1T2VLSL1/ELsVcjopSo9jM+IMqcWj93lvshYfOdsK05jb1
         Qj+ose5WG583evLlMM2UbZ+VeWvXrFgWmkYC788DDkjtxi9nzFlQeszjgDtxnv5H8OwI
         KIAE0mJ8gKizJ0KNVBLGuitx4xE/jsHA3uwzRjamjb+dfNRvpL5xf2Fe8gyMki9r5/Ve
         EL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429686; x=1793034486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aEwwJDaRcKrXZUQ9HwzKMxOcMEY2QwFfDX9Xru12yGs=;
        b=VAkuRDaTv3vWvk8YLauC2J5nN2MFSmW5aC6RcMhdr5d5shkCtAmEolWPRZDEl8YSuV
         2h42HJoTveSv4mzMjWWnYSUEBVSLbDO30oYtuiF9//HrvMMuO+AlWD1dwsmVDDAdPUs2
         td81ZVu8iYCn/35W3HAVBzb9k/Smt86ypcFbGIQ4Y3FKcVCx1L8LS3OFP0791R46zsm2
         YzVR5N/BDxk1W511fJxzBQK/hY0MF0IgpzGd66rnVF6JTVtxpke7l0eL/3vFJ+zjUmaW
         Y8yQ9CdWH2vrpXAl2PJJLReHE75iiKeHvcYSeWjQxkGwJ0DAWYPtymWxOk5FZ+iG6C46
         f4Pg==
X-Gm-Message-State: AFq9FYIlWG0iXdl7USLQb3SqhDp5ttCMfL9SX5ilsvMTMrcuFjxgxMLa
	gKQnF21VLzSOZUt5L45/YV/zut744mdgtzMGid7qVNUOXg2y0Hc/kTVxm35P7g==
X-Gm-Gg: AYBFou3v1iXvPkIId0z0no2sU2WdGuebH32reRU0BD/V1pF+E1QiX/5J3RjkCNU8ycA
	T3CAx3gSsHKpuvlstLv3JFtED+EeV8gtxiNdhPZoLFSav/4c9lBQPJitYj/W3v/QeyrzHyjpGvI
	lXZnoHqNeG3ACCEFEqv5GkFABIBRHAL9ckDn4yFN9ZYZ/h+hCr2j+NdrS/2Oubvs8tDvmV8R711
	CQ0EJXg6gHUk0Y8TzJ5sY80s20i54kLfM8xZPAgf6vR45WJDycusXz4WXLjRPvfWtE7z6gxM8de
	qizgjW7NbXIbrv1b4+7q75ZNNtGFufodNvoa8//nNw0odBywW/iHAsYIWe+41EN7A92T59MxLak
	3nggAvn3x28buVdftmDVVVtNN+ioSpfvdNLAJs+XKagIZN+IWxJJFNE66O1+HvgdVv8rd5pL2bH
	CYSoYaZBv9M5+JjXhkHyQE3YmUc1garzql2xsn9jTSP29NxXJGw8KnORW8TMRZ17bLylotqSMBk
	q9Wx6k=
X-Received: by 2002:a05:7022:170d:b0:145:287:ce91 with SMTP id a92af1059eb24-18511ad88b6mr11728793c88.14.1792429681029;
        Mon, 19 Oct 2026 10:08:01 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm29247207c88.5.2026.10.19.10.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:08:00 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Mon, 19 Oct 2026 17:07:49 +0000
Message-ID: <20261019170751.200446-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fullmesh endpoints, removing and re-adding the endpoint used by the
initial subflow never creates a new subflow from it: the closed initial
subflow stays in the conn_list with the local ID 0, and marks the remote
ID as used.

Patch 1 fixes that, patch 2 adds a test for it.

Found with a router flapping one of its links: the link carrying the
initial subflow never rejoined the existing connections. Tested on top
of the export branch (they also apply on export-net): the new test fails
without patch 1, and the whole mptcp_join.sh passes with it.

Abdul Wasey (2):
  mptcp: pm: in-kernel: fullmesh: skip closed subflows
  selftests: mptcp: join: re-add the initial subflow endp with fullmesh

 net/mptcp/pm_kernel.c                         | 10 ++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.43.0

