Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9BD70
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627378858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skKLZNKOoAxO+uIHOya2qL8TCrn44HK7eJSomwAVodU=;
	b=EEaJjY9/gUiMbKqcyuW0Hwg9XXmwR6q1e82pUQ3b8dZqbzz8wWEIqAYVXCV4rYnXGAdA8f
	dhXMVmkJqrtdmwkCATJF4ck7VG1qEjhQw9/Kme/Mi4Pb5Z7xESt/tbygaYiUrJmomPhyPH
	ZNDlVKWVdb5d/3P/HYaylR5u18WDayg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-6Ef7dJGrMTa5ZchBKsCLyw-1; Tue, 27 Jul 2021 05:40:56 -0400
X-MC-Unique: 6Ef7dJGrMTa5ZchBKsCLyw-1
Received: by mail-wm1-f72.google.com with SMTP id o4-20020a05600c5104b029024b7cd56259so367745wms.1
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 02:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=skKLZNKOoAxO+uIHOya2qL8TCrn44HK7eJSomwAVodU=;
        b=o0PI0XZEzoLNbz1JsZyl6ZJb8eplTK1AEZwF2OXx1MIKe2/nHIaeIUo8NhVTPtOLOq
         B7GgM7XaXcojtZ1LRHulcIRcpOpteZP64leVaBctDgxJvDOzuVwp6X0H6WwXoR0TJotd
         YA38JnYFgf6mZSi6J09ivSeura576LL+A9aH73kUJrXiBEcrer6cb2ItTnE58udxiqFs
         9ZywdhIVI8KhEaOXhuf7c3/LV7eHdNLQOQViRW82zdRpxMQvpD4kIeLSXq6i86Hl5HKB
         IJ01TAz8Jy5KKGSM11jrgx8VWC5ZdBOiI6OURwLNEZDhldKZcasFzXEGdUuyftblh8ou
         v7zg==
X-Gm-Message-State: AOAM530X+t+tmyGMyy5AmgLzCLEm46MkIqru/N+CpFD+ElocXOdSbNJ7
	SocWMeq+hGh2ceye53/f2kZaimeElMs/h6sJ69tB95/j5E/B0ziQURPxu3ytQkf3plK3RoHMjLE
	MUq/OoBqkYwn/DAU=
X-Received: by 2002:a05:6000:1625:: with SMTP id v5mr20718495wrb.80.1627378855421;
        Tue, 27 Jul 2021 02:40:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+diCmldxYT1rHg/N/mjoO0aRQGQQhXI5bR+U/S5EbsdAcWZNbNagMfyzTbjjwbbO9Bj/Pvw==
X-Received: by 2002:a05:6000:1625:: with SMTP id v5mr20718484wrb.80.1627378855265;
        Tue, 27 Jul 2021 02:40:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id p22sm1973997wmq.44.2021.07.27.02.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:40:54 -0700 (PDT)
Message-ID: <728d96e71e97b8b7e0dfd19593febf3c2c58380c.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: remote addresses
 fullmesh
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Tue, 27 Jul 2021 11:40:54 +0200
In-Reply-To: <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com>
	 <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
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

On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
> +static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> +					      struct mptcp_pm_addr_entry *local,
> +					      struct mptcp_addr_info *addrs)
> +{

I almost forgot another minor nit: some comments before the function
and/or in the main loop describing the function goal/behavior will make
the code more maintainable in the long term, thanks!

Paolo

