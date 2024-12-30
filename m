Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413219ABA3
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735576082; cv=none; b=uIGUX6N+/6ypzeMtpDjP+SKTAw5kVw0OtTyPBTFhHzXO3Oa0OF69mB+Jv8DSjH+G08QUqQpLUcgMuST1+GiU/pEa3W7Ivv1LLfUYWn8tKuuVuOWelf9w5+Ds5EFRiNMfFECk+ZXW6TkxbVCO/cyjQ40XMJ7rXwj6VyQWdpZxDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735576082; c=relaxed/simple;
	bh=HKEHsiWakgs9ry0L2mIneLSxvyPjWQrUvxvJdx56F0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUm9MzqcEJTD0rtVQ8KOZZWzW8fa0SgQabwDaUYct2f+Qs7g0tjZSdsFb11ZcHpJ+4eKGYdaeZDQHu7pvO0ocRkPysMDjQVw7rq/bMIT5l3/+BLhpLvkOyoAj10Ruq45qR4TloUpwlijzkQPnP49s12GjArOwWmxFBYl3M9M6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWgrqKP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWgrqKP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC65C4CED0;
	Mon, 30 Dec 2024 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735576081;
	bh=HKEHsiWakgs9ry0L2mIneLSxvyPjWQrUvxvJdx56F0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YWgrqKP4eoXSkAV67ykg568d8aK5HhRPK2K3xZEYcxPGvAFFzC/e6w2ZJ0D46R8Eg
	 AusoV7ymuvmj3NlGkiFXq/iRg+WNtWqHgVVoJy4P8CY0L+yqgfrBrG52Ab04TWmxBu
	 m42rDDhVdNNMF9aVc168ZMTlUmnPbobmQaL0u+5Js1EGyzFYTuM3xCi0lD8MZ+D4ea
	 lKErme5ghvNcrTC11h1GqUChJFBl1YA9yGnj+G354Vg8HC4MHhGLUgAEjLOzK3prqj
	 7+eRyEPpljKVOneg1qf7edj4yLyZ2HVZl182esa7XJGGGjcU/VfS6xtyxXwN940HJW
	 IiPh+5POpCL2g==
Message-ID: <c6a051fe-6fdc-49a4-aeaf-5defafaa0a7b@kernel.org>
Date: Mon, 30 Dec 2024 17:27:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 0/8] BPF path manager, part 2
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1734074788.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/12/2024 08:35, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v2:
>  - split patch 7 of v1 into two.
>  - patches 1-6 have no code changes, only the commit logs have been
> updated.
>  - more commit log to explain why mptcp_pm_addr_id_bitmap_t needs to
> be defined.
>  - use mptcp_pm_addr_id_bitmap_t in userspace_pm_append_new_local_addr
> too.

Sorry for the delay: I was waiting for the CI to do the validation, but
somehow, it didn't even start. An issue on Patchew side apparently:

  https://patchew.org/MPTCP/cover.1734074788.git.tanggeliang@kylinos.cn/

The 6 first patches look good to me (just one small thing, and a rebase
might be needed).

It is unclear to me if we need the 2 last patches. Maybe patch 7/8 is
needed for the BPF path-manager? Not even sure, please see below.

Regarding patch 8/8, it looks like it introduces new issues, and solving
them increases the complexity, and I don't think it is worth saving a
bit of duplicated code there. WDYT?

> In order to implement BPF userspace path manager, it is necessary to
> unify the interfaces of the path manager. This set updates get_addr()
> and dump_addr() interfaces.
The modifications you are proposing here makes sense. Now, regarding the
BPF path-manager, to me, they don't really need to implement get_addr()
and dump_addr() because these interfaces are only useful for the userspace:

- with the in-kernel PM, it is useful to list the different endpoints to
be able to change the configuration if needed (or to check how endpoints
got configured).

- with the userspace one, it can be useful to retrieve addresses when
the daemon got restarted, to get info about previously created connections.

- with the BPF PM, I'm not sure if there is really a need to dump
addresses to the userspace. Or do you see a case where these interfaces
can be useful? I guess BPF PMs will be configured via BPF, and if there
is a need, the addresses can also be dumped via BPF, but I don't see the
point of exporting them via Netlink.

Maybe there is no need to do much around these interfaces, and the last
two patches can be dropped? Or maybe mptcp_pm_addr_id_bitmap_t can be
defined in protocol.h instead of in include/net/mptcp.h?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

