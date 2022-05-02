Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3757F
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651478117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vW07XR5BH9dujMZlPEZnwEggHPNUeTibM/KSg4uu0o=;
	b=bWsmYH76N9aU28c4itPGu77gokvYjbygsrYMRBiRep+C26bvw9MO283xhJWxqEWBxoyLZ/
	J9EcaTDLpz+gvZBslivWK68gowncYo1VuSbPyd/2/sTLAqdKkQr7dcAxJodpRctRZeNjN8
	Uy4JjMWj9gm0lO0hs0aowYFpDv/i45I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-NS76lygDMg2h5VObdgsL2g-1; Mon, 02 May 2022 03:55:15 -0400
X-MC-Unique: NS76lygDMg2h5VObdgsL2g-1
Received: by mail-wm1-f70.google.com with SMTP id v191-20020a1cacc8000000b0038ce818d2efso4792115wme.1
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 00:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1vW07XR5BH9dujMZlPEZnwEggHPNUeTibM/KSg4uu0o=;
        b=FyaFEboVgEOA3h+5u3XkOu2z/hIKm0RP+Wp1+xbaYkL+XHXqbpwCBSC1jGvEAQVsQI
         ovF5h83rpagPIlTmfEgDmmDlKhCNOfDuBtvvYYjjqRurBsPqpJI1e/U4wQWpVEhGz7HQ
         QZ7BDrbS/bvg84lsI/EKSOkZITMgA1UBLTUdNnDMuDbKtHBAKenVmYZxUyVHJ/FCKUNm
         pY5WCCpMmMi9eF9A+R7UoUCGo04QpE8Q/Z8ANGSGM1g1sifB3OnVXGePFobJ7EX46nqE
         h2eeWfsf/XQtIxgPjCujF0pqU/haye4MBgWlANzWnv34IBlpGzu7WKw0mH8QsUKz1cB2
         JANA==
X-Gm-Message-State: AOAM530SZmtb10WuxCQ04pSIITAvhGMxWoG982b7Kw7NoFwypGc+bzC2
	kgMYLlagtC0d69Le0SuXvMkqjWJwjBuK4nJUnfAwLfG+NiC2Jwf4CSkP4D6hDQKlgTpEwr5OWMQ
	Fx3oX3Pn9tMsXyFY=
X-Received: by 2002:a05:600c:1e1d:b0:394:1b19:e347 with SMTP id ay29-20020a05600c1e1d00b003941b19e347mr14090274wmb.202.1651478114140;
        Mon, 02 May 2022 00:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFegx0nAGmAxNDawkECLOMlwwt8V2/6Vj6wVU7gS4hD5YKVITf5NMSNTE/ayZn/PxqymJW5A==
X-Received: by 2002:a05:600c:1e1d:b0:394:1b19:e347 with SMTP id ay29-20020a05600c1e1d00b003941b19e347mr14090259wmb.202.1651478113893;
        Mon, 02 May 2022 00:55:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c231000b003942a244f40sm5589206wmo.25.2022.05.02.00.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:55:13 -0700 (PDT)
Message-ID: <12a4ac76eddf80868bd61dcadfcb972d597ba629.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2] net/sched: act_pedit: really ensure the
 skb is writable
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 02 May 2022 09:55:12 +0200
In-Reply-To: <7c93496c-5153-5b83-48a9-6dd75da42542@linux.intel.com>
References: <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
	 <7c93496c-5153-5b83-48a9-6dd75da42542@linux.intel.com>
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

On Fri, 2022-04-29 at 13:56 -0700, Mat Martineau wrote:
> On Fri, 29 Apr 2022, Paolo Abeni wrote:
> 
> > Currently pedit tries to ensure that the accessed skb offset
> > is writeble via skb_unclone(). The action potentially allows
> > touching any skb bytes, so it may end-up modifying shared data.
> > 
> > The above causes some sporadic MPTCP self-test failures.
> > 
> > Address the issue keeping track of a rough over-estimate highest skb
> > offset accessed by the action and ensure such offset is really
> > writable.
> > 
> > Note that this may cause performance regressions in some scenario,
> > but hopefully pedit is not critical path.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> > - fix build issue
> > - account for the skb hdr offset, too
> > 
> > this almost solves issues/265 here. I'm still getting some rare
> > failure with MPTcpExtMPFailTx==0: sometimes the transfer completes
> > before we are able to use the 2nd/failing link. The relevant fix
> > is a purely seft-test one
> > 
> > Note that a much simpler alternatives would be simply replacing
> > skb_unshare() with skb_ensure_writable(skb, skb->len), but that
> > really could causes more visible regressions
> 
> To make sure I'm understanding correctly: skb_ensure_writable(skb, 
> skb->len) would copy the entire packet payload on every edited 
> packet, but this patch will only copy the part that might be modified (and 
> maybe a little extra). 
> 
Yes, that is. All the above when the relevant packet is cloned.

> Seems like the full copy is worth avoiding, and 
> that users shouldn't be depending on pedit modifying shared data.
> 
> I did run the associated test for a while (with the other patches for 
> #265) and the changes look good from a MPTCP perspective:
> 
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> Do you plan to upstream this one yourself, or should I include it with the 
> other mptcp-net patches?

I think it can (and should, to avoid blocking mptcp patches with
net/sched discussion and vice-versa) go on it's own. I can send it.

Thanks!

Paolo

