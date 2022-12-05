Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5E7C
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 20:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670273926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZxLt4/GF+wys/GuWAIbGAH9lD65j6IwW6mM3UiAHcI=;
	b=FXahjqqUDYIOQTSZy3Vn0KPSbKl1ZJ3g4PJUDP8Sp0F8yFYmVgNnWrw73uGK+WOFNb8WiX
	lHS3itC96jwzVP7KnGwjFFrsVWqI59/fHOo7e1+h0qSbU8DjFu6RNgnWXd7Tj4LBYsLq3D
	xCBuTC7bR0BFYwDXscY10CqMBSNxk5U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-lKDRn3GLM3CABPxEkWKYtQ-1; Mon, 05 Dec 2022 15:58:46 -0500
X-MC-Unique: lKDRn3GLM3CABPxEkWKYtQ-1
Received: by mail-qt1-f198.google.com with SMTP id g3-20020ac84b63000000b003a529c62a92so34127708qts.23
        for <mptcp@lists.linux.dev>; Mon, 05 Dec 2022 12:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZxLt4/GF+wys/GuWAIbGAH9lD65j6IwW6mM3UiAHcI=;
        b=erInEDpBBCPCoG5e37pI4hl+LggZp4/CB/w5dpe3SfQZYgKmNIqX+EQcejUup0fMAQ
         XGtLl6IuKLjQLBykqzPVma8qKuobZJO/8asDz0umhqYhyRd1M3XsMq0K2x8Lg/dMCY2k
         Cu0ceqHoarfT9bxikKI1LrYI1zABdrX6HmUSHLpF3eATdUE4W9BTagPaNa0YxfWMV49Y
         PTwGoDK40fbmPt5qbXgAsdWI+fQnsrX4RwpboxtNctqlW5EED/IrnKqhYdAaIvpVnv58
         Gf/IHVrQW+cr2mOIPXbljCzgDRzP6wFLC6hyauDq4qD1M7ZFgIMwH7nAgz8IgEiGuwlv
         X74Q==
X-Gm-Message-State: ANoB5plCkLsiHjHRKbhVO0v9rEv006HXYKvHvG6x3I2RCRc05eOw+oAZ
	ssxiaL/46NbGSEasxfqqnoYUPDxqW4JT5fJhUZXEYVmS/70yFjDx5Qvr/oJjBKyqUfImPZHhFLP
	/bVk8KEzoJkJzsiU=
X-Received: by 2002:a0c:fa51:0:b0:4c7:2a8f:7e70 with SMTP id k17-20020a0cfa51000000b004c72a8f7e70mr19336171qvo.28.1670273925381;
        Mon, 05 Dec 2022 12:58:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7AaySR5zBpy3s6Xs7h2gonCvwpPKR8N9evdPLgjXaTKZj2xt6CHalnwdxAsXlJh8ORvqRACA==
X-Received: by 2002:a0c:fa51:0:b0:4c7:2a8f:7e70 with SMTP id k17-20020a0cfa51000000b004c72a8f7e70mr19336149qvo.28.1670273925063;
        Mon, 05 Dec 2022 12:58:45 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it. [146.241.106.100])
        by smtp.gmail.com with ESMTPSA id c19-20020ac81113000000b003a57eb7f212sm10212375qtj.10.2022.12.05.12.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:58:44 -0800 (PST)
Message-ID: <50e7ea22119c3afcb4be5a4b6ad9747465693d10.camel@redhat.com>
Subject: Re: Broken SELinux/LSM labeling with MPTCP and accept(2)
From: Paolo Abeni <pabeni@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list
 <selinux@vger.kernel.org>, Linux Security Module list
 <linux-security-module@vger.kernel.org>, mptcp@lists.linux.dev, network dev
 <netdev@vger.kernel.org>, Mat Martineau
 <mathew.j.martineau@linux.intel.com>,  Matthieu Baerts
 <matthieu.baerts@tessares.net>
