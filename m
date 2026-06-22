Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFA34028B
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149869; cv=none; b=gUEpiEL9Pgd3Cc0vi0YJyIxWmKwiXhgpxmp1wexMBpWgaeXv2wkvm+CHdqaE8YkrTXroizCZHJR1dGeusjPMQliYH1g0YlybVF8vaWZmFhup4hU/4hSoEWAKHYQOsmm5CXrsO+GaW9bqPq0EYGybXNqR76I11vDYCLkzVw4TaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149869; c=relaxed/simple;
	bh=sAZwzcnK0cMoZ/EQDdtP3dxJFvuj3lwWPyTfYtmfMaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeobXlPREg0qDRgjeND29WJnImThpTs4bioCjdR0hNQTtddlTx3xQZBb4vasK/TlHzwq/P3Wb3sQ42rgR8G/SP902lPMQ/3JalVRhNmvQ5tFBN+9zSrHpb/Vdk0J/5myIOrj2q5W5dWJY8+pwJT/7ccANyX21nlSizRyoTvkYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GikRI6Bb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GikRI6Bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874E11F000E9;
	Mon, 22 Jun 2026 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149868;
	bh=5iKepNHhNEF+2mG9YfoDzhk9K8e0qF4v5bL/THkt7ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GikRI6BbcrLLZ2a5JSo8kju/4nbUP9x2VLy28AA48GgE3t4WN4mJkJ98vRaYAN2rx
	 bQl9Maio+gJkJ0E9UUK4LrgM1bnqg1i8BOzA6y5ui9tfe6PfPdAvwxAGgJdv0jt2bz
	 82L6gJsEBWmpdgX+Ay/ffiNQG+vzDEgur8GY/HyhoUpicPoiU52DALImZSlrIIEhvT
	 vxyA5mFeD3NF111fTpEix0eaQr1GrAICuV7TcLav8jUVKAQ4gBa5D9Upioe991UNN9
	 mcH7h0WJddezAGfMFtoNi4IubBSB4bmfmC2mrI66Bg+J0cYsZSLuwDnA0Xjt5FYW2F
	 POpR2Kvknyurg==
Message-ID: <b0dccb83-b9de-4207-9132-f3944bc3d5e6@kernel.org>
Date: Mon, 22 Jun 2026 19:37:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] mptcp: pm: fix memory leak from
 alloc-during-teardown race
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 pabeni@redhat.com, kalpan.jani@mpiricsoftware.com, janak@mpiric.us,
 shardulsb08@gmail.com
References: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
 <20260620084424.3072634-3-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260620084424.3072634-3-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

Thank you for the v4!

(Note: please make sure to keep the version in the prefix -- b4 does
that for you automatically ;) -- to help with the patch tracking)

On 20/06/2026 10:44, Shardul Bankar wrote:
> mptcp_pm_destroy() empties msk->pm.anno_list and
> msk->pm.userspace_pm_local_addr_list under msk->pm.lock during socket
> teardown, dropping the lock between the two.
> 
> A concurrent userspace PM genl ANNOUNCE on the same msk holds a sock
> reference via mptcp_token_get_sock() and, in
> mptcp_pm_nl_announce_doit(), calls
> mptcp_userspace_pm_append_new_local_addr() and
> mptcp_pm_announced_alloc(). Both take msk->pm.lock briefly to add to
> their respective lists. Because the genl handler holds a sock reference,
> mptcp_pm_destroy() may run on the same msk via mptcp_disconnect(), which
> invokes mptcp_destroy_common() without dropping the sock refcount,
> before the handler completes.

Sashiko seems to say [1] that the mptcp_disconnect() path is not covered
(when 'shutdown()' then 'connect()' is called from the userspace), but
it looks like that's what you are covering it. Just to be sure: is it a
false positive? (I didn't check the different code path to see if that's
possible)

[1]
https://sashiko.dev/#/patchset/20260620084424.3072634-1-shardul.b%40mpiricsoftware.com?part=2

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

