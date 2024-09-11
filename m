Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B5282F7
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025653; cv=none; b=r/ZsXYlbz4F5rgwjFMf3Qz4ox5gl+SIS3c/WSJ6/hKQZdEafM6TlghhRNbjzJqn3s1VQvHpZmjMOCHVXEXyF8QnKD1Z9OeVGzXGmvNUlQT/FVDHkUEUTsRzlnL0joQzS5i1n1VG7ycuylZKySWIBlFSEbW8spDIqH30ZDllbZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025653; c=relaxed/simple;
	bh=HHeYKyQ6fspnFYEPiocFqOqD2LHxRVcf60fOmRJcJSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnIX6C7eKqK4txqz/1Cr6qqcTK5L9Y+u1xES5SP1qHhkQmV4On/O3380pzO/qHrsVyFg5G2a4CbNIL7OSCOwXUYTwfv3Gp22oSXCQTEqIg0viiYoD3lPxCj8jc9gL7piV6z919MMiy2CKQaUOphIsgPxdGQPGNGcKyg+Fuaunjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQVAk+L7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQVAk+L7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7178df70f28so1146940b3a.2
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726025651; x=1726630451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUVoHKGlPio5WpGlEQsdtYcRALopvDTSYpm/OJHaHec=;
        b=jQVAk+L7wRme+49YLmRUgtYnQHvomlLryIF+VCUUZOv3g8CnOdBj8ysBu6AfcApFPL
         UYFrJImXs2tMOg22nz+Cw3Pk1fw9jtHGoDjCtnH1985gTfbjzIiaxzDRpeg5JK7KD2HS
         qj/8iUYMJBxWjtPTktag1iwdoW70WsZjZccAt5iEAQ/L1AyFb8H7Keyj9HNqYZFpUjcJ
         gpcPaMU7EPqeHLLMBkU0AKD8a3OAb+2xPiWCXVRtGNAEDFci1773Z7MEhVr6fIyKR8NT
         XNYaVXUcfFfWWwbq34g2bD6HFKnp50koVfqaIjq8ILuE3fSv3vUkM7eBIy71QL2YyjFY
         smrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726025651; x=1726630451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUVoHKGlPio5WpGlEQsdtYcRALopvDTSYpm/OJHaHec=;
        b=mIhShImd5tW96ltp1lbnXRnvb7a4XqWYSOLfOXZHiQHiiwUvXRg40KJ0Oss/iY7GWI
         3jeZySjEoR8MJhrLzef8t12y/27F8+16Rq79pVIHXuh6BKiEojvS8vZcxhbNZGMxajcT
         gnuFSWaGbp7IVLMSBLC+/xODeED/MXRl40AFZ4/hk2mB2PW6BcFlgWpQK7dg8ovpSPcI
         YEUS4fFdVIVcr/Yt7ZxWSopimGg0xXNbpILbblIDV0vVQph1mwg6pb3Aa8KmFurToVir
         qmqHhZ/i1YNmi7Q5KWRoonJmupqjR7aDZqjI31XZcziMTWp4V2Bm3NBayuHyODfkHV4m
         /gtg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ru6Ef1JN+c7PAygOepEcnpnpiI1+G9+gPHPqK2efuvDd0bcIfxCMxUbJBo3hGg87A1VUKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ6Z9Kx8fygEctCcwwcRFGsXIJcJp/b7T+tiDLu6ycss/HA8ht
	9UO7rQfyU0cwshHK4mUPMtVl+mv1C5B5SE/Qen6pvy6KzWRjaaIL
X-Google-Smtp-Source: AGHT+IFqsXw5JhcsGFJE6xUk1B3NgiBxoHWYgm7ulIwzopxLQtwKLx+I+Ih2tZiTQwMf2s5u9RIhxA==
X-Received: by 2002:a05:6a20:d521:b0:1cf:4572:867 with SMTP id adf61e73a8af0-1cf62d5734bmr2527010637.33.1726025651066;
        Tue, 10 Sep 2024 20:34:11 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:7cb4:335c:8e84:436f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8255dc167sm5467891a12.71.2024.09.10.20.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 20:34:10 -0700 (PDT)
