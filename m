Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8C168
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641813425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBsjxrGCRJD4h4ToVYgkfUrkbkBXPBI04/TZvFvxjWE=;
	b=RElsMSjlIYnJvdI0MbUYRwQvMkz8vQTGNJcpWj/8SL4qioG6nj8NyYP/IRN6ugZxK490ii
	4Mf5Vp6UJJs64gBYpiDCNceKxjrpbg58pW3PsZfcmXhYcDLZAmZx31ylF+DWiYbhci9FtN
	9vrFwc1KZi+1f3XSC+ah4Qn0RLgSKow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-3ynB6BvANkKj8XvVpB6Qqg-1; Mon, 10 Jan 2022 06:17:04 -0500
X-MC-Unique: 3ynB6BvANkKj8XvVpB6Qqg-1
Received: by mail-wr1-f71.google.com with SMTP id g6-20020adfbc86000000b001a2d62be244so4036301wrh.23
        for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nBsjxrGCRJD4h4ToVYgkfUrkbkBXPBI04/TZvFvxjWE=;
        b=czNPDAnDl7QK6exuESM/sNDgUPeUI5cFX4BjOZlja3CMioT5pmE/wikcwBcXW9f1rk
         nz4v6hbiQGJYEaHcoNQS8SpQ2IjsDctuOA6Ze1fyCbWFpvV/cMpEnyB5cLlMocCY5e3l
         tG9vc5QmaboItvLxRoxRmmzpsFNxRocMSC3GdnppSatfnTeTg12nvaKb2T3RSGBNSQRP
         HosUh3T0hROh/vACW4SncjfkKJqfVYeyl/PJ9CLk0B0VazEYf2udP6uKWkyyILbcv+8I
         aEmvfNYrsPcs93/rkzyygisUuhzPFSEze8oKZIM5/qao2agIWHXliADfPguvQ1ERHPZW
         EE8A==
X-Gm-Message-State: AOAM531BYoXDJL4JOxQO+CxxrmzdN4EMN3m44SqF+t4JuNVvhiTvh34Z
	hc+xJfMpU7+eMEo+ACdaWexECpEaohUvfP3tkhNTpHsM8Bv2FS2w5YZbWSCHiYKlCzQj64F1y7E
	B8RNcbol9M5FBVJg=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr9071172wrj.538.1641813422422;
        Mon, 10 Jan 2022 03:17:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwb3DtzgjSa9eQd+2wbtr24UaIjhKVW1OcNi3xuWWUgAVs4eQAwzOibOc4X9ru9sEY02G8rTA==
X-Received: by 2002:adf:dc50:: with SMTP id m16mr9071154wrj.538.1641813422215;
        Mon, 10 Jan 2022 03:17:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-184.dyn.eolo.it. [146.241.97.184])
        by smtp.gmail.com with ESMTPSA id g14sm790984wmh.3.2022.01.10.03.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:17:01 -0800 (PST)
Message-ID: <1ab5a090ab4b76730aa99674e5fdd2b11c1ceef1.camel@redhat.com>
Subject: Re: [PATCH net-next v1] net: mptcp, Fast Open Mechanism
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp <mptcp@lists.linux.dev>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mathewjmartineau <mathew.j.martineau@linux.intel.com>
Date: Mon, 10 Jan 2022 12:17:00 +0100
In-Reply-To: <17e3ad737a6.11773db21196328.7247055283158244704@shytyi.net>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net>
	 <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net>
	 <17cb73b1343.c752fede1729351.6463099199494289591@shytyi.net>
	 <868a9dcc-9001-cdd8-c655-dabe7b8f9222@tessares.net>
	 <17d8c64c442.11c026c79399960.5261313972320451268@shytyi.net>
	 <17e3ad737a6.11773db21196328.7247055283158244704@shytyi.net>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Sat, 2022-01-08 at 18:58 +0100, Dmytro Shytyi wrote:
> I'm writing this message to post another update regarding the work on
> fastopen mechanism in MPTCP.
> 
> Changelog:
> 1. Packet retransmissions are fixed.
> 2. The final ack (was missing) is now present during the exchange
> 3way handshake during TFO cookie request.
> 
> Work is in process...

Thank you for progressing on this.

Could you please additionally share your WIP code? Even if in an early
draft status, sharing it could help detecting eventual pitfalls (e.g.
the non-fastopen case should be impacted as little as possible)

Thanks!

Paolo

