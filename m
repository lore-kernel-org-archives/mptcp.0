Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793176044;
	b=mCdZtBtCasco573l6Ku6npawg3bRxM3KILHo8SQrje3Kwq6oq3RH1vzB4MqhvWuDtNvo
	 UwEWtaGUl0sQ8/SxRB6Jtq6STTC7GT04aoeRk7kwtFyL8VmBJe2gMsJ09YzmAebpZHvlI
	 c2TySKMFKABVYI6D3fut5zO1qnji/0X5CfwYxThLvdTwEHA6HuFH7uR9wHH0wy0wG6A99
	 cNbTZvyPxPGOP4XVYSaFLY2qHbrnsR9f8ikms7jJ83PK1/m2MlMDJMYUB/NTs2/Gdq1YS
	 1YzNU5IZghtGnxMZjH0wvOK53gZ2mV29shJJxqDfmdPJcB2nYykmaNBohdfMyn7cU4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176044;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=3S4mlc+KKWGHl+066WSbmpUDxv3nEWv4SNsXrmgPfuY=;
	b=ggSlXN+9044IsO1dXLNDd8jslenY3bptZUTSI/phM9igVlHjfbkKBe0BsDnjGpQvZHlS
	 DNLl0eMRhDgRLKtnCq7reQD2cFRaleRM+XSEGgf3ZKU1dO4jgPPgt0urd79a6mpn/3Toq
	 FDgU4/INIYXOYq3uLEj7dFbMWflQJKYOXaiVJxG748fow03opMnbw7MnQyToL3spnkKG7
	 v5/98S6PlW7vE7yqagevBN8u2h3oedAwX2YrY/RH4exosMIWrNkJWXPUGlvZvAQ6fjfkD
	 DWXMrjLuatrAz7Xjha6tGPrQmyW34ukfJOpL2M++U9gQ6RmrAXwHpSmZdqVecUCfO5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE26606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 08:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE26606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793176041; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fx57gA+sLXXdsvgYHipzEcQi+UGjVQgc8ro1qRVReWYvu38WvDes2ase6u+KhIGIItTcbixVgNI6FloOYwvui2OYw2KjGhzaN1LfWQ3Q6ZZxeAbA/XOzG+9cE7N6vg3hvMCEVLc3pUnYuu9DyFhrCT7GvrhI0Hsj6bXhoVXsTaw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793176041; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3S4mlc+KKWGHl+066WSbmpUDxv3nEWv4SNsXrmgPfuY=; 
	b=Tg072T1JxJSqhG4UwLpEuzAgGUFpoHq44I5l2cYdJdm3VMuqJgShB8bBzlCy2+yJBFPqccya8FEnB/Nxd1ol2F9Dwy+G2uUZH86iUnDV+Jl6HiZc5IEyy9gGZdBoM1nHCWrJdxo82PvKys5Q4sCYD9j/ir1pxd7zroribiO4Wcs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793176041;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3S4mlc+KKWGHl+066WSbmpUDxv3nEWv4SNsXrmgPfuY=;
	b=tPxhAATkUaviiR08JAqSlRksmf8D97Q7ERzCWyuIjc/Ee8Ilv0JFV/sbDB/v/ddp
	S72DVtFyGYN1Ne8cOhCtwPsNCI1eUTvOEWm28FSwK7n7NGRe9mGZqN2jZ3dxFv2BD1G
	eEZDEF8hD+7IMUOKqGqqjscNEfEF9ItUDvC9/Qt0=
Received: by smtp.zohomail.com with SMTPS id 1793176039202459.22084619033524;
	Wed, 28 Oct 2026 01:27:19 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [RFC net-next v11 0/2] inet_diag: restrict MPTCP sequence counters
Date: Wed, 28 Oct 2026 13:56:59 +0530
Message-ID: <20261028082704.1609493-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org>
References: <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org>
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
X-ZohoMailClient: External

This series updates v10 following the review discussion.

Instead of normalising sequence counters, it restricts their visibility
to users with CAP_NET_ADMIN.

Patch 1 passes the request's CAP_NET_ADMIN status through the generic
inet-diag callback. Socket-destruction notifications pass false because
there is no individual requesting user.

Patch 2 zeros mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in
unprivileged MPTCP diagnostic responses. The MPTCP_INFO getsockopt path
remains unchanged.

Changes since v10:
- Drop IDSN-based sequence normalization.
- Split generic capability propagation and MPTCP visibility restriction.

Testing:
- W=1 build of all six affected diagnostic objects against the local
  mptcp/net-next reference.
- checkpatch.pl --strict: zero errors and zero warnings for both patches.

Kalpan Jani (2):
  inet_diag: pass net_admin to get_info
  mptcp: hide seq counters without net_admin

 include/linux/inet_diag.h | 3 ++-
 net/ipv4/inet_diag.c      | 6 +++---
 net/ipv4/raw_diag.c       | 2 +-
 net/ipv4/tcp_diag.c       | 2 +-
 net/ipv4/udp_diag.c       | 2 +-
 net/mptcp/mptcp_diag.c    | 8 +++++++-
 net/sctp/diag.c           | 6 +++---
 7 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.43.0

