Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133A3FC1
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630483154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
	b=SVu3Ie7M7qe03EblygVArvpDQoYY1Nlm4MtpL7bRifjFZ3Vj6D5VeCSiez28rUVnVk56ez
	yI5ZdaqGRZtgyovOLitsbUyOo5r540Cr/wEoYGcfKw16gquTJZB2NqXI0Rjhk064d6pyJy
	ScDI4qBIMNjUOzgoJekNf+iEvjr1tBk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-c42oQY9QME6wIpWCllQj4g-1; Wed, 01 Sep 2021 03:59:13 -0400
X-MC-Unique: c42oQY9QME6wIpWCllQj4g-1
Received: by mail-wm1-f71.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so719823wmf.3
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 00:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
        b=OpbUqr0scPzYtq3bNF36g7g8tAt2LRP4X2dG8FiefQiqflLTuADi103jM13VEL4bEd
         PqdwWGcynORzdFX6hJdXLkU2WTmIkLkCIdEPfmjI6iLpufGswso5lVYKijEu5XS3g47N
         5wW8SCVqb8YYT+JcAjY2TpCGu2WvG5w2tJPAAgWhy1CFqOKY3T1Qz9Ad7uaySvsncVNi
         XFxyHFkSgH0+PB7mwXmuqEWWE3Dl6myjLM5YXXvmWWtMJUUrFajZ8xvUP98PqccIeqKK
         NAqaeerJcPwxEsBX/0gnXifIisYUnYwVXYhliKpgeVphC26O6elsXDMzzMekYRzDMCk1
         Hm9Q==
X-Gm-Message-State: AOAM531hrHrkkJsfAFGdd2IxuIf8IVeaChSXSqy9qOecsN8JOzgIldzM
	PN74AnN/FMTJb3+QRyNA0tkl+WAJxBzafcGhlSwMG+uVN4BZYh41gkURz7gtp4o8GhPIfqnRprD
	YlGkXKUO8k078RZU=
X-Received: by 2002:adf:b318:: with SMTP id j24mr35920238wrd.84.1630483152538;
        Wed, 01 Sep 2021 00:59:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6qSKRkrppsPrE7xFz0DPwkHom7QW17kdpSLZeZaFEbxoQd+jkS4db/+oYTilJq6NO0oKDdw==
X-Received: by 2002:adf:b318:: with SMTP id j24mr35920224wrd.84.1630483152355;
        Wed, 01 Sep 2021 00:59:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id o23sm8974034wro.76.2021.09.01.00.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 00:59:12 -0700 (PDT)
Message-ID: <d49518ac90b2442fc293fd333d0315b1cff00671.camel@redhat.com>
Subject: Re: [PATCH] [v3] mptcp: Fix duplicated argument in protocol.h
From: Paolo Abeni <pabeni@redhat.com>
To: Wan Jiabing <wanjiabing@vivo.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski
	 <kuba@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: kael_w@yeah.net
Date: Wed, 01 Sep 2021 09:59:10 +0200
In-Reply-To: <20210901031932.7734-1-wanjiabing@vivo.com>
References: <20210901031932.7734-1-wanjiabing@vivo.com>
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
Content-Type: text/plain
Content-Transfer-Encoding: base64

DQo=

