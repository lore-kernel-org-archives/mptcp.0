Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518447F
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651597604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuRd1I8s+u8ZBqpRX8heAEjBIIYRkA/82WGybacZbAE=;
	b=S1E7RuKjGY4dVUa0MImqs0cRZg8IRGPoK1D0qVU1MrJXHboKY360om6ui3EpfoJ4j1BMSP
	B/rpIshW04niZV1I010tsML2yBWynKtAxHXICYTDZPryh4/M8vAoaKE406OlV8VEYbiPnO
	skCZSw4I1hRKjcJpD33hOseg2bcQdw8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-0GWlvSayOheDuv_T-vgAXg-1; Tue, 03 May 2022 13:06:43 -0400
X-MC-Unique: 0GWlvSayOheDuv_T-vgAXg-1
Received: by mail-wr1-f72.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so6569421wrg.19
        for <mptcp@lists.linux.dev>; Tue, 03 May 2022 10:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KuRd1I8s+u8ZBqpRX8heAEjBIIYRkA/82WGybacZbAE=;
        b=7D78YzFjuugfBNjkX0i2QFZrFOivKZMT6FeRmIUGGek4JqCpmlOyXBO/HHvQVu6+qW
         8xJN7J85xPFsuqrF4IgPUOvscQ2a5/vSRkPzFlXJrsjVbcXrdi/f+2weX7wa5Mdwpak0
         OnRPMaqdqKp7LKHgPJrQp6OQgRcQgghrMf5RjjJSM3GdDO4/WMgZSkN9aKykZxfAF6pO
         vBi7TuZ+ddHebB0ussv65tCsbLyrBJ9ICayHu0YfBwv9dUrwtQSEi00ZpjTVywmf7P7N
         r4G0MD/smNL0FWhPK2T7ZfS1Tmzg23GQTJcShsaCuPJpifOaxiujsxQqyul6PKe/Sll0
         WWUA==
X-Gm-Message-State: AOAM531Lv8BQWSKrjygYtoXbjpYDteoQW3AFXXn7Z+3X7Vqkd6sCP25D
	uc9X3LB4NChlduc53o0M/0jRTnUF4YpSbni9ptJHQlK1G6ruYi+9J2gBj/Beur9rIG3/aFfaYxv
	L6CnAPB6MkNXSJWI=
X-Received: by 2002:a05:6000:1889:b0:20c:617a:b087 with SMTP id a9-20020a056000188900b0020c617ab087mr8690460wri.102.1651597601731;
        Tue, 03 May 2022 10:06:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaZgWXLAhmfZBSGJ8GK/MXdJTacIa6ZVCAg/eNwF++2+lvLZIN22mJi2EMWYgrGbUHi+XdIg==
X-Received: by 2002:a05:6000:1889:b0:20c:617a:b087 with SMTP id a9-20020a056000188900b0020c617ab087mr8690442wri.102.1651597601443;
        Tue, 03 May 2022 10:06:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c355200b003942a244f32sm1609642wmq.11.2022.05.03.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:06:41 -0700 (PDT)
Message-ID: <66bebfa5f6fcfc6180e13861bd1f629b066a5f4d.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix MP_FAIL test-case
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 03 May 2022 19:06:39 +0200
In-Reply-To: <7d6e2ab9-ac1-a86f-2ce4-4551e63eb087@linux.intel.com>
References: <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>
	 <7d6e2ab9-ac1-a86f-2ce4-4551e63eb087@linux.intel.com>
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

Hello,

On Fri, 2022-04-29 at 12:46 -0700, Mat Martineau wrote:
> On Fri, 29 Apr 2022, Paolo Abeni wrote:
> 
> > The mentioned tests sometimes fails because the data
> > transfer completes before any packet is sent on the 2nd
> > link (the failing one).
> > 
> > Address the issue reducing the "virtual" b/w available
> > on the primary link.
> > 
> > Fixes: bfd4cdbe7032 ("selftests: mptcp: add MP_FAIL reset testcase")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > together with the previous patch this fixes issues/265 for
> > good here. I'm not adding the Close tag due to the mentioned
> > dep, which may take a different/longer route
> > ---
> > tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index a98fee834950..0d65295c1b33 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -2734,7 +2734,7 @@ fail_tests()
> > 
> > 	# multiple subflows
> > 	if reset_with_fail "MP_FAIL MP_RST" 2; then
> > -		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
> > +		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 10mbit delay 5
> 
> The "MP_FAIL MP_RST" test still fails within a couple of minutes on my 
> desktop with this change. I changed 10mbit to 1mbit and so far it is still 
> running. You ok with slowing it down even more?

[sorry I almost missed this comment]. Just to be sure, is such test
running on top of the pedit patch? (we need both of them). Otherwise no
objection to reduce the rate even more.

Thanks!

Paolo


