Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F05F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1617297260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hy9UucFdoMBs1xEIMvHIK35dDXyQ3e0COjcOhuDpBrc=;
	b=ZrkbFEWMqNbyyIOKqgCCumwGrMiNC7K5ygw57OwRYpVooqVjLbVvcGeVxRj0dA1qnUM/tO
	Npm7AXySrKPcPyodHLgGUmxl0Vw462EPVmuDDDevJYew8hRQsfZG5lt6wSMItObpJwprXr
	iiKanBgvK2gymJPTwpq0a2WrxwyWWbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-lHu4qjadPcyI4VtY41IgXA-1; Thu, 01 Apr 2021 13:14:17 -0400
X-MC-Unique: lHu4qjadPcyI4VtY41IgXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 846E318C8C00;
	Thu,  1 Apr 2021 17:14:15 +0000 (UTC)
Received: from ovpn-114-240.ams2.redhat.com (ovpn-114-240.ams2.redhat.com [10.36.114.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B053C10016FD;
	Thu,  1 Apr 2021 17:14:14 +0000 (UTC)
Message-ID: <323c294f0f6161da5dad17306775172add7d0dc5.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next] Squash to "mptcp: add tracepoint
 in mptcp_subflow_get_send"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Thu, 01 Apr 2021 19:14:13 +0200
In-Reply-To: <77e57026944d545dc4aaf9a6199ffa39485e1f43.1617296035.git.geliangtang@gmail.com>
References: <77e57026944d545dc4aaf9a6199ffa39485e1f43.1617296035.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-04-02 at 00:54 +0800, Geliang Tang wrote:
> Reduce the indentation level and zero the uninitialized fields.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/trace/events/mptcp.h | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index f1c836573744..b1617a0162da 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -23,22 +23,29 @@ TRACE_EVENT(mptcp_subflow_get_send,
>  	),
>  
>  	TP_fast_assign(
> -		bool sk = sk_fullsock(subflow->tcp_sock);
> +		struct sock *ssk;
>  
>  		__entry->active = mptcp_subflow_active(subflow);
>  		__entry->backup = subflow->backup;
> -		if (sk) {
> -			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  
> +		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
>  			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
> -			if (ssk) {
> -				__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
> -				__entry->pace = ssk->sk_pacing_rate;
> -				if (__entry->pace)
> -					__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32,
> -								 __entry->pace);
> -			}
> +		else
> +			__entry->free = 0;
> +
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		if (ssk && sk_fullsock(ssk)) {
> +			__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
> +			__entry->pace = ssk->sk_pacing_rate;
> +		} else {
> +			__entry->snd_wnd = 0;
> +			__entry->pace = 0;
>  		}
> +
> +		if (ssk && sk_fullsock(ssk) && __entry->pace)
> +			__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32, __entry->pace);
> +		else
> +			__entry->ratio = 0;
>  	),
>  
>  	TP_printk("active=%d free=%d snd_wnd=%u pace=%u backup=%u ratio=%llu",

LGTM, thanks!

Paolo

