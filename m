Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB022C80
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 10:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638873461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYkWzI+3FSXQs0k8qhpF37IxYya5/46ROXwJdyQMpEk=;
	b=fL+J9YfHicPXXxdjXSsKLMJqes/4Cv0l+226mWIItdDM06SZECHCgKjKROle9Wt3UcztIJ
	HT3qJq7irlQ+PhpUccu1V2Rj/7X4tuaieekWflultg0YzZUwHZ29xa5pkxrhUF8WihYqKC
	J2XKafVZ4H4rkh5c0qo2aHlpkxl0n94=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-Iai0gtMXNAOzP6Dm24z9Ow-1; Tue, 07 Dec 2021 05:37:40 -0500
X-MC-Unique: Iai0gtMXNAOzP6Dm24z9Ow-1
Received: by mail-qk1-f199.google.com with SMTP id az44-20020a05620a172c00b0046a828b4684so15087778qkb.22
        for <mptcp@lists.linux.dev>; Tue, 07 Dec 2021 02:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XYkWzI+3FSXQs0k8qhpF37IxYya5/46ROXwJdyQMpEk=;
        b=iPpkyNLhONnCeWscMNJW18lZLIy4bXv37Md3QX9IJUkxX4jylAgkJiwGoFlv1tByjG
         FxOamsRGPQmB/UgLC7/VMX0/y0GhZOOjFxsK3CzY500wrEGJ9HgfYMxkn8PFyheEy5+S
         Fj5n3+yMeF2+KPrppQGYJ6P8TYlXDbBTpNnGdvQaiSlQfQSlakMJgGGCISlJMxf9u9h2
         A144NSekYzO5UOeCfcv7dgyNLMFq74fSqcWJImbLA+SvmDIB94aTEjFpCO5vpA2rop9L
         WT3q9EhNcM//4JGThy3u39046nIrjBdTD/Gjtqss5toLVLOSSdVpzsomGvs9slqWR4D3
         kxKQ==
X-Gm-Message-State: AOAM532vVfKMU0ufconlXbdxBUxe3ts1N1rldoHFg8nbKNLR7rRtCZVF
	STmcNmntfDzAQmhfhV5eN+q1EUaq1O95AAqezugPNtv6rnk0tmKj1aHR98vK089r1SXN0pOlgng
	g6ZPM57EkCdj7obw=
X-Received: by 2002:a05:620a:1a8d:: with SMTP id bl13mr40261753qkb.130.1638873459737;
        Tue, 07 Dec 2021 02:37:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWRUwvSkSp4JTwVmjhW73VL002Z4WK6fbM3JdMrFypwYBcX2WehwnIuvlqEAXIJwtGJNuusQ==
X-Received: by 2002:a05:620a:1a8d:: with SMTP id bl13mr40261729qkb.130.1638873459554;
        Tue, 07 Dec 2021 02:37:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-1.dyn.eolo.it. [146.241.252.1])
        by smtp.gmail.com with ESMTPSA id i16sm9088514qtx.57.2021.12.07.02.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 02:37:39 -0800 (PST)
Message-ID: <82d10189f1ca99ccba4c161884d446cbb3246ce9.camel@redhat.com>
Subject: Re: [PATCH net-next 10/10] mptcp: support TCP_CORK and TCP_NODELAY
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, Maxim Galaganov <max@internet.ru>, 
	davem@davemloft.net, matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Date: Tue, 07 Dec 2021 11:37:35 +0100
In-Reply-To: <20211206173023.72aca8f9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
	 <20211203223541.69364-11-mathew.j.martineau@linux.intel.com>
	 <20211206173023.72aca8f9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Mon, 2021-12-06 at 17:30 -0800, Jakub Kicinski wrote:
> On Fri,  3 Dec 2021 14:35:41 -0800 Mat Martineau wrote:
> > +static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t optval,
> > +					    unsigned int optlen)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +	struct sock *sk = (struct sock *)msk;
> > +	int val;
> > +
> > +	if (optlen < sizeof(int))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> > +		return -EFAULT;
> 
> Should we check that optval is not larger than sizeof(int) or if it is
> that the rest of the buffer is zero? Or for the old school options we
> should stick to the old school behavior?

I think it's useful if we keep the MPTCP socket options binary API as
close as possible to the plain TCP ones: that allows for seamless
switching existing TCP application to MPTCP with no code changes.

Old school, please ;)

Cheers,

Paolo 

