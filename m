Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8F3FC3
	for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631286488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQfII+1IihHe7XZ+44pZ3rE0ZVc6ad9uc7NOcIbeZi0=;
	b=Y3MeN6/IPjj6rMkrmtwSVlSM9Q0/RRcAZykfCUDjqgbHUbYL3hgeT63GPw/tCf78goQTUm
	kjE2TNOs4G+FBC1SYFMQIfw+8jdkxFMTzCcWcBCSxSbpank0/hqQ9DPEcUB4lXRSByYpkC
	t0LZ1kvCDEo5/MGN3L8TgbnHKy5Lx5Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-D5YkomxPMFO9xyDTSJIeHw-1; Fri, 10 Sep 2021 11:08:07 -0400
X-MC-Unique: D5YkomxPMFO9xyDTSJIeHw-1
Received: by mail-wm1-f71.google.com with SMTP id n30-20020a05600c3b9e00b002fbbaada5d7so1053247wms.7
        for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 08:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hQfII+1IihHe7XZ+44pZ3rE0ZVc6ad9uc7NOcIbeZi0=;
        b=EOjKIdh6jZjDAfNyIflXKQ0Rd4r+lARrO4Pl8XGKlEecqFmaK2lqdO4Kl8EhjqOX4A
         9NM/oKlSZjFnjCFw+FHcLj4Nx2uOY+Ph+HZK7AqglQ8b2+AyU0rwiOE7dCNmXLYirN/O
         1RJH401CRzG6YX6d0r7KMYYaU2IDOpXxvVAd9kmv2L7zMaqfCu/WLggf1N4MZo3H6jgb
         iOL2MlNdYJ4cF7a2cMXpo1jK61/23VeS+cPXLS3VyrvKHwykkLW3jTyqiLLAyscCSljY
         Ab8HfVdAGgYwDHhvFVhIoOAvvAgdTBkq/f1cn7qc5+KE4KW7KYQ9FPy2Q6djZypPKTwL
         /Hig==
X-Gm-Message-State: AOAM530yyIhgQw4vGOO31z+qMpcS2h8ozt6F0wUFUnFAUzUn98WMvCze
	UVsfRlsxZsg4lURpVkJe7gz/TK+JKwhWtSDyHRXj7/IbxtjB+O/YjcKmlfODUZ2XUJ66sBm5IYw
	vsaxkGHDWJzv5Obc=
X-Received: by 2002:adf:a197:: with SMTP id u23mr10158051wru.253.1631286486430;
        Fri, 10 Sep 2021 08:08:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRvQ2gRddm/yBioVy4204U+Bg3e5syrTXMOw3BhWULsgu3oR040FTS+krX21Co1Jn5I99tuQ==
X-Received: by 2002:adf:a197:: with SMTP id u23mr10158030wru.253.1631286486247;
        Fri, 10 Sep 2021 08:08:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id c14sm4972312wrr.58.2021.09.10.08.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:08:05 -0700 (PDT)
Message-ID: <4300fcede93507b5d6c8d3e743007e31985ce84b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/9] mptcp: add noncontiguous flag
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, Geliang
 Tang <geliangtang@xiaomi.com>
Date: Fri, 10 Sep 2021 17:08:05 +0200
In-Reply-To: <4e24a896-b1bf-c6ee-2db9-4d1d572c99cd@linux.intel.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
	  <138e3913108d313b11a261e6c9e3db2cc788183f.1631188109.git.geliangtang@xiaomi.com>
	 <7147f377124eaa4445aa11e8f8f4efbd72d69261.camel@redhat.com>
	 <4e24a896-b1bf-c6ee-2db9-4d1d572c99cd@linux.intel.com>
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

On Thu, 2021-09-09 at 17:00 -0700, Mat Martineau wrote:
> > On Thu, 9 Sep 2021, Paolo Abeni wrote:
> > msk stream is 'continuous' if and only if 'before64(last_retrnas_seq,
> > msk->snd_una)'
> > 
> 
> If last_retrans_seq is checked only when msk->noncontiguous is true, I 
> think that works out. Otherwise the last_retrans_seq is stale/invalid if 
> retransmission never happened, or any retransmissions have been fully 
> acked.

I think can we just init 'last_retrans_seq' to intial_seq - 1 at msk
creation time and we could always use the above check:

	if (before64(last_retrnas_seq, msk->snd_una))

WDYT?

Cheers,

Paolo


