Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95528EE
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 15:00:27 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id y26so7173028qtv.9
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681225227; x=1683817227;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a/e7NoKNRdC7o4W/4knkGx/Cr6Bsqtq0P+8IFSPj6w=;
        b=DSr2E+bLihxuIKjAOdqe/dpQcZhaLyOUYRUkswjJULAchdWAje0gDePf/WJPPuQ0gl
         Y4G3i6OVvhyIR0LIyFHfha8ArKE/dBVhit0GLkyW44dC0C+8JHnomAjSBDLECvIACJYH
         esdXVZgohItWwzmbHw3rpUBX4MjAyotwUmBCELKyJ8vzPDoDJqygL8rhoGnehnoWGMKV
         T+mSCmLSkFNwUdBiXFdqVq7gEhh7fGL35MC7teICj7v2szqgt5tHQsgrJY1qlCMpXp+r
         t6kGqEwxcydV4iNwkFlbP/DW7AxnhiHRTa4Sx4dD6rzRLUeJuiSM9OiPfzfgBpClVtwR
         kJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225227; x=1683817227;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5a/e7NoKNRdC7o4W/4knkGx/Cr6Bsqtq0P+8IFSPj6w=;
        b=Rc1TJX58Pqc+jXX/5XTTw06SC7fMB2Wpwl5EcjZSf2lXZFXpUWD7yNH/Im/mVFchDZ
         4Ya7bAvHemE5KbvHLnM2xsE+tu3dKzMEIHxR4qN3Dw5KRfWsXCzA4fWIADob96p8hBSf
         m3a8BCEsSgk38syFAssu4JQrHanqlAmxCJiGTCss8wOZQoOmv4uqq2Lc/XeY1N7akbaY
         iJfiyiZhBFJeDPoYcoCVlaeZvsn2VShvUkxjRaZDxh22TrDLaPS6lBWmWEspFI9krSht
         D2jIVBv3u70PDbIwDL5Km8hw4vF+EVFu4kV5XuPt61kiiK/CMM6dkKgmT9Qzz1usNN2g
         P3wg==
X-Gm-Message-State: AAQBX9dd29yhKSvaQIf4oe0W2MG2zGB4U1Uq2oxAgHKMBGl1EIwz3fMm
	jB3AjV6dOxojEcDvZInrCXQ=
X-Google-Smtp-Source: AKy350aGAPWamY9+W7w81yRyWj3JGvcdqv9fPOUoNNwmY1QOgNWHvjS04w6tkQFHF73FWcTmOiJv5Q==
X-Received: by 2002:a05:622a:1043:b0:3d2:efe6:3c23 with SMTP id f3-20020a05622a104300b003d2efe63c23mr23778449qte.42.1681225226470;
        Tue, 11 Apr 2023 08:00:26 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id c7-20020ac853c7000000b003e4ee0f5234sm3641080qtq.87.2023.04.11.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:00:25 -0700 (PDT)
Date: Tue, 11 Apr 2023 11:00:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
 matthieu.baerts@tessares.net, 
 marcelo.leitner@gmail.com
Message-ID: <64357608c396d_113ebd294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <036c80e5-4844-5c84-304c-7e553fe17a9b@kernel.dk>
References: <20230406144330.1932798-1-leitao@debian.org>
 <CA+FuTSeKpOJVqcneCoh_4x4OuK1iE0Tr6f3rSNrQiR-OUgjWow@mail.gmail.com>
 <ZC7seVq7St6UnKjl@gmail.com>
 <CA+FuTSf9LEhzjBey_Nm_-vN0ZjvtBSQkcDWS+5uBnLmr8Qh5uA@mail.gmail.com>
 <e576f6fe-d1f3-93cd-cb94-c0ae115299d8@kernel.org>
 <ZDVLyi1PahE0sfci@gmail.com>
 <75e3c434-eb8b-66e5-5768-ca0f906979a1@kernel.org>
 <67831406-8d2f-feff-f56b-d0f002a95d96@kernel.dk>
 <643573df81e20_11117c2942@willemb.c.googlers.com.notmuch>
 <036c80e5-4844-5c84-304c-7e553fe17a9b@kernel.dk>
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
> On 4/11/23 8:51?AM, Willem de Bruijn wrote:
> > Jens Axboe wrote:
> >> On 4/11/23 8:36?AM, David Ahern wrote:
> >>> On 4/11/23 6:00 AM, Breno Leitao wrote:
> >>>> I am not sure if avoiding io_uring details in network code is possible.
> >>>>
> >>>> The "struct proto"->uring_cmd callback implementation (tcp_uring_cmd()
> >>>> in the TCP case) could be somewhere else, such as in the io_uring/
> >>>> directory, but, I think it might be cleaner if these implementations are
> >>>> closer to function assignment (in the network subsystem).
> >>>>
> >>>> And this function (tcp_uring_cmd() for instance) is the one that I am
> >>>> planning to map io_uring CMDs to ioctls. Such as SOCKET_URING_OP_SIOCINQ
> >>>> -> SIOCINQ.
> >>>>
> >>>> Please let me know if you have any other idea in mind.
> >>>
> >>> I am not convinced that this io_uring_cmd is needed. This is one
> >>> in-kernel subsystem calling into another, and there are APIs for that.
> >>> All of this set is ioctl based and as Willem noted a little refactoring
> >>> separates the get_user/put_user out so that in-kernel can call can be
> >>> made with existing ops.
> >>
> >> How do you want to wire it up then? We can't use fops->unlocked_ioctl()
> >> obviously, and we already have ->uring_cmd() for this purpose.
> > 
> > Does this suggestion not work?
> 
> Not sure I follow, what suggestion?
>

This quote from earlier in the thread:

I was thinking just having sock_uring_cmd call sock->ops->ioctl, like
sock_do_ioctl.
> >  
> >> I do think the right thing to do is have a common helper that returns
> >> whatever value you want (or sets it), and split the ioctl parts into a
> >> wrapper around that that simply copies in/out as needed. Then
> >> ->uring_cmd() could call that, or you could some exported function that
> >> does supports that.
> >>
> >> This works for the basic cases, though I do suspect we'll want to go
> >> down the ->uring_cmd() at some point for more advanced cases or cases
> >> that cannot sanely be done in an ioctl fashion.
> > 
> > Right now the two examples are ioctls that return an integer. Do you 
> > already have other calls in mind? That would help estimate whether
> > ->uring_cmd() indeed will be needed and we might as well do it now.
> 
> Right, it's a proof of concept. But we'd want to support anything that
> setsockopt/getsockopt would do. This is necessary so that direct
> descriptors (eg ones that describe a struct file that isn't in the
> process file table or have a regular fd) can be used for anything that a
> regular file can. Beyond that, perhaps various things necessary for
> efficient zero copy rx.
> 
> I do think we can make the ->uring_cmd() hookup a bit more palatable in
> terms of API. It really should be just a sub-opcode and then arguments
> to support that. The grunt of the work is really refactoring the ioctl
> and set/getsockopt bits so that they can be called in-kernel rather than
> assuming copy in/out is needed. Once that is done, the actual uring_cmd
> hookup should be simple and trivial.

That sounds like what I proposed above. That suggestion was only for
the narrow case where ioctls return an integer. The general approach
has to handle any put_user.

Though my initial skim of TCP, UDP and RAW did not bring up any other
forms.

getsockopt indeed has plenty of examples, such as receive zerocopy.

