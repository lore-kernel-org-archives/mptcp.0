Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D450096D;
	Sun, 18 Jan 2026 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768697373; cv=none; b=aqnRZIrzG8mFOhBQ3ls86N3RAT9/2crg1bRxvXQ+qiRz4N9QRquUQ/pOECGdkOdrFsd7AkecWBV/P6YQV4dl/gaDrCUqsNakNh5SP1bvQaMmilvABMYUQtJDbt0iVJkzQgJcNjaixqtmDMcPRl848u82lxgdwwPsKGr6OT6qQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768697373; c=relaxed/simple;
	bh=VbOvOE8szbiEEc3m/5uVJd+yC+M9/BYE2w317eOONuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C4rAd2ir318v8rq4vtdAO5tGF+a3pInlCJp2erpovXrYQxub0OoRkUmgB0qWgcS6kLIz+AgozURIokwzQDdx/sg6Pw/i04po5vJ1aiScY1hd6rw5DEiIMa2MiPKO7BhavegL1WKtDK4ysNh6xlawBrYDtqRrbK42Extkxx/KKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOSJntWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOSJntWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66195C4CEF7;
	Sun, 18 Jan 2026 00:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768697372;
	bh=VbOvOE8szbiEEc3m/5uVJd+yC+M9/BYE2w317eOONuQ=;
	h=Date:From:To:Cc:Subject:From;
	b=tOSJntWW+XiWK85BD82UEbvTnWoT3cUVfsvRLqZuxgyGtS0EOCo8VjaLh6dutJ5aK
	 bfjL5loWLB/hPfWWrWcw119b+4az4YHbQiH2WGgwosPmZkYF3tseJcVheqpcjYi36p
	 zRhf8dwIH3Sd1ruaT/CdqpWMl7Og/Tv0Ww3KY2KUIrdFi/TN4+Y1qnSll2AzvO6mVB
	 GR5FdEkbNdrw8JxnthwWoW53XnSZlPzBlHtVB79ZsrDcfm9v0NoZECBqL4QiXW3g/f
	 ZUcd/z4+iv/aWbrWK0qYNrjGAPswDgo5iuTsEdnIeNbu78Bpgs1wAV4kWUk5S2Plyf
	 XfNkLGMjqEQ0g==
Date: Sat, 17 Jan 2026 16:49:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org
Subject: [TEST] mptcp diag.sh curious skips
Message-ID: <20260117164931.394ee1fc@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Every now and then this happens:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/mptcp-dbg/results/478242/10-diag-sh/stdout

note the skip and the leak.

Not a big deal if this is a false positive given the very low freq. 
But the leak made me pause.
