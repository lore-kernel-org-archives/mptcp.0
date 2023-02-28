Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC843D84
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677601875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLK+1++XOfhBI0GyMZBC+vSl5YvUdp9nWUSOnAMXtxE=;
	b=DQJoA19tfRTgyZ+KMFI+3QCC3dZMTKjED9LrBd9Wri6h+fvvuW3Xz638t2yPNLkLY6lBlF
	HbI5+sfoGgzTAwmzPWyuyJy7WzFh0BIf2nGXsZZpDOCgKO4xxfwBseHI2/Q1Z0dVBGfkKB
	UdcPMlFsUUOMjyRCQYl6l4x+3RnJ1AQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-345-E0yfaBt1MFW_3jjWaRQ4Pg-1; Tue, 28 Feb 2023 11:31:14 -0500
X-MC-Unique: E0yfaBt1MFW_3jjWaRQ4Pg-1
Received: by mail-wm1-f71.google.com with SMTP id m31-20020a05600c3b1f00b003e9de8c95easo3812163wms.2
        for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 08:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677601872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qLK+1++XOfhBI0GyMZBC+vSl5YvUdp9nWUSOnAMXtxE=;
        b=zLilJCTWeWFrCW8V3QghQMT8isr1ptnYLW7lM8TNzgmRXrTfC42JnfCGGzqOs+WubU
         hpmmicvmCwBdVySM6qjJDrTo89sXvWTX9OXaOn3AYflOD14Cp7C81Y57atfr0ESl9+F4
         qynSykQjauJSD1W+M98yhXQC2ncOytEkgBuYzulsTRxUwrsRW349QM7kbKCVh+CHLS30
         GKN0VgQG1YzEK3AeJlvqqDqiNqZ7gADxuWJEPnsGKInEc6uMrmdgtLsTkBCvJtVGOoC5
         FwTC8Xk/BF+1mKFRDTWuS6Hc89Nru5u8UCM+tBjIwDjlRm1sfkHWr7UBszP/H1fK1ECd
         C37w==
X-Gm-Message-State: AO0yUKVqcMrV8DETgpZLeQ47Pw+qJxZsFmEGV+ls/fWI8cyN5jnRqkTg
	oZxMNRm98DHZDjiX2bViC/doGf4IwY0Grbd43ezromGDel3xPotg/EyAPJhsy6e+Oe+X3Ezjl+Q
	mnNNLfvhb7OT9XGX2ap8IJel4+zoNl0Hv3uq15bVPNAvHuxlm399hKt+jTu9www1Te9cwIg==
X-Received: by 2002:a5d:4d0c:0:b0:2c7:1b4d:935f with SMTP id z12-20020a5d4d0c000000b002c71b4d935fmr2427580wrt.0.1677601872720;
        Tue, 28 Feb 2023 08:31:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+Ykzeu5xtOXVdAiONcBCHLm7ylBjloXPBtTtBEIdl16APFNYIDMdJehuotHdAGS/k3dS9SPA==
X-Received: by 2002:a5d:4d0c:0:b0:2c7:1b4d:935f with SMTP id z12-20020a5d4d0c000000b002c71b4d935fmr2427558wrt.0.1677601872368;
        Tue, 28 Feb 2023 08:31:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d6a82000000b002c53cc7504csm10532092wru.78.2023.02.28.08.31.11
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:31:11 -0800 (PST)
Message-ID: <f5a2a5c5b069d5226e6fc1b541501c52e1090111.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix lockdep false positive in
 mptcp_pm_nl_create_listen_socket()
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Tue, 28 Feb 2023 17:31:10 +0100
In-Reply-To: <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
References: <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-02-28 at 17:19 +0100, Paolo Abeni wrote:
> Christoph reports a lockdep splat in the mptcp_subflow_create_socket()
> error path, when such function is invoked by
> mptcp_pm_nl_create_listen_socket().
>=20
> Such code path acquires two separates, nested socket lock, with the
> internal lock operation lacking the "nested" annotation. Adding that
> in sock_release() for mptcp's sake only could be confusing.
>=20
> Instead just add a new lockclass to the in-kernel msk socket,
> re-initializing the lockdep infra after the socket creation.
>=20
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Fixes: ad2171009d96 ("mptcp: fix locking for in-kernel listener creation"=
)
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Sorry for the unintentional dup. PEBKAC hit again here :(

I'll drop this one from PW.

/P

