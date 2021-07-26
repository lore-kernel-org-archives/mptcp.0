Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE770
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627287943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQQ/Gv1lPIeTxY78I4R2R/gz1b9e+3YDnLRYuZxZVAc=;
	b=VBlvy7GNMq41R/eEhhHcmZkvl9Axt3UJBCVCAwn3XGjPSECMG87rf4oNNsSNX9m+7ER4rM
	MP3/Lmfm7oT9/cCf+fIR1TSH34oeIIKGoTk8i2hoAAg9nfPPZtvjdqO0tLnJ4fLq7wxuun
	A3a/PsnGwPJ9bUGXeZyNmRGyqHuTeVw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-9Zz0EXRaOYe8Wx3i1wWFHQ-1; Mon, 26 Jul 2021 04:25:41 -0400
X-MC-Unique: 9Zz0EXRaOYe8Wx3i1wWFHQ-1
Received: by mail-wm1-f71.google.com with SMTP id j11-20020a05600c190bb02902190142995dso2435935wmq.4
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 01:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dQQ/Gv1lPIeTxY78I4R2R/gz1b9e+3YDnLRYuZxZVAc=;
        b=seAVSHlqsJewpU4W7z6eKLdLsvlGtgFXYvhi2V3/BkRThCiAfNt9bLQjLFDUSsN2C/
         JlohH71PyQ9lDELoLNrP0hgadFvt9z0ojjekaJB6K7zVbddGV6uhOxm4XAEnbYeCgesM
         DuZEK4PqJiFzqv5E1U/7qzzaHoUwQaOrs8FpQpqSg3G+5MQI4Obce2GoSSu1Wkfy4Gxm
         j3fomoeImPPoaHrHSaEvM55DUSUIsgmZOPCLJ7cm2EFNS6qGaHxd8qk6PtvsPfirl/4L
         gCaXXdFK3u5LSvDUveb+J/Ro2GsEIqCAbM8Y7v+IVygImY4h0g+OTVxgVrhBNdGLt/JC
         IrrA==
X-Gm-Message-State: AOAM533nR+rJXABr3Nv4ydMh3en0IePhUQ2fvqoL99NBKzS7VAkDmhpV
	VF3nr6C+yKzwBOgwFQ3SVRbXuMa6URCzek5Hahhfk8wC/TQpooNBuHLXkOduUy73nK8ZYERN/LC
	+zApjnBdT3McJvjo=
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr866677wrj.143.1627287940539;
        Mon, 26 Jul 2021 01:25:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws4sqHDmaPvMykIJ36Jbh4Ap7uAjTe6d4xFompJx01oiMdCFuvQkanYf8JbOZsbyzFiNY86Q==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr866667wrj.143.1627287940421;
        Mon, 26 Jul 2021 01:25:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id q63sm1861118wme.36.2021.07.26.01.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:25:40 -0700 (PDT)
Message-ID: <64d4079290cfb03d6a5c4ffb44478a770854b228.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 3/5] selftests: mptcp: set and
 print the fullmesh flag
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Mon, 26 Jul 2021 10:25:39 +0200
In-Reply-To: <3e4690d0d33f8285465e54870410266e22208acc.1627272435.git.geliangtang@xiaomi.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com>
	 <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com>
	 <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
	 <3e4690d0d33f8285465e54870410266e22208acc.1627272435.git.geliangtang@xiaomi.com>
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

On Mon, 2021-07-26 at 12:12 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch dealt with the MPTCP_PM_ADDR_FLAG_FULLMESH flag in add_addr()
> and print_addr(), to set and print out the fullmesh flag.

I'm unsure we should enforce no 'SIGNAL' flag is set on the relevant
endpoint. Likely not required...

/P

