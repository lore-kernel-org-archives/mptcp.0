Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97732C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641460916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+1rMWwsTI02g+JunHYnsHyYy+KhFYcmNYVY0LzBL44=;
	b=AzdopGFJhAtKD5kcvXa3jm+QvWNyFziBCj+gP/5Q2G+C6OQf+WnFzjiTx/EJQRTlzgcB6x
	PdD2ZbtkyZGYMlLagKgKccOB6xehAHtkoDOZrhmdPXnEwkaJE0wwQxh4e8YocA6g4R7F+w
	bUK5pNzvhaWC0zUtTs0NcrifEJTlOL8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-vWwEBu49MeCcpxjpbuAaKA-1; Thu, 06 Jan 2022 04:21:54 -0500
X-MC-Unique: vWwEBu49MeCcpxjpbuAaKA-1
Received: by mail-wr1-f69.google.com with SMTP id h12-20020adfa4cc000000b001a22dceda69so977487wrb.16
        for <mptcp@lists.linux.dev>; Thu, 06 Jan 2022 01:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K+1rMWwsTI02g+JunHYnsHyYy+KhFYcmNYVY0LzBL44=;
        b=ZRXJTNORYBH3gHoTWOeVN79tr/UVwHUj83KVya7TKTk9NKwW1Y+32Q94BA3WFjGHyP
         4nI+WfIqunykKaiFz4AgTx9NORZaCZsdEmFDR3F/p/iNDy8GWSqzezFJGa8ypBf8hDsp
         1G+xGZDsD52yTYNoW71bknHNtFHmsPrvHaIkWjXeQZcVsSl9DwCYuMRD1604gPSusuzu
         wziGUQ1wuRbvdP4zkr6b18nfi2acyK/GlxTJ9ZsWqojJVlKmQ/fy4d5QjEXzKWM38XPH
         T4qj4I0uUVj99bSHJ6rKtD2g9X/bBzcwnn4vf5QKPKIqS7AJghHZMK+HQRpi6OmVZ6jD
         rOGQ==
X-Gm-Message-State: AOAM531XMqUmRUXIS9xfXSOUexx55cd4bSCUr+idJ1ic2EY+tpBdsaRc
	HrzP+KzX0XcsFFpF9TfpLthSC6QBm0GFN0USMJuMdO9cZsCPvgeYERkVSHRy62jJyCWVVIdtq72
	P90sV34lrmgT1Y6s=
X-Received: by 2002:a05:6000:16c4:: with SMTP id h4mr49288008wrf.312.1641460913606;
        Thu, 06 Jan 2022 01:21:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyR2nJdax0dB3D8659Fm6tCprJRzLwx1hGrq++jSAVoIE8xwilvaTgZlWY6hPFI9ssplYaOOw==
X-Received: by 2002:a05:6000:16c4:: with SMTP id h4mr49287987wrf.312.1641460913338;
        Thu, 06 Jan 2022 01:21:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-184.dyn.eolo.it. [146.241.97.184])
        by smtp.gmail.com with ESMTPSA id p11sm1762871wru.99.2022.01.06.01.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 01:21:53 -0800 (PST)
Message-ID: <d816d92c328cca717b3f5576aa7a57d60b5478f9.camel@redhat.com>
Subject: Re: Upstreaming to net-next
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Geliang Tang
	 <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Date: Thu, 06 Jan 2022 10:21:52 +0100
In-Reply-To: <7b9cdfb-9ae6-287e-9e3e-7cf8e67e998d@linux.intel.com>
References: <7b9cdfb-9ae6-287e-9e3e-7cf8e67e998d@linux.intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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
Content-Transfer-Encoding: 8bit

On Wed, 2022-01-05 at 17:54 -0800, Mat Martineau wrote:
> As Matthieu noted in today's meeting, we need to figure out what goes 
> upstream to netdev this week:
> 
> On Wed, 5 Jan 2022, Matthieu Baerts wrote:
> 
> > Patches to send to netdev:
> >    - net:
> >        - probably best to send:
> >            - mptcp: fix opt size when sending DSS + MP_FAIL
> >            - mptcp: fix a DSS option writing error → but we might need
> > to change
> >        - But if they are accepted after the last PR from Net maintainer
> > to Linus would delay stuff.
> 
> I noticed that Jakub sent a "Networking for 5.16-final" pull request to 
> Linus today, so the 5.16 ship has sailed.
> 
> >        - So if we don't want to rush to look at the tests, we can also
> > send to net-next for the future -net (to be check which tree is merged
> > in which one first?
> 
> The next pull requests from Jakub to Linus will be from net-next, so 
> that's the fastest route to Linus' tree for fixes that will be added to 
> the stable tree.

I'm a bit lost about all the above. Not sure if due to lack of mtg
background, lack of coffee, or lack of time to digest the above ;)


> 
> > 
> >    - net-next:
> >        - patches from Paolo could go there, fixing issues, see GH
> > issues/250:
> >            - *@Paolo*: OK for you?
> > 
> >        - + checksum fixes probably
> > 
> >        - best to skip MP_FAIL series for now as we don't have a stable
> > selftest yet
> > 
> >        - and no need to send Mat's series as it is linked to new
> > features in the Netlink PM part, not ready yet
> 
> Here are the commits that look ready (commit ids from 
> export/20220105T054758):
> 
> Paolo:
> 
> 9f6720406819 mptcp: keep snd_una updated for fallback socket
> 95bc19b21e00 mptcp: implement fastclose xmit path
> 37b1cee6f04f mptcp: full disconnect implementation
> 916957cdccd6 mptcp: cleanup accept and poll
> 6358b829913e mptcp: implement support for user-space disconnect
> adba2e970980 selftests: mptcp: add disconnect tests
> afef858f5fa4 mptcp: fix per socket endpoint accounting
> 9caba598fe7a mptcp: clean-up MPJ option writing
> f584047ecf9a mptcp: keep track of local endpoint still available for each msk
> fc51a4526843 mptcp: do not block subflows creation on errors
> 893d4cb7ccb9 selftests: mptcp: add tests for subflow creation failure
> 128e78db18bf mptcp: cleanup MPJ subflow list handling
> e470b365da5f mptcp: avoid atomic bit manipulation when possible
> 
> 3cdd8e644985 selftests: mptcp: more stable join tests-cases

... anyhow this LGTM for net-next.

Thanks!

Paolo

