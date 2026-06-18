Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E05800
	for <mptcp@lists.linux.dev>; Thu, 18 Jun 2026 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781741467; cv=none; b=P85yJaHuIpFvixQzBdJ33fikiZ58FlIW1qxF1dlCpGXzFu5I22tMV1q4kIosznEBFlslLPmxPrpHSmsPAfVly/RVKAOe66k3J4xJNfLF47X/qm12TGBgt3lPQkUfpBxaYlAij0UzkC+KDZNq9/L8YdyusnEWX2U+lUL0ctmNCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781741467; c=relaxed/simple;
	bh=cX7A7LvBMAyMkOPtPxKEb9xT8E3UwHc9nY9RIkMcGoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkAeQf3xb/AwHg81UUhWAFGno97hTe7ZlbDPqB/izj56/V4c+8IybeGGbRNo/RXk3HkNJRvmTYZBw2dRD8CQs4ZwSqzA6l36k6rSPbkd7aXlyfMA81JBHuLNx8f6ERSaemLh8OH4AkzRU2V3LRYtEnSXbV8YYBRO8JhkhTkwDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wMsVC/zr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wMsVC/zr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781741462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNfdSzfkgaF177PGx9FzaKZfGQOoUpnNHJx7DdDte4o=;
	b=wMsVC/zrqcCJpYTjJ7etJFYC7GhRXeJ/HX0oM/HhKfeUjQhGtoJy9r51b0j+JgVxexEird
	NedWuzd3tSbkRDgkN7/ynq2m9b+D2A3N4MjFAs2fvOQKkhMa5uv/nw8d+sT80e3YkVEqWS
	00+BhjEzq4yvPtyUNqn/ea7DuTYg/C4=
From: Tao Cui <cui.tao@linux.dev>
To: kalpan.jani@mpiricsoftware.com
Cc: janak@mpiric.us,
	kalpanjani009@gmail.com,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	shardulsb08@gmail.com,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
Date: Thu, 18 Jun 2026 08:10:34 +0800
Message-ID: <20260618001035.1701878-1-cui.tao@linux.dev>
In-Reply-To: <20260529085415.1562229-1-kalpan.jani@mpiricsoftware.com>
References: <20260529085415.1562229-1-kalpan.jani@mpiricsoftware.com>
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

First of all, thanks for this patch!

While playing with it on top of the current tree, I think I may have
bumped into a small detail, and I just wanted to mention it in case it
is useful — please do correct me if I got any of this wrong.

After the "mptcp: pm: uniform announced addresses helpers" refactor
(7d4dacc8ccca), the helper became mptcp_pm_announced_remove(), and its
lookup uses mptcp_addresses_equal(..., /* use_port = */ true). A pending
ADD_ADDR entry coming from a signal endpoint added without a port
(`ip mptcp endpoint add ADDR signal`) is keyed with port 1, while
msk_local carries the connection's local port. With a listener on port
5000, a temporary printk in the id 0 path shows:

    msk_local.port = 5000
    announced(port0_lookup) = 1

So, at least in this configuration, passing msk_local directly does not
match the entry: the stale entry survives, and the WARN still shows up
on the next reselection. It only goes away when the port is ignored
during the lookup.

If that matches what you see, the smallest change that keeps the v3
shape would be to clear the port before the lookup, something like:

        struct mptcp_addr_info anno_addr = msk_local;

        anno_addr.port = 0;
        announced = mptcp_pm_announced_remove(msk, &anno_addr);

(An address-only variant of the lookup might be a touch cleaner, since a
signal entry never carries the connection port — but the one-liner above
is enough to fix the case I reproduced.)

I have a small repro that triggers it deterministically if it would help
— happy to share.

Thanks again for looking into this, and sorry for the noise if I'm
missing something obvious here.

Cheers,
Tao
