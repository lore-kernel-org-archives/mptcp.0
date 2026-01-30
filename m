Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A536AB78
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770403; cv=none; b=mDrBpsGs5xkxWdF5pCDDb6sHhGxtnWkzkcrYoBh4Bh/fR7EfoWLM08FDYN6VHaopRwpzNynZYfPhBj//WTiUl4zcyD+dZsL94kaX7q+AO5IwgDjEJwEbQXQD7r3YoNYGAuZ1Oj/MB9RZAQRbR2qQhww0zzkcM2GHl9LC0eio6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770403; c=relaxed/simple;
	bh=u4dCcz6gdOuSGny7l3HDCjnHBJ3hTrY6MnI0JmLQLgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvflWuoNCK0ASHBBIcIUNDRx4ItUSvrGo9H1ZUNZnrV34wXR7U0okeiyhqiC/ncvbS1u3njZmtvpH9Sl27UuMV8r6W0F3WCwAvOv/cvmAkoMZ4UhWgpaYmG4Uod8nzyFejsscsXGLBymxBDJteTh4wuR8JyjUWEzuvNR8V8tL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XqYScpP7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34Jfamhf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XqYScpP7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34Jfamhf"
Date: Fri, 30 Jan 2026 11:53:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769770401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU4K6aX6z3ESU10qcbxhlOIxH+u+4MneZVmqcqB9Rhg=;
	b=XqYScpP7OS2zcOZRsnk+V1FoszmDHH3TtKls/Q0GaG3YCKq9iKL/IIBTysshxgJmGmXsSh
	yMpvBgYZMiCvU5dbLcB2DN4lHueErBBIr+T792UnVLEu+5KPP05bkQ85SCOeEtrQWoBcIY
	9+RihX3P9nFw4W6X0yn26VJYJ8f202teXUyO/o+Q3trt7G5OX79U2QMQLS7Fe1+q+4Ce6F
	XWsgas/l26LFIRCyV5Zse4YHshvLtxC5HIsE7f0iCUyvN5uRuPE5SCotBYjVAooWedsBOZ
	nnLty+Vnd1q3PxZcbVT16EuOz0hd52+CTM+gQus1IoAN/Fo+rOQtwSQ8vdBYZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769770401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU4K6aX6z3ESU10qcbxhlOIxH+u+4MneZVmqcqB9Rhg=;
	b=34JfamhfUnzNcrQTJvnI9nqwlNolJEz9TAAZJ4SSg7HQjcFL+XpUwA/3567GCzZf3xXMi6
	ghrC+b352UpnpNDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: diag: sort all #include
Message-ID: <20260130115218-0bdb243f-819d-46aa-a7cb-fd43fefccb8d@linutronix.de>
References: <20260130-mptcp-sft-sort-includes-v1-1-ab022fad9741@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130-mptcp-sft-sort-includes-v1-1-ab022fad9741@kernel.org>

On Fri, Jan 30, 2026 at 11:41:43AM +0100, Matthieu Baerts (NGI0) wrote:
> This file is the only one from this directory not to have all these
> header inclusions sorted by type and alphabetical order.
> 
> Adapt them, to ease the reading, prevent conflicts during potential
> future backport modifying these lines, and also to avoid having UAPI
> header inclusions before libc ones, see [1].
> 
> Link: https://lore.kernel.org/20260120-uapi-sockaddr-v2-1-63c319111cf6@linutronix.de
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks!

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  tools/testing/selftests/net/mptcp/mptcp_diag.c | 29 ++++++++++++++------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

(...)
