Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603B5A96
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663582869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjBSgQTJGO3P4ZRw0ae7OXN0z2FgH+L+9pDDlLWHVS8=;
	b=h4gQ7xYSK26otSXpSWqqbyHzIcEp4iBDciMCfLwKUKnvdPXf3nx8gfaTcjB775en1cIbGJ
	aO9+tWUGmK4akju435I4ReuFwxFq9ZOJ3vA6grUDZGzU0N1Kq2yvWCWxbRPKJWMufjsbhP
	r33WXWvZF95B+np8t/ryb25IPo7COwc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-197-hqST4hj6MR6ny6bkGW3Y-A-1; Mon, 19 Sep 2022 06:21:08 -0400
X-MC-Unique: hqST4hj6MR6ny6bkGW3Y-A-1
Received: by mail-qv1-f71.google.com with SMTP id e19-20020ad44433000000b004aaa7d00846so18824054qvt.0
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 03:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=XjBSgQTJGO3P4ZRw0ae7OXN0z2FgH+L+9pDDlLWHVS8=;
        b=okiRzBq02m9uBWNd7WcGzF0lqn3VqZNZSFmiRnRpInD/jEHn5JKmgJKWKDxsScxipw
         wcHKMFZRCrAhCAsO3uLrTURG1qcXwqpIukG/YzVHQ6cWYayG+7s0k//f9cgxLCRFgQ3i
         l7DIK7J7y2BJTiOkUBLCSQUOZyzF+mUFn016abnmKAA/jNp5O8tyO6EWJkTZDqxib35d
         fvvr7mrscecykyuVpimrMtVq/szoKmpcWX5on0x7usmkE2lmZMZGzT07REM7Cabw4VTS
         JqURoGBLwTCrUoFT2W+8ISkEMKe0vL3ZsQv3scHlAxUgO/rdqZMTEUXuGe9w0aeDYlZi
         7Vrw==
X-Gm-Message-State: ACrzQf2Lyv+pPa0o4TqbIKmesvYrrMMpmyAiOftUq8gik8SZkIBSZz/A
	Luopi5jhQKaK3O6whn37tJfBGN9aInzaVMp2q45CnGQuPVfTNwSc+aA6KYPvfX76tAiwk+c2kv6
	GyO+VDrB6ph+1BVI=
X-Received: by 2002:a05:620a:40cf:b0:6ce:b532:347d with SMTP id g15-20020a05620a40cf00b006ceb532347dmr12657441qko.708.1663582867562;
        Mon, 19 Sep 2022 03:21:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4kc79UfGyjvvffFLtdfyDRHE8javBOCMbTPgjKIojB6AgSsP7SKBKHyTv703CXuusxJfHRsA==
X-Received: by 2002:a05:620a:40cf:b0:6ce:b532:347d with SMTP id g15-20020a05620a40cf00b006ceb532347dmr12657432qko.708.1663582867340;
        Mon, 19 Sep 2022 03:21:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a048b00b006cbdc9f178esm12081225qkr.25.2022.09.19.03.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:21:06 -0700 (PDT)
Message-ID: <5a7fe64e44c689a4cdc8c9f12895b06d5736d7f4.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 01/11] Add separate fastopen.c file.
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 12:21:04 +0200
In-Reply-To: <20220917222853.2406-2-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-2-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> Add separate *.c file. Function prototypes are coming to protocol.h
> (Suggestion of @palbeni (JUN 17))
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

It's probaly better to squash this patch in 3/11, so fastopen.c will
not be a completelly empty skelethon.

Thanks,

Paolo

