Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483081D63D1
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389758; cv=none; b=TAqaha+4ieGZ6sPFhHGHGqJqXspaBjqUifhDfmg476piCLjER+ABi0CIKSdEbFL0TAA3UHJUt/u56aGM7fKuoFyZ75RlyJLbHLy8qCRh/IK/3V0cveg2JRqDamyyhyE1avynHKc6mq1oAHenvq5i/nHMvkyELpDwHMLuXVtzQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389758; c=relaxed/simple;
	bh=anqdnB9mHbedhqScyCGcOin7eoauZ/JLfVpOp+j1N8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSdTjk5sZkciDWxf1qM7b+KD7ygI7noseMevimhxBONTaxfc0q/pkLhlnkWKenQOrLf7SEEg0FHqpdDHloXuq07b1xl2E2p+UJMMrNfMTiY7yT/mszwzaNuQMG4PNs8QjBL6dyMgnSbUh9SB4tndarkbYLz6JzwhcZp/Lo1lSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d30Lacvl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d30Lacvl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so8700266b.1
        for <mptcp@lists.linux.dev>; Thu, 05 Dec 2024 01:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733389753; x=1733994553; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0VGc4uwsC1VuTO6ILJ7ETPZ+0S9klvWlGFpH9QnNmk=;
        b=d30LacvloyaKA4iLqZ4YWt6C5UBa440Y2jMKfGoiUKiBbSECDfuA1CeetEpO0ksr6J
         0bUlRi4c8nejIUPPRmHic79iWKzdsR5oE9UySuJD4bRZcQoRS/G+57QmQKKUoFzt/Ut8
         1EyWEN042V9z9Z2yKmTgHp9p71Q+tY2K2Y1+3kXlj0tenPclynyV7BASGI+NL9pbqkju
         +WzJ4StOKAmHYuHcn6U2TVu2R342YcvdkIB6L+ELDB7EbRTpZW7mPAyaTpT/zmEbc4HB
         ukEAvwR8rJdlwRUJ844S56XzobNtBqZJH/wNSNBT9iQQ6N3/fv84EdUXOik9Kqx/DwTB
         Sw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389753; x=1733994553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0VGc4uwsC1VuTO6ILJ7ETPZ+0S9klvWlGFpH9QnNmk=;
        b=IRMiOmnCoiMltomnKevAGojXXe0I5O/F7UnmQ9bdHgbtG8q1Zfneb8ewFHgyeZ7a2o
         CiFqzNVbGJb9e0+m0MlcTMPG0m/FFv/Bfq2ekR4h2xFhPD0l9S33YrU5ODL4hHulmIi/
         ltUYu1n0c3qgD/Yp2afRt1VWzRfbt9B6dMNjvCw0jF3B7wdyPDBwGtYfVpkZJ+JEWLqX
         siUmKjdDC9MaUtNXiaRuTdPQAhzQ4ZxK8qbckrQFSqWbBicOYuR0kjJHs4ICOjn+kV7d
         kcSJagGwHXR0mpS9LIaKqEGQ3xkDxZxg1IhoVZT9lA6sesSKvLlp6tRDkvfF6pFjhHLg
         uMZg==
X-Forwarded-Encrypted: i=1; AJvYcCVdmsXjtQqTb5YIzTr6GI/z5Ve76snNrXrFuLkUjAxdx+MAikQbzYg0zs9gtrpGP7VvxTS77Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YweZ9Cim2RejQ/T90DujUrobD6iIkDby9qTTTHSonNjXdQKKEAj
	yWf6v9K5qSu3h6bRA0i/u+14CW+oVshBEINGVoChfEhWhJYx2nLPvjVSDH+flYee9l4F9icLUcm
	G6Ou0i64onaX/Z2YiT+JWcX2mu1PWvr/cia3d
X-Gm-Gg: ASbGncv5QudICd8df3K4rzuYFkYOuKC75h3+vxxWp8bP4SuhFyZzlTeOfaMZSYQMEdt
	wlae4ninwi4CmcUufnxztP2HhnCCHUxk=
X-Google-Smtp-Source: AGHT+IHfa2rJ8uRXz5tARRzFCZ8XNG3orLjGFc+t9wtCUBW/tuWv2l59CAUEsv8gFxsd6TBk8iqXO3L8PkMnL6mBbmc=
X-Received: by 2002:a17:906:3d22:b0:aa5:f39a:bc99 with SMTP id
 a640c23a62f3a-aa5f7da1595mr775307466b.36.1733389753351; Thu, 05 Dec 2024
 01:09:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com> <20241204171351.52b8bb36@kernel.org>
