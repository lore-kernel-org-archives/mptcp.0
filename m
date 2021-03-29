Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505F70
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 13:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1617025935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8foLo8YmIqZbHWe1okxmTCK/YRLU0buTHRgteIVeXI=;
	b=bfchaVRM3lk2c+AhtXgoMoHZv53wsEiazuntPnx1GFGW0nUo4DT/2cE72Vh1Pa+0ND5KiG
	50vrrVZQd8jDVPJz1bigbJkGyO6LvAv72q0vJTXdBnqVGOYqHt5a8Mp/tWpSASHFylP1dK
	pGBYCggyb1d8OxVFTp3WnnDcYyievHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-X5Nq-A6KMgSNxWXM-BovKg-1; Mon, 29 Mar 2021 09:52:14 -0400
X-MC-Unique: X5Nq-A6KMgSNxWXM-BovKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD5F419251A0;
	Mon, 29 Mar 2021 13:52:12 +0000 (UTC)
Received: from ovpn-114-151.ams2.redhat.com (ovpn-114-151.ams2.redhat.com [10.36.114.151])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A118A60C03;
	Mon, 29 Mar 2021 13:52:11 +0000 (UTC)
Message-ID: <3bd1de25c30c16a76cdb2883b68fc1991002235a.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 2/5] mptcp: add tracepoint in
 mptcp_subflow_get_send
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
	mptcp@lists.linux.dev
Date: Mon, 29 Mar 2021 15:52:10 +0200
In-Reply-To: <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com>
	 <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com>
	 <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-24 at 16:51 +0800, Geliang Tang wrote:
> This patch added a tracepoint in the packet scheduler function
> mptcp_subflow_get_send().
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/trace/events/mptcp.h | 43 ++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c         |  4 ++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 include/trace/events/mptcp.h
> 
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> new file mode 100644
> index 000000000000..06908ea6afb4
> --- /dev/null
> +++ b/include/trace/events/mptcp.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM mptcp
> +
> +#if !defined(_TRACE_MPTCP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MPTCP_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(mptcp_subflow_get_send,
> +
> +	TP_PROTO(struct mptcp_subflow_context *subflow, struct sock *ssk),
> +
> +	TP_ARGS(subflow, ssk),
> +
> +	TP_STRUCT__entry(
> +		__field(bool, active)
> +		__field(bool, free)
> +		__field(u32, snd_wnd)
> +		__field(u32, pace)
> +		__field(u8, backup)
> +		__field(u64, ratio)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->active = mptcp_subflow_active(subflow);
> +		__entry->free = sk_stream_memory_free(subflow->tcp_sock);

I'm sorry for not noticing the thing before, but subflow->tcp_sock can
be potentially a TIME_WAIT socket. We need to do:

	sk = sk_fullsock(subflow->tcp_sock);

and checking for sk being != NULL before accessing any tcp_sock or sock
fields.

Note that the caller don't need such thing explicitly, because it
accesses such fields only for mptcp_subflow_active() sockets - which
are NOT TIME_WAIT ones.

> +		__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
> +		__entry->pace = ssk->sk_pacing_rate;
> +		__entry->backup = subflow->backup;
> +		__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32, __entry->pace);

Here we need to check for !__entry->pace, to avoid possible division by
0.

Thanks!

Paolo

