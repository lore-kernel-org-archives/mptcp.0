Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A52C9C
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642180309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4nMhU7GwT0t4pXdP2fUwlugJEs2Oxa5Slxm3jHaxNU=;
	b=aAtaqlDmRBZaBFyoUiJ2F4jMc2KgD2TMFnlMRpj6ChAj4NKjo+9y+Py0jyMkpfBn3OmGnT
	5kpbg0Su+NMlTUPxCysVhFwoXjijZBW9AcMD9uReMvWOk1h0QJDf2+XBh3Ce8pCSnnYusV
	RhljoZ2d1XVGd9OccaF53jKSKMcY/es=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-VcV3ZAnfNri9dj90H6S9ig-1; Fri, 14 Jan 2022 12:11:43 -0500
X-MC-Unique: VcV3ZAnfNri9dj90H6S9ig-1
Received: by mail-qv1-f70.google.com with SMTP id kc15-20020a056214410f00b004152196c16eso9062783qvb.1
        for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 09:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=X4nMhU7GwT0t4pXdP2fUwlugJEs2Oxa5Slxm3jHaxNU=;
        b=8I6V/S9GIIXvWvubVUJTMosxZJCxxnxRTcBUFtLcri3+ILUp69d9NQMmuDLZXwIfWi
         9yiqcHeNDBgYgh4cOtXIU9tF/v5wGu/5bY9iLzvDTyG/gugx1F21KmgFexchaxzMlUzi
         L1MnZBlz/TqrdCAf0FouoxEWbgTMGo8iv3KkqOvl0mt2ec3MMZ62EkrH/pAXnODAR0ra
         F4rO74Rw+ivXUJE8u1v5MPZetfAw07cDjJbM5rAm5DL2RJtkCzA0R91vIM4kOIbvH4pL
         ueObDzHxkpIDNGqZvQhtxzmPAtGKxTRDacTaP3E4K+kVvNLe0zndwtnSwK2h37C5AS3/
         IepA==
X-Gm-Message-State: AOAM532JuiLSMMV7pMUjUPExS/hFXe/8Ods3NdrpR36mRdK9JbmcIgmw
	0+OSxfhPHK9hUslHpUYCuZSEgzvHVJxalY7auGG4QKXFKatpHXPlb92jBOqkZy7z8xoKhP2JpHS
	GKQQIVUvuGzmjLow=
X-Received: by 2002:ac8:7d54:: with SMTP id h20mr8528622qtb.531.1642180303013;
        Fri, 14 Jan 2022 09:11:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiwkj48ZWRCSNSm89bjGE0aTKH2Z7JfAXwapS647VaINbCvVFfm8SrgM31XgDwb+ojnrBlVA==
X-Received: by 2002:ac8:7d54:: with SMTP id h20mr8528601qtb.531.1642180302759;
        Fri, 14 Jan 2022 09:11:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id x11sm2290236qtq.93.2022.01.14.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 09:11:42 -0800 (PST)
Message-ID: <0e4b1a7f071128a6a775b7e903dc48513a079037.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 10/21] mptcp: handle local addrs announced
 by userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 14 Jan 2022 18:11:39 +0100
In-Reply-To: <20220112221523.1829397-11-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
	 <20220112221523.1829397-11-kishen.maloor@intel.com>
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

On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
> This change adds a new internal function to store/retrieve local
> addrs announced by userspace PM implementations from the kernel
> context. The function does not stipulate any limitation on the #
> of addrs, and handles the requirements of three scenarios:
> 1) ADD_ADDR announcements (which require that a local id be
> provided), 2) retrieving the local id associated with an address,
> also where one may need to be assigned, and 3) reissuance of
> ADD_ADDRs when there's a successful match of addr/id.
> 
> The list of all stored local addr entries is held under the
> MPTCP sock structure. This list, if not released by the REMOVE_ADDR
> flow is freed while the sock is destructed.

It feels strange to me that we need to maintain an additional addresses
list inside the kernel for the user-space PM - which should take care
of all the status information.

Why anno_list is not enough? Why isn't cheapest to extend it? 

Being the list unlimited a malicius (or buggy) user-space could consume
all the kernel memory. I think we need some limits, or at least some
accounting.

/P

