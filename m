Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321C72
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1617112305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq5DcIeoBnhZjXt1cZIhx9yJSKCvXvh+nwqZXvsrisY=;
	b=UmZl/8ik4LqAbWD6rgJczliAvxqrQ2EEtQWvvE0UtElNHDdNkR2F95pqGcdwxkZluS/M3b
	LIm6ymCGs5czaIMMBiIOqVW5tzFMz9WCxbKg+guFT5ldLK6f5gYEMnpum5AlIUi4Qq0nve
	9I08SDh2cgj3c4GA+PIwkYEoU7hUS0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-_Xs6g6uDOYuZHZi2kKiEKQ-1; Tue, 30 Mar 2021 09:51:43 -0400
X-MC-Unique: _Xs6g6uDOYuZHZi2kKiEKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCB4F835B64;
	Tue, 30 Mar 2021 13:51:42 +0000 (UTC)
Received: from ovpn-115-56.ams2.redhat.com (ovpn-115-56.ams2.redhat.com [10.36.115.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC38E60861;
	Tue, 30 Mar 2021 13:51:41 +0000 (UTC)
Message-ID: <b0cbe100fd42007cf3798911da4c4c932c991b4d.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 1/4] mptcp: add tracepoint in
 mptcp_subflow_get_send
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Tue, 30 Mar 2021 15:51:40 +0200
In-Reply-To: <c69ce9cc277fd134a5254dee68436f6035ab594e.1617095554.git.geliangtang@gmail.com>
References: <cover.1617095554.git.geliangtang@gmail.com>
	 <c69ce9cc277fd134a5254dee68436f6035ab594e.1617095554.git.geliangtang@gmail.com>
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

On Tue, 2021-03-30 at 17:16 +0800, Geliang Tang wrote:
> This patch added a tracepoint in the packet scheduler function
> mptcp_subflow_get_send().
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/trace/events/mptcp.h | 45 ++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c         |  7 ++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 include/trace/events/mptcp.h
> 
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> new file mode 100644
> index 000000000000..80c9498b4ad9
> --- /dev/null
> +++ b/include/trace/events/mptcp.h
> @@ -0,0 +1,45 @@
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
> +	TP_PROTO(bool active, bool free, u32 snd_wnd,
> +		 u32 pace, u8 backup, u64 ratio),
> +
> +	TP_ARGS(active, free, snd_wnd,
> +		pace, backup, ratio),
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
> +		__entry->active = active;
> +		__entry->free = free;
> +		__entry->snd_wnd = snd_wnd;
> +		__entry->pace = pace;
> +		__entry->backup = backup;
> +		__entry->ratio = ratio;
> +	),
> +
> +	TP_printk("active=%d free=%d snd_wnd=%u pace=%u backup=%u ratio=%llu",
> +		  __entry->active, __entry->free, __entry->snd_wnd,
> +		  __entry->pace, __entry->backup,
> +		  __entry->ratio)
> +);
> +
> +#endif /* _TRACE_MPTCP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9d7e7e13fba8..eb64d373a7ee 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -25,6 +25,9 @@
>  #include "protocol.h"
>  #include "mib.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mptcp.h>
> +
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  struct mptcp6_sock {
>  	struct mptcp_sock msk;
> @@ -1411,6 +1414,10 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  			send_info[subflow->backup].ssk = ssk;
>  			send_info[subflow->backup].ratio = ratio;
>  		}
> +		trace_mptcp_subflow_get_send(mptcp_subflow_active(subflow),
> +					     sk_stream_memory_free(subflow->tcp_sock),
> +					     tcp_sk(ssk)->snd_wnd, pace,
> +					     subflow->backup, ratio);

If I read correctly, here 'mptcp_subflow_active(subflow)' should be
always true. That means we actually don't trace some data: we don'
trace not active subflows, subflows with 0 pacing_rate etc.

We should instead get the info even for them.

I think it would be better move the tracepoint just after the loop
start, move mptcp_subflow_active() to the header file, and do the
relevant check inside the tracepoint.

Thanks!

Side note: the other patches LGTM, thanks !

Paolo

