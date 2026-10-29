Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309524;
	b=t+JJCFIEIByDUqr4Vj8XIrw4KWe215M8ePQGOWYycq0Bbn/LUlN1ObheR7zXtxsdWX1W
	 Qm33l2SouZ18avxJV8bxtx3iWJ4MlHzI6CzAbVJLjOYB+Gnn0Sc5z4vj+5Qz+LSemJi+C
	 yP0IcoB+sORmyS1DUeQI+mtJvBo8Z/cFZfaYnkPo1dbqb6L2rn9gwjlGs/wC15W/E2Yge
	 Zw10b9LUcJsLSSU7dV5kNg5l/gZNdbgFKBFIfK8XCD/9KeZa4onhAg0IA+xdbcVtJaQx0
	 V/+co8nJOrvhnFozdH3HV9sBQct0L007UHAe4FHEIFPyZpKaDfRPguoJU+huD9ErqGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309524;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XAZGhqvD03+JeDBWh3YQsD9LTefeggJT4cCDo+hLgP4=;
	b=H0/jzk++uT/RV7BnGXHmpcVdebpxkdT/lHeeTa/lDSIoC+cCePXYpL8lgha/Vcb1wZHp
	 b73qtVuFjAG8ObxpnADOFyeaKKNHN74ataA4ea71zP0P8qnbM8kLL/z/IYMxlkYGScyaV
	 /UBgl40lyvzO86UjxQssR5ko5vxBsbyAQP40m5ub1xuVFwJ0lHDE+WApSj3meDoxLMQTA
	 Fb7CVLZEeNhwp1AO7wU3gnHm0ZC4nivg3bpYzztq7mSq5P1eNOU6s6qI7aGfYq5srpl/3
	 Bh/xb43/uGReQJpfTCSmmAGeViFpm1SQB+3qii9ugpQMAtx1m25C5OMsa3k+MVXYvjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fl5+AGvL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C5606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fl5+AGvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C3C1F01816;
	Thu, 29 Oct 2026 21:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309524;
	bh=XAZGhqvD03+JeDBWh3YQsD9LTefeggJT4cCDo+hLgP4=;
	h=From:Subject:Date:To:Cc;
	b=fl5+AGvLqGQ32wBWVaDuu7eCM1tydB1FykS0L9zN29tubEoojwod14ttnAF34FHm8
	 hpBpa3Wl1Ln8D3ggpcnOqwztF2mKxRholrrI4qNbgMlOatc0DVdDcG7Yc92n8lyHt5
	 8XWXtOoe4RarZPAvUkzds/VsceOt20/hiB5QZAl+Dk4cOz4eSxaprf9rittiIQPfM+
	 STwtSvVi5KXGBor/OYz3TMNlZHbTlOdfTmFu1ZGzyt9+cyHfgU9cf0ICdJpJrcEt32
	 pPwiIpk2+w2eakOT/D0WpJojZ+Jm21rtRDzYFjCFwU6TLgzqhLNadZgShYw2uQKaqd
	 mZxlno8yKq/qA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v4 0/8] mptcp: pm: userspace: properly deal with
 the ID0 case
Date: Thu, 29 Oct 2026 22:31:45 +0100
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOywrCMBAF0F+RrI1MY5qHK/9DXMQ40fhoQ1KLU
 vrvplVQEXQ5zNxzpyMJo8dEFpOORGx98nWVBz6dELs31Q6p3+aZMGACJOP0HBobaDjTS06mYOx
 wAdSahNSB5E5wLoRVJAshovPXUV+RR7DChqwfq3TZHNA2gz4c731q6ngbP2mLMfIslT9L24IC1
 UpKB8zojcHlEWOFp1kdd2NVy16YAvEbYxlzaAoFCgtbyi9s/o79+WyesS1qUKrkWjP+gfV9fwc
 akRlqfgEAAA==
X-Change-ID: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2625; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y3/ecV8EPjfwx8o9e0tdqoVc+rZigzhPJzo6yT19S0c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7/Y181Q6cNxSqNz9+rvlPa+iTv+wm/o7ncnKLDLgR
 4B5oaR+RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESqMhgZJqZ/jQqf+SJm94LF
 tzceNDy69rnTkvcGQu0youqBi21+fGFk6GfJM93yrq2/8eIa9Sj7o9pOK7e3/DRtW1Wur/4rapo
 lKwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In MPTCP, the local address and port used by the initial subflow has the
ID "0". It means that when this address and port are used for some
operations -- e.g. creating a new subflow -- they should be linked to
the ID0, and no other addresses and ports can get this special ID while
the initial IP address and port is used.

Instead of dealing with the ID0 case as an exception, add it to the
local addr list, and deal with it like the others, with minor
exceptions. That way, it seems easier to maintain instead of adding new
exceptions at a few places, at the cost of a few more bytes, which seems
OK in this mode.

The first patch modifies add the initial address to the list, and the
others remove exceptions, and validate that in the selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v4:
- patch 2: avoid two iterations (Geliang)
- patch 3: move the declaration of the new helper to one line (Geliang)
- Link to v3: https://patch.msgid.link/20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org

Changes in v3:
- patch 1: split exceptions + set msk port to 0 like before this series
- patches 2-3: new: from patch 1 + fix
- patch 6: use new is_init_id0 helper
- patch 8: avoid conflicts with WIP BPF MPTCP PM patches
- Link to v2: https://patch.msgid.link/20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org

Changes in v2:
- patch 1: commit msg + local_addr_used and needs_id exceptions
- patch 2: commit msg
- Link to v1: https://patch.msgid.link/20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org

---
Matthieu Baerts (NGI0) (8):
      mptcp: pm: userspace: properly handle the ID0 case
      mptcp: pm: userspace: lookup: match port in priority
      mptcp: pm: userspace: ID0 is not part of local_addr_used
      mptcp: pm: userspace: allow announcing ID0 addr
      mptcp: pm: userspace: no ID0 exception for RM_ADDR
      mptcp: pm: userspace: don't dump initial ID0
      selftests: mptcp: join: new ID0 subflow from the right IP
      mptcp: pm: restrict in-kernel worker actions to this PM

 net/mptcp/pm.c                                  |  8 ++-
 net/mptcp/pm_userspace.c                        | 92 ++++++++++++-------------
 net/mptcp/protocol.h                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  7 +-
 4 files changed, 55 insertions(+), 53 deletions(-)
---
base-commit: bcc5638fabf418e763621a432840cf55287e604d
change-id: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

