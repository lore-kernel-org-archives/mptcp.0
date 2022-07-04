Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4615DE
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 08:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656922021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92MY4cA5f8KBdFJRVkAH+lxMep75sXzYraxf9e14ai4=;
	b=ammFyED2ArC0sS+LCJMCcBqPrjIXxCqVb5lxEeansIYMR0CIpoxGGdzdeRWjDso9b0cWhq
	RdIgE1vVxMVfaLG7SvDOeT4Hld7SeMpSOX9SvsgKsAOqDsqTyUQQKaX8z7+fIT6skomxZs
	IKiNhaVmzm7JHVhaJULjPkoNy/w9DPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-22ruZP5AP7ubPuaJwbzUJg-1; Mon, 04 Jul 2022 04:07:00 -0400
X-MC-Unique: 22ruZP5AP7ubPuaJwbzUJg-1
Received: by mail-wm1-f71.google.com with SMTP id n18-20020a05600c501200b003a050cc39a0so3727274wmr.7
        for <mptcp@lists.linux.dev>; Mon, 04 Jul 2022 01:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=92MY4cA5f8KBdFJRVkAH+lxMep75sXzYraxf9e14ai4=;
        b=6ZKdyO1wrlpX+lEjXWCb/kvX8ntWwdPjP53PZJpX2JmnI/5PglqiCTxCB2bgQFvz1B
         OYgXBBjUtuAwmNDt8I5hzRy0KVrovc5kdyWzTzd5b+7QXKN6uHjeCgtTL+KiF9M0ziG3
         nhG1MVwEuyas5tcHbYHzd7UpwI8GBlHy5a6gg+E/iNJIOyodsvkvKM6k9Klm7ugTHK1y
         VL1wWj0wo0l13ZEgbLOJGZgw6IwIASbNkAQeRXKpQejrq6U7ys3vthA8vmemq3s9UXnG
         1UbpP7dMtmdGDlnrddNk12hJJjgx+1QaxsxPleamAR28hL+ipRtuuZbvMGhMA9aRjRXp
         OdNg==
X-Gm-Message-State: AJIora+2qhTUMz/ACgyOmMfrQIQvaPaY+kf/DW9BjAeCACjSLdNk7PvM
	qjkzEG/LP7x2xPdj6GSVtUrvHXXaWgQWEdSQaiAfecUOr+/ijYX/09yvNb+Ulqd/WAMu7L3/mhn
	sb6OzNiNcP8k/oso=
X-Received: by 2002:a5d:588f:0:b0:21b:ba06:4d46 with SMTP id n15-20020a5d588f000000b0021bba064d46mr27513624wrf.58.1656922018848;
        Mon, 04 Jul 2022 01:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uxZZheiGJ1ibLzi/IZIpNJ5cIp6AXcNWaH8NW9pU0t8l9Svo+fsntI9sQIjWs3VcfWlkQ6hQ==
X-Received: by 2002:a5d:588f:0:b0:21b:ba06:4d46 with SMTP id n15-20020a5d588f000000b0021bba064d46mr27513598wrf.58.1656922018570;
        Mon, 04 Jul 2022 01:06:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id j19-20020a5d6e53000000b002102b16b9a4sm29461086wrz.110.2022.07.04.01.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:06:58 -0700 (PDT)
Message-ID: <7d6ea030c8f874a38754ff9a8213044148cfd0dc.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/6]  mptcp: introduce and use
 mptcp_pm_send_ack()
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 04 Jul 2022 10:06:57 +0200
In-Reply-To: <e12db843-9a-64d2-4d4e-ef14655354ab@linux.intel.com>
References: <cover.1656669391.git.pabeni@redhat.com>
	 <6de116ad2229ddd1c557fca592b9c56fd2836823.1656669391.git.pabeni@redhat.com>
	 <e12db843-9a-64d2-4d4e-ef14655354ab@linux.intel.com>
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

On Fri, 2022-07-01 at 17:13 -0700, Mat Martineau wrote:
> On Fri, 1 Jul 2022, Paolo Abeni wrote:
> 
> > The in-kernel PM has a bit of duplicate code related to ack
> > generation. Create a new helper factoring out the PM-specific
> > needs and use it in a couple of places.
> > 
> > As a bonus, mptcp_subflow_send_ack() is not used anymore
> > outside its own compilation unit and can become static.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> The rest of the series looks good, I ran the new tests and checked the 
> pcaps too.
> 
> However, there's a conflict in this patch with the export branch. Can you 
> rebase and repost?

I'm surprised by the conflict. I likely messed-up something in my tree.
I'll rebase.

> Something else I noticed that is out of scope for this series, but 
> something we should think about addressing:
> 
> The RFC says about MP_PRIO that "this signal applies to a single 
> direction, and so the sender of this option could choose to continue using 
> the subflow to send data even if it has signaled B=1 to the other host.".
> 
> However, we only have a single 'backup' value stored per subflow. If 
> there's a netlink request to change the backup bit, it affects both 
> outgoing scheduling and sends MP_PRIO to the peer to affect incoming 
> traffic. A received MP_PRIO would affect outgoing packet scheduling on 
> that subflow, but the peer may choose to schedule differently (and we do 
> handle this ok). Would it be worth it to separate "incoming priority" and 
> "outgoing priority"?

Indeed, that could be worthy. Note that we have a very similar issue
for fallback to TCP: according to the RFC is again an unidirectional
status, but we have a single bit info for both directions.

I guess the relevant changes (both for MP_PRIO and even more for
fallback could be a bit invasive, let's see...

Cheers,

Paolo

