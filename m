Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193553FE0
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631194309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIfooikRiFAr3bICshiuahc4Zop+/cCg4UYFSPj5flc=;
	b=INsSMfoDutLrWHgpqolUALLhgkPeh+0mjpZmb/BFngftgvZK8wWDMjiFtvCT/uYQdCdUIe
	S3pqEBTwKG92ghM7DyZqwXC4cRrGQdx/atnTAoQdZP/Y3j00R1eIH/SEPaQ2/xO383lX9h
	ylYIVm9d0LUcBcd11FJRittJaQN5Qr4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-kwNYsrFdMYajjJS9eJ1ktQ-1; Thu, 09 Sep 2021 09:31:48 -0400
X-MC-Unique: kwNYsrFdMYajjJS9eJ1ktQ-1
Received: by mail-wr1-f69.google.com with SMTP id l12-20020a5d410c000000b00159aa62fbb2so510334wrp.3
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 06:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sIfooikRiFAr3bICshiuahc4Zop+/cCg4UYFSPj5flc=;
        b=c9Ux+0TbO0M+ySbAR9UfJtBhBVM0KSYABgnxuQhktWwHfyfzxg7uuokoJvFpRjQCKU
         y5WQDxUxe6+guAEcsxwBcNgDYe31bI481W5T92EyUp3j1a913FRCfBPwWbabASGUNi1q
         umgKEqMjripe1QdeL/mPRJKJyXb9XIMjg5g4g7C1aktiK0O8T0O34YJlkZ9qh7A2yx4U
         lRMaz4pxFWkEMTLravrv+VAtE1FIEE9FLfA8R75/OpSAV4egBW46FMzgDaS87ZvzlTTL
         Km5v3eNQkLesg4/T1TUoIl+M+v4AjDDkzaod6N9a79v3kvefy31y8VtSSrWXMcxkQoky
         cLIA==
X-Gm-Message-State: AOAM533pS1c5/1l0dbgWxaNrgyQj1PJJFY7j0bCirfXVV0IvwBZznRts
	IJ5P/4f0oOagEUyCq3kZCA2MvhxRR6PsuD6kdXUsxJf47wn7To+WIcpyKZlA/+S3w4baVnhDVpX
	kqPXDvn7tfbyw3W8=
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr3617498wrc.12.1631194306553;
        Thu, 09 Sep 2021 06:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3Vdwc9NPhb46OtIhz254SeA4qtVl9dp8VOP52ghNruYIJltppsbig9diy3ipk9MGjjNxvgw==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr3617477wrc.12.1631194306367;
        Thu, 09 Sep 2021 06:31:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id j14sm1776009wrp.21.2021.09.09.06.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:31:46 -0700 (PDT)
Message-ID: <264bce65e93c2bf8f679ac2ed9d781b6994128f2.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 2/9] mptcp: add MPTCP_INFINITE_DONE flag
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 09 Sep 2021 15:31:44 +0200
In-Reply-To: <436686041e03ec619d507cf4d517e9137f7bd27a.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
	 <436686041e03ec619d507cf4d517e9137f7bd27a.1631188109.git.geliangtang@xiaomi.com>
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

On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added a new flag named MPTCP_INFINITE_DONE. Define
> mptcp_do_infinite and __mptcp_do_infinite to set this flag, and
> mptcp_check_infinite and __mptcp_check_infinite to check this flag.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/protocol.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 011f84ae1593..5644a361b9c7 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -123,6 +123,7 @@
>  #define MPTCP_RETRANSMIT	9
>  #define MPTCP_WORK_SYNC_SETSOCKOPT 10
>  #define MPTCP_CONNECTED		11
> +#define MPTCP_INFINITE_DONE	12

I'm likely the last person that should raise this kind of topics, but
IMHO this flag name is a bit unclear. What aboyt 'INFINITE_MAP_SET'?

/P

