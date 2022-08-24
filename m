Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E557B
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661344691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRLVluM+AkumW3CTJG/wPEaF7eBAjA8OB1u5fhQxOVI=;
	b=Y2daCGjhXNKu0r7ts6Um1KYEmhydaZPDXNN1q94f9edwfmr20Cu0z4T6bJlyvLXV9ZijHr
	SElhju7VShht9iHrZMfaCIMtNaVXkE47F7JMbiotLXtFQ7Z0k+LcG+cXuTRl1DuZD68VEL
	Trs/c2utOBRURq9f7/1PFvzRkDdXAgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-19-3Vn9BhacO2OChQ5eDcEsRA-1; Wed, 24 Aug 2022 08:38:10 -0400
X-MC-Unique: 3Vn9BhacO2OChQ5eDcEsRA-1
Received: by mail-wm1-f71.google.com with SMTP id f9-20020a7bcd09000000b003a62725489bso398580wmj.2
        for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 05:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=IRLVluM+AkumW3CTJG/wPEaF7eBAjA8OB1u5fhQxOVI=;
        b=of+s0DLPTU3Qjc8dWUCIM2WnGzJhkJSgo36SVXj5u4PuTo3BV6QsEp3f4PC5eN3wGH
         uMMzD9bkSxuzRzPhBz3bZopGMSUSEfDtDp40x/DAqdKkN0gf7UvPZ9chWvZedBVr2goL
         nfROgNMcZsFW491Y++4aCa2I7WTy1sWMs6p59pxAdLQcmVfYp9uzU3yIiaI4KLAAWZ60
         1ChEmDYkUrrLQON2H0SN/WUINkwpNx2EIVr4cIu+hgutHLyZ8RPAj+0FMpsA2FLnc8nb
         tcWHXfSdissVx83pOcF/tkyeQ5YHUEuCKfvrzhoCtE1uvX2JIbYroFWy4exTwztba7i8
         ilRw==
X-Gm-Message-State: ACgBeo2kSw1+uD+0Q6xmNqCqpiuk7udTS+oG5n5h9WTfh5YxkunJ73Nu
	y9YXo8/8nlOLQHVnFIL/9Qnl1XiMTZ11eFKPLvgZESAA1JcvxQW+9r61ZpiOpPk01zUaxAsmPLf
	qefxDGBYkoSD3UXapPPtBY4FvugmyxhOWy5x4MB8Zt4Vhgb52zT3CDdQI7OSJ0qff
X-Received: by 2002:a5d:4752:0:b0:225:1fb1:862f with SMTP id o18-20020a5d4752000000b002251fb1862fmr16046344wrs.458.1661344689200;
        Wed, 24 Aug 2022 05:38:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6QsijO3DcVhb7PuXUyL/DzfF3yr1IAwScCzt6zpPf/eMCJVHyb/RyBM/SI9/cg+GXDBoDWkg==
X-Received: by 2002:a5d:4752:0:b0:225:1fb1:862f with SMTP id o18-20020a5d4752000000b002251fb1862fmr16046326wrs.458.1661344688797;
        Wed, 24 Aug 2022 05:38:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c419400b003a5ffec0b91sm1704363wmh.30.2022.08.24.05.38.07
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:38:08 -0700 (PDT)
Message-ID: <73d8018455cc933f99d4a5f53339b0e1b4a7ed12.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/2] Squash-to: "mptcp: move msk input path
 under full msk socket lock"
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Wed, 24 Aug 2022 14:38:07 +0200
In-Reply-To: <30ec171851daca06e3c3a60a1d3e41ff5887eae2.1661339834.git.pabeni@redhat.com>
References: <cover.1661339834.git.pabeni@redhat.com>
	 <30ec171851daca06e3c3a60a1d3e41ff5887eae2.1661339834.git.pabeni@redhat.com>
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

On Wed, 2022-08-24 at 13:18 +0200, Paolo Abeni wrote:
> whoops, I forgot to really test for pending data at release_cb time.
> 
> The above causes several recurring failures in the self-tests.
> 
> Note that this could affect badly the mptcp performance (as we now
> really move relevant CPU time from the subflow rx path/ksoftirqd to
> the user-space process), even if I haven't performed perf-tests yet
> on top of this change.

The first raw number are quite discouraging :/ 
-30% on single subflow test.

/P

