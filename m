Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539CA44A3EE
	for <mptcp@lists.linux.dev>; Fri, 25 Sep 2026 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332718; cv=pass; b=mF4MpRqs6508DzkKb11Bv2/nH/lOXyaz+rU6ZBC9vnicyQP4EWOHgrG6lx9eW+zGytV7JxjzUTT3+ThFtssCO82ZhXQbnoLzq2O/TKX+iv53mjZn9yf9gsEuQLg54+tPFZP8z01sHiK0WFzc97dnkjuLMN4jbLAL/uXhGiXIrx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332718; c=relaxed/simple;
	bh=Ih7F+cl87P7m0imgGnq/BFgvQtqL5Wj70aYd1cNFqso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahxq++lTInWAj9kgNAGQBI7e3LBj0I4JjP5dCCm+pSA0q5hQbJsY09aAtYVgr66YJF7krqtnFwIYnPJmuqLBrvHQF8qD2vEAIai5wNmIyQGkFEaWYUta8r2trGDDMssFjesazH/jMRFB+9nd2uYr9r2weJFDksThyvmtJ41aU14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=EtYo0OWt reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="EtYo0OWt"
ARC-Seal: i=1; a=rsa-sha256; t=1790332713; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GBBgUzQ8JZJ/CFykeCe1vmee5An7O2PcVLkwQhiZZiRzRFKwJuK9TyaEXi/t2Ut8bPabmJ2gwrldia6dM1DXt4flr7qBhld0asGTxNnwCIxwTkvjEGWhN7R6kTGFuO7j+kQirDmb7XVxV9gBqB3Do15KTZUAWdY9ADW7W/Cn4t0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790332713; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ih7F+cl87P7m0imgGnq/BFgvQtqL5Wj70aYd1cNFqso=; 
	b=b7KfQhd7G1+3ghM+BqDXCdsIvCgVECQz9jz9ZdIL3QC6eJFF/thHGpgKIBtBEYp7kSuLYSWuWsSwZgQcTmWV2dROqCl8IvD5vrFgyVxox9YPFobFFuPzpZfEI6PcU2mBz0P0P45/IpHcrTdCYGBMup5Ci3q0kFjRMKnPjY75J9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790332713;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ih7F+cl87P7m0imgGnq/BFgvQtqL5Wj70aYd1cNFqso=;
	b=EtYo0OWt8PXP+kcvkxoK7GKV6+qQhlLHP9/ED/Owu+hqwXqq81xP3+1BHHnNZr7q
	i5GYPToavB3UK+tXeG0EAqJcwPvLrq+X1qRrcxrbYvYhF65T5IJq6RMf8u9BgJiY0Xd
	gSW365FYo/wLtAavqjMttzzFfBARmQ12CVEgC1X0=
Received: by smtp.zohomail.com with SMTPS id 1790332712280680.1700445413211;
	Fri, 25 Sep 2026 03:38:32 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: Re: [PATCH mptcp-next] mptcp: force a push after arming infinite map on MP_FAIL
Date: Fri, 25 Sep 2026 16:08:20 +0530
Message-ID: <20260925103821.420389-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922071245.1997430-1-kalpan.jani@mpiricsoftware.com>
References: <20260922071245.1997430-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Thanks for the review. I looked into this further and wanted to share
where I landed, including two dead ends, rather than go quiet while
I kept poking at it.

The gap is real: mptcp_established_options_dss() copies the mpext
already attached to a given skb rather than checking
send_infinite_map fresh per-transmission. So once all data is sent
and only pending ACK (mptcp_send_head(sk) == NULL), there's no way
for the infinite map to reach the wire -- a plain TCP-level
retransmit of an already-queued skb just resends its original,
frozen mapping. The only way out is a genuinely new mapping via
mptcp_sendmsg_frag(), which requires either new data (not present in
this scenario) or MPTCP's own retrans path -- which
__mptcp_push_retrans() unconditionally blocks via
!msk->allow_subflows, set just before send_infinite_map is armed in
mptcp_pm_mp_fail_received().

First attempt: relaxed that gate to let retransmission through when
send_infinite_map is pending on the subflow, and explicitly triggered
it via mptcp_schedule_work()/MPTCP_RETRANSMIT. This deadlocks:
__mptcp_push_retrans() holds fallback_lock across its whole retry
loop, and mptcp_sendmsg_frag() -> mptcp_update_infinite_map() ->
__mptcp_try_fallback() tries to re-acquire that same lock. Reproduced
as a soft lockup escalating to a kernel panic under CI.

Second attempt: threaded a fallback_lock_held flag through
__mptcp_try_fallback(), mptcp_try_fallback(),
mptcp_update_infinite_map(), and mptcp_sendmsg_info, so the nested
fallback check could skip re-acquiring the lock when the caller
(__mptcp_push_retrans()) already holds it. This avoids the deadlock
-- confirmed clean across repeated runs of a shrunk-file repro (data
fully drained before the corrupting packet lands) with correct
MPTcpExtInfiniteMapRx/Tx and MPTcpExtMPTCPRetrans counters every
time, no lockdep/RCU/softlockup issues.

But re-running the original, unshrunk "Infinite map" test (128 KB)
against this version consistently reproduces a data mismatch between
what the client sends and what the server receives -- 5/5 runs, vs.
zero occurrences across several hundred runs of the same test against
the unmodified retrans path. So relaxing the gate this way, even with
the lock ordering fixed, appears to let retransmission interleave
with the infinite-map transition in a way that corrupts data --
likely because the sequence/checksum semantics genuinely change once
mpext->infinite_map is set (data_len becomes 0, checksum no longer
validated per RFC 8684), and the existing dfrag/already_sent
bookkeeping doesn't account for that transition happening mid-loop.

I don't have a safe fix for the unacked-data case at this point.
Both attempts I tried address the locking/triggering problem but not
the underlying data-integrity question of what retransmission is
allowed to do once a subflow is mid-transition into infinite mapping.
Would appreciate direction on whether that's the right area to keep
digging, or whether there's a different intended approach for
flushing the infinite map when no new data is available.
