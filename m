Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E42CA9
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639764289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr20za68Sqg40Pb0QTZaC/YIwqujjMCN9ptxOarV0SE=;
	b=S7pET+Q4ID9bohGwYcxN6rM4ka/WA6y5IGi/3fhwmuw0EsHrtVyAi8e+AhcgvBWX8b/baY
	vyaGWXSlCYZvwcJ7WvxzmulCCFC9K30FjlfvzCo+fKlxXKb2ix1jpm+zguLfQzASbftXPf
	2Iv11jbLKRo0ZVpCUxjVc4dGm+2m0mw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-Ket7-2L2OvW0C5H-RZIReg-1; Fri, 17 Dec 2021 13:04:48 -0500
X-MC-Unique: Ket7-2L2OvW0C5H-RZIReg-1
Received: by mail-qk1-f200.google.com with SMTP id u8-20020a05620a454800b00468482aac5dso1334148qkp.18
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 10:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Vr20za68Sqg40Pb0QTZaC/YIwqujjMCN9ptxOarV0SE=;
        b=18QFEXBAHvN1gZG7hAiiL/N8LbraJ5AfSbqs/XxenRmnIK0ypQsuYGqg9F+X4MCCMm
         EvTVZlgm04e/oTO2vXGCxx10dPaT7x0Duoy5onk9Hmzr5zGz2BTuwj3X9ls6XhqqOw5U
         I5moeKieGxXyqtXEOvdtRHk04jrVf76BPyBTOSA9/maWeYfOYXZHgB3KgOD3+MxGfEH2
         hdTRqRdbOsFW7QC6fN9074iqkjifvwKvfRrQMY4ZHjZGGKr7IrTSZsEXEdFYo1X4nLJR
         gqfl45QoObpur2B5sUwyxIVecIYESs9jUlmTxX2gspVVr+uEYxtinuHKMz3jgKtHtsPi
         s1uA==
X-Gm-Message-State: AOAM530vWZD2hfN5rqVxnUOI0HLQmz/fKHOygEaoGEmDy0F07lyuUkts
	RCUI/TDtBV6YjJjYIytxuUYmX4HdhKGCwvvkkaw49hcAxAmCOdL0lUeO+jxBT4RPxu/BugRzI9t
	DKYRmYX3Z2zYQkgE=
X-Received: by 2002:a05:6214:2a8d:: with SMTP id jr13mr3526691qvb.85.1639764287953;
        Fri, 17 Dec 2021 10:04:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6VHKEBY7yz6G1E7G2JwTfyyW2vSvWB49VfS67H1OeISBIFDC+3vUOngTclfnHJFfrp4rUBA==
X-Received: by 2002:a05:6214:2a8d:: with SMTP id jr13mr3526665qvb.85.1639764287618;
        Fri, 17 Dec 2021 10:04:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-225-60.dyn.eolo.it. [146.241.225.60])
        by smtp.gmail.com with ESMTPSA id y6sm6848812qtn.23.2021.12.17.10.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:04:47 -0800 (PST)
Message-ID: <36f0c0b90d362b0f6a2ab02ba1f192eb87481752.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 08/21] mptcp: attempt to add listening
 sockets for announced addrs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 17 Dec 2021 19:04:44 +0100
In-Reply-To: <20211216222314.1244708-9-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
	 <20211216222314.1244708-9-kishen.maloor@intel.com>
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

Hello,

On Thu, 2021-12-16 at 17:23 -0500, Kishen Maloor wrote:
> When ADD_ADDR announcements use the port associated with an
> active subflow, this change ensures that a listening socket is
> bound to the announced address and port for subsequently
> receiving MP_JOINs from the remote end. 

Is this change strictly needed for user-space path manager? I
personally think we should avoid it.

yes, port-based endpoints do create an in kernel listener socket, but
that is sort of last resort thing, it's a single socket per endpoint,
and it's created at endpoint creation time.

The fact that potentially multiple listener could be created "under the
hood" at run-time can have a number of bad side effects hard to track.
e.g. if an application already create multiple listeners on different
address, it will randomly fail at startup...

Can't instead the user-space path manager creating the listeners as it
fits it's strategy better ?!?

Thanks!

Paolo

