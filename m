Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8727F
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651669441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3y8Vu0yh2CT2hCmK4ymoJCw+hnt0yanpdYJy8+VOIpY=;
	b=CKhX6C+by30/sK1IUWIvW6Sh9zY0AANlrN8R8l/uVDRb73/MtTIE3JOFCE/fb0L9Yl62M1
	oQRKXsd/L9wboWjN89RZKwLkhY8dcgr52FqD5mqqx1e/8+6rwxZKaOHQvCBzCsbWTe+DRy
	vQXXxWkhZ/BEY+n4x/tFBv3y2cWxCzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-T3QtF_9TNOeS-48HTk9n2g-1; Wed, 04 May 2022 09:04:00 -0400
X-MC-Unique: T3QtF_9TNOeS-48HTk9n2g-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so649420wmj.0
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 06:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3y8Vu0yh2CT2hCmK4ymoJCw+hnt0yanpdYJy8+VOIpY=;
        b=TuVn1PjI8F96ltcH+iZm2MdEqiWeuZ27+EOG8datvqhT4/vBLg3EOUUxtLL+qVFda2
         lWxWrRT5EMERzV6EiDQKNh50tPP1OSnXI+YUPtVzp7GfuXsRAO6Hk21nHVeDFti5UJR+
         E4Ql1Jmo9ck3sWOX543RdJeKZzHHqr5Zx4rGtpu2+fd67P0SUu1X2UNIffL97eIjQ9qr
         +9V5QPe3d3pBvqKSusQT37OO+HtqGtu6QZfDtWI82wQ9EdKgPLUuf3I3vTPq3OGRlurW
         D2EdQ55B4AXDLd6Y9/lqlGjvy9lE7BBGdILrL6gQA31DavBl0QyT5tMKsaxd++i58t6G
         NRJA==
X-Gm-Message-State: AOAM531BVxDmh5OClBGjMoTjxjC25p07fjhrDu5jtsS8V5hFNLTTI1tm
	n+v3FgAbnDY24QNQ3jEOiJPYXZEtU21v7W77+H5cHh0drN5e3GYXDKqApvgL/e+0fEqjjcISq1Q
	KOuEg0Md+XBLeJFI=
X-Received: by 2002:adf:fa91:0:b0:20c:4fde:171e with SMTP id h17-20020adffa91000000b0020c4fde171emr15910429wrr.533.1651669439573;
        Wed, 04 May 2022 06:03:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1iKstfYcsii5B00pjWb8hK9TfrvxaZkvBV69MHUw1DS61qAtjU9ODKDGJr2hQrK3ig+bFPw==
X-Received: by 2002:adf:fa91:0:b0:20c:4fde:171e with SMTP id h17-20020adffa91000000b0020c4fde171emr15910414wrr.533.1651669439305;
        Wed, 04 May 2022 06:03:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id r29-20020adfb1dd000000b0020c61af5e1fsm7635449wra.51.2022.05.04.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:03:58 -0700 (PDT)
Message-ID: <d4546526351251a86d13673baa3f88de5655fb13.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add MP_FAIL
 reset testcase" - cleanups
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 04 May 2022 15:03:57 +0200
In-Reply-To: <20220504121429.GA18870@bogon.HOST>
References: <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
	 <20220504121429.GA18870@bogon.HOST>
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

Hi Geliang,

On Wed, 2022-05-04 at 20:14 +0800, Geliang Tang wrote:
> On Wed, May 04, 2022 at 07:44:24PM +0800, Geliang Tang wrote:
> > Two small cleanups for MP_FAIL reset test case:
> > 
> > Reduce the test files size from 1024 to 128, to make the test faster.
> 
> The original commit log needs to update too:
> 
>  1024KB -> 128KB
> 
> '''
> Add the multiple subflows test case for MP_FAIL, to test the MP_FAIL
> reset case. Use the test_linkfail value to make 128KB test files.
> 
> ...
> ...
> '''
> 
> > With Paolo's fix [2] for MP_FAIL test-case, the test becomes very slow.
> > 
> > Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, no
> > extra checksum failures now, no need to add '+'s anymore.
> > 
> > Depends on Paolo's commits:
> > [1] net/sched: act_pedit: really ensure the skb is writable
> > [2] selftests: mptcp: fix MP_FAIL test-case
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>

I noticed the the time increase. Unfortunatelly, it may be necessary to
be reliable in all environment, comprising the slowers one.

Mat (M.) was able to reproduce some failure with b/w == 10Mbps and size
== 1M. I think/guess he could hit the same failure even with 1Mbps and
size == 128K.

We need at least some additional testing for this one.

Thanks!

Paolo

