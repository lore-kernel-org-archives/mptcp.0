Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA064322F9
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800580; cv=none; b=sSQro5DBDhf5lgwKdqe2fx215py4AR+mEC9Jx18knZMZKhMt3vCzBb50dz1tBWh/WPZoDzQ/UO6J7OolU5dXTYxVA16EAFI0pL9cTXoepwVS2d3LozDwuWHxgE5La7vlbKR08rHTV8hDxFSYKCX5rdCX3EgXlqfN/MsSkT/g0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800580; c=relaxed/simple;
	bh=zo8ycUdY+9B6IVlWZtp/XChev9KskiTBtgHxoM3wggA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NlgXTn1WpONUJA/u2MHrlL4iEarP2bpOx2yw8BpBlJ/rSC/6RoxPO4VWYAbC1t//mluELqXwMNWcz7Jy2Gx7Ix0qOMlIn0Qlvb0UfARuTRds38uNVvdhx7eztWs9XwwDyygkpepQSNyxbRh5xeRuy4O2Mv0xjiAzNi8TolzYyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c9vrPATo; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c9vrPATo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784800576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MbODj/oB0s4+cT3n07iFkwh3d9sz6PakIZTckzcOgII=;
	b=c9vrPATo/MIqljuk1h3uqKGuLWfzBgy3IHHofsHp66VjVBHaNC3qrqCLesvA6kYsbFhjOS
	JCY2okKDo2tjRMd/LWmfL4raj1SbFVAMt5+7O2iOCgMo7EHaTahdejWTdp5P5MZ1MMN0Vl
	MBqDfY9b2syRHrgIRI5aYJz0mtF8YoQ=
From: Gang Yan <gang.yan@linux.dev>
Subject: [PATCH mptcp-next 0/2] mptcp: fix local_addr_used issue in
 userspace PM
Date: Thu, 23 Jul 2026 17:55:56 +0800
Message-Id: <20260723-localaddr-v1-0-ce84b865594a@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACzlYWoC/x2MQQqAIBAAvxJ7TlCDtL4SHUS3WjATjQjEvycd5
 jAwTIGMiTDD3BVI+FCmKzQRfQf2MGFHRq45SC5HruTA/GWNN84lJoQaG5NG1ND6mHCj938tcMb
 bRhbwvWGt9QO/xq3VZwAAAA==
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

This series fixes a local_addr_used counter leak in the userspace PM
netlink REMOVE_ADDR handler and adds a selftest assertion that catches
it.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Gang Yan (2):
      mptcp: pm: userspace: decrement local_addr_used when remove
      selftests: mptcp: check local_addr_used in userspace PM

 net/mptcp/pm_userspace.c                          |  1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 31 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)
---
base-commit: d2cc1d2dd6c52fda38f9a5ef2d5eb2acc5274473
change-id: 20260723-localaddr-117611798ee8

Best regards,
-- 
Gang Yan <yangang@kylinos.cn>

