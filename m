Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C129CA
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637939775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2EH1SjN+kH9ufGrbUEHOhukqucB7mjFMaGPkVy/Pts=;
	b=Rpc1j6SZ2XCsH8/C6NCvj8Dd+WKAqfkB0jexW5/leEE22hiS0muJojj/XcCFYjgFS2757V
	oG0g6KB0E5bFf4nxzntsHBTmJjULPA0zLzRKDWE6dvxzHV+eg6xbbrNJYPaS+fYmumvLQL
	/LyzTlCtgOg+2+5yOvy4a6Y1Krrh4dg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-Zsou2yFFNdu0yOiKSGMm-A-1; Fri, 26 Nov 2021 10:16:13 -0500
X-MC-Unique: Zsou2yFFNdu0yOiKSGMm-A-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso8217482eds.22
        for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 07:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=z2EH1SjN+kH9ufGrbUEHOhukqucB7mjFMaGPkVy/Pts=;
        b=iQ09qi+pxr23aOeI7HAlovHXOqTpbFLFuw4kU53LrTRXNQO0LxaP7031zru9Bdd/Qu
         o2jbAO/5wXyd6/l+ymIrzomizYLf6O4X/iJqoVn5XfrC3LWqZLl29HxwnZkeY14H0R56
         3Ooj9+UkNsvGxDigtOmQrXihiMdG4D51uASzBfHjo/HLWWKNn9mO8c7S3ZSxjX/0rgQK
         c522BySf/2JSLLsx0RErNUz1HFFcWmEC0VkH6qTVxU+KGr3GJ9s0H5sH147Ru/OVeElc
         055JX/SnNeO2LggBUAULzlPkoOnoFRlHdHarCOS6bd0yflDdgp3F815s89B9gskEklcG
         0W3A==
X-Gm-Message-State: AOAM5335ZH8rP+HSiIx51O7fe7nnB1/twVJ5HQP5ceLtjVQ3Pu8CATWf
	8Xk9rH/rwjdCA4OJJ0vhKPYdAdk40rufWUM7pcCKlzB7eoh0UCqWKZkLN8aQ1mKcPKfA/vM48cp
	p5lH+5mNK+eEugYUgE2UlevxxHWlHwS9oc7Bwmuy9VmBjrtuSgF2nsHVsDW5NAMHe
X-Received: by 2002:a17:906:fcb0:: with SMTP id qw16mr36985406ejb.495.1637939772286;
        Fri, 26 Nov 2021 07:16:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKMIofpvyiESG6FuMP+8aiZXtYlG6D0jYcJql+IuRVgZSLDDPO9CjIyIhfxl+A1KP7a/XLDw==
X-Received: by 2002:a17:906:fcb0:: with SMTP id qw16mr36985375ejb.495.1637939771940;
        Fri, 26 Nov 2021 07:16:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-118.dyn.eolo.it. [146.241.234.118])
        by smtp.gmail.com with ESMTPSA id ga37sm3257466ejc.65.2021.11.26.07.16.11
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:16:11 -0800 (PST)
Message-ID: <e889d930584a5b48d866f771ab839a5f4060caf2.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 0/4] mptcp: improve subflow creation on
 errors
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 26 Nov 2021 16:16:09 +0100
In-Reply-To: <cover.1637929034.git.pabeni@redhat.com>
References: <cover.1637929034.git.pabeni@redhat.com>
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

On Fri, 2021-11-26 at 13:19 +0100, Paolo Abeni wrote:
> This iteration just addresses a compile warning spotted by the
> CI.

I'm sorry for the confusion: this is really a v3, not v2. Hopefully
patchwork is still happy?

I could not even say ENOCOFFEE because I just had one before posting.

Cheers,

Paolo


