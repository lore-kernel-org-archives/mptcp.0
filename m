Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E927C
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645805993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7WUEkjJnvy1/l7hFeXLFM87wq9arTARZqZBpNmUuo8=;
	b=S/ZAvxNoggjHBhVtWmYw5n9QipcKmqGRbzEn92HheKI4ZMfWdiI+F4sIrAsHQI+Kk1yGht
	yN9Gqp+BW5gxtY/cdbRmg465P7bnkPdHF4O0sTdDmglr6JredqK+6Azvo7d1M7SoleKhB3
	pqxIcQZMejtbHH4YktCLFiAfZI99HWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-3DL1ieR_Owy_P327rDTDRQ-1; Fri, 25 Feb 2022 11:19:52 -0500
X-MC-Unique: 3DL1ieR_Owy_P327rDTDRQ-1
Received: by mail-wm1-f72.google.com with SMTP id q17-20020a1ca711000000b0037be98d03a1so1792627wme.0
        for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 08:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=j7WUEkjJnvy1/l7hFeXLFM87wq9arTARZqZBpNmUuo8=;
        b=fnpm6sq4hnHp8slYKwykoWecPNJaeYar59VVPLqUBz4RJHCzufmHFlnITbOncTHe5P
         sC9isEtYC3Nf2MEFtniaLe3YTf+Lt5FvDszoajKagmCPsbQlBo7g++8XOyKx2kXZmMmP
         mlcS+f1mNO4CCEmQsKE18TZ2otQWu7fFJjoMUcNUNKUZBdAqKvPUyx8zcdRUzqxosfup
         UGy2BcmMzwpcRyLZwuSe2ajbYsM0dfOB+87HM7O/piSaRqU5tF4cdti+kFHab9NYCky2
         7TEUg1aOJmdILe2jpfPxn11LFXY9gVApZOz9+FZKcKeVzKUlKwFJ2ico+X66C/6MgcrS
         mTCA==
X-Gm-Message-State: AOAM530wm74KHccj384QCGKmMHWbtvt5j/VqDuS7Vg01F+7aLMkaWCiN
	+Bemhh7wmzgrmmNLE+JTfbYym7nIREcBgbTgZ5OiqGgA6c6zZUrBaPtUM2fGb6e2BjQXR002gr7
	Bxw06xZt2Di03cM8=
X-Received: by 2002:a05:600c:3ac7:b0:381:32ff:9e90 with SMTP id d7-20020a05600c3ac700b0038132ff9e90mr2987416wms.2.1645805991227;
        Fri, 25 Feb 2022 08:19:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynbk8aGj/RiV9hsXwOZFXtg0VJNrQzpFXJzsjxkQzV5795HkqHmuuRnLe3aLJ9D4dXfhkpZQ==
X-Received: by 2002:a05:600c:3ac7:b0:381:32ff:9e90 with SMTP id d7-20020a05600c3ac700b0038132ff9e90mr2987399wms.2.1645805991014;
        Fri, 25 Feb 2022 08:19:51 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-242-142.dyn.eolo.it. [146.241.242.142])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d4dc4000000b001d8e67e5214sm2806405wru.48.2022.02.25.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:19:50 -0800 (PST)
Message-ID: <3c10ce87c885ade73b3fe8dc086569233250684d.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next 0/4] MP_JOIN fallback for TCP listeners
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: fw@strlen.de
Date: Fri, 25 Feb 2022 17:19:49 +0100
In-Reply-To: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
References: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
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

On Thu, 2022-02-24 at 15:22 -0800, Mat Martineau wrote:
> Compared to Florian's proposal (add token lookup before the listener
> lookup) this does change more lines of TCP code, but has less runtime
> impact.

I think this will need more changes to TCP code, see my reply to patch
4/4.

I really don't know which one will affect plain TCP setup more from
performance PoV: we will have a token lookup for each incoming syn
packet with both impl. With this patch we still need "mptcp: replace
per-addr listener sockets", right? otherwise issues/203 will not be
addressed.

The thing that concerns me more is that this approach brings quite a
bit of MTPCP logic inside the TCP code with little/no isolation.

More I think about it and more I belive we will should try to code as
simple as possible. And the easyest way to address issues/203 is
possibly at the documentation level...

Thanks,

Paolo


