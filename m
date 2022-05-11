Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0917DA
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1652268509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tBPOAVVxF3zjlO9+CD6YfpaIaXyxfk33r9ysLCheRU8=;
	b=Bc25v6NItcO7sIWYVgCuvYAbpmEqM/udpPTv0XtEPGahlvySn/Merp2txyrD3xoG1IZQaj
	vlKDBBAebwdEhKIHCTe1BS93PdHMbnvJv5TPwm6CEVcJwAAcrYOFzej65YeKRHEtO4u2tc
	maJfL1qSjCRsexflh1an4TBoX/QE3n0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-bbUlkTsiM6qo63nQ5H-fiw-1; Wed, 11 May 2022 07:28:28 -0400
X-MC-Unique: bbUlkTsiM6qo63nQ5H-fiw-1
Received: by mail-wm1-f70.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so590082wmb.3
        for <mptcp@lists.linux.dev>; Wed, 11 May 2022 04:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=tBPOAVVxF3zjlO9+CD6YfpaIaXyxfk33r9ysLCheRU8=;
        b=WT+WBZgF9EPHa6l+BsPsFTZ02WXt/l17tZvSK99KXIOH4mPk19daLCWXnFvvz+yvoh
         oMj1KuEg45y7BfjV6gNZJ0ZZdBHrjMi5yULA92cRJIpA8pKMeTT7zPvVo8f2otrrBlKB
         Gnh+Q9TEquifGGvM/01njQivzIz8YOcFMCzF/dtQDxpF7DJmWCD5UjMjFLvAHW2r+LTi
         yd9F3SgvHBQUaPaz3X4yZtPSUQ+QxLrwMgxkxbCF00q6oOJcoaL/g16uMmMRUFC2v0bb
         c7YP64IgyKdDX98U9D9BbvC12LXhNaRjnDO/Aa/qaS4RWhjAU6qFEjWsjEpTNDvFrY/v
         T9IQ==
X-Gm-Message-State: AOAM532PbjfZcnHasjDe+XPoo39+74MFZ8YwBk19CVCXOY51ghJBSGxS
	TaUZ+DCFKKNJ/uaiec7rVzu+aFJMPOLqWEagHB3ppy7VB0XvAKAvm9w3EtUvYXvNhrRaoEi6VCh
	mWJSc0U8CDQOwXejBQJnDV2CZWCOJfUD26ZdJKyIEe8pcNdOVJtq16fo1XT9t8UlS
X-Received: by 2002:a05:600c:154d:b0:394:8d64:9166 with SMTP id f13-20020a05600c154d00b003948d649166mr4378823wmg.102.1652268506948;
        Wed, 11 May 2022 04:28:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTU1Wbmsbb2E6miYF6edUYCxrquPg0h3LtCGwvM7PDcs8wRXZAizwKDO9lbmZieuPO8CRrxw==
X-Received: by 2002:a05:600c:154d:b0:394:8d64:9166 with SMTP id f13-20020a05600c154d00b003948d649166mr4378793wmg.102.1652268506614;
        Wed, 11 May 2022 04:28:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003942a244f4dsm5066075wms.38.2022.05.11.04.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:28:25 -0700 (PDT)
Message-ID: <cf419fbb3022f54fa63476a75361a016a7051367.camel@redhat.com>
Subject: problems with MP_FAIL timer
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Date: Wed, 11 May 2022 13:28:24 +0200
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
Content-Transfer-Encoding: 8bit

Hello,

re-reviewing again the commit:

mptcp: reset subflow when MP_FAIL doesn't respond

There are a few issue with sk_timer handling, specifically:
- no additional mptcp_data_lock is needed to stop/reset it
- I think overlapping infinite mapping reception and close may lead to
some inconsistent timer usage

More importantly I could not find the RFC reference for such
timer?!? @Geliang, @Mat could you please point that out?!?

Thanks,

Paolo

