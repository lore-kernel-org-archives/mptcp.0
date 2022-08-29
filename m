Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC03D65
	for <mptcp@lists.linux.dev>; Mon, 29 Aug 2022 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661779407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6bQH0QudxVBqE03fZaKsQZ1B8AIT6nabVsLgna7BHA=;
	b=Pv6dqp5pspuZ9Zvy2X7sEGDKwsiigsXu9c6uHHyB3CCOXUUDeckdJXImJooB7hW7ASTI2K
	c6fgfi0xgSpzqibI+BQTj+nd0P8OLy6jzgUxIQsqEVrftZjqelpDnorBopYi8Uw16KJipC
	rdnruQEXNi2XI1QGytGcqNZHBH6Ufoc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-WuxeZbEnNmeKLIqZR5zGyg-1; Mon, 29 Aug 2022 09:23:26 -0400
X-MC-Unique: WuxeZbEnNmeKLIqZR5zGyg-1
Received: by mail-wm1-f72.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so5058343wma.4
        for <mptcp@lists.linux.dev>; Mon, 29 Aug 2022 06:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=Y6bQH0QudxVBqE03fZaKsQZ1B8AIT6nabVsLgna7BHA=;
        b=RrtXTTToJR1ZYX3rYc1k38VqUFOJupL1YL71meFJsx7cKEzgF6+/9teuNMGzm0QO3B
         jtu6PsOUC5ZB7jBShMlFr66XLLeepxQY35TzO9BqPkruxAbJcO3ThPOMmQiS/ACEDQ+r
         N9l8pQY1NGWcbgopnXytPkQkQXuV2LNa7r+xCtnyREgTOus8TW92sc0Sdg/vdYz/QEyR
         YY951gGLvbx1ubmKo+p6W0Q+tCmH2luNLHabUOaorZeqk5rZ8JxulaDGGEz74tNs86zP
         /xDL6BMl1nN6A//rW7gSSB0TzfTCNXk2IjpmU3OvwBwCI5XnCpWHiUsknKQIEm2qF03x
         +dIQ==
X-Gm-Message-State: ACgBeo0rmU2FMc00UtV+lonbwFhKxRulHa/uOihUlerfJ23ugcJEtK9R
	P5tuqKw0f4gusoAPs/L9D2T3+SwZeWNmgnmPCD0vRxGb6QlBu7QogWOJ5hHkXGltn6MBmMrWENV
	nyTPkhRZz08n4Cb+RiMfc4bxXBpGTP/ry1S0unuUCpPVUTdoE73osUDHbduQZpWaT
X-Received: by 2002:a05:6000:178f:b0:221:7dcb:7cbf with SMTP id e15-20020a056000178f00b002217dcb7cbfmr6435706wrg.58.1661779405342;
        Mon, 29 Aug 2022 06:23:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CbMy44j7fbTz2Nzkth5kON4VOgbUpIEsRztyuWypv8YnQ368L23a8KeuoZIAY9zLoS17PRw==
X-Received: by 2002:a05:6000:178f:b0:221:7dcb:7cbf with SMTP id e15-20020a056000178f00b002217dcb7cbfmr6435696wrg.58.1661779405070;
        Mon, 29 Aug 2022 06:23:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c2d9400b003a342933727sm8680031wmg.3.2022.08.29.06.23.24
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:23:24 -0700 (PDT)
Message-ID: <1455852631243eb21d13c86ba3ca2332a9bf48a3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: use fastclose on more edge scenarios.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 29 Aug 2022 15:23:23 +0200
In-Reply-To: <fda2e5ce19891d50fc3b7cff19c81330b5b475b1.1661533333.git.pabeni@redhat.com>
References: <fda2e5ce19891d50fc3b7cff19c81330b5b475b1.1661533333.git.pabeni@redhat.com>
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

On Fri, 2022-08-26 at 19:03 +0200, Paolo Abeni wrote:
> Daire reported a user-space application hang-up when the
> peer is forcibly closed before the data transfer completion.
> 
> The relevant application expects the peer to either
> do an application-level clean shutdown or a transport-level
> connection reset.
> 
> We can accommodate a such user by extending the fastclose
> usage: at fd close time, if the msk socket has some unread
> data, and at FIN_WAIT timeout.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

self-nack. This causes self-tests hang-up, even if the root cause of
the latter is likely pre-existent and this just uncover the latter
issue.

Will send a v2.

/P

