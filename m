Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408F4A99
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645197775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQvJQJUjy2UP/Zjc7lg6a/nIXO3u8sd4baCFgqdw1m0=;
	b=diWjtHQmkT0tYufcv7AiFVRiMsebYzUYcKnqsiOmBYYBhYyxjk/H8rhIaav01MgvJLWv/1
	Ro2FYeEfrMdJa8O9zFgCoNpj6HG1Ky+j2JmVMKf0r9dA49JF2OmbQyDxv3+eCQgX3WIOR9
	TU3Yi0B5X38ep+l7XBHwY/zSZcES8tQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-P-P8Etj_MmCQ9OwLMVhNIA-1; Fri, 18 Feb 2022 10:22:53 -0500
X-MC-Unique: P-P8Etj_MmCQ9OwLMVhNIA-1
Received: by mail-qv1-f72.google.com with SMTP id k6-20020ad45be6000000b0042c82bd64deso9094770qvc.22
        for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 07:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GQvJQJUjy2UP/Zjc7lg6a/nIXO3u8sd4baCFgqdw1m0=;
        b=yqLuw3YNfPD321HkO8edCHnL+rtLB1ONSVrLB7Q6Ac780/57nn33Yq283S4iILfV5T
         0WlRKnb6a/zIXL8VpxccijzigJcmk7rBGmzCr/Q7p/Q2/9e1lRb/e+rcQ4vEpQKUB4+x
         /xdu1wwN7ydVp+Dw1zmweOP6rtxLmQrTYB6A3ie9+4xbEdgDs7MkrvBgkuomHa0EnxLU
         yljHWcchNxFSU5ehhEsintkrnRG9pGHQHWOue0U9+419Wf2blRR+0Gc9y/s/FPLbZgtl
         nl0O8re5kS8zhNLIZKSBWi5GZXYx2QhlG7b5E7QOwyXGtTlSHXybNOSGx6y6kRNWL5TK
         XmDw==
X-Gm-Message-State: AOAM532Pv28yme+FPmEq3k4Y01iWwjnvUowNfZexMzLg3jhNKL38KfZT
	mjkT796KYJl2uT6GV7rztAZxb3HJYjnfGtPpavT6QFIGDORcXdRvQ2IysZgYjDgSFxNUiHemhyg
	FC9JXcFjnibmgbyo=
X-Received: by 2002:a0c:c2cd:0:b0:42c:42f:6ba4 with SMTP id c13-20020a0cc2cd000000b0042c042f6ba4mr5955497qvi.36.1645197773071;
        Fri, 18 Feb 2022 07:22:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXo78itsoU57KAJqTKICOh7fd+wpx1uwJFBAT5iVJnEm3PoOYWZHEGlrgYxqtoLzRyPcBfgw==
X-Received: by 2002:a0c:c2cd:0:b0:42c:42f:6ba4 with SMTP id c13-20020a0cc2cd000000b0042c042f6ba4mr5955479qvi.36.1645197772827;
        Fri, 18 Feb 2022 07:22:52 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id c20sm25748737qtb.58.2022.02.18.07.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:22:52 -0800 (PST)
Message-ID: <4b734547027f1509cbced67bab7bda98dadcf00e.camel@redhat.com>
Subject: Re: Upstreaming pending -net patches from the export branch, with
 conflicts
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 18 Feb 2022 16:22:49 +0100
In-Reply-To: <c2bcf4d9-9f9a-d4f-a877-2d18c2606f7a@linux.intel.com>
References: <c2bcf4d9-9f9a-d4f-a877-2d18c2606f7a@linux.intel.com>
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

On Thu, 2022-02-17 at 14:43 -0800, Mat Martineau wrote:
> There are 7 pending -net patches in the export branch 
> (export/20220217T054646):
> 
> a92e1a369e45 selftests: mptcp: be more conservative with cookie MPJ limits
> 0d1f61719931 selftests: mptcp: more robust signal race test
> f9ce14971cd2 mptcp: add mibs counter for ignored incoming options
> 474d31e3d81f mptcp: fix race in incoming ADD_ADDR option processing
> cb3236ecdf7f mptcp: fix race in overlapping signal events
> ec621fe172ae selftests: mptcp: improve 'fair usage on close' stability
> 3dbd5c179fa0 selftests: mptcp: fix diag instability
> 
> I was doing a test run to see how these applied to net/master and ran in 
> to two issues:
> 
> "selftests: mptcp: improve 'fair usage on close' stability" creates a 
> net/net-next merge conflict due to the renaming of "wait_for_tw" to 
> "wait_attempt_fail". I propose to drop this rename for the -net patch and 
> queue a new patch for mptcp-next with just the rename.
> 
> 
> "selftests: mptcp: more robust signal race test" creates a net/net-next 
> conflict that's due to changes in the patch context (switching from 
> direct calls to "ip netns exec..." to "pm_nl_add_endpoint"). I think the 
> conflict resolution is super obvious for the netdev maintainers if we 
> remove the blank line added here:
> 
>   	# signal addresses race test
>   	reset
> +
>   	pm_nl_set_limits $ns1 4 4
>   	pm_nl_set_limits $ns2 4 4
> 
> So, I propose to remove that whitespace change and mention the expected 
> merge conflict when posting to netdev.
> 
> Sound good?

LGTM! Thanks for accurate checks!

Paolo

