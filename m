Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C412B71
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BI0pMc0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701248892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxV7zwx5P3shLsAbPcH2ugmzUF1Po9aSTDeKdQgg9OU=;
	b=BI0pMc0U81hut8j7w1pXTjzr2gc5KIcqrLE2JZBKDDoZjzeEWjFKvpKZegm/8qYH3or4y0
	ZK2/ZlQpDN2tsn81cQLk3iUmHf3adAZ4RHs5SVtWdguJH3uWOcriWf54Opo63rfO+SIqtS
	Nk/rRyTqFi8glF2CzAgpHpbl96fcBBU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-sbPuI7W-OsqExp_BV9EEDg-1; Wed, 29 Nov 2023 04:08:10 -0500
X-MC-Unique: sbPuI7W-OsqExp_BV9EEDg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-544f174ccccso525985a12.0
        for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 01:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248889; x=1701853689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vAqL0FYjRrVr29BPqr9AVquQiikVkav3gAAZLHFyc1A=;
        b=srboCqDPiXBbOxWypjHoLhR9nexCqG4PG+gfOcG4snU5d7kmyokgfc+DEh6QfFHQG6
         18Wq9+QoXiXh+8uy7tPrT1ZoUMe5YcC+GTAenznFXNYwpbJddh9/UM7ba7McsNQGY1Ky
         2R+0Mi6Nz2padlD65q2z4JDNII3EihkUaXR0liHQ9Uy850QQXGEHh8w853iwVbRVfO2j
         iCED54roAh2aRAM/itbjvbuPBF/JhDDI1ildMN26+LJ5CBWe6RWJcpUKWs8VVg0fT2lQ
         1uEqgt/TZ2dhIAIGujpQdmjOZVWwyxR/OFCzh2KGNAgLBPKZoLOiOyxmHYcZ16rZ4CCu
         PabQ==
X-Gm-Message-State: AOJu0YwTPprvXy67JuDg9gxiIoufoljY2OIL4gTs3TkGu8okuBd5PH33
	dWiToIiaqEs+13h2Gda32j9NjZQ0eAGuyDWpwKuf+KHULYgJyPD3KVPUNV6aLXtpR9YC5z5BYSN
	oPbtcyne2+E4x279V0iXHNLM=
X-Received: by 2002:a05:6402:1d4b:b0:546:efd8:7f05 with SMTP id dz11-20020a0564021d4b00b00546efd87f05mr13549191edb.1.1701248888857;
        Wed, 29 Nov 2023 01:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6whtXQ/L0fEaRDaAjwa/aNzzeggZJmtDYwcFvvSJHAKZoyWLbs4EpLru5dmZHU3nR9WizGQ==
X-Received: by 2002:a05:6402:1d4b:b0:546:efd8:7f05 with SMTP id dz11-20020a0564021d4b00b00546efd87f05mr13549169edb.1.1701248888433;
        Wed, 29 Nov 2023 01:08:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-93.dyn.eolo.it. [146.241.245.93])
        by smtp.gmail.com with ESMTPSA id j12-20020a05640211cc00b0054b1e553268sm4949250edw.57.2023.11.29.01.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:08:07 -0800 (PST)
Message-ID: <17c718e88009e0731dd4172f6f73aa9d7010cf51.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 3/4] mptcp: add a ftrace callback for
 tcp_set_state
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 29 Nov 2023 10:08:06 +0100
In-Reply-To: <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>
References: <cover.1701230012.git.geliang.tang@suse.com>
	 <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-11-29 at 12:08 +0800, Geliang Tang wrote:
> This patch adds a new function mptcp_check_state(), in it if switch from
> or to ESTABLISH state, increment or decrement the newly added counter
> MPTCP_MIB_CURRESTAB.
>=20
> Instead of invoking mptcp_check_state() in tcp_set_state() directly, here
> add a new file trace.c, in it use ftrace to hook a callback function to
> tcp_set_state(), named mptcp_state_callback(). mptcp_check_state() is
> invoked in the callback function.
>=20
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/Makefile |  1 +
>  net/mptcp/trace.c  | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 net/mptcp/trace.c
>=20
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 67cd565bb321..bf88bdb222b3 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -14,3 +14,4 @@ mptcp_token_test-objs :=3D token_test.o
>  obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test=
.o
> =20
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf.o
> +obj-$(CONFIG_FUNCTION_TRACER) +=3D trace.o
> diff --git a/net/mptcp/trace.c b/net/mptcp/trace.c
> new file mode 100644
> index 000000000000..7dc33ff88813
> --- /dev/null
> +++ b/net/mptcp/trace.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Multipath TCP
> + *
> + * Copyright (c) 2023, SUSE.
> + */
> +
> +#define pr_fmt(fmt) "MPTCP: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/ftrace.h>
> +#include <net/sock.h>
> +#include <net/mptcp.h>
> +#include "protocol.h"
> +#include "mib.h"
> +
> +static void mptcp_check_state(struct sock *sk, int oldstate, int state)
> +{
> +=09switch (state) {
> +=09case TCP_ESTABLISHED:
> +=09=09if (oldstate !=3D TCP_ESTABLISHED)
> +=09=09=09MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
> +=09=09break;
> +
> +=09default:
> +=09=09if (oldstate =3D=3D TCP_ESTABLISHED)
> +=09=09=09MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
> +=09}
> +}
> +
> +static void mptcp_state_callback(unsigned long ip,
> +=09=09=09=09 unsigned long parent_ip,
> +=09=09=09=09 struct ftrace_ops *op,
> +=09=09=09=09 struct ftrace_regs *fregs)
> +{
> +=09int oldstate, state;
> +=09struct sock *sk;
> +
> +=09sk =3D (struct sock *)ftrace_regs_get_argument(fregs, 0);
> +=09if (!sk)
> +=09=09return;
> +
> +=09oldstate =3D sk->sk_state;
> +=09state =3D (int)ftrace_regs_get_argument(fregs, 1);
> +
> +=09if (sk_is_mptcp(sk))
> +=09=09mptcp_check_state(sk, oldstate, state);
> +}
> +
> +static struct ftrace_ops mptcp_state_ops =3D {
> +=09.func=09=09=3D mptcp_state_callback,
> +=09.flags=09=09=3D FTRACE_OPS_FL_SAVE_REGS,
> +};
> +
> +static __init int mptcp_ftrace_init(void)
> +{
> +=09char *func_name =3D "tcp_set_state";
> +=09int ret;
> +
> +=09ret =3D ftrace_set_filter(&mptcp_state_ops, func_name,
> +=09=09=09=09strlen(func_name), 0);
> +=09return ret ?: register_ftrace_function(&mptcp_state_ops);
> +}
> +late_initcall(mptcp_ftrace_init);

I think this is not the correct approach.

I think we must avoid using ftrace to plug an hook from a builtin
feature into another builtin kernel feature.

Additionally this is tracing tcp socket state change, not mptcp
sockets.

A cleaner solution would be adding in protocol.c a mptcp_set_state()
helper that does set the msk state to the provided value and does the
MPTCP_MIB_CURRESTAB accounting.

Then replacing all the 'inet_sk_state_store()' calls under net/mptcp
with the new helper call. I already checked all of them are under the
msk socket lock, so such substitution is safe.

There is only one exception:

=09inet_sk_state_store(newsk, TCP_LISTEN);

in mptcp_pm_nl_create_listen_socket(). You can either:

* avoid replacing such call with the new helper, as the old status is
known to be TCP_CLOSE, hence will not affect the count (just drop a
comment there)

* (possibly better) do the replace even there, adding the relevant msk
socket lock around such call.

Cheers,

Paolo