Date: Mon, 05 Dec 2022 21:58:41 +0100
In-Reply-To: <CAHC9VhT0rRhr7Ty_p3Ld5O+Ltf8a8XSXcyik7tFpDRMrTfsF+A@mail.gmail.com>
References: <CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com>
	 <108a1c80eed41516f85ebb264d0f46f95e86f754.camel@redhat.com>
	 <CAHC9VhSSKN5kh9Kqgj=aCeA92bX1mJm1v4_PnRgua86OHUwE3w@mail.gmail.com>
	 <48dd1e9b21597c46e4767290e5892c01850a45ff.camel@redhat.com>
	 <CAHC9VhT0rRhr7Ty_p3Ld5O+Ltf8a8XSXcyik7tFpDRMrTfsF+A@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit

On Fri, 2022-12-02 at 15:16 -0500, Paul Moore wrote:
> On Fri, Dec 2, 2022 at 7:07 AM Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > Side note: I'm confused by the selinux_sock_graft() implementation:
> > 
> > https://elixir.bootlin.com/linux/v6.1-rc7/source/security/selinux/hooks.c#L5243
> > 
> > it looks like the 'sid' is copied from the 'child' socket into the
> > 'parent', while the sclass from the 'parent' into the 'child'. Am I
> > misreading it? is that intended? I would have expeted both 'sid' and
> > 'sclass' being copied from the parent into the child. Other LSM's
> > sock_graft() initilize the child and leave alone the parent.
> 
> MPTCP isn't the only thing that is ... complex ;)
> 
> Believe it or not, selinux_sock_graft() is correct.  The reasoning is
> that the new connection sock has been labeled based on the incoming
> connection, which can be influenced by a variety of sources including
> the security attributes of the remote endpoint; however, the
> associated child socket is always labeled based on the security
> context of the task calling accept(2).  Transfering the sock's label
> (sid) to the child socket during the accept(2) operation ensures that
> the newly created socket is labeled based on the inbound connection
> labeling rules, and not simply the security context of the calling
> process.
> 
> Transferring the object class (sclass) from the socket/inode to the
> newly grafted sock just ensures that the sock's object class is set
> correctly.

Thank you for the explaination. Hopefully I'm less confused now;)

> > ---
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 99f5e51d5ca4..b8095b8df71d 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3085,7 +3085,10 @@ struct sock *mptcp_sk_clone(const struct
> > sock *sk,
> >         /* will be fully established after successful MPC subflow
> > creation */
> >         inet_sk_state_store(nsk, TCP_SYN_RECV);
> > 
> > - security_inet_csk_clone(nsk, req);
> > + /* let's the new socket inherit the security label from the msk
> > + * listener, as the TCP reqest socket carries a kernel context
> > + */
> > + security_sock_graft(nsk, sk->sk_socket);
> >         bh_unlock_sock(nsk);
> 
> As a quick aside, I'm working under the assumption that a MPTCP
> request_sock goes through the same sort of logic/processing as TCP, 

The above assumption is correct.

> if that is wrong we likely have additional issues.
> 
> I think one potential problem with the code above is that if the
> subflow socket, @sk above, has multiple inbound connections (is that
> legal with MPTCP?) 

Here there are few things that need some clarifications. In the above
chunk of code, 'sk' is the main mptcp socket, not a subflow. Insite the
mptcp code, subflow sockets variable name is usually 'ssk' (== subflow
sk).

An mptcp socket allows multiple inbound connections (each of them is a
subflow).

> it is going to be relabeled multiple times which is
> not good (label's shouldn't change once set, unless there is an
> explicit relabel event).  

I now see that even my 2nd proposal is wrong, thanks for pointing that
out!

> I think we need to focus on ensuring that
> the subflow socket is labeled properly at creation time, and that has
> me looking more at mptcp_subflow_create_socket() ...

Agreed.

> What if we added a new LSM call in mptcp_subflow_create_socket(), just
> after the sock_create_kern() call?  

That should work, I think. I would like to propose a (last) attempt
that will not need an additional selinux hook - to try to minimize the
required changes and avoid unnecessary addional work for current and
future LSM mainteniance and creation.

I tested the following patch and passes the reproducer (and mptcp self-
tests). Basically it introduces and uses a sock_create_nosec variant,
to allow mptcp_subflow_create_socket() calling
security_socket_post_create() with the corrct arguments. WDYT?

---
 include/linux/net.h |  2 ++
 net/mptcp/subflow.c | 18 ++++++++++++--
 net/socket.c        | 60 ++++++++++++++++++++++++++++++---------------
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index b73ad8e3c212..91713012504d 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -251,6 +251,8 @@ int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
 int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
 bool sock_is_registered(int family);
+int __sock_create_nosec(struct net *net, int family, int type, int proto,
+			struct socket **res, int kern);
 int __sock_create(struct net *net, int family, int type, int proto,
 		  struct socket **res, int kern);
 int sock_create(int family, int type, int proto, struct socket **res);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 29904303f5c2..9341f9313154 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1646,11 +1646,25 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
-			       &sf);
+	/* the subflow is created by the kernel, and we need kernel annotation
+	 * for lockdep's sake...
+	 */
+	err = __sock_create_nosec(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
+				  &sf, 1);
 	if (err)
 		return err;
 
