Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA483FC1
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630484030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uyDrxtsR94VMPU5MaJ7LybPMEr60Xgeln0jH3Y/pfWo=;
	b=cn7FYvcHM97I3JiM4ix1s6EOhakzNRj4dUErSNBEOecyxfg1MEcVgQa/E0JSEHejw2wrb3
	lawg1FmbJ8jSxBgCMLR6oxEt0+rY4at5oz/gOehL4vCQgVrqkFD+tQX4VcPA68P7RNZqOZ
	zprUKFPYdekYIdltH5JgYyVkMYjeBE4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-o2zxR0AWP42RdlABmxVPLg-1; Wed, 01 Sep 2021 04:13:47 -0400
X-MC-Unique: o2zxR0AWP42RdlABmxVPLg-1
Received: by mail-wm1-f72.google.com with SMTP id a201-20020a1c7fd2000000b002e748bf0544so2484154wmd.2
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 01:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uyDrxtsR94VMPU5MaJ7LybPMEr60Xgeln0jH3Y/pfWo=;
        b=fRfmr7DDdq0cqRnadeFffZEf2tvri7jYVUFiynx/MFB7wworshsCJ7+QyezggzsMDS
         52739OfQ++Pbfb7AGgfVJhjW17qLB4JeRU2hHL6vAWu4Q5XU1IJm7zxl7L730BPk2suQ
         QlsxV4d9OFcZdTiYR8iViPEgOIODD5VIxBo9DTTy9McOTvR224OFU0KZ98d1NpOiNSxV
         VtLL7iq/hmXeoQPlFzS31Q6cegh5Rspn4KWJVVCU57Rb6zMUDohF9av0ZiAkKFVP97YI
         i89J9QIJFala3WpffrocPoWByxcp1WFXHYaiQBFtNw8uhOJKxkACmN0KLlEk5tR0HeOZ
         xH3w==
X-Gm-Message-State: AOAM533BmmPfDV/TT1bB1bH2Ez2nMVdqK+VxZ7fzc/kBV99CrrpiUBS0
	xlNEr92FbUGQlwM3unLLANwMV67AqRGj5j+sYq1yzL7kYCzlpZFwvDh9iNqn3PW1VG+dgeHdTBt
	YaBbkrW1JDK7KVA4=
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr36069381wrg.358.1630484026644;
        Wed, 01 Sep 2021 01:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrnLwgdxjrPnEWEVBAyYagEpAefLy0ZBMaW08Mk0jB8RfFU+GX3ibBFf9h6AshyJy/RQ8VRg==
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr36069361wrg.358.1630484026470;
        Wed, 01 Sep 2021 01:13:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id u25sm4703254wmj.10.2021.09.01.01.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:13:46 -0700 (PDT)
Message-ID: <0b030119a755fb246a617f3ab30c7664d4f95323.camel@redhat.com>
Subject: Re: [PATCH] [v3] mptcp: Fix duplicated argument in protocol.h
From: Paolo Abeni <pabeni@redhat.com>
To: Wan Jiabing <wanjiabing@vivo.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski
	 <kuba@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: kael_w@yeah.net
Date: Wed, 01 Sep 2021 10:13:45 +0200
In-Reply-To: <20210901031932.7734-1-wanjiabing@vivo.com>
References: <20210901031932.7734-1-wanjiabing@vivo.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Wed, 2021-09-01 at 11:19 +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> ./net/mptcp/protocol.h:36:50-73: duplicated argument to & or |
> 
> The OPTION_MPTCP_MPJ_SYNACK here is duplicate.
> Here should be OPTION_MPTCP_MPJ_ACK.
> 
> Fixes: 74c7dfbee3e18 ("mptcp: consolidate in_opt sub-options fields in a bitmask")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Not sure what happen to my previous reply, most probably PEBKAC, sorry.

WRT this patch, note that the dup is harmless, as in the input path we
always use the mask and not the individual bit - vice versa in the
output path. Still the cleanup is worthy and patch LGTM.
Acked-by: Paolo Abeni <pabeni@redhat.com>

