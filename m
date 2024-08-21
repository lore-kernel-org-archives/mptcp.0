Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8B16A92C
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237566; cv=none; b=QaoSiO5mvUE3MoYGPf3QrVTLYcM+C1J/To1OHBLTHFpwBK6PlbvHrT3A44Z7BfCMkG2J8GYllUsGO+4YzrKZ23Puv14DA/bo7IFdpx927YRGrkMXQ/NPAPpALfr5h9Jlj1enA+vhwefvChSSl74DMGvKxfCKZR4eA913cDbUjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237566; c=relaxed/simple;
	bh=OgLX1jwuU6ZpEFNfGKRBbpx3nVKoAzLdeAiJCHnNUWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRnJO9+3ayjJ/Yy2b16BNVeCcvF8vlS4kfd7LclybZ0VxqpmuEwAh53NpRZn1eQGmcOj9V2JtNmHk7wacAvByQwjG1n6ZT/8913/Ev5FMVhHz4z4P5WfaRtGCEzIycuyAns7bRvZdKBPlrry502+USKjmHzxxhDReggqVQZ6pME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBETKSLF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBETKSLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DA6C32782;
	Wed, 21 Aug 2024 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724237566;
	bh=OgLX1jwuU6ZpEFNfGKRBbpx3nVKoAzLdeAiJCHnNUWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gBETKSLFI8bP2JjdxoA3029BDqvD+iq3uMB6cUAQ0E506TSYU7kamE227yCpwTMY5
	 UE4+5BH+126Qdb85pQ0Dc4VVv9durzqQ3Zn3CNS9Qtwn8DEOQuTWr47cRYqTSN6tjE
	 P21tNe7di/w5UkV9e/THVKnviBLIo4vDvYUzUi2rwV/k3UoSUfkesrYBPsxnfvhZ6T
	 Khtffy7wEoBnt9D8Ili4aSGD3bj8ht657MJrTOygaN47AhXakmgXv08866xZPtOWJq
	 Ghy6RK1A3HWfvg0wQlafvytXYGU0RcB1biFfqv6Zra518udB9/7c0qw6ozk/YM/TD5
	 1tNrhLYfxPdgw==
Message-ID: <57a55f3a-3214-49f2-a7ce-73a13ef24173@kernel.org>
Date: Wed, 21 Aug 2024 12:52:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] bpf: Allow error injection for
 update_socket_protocol
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
References: <tencent_48C13AF02833651C8CEA9329191D76628207@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_48C13AF02833651C8CEA9329191D76628207@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang, Geliang,

On 21/08/2024 04:35, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> The "update_socket_protocol" interface is designed to empower user space
> with the capability to customize and modify socket protocols leveraging
> BPF methods. Currently, it has only granted the fmod_ret permission,
> allowing for modifications to return values. We are extending the
> permissions further by 'ALLOW_ERROR_INJECTION', thereby facilitating
> the development of user-space programs with enhanced flexibility and
> convenience.
> 
> When we attempt to modify the return value of "update_socket_protocol"
> to "IPPROTO_MPTCP" using the below code based on the BCC tool:
> 
> '''
> int kprobe__update_socket_protocol(void* ctx)
> {
>     ...
>     bpf_override_return(ctx,IPPROTO_MPTCP);
>     ...
> }
> '''
> 
> But an error occurs:
> 
> '''
> ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
> Traceback (most recent call last):
>   File "/media/yangang/work/Code/BCC/test.py", line 27, in <module>
>     b = BPF(text=prog)
>         ^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 487, \
>                   in __init__ self._trace_autoload()
>   File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 1466, \
>                   in _trace_autoload self.attach_kprobe(
>   File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 855,\
>                   in attach_kprobe
>     raise Exception("Failed to attach BPF program %s to kprobe %s"
> Exception: Failed to attach BPF program b'kprobe__update_socket_protocol' \
>   to kprobe b'update_socket_protocol', it's not traceable \
>   (either non-existing, inlined, or marked as "notrace")
> '''

Thank you for this patch and this explanation!

The modification looks good to me, but this should be accepted by BPF
and netdev maintainers, more than us, I think.

Do you mind sending this directly to netdev with the BPF ML in CC please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

