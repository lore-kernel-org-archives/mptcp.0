Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25DA51
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664355930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRIihbciqq9gaoN4Wf1leHDrnGf6+4WoJ5xSWPVUa60=;
	b=dUEr72U5d+x9efnqaJ5DRGNnBkKZVPF1a6LjOa+rd3xwihFdlO0ScwVbCFrkDqd4LdshMN
	BJ+puCQOcCX5ejnG9dPF9Gkr9XwdESHseG5pt9Sap75wwQJxyQhULjXwQ2GYNzPTpeLODf
	a0pl2cIsXBZHxh0Z2YsBP/atjTLpaqs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-253-bYE8JragN2CPY_loMqAzPA-1; Wed, 28 Sep 2022 05:05:28 -0400
X-MC-Unique: bYE8JragN2CPY_loMqAzPA-1
Received: by mail-wr1-f69.google.com with SMTP id s5-20020adfa285000000b0022ad5c2771cso2797589wra.18
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 02:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=CRIihbciqq9gaoN4Wf1leHDrnGf6+4WoJ5xSWPVUa60=;
        b=kpsvZhd7JMdjxyWkdcA6GXIeYzbdDPL7e6RK8HDICgQqkuXTTgg1ZOm7E0tNWuRVCc
         4h9XWuvI/KazMcDtRE5ALXFWPp/t8Jzr+jGqSXcRMaBqueuOxYzHxMpLUhTna8jCiwS/
         5d7UaC/JghgIuOkWQwWelLn0O9oB9YCw6EGbXvPyKjmXPCYr7/LLIr9WPxfhqkbDqBZJ
         uzhXu9FZMq/E40tW7l6bA5ZDRuY2oloYn23YzfeaE4e6kfjnKpkTuVtPeGQ0IJgZ07Aa
         WiNHkhGTU9CDDOlmd6i6lUzRZi9m7paImNXBkJXQIQ3JjxnTNAxJ+zGhEvnQu988vfQg
         FLFw==
X-Gm-Message-State: ACrzQf2+hVQ2dplGfMAm93Rk24JD1IUHZCX85M2EUkiekJ1exygkol63
	lpFQQEUtJGFKF+8TX28/fAxBztQmeTS9Ee15FVIKwgFi4T5P9eyadoD/15KUYQGqg2BMoad69Lh
	9Ga9LTO5qsA9MVIo=
X-Received: by 2002:a5d:5089:0:b0:229:3151:2865 with SMTP id a9-20020a5d5089000000b0022931512865mr19244336wrt.81.1664355927649;
        Wed, 28 Sep 2022 02:05:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7HE1ZYWYsfIhwuCx9AHAYp89CNegvWG1ENTafx89rgGybHd3NXXv6quncaY4F2lWqi7BMn9A==
X-Received: by 2002:a5d:5089:0:b0:229:3151:2865 with SMTP id a9-20020a5d5089000000b0022931512865mr19244318wrt.81.1664355927422;
        Wed, 28 Sep 2022 02:05:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b003b31c560a0csm1181027wmq.12.2022.09.28.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:05:27 -0700 (PDT)
Message-ID: <b56f6e1787e3532afbb91c97cab97a6e06011f24.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v12 2/7] mptcp: fix retrans., add mptfo
 vars to msk
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Wed, 28 Sep 2022 11:05:26 +0200
In-Reply-To: <20220927225341.14165-3-dmytro@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
	 <20220927225341.14165-3-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
> With fastopen in place the first subflow socket is created
> before the MPC handshake completes, and we need to properly initialize
> the sequence numbers at MPC ACK reception.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

Nit picking: I think this patch subj should be changed to something
alike:

mptcp: implement delayed seq generation for passive fastopen

The main point is that reading the current subject, this looks like a
bugfix, while instead is adding (a piece of) a new feature.

Thanks,

Paolo

