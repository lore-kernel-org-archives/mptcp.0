Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4792100
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670337832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31gz8VlP5hmM3HlytL65fbv1NxYANtMAS5gDcklIaXo=;
	b=BA38r3r8KFyw3GPO1ldTVS6znR/5YF+14VdGiYrT4Q4vo6QzwNbRsYX4CBB/r8wZDZRKEn
	AwpIrVoApHPI7q6DwB73ru+vnJcwvOF0SjRgejNUyF5XQxsjLuZbZvtnokX0RJ01vSfTYU
	ATUdgrv8VYlEpZkR2b1tISvAQ7AFpco=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-PzACOX3DMvGLcjzQiLGqtg-1; Tue, 06 Dec 2022 09:43:51 -0500
X-MC-Unique: PzACOX3DMvGLcjzQiLGqtg-1
Received: by mail-pl1-f197.google.com with SMTP id h7-20020a170902f54700b00189deebdb91so4435964plf.9
        for <mptcp@lists.linux.dev>; Tue, 06 Dec 2022 06:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31gz8VlP5hmM3HlytL65fbv1NxYANtMAS5gDcklIaXo=;
        b=qjN/4ZFppVzQHYn8uplibI7pduJOpv+y/k8FdmTwP8wr0HzMukgpIVoIe3wm2iaTU8
         vejB59XlWBKIiHGlUHgV4nF9v/BKdh09fOgOlmUrrvE4ZmhZJ+PE51GuyQpEMLSMhIk0
         B6G36AeKR1VQaKux/FUniO7FEcnOlFQiedMrJG4Lo+f9sVrL+EHQIaYjOE6Vo4IKGCPK
         TVGT1C3YHYN8Q5ILaPFZsoXKNI2EmQ2oap4ZmEuX71GsbTuWDPXEpuTSgBnmdTF1zSNs
         7QlekJTTlZ1BVH44xglpsum7hZV2CLzRC5n9a7plV2itA4i2uQ9SCtwpw9DoOA86wusG
         x43w==
X-Gm-Message-State: ANoB5pk27lEK1KatrZ7zvzvzrcreemq8DKn81gtARgHgOENX1G5PwDvw
	dATim+yR3QzBTQTxW4g9hz3/xh2XWRwmQXKUjS5GhhK7HbJP4i885pTmvX5ca85B2lCa0Z4OdcH
	1usfETNVGgl3xJ/RMD9l8CmCiArPkbKU=
X-Received: by 2002:a63:d256:0:b0:478:46b4:4f91 with SMTP id t22-20020a63d256000000b0047846b44f91mr30902420pgi.211.1670337829863;
        Tue, 06 Dec 2022 06:43:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7HOJoY0VTa7e6D4mqXziXi14VAvKEN40mNj8IREQjjOgfHHjFbQPvgz592RFQsTb/2+j6E9KuycuNl+7it7AQ=
X-Received: by 2002:a63:d256:0:b0:478:46b4:4f91 with SMTP id
 t22-20020a63d256000000b0047846b44f91mr30902367pgi.211.1670337829452; Tue, 06
 Dec 2022 06:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com>
 <108a1c80eed41516f85ebb264d0f46f95e86f754.camel@redhat.com>
 <CAHC9VhSSKN5kh9Kqgj=aCeA92bX1mJm1v4_PnRgua86OHUwE3w@mail.gmail.com>
 <48dd1e9b21597c46e4767290e5892c01850a45ff.camel@redhat.com>
 <CAHC9VhT0rRhr7Ty_p3Ld5O+Ltf8a8XSXcyik7tFpDRMrTfsF+A@mail.gmail.com> <50e7ea22119c3afcb4be5a4b6ad9747465693d10.camel@redhat.com>
In-Reply-To: <50e7ea22119c3afcb4be5a4b6ad9747465693d10.camel@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 6 Dec 2022 15:43:38 +0100
Message-ID: <CAFqZXNtOku4vr5RrQU4vcvCVz5iK79CimeUVHu0S=QoN-QVEjg@mail.gmail.com>
Subject: Re: Broken SELinux/LSM labeling with MPTCP and accept(2)
To: Paolo Abeni <pabeni@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, mptcp@lists.linux.dev, 
	network dev <netdev@vger.kernel.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 5, 2022 at 9:58 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Fri, 2022-12-02 at 15:16 -0500, Paul Moore wrote:
[...]
> > What if we added a new LSM call in mptcp_subflow_create_socket(), just
> > after the sock_create_kern() call?
>
> That should work, I think. I would like to propose a (last) attempt
> that will not need an additional selinux hook - to try to minimize the
> required changes and avoid unnecessary addional work for current and
> future LSM mainteniance and creation.
>
> I tested the following patch and passes the reproducer (and mptcp self-
> tests). Basically it introduces and uses a sock_create_nosec variant,
> to allow mptcp_subflow_create_socket() calling
> security_socket_post_create() with the corrct arguments. WDYT?

This seems like a step in the right direction, but I wonder if we
shouldn't solve the current overloading of the "kern" flag more
explicitly - i.e. split it into two flags: one to indicate that the
socket will only be used internally by the kernel ("internal") and
another one to indicate if it should be labeled according to the
current task or as a kernel-created socket ("kern"?). Technically,
each combination could have a valid use case:
- !internal && !kern -> a regular userspace-created socket,
- !internal && kern -> a socket that is exposed to userspace, but
created by the kernel outside of a syscall (e.g. some global socket
created during initcall phase and later returned to userspace via an
ioctl or something),
- internal && !kern -> our MPTCP case, where the socket itself is
internal, but the label is still important so it can be passed onto
its accept-offspring (which may no longer be internal),
- internal && kern -> a completely kernel-internal socket.

