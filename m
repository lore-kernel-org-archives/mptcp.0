Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923C25B68C
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187205; cv=none; b=HGasVHt5RqpPM0bb7BMY6RB7MaB5O7bBTT3fG/U8jpJb9+ISQRXYY1BnRiZRy2EN72I4m6xhM/u3CGD464QHLT/p1cite9m9CR5+/B38gZUY0f/SuGx0Y3m0HlTxX72xOc65ub8qgcGCZeMCg7XP8fIRjsx+ry1f0MHRcdFlLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187205; c=relaxed/simple;
	bh=y++kdN5AS/zb7p5PFaqIMDfBwe7Q4srvOc9HH7xzblY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mu8C/xnUl6I1SKNH54fbp6Q7idhVC05hrKeSONYuNV48RIWkeSohZ4i0BXchnhH+JHWWWvrEcmuvqHyTmI3kl+XmYlwx/OHuQftN3FfY8iIScvCeXCH1I19q2CsVMbq8JJUsVMtVpbnOJtlsGsCK99Xqp/kxNMlbZ5XQZuLFZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZC7ikty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZC7ikty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E477AC4CEE3;
	Wed,  9 Apr 2025 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744187205;
	bh=y++kdN5AS/zb7p5PFaqIMDfBwe7Q4srvOc9HH7xzblY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FZC7ikty0GEtLl7zgjc6rdk6SqsgaKX3r5oSuT9v2574P1SLFTOkOqxJCtq8vBc3a
	 xIx5Lkx0ZZQjhYhBO9YIyumjw/PASgJV/JPNmYdtWk6ZuoUmiY4KbAlTqeuQXw7L5O
	 kDwrR/d/OJ+2KAp4EoN/d5DuT5YSiuh88wkzF0AQ7Auu3l+x75kxLGvPE8WdKGcWnO
	 F43m5BCJZNfVqeKiCzAjBOXUMT4X5W1/cjifvAl8B9pl1Tc6hUWYj9XK7drwPbFbhA
	 tbXQea4A1fJ+OthUb/8S3zxH1egW145FiXAMTGy2WMK51+BQioBzeoRg1IYyvxXYRx
	 EmzsF9ZqydAxg==
Message-ID: <b7eb84ea-97c8-4a00-8a91-8d36a82f8563@kernel.org>
Date: Wed, 9 Apr 2025 10:26:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [Patch, v2, 2/2] BCC: python: add a useful tool for mptcp
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1744182834.git.yangang@kylinos.cn>
 <cde026e8afeec48569765f7590ee0ca8fd14b57f.1744182834.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cde026e8afeec48569765f7590ee0ca8fd14b57f.1744182834.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 09/04/2025 09:17, Gang Yan wrote:
> Multipath TCP (MPTCP) is an extension of the standard TCP protocol
> that allows a single transport connection to use multiple network
> interfaces or paths. MPTCP is useful for applications like bandwidth
> aggregation, failover, and more resilient connections.
> 
> Linux kernel starts to support MPTCP since v5.6, this patch provides
> a method which can easily force applications use MPTCP socket without
> modifing its code.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/mptcpify.py  | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  tools/mptcpify.txt | 22 +++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 tools/mptcpify.py
>  create mode 100644 tools/mptcpify.txt
> 
> diff --git a/tools/mptcpify.py b/tools/mptcpify.py
> new file mode 100644
> index 00000000..efdbd910
> --- /dev/null
> +++ b/tools/mptcpify.py
> @@ -0,0 +1,80 @@
> +#!/usr/bin/env python
> +#
> +# mptcpify Make the applications to use MPTCP.
> +#           For Linux, uses BCC, eBPF. Embedded C.
> +#
> +# USAGE: mptcpify -t
> +#
> +# Copyright 2025 Kylin Software, Inc.
> +# Licensed under the Apache License, Version 2.0 (the "License")
> +#
> +# 05-Apr-2025   Gang Yan   Created this.
> +
> +import ctypes as ct
> +import argparse
> +import signal
> +import time
> +
> +from bcc import BPF
> +
> +#arguments
> +parser = argparse.ArgumentParser(
> +         description="mptcpify try to force applications to use MPTCP instead of TCP")
> +parser.add_argument("-t", "--targets", required=True, type=str,
> +                    help="use ',' for multi targets, eg: 'iperf3,rsync'")

If it is easy for you to have this argument optional, don't hesitate to
add this support: I think it will be useful to have this mode
"everything is forced to use MPTCP".

(...)

> +b = BPF(text=prog)
> +b.attach_fmod_ret("update_socket_protocol")
> +
> +support_apps = b.get_table("support_apps")
> +for i in args_list:
> +    app = i.encode()
> +    name = app_name()
> +    name.str = app[:TASK_COMM_LEN-1].ljust(TASK_COMM_LEN, b'\0')
> +    support_apps[name] = ct.c_uint32(1)
> +
> +print("MPTCP is been forced for ", args_list);

Detail: maybe better with "is being forced".

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

