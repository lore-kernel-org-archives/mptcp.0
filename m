Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237535DA49
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 05:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674140; cv=pass; b=D39mD57V6pms/k3Ul5E5D7E8bc3vR4mqaF2pPUfPXr/w+3fVDm7iUsncwROeYhoQfMWO8x/+hk2Un9rr4At6AOrNDsEBQfU7HTkCoMHWC1uVKd/UzdbuAj4j0mw5a+NiRPpn+LXvvzQFAqBX3yzRPmW7x0SnTva5MLMQnzIc74U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674140; c=relaxed/simple;
	bh=0yepSpmw7xhTUgoAfd3AsL8m7KxpJ1mXDzAwcGiHcZ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fXy/0NoX/YhVvovw6WlLc+qTo1oxoifT9J9mOdFKLoRkF9gyYS5z7jR85NzVRYA1Feeawpwe0tfbqEtt7L6X7S2JVl+eleALe3kyNVwcCU3otIN8W7qLh6wh1Fn181U8refKhIbGR0jw7sxNG5as9Dqp6/j1g5X1F2ll8xRKEu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=kLLmf3RU reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="kLLmf3RU"
ARC-Seal: i=1; a=rsa-sha256; t=1781674134; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h0KBrVnv9BUpS91wHUeshZa2R1rxWTPbztz/caCa2gg0vZI4/oSfjPVNfW1NrdH/ZwmlozqH3coR27PKvgkCMp7U+oNpgoBAsk0IVrnDEjRhoukQnijnFz+84lWWn4BrdaCHwWSLzQFbwveQYN68Kb1hAEPc2QSV7ymxkdIgWSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781674134; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rXSnXH8WRsbFulXjkwMH1kSSo4KwLSOmnSHRwKPbqGs=; 
	b=GEeqfZZwhcDN0PzeFbzzwSVoDTvhKcXFWURZvrWMXLzDAj2CX2AXT/XNkShpQcIwQhGpISTYjAwdliH+IC3BcCHDmQuxJFvxe2IGzTlDo59dZrzM65yi201eE0RUM7JgxvSz1ETap3uZwiem/xe5kdrmMcvu/Gi9in/ly9IVm0o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781674134;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rXSnXH8WRsbFulXjkwMH1kSSo4KwLSOmnSHRwKPbqGs=;
	b=kLLmf3RUTnH93lA4BZJ9zcejBhRV079tnI6324wq5GaUrgTxwAPpOA2DvIMOl+q5
	xO3maqaL4FPYc60RCqKGLAIfkASjsWayt8Grg0PNtTDm4fXH6IXCdgrJW0zxbteyn3z
	kuGKeNF3XX82wmFf7yNkSCfWjoiKtTLOwx79kOZE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1781674132684988.07072176918; Tue, 16 Jun 2026 22:28:52 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:58:52 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "mptcp" <mptcp@lists.linux.dev>
Cc: "matthieu.baerts" <matthieu.baerts@tessares.net>,
	"Kalpan Jani" <kalpan.jani@mpiricsoftware.com>,
	"syzbot+fb2c3fa2ba28aec94627"
 <syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com>
Message-ID: <19ed40dc4bb.2d437dcd1096555.9183844211674571079@mpiricsoftware.com>
In-Reply-To: <20260616124801.2282199-1-kalpan.jani@mpiricsoftware.com>
References: <20260616124801.2282199-1-kalpan.jani@mpiricsoftware.com>
Subject: Re:[PATCH mptcp-next] mptcp: fix lockdep splat by using GFP_ATOMIC
 in sk_net_refcnt_upgrade
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Please ignore the previous patch. I sent the wrong version (GFP_ATOMIC workaround).

This is a workaround solution, not the proper fix. I'm sending a proper fix that moves sk_net_refcnt_upgrade() outside the socket lock, which is the correct architectural approach.

Please wait for the next patch (Version 1: move code outside lock).

Thanks,
Kalpan Jani


From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: <mptcp@lists.linux.dev>
Cc: <matthieu.baerts@tessares.net>, "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, <syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com>
Date: Tue, 16 Jun 2026 18:18:01 +0530
Subject: [PATCH mptcp-next] mptcp: fix lockdep splat by using GFP_ATOMIC in sk_net_refcnt_upgrade

 > The function sk_net_refcnt_upgrade() is called while holding a socket lock
 > in mptcp_subflow_create_socket(). This function performs an allocation via
 > ref_tracker_alloc(gfp), which was using GFP_KERNEL.
 > 
 > GFP_KERNEL can trigger page reclaim, which creates a lockdep edge with
 > fs_reclaim, leading to a circular dependency when combined with other
 > lock chains from the block layer (nbd driver).
 > 
 > Change the allocation to use GFP_ATOMIC instead. This is safe because:
 > - The ref_tracker struct is small (~200 bytes)
 > - GFP_ATOMIC allocation failure is extremely unlikely
 > - GFP_ATOMIC is commonly used in other locked contexts
 > 
 > Tested with mptcp/mptcp-upstream-virtme-docker CI: all 24 tests pass.
 > 
 > Circular dependency chain detected:
 >   fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET/1
 > 
 > Fixes: 0cafd77dcd03 ("net: add a refcount tracker for kernel sockets")
 > Reported-by: syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com
 > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/599
 > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > ---
 >  net/core/sock.c | 2 +-
 >  1 file changed, 1 insertion(+), 1 deletion(-)
 > 
 > diff --git a/net/core/sock.c b/net/core/sock.c
 > index 8a59bfaa8096..8458c304dabc 100644
 > --- a/net/core/sock.c
 > +++ b/net/core/sock.c
 > @@ -2399,7 +2399,7 @@ void sk_net_refcnt_upgrade(struct sock *sk)
 >      __netns_tracker_free(net, &sk->ns_tracker, false);
 >      net_passive_dec(net);
 >      sk->sk_net_refcnt = 1;
 > -    get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
 > +    get_net_track(net, &sk->ns_tracker, GFP_ATOMIC);
 >      sock_inuse_add(net, 1);
 >  }
 >  EXPORT_SYMBOL_GPL(sk_net_refcnt_upgrade);
 > -- 
 > 2.43.0
 > 
 > 