Date: Tue, 10 Sep 2024 20:34:09 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [Patch net] mptcp: initialize sock lock with its own lockdep keys
Message-ID: <ZuEPsZ3yrLqHNRUt@pop-os.localdomain>
References: <20240908180620.822579-1-xiyou.wangcong@gmail.com>
 <c332e3f8-3758-43ce-87a7-f1290d9692bc@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c332e3f8-3758-43ce-87a7-f1290d9692bc@kernel.org>

On Mon, Sep 09, 2024 at 05:03:32PM +0200, Matthieu Baerts wrote:
> Hi Cong Wang,
> 
> On 08/09/2024 20:06, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
> > lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
> > at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.
> > 
> > As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
> > sk_clone_lock() immediately locks the new sock after preliminary
> > initialization. To fix that, introduce ->init_clone() for struct proto
> > and call it right after the sock_lock_init(), so now mptcp sock could
> > initialize the sock lock again with its own lockdep keys.
> 
> Thank you for this patch!
> 
> The fix looks good to me, but I need to double-check if we can avoid
> modifying the proto structure. Here is a first review.
> 
> 
> From what I understand, it looks like syzbot reported a lockdep false
> positive issue, right? In this case, can you clearly mention that in the
> commit message, to avoid misinterpretations?
> 
> > Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
> 
> checkpatch.pl reports that "Reported-by: should be immediately followed
> by Closes: with a URL to the report".

Sure, didn't know this is helpful.

> 
> Also, even if it is a false positive, it sounds better to consider this
> as a fix, to avoid having new bug reports about that. In this case, can
> you please add a "Fixes: <commit>" tag and a "Cc: stable" tag here please?

I intended not to provide one because I don't think this needs to go to
-stable, it only fixes a lockdep warning instead of a real deadlock.
Please let me know if you prefer to target -stable.

> 
> > Cc: Matthieu Baerts <matttbe@kernel.org>
> > Cc: Mat Martineau <martineau@kernel.org>
> > Cc: Geliang Tang <geliang@kernel.org>
> 
> (If a new version is needed here, feel free to remove the Netdev ML from
> the CC list, and only add the MPTCP ML: we can apply this patch on MPTCP
> side first, and send it to Netdev later, when it will be ready and
> validated)

OK.

> 
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > ---
> >  include/net/sock.h     |  1 +
> >  net/core/sock.c        |  2 ++
> >  net/mptcp/pm_netlink.c | 18 ++++++++++++------
> >  net/mptcp/protocol.c   |  7 +++++++
> >  net/mptcp/protocol.h   |  1 +
> >  5 files changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index cce23ac4d514..7032009c0a94 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1226,6 +1226,7 @@ struct proto {
> >  	int			(*ioctl)(struct sock *sk, int cmd,
> >  					 int *karg);
> >  	int			(*init)(struct sock *sk);
> > +	void			(*init_clone)(struct sock *sk);
> >  	void			(*destroy)(struct sock *sk);
> >  	void			(*shutdown)(struct sock *sk, int how);
> >  	int			(*setsockopt)(struct sock *sk, int level,
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 9abc4fe25953..747d7e479d69 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
> >  	}
> >  	sk_node_init(&newsk->sk_node);
> >  	sock_lock_init(newsk);
> > +	if (prot->init_clone)
> > +		prot->init_clone(newsk);
> 
> If the idea is to introduce a new ->init_clone(), should it not be
> called ->lock_init() (or ->init_lock()) and replace the call to
> sock_lock_init() when defined?

'lock_init' or 'init_lock' reads like we are initalizing a lock. :)

