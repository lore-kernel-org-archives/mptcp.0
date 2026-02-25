Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9E3B8D75;
	Wed, 25 Feb 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037003; cv=none; b=qNBukzKTm2bgkRXsEmM3J4E73V9FNiaPFo7aIXbw+u41Su1Gxm7OfDL5frbS4cMe0m8JV4ADWLrugqwCT10ErPK8omv8q2+GA9jQEVFKsAZdnXDI3LTNuvTafwDhR7zz+lg+oeooQGiLbCvXwIV3AD56QeYRuqwn4hWz1Pz1q9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037003; c=relaxed/simple;
	bh=X3djo022JmT3z/HPmhEcSpD6n6x9EOEnIQKRU0ve6ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k7n7AFeea3+everCmZLyCkiASqWwXmmkf5jN7Dx7cvqGD/feYA0fivghbt9YxHVGheBRltMXx4kTmuvLcUJ/Byl9mbj9JXoFf0pCEVu+PBD3Sb3v4qX564xIKzKcVe61fpObGD9g1aXaY39KlpyS3/QIXaQASuUwPGH5cM4oGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNtOPvtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNtOPvtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5226EC116D0;
	Wed, 25 Feb 2026 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772037003;
	bh=X3djo022JmT3z/HPmhEcSpD6n6x9EOEnIQKRU0ve6ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tNtOPvtEVmvvCQ8/59KcjFy/rS6XB34LLF4vKquqYrQE8GmxUcDqUNHqI7SLTRwDT
	 mffG/ZkOOYnBa5or0cMddrZYPsvqmPhHBHQJVPXFQmt4M857E1LIEwasONnAFCnsCb
	 w+adKr7YnlS21aid5TlXlaVdDJVKpIrUcKucUVPeJPNzvDM0hbd0GJDR8Js2daM8PC
	 qu8+gmTfjGYvqfqA/l5YKnV8cZP9+1xWPAeq1SwE2s2pLwWXY9Lvw8BBqwRlQMjb65
	 iq2FM8HJ4HvRqF1C6wgoTnPLKAriq4V/6eIKMknCfmqJQWKtl7vGMUU8EU5L2LxJEK
	 +iuXT1hu07CEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE2A3809A8A;
	Wed, 25 Feb 2026 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/3] ip mptcp monitor: add JSON support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177203700829.400635.9348490829138373346.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 16:30:08 +0000
References: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
In-Reply-To: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 23 Feb 2026 16:28:37 +0100 you wrote:
> With this series, the command 'ip [-t[s]] mptcp monitor' produces an
> output with the JSON format.
> 
> - Patch 1: a small refactoring to uniform the code.
> 
> - Patch 2: add JSON support in print_timestamp() helper.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/3] mptcp: uniform stream closure
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fa0217870a8b
  - [iproute2-next,v2,2/3] utils: timestamp: add JSON support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1fea8c6f3d9b
  - [iproute2-next,v2,3/3] mptcp: monitor: add JSON support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d37b3aed28c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


