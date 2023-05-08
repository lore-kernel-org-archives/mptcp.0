Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4CEA93B
	for <mptcp@lists.linux.dev>; Mon,  8 May 2023 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683538356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWkdtBVD2aVZDeW0b8R1LySMY+BOtR5FcxRcUp/n4CA=;
	b=XDjCAN2m3ucIG6I997GGO0bhUskfqbLHdc1+mfowPqc4QCMR57Y074mM30mzCZAaas117k
	NoYbEz55ovKSXSOA4gqwy+p/za7ckkqAih9XMF6JarJcVuB2xsjREuS3qkLZ4J4b6FxeL9
	9t/SbgNifFPrBSEw0c8D/ENzRKdPpqs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Tnt27f9DOEazTiY0qNFG6Q-1; Mon, 08 May 2023 05:32:34 -0400
X-MC-Unique: Tnt27f9DOEazTiY0qNFG6Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3079087c27eso13897f8f.0
        for <mptcp@lists.linux.dev>; Mon, 08 May 2023 02:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538353; x=1686130353;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWkdtBVD2aVZDeW0b8R1LySMY+BOtR5FcxRcUp/n4CA=;
        b=bgII0jEqJS9PnMd0tMGKlRqEYWCFyBZDVwZlPJO4yRwgvgCyh47+xEVQfUOFZTLf+P
         x3VAk1LEgS5R+/PzZQTWVo8kFWPM0cBg2DT29tyXja6VSgEO/dqZsE+FvCUKlnZGDyCz
         /N7Yy6pswQz+x3VClRjna7Kq0HD55svY+++HPxM+AQnrVm7oEpumjtS5V4YKNJ7gGjLD
         bcLtSpqsr8+I5DMlHfI7e47zzeFdD78u+V65K3ex5Rp/6Pi0aDznZkR3E3WORikXYFWp
         yuM7ZW3ke6wTofjiwznJYKFnR3QkoRHP8ZgDlACyacDvTrh3XiWHyJ+O7u/U3kx3prQp
         ND/Q==
X-Gm-Message-State: AC+VfDwCoj1uDa/AorWQBj4hVNDrhP+NByMLJ6VMXvdVUwiXwu2gk/Wn
	wasU1l4s37y5Tw8JLMvOpK793O3L+xiqooVGP6evGAZmeip+b5KlybZJ1tcdi0Evf4xAHcnplL+
	oa8PSeX8Qlxj+k2HRQcAMRVNT94ei/MwlpUSmvsaMFo3qmvIo8cAGtgTnBjnZRhWW0Asvqap1
X-Received: by 2002:a05:600c:3ac9:b0:3f1:7a4b:bf17 with SMTP id d9-20020a05600c3ac900b003f17a4bbf17mr6613860wms.1.1683538353404;
        Mon, 08 May 2023 02:32:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oKx9Q2Dg5N9U5puYESvrrpPQMacOLDBmae5I8BQrGbDM07EviwGTvLDhaaH/MZlwe8+GCDQ==
X-Received: by 2002:a05:600c:3ac9:b0:3f1:7a4b:bf17 with SMTP id d9-20020a05600c3ac900b003f17a4bbf17mr6613843wms.1.1683538353055;
        Mon, 08 May 2023 02:32:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-175.dyn.eolo.it. [146.241.244.175])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003ed2c0a0f37sm16247202wmg.35.2023.05.08.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:32:32 -0700 (PDT)
Message-ID: <fbe6a5426a0532d76b3c6884cb37b8d0d0f14120.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix connect timeout handling
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 08 May 2023 11:32:31 +0200
In-Reply-To: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
References: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-05-05 at 21:34 +0200, Paolo Abeni wrote:
> Note: there is needed follow-up correctly propagating the SYN_SENT
> -> CLOSE state transition from the first subflow to the msk socket in
> case of connect error, but that is somewhat independed/pre-existent.

Re-reading the relevant code, there is no need for such follow-up:
commit 1249db44a102 ("mptcp: be careful on subflow status propagation
on errors") already take care of it.

Cheers,

Paolo

