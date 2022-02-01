Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCC2CA2
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643715123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuhF44glbtRpC5QtM0+4Ua+wlIRXUKsKinMRsc0ULmk=;
	b=FCQicjgW7wc6Li0b1e1zWN/8nRvl2G7OJDpFRwWS2F2XqDxKgPMQoIMK+o/l4d5WKpqhf2
	01Sojw9PnW/gGFuBui/GeslczkTr4zn2EuGhS5pI6ArVQ1lr9RudsLtB/wUbTyjqYNd2XD
	TUXxkdNCAYW3B2IxKH1vuxOjn3f8I+g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-OmO2PvZCMLuTwksn94rrIQ-1; Tue, 01 Feb 2022 06:32:02 -0500
X-MC-Unique: OmO2PvZCMLuTwksn94rrIQ-1
Received: by mail-wm1-f71.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so843879wmi.2
        for <mptcp@lists.linux.dev>; Tue, 01 Feb 2022 03:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FuhF44glbtRpC5QtM0+4Ua+wlIRXUKsKinMRsc0ULmk=;
        b=1f+CHzlitFpFSDeBclDWm0RM2YUi5MTCJOJIF4QjAfNl+U4QBPDyp74ZL6KnYyKNI2
         wECENLHAJ/38c8eCM0wfKq52DHYlKW6hBzCZowunTTPT0FTJlxCwWV2gcXLRS1cK7GZw
         hbsuWs9cbgZ//Lgwc2v0if5TyfXjL2FiVpuIc7bPaqEmiopYfgkhIl5CZ9bb05rkQ8Bt
         1ybdwvpfJ02zF10uSUXg0Ck8s6D/9y3MFjgBGsX4bjAnjCy+HBhtP0NFrFsUSW0zwvnj
         UiNctGRam+h3xiVZrSf2iLaQ5jTXTBVM7kGdGLaNr0c9jZQrxCuL7ctWn0RpsEb6pojI
         AMIQ==
X-Gm-Message-State: AOAM531lFxe+A8HEj8ml7u+AAGTaOMsQiCpE0oQv1e5YH/H0gbj+hEyk
	W04zJ6HLoi2AVJhXRzYiY3xXBDczWXeSeJktOkJEOzoFbbfEzu0E69oIAiD/4bdB65X4IXF3AGJ
	q89qnM0GTjFIcKqQ=
X-Received: by 2002:a05:6000:258:: with SMTP id m24mr21806607wrz.2.1643715121580;
        Tue, 01 Feb 2022 03:32:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHf2OXx+9K8ji10koOFALaDUjdi/X52sLvn5zmkmIQwkTy/w3h7kE3kAypZtm7QpiZKxYkmg==
X-Received: by 2002:a05:6000:258:: with SMTP id m24mr21806593wrz.2.1643715121301;
        Tue, 01 Feb 2022 03:32:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id r2sm2248109wmq.24.2022.02.01.03.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 03:32:00 -0800 (PST)
Message-ID: <95b6d470ba9cda9da853ff1f4f649f597934ca9c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3 6/8] mptcp: netlink: store lsk ref in
 mptcp_pm_addr_entry
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Tue, 01 Feb 2022 12:31:59 +0100
In-Reply-To: <20220128003812.2732609-7-kishen.maloor@intel.com>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
	 <20220128003812.2732609-7-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Thu, 2022-01-27 at 19:38 -0500, Kishen Maloor wrote:
> @@ -157,6 +157,33 @@ static void lsk_list_release(struct pm_nl_pernet *pernet,
>  	}
>  }
>  
> +static struct mptcp_local_lsk *lsk_list_find_or_create(struct net *net,
> +						       struct pm_nl_pernet *pernet,
> +						       struct mptcp_pm_addr_entry *entry,
> +						       int *createlsk_err)
> +{
> +	struct mptcp_local_lsk *lsk_ref;
> +	struct socket *lsk;
> +	int err;
> +
> +	lsk_ref = lsk_list_find(pernet, &entry->addr);
> +
> +	if (!lsk_ref) {
> +		err = mptcp_pm_nl_create_listen_socket(net, entry, &lsk);

What happens if multiple cores call 'lsk_list_find_or_create'
simultaneously? Is that possible/expected?

I think the expected behaviour in that scenario is creating a single
new lsk, and have all the callers fetching such instances. If the race
happens on mptcp_pm_nl_create_listen_socket() it looks like only one
caller will get a valid lsk reference, all the others will get back an
error.

Possibly calling again lsk_list_find() in case of failure could address
the above.

If the race is not possible, it should be at least documented in a
comment why it can't happen.

Side note: using:

	if (lsk_ref)
		return lsk_ref;

instead of:
	if (!lsk_ref) { //...

will reduce the indentation level.

/P

