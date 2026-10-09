Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C42D838E
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533878; cv=none; b=XE+sAx/AOHscxKxSLEn8y5o/IdHDVYRh0ONeUsTSytu560rqPlUqKwu/S97AysFwc4IhQKRzLVYdBzYP4CmWTh/eJdflYe7CyjhIHaTse1cljiBlDuxuUahV0O1gVAhnYBtcGHhGLxm6LLvGFexiHRXZ/S2hGyXDGTNYU6wgrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533878; c=relaxed/simple;
	bh=mtUeMHV8rf9bQtx9uQ5+34+C3v2pyf3hTZJKmC+vbKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mc04nUop12XIR3SivH8vUKbZ4djDCHdvFx0kKYCyghqZ8OQKBReZFEfdwZWHchvj+LwaV5RDRttDVdT+4MwqX990ac/YeAmUhHuqxKrTgPTlKyNY8hcovn0v4+NCLUuxKf4zp38PI2YSjem2Pieta4oC6waqjqwkUMYvs4/AdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PX1kW6dS; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PX1kW6dS"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=mtUeMHV8rf9bQtx9uQ5+34+C3v2pyf3hTZJKmC+vbKM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791533873; v=1; x=1792138673;
 b=PX1kW6dS1lNbRyO9kpzbVjs8EdVq5p8KHhn24ORSxq6PTwlRtGIaqZhWTeeZUDEu+YFvA61b
 J05kskmx/9zKo/V+fmH1BzPW8onmPryUCnTL1iLPmdTzo3tPcV3lP8YqvovLEUi7vwmfqKEofFx
 +6H652WEbZS18oCXe3QStBQU=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id f75ec6133f904e90;
	Fri, 09 Oct 2026 08:17:53 +0000
X-Mizu-Trace-ID: f75ec6133f904e90
X-Migadu-Flow: FLOW_OUT
Date: Fri, 9 Oct 2026 16:17:44 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] squash to "selftests: mptcp: convert iptables
 to nftables for mptcp_join.sh"
Message-ID: <asijKELSThzLqywv@fedora>
References: <20261009-mptcp_rm_debug-v1-1-a7b4fdbe1b5f@kylinos.cn>
 <sashiko-outbox-165003@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-165003@kernel.org>

On Fri, Oct 09, 2026 at 07:31:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] selftests: mptcp: incorrect squash target in commit message
> --
> 
> commit 95308d8ced7d193c5aadb0348b4665a25a875b28
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> squash to "selftests: mptcp: convert iptables to nftables for mptcp_join.sh"
> 
> This commit removes the syn mark rule from the output filter in the mptcp
> selftests. It is intended to be squashed into a previous patch converting
> iptables to nftables.
> 
> > squash to "selftests: mptcp: convert iptables to nftables for mptcp_join.sh"
> 
> [Severity: Low]
> Is the commit title targeting the correct script for this squash? The title
> explicitly states "mptcp_join.sh", but the diff exclusively modifies
> "mptcp_sockopt.sh".
> 
> If this is squashed into the "mptcp_join.sh" commit, it might cause confusion
> about the patch's purpose or result in applying the squash to the wrong target
> commit.

Oh, sorry for the typo, this patch should target to mptcp_sockopt.sh

Hangbin
