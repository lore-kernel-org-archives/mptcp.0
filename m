Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004417C4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1652264544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1IG01soTqXJu2Z1UG+cUqrR+XOl+pps8P5miLnIJ+o=;
	b=PtVqRGwqxTcouZxVsOSvLqLwN9Ba5+veTTMUqFogeFsb9VHzhGj1zIFO08gllk4qphUWpG
	GT+nH0hRpIDMC3aU7XS5gG7/otBcvoDFNZBolRlAtAzO2hQfXcwHEyDEUzg9oqJF+zC3fh
	yEhxgaSRFecO695lFXsRuZhceF0DPeY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-cPKei8pyOr6XdCah8L070g-1; Wed, 11 May 2022 06:22:23 -0400
X-MC-Unique: cPKei8pyOr6XdCah8L070g-1
Received: by mail-wm1-f70.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so530877wmb.3
        for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=d1IG01soTqXJu2Z1UG+cUqrR+XOl+pps8P5miLnIJ+o=;
        b=fj9d3E27MIIhu29As2nAJwgTJePGO1XqfmPymC3p51G75Tuegf8fBWbY+/p6KVh/0Q
         F9bzkEsoU97cZbpbxVWlJ62hUS2le3430H5OwBTuvc8QYPJrX1cB6N+QOSc9KgskTGig
         AOE7t57yxFDPn5/a4qg2bCUaReZeeBseOJtbXZfe04tRmfpzLhKLHbFa9cl3BFR9Nk35
         OGtwlRlyLcIk4F9AxoFvNIrzJYestQ5ilEs11wwGpLYwPYfdm1K2xyZtaM+3Jrv2xvlI
         vXiFD3Z9DPgFqFEWRCAZKchw6M0R1PbEJtYOH3PHa12/CSCmFCd/Ls4XzJ6cvMxw9InM
         usjg==
X-Gm-Message-State: AOAM532rgpMbQrwlfUZcDityhYp/E4JtL/UU5QqbUWjueHtmTF45ZtF1
	T4AEGm5S5STelOdswmBCJw3LjHEs/YwwCVOBUTy6Kcud1C8fizdp5F1DvdQVWouGRDd1+znuJiV
	cH1krVbP/vHzLQng=
X-Received: by 2002:a5d:6a85:0:b0:20a:d938:3879 with SMTP id s5-20020a5d6a85000000b0020ad9383879mr21987090wru.462.1652264541801;
        Wed, 11 May 2022 03:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZt5DITpWCkddU5RU3+NXQwRKz4et4twZ/zWlRSa3YfNgLbIgs9LjIYLw5sXnZKzPOEW5Z4A==
X-Received: by 2002:a5d:6a85:0:b0:20a:d938:3879 with SMTP id s5-20020a5d6a85000000b0020ad9383879mr21987076wru.462.1652264541546;
        Wed, 11 May 2022 03:22:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id c10-20020a7bc00a000000b003942a244edcsm1647311wmb.33.2022.05.11.03.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 03:22:21 -0700 (PDT)
Message-ID: <2bf857cc4abe21426ce2418645667663ca7cefcb.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: fix checksum byte order
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 11 May 2022 12:22:20 +0200
In-Reply-To: <331ef61b-19b7-ea0-6832-ebf3c97aa9c@linux.intel.com>
References: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
	 <331ef61b-19b7-ea0-6832-ebf3c97aa9c@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Tue, 2022-05-10 at 16:10 -0700, Mat Martineau wrote:
> On Tue, 10 May 2022, Paolo Abeni wrote:
> 
> > The MPTCP code typecasts the checksum value to u16 and
> > then convert it to big endian while storing the value into
> > the MPTCP option.
> > 
> > As a result, the wire encoding for little endian host is
> > wrong, and that causes interoperabilty interoperability
> > issues with other implementation or host with different endianess.
> > 
> > Address the issue writing in the packet the unmodified __sum16 value.
> > 
> > MPTCP checksum is disabled by default, interoperating with systems
> > with bad mptcp-level csum encodying should cause fallback to TCP.
> > 
> > Fixes: c5b39e26d003 ("mptcp: send out checksum for DSS")
> > Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> > - move the typecast inside put_len_csum (Mat)
> > - updated the commit message (Mat)
> > - fix a few sparse issues
> 
> Hi Paolo, thanks for the v2:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> (for export-net)
> 
> Still ok with you to apply this to export-net? There are a couple of minor 
> conflicts when rebasing to export-net, and it also creates a merge 
> conflict with net-next. But I think it's worth it to be able to say "every 
> 5.18 and later kernel has the checksum fix".

Agreed. 

> Have you tried backporting this commit to 5.17-stable or 5.15-stable?

No, that is likely worthy, but I really have my hands full :( I think I
can have a look not earlier than next week.

/P

