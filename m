Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56A3D9E
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 08:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659084258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPxRvxvHSbBcGdGxwkPlHvTQXiY6piDqwU3BVns1Qko=;
	b=DsYbUoqnlnBxFL234BqWFA4g6r+nGXcQQtsAXYAQ2JkH4x3Lejy0q2mNpxXU5xg6vXM0pL
	sMnevvAIi0/DOU1palUDHObBAPdfUzCdc4ecwok8lqHtiJZ8CMqqOsmMe4A4l+4lPG0NTw
	ve4K7t6j8DSnSpn4TApIjlmW8CW+8aA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-HGoTQLiyMxGlT5S6FuedSw-1; Fri, 29 Jul 2022 04:44:17 -0400
X-MC-Unique: HGoTQLiyMxGlT5S6FuedSw-1
Received: by mail-qk1-f197.google.com with SMTP id br36-20020a05620a462400b006b5fa8e5dd5so3099166qkb.1
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 01:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RPxRvxvHSbBcGdGxwkPlHvTQXiY6piDqwU3BVns1Qko=;
        b=3A7FEvYlJhMJql+j8BEMg12uDkqw3/6SoQ0rizDpEOSY3Sfw5QwhpyMAqCFEacG9/t
         aUnj0u5u66Pegg4eoLyof+x5cmDgpTJ8xcfDVaVKYs7OYL0xL7KVMXBNaEjGve8pTinK
         t7CFUmSnZaU38Hn3YC5qme+3gGdRmETmhJV3Wu3FjMaRUu9vrg8D4WPIZg7pDpi2/lOU
         oYltKmodQqVzmvrygXNL8deKc+wUMHgXzQ1beGm+laRc71BtyPkQJKMqOqiCRBMqQA27
         9sqPvl9jx6Er+CTdRgyUAtgYx661caLRMgiQ+C7HBWZ0R/ou4H3aQMD8CtCDPKQQ/5kW
         8lxg==
X-Gm-Message-State: AJIora9pC+EBApeQw5UdqHfN+38msj8wpyg/17uundztTMcUWx0ONd5T
	6MP6XI6148YSmHf7DPK+JMNE/Zj9g+3evB27HcvDgPgjiF4jNAbyVPpWXm97ZhRMzQ1ezp/8FN5
	b7aitOFj34SmQY+U=
X-Received: by 2002:ac8:5b8f:0:b0:31f:402b:92ad with SMTP id a15-20020ac85b8f000000b0031f402b92admr2452017qta.188.1659084256791;
        Fri, 29 Jul 2022 01:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEh4N1d4AbXITOC4hH7/Y43XHfEzX520GxcOSGNHQHDq4Ap+HQormKxdM6EdI/RcVd2+UYCQ==
X-Received: by 2002:ac8:5b8f:0:b0:31f:402b:92ad with SMTP id a15-20020ac85b8f000000b0031f402b92admr2452005qta.188.1659084256477;
        Fri, 29 Jul 2022 01:44:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-164.dyn.eolo.it. [146.241.104.164])
        by smtp.gmail.com with ESMTPSA id do54-20020a05620a2b3600b006b5e833d996sm2153480qkb.22.2022.07.29.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:44:15 -0700 (PDT)
Message-ID: <43887faf858ff3f2e245df6e331f0ff03e4e3aef.camel@redhat.com>
Subject: Re: MPTCP patches pending for -net
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 29 Jul 2022 10:44:13 +0200
In-Reply-To: <73f44e58-3ead-e2fc-ac83-4e3ee99d534@linux.intel.com>
References: <73f44e58-3ead-e2fc-ac83-4e3ee99d534@linux.intel.com>
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

On Thu, 2022-07-28 at 16:06 -0700, Mat Martineau wrote:
> Since we didn't get to discuss this question in the meeting today: With 
> the final -net pull request for 5.19-final already sent, should I wait 
> until next week to send the two patches we have in export-net now?
> 
> mptcp: do not queue data on closed subflows
> mptcp: move subflow cleanup in mptcp_destroy_common()

Yes, it make sense: PW is pretty crowded now, so it's better to wait
after that net-next closes.

Thanks!

Paolo

