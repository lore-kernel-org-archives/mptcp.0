Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B892DECD3
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362573; cv=pass; b=WoL6ocntM6ql9BkTf56zyox1q87M881I8v86xzB2Itajw9RqLnvIeCV4g4MIzq0JBPua60Va2IssPah450QtJS5s6twQxdRBU+Vu7dJe1Y5LQHpHmdcSxcUNBc0wJ2mlZJeZYX2JotlPOKxzvuzhrx+WLoEQaSCctjDwH2NhHPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362573; c=relaxed/simple;
	bh=b6bex6WFRq6aDBcHqJBb0Gov5XokLYyS/cNhOS0NXHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LqytcjJ6zEyS6mwR1MniuR0rNPS4kelNPQbJdhcu2mw0B1xp5NaXUR6sFOQLttV6GFqT3hCAnKih8GfQz14vQca0vJb4c1Z8KzdUUuAXWDDodgXG6+WEqyS31IdlsyE9VVG6raI3U0IUcrV9eYxusqwaL0T/mqgpXMIcElVDNxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=hzu8xVb/; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="hzu8xVb/"
ARC-Seal: i=1; a=rsa-sha256; t=1777362534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cuiRRhuXgvyhNhpGLtOdWmNoFwm2Dmi0eqEQvgOuNZ9lcdhn6jTHNHmDR7l5MrWhC3wXhBLnjdjQtiWMMwKDEhTmRW6HjsI703VujIm9YAnOhkU4uNdK99q00RR8VthwGUr04g0poWMan40cPSFqEeM96DOuvg5GyxNkgYnm++8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777362534; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8X1D7Re0OwwPN71om672yr0MR9k9nhXm05Hpv//9k/s=; 
	b=G5h0GWw+Nna8AtrL792QhtQZjVlYkn9ADrp9UoXSGXy2aBzT2pN76TYBSef099jBonAq0hFPyLOLWF7CR9Sr90pLDS62vATV+7JSUpssUkuoMLW0VCezUG96w/s5lC31aP2TJRxhWy7HRdq+BYOLKTItaIZoSMyRGwOX1wdlGzQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777362534;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=8X1D7Re0OwwPN71om672yr0MR9k9nhXm05Hpv//9k/s=;
	b=hzu8xVb/iBKeOLjdRnqtE3IIGfbMULGl/OEPq3wx5bNQagxP6ksaPlx9hA5vXAgU
	D03/3hPkGqb+fJgQM9kHlwoR7bEcjSsj6uE+BKcb7PPZ8Et2zuovupd1sYMzswN8TVr
	xk59usRzyEAnZsyr6RRdysWGl1tW7WfhHoqcTS3c=
Received: by mx.zohomail.com with SMTPS id 1777362531931130.09521301305165;
	Tue, 28 Apr 2026 00:48:51 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net] mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC failure
Date: Tue, 28 Apr 2026 13:18:44 +0530
Message-Id: <20260428074844.1746594-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

In subflow_finish_connect(), HMAC validation of the server's HMAC
in SYN/ACK + MP_JOIN increments MPTCP_MIB_JOINACKMAC ("HMAC was
wrong on ACK + MP_JOIN") on failure. The function processes the
SYN/ACK, not the ACK; the matching MPTCP_MIB_JOINSYNACKMAC counter
("HMAC was wrong on SYN/ACK + MP_JOIN") exists but is not
incremented anywhere in the tree.

The mirror site on the server, subflow_syn_recv_sock(), already
uses JOINACKMAC correctly for ACK HMAC failure. Use JOINSYNACKMAC
at the SYN/ACK validation site so each counter reflects the packet
whose HMAC actually failed.

Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Fixes: 3eccc998b50b ("mptcp: increment MIB counters in a few places")
Cc: stable@vger.kernel.org
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e2cb9d23e4a0..bda6862264ca 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -581,7 +581,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			 subflow->backup);
 
 		if (!subflow_thmac_valid(subflow)) {
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKMAC);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
-- 
2.34.1

