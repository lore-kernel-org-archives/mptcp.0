Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C5AD26
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 16:58:44 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id y14so40214201wrq.4
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 09:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800323; x=1683392323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/I9XQ5BsNrfqYkDP7sT9gRtY/AQlvWI8OQc8Brk7LM=;
        b=ScRnPSaxWxma4IEF8Mu9zb0YjJbug1PUJG4sjoPljWWg0I71hdiYf1OlFISO6ksrv7
         QeACzCxqCL3bsKg2SDDdAM5BO571pBa1KZWuWnUNZayAtjUJ8BRYF+d6n1pswqmMdB1Y
         KEAC+sUMBZfLHz2zbjoSIJy5x9DPRCZpmAuJGTtTEXW2ZN2uIwq/PxkgecfMKwFXQQSM
         +qwzCK2+m35H/3YiajlkJj4FS4xaVXz7weBo3RGHcIKa7h97sdzXuL8K1ZVqyhRN/Txu
         wDam23D3mkiL31HhWVI6JK1pzWUuaxmsePwudgAPFOTCxvBL/BKu0fKMzoUH4H87vqTf
         8RGQ==
X-Gm-Message-State: AAQBX9eikWNK4tiwI/7H9Y3M0nZV8XWdDvQ/7jspWZclRNfEqzM15oxy
	o3/lrG8BTqgK5BdMRmLDdfo=
X-Google-Smtp-Source: AKy350aictw9XxlMZA5bKLdEZ9LU1B6Eevsf0qglj8Mo0H6pA185jjoWKCIE1jTQqvy7y9kwv7gS2A==
X-Received: by 2002:a5d:5550:0:b0:2ef:9837:6b2b with SMTP id g16-20020a5d5550000000b002ef98376b2bmr408195wrw.21.1680800322724;
        Thu, 06 Apr 2023 09:58:42 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-026.fbsv.net. [2a03:2880:31ff:1a::face:b00c])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b003ee9f396dcesm5858206wmq.30.2023.04.06.09.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:58:42 -0700 (PDT)
Date: Thu, 6 Apr 2023 09:58:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Keith Busch <kbusch@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
	dccp@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com, matthieu.baerts@tessares.net,
	marcelo.leitner@gmail.com
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Message-ID: <ZC76QH97yFsx9e7y@gmail.com>
References: <20230406144330.1932798-1-leitao@debian.org>
 <ZC72UKx/sA4syPfK@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC72UKx/sA4syPfK@kbusch-mbp.dhcp.thefacebook.com>

Hello Keith,

On Thu, Apr 06, 2023 at 10:41:52AM -0600, Keith Busch wrote:
> On Thu, Apr 06, 2023 at 07:43:26AM -0700, Breno Leitao wrote:
> > This patchset creates the initial plumbing for a io_uring command for
> > sockets.
> > 
> > For now, create two uring commands for sockets, SOCKET_URING_OP_SIOCOUTQ
> > and SOCKET_URING_OP_SIOCINQ. They are similar to ioctl operations
> > SIOCOUTQ and SIOCINQ. In fact, the code on the protocol side itself is
> > heavily based on the ioctl operations.
> 
> Do you have asynchronous operations in mind for a future patch? The io_uring
> command infrastructure makes more sense for operations that return EIOCBQUEUED,
> otherwise it doesn't have much benefit over ioctl.

I think this brings value even for synchronos operations, such as, you
can just keep using io_uring operations on network operations, other
than, using some io_uring operations and then doing a regular ioctl(2).
So, it improves the user experience.

The other benefit is calling several operations at a single io_uring
submit. It means you can save several syscalls and getting the same work
done.

>  
> > In order to test this code, I created a liburing test, which is
> > currently located at [1], and I will create a pull request once we are
> > good with this patch.
> > 
> > I've also run test/io_uring_passthrough to make sure the first patch
> > didn't regressed the NVME passthrough path.
> > 
> > This patchset is a RFC for two different reasons:
> >   * It changes slighlty on how IO uring command operates. I.e, we are
> >     now passing the whole SQE to the io_uring_cmd callback (instead of
> >     an opaque buffer). This seems to be more palatable instead of
> >     creating some custom structure just to fit small parameters, as in
> >     SOCKET_URING_OP_SIOC{IN,OUT}Q. Is this OK?
> 
> I think I'm missing something from this series. Where is the io_uring_cmd
> change to point to the sqe?

My bad, the patch was not part of the patchset. I've just submitted it
under the same RFC cover letter now.

Here is the link, if it helps:

https://lkml.org/lkml/2023/4/6/990


