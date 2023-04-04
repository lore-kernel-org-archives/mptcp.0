Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103876D22
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 13:59:08 +0000 (UTC)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-kFQy_Pm_Pe6taA4-fomviQ-1; Tue, 04 Apr 2023 09:59:06 -0400
X-MC-Unique: kFQy_Pm_Pe6taA4-fomviQ-1
Received: by mail-qt1-f198.google.com with SMTP id r22-20020ac85c96000000b003e638022bc9so10215797qta.5
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 06:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TRrhmDIBvP4ZGmnJwTlUysQMTGjMfM/YpM5TkiQkZ74=;
        b=StX1ej/VFExx9rB/TTrNC2rTMPKAyx3pdZHc4n7YZOeVVfMPzJMfDhcbc4F/MxfCAj
         l3z/6mgcgcTzKI4v9Wja3DaqtY6qGnDe80dIrnI9kH9niv2wr9DczZ66k7kH9CyaMj+B
         3Stq8oI5p/a9A9sdFmNqqrCde/dDfigIVnldh1SlqWO4XFvdNoHnAC6EkqUcw1hxpmnY
         F8QE8cQXnYE8rwQxJknLmDTkoALDcK2r9EZdY8f93YW8UNktgTvvaW6pMhGpetS8Y8KQ
         bV5GNoWVm9rCmQk+j4t45foRpNaFem1TM1DR97Bi4HbwiwbQzytxfZ2y8vU9OcYcMJrv
         ztqA==
X-Gm-Message-State: AAQBX9fN6iAiX1jf+8EXYM3Xq65BvVWMAch1O+ccdEB0rzeDy0yS5/fx
	1laOICxn1MpAp688mGQPMqrVTQYbAIlkEe69J0q/WRJFvINT5QaFbuaTgXrlzq/vrJw+8V6vtMy
	JQb7vxrvqYMLGZlX313YRm7k=
X-Received: by 2002:a05:6214:29ca:b0:5dd:ac69:4bdf with SMTP id gh10-20020a05621429ca00b005ddac694bdfmr3465789qvb.3.1680616745476;
        Tue, 04 Apr 2023 06:59:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350YOLffW8zsxuMKU1UArnJH8sAh1AX29LcTS7fRbHV0BWjZHnRM8AJjmRs2ACVxipivs9jlDpw==
X-Received: by 2002:a05:6214:29ca:b0:5dd:ac69:4bdf with SMTP id gh10-20020a05621429ca00b005ddac694bdfmr3465758qvb.3.1680616745066;
        Tue, 04 Apr 2023 06:59:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b005dd8b9345bcsm3421294qvb.84.2023.04.04.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:59:04 -0700 (PDT)
Message-ID: <ba55d265f400227a15331e9cf26112de111a3e74.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: userspace pm: uniform
 verify events
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 04 Apr 2023 15:59:02 +0200
In-Reply-To: <20230328-mptcp-selftests-userspace-sleep-verify-listen-v1-1-2a4adf550084@tessares.net>
References: <20230328-mptcp-selftests-userspace-sleep-verify-listen-v1-1-2a4adf550084@tessares.net>
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

On Tue, 2023-03-28 at 19:05 +0200, Matthieu Baerts wrote:
> Simply adding a "sleep" before checking something is usually not a good
> idea because the time that has been picked can not be enough or too
> much. The best is to wait for events with a timeout.
>=20
> In this selftest, 'sleep 0.5' is used more than 40 times. It is always
> used before calling a 'verify_*' function except for this
> verify_listener_events which has been added later.
>=20
> At the end, using all these 'sleep 0.5' seems to work: the slow CIs
> don't complain so far. Also because it doesn't take too much time, we
> can just add two more 'sleep 0.5' to uniform what is done before calling
> a 'verify_*' function. For the same reasons, we can also delay a bigger
> refactoring to replace all these 'sleep 0.5' by functions waiting for
> events instead of waiting for a fix time and hope for the best.
>=20
> Fixes: 6c73008aa301 ("selftests: mptcp: listener test for userspace PM")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/te=
sting/selftests/net/mptcp/userspace_pm.sh
> index 48e52f995a98..b1eb7bce599d 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -913,6 +913,7 @@ test_listener()
>  =09=09$client4_port > /dev/null 2>&1 &
>  =09local listener_pid=3D$!
> =20
> +=09sleep 0.5
>  =09verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2=
.2 $client4_port
> =20
>  =09# ADD_ADDR from client to server machine reusing the subflow port
> @@ -928,6 +929,7 @@ test_listener()
>  =09# Delete the listener from the client ns, if one was created
>  =09kill_wait $listener_pid
> =20
> +=09sleep 0.5
>  =09verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.=
2 $client4_port
>  }
> =20
>=20
> ---
> base-commit: 1281a7eb9aa62b79cb9ad4d221ae31659ed892d0
> change-id: 20230328-mptcp-selftests-userspace-sleep-verify-listen-4fb855b=
c054d
>=20
> Best regards,

LGTM!

(no need for a forma acked-by tag imho here due to the already present
tag)

/P

