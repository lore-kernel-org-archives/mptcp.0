Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B852F27
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1653327673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDpEhjStxU7dzRsevPa7m0gvfkZzjuqCquR9DWe/JIA=;
	b=WCyFx7wMa2K0VbhUtVUJfUlnBVlJk02xX9WgW6PB/E7otzwq1r6uMkOcQaO1yKHSg528XP
	YFtPdyGelgV/t45uvWxw3QehzGNTPNsueg5CAZFwVfNtz2bT56EXy7/I+OjJsvghnlws94
	H47lZPwKRgY79rQYz6JIKkWYLSbc4HI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-KbV-zC_8P1WFwYCyUjWHrQ-1; Mon, 23 May 2022 13:41:12 -0400
X-MC-Unique: KbV-zC_8P1WFwYCyUjWHrQ-1
Received: by mail-qt1-f198.google.com with SMTP id cn8-20020a05622a248800b002f3c7be2744so12011598qtb.17
        for <mptcp@lists.linux.dev>; Mon, 23 May 2022 10:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lDpEhjStxU7dzRsevPa7m0gvfkZzjuqCquR9DWe/JIA=;
        b=7v2e/3joGBU1t2n2k7vppHbHMupKq+wa8dlmhHnJQFteju8UGgSlZ3sNHHWY8Jy9X2
         Q8+QOWHtFwLMlD82fZ7Vpqtjk+c9L6BH237Szqjj0puacjjIXUyfiDLmu2oyGOIl/Exh
         dtjd5lSfoddj2N5y9bDRhA8RoE90w9iM8e50ohGDqmCy44lEghx3dzWeed5UyMDQ+9+3
         PfntPrDVwdxXOkfa0KVmAJYvo55zIbn1GlnaKDnq9/lErcKKxBO0mWXdYgJ8sGjmtXjw
         YBIJdbrZiB50XOnfQgNsYhn2ddkeAQTIF8qOIk58l1Kz7JnNhhIL8HrLABjm8e+Aq2KB
         rFHA==
X-Gm-Message-State: AOAM530l0scQLorLbRoudwUEOqh/JagWNBfWVwJ0xnxKcyWyKCNj7CTg
	e62k78EyhHgTeJVTpvVSVoH20ILuOPnjcE6dLCBJrwoNp+OSUnBhO9o7sg9XfDOZkoinw5N2Zso
	Fl48Wx8gL7jEHXrk=
X-Received: by 2002:a05:622a:342:b0:2f3:dd79:2463 with SMTP id r2-20020a05622a034200b002f3dd792463mr17735690qtw.468.1653327671928;
        Mon, 23 May 2022 10:41:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsozW3hBfyB5MSk15OM2Nv4N0IzfHLIgohY1SU/ycglOZm8BBTZBMKvWc5PDi0aRj9BtH7JA==
X-Received: by 2002:a05:622a:342:b0:2f3:dd79:2463 with SMTP id r2-20020a05622a034200b002f3dd792463mr17735673qtw.468.1653327671684;
        Mon, 23 May 2022 10:41:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id ca13-20020a05622a1f0d00b002f39b99f6c0sm4592532qtb.90.2022.05.23.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:41:11 -0700 (PDT)
Message-ID: <fc5e28d40fb054e586f84bc7b85b64b3985aa016.camel@redhat.com>
Subject: Re: Patch "mptcp: strict local address ID selection" has been added
 to the 5.17-stable tree
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Mon, 23 May 2022 19:41:08 +0200
In-Reply-To: <4668b747-35fa-d6b0-8390-24c0f8f62a71@tessares.net>
References: <20220523030625.741995-1-sashal@kernel.org>
	 <4668b747-35fa-d6b0-8390-24c0f8f62a71@tessares.net>
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

On Mon, 2022-05-23 at 17:33 +0200, Matthieu Baerts wrote:
> Hi Mat, Paolo,
> 
> (- stable list and netdev maintainers, + mptcp list)
> 
> On 23/05/2022 05:06, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     mptcp: strict local address ID selection
> > 
> > to the 5.17-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      mptcp-strict-local-address-id-selection.patch
> > and it can be found in the queue-5.17 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> 
> Do we want the patch below to be backported to stable?
> 
> It think it is slightly changing the behaviour and we might not want it
> there, no?

I don't have hard-preferences, but I *think* we are better-off with
this patch and the csum-one in without any additional effort, than to
craft csum specifically for stable (and delay it). 

Cheers,

Paolo

