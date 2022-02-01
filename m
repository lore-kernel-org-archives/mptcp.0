Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957E2CA1
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643715746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjUr32BEoeBHNtrQz4pCMs4WtgbuVjyhPRYvYQSiPZc=;
	b=cEnH2kQvqKyERhoYSSAYxwxM/dyquzY4wWeBLUzspAsRu6P9pTRn3oxmuqUhUxj6wnDgHj
	iukU/5FHWOf2QrXZDuFOHIPorOZxNz2gBWjRQ3rTnX+SYGT3sTgmuJb3tSBz2m9tBxAyEz
	26ifS9Mk90zhzhaDueVWYRlWvYQM/ic=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-7EB2fhhhNfCvQ4eab6OQ2w-1; Tue, 01 Feb 2022 06:42:23 -0500
X-MC-Unique: 7EB2fhhhNfCvQ4eab6OQ2w-1
Received: by mail-wr1-f69.google.com with SMTP id r2-20020adfa142000000b001e176ac1ec3so1736745wrr.3
        for <mptcp@lists.linux.dev>; Tue, 01 Feb 2022 03:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WjUr32BEoeBHNtrQz4pCMs4WtgbuVjyhPRYvYQSiPZc=;
        b=YGFlcsbwdIwx3ZnMC7vDwnQQhxr5OQfmp73kFUEOoIm8XQQVCM6JgHxMUFbfkOSKC4
         FI0UYaZejetBeqNFJ9fsNihosvmc3SqgdV8p18F8cjsClrEaGvwYuj1M+o+0ya4hfU7z
         TKRSokhW2qf3MxKSZZiiIVSWojJoAZM7N4/6gg5EgvlfwcFaaU9M/EFpMyiujFrmbRAI
         JUMnuKG+dpKXu/WsXJQ66FjZXeviBNKAeqTT+2rRn/kK11NH6b4TkZW0o7LS+RoGQdmI
         FkmT0pKCSDOD8ldcL9UCGqwnB+zkybSgKttaaeRUn8WUhCZsNmXD5RAyymTQgn7X79oO
         FZOw==
X-Gm-Message-State: AOAM533JOvRanydoGR9XTyWOOuVuVJKkpiU8esAyBh50PvpFGtwL6qfg
	xLTfCK2KWogAr77jiyjkot1iS41pJz/3p7WyL4qi6sVJOrtGlECt9Z+lEiLuKuvs6I+8N0DoXjw
	sbF9p929qL0CeT6E=
X-Received: by 2002:a5d:6f0e:: with SMTP id ay14mr21182106wrb.60.1643715742494;
        Tue, 01 Feb 2022 03:42:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEKE3lc0rVv6HCaRCuFolMjJw4ksycj6u0lJmROuu9JqcyD6VH8Bju/7BojhWTX2JKDkTIEA==
X-Received: by 2002:a5d:6f0e:: with SMTP id ay14mr21182090wrb.60.1643715742251;
        Tue, 01 Feb 2022 03:42:22 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id h9sm1851121wmq.8.2022.02.01.03.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 03:42:21 -0800 (PST)
Message-ID: <2a4c2a567359b839aacd3d56d8a7734af5479747.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3 7/8] mptcp: attempt to add listening
 sockets for announced addrs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Tue, 01 Feb 2022 12:42:20 +0100
In-Reply-To: <20220128003812.2732609-8-kishen.maloor@intel.com>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
	 <20220128003812.2732609-8-kishen.maloor@intel.com>
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

On Thu, 2022-01-27 at 19:38 -0500, Kishen Maloor wrote:
> When ADD_ADDR announcements use the port associated with an
> active subflow, this change ensures that a listening socket is bound
> to the announced addr+port in the kernel for subsequently receiving
> MP_JOINs. But if a listening socket for this address is already held
> by the application then no action is taken.
> 
> A listening socket is created (when there isn't a listener)
> just prior to the addr advertisement. If it is desired to not create
> a listening socket in the kernel for an address, then this can be
> requested by including the MPTCP_PM_ADDR_FLAG_NO_LISTEN flag
> with the address.
> 
> When a listening socket is created, it is stored in
> struct mptcp_pm_add_entry and released accordingly.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v2: fixed formatting
> v3: added new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN to skip creating a
> listening socket in the kernel during an ADD_ADDR request, use this flag
> along the in-kernel PM flow for ADD_ADDR requests (Note: listening sockets
> are always created for port-based endpoints as before), use the
> lsk_list_find_or_create() helper

I think it's better introducing the opposite flag (e.g.
'MPTCP_PM_ADDR_FLAG_LISTEN') otherwise this will change the default
behavior

Thanks!

Paolo

