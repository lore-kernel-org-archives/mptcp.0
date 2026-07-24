Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15136385D87
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918917; cv=none; b=dU7zZpLFekA0yKPRc2px8JeNyBG3QjZmgDgr6dDtEIKlioGzNFEwIT76HM1j3ai5OmLxn+4o9moRkMUlc4NNvlMeZVkmRWWEhnq1059m0RkP4uPARePkRAxerTuSeF3r+svSow2MKqf6l/FunEYyFxWSWqtMCtu9jwTfgAVA294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918917; c=relaxed/simple;
	bh=vLyM/nWrXP9rpv5P1x0VUI55x8VjMwT1zYVp/Q3fi/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lW8BAKqtIEWiF5tZARAhU4Lq3jbqJy0Co/RS+T7982G089ppdOc6q15qob7sRup0cEiQJDGOxfcg9JiLjM9J+i9Wp7oR0CNetuAdaCJ4KxiBUrtwnVs63PrOGlRRJFHS7YfVjfTTztIRPoXSPqGe1xyINKaUGPnhxE3MooXXQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq5B7gGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq5B7gGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89221F000E9;
	Fri, 24 Jul 2026 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784918915;
	bh=84TmnsWJs3P1bIX+C1bPAVbZplPke4MkzwyxZooisis=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qq5B7gGt7VN05W8GcmhOsqL97MwBjibOr4GS/UVaXyww6ORIm0fHdFz8EnCImPoGn
	 5Kvl51HDVmIdPGtIeWMZPVgwsKfAw36crZWauLA+lgwwj4DVuEjfSIA3GcYvLvv9bw
	 nWtLcJAwdB+sH7IW3h6bTHIi6nB+eph6nAn0I5KBfKnhBsWVvBXCpSTpIdrcfAOcFW
	 o7lhpffaqxG/jZ+sQ7Dvnan0SHMj0ORP3Cv2GvTYfJI/GJm6tM+K1A2YXeUe5W+84Y
	 V0keKShmtgLzx8+7NV4NhHASO09VLZ68w1CNRE907JwOOHL/kAfTj391wbcJsK0RgN
	 lYf9kxey+/DXQ==
Message-ID: <4da53292-aa11-45be-ac7f-11afcfb278a1@kernel.org>
Date: Fri, 24 Jul 2026 20:48:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 1/3] mptcp: pm: userspace: drop
 delete_local_addr helper
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1782513313.git.tanggeliang@kylinos.cn>
 <0d2025431ba1b2a34da3a1747880d7b23779cf76.1782513313.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0d2025431ba1b2a34da3a1747880d7b23779cf76.1782513313.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 27/06/2026 00:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Address entries should not be removed from local_addr_list when a subflow
> is deleted by the userspace PM, should only be removed when sending a
> REMOVE_ADDR.
> 
> So mptcp_userspace_pm_delete_local_addr() helper shouldn't be called in
> mptcp_pm_nl_subflow_create_doit() and mptcp_pm_nl_subflow_destroy_doit().
> 
> Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it can be
> dropped now.
> 
> Address entries are removed from local_addr_list when sending a REMOVE_ADDR
> by the userspace PM, the local_addr_used counter of PM should also be
> decremented accordingly.

I was re-reviewing this series after having read the comments from Sashiko:

https://sashiko.dev/#/patchset/cover.1782513313.git.tanggeliang@kylinos.cn

I think the series is correct, but it feels like additional fixes are
required:

- msk->pm.userspace_pm_local_addr_list doesn't contain an entry for the
ID0 when initialised
  - That's probably fine, but then it means the ID0 case needs to be
handled separately, like it is with the in-kernel PM.
  - Or maybe easier to add it when the userspace PM is used, to avoid
all these exceptions?
    - If yes, then the remove_doit should no longer handle the ID0
differently as well.
    - same for announce_doit?
    - maybe better to do that to avoid all these exceptions?

- When creating a subflow with ID0, an entry can be added to the list
(to be checked)
  - If the ID0 is not added at init time, then an exception should be
added there
  - (also there is a check to avoid announcing ID0 → I think it is valid
to re-announce the ID0 if this address is no longer used, an exception
should be added there too, no?)

- each time the list is traversed, it doesn't take into account the ID0
case:
  - If the ID0 is not added at init time, then an extra check should be
added there

WDYT?

If yes, maybe this kind of patch can help? (not tested)

  https://github.com/matttbe/mptcp_net-next/commit/e03ee2728e98

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

