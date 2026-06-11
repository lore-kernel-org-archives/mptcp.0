Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCE372ECE
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209956; cv=pass; b=sHdx2IbgFF+pwXiKPG04hknJAFk5dwt8fzRfFpsDoJSol4Erp8vPpNmh2AehtKuwipyavl293OJlniWJ0yFrJJtHxlZTAn3WrZbfcoMQqd1pjZMPEAi/LJdhi1qXnUQJ5+oSAlSsIeXhUDSc5p0tnf9RXcMu5Q4WQHeItBKk8hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209956; c=relaxed/simple;
	bh=oRPuLed9+y0UX2fZLaQ2QHQ9cZz8PH4WwAuyWhoYGfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pMlJ4dxLkc0LKp9rfES4E+AoLFETmQpV+1vYaz0EH2G8bI3WvUZdmz5zA8vGHFSarEPzT+RLKva3COCjShD48iuRNcsCAD80tza2vQTHEzmD7vuz7plcTZIhb3Yo8DZIDKnz+IGq/rPwiV13wt9IJQvOAyz5HNnofGtcajZkMTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=VXi6/m7v reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="VXi6/m7v"
ARC-Seal: i=1; a=rsa-sha256; t=1781209947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X4F9TVs0FESRnmw8bz4+inWdotkQAwOnEyGJPHerFIaAtssWb5TagGrn9zCKFYT5422SlknNUT+jRoxZhTBbBczrdgtZPx8pIL1wboRydJbA+6pa5+oDCQGcaO4EDZTU+MFP75NwRBHe4xnDuEjJaj5doiY94Mcvhwgt/QWKsEc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781209947; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FH5J8FewfSuNQ/RD80r6Im9uTxwF8oJSwZYrPgEqIjw=; 
	b=VLuqnapPezpgfw+Go7zc7PSUFgRfIPKswPIIBoUGWH1gc8hUVHWvn6wq/eHmokRBBxIU3h4UWV2Q4Fvo/mkWtTFQt6Ouw+81NOEo5HenqK+y7tiX+WrcPvSX6GZoX44hz6PJjnft1W7KFQMePAMYmUKx3UJrfTMQCtzzjvPTPtI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781209947;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=FH5J8FewfSuNQ/RD80r6Im9uTxwF8oJSwZYrPgEqIjw=;
	b=VXi6/m7v7OBL4K0JgME1L419vqxN0hy5d+KPhLj7B5GAfMQ64JoG9DZUXzWLkT7Z
	pL3kBDS/Yljcdczyyg4JIP7KnS64DLV8PxY8k4qerRfbVmXdaqO7UIZjJxgwW9lriUY
	NT6+34DjdJ8e5+zuqLqEPpTReh/56LAWdp6smgds=
Received: by mx.zohomail.com with SMTPS id 1781209946628949.758724462893;
	Thu, 11 Jun 2026 13:32:26 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	pabeni@redhat.com,
	kalpan.jani@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v4 0/2] mptcp: per-event MIB counters for MPTCP_RST_EMPTCP
Date: Fri, 12 Jun 2026 02:02:17 +0530
Message-Id: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

MPTCP_RST_EMPTCP (reset reason 1) is currently used as a catch-all for
several distinct conditions across subflow setup, authentication, and
data-path validation.  This series adds per-event MIB counters at each
of those use sites and validates them from mptcp_join.sh.

Patch 1 adds seven counters (MD5SigReset, MPJoinSynAckNoMPJoin,
MPJoinAckNoMPJoin, MPJoinAckNoCtx, MPJoinNoIdFound, DssReset,
MPJoinNotEstablished) and increments them in mib.c/mib.h, subflow.c and
protocol.c.

Patch 2 adds named env-var expectations for each counter: the
JOIN-related ones in chk_join_nr() and the two reset ones in
chk_rst_nr(), both on fixed namespaces.  It also adds one test inside
signal_address_tests that triggers MPJoinSynAckNoMPJoin from the
existing ns1/ns2 setup.

v4 (this version):
  patch 1: add MPJoinNoIdFound for an MP_JOIN that carries a valid token
           but for which the path manager returns no local id; it
           reaches the same MPTCP_RST_EMPTCP that MPJoinNoTokenFound
           only counts the no-token half of (Matt).
  patch 2: move the MPJoin* checks into chk_join_nr() with fixed
           namespaces, leaving only MD5SigReset and DssReset in
           chk_rst_nr() (Matt); rename the env vars (join_* / rst_md5sig
           / rst_dss); the new test uses mptcp_lib_wait_local_port_listen()
           and asserts with chk_join_nr().
v3: https://lore.kernel.org/all/20260512103331.1934343-1-shardul.b@mpiricsoftware.com/
v2: https://lore.kernel.org/all/20260509183335.969018-1-shardul.b@mpiricsoftware.com/
v1: https://lore.kernel.org/all/20260421095646.3741956-1-shardul.b@mpiricsoftware.com/

Shardul Bankar (2):
  mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
  selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters

 net/mptcp/mib.c                               |  7 ++
 net/mptcp/mib.h                               |  7 ++
 net/mptcp/protocol.c                          |  1 +
 net/mptcp/subflow.c                           | 10 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 93 +++++++++++++++++++
 5 files changed, 118 insertions(+)

-- 
2.34.1

