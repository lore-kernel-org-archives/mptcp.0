Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C000253B58
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941777; cv=none; b=RsdrnMpLUQxuANH9FeU6F1zF9zIgupkf0yu7Q5kOCfVoW3fhHfWp8gbX9VkywLmRf8KXC02UCsP9pZhkq8lfezqsM3rb6aOwBx8fba4FTOUWo3dRMeM8cO2SJi9qdyA0bWWwQQRZisK2dNNadwkel5dVj2mBpV/WVYca6mvP7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941777; c=relaxed/simple;
	bh=+MNP2Ll29aGa96PzZXaZUQpz5rDNAOVZEONCZRlTfW8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AW30cj4eTbzzxSvos4D3JuXkY+EJ69nzvS3YfQ4BDcr0bTMLny1Se5OSn/Tdes/4qP/j87HcoUZ9If37ze6bhy8meEHjO7DYiDSBJSWaQcOa+eemtKL8GWciPno9NC7HPkbt81hQNHtHECyEgo7L0mWLEwGZF7Mi+Nur/ZqsW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSgboQh+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSgboQh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7F2C116B1;
	Wed, 12 Nov 2025 10:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762941777;
	bh=+MNP2Ll29aGa96PzZXaZUQpz5rDNAOVZEONCZRlTfW8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=hSgboQh+gDjCN5qXccKmuz84vj7Q5sYUrsMdwhrMYIKb5Q3qiThxe1bKN9Z2nIZ8K
	 CWFRsJ3DvGVd81a8aPSIEwQZikPrpvWZnwrpWCblnpVz6cYLFeCcedJKEQJBpkp1F8
	 hQvpfQNdf7GV5dYnrCWCYpcQaxxB0uGH1Bhcb36srjQYbGJCYotZVpKkH68/eUP6eq
	 7ZAyok1WSr4unaYQZ/w85DY5OmNB8uu2VRZb8q+4eBniLuYZGu909VNf7WYexyhHUg
	 T/QFhSGnymhPNL0cFh3R5PnR8/PCJiQIFHCQ1YmlZzP71NylFtaQEO7Ft/RgujwbaU
	 OCpKKrqvcY/lA==
Message-ID: <db3ad087c99a9b625dc257e035cc271863cd083e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 0/4] selftests: mptcp: get stats just before
 timing out
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Wed, 12 Nov 2025 18:02:52 +0800
In-Reply-To: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-11-08 at 15:20 +0100, Matthieu Baerts (NGI0) wrote:
> A few patches to improve the selftests in case of issues:
> 
> - Patch 1: a fix to properly kill background tasks.
> 
> - Patch 2: avoid taking the same packet trace twice.
> 
> - Patch 3: wait for an event instead of a fix time.
> 
> - Patch 4: instead of using 'timeout' and print the stats after,
> another
>   internal timeout is used: if it fires, it will print stats, then
> stop
>   everything. This avoids confusions around stats in case of timeout.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This set looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Matthieu Baerts (NGI0) (4):
>       selftests: mptcp: join: properly kill background tasks
>       selftests: mptcp: connect: avoid double packet traces
>       selftests: mptcp: wait for port instead of sleep
>       selftests: mptcp: get stats just before timing out
> 
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 31 ++++++++----
> --
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 47 +++++++++++-
> ----------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 34
> ++++++++++++++++
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 23 ++++++-----
>  tools/testing/selftests/net/mptcp/simult_flows.sh  | 24 ++++++-----
>  tools/testing/selftests/net/mptcp/userspace_pm.sh  |  3 +-
>  6 files changed, 106 insertions(+), 56 deletions(-)
> ---
> base-commit: e3f3a4ba83a02423a3cb045f7485340b713fb549
> change-id: 20251106-slft-timeout-stats-d061de7fcebe
> 
> Best regards,