Another concern I have about this approach is whether it is possible
(in some more advanced scenario) for mptcp_subflow_create_socket() to
be called in the context of a different task than the one
creating/handling the main socket. Because then a potential socket
accepted from the new subflow socket would end up with an unexpected
(and probably semantically wrong) label. Glancing over the call tree,
it seems it can be called via some netlink commands - presumably
intended to be used by mptcpd?


>
> ---
>  include/linux/net.h |  2 ++
>  net/mptcp/subflow.c | 18 ++++++++++++--
>  net/socket.c        | 60 ++++++++++++++++++++++++++++++---------------
>  3 files changed, 58 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/net.h b/include/linux/net.h
> index b73ad8e3c212..91713012504d 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -251,6 +251,8 @@ int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
>  int sock_register(const struct net_proto_family *fam);
>  void sock_unregister(int family);
>  bool sock_is_registered(int family);
> +int __sock_create_nosec(struct net *net, int family, int type, int proto,
> +                       struct socket **res, int kern);
>  int __sock_create(struct net *net, int family, int type, int proto,
>                   struct socket **res, int kern);
>  int sock_create(int family, int type, int proto, struct socket **res);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 29904303f5c2..9341f9313154 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1646,11 +1646,25 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
>         if (unlikely(!sk->sk_socket))
>                 return -EINVAL;
>
> -       err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
> -                              &sf);
> +       /* the subflow is created by the kernel, and we need kernel annotation
> +        * for lockdep's sake...
> +        */
> +       err = __sock_create_nosec(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
> +                                 &sf, 1);
>         if (err)
>                 return err;
>
> +       /* ... but the first subflow will be indirectly exposed to the
> +        * user-space via accept(). Let's attach the current user security
> +        * label
> +        */
> +       err = security_socket_post_create(sf, sk->sk_family, SOCK_STREAM,
> +                                         IPPROTO_TCP, 0);
> +       if (err) {
> +               sock_release(sf);
> +               return err;
> +       }
> +
>         lock_sock(sf->sk);
>
>         /* the newly created socket has to be in the same cgroup as its parent */
> diff --git a/net/socket.c b/net/socket.c
> index 55c5d536e5f6..d5d51e4e26ae 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1426,23 +1426,11 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
>  }
>  EXPORT_SYMBOL(sock_wake_async);
>
> -/**
> - *     __sock_create - creates a socket
> - *     @net: net namespace
> - *     @family: protocol family (AF_INET, ...)
> - *     @type: communication type (SOCK_STREAM, ...)
> - *     @protocol: protocol (0, ...)
> - *     @res: new socket
> - *     @kern: boolean for kernel space sockets
> - *
> - *     Creates a new socket and assigns it to @res, passing through LSM.
> - *     Returns 0 or an error. On failure @res is set to %NULL. @kern must
> - *     be set to true if the socket resides in kernel space.
> - *     This function internally uses GFP_KERNEL.
> - */
>
> -int __sock_create(struct net *net, int family, int type, int protocol,
> -                        struct socket **res, int kern)
> +
> +/* Creates a socket leaving LSM post-creation checks to the caller */
> +int __sock_create_nosec(struct net *net, int family, int type, int protocol,
> +                       struct socket **res, int kern)
>  {
>         int err;
>         struct socket *sock;
> @@ -1528,11 +1516,8 @@ int __sock_create(struct net *net, int family, int type, int protocol,
>          * module can have its refcnt decremented
>          */
>         module_put(pf->owner);
> -       err = security_socket_post_create(sock, family, type, protocol, kern);
> -       if (err)
> -               goto out_sock_release;
> -       *res = sock;
>
> +       *res = sock;
>         return 0;
>
>  out_module_busy:
> @@ -1548,6 +1533,41 @@ int __sock_create(struct net *net, int family, int type, int protocol,
>         rcu_read_unlock();
>         goto out_sock_release;
>  }
> +
> +/**
> + *     __sock_create - creates a socket
> + *     @net: net namespace
> + *     @family: protocol family (AF_INET, ...)
> + *     @type: communication type (SOCK_STREAM, ...)
> + *     @protocol: protocol (0, ...)
> + *     @res: new socket
> + *     @kern: boolean for kernel space sockets
> + *
> + *     Creates a new socket and assigns it to @res, passing through LSM.
> + *     Returns 0 or an error. On failure @res is set to %NULL. @kern must
> + *     be set to true if the socket resides in kernel space.
> + *     This function internally uses GFP_KERNEL.
> + */
> +
> +int __sock_create(struct net *net, int family, int type, int protocol,
> +                 struct socket **res, int kern)
> +{
> +       struct socket *sock;
> +       int err;
> +
> +       err = __sock_create_nosec(net, family, type, protocol, &sock, kern);
> +       if (err)
> +               return err;
> +
> +       err = security_socket_post_create(sock, family, type, protocol, kern);
> +       if (err) {
> +               sock_release(sock);
> +               return err;
> +       }
> +
> +       *res = sock;
> +       return 0;
> +}
>  EXPORT_SYMBOL(__sock_create);
>
>  /**
>

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