In-Reply-To: <20241204171351.52b8bb36@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Dec 2024 10:09:02 +0100
Message-ID: <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 0x7f454c46@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 13 Nov 2024 18:46:39 +0000 Dmitry Safonov via B4 Relay wrote:
> > 2. Inet-diag allocates netlink message for sockets in
> >    inet_diag_dump_one_icsk(), which uses a TCP-diag callback
> >    .idiag_get_aux_size(), that pre-calculates the needed space for
> >    TCP-diag related information. But as neither socket lock nor
> >    rcu_readlock() are held between allocation and the actual TCP
> >    info filling, the TCP-related space requirement may change before
> >    reaching tcp_diag_put_md5sig(). I.e., the number of TCP-MD5 keys on
> >    a socket. Thankfully, TCP-MD5-diag won't overwrite the skb, but will
> >    return EMSGSIZE, triggering WARN_ON() in inet_diag_dump_one_icsk().
>
> Hi Eric!
>
> This was posted while you were away -- any thoughts or recommendation on
> how to address the required nl message size changing? Or other problems
> pointed out by Dmitry? My suggestion in the subthread is to re-dump
> with a fixed, large buffer on EMSGSIZE, but that's not super clean..

Hi Jakub

inet_diag_dump_one_icsk() could retry, doubling the size until the
~32768 byte limit is reached ?

Also, we could make sure inet_sk_attr_size() returns at least
NLMSG_DEFAULT_SIZE, there is no
point trying to save memory for a single skb in inet_diag_dump_one_icsk().


diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 321acc8abf17e8c7d6a4e3326615123fff19deab..cd2e7fe9b090ea9127aebbba0fa=
f2ef12c0f86a4
100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -102,7 +102,7 @@ static size_t inet_sk_attr_size(struct sock *sk,
                                bool net_admin)
 {
        const struct inet_diag_handler *handler;
-       size_t aux =3D 0;
+       size_t aux =3D 0, res;

        rcu_read_lock();
        handler =3D rcu_dereference(inet_diag_table[req->sdiag_protocol]);
@@ -111,7 +111,7 @@ static size_t inet_sk_attr_size(struct sock *sk,
                aux =3D handler->idiag_get_aux_size(sk, net_admin);
        rcu_read_unlock();

-       return    nla_total_size(sizeof(struct tcp_info))
+       res =3D nla_total_size(sizeof(struct tcp_info))
                + nla_total_size(sizeof(struct inet_diag_msg))
                + inet_diag_msg_attrs_size()
                + nla_total_size(sizeof(struct inet_diag_meminfo))
@@ -120,6 +120,7 @@ static size_t inet_sk_attr_size(struct sock *sk,
                + nla_total_size(sizeof(struct tcpvegas_info))
                + aux
                + 64;
+       return max(res, NLMSG_DEFAULT_SIZE);
 }

 int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
@@ -570,6 +571,7 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *hashi=
nfo,
        bool net_admin =3D netlink_net_capable(in_skb, CAP_NET_ADMIN);
        struct net *net =3D sock_net(in_skb->sk);
        struct sk_buff *rep;
+       size_t attr_size;
        struct sock *sk;
        int err;

@@ -577,7 +579,9 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *hashi=
nfo,
        if (IS_ERR(sk))
                return PTR_ERR(sk);

-       rep =3D nlmsg_new(inet_sk_attr_size(sk, req, net_admin), GFP_KERNEL=
);
+       attr_size =3D inet_sk_attr_size(sk, req, net_admin);
+retry:
+       rep =3D nlmsg_new(attr_size, GFP_KERNEL);
        if (!rep) {
                err =3D -ENOMEM;
                goto out;
@@ -585,8 +589,14 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *hash=
info,

        err =3D sk_diag_fill(sk, rep, cb, req, 0, net_admin);
        if (err < 0) {
-               WARN_ON(err =3D=3D -EMSGSIZE);
                nlmsg_free(rep);
+               if (err =3D=3D -EMSGSIZE) {
+                       attr_size <<=3D 1;
+                       if (attr_size + NLMSG_HDRLEN <=3D
SKB_WITH_OVERHEAD(32768)) {
+                               cond_resched();
+                               goto retry;
+                       }
+               }
                goto out;
        }
        err =3D nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).porti=
d);
