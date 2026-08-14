Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6CF36B909
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725867; cv=none; b=MHd8eVX+eBoFhW7e4/rHYSIj7EFSJRV7DofrpB5exdHHferOjpuhAzVzbjsXmsp5yg0SHZv9q+gKaenzuUJs4FRca09PeLfhuoZYz6GWFxWOsSKu1OXEhJ8rPzFPioqK6MrlOL9pu9hptVgjlRuJzfY7eFXc+oeLORQHA6jYjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725867; c=relaxed/simple;
	bh=2qdD8Hz8W86PoPH7GKdCo3XU354V2bS0YSZBLNn4yWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E7BC+gFtlHwjvfRbVOMTWy/SOnOVEO4vvcMG4BAi8mWyYhRMnL1Wkdj28Ey5F44gly9xio1MduoIUJYcfSW5TB9RgniOuzaMHK4zupl23fc1NLOhlt5NaOq0qO9SLRv40IrA8GB2x3iAI8zGZbQLhX4NySqweSqyZPJQz/nMjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRSvyDH3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRSvyDH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786725864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEwT6bKeR3y4PmtycixGIkN4fzQk1HukSm3tdNuDY7I=;
	b=HRSvyDH35uBZNRqh1mWK9BT9PNAa6m3lnjz7ZkP12XNV+A1Z/Q5H2ZFq5kzHKZXckHaJ+D
	5tjJqWeQFIpHZGse8PtsQ4/0amXTR2UyOKQ5FlnRn/yfxcPv78vJRRezCXR6C9oSFmL8Uo
	lnHmn0/9VvxXWzzzPLx2Dn4p5r9xFY4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-EwY1yTNWORK48dy9jGjZDA-1; Fri, 14 Aug 2026 12:44:23 -0400
X-MC-Unique: EwY1yTNWORK48dy9jGjZDA-1
X-Mimecast-MFC-AGG-ID: EwY1yTNWORK48dy9jGjZDA_1786725862
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso10831115e9.1
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 09:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786725862; x=1787330662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AEwT6bKeR3y4PmtycixGIkN4fzQk1HukSm3tdNuDY7I=;
        b=EZUj075YXKZcx7GKlILv2OjpxvwQr/53Pt1qlsCjXPwjdWQaQfVyx+Ta1/t72kfZvC
         /sjA6u0nJWeMmyKWN0vCFMwMgc5qBnzBQ0Ywj2PUmWMcKDbInDJlqVUrmNJPgnJNNQc8
         cX5adKv63X9KEPyp8ZqFF8CuyFgR6M6A1+t3TjvOs1Ji5Mzti8k+ouzxvjL9b2NbBcVy
         dkg8fmm2aZzoMNnptN6csy1thpeulJxwDaUcT/9s5qIuFIZyuaHp5VkiKs8qHOA1FzVA
         x4l2SLMYygr6ill14vvji929kFmT+HESnabd5NzG6BJ2JS5o1/WTOLiwk6ofX40oRgyq
         fDJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPRkhgeLnE1X6XTfh1jkBvr1r4nagwHPuq2vb4imNkuGXAOoD8/8P4UQdLjgzXY3fUJD5iPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyysfyZsbdvMgKw7s5YKzSSx18fz7C5zDoE0e7ceyiHF2FZBycH
	34QLIMg9k7F6tCV1e/WlHF6lXHiJcQhTxHv5mCxHMZq0C7FXhgTxzTxX6aFvX5td5fvCx+Sr7pv
	d6I6JBQqp8DraRk0io0wawxEpVnJFzYHBYI6lueQhW6cR+L5Ln6tfMD+2KVx4V4gr
X-Gm-Gg: AR+sD10Fla57BrZMeHCWkFjAQvGeu8gnum8NAlwh5SUglUOsXEASdmckNC8mbpWEIBi
	NH7AXirkbEZ2IVQUXtRAor+Pfdp4NIVi8/nbbJAeFyX+DQr4xcTA/Hy3tKYrvEBfvJgyI3r3t71
	DCdCg8FsGx39ueWjWgo/R9mW4MZCEzG3DnH8df+kPiuK1MshMrQtHyfnJPQaSDdLYBCjFNQAdUl
	zMgDz6e7dRHKJEVutaAkSCmoecZbYHFzahr0gah9ArViXJLx9UbzDtuxi6F5x/FshZB28VXMtv7
	wg6zHkHDojFGRgHKQqFT0m6kr3Pg6QVnueWpK7rv+UJd9r5pCkeAjxd9yU4xA8xJqacVJ8DMBxj
	ztm095Jr32ohvv5uoMT02GnArJOQ3+hZx3XK+wKFUQPMA9Q93TycJIwzVFMcnvaEoW3hyLx6dP+
	o=
X-Received: by 2002:a05:600c:8107:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-499879665ffmr116026535e9.13.1786725862295;
        Fri, 14 Aug 2026 09:44:22 -0700 (PDT)
X-Received: by 2002:a05:600c:8107:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-499879665ffmr116025915e9.13.1786725861899;
        Fri, 14 Aug 2026 09:44:21 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899afa63sm43922225e9.1.2026.08.14.09.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:44:21 -0700 (PDT)
Message-ID: <b8ac43a1-d5f1-4498-8aae-dc87c2e3b437@redhat.com>
Date: Fri, 14 Aug 2026 18:44:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] selftests: mptcp: print stats before socket
 closure
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h2NFBAxEit948MOY56ORBPTLHWMy3pHHcXIe6l0ZoO0_1786725862
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 4:07 PM, Matthieu Baerts (NGI0) wrote:
> In case of poll timeout, it might be too late to print the stats after
> the socket closure.
> 
> Now, in case of poll timeout, 'ss' and 'nstat' are invoked from
> mptcp_connect to print the stats before exiting. This should help
> debugging poll timeout issues.
> 
> Note: for this "workaround", system() is used for debugging purposes
> only. The returned result can then be safely ignored.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index ea4cb6c1bd5e..842c0eb99aa9 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -210,6 +210,19 @@ static void xgetaddrinfo(const char *node, const char *service,
>  	}
>  }
>  
> +static void print_err_stats(void)
> +{
> +	char cmd[128];
> +
> +	snprintf(cmd, sizeof(cmd), "ss -Menitam -o '%cport = :%s' >&2",
> +		 listen_mode ? 's' : 'd', cfg_port);
> +
> +	fprintf(stderr, "socket stats before socket closure:\n");
> +	(void)!system(cmd);
> +	(void)!system("NSTAT_HISTORY='/tmp/$(ip netns id).nstat' nstat -s | "
> +		      "grep Tcp >&2");

Overall LGTM. I tried something similar in the past, but the correct
redirection always fouled me. A couple of questions:
- Is the '!' operator needed?
- Can we avoid the pipe? with something alike the following:
	(void)system("NSTAT_HISTORY='/tmp/$(ip netns id).nstat' nstat -s *Tcp*
>&2");

/P

