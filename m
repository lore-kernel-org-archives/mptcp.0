Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64B7B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 10:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656497816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpNPEh7OSs5jdan8QDOwgWI7J7zD+n6D7qWMoj+4p+w=;
	b=CPRgQzKej6eUSbaK5xGx1omXpwhipwDIPgSBovpSVetBdtABVGWCgD6K3Sn7njCVTjlxoZ
	sIkgFayyYH2dvDwv/enzNfktqUBcUmEr8KbrappYTcf2Evrs21IXXEXgGxTMesabIMIZvU
	Ch5mlC5LYkGMbrEDoi14wCAcu/Qm8vk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-3b47dH4SOF25WeoJ9RHabQ-1; Wed, 29 Jun 2022 06:16:55 -0400
X-MC-Unique: 3b47dH4SOF25WeoJ9RHabQ-1
Received: by mail-wr1-f72.google.com with SMTP id a1-20020adfbc41000000b0021b90d6d69aso2268046wrh.1
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 03:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KpNPEh7OSs5jdan8QDOwgWI7J7zD+n6D7qWMoj+4p+w=;
        b=nYYIICKgr00W/R9+uci9lnE4rBZUOpdTpGekvqhJeV+V/98WPTaXLGZWsGZ6pXeiD7
         97xLAIcZRC3wGfDBm+1RX/XmRw/t4XNxrMA31/C1lHyLSSF2fsgqSpZaiiK5Hddw83QW
         hMlAPKR0b49Kf3TTxbo2oXb6zz84FJ1b+fc920rE2idIlpt8pLOkor31MI4eu1uMR8Mv
         FQ+DjHhYYBZ5wxtwiH1lwPYT/6lDV+l+qXTzy8HUdKuGgrUFaN0otEpQHdJxoPmWZ3zB
         GPGeCE8GAtwTdJUfvAI7k+j3AvJkcpk3X8T8VXifOUWxYbDSBrSkwuhN7j/270/MjlGt
         gxDg==
X-Gm-Message-State: AJIora/DHB/FtzKP83o7zrYTjMAv6I3m7LRmdxU3e35VnfiFvNmIETEI
	a4HaQW74JMEUmkjaap2YGPDrJNVQwmLO+GBulK4akqvk8h1cYKpU5DMZjZMhKR9Pm0drTJMBLii
	Buv4KGDDA4e7F9c8=
X-Received: by 2002:a5d:6d08:0:b0:21b:bb1b:d5f9 with SMTP id e8-20020a5d6d08000000b0021bbb1bd5f9mr2267325wrq.524.1656497814301;
        Wed, 29 Jun 2022 03:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tUYG+7A3t1TN++bnn9y8RisOFK9AoqLU4QDED8yt9Co2ePTwsFg9L2hWdVo3CPAbelLBNuAg==
X-Received: by 2002:a5d:6d08:0:b0:21b:bb1b:d5f9 with SMTP id e8-20020a5d6d08000000b0021bbb1bd5f9mr2267310wrq.524.1656497814082;
        Wed, 29 Jun 2022 03:16:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a05621dc53sm2549108wmi.29.2022.06.29.03.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:16:53 -0700 (PDT)
Message-ID: <9bfd377923a2c200ff8be000dcbe6b378504f8bd.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: support MP_PRIO signals with
 userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Kishen Maloor
	 <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 29 Jun 2022 12:16:52 +0200
In-Reply-To: <144ee4af-c481-ffd3-1eae-151557d28e9c@linux.intel.com>
References: <20220629012702.425574-1-kishen.maloor@intel.com>
	 <144ee4af-c481-ffd3-1eae-151557d28e9c@linux.intel.com>
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
Content-Transfer-Encoding: 7bit

On Tue, 2022-06-28 at 20:37 -0700, Mat Martineau wrote:
> On Tue, 28 Jun 2022, Kishen Maloor wrote:
> 
> > This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
> > to issue MP_PRIO signals over a selected (by local and remote address+port)
> > subflow in a MPTCP connection. It also adds self tests for this
> > change.
> > 
> > This patch series has been rebased to the series (in review) titled
> > "Locking fixes for subflow flag changes".
> > 
> > v2:
> > -userspace_pm.sh: added a sleep after issuing the MP_PRIO signal.
> > 
> > v3:
> > -use local and remote address+port (instead of address ID) alongwith the
> > connection token to select a subflow.
> > 
> > v4:
> > -fixed bug during rebase in v3.
> 
> Thanks Kishen. v4 looks good to me, and the builds look good (I pushed 
> equivalent commits to github to trigger a build):
> 
> https://cirrus-ci.com/build/6289402744799232
> https://github.com/multipath-tcp/mptcp_net-next/runs/7103422638
> 
> Looks like the github action got a little confused by the exact version of 
> the patches not being in patchwork.
> 
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> At the meeting last week Paolo said he was planning to take a look as 
> well.

LGTM, too. 

Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks!

Paolo

