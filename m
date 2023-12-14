Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB33F8C2
	for <mptcp@lists.linux.dev>; Thu, 14 Dec 2023 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L08Z/RfU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c2a444311so77122855e9.2
        for <mptcp@lists.linux.dev>; Thu, 14 Dec 2023 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552353; x=1703157153; darn=lists.linux.dev;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGDHADo7C3NaDRc+ZRm9nq6QxuOQpyaoDXW27f7Yvxg=;
        b=L08Z/RfUYZBN6YOeUi+xvpKH0cuPVTGzHMq3pCADBs/ueD7ivHd3dpFQCVsRTYzpie
         Ie+fP5odkT+uhPS98SbULPZRJfHZj20rt0hYVro2LJAYuV0zK/TF7ar0t1x6ZZfDI6Q1
         TmX+9AAFrsPxt6bG3+AhRfNopGDKvxeinnG3BwJrnV140X6rXgu1i5fKYTzT4jO8mHfd
         RNF7+/Ap77g0RhWpu8kULb09h0+eaWZjUN14AsNZz07N5W9pwPKUMfml7pNFRzqHXXlZ
         D4gW4eHg1DYNqyReSIM7S4Hdoo7ayRBMmhCWBPo3xLYNADRzSGT9yy5lm97F2JCucOWf
         4pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552353; x=1703157153;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGDHADo7C3NaDRc+ZRm9nq6QxuOQpyaoDXW27f7Yvxg=;
        b=nDDtTouEORqhnYovAQmnLlx74EcmcP0iQZqsTDrEv9bzDky3AW74Uaa4s5pMfV7ONE
         RwScemRBEyGxK5l6Fb3U/fsxKyXhjtuDhsosxWCxgqWvjLsYMVS+HC7O8xce2D1qtZnp
         Jp8PRpy5df+o9s1nSV081uqSvBW9UCnODv4KAfBge0KjKIEW3sZ5eT5Ivkkl+SKzMUyX
         VFzCytdq3SKMOXLd9RSmWBivEPnMcOyh4jcLwOIlGY6KBhg8J+OFp2xO5v6pAaK2l50h
         Z14DXRo9jQjYWtPQwORX2CNNtWNwfDyEC2OPPG92DLAMf85t2Pf1bzj1NPOYPNTFcoYM
         6Z8A==
X-Gm-Message-State: AOJu0YwAhT6ui1FSXLANILWufBRBy3fBsyUVZ0kHB4fs/QuRzZrkzS8F
	i3q5ON5SzuLuSFf/JfK0Br5i+GMpOUA4dQ==
X-Google-Smtp-Source: AGHT+IHQq2H06/ajaLzf9ecb2zQvKQDlKeASRQe+NPs3P0RofX1vL7E9lJ60bUJ0sWpUFLobinZ3yA==
X-Received: by 2002:a05:600c:4fd6:b0:40c:38e2:8e51 with SMTP id o22-20020a05600c4fd600b0040c38e28e51mr2872515wmq.13.1702552352652;
        Thu, 14 Dec 2023 03:12:32 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040c4c9c52a3sm12581213wmo.12.2023.12.14.03.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:31 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  matttbe@kernel.org,  martineau@kernel.org,
  dcaratti@redhat.com,  mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] netlink: specs: mptcp: rename the MPTCP
 path management(?) spec
In-Reply-To: <20231213232822.2950853-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:28:22 -0800")
Date: Thu, 14 Dec 2023 08:42:48 +0000
Message-ID: <m2o7et5g53.fsf@gmail.com>
References: <20231213232822.2950853-1-kuba@kernel.org>
	<20231213232822.2950853-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We assume in handful of places that the name of the spec is
> the same as the name of the family. We could fix that but
> it seems like a fair assumption to make. Rename the MPTCP
> spec instead.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
