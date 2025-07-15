Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23002D7819
	for <mptcp@lists.linux.dev>; Tue, 15 Jul 2025 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573131; cv=none; b=hcI4cDQhEkFzARVQllXO2Kw0noztv4XHJ8CVTKgxj8tphik4r7tSNSoT2lLtUeYmax00xiBuNApU6T4ATDTsdOkNycc4bo1yWAjVQC1xOphU329DthV52JVSot+55cShdXdJIW4svNSv/h9VRKIzWs4op3APcNpMdkxEhRT7Zcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573131; c=relaxed/simple;
	bh=ZsAwAGSkwmhpIocVp1w+d64xa+IdRJKANUr4jIW0Xr4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WgEakYYpmfSJmNPRzERzLzxR9EV2CfsOWpxog7UqpGK42MLFADS97DEx55i+tWNdU5JSI/c5HMDE5prXTzTjz3GctjJrNzKmYhXwQxFnP3XERoJEtRw5k6RVms2XorNDH5SBUmmLOex9iTMcPYlYjTfv105Gyh8ZcDeSaKQ3w7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJTh1Kd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJTh1Kd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65434C4CEF6;
	Tue, 15 Jul 2025 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752573131;
	bh=ZsAwAGSkwmhpIocVp1w+d64xa+IdRJKANUr4jIW0Xr4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ZJTh1Kd0lsj8+dqQafQj06OaOFWs5kSxZTfOYBJgIZI1wPIEYRJ5zHDWzmXDePmC1
	 zleWZIXh9n4N7j37oO4hPUjXCIbNETS/M3GNHqPXill+vT+YfLKm4GDTwFP1CDhRq/
	 zxYdQc0EP2WJHe7GigwnGWuzLoxatjc5nfMEkeokW0EGZ0p0sNb63Pli1ObhJ2oBO2
	 qOhJUS55ZLr9P8nPOYmgfxbck6A4d9i8FzENcb1g6QnOngYRlazBHfful5GT+YCNpI
	 1AO6P2cXRAtvRRnI7pt20BMJ4HGpRdR4VTGN+TBAa8AzxoJiK/br6/srBWIWJiqav9
	 06KJ7MT2dEo5A==
Message-ID: <e33e7262b9c30069bfe9666114ca796707a8324c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] Fixes for "selftests: mptcp: connect:
 cover alt modes"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 15 Jul 2025 17:52:07 +0800
In-Reply-To: <20250715-selftests-mptcp-connect-modes-fixes-v1-0-58fc475d9397@kernel.org>
References: 
	<20250715-selftests-mptcp-connect-modes-fixes-v1-0-58fc475d9397@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-07-15 at 11:49 +0200, Matthieu Baerts (NGI0) wrote:
> Without that, all mptcp_connect*.sh subtests have the same name, e.g.
> 
>   mptcp_connect: ping tests  ## from mptcp_connect.sh
>   mptcp_connect: ping tests  ## from mptcp_connect_checksum.sh
>   mptcp_connect: ping tests  ## from mptcp_connect_mmap.sh
>   mptcp_connect: ping tests  ## from mptcp_connect_sendfile.sh
> 
> In such case, the CI will only see one subtest, not 4 different ones.
> 
> To fix that, MPTCP_LIB_KSFT_TEST env var can simply be set.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Matthieu Baerts (NGI0) (2):
>       Squash to "selftests: mptcp: connect: also cover alt modes"
>       Squash to "selftests: mptcp: connect: also cover checksum"
> 
>  tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 3 ++-
>  tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 3 ++-
>  tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> ---
> base-commit: 422cf93634436650f6ea5dacb37f1edfed7ab3c9
> change-id: 20250715-selftests-mptcp-connect-modes-fixes-61383574b42a
> 
> Best regards,
