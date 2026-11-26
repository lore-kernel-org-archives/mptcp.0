Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725841;
	b=q31qMI/WRllY0dGp41fc1BYjwbsATESkDOipde31FxJh/Zj96giiP2grWWO1EtTOxxyn
	 htw01Kt83Qm3Z3RNsG6hFs+KDWzm0sZVHBuBoubmd4F4lw7Yk5XPfnkEoOAtJkDvpuk9E
	 c2OrEslwBbpwGcczTHSVicvxEz4CbJauZYe31Rnhc2H/6GPOouUJYH9x+s1CvrUulcXc6
	 4sJ69Lncqsfc15GbyppN/AQJP96ATy7TKWEWWSqmMp0Oc3JP/0CjiBvDhoWIBatbjgnrl
	 HixZd6VFTkbvu5kJI6iN37rZpVJ1jOiWi+f8g/zHYkd6O7Z14bYiYwisS2sELWMTukw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725841;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N8FdICBFqsBvJCqoln3G1UyJ/OXhtK4yDYC5Ebbokhs=;
	b=i/2ucJ7W7xJg02A7O3t/xHdB/+sQBEziNdAa6RvtFaIyeoIgvjJ7L2qORYDUhyeijlTm
	 Euj0NLU1+dzRI0zb4GH6W4wvr2jEY1I58rt2UIuORE5lnKgfLQDiXEGh18h8LRdYdQ7kn
	 e6UZ8cVSngKckhYYATBYovfOyL7sWeXsvr27S/JxH9dXTfB9KfTAoKRHdQq1MoZpQKX+P
	 Vh4iGAYImzG2KxnL/mu9ilcECl5D4y3JBokfClcfNkylJSrYmyolwwDmXiLSNFE4ed+yH
	 uM6vOyvnZ/QYZcknib2pk5d/bdb4aMbGhUdiaVZ8At6LJDydZYpZWXui54VviVDoMcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sd9ZCdq7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD752606A6A7
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sd9ZCdq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3231F000C1;
	Thu, 26 Nov 2026 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725841;
	bh=N8FdICBFqsBvJCqoln3G1UyJ/OXhtK4yDYC5Ebbokhs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sd9ZCdq7ZPI8GUMkaVq4HL3JYdOWvkFerriP0NaB2svYZanhamzM1H5cnkOcv9Z1D
	 upDxQBYd0Iidg6KFxoWbS53LGxDs65JreZuAF4z3Va/s8ENOymMFpxufPwExHDA4Nz
	 sX7PCRbDajucCmp2ocgmYFyN4dM/ErruHV5liT9EVJ3HSDK7VTo6Ebz4IgyUaY13a6
	 QH7clWvB/5Z6doa2ulMvdWftjJt31M4KCA8p2p9XghUDKVmNSEc4gysAvTzNNW5LzC
	 jGcx/8nK4kEeas0XAsAM8mMmVmJGKAk5cuD5akfFFx27UUm3TKd9YRE/UQiC5Irbaq
	 5Xs08US+N2H+g==
Subject:
 Re: [PATCH mptcp-next v9 1/7] mptcp: use local variable tp in sendmsg_frag
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 20:44:00 +0000
Message-ID: <179572584070.3133.13336174201368005732@kernel.org>
In-Reply-To: <d78ad0fbee64b4495d852c1676614c25330357f5.1795591278.git.tanggeliang@kylinos.cn>
References: <d78ad0fbee64b4495d852c1676614c25330357f5.1795591278.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The From:/Signed-off-by: email addresses do not match.

--

mptcp: use local variable tp in sendmsg_frag

This commit adds a local variable tp to hold tcp_sk(ssk) in
mptcp_sendmsg_frag() in net/mptcp/protocol.c. It then uses tp for the
tcp_mark_push() calls and the write_seq update. No functional change is
intended.

> Author: Geliang Tang <geliang@kernel.org>

[ ... ]

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the From: and Signed-off-by: email addresses don't
match. The author is geliang@kernel.org, and the only sign-off uses
tanggeliang@kylinos.cn.

The .mailmap file maps both addresses to the same person:

    Geliang Tang <geliang@kernel.org> <tanggeliang@kylinos.cn>

The author sign-off check in scripts/checkpatch.pl does not read
.mailmap, so it still warns:

    WARN("FROM_SIGN_OFF_MISMATCH",
         "From:/Signed-off-by: email address mismatch: $sob_msg\n");

The netdev patchwork CI will probably flag this too.

Could the author be set to the kylinos.cn address, or could a
Signed-off-by with the kernel.org address be added?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795591278.git.tanggeliang%40kylinos.cn
