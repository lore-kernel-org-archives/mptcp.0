Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C92F25
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644267230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwws/JzFb7qNchOVfOTF7ZJ8E0pOi4VvV68oyaBvowY=;
	b=YTDVLLd9uBZJRlBSSOOg4pJqtBTajz427dclsCIix6AkI73vRC7hYzQob1qysL+m4QC2vY
	U95IF4BGMMya2xoorydVGUrYEikZhs3/UsZEYuYyPktBsCJJg2tdbhTBkKEzlzQjGF6yg2
	TxciXNmi8EV25VRvRPwxXtds7y9WXKs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-bEXEQW3XOXqFG8jXnTofZQ-1; Mon, 07 Feb 2022 15:53:49 -0500
X-MC-Unique: bEXEQW3XOXqFG8jXnTofZQ-1
Received: by mail-wr1-f72.google.com with SMTP id e1-20020adfa741000000b001e2e74c3d4eso3343620wrd.12
        for <mptcp@lists.linux.dev>; Mon, 07 Feb 2022 12:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wwws/JzFb7qNchOVfOTF7ZJ8E0pOi4VvV68oyaBvowY=;
        b=a566fZz9aImOlj7kGg5fMtKV96uetzbaED3G+m6pv5idPHyPJKLr7fVdg0fHNkTW6z
         fXD+AU9xVdJ7zTbXlndsuYt8F2seMTJ0aYp1wFwZ2+0XPqksHVPwxo5UeOexu05DSuk+
         lbaRZVjL5hDs0E36NA4brqcaKhMskJNeS8HzRZey9CDzZpWvZ1ZZaEIba/uykRE8trcX
         260tccVnp1DnXH4Gb0ZjHFAXc7n1Hh3lsreGdFgMhmZcQPS5JtZc9nkxHRpiLjQa8b9M
         A9LZRpMlnUbjRLQtzQpPShPpi2GSXYaf1dZfeZG2i6QnOcKjEtUD0g7zGcRDuMXdHBtX
         Hjnw==
X-Gm-Message-State: AOAM533vzhbJPOIyuUGPgVpJkSxvJUV0Lgo2a3u5/ayhUMeUv78cs+jw
	OHett/SpOjdAHcbw1XMqt9L94PRTURgDmo8ZlBGmrKEwmOrah1xZAbvrax6baU+/SBO3t5/4znH
	IOg2z9w4XQkLJtUSrRkRiEuDee59xtZGnaoLwXL7ImAqkUcFbsbHiil51O/XPXUu+
X-Received: by 2002:a05:6000:168c:: with SMTP id y12mr919654wrd.265.1644267227540;
        Mon, 07 Feb 2022 12:53:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyk/v3Acrn2ij/WX9Wh1z3BNjpr4hiJGtS4LWrWv5UK0+7/UmOWB0CmNmngtvriU6k7iaSPhw==
X-Received: by 2002:a05:6000:168c:: with SMTP id y12mr919645wrd.265.1644267227297;
        Mon, 07 Feb 2022 12:53:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id p12sm168363wmg.36.2022.02.07.12.53.46
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:53:46 -0800 (PST)
Message-ID: <f6abaf441e13c2f4cb6929605f67f9c0c7417e44.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix race in overlapping signal events
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 07 Feb 2022 21:53:45 +0100
In-Reply-To: <c5d17a37b8ad315e72dd8551e148017a66987f7f.1644266387.git.pabeni@redhat.com>
References: <c5d17a37b8ad315e72dd8551e148017a66987f7f.1644266387.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Mon, 2022-02-07 at 21:39 +0100, Paolo Abeni wrote:
> After commit a88c9e496937 ("mptcp: do not block subflows
> creation on errors"), if a signal address races with a failing
> subflow creation, the subflow creation failure control path
> can trigger the selection of the next address to be announced
> while the current announced is still pending.
> 
> The above will cause the unintended suppression of the ADD_ADDR
> announce.
> 
> Fix the issue skipping the to-be-suppressed announce before it
> will mark an endpoint as already used. The relevant announce
> will be triggered again when the current one will complete.
> 
> Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Please keep this on-hold a little, it need a little more testing,

Thanks!

Paolo