> 
> >  	bh_lock_sock(newsk);
> >  	newsk->sk_backlog.head	= newsk->sk_backlog.tail = NULL;
> >  	newsk->sk_backlog.len = 0;
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index f891bc714668..5f9f06180c67 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -1052,10 +1052,20 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> >  static struct lock_class_key mptcp_slock_keys[2];
> >  static struct lock_class_key mptcp_keys[2];
> >  
> > +void mptcp_sock_lock_init(struct sock *sk)
> 
> If this helper is used by different parts in MPTCP, I think it would be
> better to move it (and the associated keys) to protocol.c: such helper
> is not specific to the Netlink path-manager, more to MPTCP in general.

Sure, if you don't mind more lines of changes.

> 
> > +{
> > +	bool is_ipv6 = sk->sk_family == AF_INET6;
> > +
> > +	sock_lock_init_class_and_name(sk,
> > +				is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> > +				&mptcp_slock_keys[is_ipv6],
> > +				is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> > +				&mptcp_keys[is_ipv6]);
> 
> The alignment is not OK, and checkpatch.pl is complaining about that.
> Can you keep the same indentation as it was before please?

Sure, sorry for missing this.

> 
> > +}
> > +
> >  static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> >  					    struct mptcp_pm_addr_entry *entry)
> >  {
> > -	bool is_ipv6 = sk->sk_family == AF_INET6;
> >  	int addrlen = sizeof(struct sockaddr_in);
> >  	struct sockaddr_storage addr;
> >  	struct sock *newsk, *ssk;
> > @@ -1077,11 +1087,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> >  	 * modifiers in several places, re-init the lock class for the msk
> >  	 * socket to an mptcp specific one.
> >  	 */
> 
> Please also move this comment above to the new mptcp_sock_lock_init()
> function.

OK.

> 
> > -	sock_lock_init_class_and_name(newsk,
> > -				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> > -				      &mptcp_slock_keys[is_ipv6],
> > -				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> > -				      &mptcp_keys[is_ipv6]);
> > +	mptcp_sock_lock_init(newsk);
> >  
> >  	lock_sock(newsk);
> >  	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 37ebcb7640eb..ce68ff4475d0 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2839,6 +2839,7 @@ static int mptcp_init_sock(struct sock *sk)
> >  	int ret;
> >  
> >  	__mptcp_init_sock(sk);
> > +	mptcp_sock_lock_init(sk);
> >  
> >  	if (!mptcp_is_enabled(net))
> >  		return -ENOPROTOOPT;
> > @@ -2865,6 +2866,11 @@ static int mptcp_init_sock(struct sock *sk)
> >  	return 0;
> >  }
> >  
> > +static void mptcp_init_clone(struct sock *sk)
> > +{
> > +	mptcp_sock_lock_init(sk);
> > +}
> > +
> >  static void __mptcp_clear_xmit(struct sock *sk)
> >  {
> >  	struct mptcp_sock *msk = mptcp_sk(sk);
> > @@ -3801,6 +3807,7 @@ static struct proto mptcp_prot = {
> >  	.name		= "MPTCP",
> >  	.owner		= THIS_MODULE,
> >  	.init		= mptcp_init_sock,
> > +	.init_clone	= mptcp_init_clone,
> 
> If 'mptcp_sock_lock_init()' is moved in this file, and 'init_clone' is
> renamed to 'lock_init', maybe directly use 'mptcp_sock_lock_init' here?

Sounds better.

> 
> >  	.connect	= mptcp_connect,
> >  	.disconnect	= mptcp_disconnect,
> >  	.close		= mptcp_close,
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 3b22313d1b86..457c01eac25f 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -1135,6 +1135,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
> >  
> >  void __init mptcp_pm_nl_init(void);
> >  void mptcp_pm_nl_work(struct mptcp_sock *msk);
> > +void mptcp_sock_lock_init(struct sock *sk);
> 
> (if the definition is moved to protocol.c, please also move it elsewhere
> here, e.g. around mptcp_sk_clone_init())

Got it.

Thanks.
