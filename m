Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1A7480
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 20:16:25 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id jl24so5606046plb.8
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPJD0sgtEYoPAaGZw8YAHzHcUatreyrgUWldBEzj/Y4=;
        b=a13XHiJg8zjQXrzXRtOsM7afHxgmDa9rPv1jh4x/40F8rgUeu2zzhY8BkOZp/X/aLs
         YWGsn119XQYu7RPalEl6Shhin603eVtqCaN20IXHAfVXT5KEcmyhMoTSmUox1ApbOzb2
         p0aOAxomUf+lTdxSOn7a9Y0Jeoux/5uND4ghKFRTxzlkKspovFQ36n0DSvetD+7k6Bf8
         vqU6MQfi/7jzI9513dUwMUosyeMuSmtnToiSDcGJpxbHHr4QIETxuCQKp0Ec+g2Mw1L1
         tVbih/GsRN37Bd7eO2Z+INyypdr9OU535d11QA1kZkhJrDkplU6yhzTxv1C+IexyFh05
         2ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPJD0sgtEYoPAaGZw8YAHzHcUatreyrgUWldBEzj/Y4=;
        b=6GpaT371s+dauVDbniWHqoDxZCP2Y/QTyuickGZS04u2ev4uxq47R7uVZwuyXXUBLl
         5I6oAuwNMFjJ2EIIoC3hGbt7YYaS7vDU4j2RYkCa4gHa6dCBpo+HRKWLT1EunEyVXeFn
         c6yCwyxIswPYYc7XhdNvGEWV8+Zz5JycZmC3ncj09yslKRTV7VS/i59PwvkU2rGoR88t
         6AxXC0hxfL2WdT+PaKe4zlInZH7ObxcorTh8Bst/JLx5FsoWNPtqaiJdH9RA4VjIFTTJ
         lyVqhCzsalrBlUrfgsFpYeUmMdNNcfPloewIk+2TdxuQVl96R3lvvEb/r7NeZ3P4Dllg
         jZEw==
X-Gm-Message-State: ANoB5pnUi8L+j+VgRzjXCDLkAkMWqd+/tmPzpqHPeIHmaGnb7KoaZrZ1
	xeEvIhAAiGurany+Ef+gi+0iXMVcwoUYmwtaaNl5
X-Google-Smtp-Source: AA0mqf6bJ56BRnGwCC7Uw5nPs72fy+2T61J/mGH0Oe2db1nEfwJuCiBMjm9O+zfbH6nkSNlkkRImvfRozfMnBelVUWo=
X-Received: by 2002:a17:903:28f:b0:189:8a36:1b70 with SMTP id
 j15-20020a170903028f00b001898a361b70mr28304689plr.12.1670012185016; Fri, 02
 Dec 2022 12:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com>
 <108a1c80eed41516f85ebb264d0f46f95e86f754.camel@redhat.com>
 <CAHC9VhSSKN5kh9Kqgj=aCeA92bX1mJm1v4_PnRgua86OHUwE3w@mail.gmail.com> <48dd1e9b21597c46e4767290e5892c01850a45ff.camel@redhat.com>
In-Reply-To: <48dd1e9b21597c46e4767290e5892c01850a45ff.camel@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Dec 2022 15:16:13 -0500
Message-ID: <CAHC9VhT0rRhr7Ty_p3Ld5O+Ltf8a8XSXcyik7tFpDRMrTfsF+A@mail.gmail.com>
Subject: Re: Broken SELinux/LSM labeling with MPTCP and accept(2)
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, mptcp@lists.linux.dev, 
	network dev <netdev@vger.kernel.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 2, 2022 at 7:07 AM Paolo Abeni <pabeni@redhat.com> wrote:
> On Thu, 2022-12-01 at 21:06 -0500, Paul Moore wrote:

...

