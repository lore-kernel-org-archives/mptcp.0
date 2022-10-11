Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E93C14
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665505734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9k/pGl69MbaVxTQGb+HKio0kXPAHmv2GzuvCdmomL4=;
	b=MXAS+DtI3hyEvh4Y7EhetqBd9P07uuaSWcnf0YwqbkM5JaB5Wc6OigkIEgMSaX+FFJx1vQ
	QvFPqKjNpwhcGAXalcUxmNbXkMWp6ErmbtwQn2JHoYyAqmY7TRn2AS3mHSHJxIoCwPz5Tc
	83t1f+oSfWOcw1ngmhUyU7AGF7Rn+UQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-578ibkrpPgyNVRMilUKjTA-1; Tue, 11 Oct 2022 12:28:53 -0400
X-MC-Unique: 578ibkrpPgyNVRMilUKjTA-1
Received: by mail-wm1-f71.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so10846755wms.5
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 09:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9k/pGl69MbaVxTQGb+HKio0kXPAHmv2GzuvCdmomL4=;
        b=Z04NkrzP8wE7nxZgFRyDuheuepEE5itHSiV1jaVNqHlXxePjzYXtpKUJ6oGAWG+VEe
         xmDLVVl/qNWxcpU5Ben8zO09ct42HUib4IGAb3pIMV9IPYSdHKLpasizJGqNAqr3Xz4n
         bCa6t3RQM1QBjBcU8ewVcpDK0Gh9RFLlzQRkdvf4V4Khh/vObb9bHG2XDLUCl4hhfef3
         VBdH0qnz8hTMfHFZutpfQ2f0XddQMgDhHYGPknfzKmihOXIxELteA//w4yxPqtFqdRw8
         pGeSNMju1heIpxAH0CyirzkPcuTJsnGpqUSe1m5DioYkeMnehnemnuQtklftRRES7GHK
         G8Gg==
X-Gm-Message-State: ACrzQf3W9HA1G/d0P/g8cWvrUKt3K7FqDPCcsPoo/gjm8sIR/ZpunmUv
	lLuHDWSE9N33rAr868NrhTih19w9k53epg9vbt5n2VXQ5ppqUPxjJAyKraivgUVR2pA/b2L9/mC
	W7IXb886cseKJqDE=
X-Received: by 2002:a05:6000:2a3:b0:230:c9d4:3f9b with SMTP id l3-20020a05600002a300b00230c9d43f9bmr6143911wry.254.1665505732276;
        Tue, 11 Oct 2022 09:28:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5aYK4Y4tMXQduv79TxQ2+otXPJI9uMbO8SLf+PCWNBTQaiyvU+m/ttIwh10Z03ty1DgDr1Iw==
X-Received: by 2002:a05:6000:2a3:b0:230:c9d4:3f9b with SMTP id l3-20020a05600002a300b00230c9d43f9bmr6143896wry.254.1665505731980;
        Tue, 11 Oct 2022 09:28:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id ck10-20020a5d5e8a000000b0022ca921dc67sm12196576wrb.88.2022.10.11.09.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:28:51 -0700 (PDT)
Message-ID: <6373208fd3b59bb72fd1c6a12af3c4ab115b1e10.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v14 5/5] selftests: mptcp: mptfo
 Initiator/Listener
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Dmytro Shytyi
	 <dmytro@shytyi.net>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 11 Oct 2022 18:28:50 +0200
In-Reply-To: <eb9ace54-579b-f27a-aa78-f1a2cf4b175e@tessares.net>
References: <20221010221809.1792-1-dmytro@shytyi.net>
	 <20221010221809.1792-6-dmytro@shytyi.net>
	 <a03a004fa4ca05ba20a42fe5e092368206af793f.camel@redhat.com>
	 <eb9ace54-579b-f27a-aa78-f1a2cf4b175e@tessares.net>
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

On Tue, 2022-10-11 at 17:49 +0200, Matthieu Baerts wrote:
> Hi Paolo, Dmytro,
> 
> On 11/10/2022 17:33, Paolo Abeni wrote:
> > On Mon, 2022-10-10 at 22:18 +0000, Dmytro Shytyi wrote:
> > > This patch adds the selftests support for mptfo in mptcp_connect.c,.sh
> > > We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
> > > We call sendto() instead of connect().
> > > 
> > > Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> 
> (...)
> 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > > index 621af6895f4d..d2328f94d1df 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > > @@ -677,6 +677,58 @@ run_tests()
> > >  	run_tests_lo $1 $2 $3 0
> > >  }
> > 
> > I guess mptcp_join.sh would be a better location. @Mat[s]: wdyt?
> 
> We only need to test with one subflow. Then mptcp_connect.sh should be
> fine, no?
> 
> I know Dmytro likes to duplicate code ( :) ) but I think run_tests_lo()
> should be re-used. In this case, we reduce the modification to a few
> lines (e.g. what is done in run_tests_peekmode()).
> 
> Then if we limit the validation to 2 tests: one in v4 and one in v6
> (between two fixed ns, could even be the same ns ), we are OK, no? More
> complex stuff can be added using packetdrill. WDYT?

Fine by me!

Thanks,

Paolo