+	/* ... but the first subflow will be indirectly exposed to the
+	 * user-space via accept(). Let's attach the current user security
+	 * label
+	 */
+	err = security_socket_post_create(sf, sk->sk_family, SOCK_STREAM,
+					  IPPROTO_TCP, 0);
+	if (err) {
+		sock_release(sf);
+		return err;
+	}
+
 	lock_sock(sf->sk);
 
 	/* the newly created socket has to be in the same cgroup as its parent */
diff --git a/net/socket.c b/net/socket.c
index 55c5d536e5f6..d5d51e4e26ae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1426,23 +1426,11 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
 }
 EXPORT_SYMBOL(sock_wake_async);
 
-/**
- *	__sock_create - creates a socket
- *	@net: net namespace
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
- *	@kern: boolean for kernel space sockets
- *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
- *	be set to true if the socket resides in kernel space.
- *	This function internally uses GFP_KERNEL.
- */
 
-int __sock_create(struct net *net, int family, int type, int protocol,
-			 struct socket **res, int kern)
+
+/* Creates a socket leaving LSM post-creation checks to the caller */
+int __sock_create_nosec(struct net *net, int family, int type, int protocol,
+			struct socket **res, int kern)
 {
 	int err;
 	struct socket *sock;
@@ -1528,11 +1516,8 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	 * module can have its refcnt decremented
 	 */
 	module_put(pf->owner);
-	err = security_socket_post_create(sock, family, type, protocol, kern);
-	if (err)
-		goto out_sock_release;
-	*res = sock;
 
+	*res = sock;
 	return 0;
 
 out_module_busy:
@@ -1548,6 +1533,41 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	rcu_read_unlock();
 	goto out_sock_release;
 }
+
+/**
+ *	__sock_create - creates a socket
+ *	@net: net namespace
+ *	@family: protocol family (AF_INET, ...)
+ *	@type: communication type (SOCK_STREAM, ...)
+ *	@protocol: protocol (0, ...)
+ *	@res: new socket
+ *	@kern: boolean for kernel space sockets
+ *
+ *	Creates a new socket and assigns it to @res, passing through LSM.
+ *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
+ *	be set to true if the socket resides in kernel space.
+ *	This function internally uses GFP_KERNEL.
+ */
+
+int __sock_create(struct net *net, int family, int type, int protocol,
+		  struct socket **res, int kern)
+{
+	struct socket *sock;
+	int err;
+
+	err = __sock_create_nosec(net, family, type, protocol, &sock, kern);
+	if (err)
+		return err;
+
+	err = security_socket_post_create(sock, family, type, protocol, kern);
+	if (err) {
+		sock_release(sock);
+		return err;
+	}
+
+	*res = sock;
+	return 0;
+}
 EXPORT_SYMBOL(__sock_create);
 
 /**

