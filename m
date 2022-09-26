Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A102F21
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664203864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovh2Zpx/5GB3veT4ZhHebRx0QWPAN25HSzWF0fan5tg=;
	b=FHHKll7KfR+H0kDOiHaY1cLbesjar8oc0f88AL3eC/k69qrH409zjx4MuyXKYsJIH/K1Io
	i8VLfF9JjTWtoDgJS/jwZaCTh0EXs3hmPns1J6pFT45nzou3OnTaLSih52dTvjwHtikp1R
	hRv3Cs53cO42Gs7B2urMrcOIwP0T4AM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-GmRaCjH4Ovumss9iXjHrSQ-1; Mon, 26 Sep 2022 10:51:03 -0400
X-MC-Unique: GmRaCjH4Ovumss9iXjHrSQ-1
Received: by mail-qt1-f199.google.com with SMTP id fx6-20020a05622a4ac600b0035a70ba1cbcso4933475qtb.21
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 07:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Ovh2Zpx/5GB3veT4ZhHebRx0QWPAN25HSzWF0fan5tg=;
        b=wj9Qfw3bx5TaDDo405pj7ZNwpbmu9/wt13frVHdws1dLNY7cI5M01Xym9jlMobcufA
         2n2o7P28wJ8WB2S7GsSs8//AygYa4K7+ramnWB1mEmtgjun9UmshljM8mtEm9PhtiYt4
         48QeQno4N9E1DJsC6bLfGwq6pf8MOwQKou2OJFS0VpvFPHqZaTTS5kQ4RGoSG8VYXVnf
         zCnvFqDgCenRZZjaSAQv89TnddY8HLzSUuSfC8qWv5AM2Tvk1P3Z1JkPU9WSwoI2dtfA
         tr6FFLn3aJMay+HPVuASCHY2TOirYvnCNUCorg+3FewIatNTslcS7wzaYlCNi1yV1YIA
         8W2Q==
X-Gm-Message-State: ACrzQf1abfUq3NWjLfVIzdsYGhhFMoZA05gHHwDVJVQMDCqnZ6HRblCI
	FSRBFS7G/S/MuH4iygcVSZsjTeWllB/aYKBuPUkEnU5yzMv/mS5HbS71LTywyuTKYcJlTQTbKn/
	0tgSzbVoqzw7YT9M=
X-Received: by 2002:a05:622a:14cc:b0:35d:1214:99e8 with SMTP id u12-20020a05622a14cc00b0035d121499e8mr17925501qtx.205.1664203862777;
        Mon, 26 Sep 2022 07:51:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4rmqLfw9bli40kiy7YiiagsGjkDUt+GOJRNhR14QJ4WdbwhA3+RgqoYniCyqr64+0PmV/9+g==
X-Received: by 2002:a05:622a:14cc:b0:35d:1214:99e8 with SMTP id u12-20020a05622a14cc00b0035d121499e8mr17925484qtx.205.1664203862519;
        Mon, 26 Sep 2022 07:51:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-96.dyn.eolo.it. [146.241.97.96])
        by smtp.gmail.com with ESMTPSA id y2-20020a05622a004200b0035a79e18410sm12084727qtw.48.2022.09.26.07.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:51:02 -0700 (PDT)
Message-ID: <84be9c0419af677897836e5af900596bc4713767.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v11 1/4] mptcp: add
 mptcp_setsockopt_fastopen
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 26 Sep 2022 16:50:59 +0200
In-Reply-To: <20220925232601.25252-2-dmytro@shytyi.net>
References: <20220925232601.25252-1-dmytro@shytyi.net>
	 <20220925232601.25252-2-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2022-09-26 at 01:25 +0200, Dmytro Shytyi wrote:
> Add set MPTFO socket option for MPTCP. This option is needed for
> the listen socket to accept MPTFO.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

> ---
>  net/mptcp/Makefile   |  2 +-
>  net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.h |  5 +++++
>  net/mptcp/sockopt.c  |  3 +++
>  4 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 net/mptcp/fastopen.c
> 
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 8a7f68efa35f..c42ad8609876 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -2,7 +2,7 @@
>  obj-$(CONFIG_MPTCP) += mptcp.o
>  
>  mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
> -	   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
> +	   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o fastopen.o
>  
>  obj-$(CONFIG_SYN_COOKIES) += syncookies.o
>  obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> new file mode 100644
> index 000000000000..086cbad49979
> --- /dev/null
> +++ b/net/mptcp/fastopen.c
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
> + */
> +
> +#include "protocol.h"
> +
> +int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
> +				      unsigned int optlen)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	struct net *net = sock_net(sk);
> +	struct socket *ssock;
> +	struct sock *ssk;
> +	int val;
> +	int ret;
> +
> +	ret = 0;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;
> +
> +	ssock = __mptcp_nmpc_socket(msk);
> +	ssk = ssock->sk;
> +	net = sock_net(ssk);
> +	lock_sock(ssk);
> +
> +	if (val >= 0 && ((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
> +		tcp_fastopen_init_key_once(net);
> +		fastopen_queue_tune(ssk, val);

Instead you could directly call:

	return tcp_setsockopt(ssock->sk, SOL_TCP, TCP_FASTOPEN, optval, optlen);

Side note, we could add a generic helper to invoke tcp_setsockopt() on
the mpc subflow, on the give tcp socket option, and reuse such helper
for: TCP_FASTOPEN, TCP_FASTOPEN_CONNECT, TCP_DEFER_ACCEPT... but that
can/should be done later.

Cheers,

Paolo