> > However, I think this simplest solution might be what I mentioned
> > above as #2a, simply labeling the subflow socket properly from the
> > beginning.  In the case of SELinux I think we could do that by simply
> > clearing the @kern flag in the case of IPPROTO_MPTCP; completely
> > untested (and likely whitespace mangled) hack shown below:
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index f553c370397e..de6aa80b2319 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4562,6 +4562,7 @@ static int selinux_socket_create(int family, int type,
> >        u16 secclass;
> >        int rc;
> >
> > +       kern = (protocol == IPPROTO_MPTCP ? 0 : kern);
> >        if (kern)
> >                return 0;
> >
> > @@ -4584,6 +4585,7 @@ static int selinux_socket_post_create(struct
> > socket *sock, int family,
> >        u32 sid = SECINITSID_KERNEL;
> >        int err = 0;
> >
> > +       kern = (protocol == IPPROTO_MPTCP ? 0 : kern);
> >        if (!kern) {
> >                err = socket_sockcreate_sid(tsec, sclass, &sid);
> >                if (err)
> >
> > ... of course the downside is that this is not a general cross-LSM
> > solution, but those are very hard, if not impossible, to create as the
> > individual LSMs can vary tremendously.  There is also the downside of
> > having to have a protocol specific hack in the LSM socket creation
> > hooks, which is a bit of a bummer, but then again we already have to
> > do so much worse elsewhere in the LSM networking hooks that this is
> > far from the worst thing we've had to do.
>
> There is a problem with the above: the relevant/affected socket is an
> MPTCP subflow, which is actually a TCP socket (protocol ==
> IPPROTO_TCP). Yep, MPTCP is quite a mes... complex.
>
> I think we can't follow this later path.

Bummer.  I was afraid I was missing something, that was too easy of a "fix" ;)

As I continue to look at the MPTCP code, I'm also now growing a little
concerned that we may have another issue regarding the number of
subflows attached to a sock; more on this below.

> Side note: I'm confused by the selinux_sock_graft() implementation:
>
> https://elixir.bootlin.com/linux/v6.1-rc7/source/security/selinux/hooks.c#L5243
>
> it looks like the 'sid' is copied from the 'child' socket into the
> 'parent', while the sclass from the 'parent' into the 'child'. Am I
> misreading it? is that intended? I would have expeted both 'sid' and
> 'sclass' being copied from the parent into the child. Other LSM's
> sock_graft() initilize the child and leave alone the parent.

MPTCP isn't the only thing that is ... complex ;)

Believe it or not, selinux_sock_graft() is correct.  The reasoning is
that the new connection sock has been labeled based on the incoming
connection, which can be influenced by a variety of sources including
the security attributes of the remote endpoint; however, the
associated child socket is always labeled based on the security
context of the task calling accept(2).  Transfering the sock's label
(sid) to the child socket during the accept(2) operation ensures that
the newly created socket is labeled based on the inbound connection
labeling rules, and not simply the security context of the calling
process.

Transferring the object class (sclass) from the socket/inode to the
newly grafted sock just ensures that the sock's object class is set
correctly.

> ---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 99f5e51d5ca4..b8095b8df71d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3085,7 +3085,10 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>         /* will be fully established after successful MPC subflow creation */
>         inet_sk_state_store(nsk, TCP_SYN_RECV);
>
> -       security_inet_csk_clone(nsk, req);
> +       /* let's the new socket inherit the security label from the msk
> +        * listener, as the TCP reqest socket carries a kernel context
> +        */
> +       security_sock_graft(nsk, sk->sk_socket);
>         bh_unlock_sock(nsk);

As a quick aside, I'm working under the assumption that a MPTCP
request_sock goes through the same sort of logic/processing as TCP, if
that is wrong we likely have additional issues.

I think one potential problem with the code above is that if the
subflow socket, @sk above, has multiple inbound connections (is that
legal with MPTCP?) it is going to be relabeled multiple times which is
not good (label's shouldn't change once set, unless there is an
explicit relabel event).  I think we need to focus on ensuring that
the subflow socket is labeled properly at creation time, and that has
me looking more at mptcp_subflow_create_socket() ...

What if we added a new LSM call in mptcp_subflow_create_socket(), just
after the sock_create_kern() call?  Inside
mptcp_subflow_create_socket() we have a pointer to the top level MPTCP
sock that we should serve as the source of the subflow's label, so for
SELinux it's just a matter of copying the label information and doing
basically the same setup we do in selinux_socket_post_create().  The
only wrinkle that I can see is that this new LSM/SELinux hook would be
called *after* security_socket_post_create() so we would need to add a
special comment about that and write the code accordingly.  That said,
it *shouldn't* be an issue for the SELinux code right now, but if this
approach looks reasonable to you we should probably double check that
(the NetLabel/CIPSO and NetLabel/CALIPSO code would be my main concern
here).

-- 
paul-moore.com
