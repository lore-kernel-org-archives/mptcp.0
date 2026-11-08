Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123447;
	b=lxjugtFxY9LDvFiEa8BfqRhMqfchf2Jo0Yq/8jooJPEhB8T70r+qyiWfPbqYDPbiUtO2
	 9kx0LDHUk+yc/hVmRdjSsZTOa1Enh2DZLns1NzWLZ/AiFV8QVc4lyNWIf0JEHV/MM9r1K
	 A63BYVScdjOJzAaToFOCLEC+GKKbjiAP5IjEFoIoMYVob+Bnf8PYZdfGH0hMio7Xc7UUq
	 pluROtzj5XtueuziL8wTjd7bqu+mg6ZtDIpGiiDoN47447CK1pAjmsRCxNFAIaeX6JZXA
	 hWQZ9v9QSnZz/CdOP2xNvGBwjRjXPlwArFNHmZXwgqeM8eVjU3aDt49JCiBGMsfxHMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123447;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=I58/ssZqNBY6bngZNZOylzHMlxG5RfoxpbTGwDe21/k=;
	b=yPq7jNsXiC7UIlZJiWEY0DKHMwTVIKCJdFR/SWwc6uVLlhmJF2x+7yiF7nTSBZ6iCeVM
	 n0dl4Xy3ORYrJD8S/NFfIMtqgQQh/qCqR1mimJ73yi/Fi/cGxrZy64YH9fRv7Sv7898aX
	 /cec4vZ179W98AYJoSntPkpd87QAuT7L3J4iCvhEThb3DLEHXry6SV5c8p2fLGpDnYgKV
	 TZ7m2MWkLirb+wsrqqt5+2zeMGETEFyG1Bz9LX34Q0E+MCwbBsFEvqD5KSWqrhEJI1CkM
	 Fr4X5Q465q8lMFviWO9fbZSIBgX65XOyY9KfLyE1F2uBxJfA1As13jB35lIlN1dtz8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExCwvvTK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF45606A31C
	for <mptcp@lists.linux.dev>; Sun,  8 Nov 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExCwvvTK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD991F0089F;
	Sun,  8 Nov 2026 07:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123446;
	bh=I58/ssZqNBY6bngZNZOylzHMlxG5RfoxpbTGwDe21/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ExCwvvTKdwWUmyTWqb/pMJ4CarVhyJaowk+/qWk5XaQgz3gHa4ukmdaTFxHiIru5n
	 8AsOBlU3V0nSLKqms2du6F+Ki+EYy9/7INUac7eFney+O6HQoeyfWt90T7E0ucj92q
	 XM0Tz4/AESkHURyLs8LSNoM4bXvqJbsl9lCSofmBIyn96raAWV/CS/dsePJ4fqN+Ft
	 FFzxkiLzNoA/qaKu3kyOPHAtKq7RVdJ4ZNI+00IJd6QkcghY5AYUF5mkuSZigevkzc
	 b+JUUy+ojaN16TPjWWHppG+FCkAIWD1jBxfIvnuY1unYfp/1oETg7vVihLLB4RL0Z8
	 2vR7o6a58jm1w==
Subject:
 Re: [PATCH mptcp-net v23 3/8] mptcp: fix fallback dummy mapping anchor
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 08 Nov 2026 07:37:25 +0000
Message-ID: <179412344574.488855.1655735557250325739@kernel.org>
In-Reply-To: <c16a38cd2bcba22c4a7eac338f3b151306e827f4.1793969127.git.tanggeliang@kylinos.cn>
References: <c16a38cd2bcba22c4a7eac338f3b151306e827f4.1793969127.git.tanggeliang@kylinos.cn>
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

- [Low] The From: and Signed-off-by: email addresses don't match in
  commit "mptcp: fix fallback dummy mapping anchor".

--

mptcp: fix fallback dummy mapping anchor

The fallback dummy mapping in subflow_check_data_avail() now anchors
map_subflow_seq at TCP_SKB_CB(skb)->seq rather than at copied_seq. This
makes it match map_seq, which is already anchored at the DSN of skb->seq.
With both anchored there, mptcp_subflow_get_mapped_dsn() returns the
correct DSN at copied_seq when the queued skb partially overlaps
already-received data.

> Author: Geliang Tang <geliang@kernel.org>

[ ... ]

>     Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
>     Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the only Signed-off-by
address are different:

  Author: Geliang Tang <geliang@kernel.org>
  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

checkpatch.pl reports this as FROM_SIGN_OFF_MISMATCH.

Could you either add a "From: Geliang Tang <tanggeliang@kylinos.cn>" line
at the top of the body so the author matches the sign-off, or add a
Signed-off-by for the geliang@kernel.org address?

Other patches in the same series, such as "mptcp: drop the
mptcp_ooo_try_coalesce() helper" and "mptcp: remove CB offset field",
are signed off as Geliang Tang <geliang@kernel.org>. Should one identity
be used across the whole series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793969127.git.tanggeliang%40kylinos.cn
