Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454655F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1617272307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2U+1X1SM3NtosN3mLLpZy4437SzzRcndSlySD1nl1nQ=;
	b=CjoglRElYmHch8XuChNkNQCDTXJXXyeqbutMdwy6JXOUktsoNp3nyYIVS9h1u+ZJjPOd56
	k85bwF8Auy+9vj0aotEGGUHT218MHPHARJ6VTU484+9IuYP5whDFrds08Hm2/0rjyWaDb+
	5lqlXOIF649Sw2pwDgPL3ot4wChK5cI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-h9nQDdmIPY-QXOIqaurI9g-1; Thu, 01 Apr 2021 06:18:25 -0400
X-MC-Unique: h9nQDdmIPY-QXOIqaurI9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73DD0801817;
	Thu,  1 Apr 2021 10:18:24 +0000 (UTC)
Received: from ovpn-114-240.ams2.redhat.com (ovpn-114-240.ams2.redhat.com [10.36.114.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8944461F55;
	Thu,  1 Apr 2021 10:18:23 +0000 (UTC)
Message-ID: <0c7cbf71e4c5709da87ea91ea15bc67694195edc.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v4 mptcp-next 2/5] mptcp: add tracepoint in
 mptcp_subflow_get_send
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Thu, 01 Apr 2021 12:18:22 +0200
In-Reply-To: <9a7fe804a654722cab2b7b4cd97f21a5f27ec2cb.1617175133.git.geliangtang@gmail.com>
References: <cover.1617175133.git.geliangtang@gmail.com>
	 <69be5c2c98752dfe6cfe572ef5f13ff701618bd0.1617175133.git.geliangtang@gmail.com>
	 <9a7fe804a654722cab2b7b4cd97f21a5f27ec2cb.1617175133.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-31 at 15:23 +0800, Geliang Tang wrote:
> This patch added a tracepoint in the packet scheduler function
> mptcp_subflow_get_send().
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/trace/events/mptcp.h | 53 ++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c         |  8 +++---
>  2 files changed, 57 insertions(+), 4 deletions(-)
>  create mode 100644 include/trace/events/mptcp.h
> 
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> new file mode 100644
> index 000000000000..f1c836573744
> --- /dev/null
> +++ b/include/trace/events/mptcp.h
> @@ -0,0 +1,53 @@
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
> +	TP_PROTO(struct mptcp_subflow_context *subflow),
> +
> +	TP_ARGS(subflow),
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
> +		bool sk = sk_fullsock(subflow->tcp_sock);
> +
> +		__entry->active = mptcp_subflow_active(subflow);
> +		__entry->backup = subflow->backup;
> +		if (sk) {
> +			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
> +			if (ssk) {
> +				__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
> +				__entry->pace = ssk->sk_pacing_rate;
> +				if (__entry->pace)
> +					__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32,
> +								 __entry->pace);
> +			}
> +		}
> +	),

Minor nit: I think we can reduce the indentation level and probably we
should zeroed the uninitialized fields, but I think we can do that
eventually later with a squash-to patch. I suggest to merge this as is
and than eventually improve later.

Thanks!

Paolo

