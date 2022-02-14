Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D57A35
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644864077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LD40ayfmBd0Kg2gu4jKCVxIbw41hAszGdUe1FJbEL3c=;
	b=KrIMVOs/c1lYoja8IBWOQk5aBfEsOY5b62PYW/xRXEvaw/eYdwAcIpGKOwqVm9mClsqK3z
	nhQc4+wVZOkPK+A9IkQXreMVSrv2/FvqWYvFQ9dlgwZnUYat7jyNS+pdohzQTXQZxm4Kck
	nnnqQmPX4dYTzE/Zj/V5ZMAQMv2wTnM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-whp-kSGaMlKEPjiNmm0WyA-1; Mon, 14 Feb 2022 13:41:15 -0500
X-MC-Unique: whp-kSGaMlKEPjiNmm0WyA-1
Received: by mail-wr1-f72.google.com with SMTP id i10-20020adfaaca000000b001e4b2db0303so5295221wrc.23
        for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 10:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LD40ayfmBd0Kg2gu4jKCVxIbw41hAszGdUe1FJbEL3c=;
        b=dQdLyp55L6JogIX6i0BGGJGd1iqz/bU8gz80cIYuwDBI52RTSJ6RPJj+fq4vZR6107
         8llOI3HbaAYNZNlooKTNUnrzc+CICq75k0kwlYIzUPbk6MiKV1NZ3l144lojOIi+83My
         t6AWrA6o509zRS5WXl+Oer/JltdK06fgtM3tR6aGHFP/00fhf1hHdXVYV4kxQ0j6tOW+
         /5dEXSAKTKj7uQ7dCIn/Lz7X4YBZXrI2cxndSS5yyIeFVFJ3XmZY8OqeGif78PVOxIG5
         q7tGBxrDZV6sjk2dgAPyFSQ1645G51Htv0GretioxmPYfP6HfGjBPqs5xWhhcTvPRY1S
         KB1w==
X-Gm-Message-State: AOAM530N1WusYsyz04OkTTvvBDbqJdoZWKrELfV1lXVV8HOWl0gTzcdW
	woNh6PPngqe8frD4fMSuENuuqitDm05k2vO9DaHo7kxk0SR4UNEYXWSOuxLwkObeuW27cLozIfi
	2xgM/v/Kbwv3qldXirBvyixLOUESoQCUls/kSQsksb7xRy9hAk0CFbPodCDK+kQ4j
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr273059wrt.125.1644864074035;
        Mon, 14 Feb 2022 10:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeKN6vQtjpZ/rYSOixkH+WocVOmRz26or0a26aBlj+a2fvrBrHb+I7gv6MgkDHiObpqq9Zkw==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr273046wrt.125.1644864073618;
        Mon, 14 Feb 2022 10:41:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-165.dyn.eolo.it. [146.241.224.165])
        by smtp.gmail.com with ESMTPSA id b18sm22738642wrx.92.2022.02.14.10.41.13
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:41:13 -0800 (PST)
Message-ID: <38393366b636adfcf8b5eecf08e92c6b4394dd9a.camel@redhat.com>
Subject: Re: [PATCH v4 mptcp-next 2/3] mptcp: more careful RM_ADDR generation
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 14 Feb 2022 19:41:12 +0100
In-Reply-To: <9ac38525eac5d4e812fd11f20125e28edd8514df.1644852970.git.pabeni@redhat.com>
References: <cover.1644852970.git.pabeni@redhat.com>
	 <9ac38525eac5d4e812fd11f20125e28edd8514df.1644852970.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Mon, 2022-02-14 at 16:38 +0100, Paolo Abeni wrote:
> In some edge scenarios, an MPTCP subflows can use a local address
> mapped by a "implicit" endpoint created by the in-kernel path manager.
> 
> When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
> suboption. That is somewhat unexpected, as an MPTCP listener will keep
> accepting incoming subflows targeting such address and the unexpected
> options can confuse some self-tests.
> 
> Be more conservative about RM_ADDR generation: explicitly track the
> implicit endpoint with an appropriate flag and exclude them from the
> RM_ADDR generation.
> 
> Additionally allow the user-space to replace implicit endpoint with
> user-provided data at endpoint creation time.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

The CI still reports an issue on top of this patch:

https://cirrus-ci.com/task/5380046008352768?logs=test#L7283

Even if the symtom is the same, the root cause is different. I think
such failure is caused by the flush operation deleting both all
existing endpoints and all the existing subflows for each MPTCP socket.

Even when the subflow is not attached to any known, non implicit,
endpoint.

When we have simult flush on both sides, deleting the subflow (with no
endpoint) on one end can make disappear the subflow on the other end
(tied to a local endpoint) before the PM could generate the relevant
RM_ADDR.

Overall the number of generated RM_ADDR become impredictable, even if
the testcase is quite stable, to the point I could not replicate the
failure reported by the CI.

AFAICS, there are 2 possible solutions:

- avoid flushing both ends in test-cases "flush subflows" and "flush
addresses". This is very simple, but could hide other (currently
unknown) problems.
- change mptcp_nl_cmd_flush_addrs() to only delete subflows tied to
known, non implicit, endpoint. That is possibly a saner behavior for ip
mptcp endpoint flush, but will need more testcases to be adjusted and
is still a change of behaviour.

Any hint on the preferred option more than welcome!

/P

