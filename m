Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6A7E
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669218176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLgRjY2uZRC9ijY+A9T6tbj7z2wlp/8NH9LAeuVBDOs=;
	b=DltfB6Zir+eXgUNWXC6tSpRk03vn5oLmva7f0WXM/XWsI89GtyvE6t08rRCt5J88G4vrjM
	CJv2ovD/HIg2MLwKmQ+0aWyUKhe+hgXtsKtamCkimbbeZxeyN+2uMZqE4J5efxrtF6WFxV
	QV48Ps50psCZlxwuOv7lEHckr9F9i+c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-213-RXipRAxHPJCmq1YdYEgPpw-1; Wed, 23 Nov 2022 10:42:54 -0500
X-MC-Unique: RXipRAxHPJCmq1YdYEgPpw-1
Received: by mail-wm1-f72.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so935264wmb.2
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 07:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLgRjY2uZRC9ijY+A9T6tbj7z2wlp/8NH9LAeuVBDOs=;
        b=B937lThPFZ+yG94XVU0/bdI/zgMYhnil73PxOgH2wCdbY1jx8456IVUdhRQgMwNU6p
         WXMPEivQRoXXEU4Ci82Id2qDmnUkATJokeqF7RP6teKR32BdGlAFy1BpdFKS8qOS4U+B
         PFZu21S7LjTTnf/WFZZaW7Bd/r5kG6W41z1O8Ndy4goDqku1+FL4yBwPPemcy1m5JVvV
         8INQyo6pjEaKbQDs1ynSCVQQm5+kyZ/QUgxbPrUaBW3Mpms1q7rMuIfAPRGAAHpgUWS9
         3UA479+PFstnOkJ4lQnds997gzO1c6VjYcrkDh/Sj38EQaeaUpMR3X3Jfjv9XQgWL8jS
         jP6Q==
X-Gm-Message-State: ANoB5pmEdEULEmd7MwPBlZ0EvOl3osDf55SGc8xvvlAvGit7o1jXbZuA
	zkpcR5m/FsRT1hoAFAGBynKbOymuqXwCE6pkG2AbpB8jPkbXeOcZZ5nDepeT12jIbKbgGLy2Svy
	wM1Sbc7r5r32jjaQ=
X-Received: by 2002:a05:600c:3ba8:b0:3cf:59c9:4a4e with SMTP id n40-20020a05600c3ba800b003cf59c94a4emr10050234wms.17.1669218173355;
        Wed, 23 Nov 2022 07:42:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7qMPdTb/Xh3ofO9wfNwxVi4GXOE6cLj5YVHiBqKmCsW74DMhhdkdPPEyevClZeOF5LwdKFFw==
X-Received: by 2002:a05:600c:3ba8:b0:3cf:59c9:4a4e with SMTP id n40-20020a05600c3ba800b003cf59c94a4emr10050228wms.17.1669218173135;
        Wed, 23 Nov 2022 07:42:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c4ec900b003cfd58409desm3109227wmq.13.2022.11.23.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:42:52 -0800 (PST)
Message-ID: <4f616c8658b67cbbc4557c9521efad2a149500d0.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix sleep in atomic at close time
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Jiang Biao <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Date: Wed, 23 Nov 2022 16:42:51 +0100
In-Reply-To: <4f78725c-7e72-63fe-854a-c6b48f09b932@tessares.net>
References: <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
	 <4f78725c-7e72-63fe-854a-c6b48f09b932@tessares.net>
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

On Wed, 2022-11-23 at 16:36 +0100, Matthieu Baerts wrote:
> > Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Closes: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Please don't close me, it took me some times to find how to re-open
> myself...

What can I say? at I list did not accidently close the b&b ;)

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/316
> 
> For the rest, it looks good to me!
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

feel free to add even your tested-by tag, as you already did that :)
and we can produce same monster tag like 'reported-reviewed-and-tested-
by: ...' ;)

Or do you prefer I'll repost?

Thanks!

/P



