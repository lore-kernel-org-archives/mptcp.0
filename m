Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E73DD87F
	for <mptcp@lists.linux.dev>; Thu, 25 Jun 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390716; cv=none; b=DeE4Kpwwwv0ZN49QxbWwI+NlGGnKrh2BHD3eNeGnNMxpk+xGs4HBb0p2OjsjAw1TCYk94s2YKqKe+mHxgrD298/IpmlR5Kx2ICzysUwJsNz+3Lo4dh7IJLHrlP32lpvLwH6gXFwZ783PBRbsubc9lQBLo8lB3q2npMcun3mweI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390716; c=relaxed/simple;
	bh=VSVDjEJNIbg5wmGgDntHXelkDqCbhvlZ+2cVJ8h3uv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASHv5trO4Cu66arazmWTw4NiRGFJd/gfFnySAkLTVdeSxBhknV/yTj2GbHDQTk5cqITjctTf7L8uJOPqXO96wdH+owj670o59kRrsLJINbTIHufYQ5KXc7stkWYlZjIFbE9npIq+K3ReX652WRH8/x0Ya0PhydcB7ErXclexElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c8rX9e9G; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8rX9e9G"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782390708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbYngqo1yrFMc1hU3uNw2U+zYT26SUbBqoMpKan4hjg=;
	b=c8rX9e9GFQqh17VQI34UWk1gYDLx6u0Chd/hDX6lcmrR+DCXSsNASKDyUYeHv23fsAy3PT
	XAvCfiSbC+HVr4CTLXCbb8GLcAC9gsEPiAv6kMJJC3MqVOm8v2ptkC34Ye/iRzWKRdsmtj
	Momzl9vUnTNAMOFKSIb90nt8lqgkKLg=
From: Tao Cui <cui.tao@linux.dev>
To: kalpan.jani@mpiricsoftware.com
Cc: cuitao@kylinos.cn,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	shardulsb08@gmail.com,
	cui.tao@linux.dev,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Subject: [PATCH net v4 1/2] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
Date: Thu, 25 Jun 2026 20:31:33 +0800
Message-ID: <20260625123133.709454-1-cui.tao@linux.dev>
In-Reply-To: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
References: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Hi Kalpan,

The CI build failure is just a leftover rename: patch 1 calls
mptcp_remove_anno_list_by_saddr(), which was renamed to
mptcp_pm_announced_remove() in 7d4dacc8ccca and no longer exists in the
current tree. One-liner:

  -	announced = mptcp_remove_anno_list_by_saddr(msk, &anno_addr);
  +	announced = mptcp_pm_announced_remove(msk, &anno_addr);

Cheers,
Tao
