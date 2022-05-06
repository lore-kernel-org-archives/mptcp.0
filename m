Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49EE7F4
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 09:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651828746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnPQyEeKbsHW1LZRu1jU8z7ntrJgUW9w1tgC5w+Ee54=;
	b=N5wQxQVBAi+44PBzRstKHPBJ3tQivzxMd1816eIfVsXseaYeqd4sCbCGrvt6/Jqt5UjyKs
	SCoACoqiuzYnuITxM+S+eoTJ1oNWtCm6/1tKyPqqMVzw7YiFffBhxG27KfKB3aLgKhEnnv
	AXZvtXfJZeESXWXBUEBGFBCE5dkLvvc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-VwI2xfSdMGeyL7_ZW2Y9CA-1; Fri, 06 May 2022 05:19:05 -0400
X-MC-Unique: VwI2xfSdMGeyL7_ZW2Y9CA-1
Received: by mail-qv1-f69.google.com with SMTP id eo13-20020ad4594d000000b004466661ece9so5505635qvb.1
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 02:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fnPQyEeKbsHW1LZRu1jU8z7ntrJgUW9w1tgC5w+Ee54=;
        b=5dyxTBKBhkiy1rcNPcNpsdNp18cCI1rQZKzyQaCAXts4oQjXqQz9QP8NI3Nlv+SQqt
         cBrg6rrEQP6dMdk7wr2b+HV2Tn2FOZo2+AC9tXmgAvgEf7QPnebmlQtajghzmoxVr7T2
         /kwoeeXaBH3K5q4pIbh8+UTELutWD9+ri5hfSDOrBYycqsSDRd+oFK5G1DcKu/po6ZyX
         43kfEkpzJF6D3XSEN1q3or069s0/ko62sdTCXH4bI/huVY0f3r0uK/VWMm/8zOPYd0Bc
         6Qt7YnfYHGKKu+xljVtWsbvOwf7NyIpXZ3H6pWeg2nS9gIUsAX4pDuUifM4FPbAeyr5Y
         URFg==
X-Gm-Message-State: AOAM533hAyxvs8jCZr6v33ABgFNBj8GNoIFP5vZVLK74vT+if72IZheV
	p+vlqodMrNb9oNCI31zD/mLf1NzyejNuhN9CPJqc5hBweGdRPgSThLL0n451jacf49zbPmNfO/k
	BHzKvwPJXNYm9DGU=
X-Received: by 2002:a37:42d3:0:b0:69c:830d:6e51 with SMTP id p202-20020a3742d3000000b0069c830d6e51mr1639355qka.302.1651828744954;
        Fri, 06 May 2022 02:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT9sl+A+/gPrLqJIQm/b4hftX4hOWp/c+uKwOuKB60cNN+PG8ETHWSOnQlzT7oc0fN80zUpA==
X-Received: by 2002:a37:42d3:0:b0:69c:830d:6e51 with SMTP id p202-20020a3742d3000000b0069c830d6e51mr1639343qka.302.1651828744679;
        Fri, 06 May 2022 02:19:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id e26-20020ac8671a000000b002f39b99f6c2sm2116040qtp.92.2022.05.06.02.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 02:19:03 -0700 (PDT)
Message-ID: <ec6a41422f706bc73075e97df27d437a7bde9c13.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Revert "mptcp: add data lock for sk timers"
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 06 May 2022 11:19:00 +0200
In-Reply-To: <bdde3a40-1471-c8b9-65bd-f53ddebacdb4@linux.intel.com>
References: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
	 <bdde3a40-1471-c8b9-65bd-f53ddebacdb4@linux.intel.com>
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

On Thu, 2022-05-05 at 16:40 -0700, Mat Martineau wrote:
> On Thu, 5 May 2022, Paolo Abeni wrote:
> 
> > This reverts commit 4293248c6704b854bf816aa1967e433402bee11c.
> > 
> > Additional locks are not needed, all the touched sections
> > are already under mptcp socket lock protection.
> > 
> 
> I agree that this needs to be reverted:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> 
> But msk->sk_timer is *also* accessed in two places without the mptcp 
> socket lock (but with the data lock):
>   * mptcp_pm_mp_fail_received() (stop timer when mp_fail received)
> 
>   * subflow_check_data_avail() (start timer on infinite mapping rx)

I'm reasonably no additional lock is required to call sk_stop_timer()
and/or sk_reset_timer(): they boil down to the timer_{del,mod}
primitives which in turns are irq safe.

The mptcp wrappers *could* require additional locking because they
additionally touch mptcp_sk(sk)->timer_ival. I *think* we could avoid
the lock even there with some additional barrier, but it looks every
caller is already under the lock.

I think we don't need to defer touching the timer. Eventully we could
remove the check on the msk socket status, which again looks not
needed.


Cheers,

Paolo

