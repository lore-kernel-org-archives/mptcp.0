Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54116F8E9;
	Tue,  4 Mar 2025 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054205; cv=none; b=h1PJ2MveE3kgVdc9eaYR5Jo4a+FhHnCS1CFL+RvXwJO336g4S5WDTqnHZr1MTf9IjaPUSunk0uKkzBi0QI3oPQ4pmKngmFtptzCcHQlYeq8keMwamZ2RmQ0WxtFLbHPshE/gEoGMLzSwhHmQXpdu5v+NZQoZfwmkrBmASRcd7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054205; c=relaxed/simple;
	bh=mNNK4A9PcXJOJVTtLwr7TqFQkdcBVDTV+lHKiq55zrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fQg7Kjh/KLZeeqF1fmu8SqYQIVeknoIGR95MOnQkTxM5T6kbdDZLOX5L+pnTOak9HrvLuc/wH1hgsaZ38phENl7kXF4heCxFPAF18ikHtCI7ffkIQuMDiO1vseoKETvuLn7wsCUM5l3zAknvnbt3bTmfmWKgh9fJGNrTqWd6AzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pxjpt6xD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pxjpt6xD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65230C4CEEC;
	Tue,  4 Mar 2025 02:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741054204;
	bh=mNNK4A9PcXJOJVTtLwr7TqFQkdcBVDTV+lHKiq55zrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pxjpt6xDxZE2ggO3cQdpQm5fra5Iw+r8rbjUs5qAagj7qwG1xutVcIeGMgYbz7iSf
	 ASRXUoZ58rugdhOfMSMT2bp2zHcaZ9Oxp4rwxjCiaaEon220f9Zq2JPUoeYApcNOpm
	 owzOWfGygCcHjvJJO4s5BIrfJ3ihupL6MfWRnwFtbSIu/4IEis6+p1k8KgJH3xQ5Gr
	 HMKTj517z5u+/+pixJdYdrnsWPSRNfozFQlBhzuW9awrd5rtE03ETlC65E2jX4yhMc
	 KX6kIBODN7Ic7Qt3n+6HAzn1LEGib0huxN3d8He8W1MuNdifnYdluXG6o5hccAYTup
	 b4YWZPqBQcCpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71184380AA7F;
	Tue,  4 Mar 2025 02:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: Remove unused declaration mptcp_set_owner_r()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174105423724.3834266.10410139780171838306.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 02:10:37 +0000
References: <20250228095148.4003065-1-yuehaibing@huawei.com>
In-Reply-To: <20250228095148.4003065-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 17:51:48 +0800 you wrote:
> Commit 6639498ed85f ("mptcp: cleanup mem accounting")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/mptcp/protocol.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] mptcp: Remove unused declaration mptcp_set_owner_r()
    https://git.kernel.org/netdev/net-next/c/60d7505292c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


