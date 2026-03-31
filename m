Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD533876B9
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948132; cv=none; b=dKFoUaVk10xyjoGa6x1YPAQFaNiEwPmEJJox62wvooUtY4M7cJYfQqO9bwMdauWSlVzEsLPA+h2k1hTzmDqT2mXL7KYx0XhAN/xZSbNbRx1AvZY07WFtU7WDpXBVBsnOzsBdO/faYDr7eP+qbX7SPvyqkBOjko7AzhuiKXEpWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948132; c=relaxed/simple;
	bh=dT9UHDesKUd/FCSN+aNlKdXqFO6dRRvSVFmaGWDtBzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mc0bQ+l+MZVNaCS4zrQIDdnSfiK3yWGw3Gifh4f+HDWpMqnk7T8HnSuS0W2ZFEUfISgkAeLhd02Vxkl+DSiDebEqFnRdGF5Ht3hZTEclFoYZG5NYA1RXMT2TqazLNYUMBRbQtdpPVazJ/gCAfSAPnxWWBiaY++MhP9WpnLRSoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iQ737ijM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iQ737ijM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774948127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R5Kitshv2h9rTstk1o61PrJsjSpykhTnHavGSw4tkFE=;
	b=iQ737ijMhOJwJGs3cXwb6q/H60FNVopnqZPav9JmhnyOOflqBN3kkr71eFK93oWST0vsHu
	Un+wL6I3kcSMMYAPHR1c73t5455TsjGaqmtz0OJkejku4D1bY5/RCVkROYY6qFLl0Eorok
	eN1U3hJB9sknBhaiIIzKke8mbItuCZs=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] mptcp: preserve MSG_EOR semantics in sendmsg path
Date: Tue, 31 Mar 2026 17:08:07 +0800
Message-ID: <cover.1774947296.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Hi, Matt:

With this v2 version, the packetdrill scripts also updated at
https://github.com/multipath-tcp/packetdrill/pull/189.

I removed the 'mptcp_eor_subflows.pkt', and made some improvements in
'mptcp_eor_no_collapse.pkt'.

Thanks,
Gang

---
Changelog:
v2:
  - Split the change into two independent patches:
    Patch 1 changes overhead to u8 (with BUILD_BUG_ON).
    Patch 2 implements the actual MSG_EOR handling.
    This split makes the series easier to review.
  - Added a !df->eor check in mptcp_frag_can_collapse_to() to prevent
    appending new data after a dfrag with the EOR flag set.
  - Improved comments at the new BUILD_BUG_ON check.

v1:
  - Link: https://patchwork.kernel.org/project/mptcp/patch/20260309025431.125943-1-gang.yan@linux.dev/

Gang Yan (2):
  mptcp: reduce 'overhead' from u16 to u8
  mptcp: preserve MSG_EOR semantics in sendmsg path

 net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
 net/mptcp/protocol.h |  4 +++-
 2 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.43.0

