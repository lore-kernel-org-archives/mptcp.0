Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8A72
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629795578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Cav89NwWTxjoYtgoOBON341GP6biIGCsp8P4e7Q9/w=;
	b=VQnyCkH3BGG0FcNPE+TykalIrZriPcwAktLfceyXjy+CDagD+1sn/vrsA5o0HYcKURgjBK
	HY2YsXJ5e+f+GuXgblogr6yGXWe/S6W+ULn/Pt+II6LFpVNbznQ466aNxHQ4VMEAUVqZIa
	MoaMl4M2obDDxC9PrH1vrnGtQLT+DCc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-uK7dW0lWMi6RCk29LEkGYQ-1; Tue, 24 Aug 2021 04:59:36 -0400
X-MC-Unique: uK7dW0lWMi6RCk29LEkGYQ-1
Received: by mail-wm1-f70.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so3863949wmc.9
        for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 01:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0Cav89NwWTxjoYtgoOBON341GP6biIGCsp8P4e7Q9/w=;
        b=YKXPVU5A9jh2nrBLdPi0GH1kYTwxU1/TjtFDPfN4xZU93Rpajl0F2fK4vkLrqqSeKK
         yh4c7RgKfkFDaF+d+kUp29glbcBDIB/PAENDyUxQShWJ27V3hNVKTtZz2cFRUvZbEVs7
         2ufBY0fbliDl6GrIi5080HZoJnit9VS+qn53WNLSX0M41QW+GId1uB6tBkudzydpvtir
         dquCON1xwwX6XpRCnAuvcXVXBs7v35gabD705wwlJJAnHX224HJpDpAK2x2S6qWZTez9
         LcDNdF7TqOkh8MqWwDWgugi1guQz5e9Bt+fg2IbC/1oXUh6PsNRrRT0lPDeSBPgMw8Yq
         cG5A==
X-Gm-Message-State: AOAM533aJQJDSKAzh19OiqXblME1oaKUfzuwxf2d8WhyO4rHBr94byZl
	0VuaUndq8V24ID6DT34KpL40My76xmn36rzWscy4O57++puqzmPG6jLfNongo/ZGcckmltGAfxJ
	71Zva0Stc2mHVsXg=
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr3079388wmj.185.1629795575350;
        Tue, 24 Aug 2021 01:59:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqc3lIeHWPhFLIzFFeaFeJlRD7liTudpb1u7X8R6HI7vtfP4I66FJ6rMFTJVzwgPntRL3utQ==
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr3079371wmj.185.1629795575109;
        Tue, 24 Aug 2021 01:59:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id b15sm18794006wru.1.2021.08.24.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:59:34 -0700 (PDT)
Message-ID: <a740d2b1755700420f86dce2b14267eac1ea1c5c.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: clean tmp files in
 simult_flows
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 24 Aug 2021 10:59:34 +0200
In-Reply-To: <20210824084751.3490436-1-matthieu.baerts@tessares.net>
References: <20210824084751.3490436-1-matthieu.baerts@tessares.net>
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

On Tue, 2021-08-24 at 10:47 +0200, Matthieu Baerts wrote:
> '$cin' and '$sin' variables are local to a function: they are then not
> available from the cleanup trap.
> 
> Instead, we need to use '$large' and '$small' that are not local and
> defined just before setting the trap.
> 
> Without this patch, running this script in a loop might cause a:
> 
>   write: No space left on device
> 
> issue.
> 
> Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Many thanks for catching this!

Acked-by: Paolo Abeni <pabeni@redhat.com>

