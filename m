Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280822B8B0
	for <mptcp@lists.linux.dev>; Mon,  7 Apr 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017002; cv=none; b=XUId4IlReTZm6BYE7JiTcpzJ+eMe9w8UcF0nkgYTSk6lYMUR9iTy2y0BxxEFvlE/SWxCoBAajppEsG76mzZCZtDo+40fEiHdhO2biT3kOEDN76cyJblXmAsVg8LNXLNl//+ZU8WZr0XyJU1S4cS/KOgc0MyF2dMoFI2592R7oKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017002; c=relaxed/simple;
	bh=zSKF7+PUzGdvkyjUOQWXlBq0KQ9TPUqhEUSZz8GJfPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JAXfpKPoZpbkPFJQF3FdKKnng40d4j1CgTyqHhJ6jEzVgk265HGrUqgPoQg311ZLsU7ZQZ/pjSTXqaypLujeB/86VAGIlyKRCDlx0akvOPF9JNugwHTTKn7/UsK6vvACAp27gYS6PI03AwfpYe7cRRyv/2302PuaNQGoR5orjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2YfEiP+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2YfEiP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541B6C4CEDD;
	Mon,  7 Apr 2025 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744017001;
	bh=zSKF7+PUzGdvkyjUOQWXlBq0KQ9TPUqhEUSZz8GJfPs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Y2YfEiP+MthfKK4ehSU9S4OnxMItqO0hEDWk5jIuuk3gVQzdksHh9MKFJ6QAveqrB
	 AtiXRFJJQk32WStX2TsphUy/wQKa23YrKuk0e+F0Yytme+8s/weAGVldKR5mDjI1K1
	 D9+1nB9yevzQGD9eak9u4HNbBVVoiPNH3v2w9dzvvBCnWtAH6mWpzzx9vgaqMPYI5t
	 Nnxo6Cc4zXeTiGpchlXhAtViyJ7O6sqTgKsarxADEgFVz8jUiSfaXGrROCzflRmqgO
	 M8E+YFGAU4+0XfQlQ1ibWknjfIdyAkxuZ6gnpZk3QKUigNC5SYfEUlTAlPVP//OyBh
	 +lpnbTT0aUAfA==
Message-ID: <a4df5346-ecaf-4dda-99ea-9652e2db484c@kernel.org>
Date: Mon, 7 Apr 2025 11:09:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/2] BCC: python: add a useful tool for mptcp
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1743988616.git.yangang@kylinos.cn>
 <df79879bf4e8c5c73ffcc557cdb6f517e29ccae7.1743988616.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <df79879bf4e8c5c73ffcc557cdb6f517e29ccae7.1743988616.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 07/04/2025 04:37, Gang Yan wrote:
> Multipath TCP (MPTCP) is an extension of the standard TCP protocol
> that allows a single transport connection to use multiple network
> interfaces. MPTCP is useful for applications like bandwidth
> aggregation, failover, and more resilient connections.
> 
> Linux kernel starts to support MPTCP since v5.6, this patch provides
> a method which can easily force applications use MPTCP socket without
> modifing its code.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/mptcpboost.py  | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  tools/mptcpboost.txt | 22 ++++++++++++

Small detail: what about re-using the "mptcpify" name

https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/mptcpify.c
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=ddba122428a7

Once applied on BCC side, we could update our website to point to this
program:

  https://www.mptcp.dev/setup.html#force-applications-to-use-mptcp

>  2 files changed, 104 insertions(+)
>  create mode 100644 tools/mptcpboost.py
>  create mode 100644 tools/mptcpboost.txt
> 
> diff --git a/tools/mptcpboost.py b/tools/mptcpboost.py
> new file mode 100644
> index 00000000..0ddd731a
> --- /dev/null
> +++ b/tools/mptcpboost.py
> @@ -0,0 +1,82 @@
> +#!/usr/bin/env python
> +#
> +# mptcpboost Make the applications to use MPTCP.
> +#           For Linux, uses BCC, eBPF. Embedded C.
> +#
> +# USAGE: mptcpboost -t
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
> +         description="mptcpboost try to force applications use MPTCP")

detail: 'to' missing: try to force applications *to* use MPTCP

Maybe clearer if we add 'instead of TCP'?

> +parser.add_argument("-t", "--targets", required=True, type=str,
> +                    help="use ',' for multi targets, eg: 'iperf3,rsync'")

Could it be eventually optional to force all apps from the same CGroup
to use MPTCP instead of TCP?


Another idea is to restrict this transformation to the app passed in
argument, e.g.

  mptcpify -- iperf3 -s

(but can be done later if this makes sense)

> +
> +args_str = parser.parse_args()
> +args_list = [t.strip() for t in args_str.targets.split(',')]
> +
> +if (not BPF.support_fmod_ret()):
> +    print("Your kernel version is too old,"
> +          " fmod_ret method is only support kernel v5.6 and later.")

v5.7?

> +    exit()
> +
> +TASK_COMM_LEN = 18
> +
> +class app_name(ct.Structure):
> +    _fields_ = [("str", ct.c_char * TASK_COMM_LEN)]
> +
> +# define BPF program
> +prog = """
> +#include <linux/net.h>
> +#include <uapi/linux/in.h>
> +#include <linux/string.h>
> +
> +struct app_name {
> +    char name[TASK_COMM_LEN];
> +};
> +
> +BPF_HASH(support_apps, struct app_name);
> +
> +KMOD_RET(update_socket_protocol, int family, int type, int protocol, int ret)
> +{
> +    struct app_name target = {};
> +    bpf_get_current_comm(&target.name, TASK_COMM_LEN);
> +
> +    if ((family == AF_INET || family == AF_INET6) &&
> +        type == SOCK_STREAM &&
> +        (!protocol || protocol ==IPPROTO_TCP) &&

detail: space missing after '=='

> +        support_apps.lookup(&target))
> +        return IPPROTO_MPTCP;
> +
> +    return protocol;
> +
> +}
> +
> +"""
> +
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
> +print("MPTCP is been applied in ", args_list);

detail: MPTCP is being forced for:

> +signal.pause()
> +#while(1):
> +#   time.sleep(200)

I guess you can remove the comments.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

