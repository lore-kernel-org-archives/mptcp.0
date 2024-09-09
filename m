Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AB13AF9
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891732; cv=none; b=iADdRLwcY5yUrNn9Cx3Mf+4hfLj76l7t8qz63UWZssUQKcehFRdAXEvljFrdRxBs5PLz9FqZcsGavFx5TE72TLj0SYi5Ib6z3W+bEjdI4N4ai/N7/BA9FGY82u6m3N+CVHse5cBK8l9f/kW8rAQxsf0lfRO7a3pvU1GSRo6E74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891732; c=relaxed/simple;
	bh=QPuHabZp6gpSKxZQHR8en0iGP2Yuh72a0rZdbO0b+F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AO1kG+YbKdwySTW7coWCjrUJa16pVXGuYSxg1wjbhipM3Kz7ct++GVfIvJARRHkFL+GfOTRt8lJ9hapvSgp0gZeJkeTeYtVoLzDKzvTMVgIpPYUx4g4jAC9G1ZHumofJF9ocHfa/Cj6HT19zRMB38Zl3tXJycPuCPx693GRzEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr2bQ1Co; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr2bQ1Co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B232C4CEC7;
	Mon,  9 Sep 2024 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725891732;
	bh=QPuHabZp6gpSKxZQHR8en0iGP2Yuh72a0rZdbO0b+F4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yr2bQ1Co4vWgybr2OBfLxduySU6xMROxAJMmYROJepZR+Q7lIVi5Sfto7D6jwU0r/
	 VseUgL+4JFm5is6OLwGnyIayXjCy6bQNC+rZSP52YA0HKqz8r1lsREf660HiRSiXNd
	 yWFi6ehrY2WIhqBYJIKCI7VdqxEq/SzPEL5BrESU0gs+Ckeawb9TyCk+Y37RIOi7cv
	 17A8sJq3AtL+jlFgDLVjKx9YSl91HLZ+TKWQu/0Qsu0IjinBrJEf/vqpPanGCQdaV8
	 hG7VkYbZO4LdXeWcsadchS67kTknyBwekfl5rdBR8VJfJh3lwL8KqLEvXcFK8fg+CZ
	 OtsvNZulp2K+Q==
Message-ID: <ba918d63-cc5f-4d9e-9c0a-e37af685db4e@kernel.org>
Date: Mon, 9 Sep 2024 16:22:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next] mptcp: Add data race when accessing the
 fully_established of subflow
Content-Language: en-GB
To: gang_yan@foxmail.com, mptcp@lists.linux.dev
Cc: YANGANG <yangang@kylinos.cn>
References: <tencent_604F30643CD92D084CEB0AA3BE951B30C009@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_604F30643CD92D084CEB0AA3BE951B30C009@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang Yan,

On 09/09/2024 03:14, gang_yan@foxmail.com wrote:
> From: YANGANG <yangang@kylinos.cn>
> 
> We introduce the same handling for potential data races with the
> 'fully_established' flag in subflow as previously done for
> msk->fully_established.

Thank you for this patch!

> Additionally, we make a crucial change:  convert the subflow's
> 'fully_established' from 'bit_field' to 'bool' type. This is
> necessary because methods for avoiding data races don't work well
> with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
> the size of the variable being accessed, which is not supported in
> 'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.

Indeed, bitfields cannot be used with READ/WRITE_ONCE.


(I think we can remove the following text from the commit message ...)

>  This change was prompted by compilation errors we encountered,
> as detailed below.
> 
> '''
> READ_ONCE:
> 
>   477 |         (sizeof(t) == sizeof(char) || \
>       |		       ^
> 		 			sizeof(t) == sizeof(short)|| \
> ././include/linux/compiler_types.h:490:23:
> 				note: in definition of macro ‘__compiletime_assert’
>   490 |                 if (!(condition))\
>       |                       ^~~~~~~~~
> ././include/linux/compiler_types.h:510:9:
> 				note: in expansion of macro ‘_compiletime_assert’
>   510 |         _compiletime_assert(condition, msg, \
> 				__compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/rwonce.h:36:9:
> 				note: in expansion of macro ‘compiletime_assert’
>    36 |         compiletime_assert(__native_word(t) ||  \
> 				    sizeof(t) == sizeof(long long),  \
>       |         ^~~~~~~~~~~~~~~~~~
> ./include/asm-generic/rwonce.h:36:28:
> 				note: in expansion of macro ‘__native_word’
>    36 |         compiletime_assert(__native_word(t) || \
>       |				       ^~~~~~~~~~~~~
> 					 sizeof(t) == sizeof(long long),  \
> ./include/asm-generic/rwonce.h:49:9:
> 				note: in expansion of macro ‘compiletime_assert_rwonce_type’
>    49 |         compiletime_assert_rwonce_type(x); \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/mptcp/protocol.h:781:39:
> 				note: in expansion of macro ‘READ_ONCE’
>   781 |         if (subflow->request_join && \
>       |					   !READ_ONCE(subflow->fully_established))
>       |                                       ^~~~~~~~~
> 
> test_bit:
>  error: cannot take address of bit-field 'fully_established'
>    50 |         if (test_bit(1, &sf->fully_established))
>       |
> '''

(... and add a blank line here: I can fix that when applying the patch)

The rest looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

