Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D2431484
	for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383599; cv=none; b=XT6yWLfdl/L5GODuRMMoZCw77XDNRVGlTTHex+ugQF3I5POg7biYjWR8vz14jrsuIbKm+eGqpAOXdFC8thCtE1OUGvPVbdAWZf4ERZVmn6u/4iFqpn7Rf9rwfmfHSl1Eo9TFsZc/JFdwJILcd7rsEa+98hS2aNjvRVRvJThGXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383599; c=relaxed/simple;
	bh=m0HuI9k8dTTkyPYsV8F6wzFlY+vpExjE37g+DmQedIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcFZrzHiOsaynDR1uudcJo+XfgckZKYi0R5bOMqiJk69CECCABt/yhxuGc0SdNErU5bl60DXdkpx+k2liugMVcKP0Wh9muxyqVFAbc1fQlmn4jYDxgwpH1mlaEvCY4CBKg4UvAcHGDrpUQaeIa0GsbzevArbEIz5zo2pT3AEdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi2U1oUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi2U1oUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8D51F000E9;
	Mon, 10 Aug 2026 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786383598;
	bh=R10Dq4Mnt3UkadX2F5m9HK9FF5TCYXf2tHXFxOJjXIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vi2U1oUnsB0MfMYo2p1oSLNz7rqB2IsSOEs9X7dh10gEoMT64GaL0qGSXRXWX/yYr
	 cHR3gP5MfzwKv+J8OPUPgLa/8aSU7HaDDPqFRVzEvWtFayJIdhytp+MS4ykjaY6UER
	 D6QFG4LaLpVoVKUDjGC/6vH+WpTFsQCm5S4OQkdJChkNE9a/SGRSHmUiqHJeF/opQ5
	 Hoa6AwmcSgzWp8GW9I4xgN7e0bs+BsGR1Ic7j2hj8cPqw/ACA/TSkPPKdfz2qbR/7o
	 ljE2XplglcaZyiplztQed1SkciCCf04XGqiQpiY/evmRYtRKO42iok4oSOX3x/J/GY
	 zB4fsxg3jpsSw==
Message-ID: <05693030-fe2c-4eed-8ed1-fb60da3273f7@kernel.org>
Date: Mon, 10 Aug 2026 19:39:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: userspace: unify entry free path
 via RCU callback
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 01/07/2026 08:11, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In mptcp_pm_nl_remove_doit(), sk_omem_alloc is decremented immediately
> but the memory is freed later via kfree_rcu(). This allows a CAP_NET_ADMIN
> user to bypass the socket memory quota and exhaust kernel memory by
> accumulating RCU callbacks.
> 
> Fix by using call_rcu() with a custom callback that uses sock_kfree_s()
> to free the entry and decrement sk_omem_alloc atomically. To ensure the
> socket remains valid until the callback runs, take a reference with
> sock_hold() when storing the socket pointer in the entry, and release it
> with sock_put() in the callback.
> 
> Convert the synchronous freeing paths in free_local_addr_list() and
> delete_local_addr() to use the same RCU callback, ensuring the socket
> reference is properly released.
> 
> Additionally, mptcp_userspace_pm_append_new_local_addr() now checks
> SOCK_DEAD under the spinlock before allocating. A SYN+JOIN handler
> holding an msk reference from mptcp_token_get_sock() could otherwise
> race with __mptcp_destroy_sock() - sock_orphan() sets SOCK_DEAD and
> then mptcp_userspace_pm_release() clears the list, so a new entry
> allocated after that point would never be freed and its sock_hold()
> would leak the msk permanently.

Thank you for this patch, and your patience!

It looks OK to me, but TBH, I'm not confident enough to judge if this is
the best way to address this issue, plus if this issue mentioned by
Sashiko [1] can really be observed. By chance, do you have any
reproducer for the original issue?

@Mat: WDYT?

Also, after "mptcp: pm: userspace: properly handle the ID0 case" [2], I
guess we will need a sock_hold() in mptcp_pm_userspace_created as well.

[1]
https://sashiko.dev/#/patchset/cover.1782457962.git.tanggeliang@kylinos.cn
[2]
https://lore.kernel.org/20260807-mptcp-pm-userspace-id0-case-v3-1-de9088549924@kernel.org

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

