Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF35199C9
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JArmn981"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697011748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTK80oDD0Bv5gtOXZS+QKGF2fWjN9XveAlI4QWt8H7w=;
	b=JArmn981j8fCVfHj2jTpFypzc6SoszcqTKaBv+6slA/DEHKIF5hbN2PuasPHCiq2+KE5EV
	2XVa6A0cH/Mt13dWIIaq+lX58m5dlDngb/3TVrZllR8M5f1Zr3q2h0EDhBCmFKuzxdy5rB
	SPLXBGJWs5bbfEYBNNqNpgTL9SSIP8E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-SG1UzxeBN--MKVgyHclKQg-1; Wed, 11 Oct 2023 04:09:06 -0400
X-MC-Unique: SG1UzxeBN--MKVgyHclKQg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5386aefc01eso953098a12.1
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 01:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697011745; x=1697616545;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ky77DLJakT9unCG2ouOjuY2UmwPyrVoxGi1Bc0mbU6Y=;
        b=J3exnP8Dnnjm5rAuELnjQVf+E4ssGqVHnM6WegjMkQ+TIDY8E/UqGGF89jT4SKuDEb
         9ua2T3nx29PAfH4+o5oKZN/WcOxNqESWs76hc/IrTSBRmuYe6tlO7cNymdAdLG/lOwrH
         gAqga9RN+97Wb8KwK8K39TX9l9+rQ050yEKLI+ssCozVvNg8Z+1xn+ZJQMHho3YtnaZw
         1xp9dsZA6TgBrBdZTpTxGuu8ARlK+D3FWSeupP2hV0tZN9qpGLiBYZFg0+uEDCRw0Pn/
         bLEd6RiPLyA0q+CwtBdwsHXmy4nbb+IuigQduUFxOVo13bgU2TcBhzAu07t3xC0cKiGX
         y8nA==
X-Gm-Message-State: AOJu0YwvHs4Ovu8wXa0c5o5eqEmN0Gp6XK7tj3eYm0hJ1K2CLV/HKKM9
	WxVusLUSIpYULsqQdgHRKCfnMbff86EufAkr8WgIMGSV7wXumRIpsPZ/l37XPXxEaGipok6QG+k
	YNseaI5xj3WJvJ1m1uK0ltGE=
X-Received: by 2002:a05:6402:5191:b0:51e:5dd8:fc59 with SMTP id q17-20020a056402519100b0051e5dd8fc59mr17073831edd.1.1697011745043;
        Wed, 11 Oct 2023 01:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtCD8skJ1qwT6k72lQxXjzH0PB6NYyxOj4JA3xYKpe+EKFW2STryCS+JNRDkR+u+ZloJBmog==
X-Received: by 2002:a05:6402:5191:b0:51e:5dd8:fc59 with SMTP id q17-20020a056402519100b0051e5dd8fc59mr17073811edd.1.1697011744636;
        Wed, 11 Oct 2023 01:09:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-163.dyn.eolo.it. [146.241.235.163])
        by smtp.gmail.com with ESMTPSA id u1-20020a05640207c100b005311e934765sm8558245edy.27.2023.10.11.01.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:09:04 -0700 (PDT)
Message-ID: <5be14d802956c3c7128614dab2bd7165cd46988f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: avoid resetting when
 another subflow available"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 11 Oct 2023 10:09:02 +0200
In-Reply-To: <cfa0382eb429ef762c6c862c2cd7c6d4dc6d2441.1697006323.git.geliang.tang@suse.com>
References: <cfa0382eb429ef762c6c862c2cd7c6d4dc6d2441.1697006323.git.geliang.tang@suse.com>
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

On Wed, 2023-10-11 at 14:39 +0800, Geliang Tang wrote:
> Invoke mptcp_subflow_shutdown() as Paolo suggested.
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a94e1f519788..977bae817e62 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2396,11 +2396,17 @@ static void __mptcp_close_ssk(struct sock *sk, st=
ruct sock *ssk,
>  =09=09goto out_release;
>  =09}
> =20
> -=09dispose_it =3D msk->free_first || ssk !=3D msk->first ||
> -=09=09     !list_is_singular(&msk->conn_list);
> +=09dispose_it =3D msk->free_first || ssk !=3D msk->first;
>  =09if (dispose_it)
>  =09=09list_del(&subflow->node);
> =20
> +=09if (!dispose_it &&
> +=09    !list_empty(&msk->conn_list) &&
> +=09    !list_is_singular(&msk->conn_list)) {
> +=09=09mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);


I think there was a misunderstanding. I intended suggesting using
tcp_shutdown(). Note that mptcp_subflow_shutdown() for established msk
is intended to carry the MPTCP-level data fin, while here we want to
only to close the subflow.

I think it's better to let the mptcp_close_ssk() caller specify this
behavior via the 'flags' value. It looks like the already existing
flags are enough: we want this behavior if and only if '!(flags &
MPTCP_CF_FASTCLOSE)'.

All in all, something like the following (untested, based on the
current export branch) should do:
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 30e0c29ae0a4..2dabc118d78d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2366,6 +2366,26 @@ bool __mptcp_retransmit_pending_data(struct sock *sk=
)
 #define MPTCP_CF_PUSH=09=09BIT(1)
 #define MPTCP_CF_FASTCLOSE=09BIT(2)
=20
+/* be sure to send a reset only if the caller asked for it, also
+ * clean completely the subflow status when the subflow reaches
+ * TCP_CLOSE state
+ */
+static void __mptcp_subflow_disconnect(struct sock *ssk,=20
+=09=09=09=09       struct mptcp_subflow_context *subflow,
+=09=09=09=09       unsigned int flags)
+{
+=09if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
+=09    (flags & MPTCP_CF_FASTCLOSE)) {
+=09=09/* The MPTCP code never wait on the subflow sockets, TCP-level
+=09=09 * disconnect should never fail
+=09=09 */
+=09=09WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+=09=09mptcp_subflow_ctx_reset(subflow);
+=09} else {
+=09=09tcp_shutdown(ssk, SEND_SHUTDOWN);
+=09}
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2403,8 +2423,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
 sock *ssk,
 =09lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
=20
 =09if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-=09=09/* be sure to force the tcp_disconnect() path,
-=09=09 * to generate the egress reset
+=09=09/* be sure to force the tcp_close path to generate
+=09=09 * the egress reset
 =09=09 */
 =09=09ssk->sk_lingertime =3D 0;
 =09=09sock_set_flag(ssk, SOCK_LINGER);
@@ -2413,13 +2433,8 @@ static void __mptcp_close_ssk(struct sock *sk, struc=
t sock *ssk,
=20
 =09need_push =3D (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_dat=
a(sk);
 =09if (!dispose_it) {
-=09=09/* The MPTCP code never wait on the subflow sockets, TCP-level
-=09=09 * disconnect should never fail
-=09=09 */
-=09=09WARN_ON_ONCE(tcp_disconnect(ssk, 0));
-=09=09mptcp_subflow_ctx_reset(subflow);
+=09=09__mptcp_subflow_disconnect(ssk, subflow, flags);
 =09=09release_sock(ssk);
-
 =09=09goto out;
 =09}
=20

