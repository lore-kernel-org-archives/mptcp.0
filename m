Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4262B577
	for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692727809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/j+wEnE2HPsRw2LlNr3EAu2lEVIba2wfuYHIy/vZyU=;
	b=ieroOMTvkpcQvq4xoka7iccKkqJhs8Pvmx9eUwLOtnI/KPS/OjZJdCwuOrj5Of3++UBbm3
	TWBtHiCrMuGMCga5qEE1iskYEBWYLnA/XfVk0Il03I/M52XM9Gr4P4fb66YwiNqV4wOr4Q
	OFUQmk6rqjD/s++fqTNDIXM2cWeJiu0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-iaTNle0EM3m9iW6uVzP2dA-1; Tue, 22 Aug 2023 14:10:07 -0400
X-MC-Unique: iaTNle0EM3m9iW6uVzP2dA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31adc3ca07aso2838977f8f.2
        for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 11:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727806; x=1693332606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/j+wEnE2HPsRw2LlNr3EAu2lEVIba2wfuYHIy/vZyU=;
        b=lzBdIc0wH2/MGPyU2f0MOKcV5aCEey01HrcoDeAFLmTDvliH25l1xTzU/F4YLv1ejN
         W3Tam9fr6eBH0Uaz4GVHic1MN1JUCjCtsKTulPv5daOWZZQZR056WU5MCcSZcxwSyX9x
         rKpoKnClE/l9ugc3sb+W0wdJfOzXLgbCVoNXrkYmBPW/nP+JD+0dyRSEVgAu3zhpMt8W
         wro9FJ/01mIBWBwCKrF2qqhAD0/QIqRapXrBOazCR8hCo+FNAOicKge195+WMGDUdk3N
         ofTDmKSOb+qhCz2U4PtvvJxZkpDgwDNWa932Jjyn7jHlCY56Xz7EYAWOoM31ITl2Ie81
         iYHw==
X-Gm-Message-State: AOJu0Yw1OHHFXZOYlBBvv8pPyt0bJ3qZigjmoheNiHvxyxjJQ20tZ0YO
	bngBAg5yfL4garP/liAnNgjwhBb1MP/c33O+FuI2RYypY9m74lSJ595qwZAZ7ELavXIegHNBiag
	0AizVemEBkzMRNuz+odLTkNI=
X-Received: by 2002:adf:e501:0:b0:31a:e376:6bd6 with SMTP id j1-20020adfe501000000b0031ae3766bd6mr7918645wrm.45.1692727806221;
        Tue, 22 Aug 2023 11:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVnsmrCZFlT++AlakwwCDFyWXUY44t82zeq1lJX0y+nHb92toB8GmdFkMQ0xyhG6EV9mJwDQ==
X-Received: by 2002:adf:e501:0:b0:31a:e376:6bd6 with SMTP id j1-20020adfe501000000b0031ae3766bd6mr7918631wrm.45.1692727805909;
        Tue, 22 Aug 2023 11:10:05 -0700 (PDT)
Received: from localhost ([37.162.223.153])
        by smtp.gmail.com with ESMTPSA id t4-20020adff604000000b003176aa612b1sm16410101wrp.38.2023.08.22.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:10:05 -0700 (PDT)
Date: Tue, 22 Aug 2023 20:10:01 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-iproute 0/3] ss: mptcp: print new info counters
Message-ID: <ZOT5+d4s4tteHvB+@renaissance-vector>
References: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 05:27:25PM +0200, Matthieu Baerts wrote:
> Some MPTCP counters from mptcp_info structure have been added in the
> kernel but not in ss.
> 
> Before adding the new counters in patch 3/3, patch 1/3 makes sure all
> unsigned counters are displayed as unsigned. Patch 2/3 displays all seq
> related counters as decimal instead of hexadecimal.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Matthieu Baerts (3):
>       ss: mptcp: display info counters as unsigned
>       ss: mptcp: display seq related counters as decimal
>       ss: mptcp: print missing info counters
> 
>  misc/ss.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> ---

For the series:
Acked-by: Andrea Claudi <aclaudi@redhat.com>

