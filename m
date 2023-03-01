Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374FEC8
	for <mptcp@lists.linux.dev>; Wed,  1 Mar 2023 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677657033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azO+asK5EdmjAdxnQKLYAHq3HlOIOK3qCx+ntgTBMU4=;
	b=P+sLw5mifdw2qhtjfFvfJpTulVQheOqiDdl+HVhtiNQwQZseM8l7gQRLSlAnT6lBS5IKH4
	1Wm3U90f14zThFnbqgMmQBCWNkiksvz6zNwxcVlGQD2hjHunggrI82ZNT/NsDak3C54WLg
	ryM9GtE/5ogY4lmhRjZPUCwKnLe5V/Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-178-lR7wtis4PcmuxZfizwjwfg-1; Wed, 01 Mar 2023 02:50:32 -0500
X-MC-Unique: lR7wtis4PcmuxZfizwjwfg-1
Received: by mail-wm1-f72.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so4291289wmb.8
        for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 23:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677657031;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pu9sDDoiO2pNPRdKDPadUX6jIS5wT8Trs8o4kUO2no0=;
        b=Q2LtEeE7InDhgwqFBh67lIi5GUlejvdJ0gEs40WKbtWQo4q1D0CYVleAj3f+q6dk+d
         /HF51ofIjN1P+XGhvwVOJNEK6ALIutJiWO6KaUUbQKgRAl35q/kVYfIpIIDc0iL1XA/Y
         XOsG+PuhF0p2p4a6L+lCwevAYh2V3PLx+TJ8HV58WpCMJRHwlErtyeQTjYu1CrWmIWXW
         ksWTs7E35EUc+s/CvOLcZAZvbh7YB7Wk0fwdgXlH9OXu6A4p5NAre49+3wywSgoUVK2/
         wQKtIQKKBtFo71zvEGXr9dE+lmAwnxZxy+QHovwgjD8h3qCtcBMkGTWMUNRlM60Io4Z9
         7bbQ==
X-Gm-Message-State: AO0yUKUUxUDkMKgab8HJ5WZbu65K10fbDikbYihgaLFqewteUaO1SpK2
	/yxA7sSPWfEasd8zxWQsdgJfahsAWS6t15MT9eKRAYLOciBj6SQgClf6TnC+6D6VQqWdL8bhA36
	oFqxbP8FQ4tZIh9oqj5fr1kgBtkq/H0u2rDYVdJYAPsTOf+UM1XSJqQnjDV+J6xTxDYvagg==
X-Received: by 2002:a5d:4c84:0:b0:2c7:b5ef:9695 with SMTP id z4-20020a5d4c84000000b002c7b5ef9695mr3676206wrs.3.1677657031116;
        Tue, 28 Feb 2023 23:50:31 -0800 (PST)
X-Google-Smtp-Source: AK7set82cqu79AcgcbPk9uubDGyZVqjNFnRpFv92D/0tInPwRhQxcghDLg5vaQusL7Qp4Jd1KXbzPQ==
X-Received: by 2002:a5d:4c84:0:b0:2c7:b5ef:9695 with SMTP id z4-20020a5d4c84000000b002c7b5ef9695mr3676192wrs.3.1677657030750;
        Tue, 28 Feb 2023 23:50:30 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id d16-20020adff850000000b002c55306f6edsm11804663wrq.54.2023.02.28.23.50.29
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 23:50:30 -0800 (PST)
Message-ID: <b48676849c00ed0f700702717ddccc6204a4f489.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] Squash-to: mptcp: use the workqueue to
 destroy unaccepted sockets
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Wed, 01 Mar 2023 08:50:29 +0100
In-Reply-To: <ee3e0181ffd7e4d81ed43d27f18401da3d5927d6.1677600530.git.pabeni@redhat.com>
References: <ee3e0181ffd7e4d81ed43d27f18401da3d5927d6.1677600530.git.pabeni@redhat.com>
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
> The workqueue could trigger before inet_csk_listen_stop() kicks-in,
> or the closed socket could even land to accept(). Solve the race
> falling back to TCP - we already complete the MPTCP level close
> signaling.
>=20
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/366
>=20
> possibly worth manual handling
> ---
>  net/mptcp/protocol.c | 14 +++++++++++++-
>  net/mptcp/protocol.h |  2 ++
>  net/mptcp/subflow.c  |  6 +++---
>  3 files changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 08a912bb7215..467989c2b0ec 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2398,7 +2398,6 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>  =09=09goto out;
>  =09}
> =20
> -=09sock_orphan(ssk);
>  =09subflow->disposable =3D 1;
> =20
>  =09/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
> @@ -2406,7 +2405,20 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>  =09 * reference owned by msk;
>  =09 */
>  =09if (!inet_csk(ssk)->icsk_ulp_ops) {
> +=09=09WARN_ON_ONCE(!sock_flag(sk, SOCK_DEAD));

Dumb me! above should 'ssk' instead. Not sure why the issue did not
trigger in my local test.

I'll send an update version soon.

/P

