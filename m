Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04125B69C
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187184; cv=none; b=k8A0giGBrbHvNV4/l1h7fNd59YVXLhnHnkQMkP7Z1VQszCxFULM4Ptrn6Ga6tRbTExscYUk4klAsOcAzVZtJ6dbU7fXB/U24JexxlrgYvjSUD3QzUMKGddcupBoaMdcFn54eInoqBF6oBmPfO5lOaXHDJFBHIfWgDQ770kHu6Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187184; c=relaxed/simple;
	bh=GzkaiZj36WRnqPmlXJYG8L3j827VRG6Jeb/G3o7lGSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VZO4uus7MKM32VnNNIDw49vqyDjfkL6fxzbwYdX+R5K1Arp8NQB8Pw7QTS2dfuq1T/kd/L26/yaTReSIe5ajrjNZdjm/kc7B3eFqgEvHmrXNjRfxH8dY5/HjMwCxHsk7D6NUf7aXvwy+hIw5vrYdVwFbRmFrs76Dd2ra+mRFMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZIlEP64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZIlEP64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6752AC4CEE7;
	Wed,  9 Apr 2025 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744187183;
	bh=GzkaiZj36WRnqPmlXJYG8L3j827VRG6Jeb/G3o7lGSs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DZIlEP64KqRQDhsSxfS+7WCNQHvqGLqZOqK/fld3493SIxOM1n8AI11ztrosZCOrO
	 yrpXv0tu4KeWC+bPgAeajgxA96YieyF9MHdskmXi/No9L9+wvLuNIIHS6bSBgMPoGN
	 sx/mhYsenyBG+RSxmCkWD+ZoFBESPlBSRC2JDioCJ+CvKcZvvlBqgPpmJ3WANonInH
	 FXFNPpbn6J4u0bCs1iVnvK6JZ/FcWgK1sB2qzviFzEi2tm4AVUGxMMToNmMM8Rnqsc
	 WkpB5R52JWjuB2TYA9XuEvGPAPurfIhC7FkGb+Q4VdFbGg4TzSCt7ZWKii+98WiU6p
	 jwlEn6ksRFMGQ==
Message-ID: <1d6bceea-daae-49b5-918f-60df35b0791f@kernel.org>
Date: Wed, 9 Apr 2025 10:26:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [Patch, v2, 1/2] BCC: Python: Support 'fmod_ret' method for eBPF
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1744182834.git.yangang@kylinos.cn>
 <224f2b589ffd6e6f5aa42a213f5f6410c21f9dcf.1744182834.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <224f2b589ffd6e6f5aa42a213f5f6410c21f9dcf.1744182834.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 09/04/2025 09:17, Gang Yan wrote:
> In kernel, there exists a lot of 'fmod_ret' functions, such as
> 'update_socket_protocol'. But it cannot attached in BCC-python directly,
> so this patch provides an interface for python to use 'fmod_ret'
> attaching method.
> 
> But there exists a question about how to check 'fmod_ret' support in
> kernel, do you have any suggestion? I already considered checking the
> kernel version which seems not suitable.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  src/python/bcc/__init__.py | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/src/python/bcc/__init__.py b/src/python/bcc/__init__.py
> index 8bc85516..12ce3ef6 100644
> --- a/src/python/bcc/__init__.py
> +++ b/src/python/bcc/__init__.py

(...)

> @@ -1189,6 +1205,22 @@ class BPF(object):
>          self.kfunc_entry_fds[fn_name] = fd
>          return self
>  
> +    def attach_fmod_ret(self, fn_name=b""):
> +        fn_name = _assert_is_bytes(fn_name)
> +        fn_name = BPF.add_prefix(b"kmod_ret__", fn_name)
> +
> +        if fn_name in self.fmod_ret_fds:
> +            raise Exception("Fmod_ret func %s has been attached" % fn_name)
Detail: maybe clearer with this:

  "Fmod_ret func %s is already attached"

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

