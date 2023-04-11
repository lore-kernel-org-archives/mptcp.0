Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926028F45
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 14:51:13 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id h3so22171833qtu.1
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681224672; x=1683816672;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHMCzwM6PDLhVkTQMZnMhtpmr/ubBhgQvLDgMQf1SOU=;
        b=eWJTQS0/ZEm7ZmaPAMa9oqA9wx0EPBV6l2uuwG6yIKqt1a06KRUxVLwWRWyMxAuE5Y
         dGcp39rEcvsbQdIl6zuG+tA8hzve7Ip/lS2I/SPm3my4GXlkmuOrFBcFyHhw5MiQaxI5
         ouNwprfsZ/zrSN54YLKJFfk0CfVceIVDumgsojvLaG+W30EONVwx6HzUF5/sC5/1vhG9
         /NIY/8e4qUCdGbPorHVAUl5qktHHwVotkdewfS3QvtKFir37S/emsfdxD7RmN0MzvvvS
         i02eMSq3lD27ogjCSxQiDOKcpOM0Mknt8DHlSnC17kAe2yTB80OX0gfiwymIMnLr7J1w
         +FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681224672; x=1683816672;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XHMCzwM6PDLhVkTQMZnMhtpmr/ubBhgQvLDgMQf1SOU=;
        b=Jn4ZsdL4deOYyN+UEEJi/Azkxe5H3DCvP2ascadj2up3YgbvuSTv7xnAzyMsBWneli
         MlmRbeTCNGmvN1mw9QtKjnAsvC9DswzypE6R/L5m4Tg7SDnH/qDioRCn+f2bf99ECJGg
         jJ8nAKsvjxzZikGMrjQqe3/7dtCYg87izcapvN2c56SgAM6msI6flcana2fuTPazSiSD
         CdO+FiN9ModYKwo/ckpswsN6V4JPfO15jqOYfPNvTqMseH5YXxWA+fRQpaiKd4iqWLe9
         jHabVZ9UKvlz2l3s+W1Wun7M9VXbO/VKnH35AF3lCulWzf6Ig04h7iY201kuuF7rB0jc
         r9Pw==
X-Gm-Message-State: AAQBX9f+rloRAWsV3wCnLiS462DuKu1kTT1hhTBTf0l94wnMhWXO0irx
	gl8l5nlNWikP1mmFaoAlINw=
X-Google-Smtp-Source: AKy350Y70yOUSwGBZYXj/TXH4vYBKCrUiGGiU0kdtk3VRctAr80kkFd917fwKzl/B7V6SYpgOgS7lw==
X-Received: by 2002:ac8:5fd1:0:b0:3e6:4fab:478f with SMTP id k17-20020ac85fd1000000b003e64fab478fmr22841516qta.43.1681224672436;
        Tue, 11 Apr 2023 07:51:12 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id h2-20020ac87442000000b003e3914c6839sm3646662qtr.43.2023.04.11.07.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:51:11 -0700 (PDT)
Date: Tue, 11 Apr 2023 10:51:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, 
 David Ahern <dsahern@kernel.org>, 
 Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemb@google.com>, 
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kuba@kernel.org, 
 asml.silence@gmail.com, 
 leit@fb.com, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 davem@davemloft.net, 
 dccp@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 matthieu.baerts@tessares.net, 
 marcelo.leitner@gmail.com
Message-ID: <643573df81e20_11117c2942@willemb.c.googlers.com.notmuch>
In-Reply-To: <67831406-8d2f-feff-f56b-d0f002a95d96@kernel.dk>
References: <20230406144330.1932798-1-leitao@debian.org>
 <CA+FuTSeKpOJVqcneCoh_4x4OuK1iE0Tr6f3rSNrQiR-OUgjWow@mail.gmail.com>
 <ZC7seVq7St6UnKjl@gmail.com>
 <CA+FuTSf9LEhzjBey_Nm_-vN0ZjvtBSQkcDWS+5uBnLmr8Qh5uA@mail.gmail.com>
 <e576f6fe-d1f3-93cd-cb94-c0ae115299d8@kernel.org>
 <ZDVLyi1PahE0sfci@gmail.com>
 <75e3c434-eb8b-66e5-5768-ca0f906979a1@kernel.org>
 <67831406-8d2f-feff-f56b-d0f002a95d96@kernel.dk>
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> On 4/11/23 8:36?AM, David Ahern wrote:
> > On 4/11/23 6:00 AM, Breno Leitao wrote:
> >> I am not sure if avoiding io_uring details in network code is possible.
> >>
> >> The "struct proto"->uring_cmd callback implementation (tcp_uring_cmd()
> >> in the TCP case) could be somewhere else, such as in the io_uring/
> >> directory, but, I think it might be cleaner if these implementations are
> >> closer to function assignment (in the network subsystem).
> >>
> >> And this function (tcp_uring_cmd() for instance) is the one that I am
> >> planning to map io_uring CMDs to ioctls. Such as SOCKET_URING_OP_SIOCINQ
> >> -> SIOCINQ.
> >>
> >> Please let me know if you have any other idea in mind.
> > 
> > I am not convinced that this io_uring_cmd is needed. This is one
> > in-kernel subsystem calling into another, and there are APIs for that.
> > All of this set is ioctl based and as Willem noted a little refactoring
> > separates the get_user/put_user out so that in-kernel can call can be
> > made with existing ops.
> 
> How do you want to wire it up then? We can't use fops->unlocked_ioctl()
> obviously, and we already have ->uring_cmd() for this purpose.

Does this suggestion not work?

> > I was thinking just having sock_uring_cmd call sock->ops->ioctl, like
> > sock_do_ioctl.
 
> I do think the right thing to do is have a common helper that returns
> whatever value you want (or sets it), and split the ioctl parts into a
> wrapper around that that simply copies in/out as needed. Then
> ->uring_cmd() could call that, or you could some exported function that
> does supports that.
> 
> This works for the basic cases, though I do suspect we'll want to go
> down the ->uring_cmd() at some point for more advanced cases or cases
> that cannot sanely be done in an ioctl fashion.

Right now the two examples are ioctls that return an integer. Do you 
already have other calls in mind? That would help estimate whether
->uring_cmd() indeed will be needed and we might as well do it now.
